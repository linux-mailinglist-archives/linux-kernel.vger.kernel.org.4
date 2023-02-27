Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B863D6A4A66
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjB0S6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjB0S6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:58:36 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B61901C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 10:58:34 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bp25so9966752lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 10:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677524313;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRsKipwTaZMto6Q2Ot7ciKaa6dv/XDA9FjOe0TQ3/no=;
        b=CWY8U8jhOLvKLGkjkUZAnFg/LXI2S72CxNcC4mseTG3U+TTx9Q5iV8VDC/vHHgetCt
         7nf6bVU0rOsbFKGxFNWOcmhFydzbKSMmv5VOz/qhVWPLegkUtoqaYt/+Hm2zkMkI9STQ
         NWNwVcjlaS9Ad9Ievzi8T0kPu6r3rkdRpusjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677524313;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRsKipwTaZMto6Q2Ot7ciKaa6dv/XDA9FjOe0TQ3/no=;
        b=X/RXsbs4nJr8oi+0VCN/qmI2Q9nCtOjGc51QQj7yFQPhv72hOBewikg5oseFwuepGv
         yFlXjm2mqPwUW/hxx3kAJ/nB8crZdUskrGIReBtY1amKW+cGr0rbbAVVg3Tu3bjKo6WV
         KniSu5haTXOPk7Fus7VIg5ntLPuVEJVmUe9bK+dYcs7rSedOKbdeFg0Fe4usNcKm8rte
         ltwQCCKhqbgWON2H6w7zkj/QmK3Q0BZfTMT6403DZ9Gikv2qp4G0dVNLKdh659vVBBDD
         Axn6GXH6QFlsBFXPp7+hnmy4rkg8k8oKaHBmag31dx1s01v5idAh5XAvsk/VJnTm4Ueb
         IpBw==
X-Gm-Message-State: AO0yUKVzuo1CZw/GgzgUmhxMp739mSJxYAOJ6XDDgO9ouo14nekorRRR
        Y7zEFLUEXpxYIfWVSQ373oPFjLqAfcCQwPATxbYf4Q==
X-Google-Smtp-Source: AK7set8yKCM21HLcQlsUeT3bM88VXuBEcNpQS27/Aqoe0Fk8QBAzE2fMXsBi+t9fzPuZdWk9BMd16KTdWDB18VP6Ywo=
X-Received: by 2002:ac2:520e:0:b0:4db:1999:67a3 with SMTP id
 a14-20020ac2520e000000b004db199967a3mr7871179lfl.13.1677524313029; Mon, 27
 Feb 2023 10:58:33 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Feb 2023 13:58:32 -0500
MIME-Version: 1.0
In-Reply-To: <1677517471-5947-1-git-send-email-quic_khsieh@quicinc.com>
References: <1677517471-5947-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 27 Feb 2023 13:58:32 -0500
Message-ID: <CAE-0n51tvrbr1f2cRz4pCE-LMPjn09wXTAuiB9D_QeiF65pHVQ@mail.gmail.com>
Subject: Re: [PATCH v1] drm/msm/disp/dpu: fix sc7280_pp base address
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@gmail.com, andersson@kernel.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2023-02-27 09:04:31)
> Correct sc7280 pp block base address.

What goes wrong if this is left unchanged? How important is it to fix
this? Does the display fail to work? Does it fix something for a new
feature that isn't yet enabled upstream?

This information is useful to put in the commit text so we know the
severity of the problem that is being fixed and so that maintainers can
understand the importance of the patch.

>
> Fixes: 591e34a091d1 ("drm/msm/disp/dpu1: add support for display for SC7280 target")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
