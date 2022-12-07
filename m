Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7B96464BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiLGXEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiLGXEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:04:35 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600BF2DE8;
        Wed,  7 Dec 2022 15:04:34 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id t17so19109835pjo.3;
        Wed, 07 Dec 2022 15:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ff3cokBLft8feKASwtORz5rCPHq4zUkqXInCT5nyqYA=;
        b=fIDItAjMev2MvAAyeruSl2KVDnU+sdaUg9FJwgg0MVJrxWXLmnXqPn7nxezvrSPkHB
         /2Lo/fCc2k0ksRQiCsqfi3FF6ViLwShr+LG+/hqVwlsOqpHvVd13JhOHUwJYqXcKaJVI
         JWCJ8N2iJDba1qJC/xmJrW0jUUJOmk4X1n+LToJxsLKsEJBjd37+ldRm/jEPI5AKrPuP
         Fr0TzjTQXXrt9yNKC+uyVaUstL6i9zMqirJAIPRTJtJ1rCUd66YvEdWhKAlnJNIg/XcN
         gsM9cZTwo6TS6Bohsw4ca1vm7tuLLv6UBvJgFcEKynWi0HrZACPIF5tXrMJOeWMFBGf+
         eyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ff3cokBLft8feKASwtORz5rCPHq4zUkqXInCT5nyqYA=;
        b=4Lp0kGp4cgM4brVj8bI52FH3H1QcDfe5qeIZDIvdUi1eNkHpLcN5lZpBXd+O5t8FZT
         jGNA17M/Ct72mNKdRm85aprx55IjSYJK5uMIv9n3ptMy90FzUNDn0OBZzC2I53Y0uTcb
         qWibW4nsYUF4ilqwLfP8hPh9IdByiRkWvAV3PVibxW/90xNhC6jAKtt6ZTjOtcTN9ScH
         xVXuFc4pDOkwt8Ul6vNcd5YYQ23PycutPYUc9/eEbJfFsJqa5BlpV49X6txHcWxKgjlT
         hTHXifJf8F3I8Qc2jL6/9wPB+9NdjWeOSd8A2OcOIQcIt96leKPo4iJNOnWZLKYpcREF
         9dJw==
X-Gm-Message-State: ANoB5pmZXReitArZVWZm8HHjkn0mhbu0BaFNqzCRTUEI+p92cDGXRzi1
        RDvhD8gSqfr5evmkps/9An24qrCLE8Uh3vKhSf0=
X-Google-Smtp-Source: AA0mqf6i0d2kZ/4sKYtlTOp5psxMv1nZN9hqvpeh1U0tewmJ9pj106PPp9E2i4CJ5GXcIlbtEjca3btcsda8I4+Tyj0=
X-Received: by 2002:a17:902:a514:b0:189:97c3:6382 with SMTP id
 s20-20020a170902a51400b0018997c36382mr44756888plq.168.1670454273676; Wed, 07
 Dec 2022 15:04:33 -0800 (PST)
MIME-Version: 1.0
References: <20221128054820.1771-1-clin@suse.com> <20221128054820.1771-3-clin@suse.com>
In-Reply-To: <20221128054820.1771-3-clin@suse.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 7 Dec 2022 20:04:18 -0300
Message-ID: <CAOMZO5D0wJcfbFsvUN3K17S5F4zT2Yf8yQB+wMKQPzuMBitrpA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: add NXP S32 SoC family support
To:     Chester Lin <clin@suse.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Phu Luu An <phu.luuan@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chester,

On Mon, Nov 28, 2022 at 2:49 AM Chester Lin <clin@suse.com> wrote:

> +static struct platform_driver s32g_pinctrl_driver = {
> +       .driver = {
> +               .name = "s32g-siul2-pinctrl",
> +               .owner = THIS_MODULE,
> +               .of_match_table = s32_pinctrl_of_match,
> +               .pm = &s32g_pinctrl_pm_ops,
> +       },
> +       .probe = s32g_pinctrl_probe,
> +       .remove = s32_pinctrl_remove,

Do you really want to allow this pinctrl driver to be removed?

In other imx8m pinctrl drivers we pass:

.suppress_bind_attrs = true,

Check drivers/pinctrl/freescale/pinctrl-imx8mm.c for example.

> +module_platform_driver(s32g_pinctrl_driver);

And we also register it in arch_initcall() level.

Maybe you want to align these points with imx8m?
