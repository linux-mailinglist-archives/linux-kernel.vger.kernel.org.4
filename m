Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CA37290E3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjFIHZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjFIHZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:25:38 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDE11725
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:25:37 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so2172322276.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 00:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686295536; x=1688887536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyFsZ1UjDfl+6Xm895L91HDQsfrFb/TNPC96tZmCYRY=;
        b=CX1UKIRyTXnjFO61leuUT0Z4M/6qUCPOZ+VPatcqAHojS+QasSSEEtevTBKekpzr9X
         8PJeQydugevHD6Z3do5so5iAt27bHeiLIQhrPfHBeV5frLZhDtY7wfdBGD0y6D9lKN4D
         OOnM8aWmrxmRsriAApDMQqOfeCYle1uHNRPKwUdECISqKv2Y3OCXLZveMRQqC8pCkiCb
         H6bRT4fI84fwo3HArBC57usY1JXAchaaTVR5/J6LPTsvkaA06eOpZ4+UTFCa7Py6h6+T
         zYWpaD2dtCEJQNoheKZQj2JofLzhMdJq7xUV4ktBFUF4A3P5vjNRnjfbWn8J7Lr9dxuz
         cttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686295536; x=1688887536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyFsZ1UjDfl+6Xm895L91HDQsfrFb/TNPC96tZmCYRY=;
        b=hORc3Zzy+f73tuOi+CiCbSCimijB79oQBRAZeXcW5L7VBiNNSf0690fX/RGFfHFMYm
         tXTIBCittHRl5J87zwOim7jkoUu83mj4yPABpNSOJkMyH1i4hfOOpDMta5QHpIfaowJl
         X3dcnc6bSxLEW25GEg+VlmtiPwbkfjlR1bs3Ds0eS03yN4NFN9cHixEMydHI904U1Hsf
         zljK2OTzJtiU5/PPAye6jXSPKdispq2gRzLjr0AC4wXqra4domsHLIzsb1BBmQIdIZ89
         y9QpKwrGIHNYR3SCx9eeXeK/jSosD3WE7ZvxVk4xmOV7nfbkfb45+DrMGKIaHXr7tT2k
         QStg==
X-Gm-Message-State: AC+VfDxOpDux1zR34svkV/cWigEO+O4pYY1AWwFmhMqav9XFzTWmpZQR
        e55Qa35cnjDOphKdYb/ZNyzPH5suzgBgr5TwYXr6nw==
X-Google-Smtp-Source: ACHHUZ7V1GUtrr0cM5cflChK55207A8+S6WRZrQ4JxkAWAsysWCi9ySFtXEBM2LMnXgfBMVLK1Dyvnb4NXOwuA/DamQ=
X-Received: by 2002:a25:54f:0:b0:bac:46f2:8d0f with SMTP id
 76-20020a25054f000000b00bac46f28d0fmr2765832ybf.3.1686295536319; Fri, 09 Jun
 2023 00:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230606070201.14249-1-luhongfei@vivo.com>
In-Reply-To: <20230606070201.14249-1-luhongfei@vivo.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Jun 2023 09:25:25 +0200
Message-ID: <CACRpkdaTc9sN5n1WVKqevvLCLoO6Hpz7Vgwh5HXebxObMmmKbg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nxp: Fix resource leaks in for_each_child_of_node()
 loops
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     Chester Lin <clin@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
        "open list:PIN CONTROLLER - NXP S32" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 9:02=E2=80=AFAM Lu Hongfei <luhongfei@vivo.com> wrot=
e:

> Ensure child node references are decremented properly in the error path.
>
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>

Patch applied.

Yours,
Linus Walleij
