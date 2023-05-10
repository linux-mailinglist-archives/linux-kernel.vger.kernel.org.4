Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3906FE77F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 00:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbjEJWrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 18:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbjEJWrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 18:47:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E243598
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 15:47:01 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f22908a082so5783728e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 15:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683758819; x=1686350819;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lc9F8QaPJkxAnOe+Xl1C2QlUZazEe73HEcZR10o9E9A=;
        b=OUTeeS/IjRvUewaDFMBR2nz8cQVKPl25aHSFeXlJeYsY5sLhfm5KCpbDTVwyFAON4i
         p6VtfvVDwB3dHDu2QM07grzKk89qjcZ8HcVr3Yn6w+WspTT6KaAfRU33H4l2AN+FSkyT
         77GXjTUPUnZRizQz4h72jAQhbYda/SvDR/lD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683758819; x=1686350819;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lc9F8QaPJkxAnOe+Xl1C2QlUZazEe73HEcZR10o9E9A=;
        b=P1ToO2Jjgq7A2BRssLfu6+HUN67Omt6q69br/Yet9DK9f/0peIXGR6XeuAKU+JLpBd
         jKmEMkpqFM1WWKBhcZRaixWdahs8ewqnwIadCZAD0WrxmgMyIRVGFof01qRPzWyGkBaw
         /PcNLycxhwDTkr6ftyk6vVAW6gBtSxb1X2fee0P5tWokRyIZuFeDMs0r46jnQL7cLa7w
         t5azKNJ1k0w5Home7iSquiaSg6mPxm9a0TZbYw0En1g8I4eK20MjGb3kVY0JVQRCqMGt
         g7UTY7a9jwPc3OFE/uxVw7rqW/Huh9+BWVGBcOpQGlOf4pdktvKHy5SKAJb/proE6UyD
         L63Q==
X-Gm-Message-State: AC+VfDxgol2LUxO4ZpbuC4iAc5kJOuR4i3EoOjqWCrLzP/7Z12hZ4DHQ
        4UXzeikKNuvSzsqexNJuPWt98fUE35ZRA1YgfIR4Qg==
X-Google-Smtp-Source: ACHHUZ5POndhPxkoH7qR9oNGQ2z2nTWFZHH0gWw8KX3wXh6qJr+Gz7PeuHb1IydiRZeMJTRDh0ecvKmOW3536Z6hjDo=
X-Received: by 2002:ac2:4f8d:0:b0:4f1:2180:5683 with SMTP id
 z13-20020ac24f8d000000b004f121805683mr1967053lfs.41.1683758819344; Wed, 10
 May 2023 15:46:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 May 2023 15:46:58 -0700
MIME-Version: 1.0
In-Reply-To: <1683750665-8764-3-git-send-email-quic_khsieh@quicinc.com>
References: <1683750665-8764-1-git-send-email-quic_khsieh@quicinc.com> <1683750665-8764-3-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 10 May 2023 15:46:58 -0700
Message-ID: <CAE-0n532y=ARQ_+urEA_b3zUn+gKTu1fgK_siHNt3CpbLB9PZg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/msm/dp: add mutex to protect internal_hpd
 against race condition between different threads
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@gmail.com, andersson@kernel.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2023-05-10 13:31:05)
> Intrenal_hpd is referenced by event thread but set by drm bridge callback
> context. Add mutex to protect internal_hpd to avoid conflicts between
> threads.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

This patch looks completely unnecessary. How can dp_bridge_hpd_enable()
be called at the same time that dp_bridge_hpd_disable() is called or
dp_bridge_hpd_notify() is called? Isn't there locking or ordering at a
higher layer?
