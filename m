Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0574463BA27
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiK2HEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiK2HED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:04:03 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA700391EE;
        Mon, 28 Nov 2022 23:04:01 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso518144pjb.1;
        Mon, 28 Nov 2022 23:04:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDBBVGb3vVgUNo8t/6IIvRT92H3GgjNyrjnKQ0u5Jiw=;
        b=35u+fOJrw4/yI0hrmDlB9ogSl2FDErWDaDyQ/zsE74+uF8moKrcRC3wlvu5y6Ak5YS
         ok/KILUF7WCfZLbUEdvW+70Ec5c9WNDxLMPEEzn3mZJkPEopEJvA67BFxOS0psxfEeEu
         B3fAOiZZwPOqUjc5F95w8CmHfpcA8ZV0iAQbmctJqttiHlaSYxJrtipmJqAWOrKh3Xr/
         PW8wxQvl0SQGksY5NV71S0AvZmUvg7eLSttPnbFxLXMgcLBMu38TJJIDFqh8y6HogP6i
         zVP5hKQKGB/s63fYnRQGD8US6R21UrkMkDDA9g6ZzR6xxu42XCNa/yJbHqIzxhI2jUO6
         xnMw==
X-Gm-Message-State: ANoB5pkSZYpLjt591Y7lTDUcpiwPMnRf2UTr0idegzSNQlP9CMtVBe0f
        0MrA4KVzVovRZH0ED6ybq7oRjYDYnME+Ppjkk1k=
X-Google-Smtp-Source: AA0mqf6l+enkVVGQLai+KWiZd79TKE9e5GTzpEIPM0wnvPOa9DgHHhjHnDSd7hXaF28h9XrWCvFuXgAw1rjCeASJuBw=
X-Received: by 2002:a17:90a:a60c:b0:213:2e97:5ea4 with SMTP id
 c12-20020a17090aa60c00b002132e975ea4mr64367458pjq.92.1669705441138; Mon, 28
 Nov 2022 23:04:01 -0800 (PST)
MIME-Version: 1.0
References: <1669704232-40228-1-git-send-email-wangyufen@huawei.com>
In-Reply-To: <1669704232-40228-1-git-send-email-wangyufen@huawei.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 29 Nov 2022 16:03:50 +0900
Message-ID: <CAMZ6Rq+rTiAu3+SZ1GrE1+NoRnuoJ=g_6LA7GKZBOreQZVC3jQ@mail.gmail.com>
Subject: Re: [PATCH v3] USB: FHCI: fix error return code in of_fhci_probe()
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue. 29 Nov. 2022 at 15:43, Wang Yufen <wangyufen@huawei.com> wrote:
> Fix to return a negative error code of PTR_ERR(fhci->gpiods[i])
> instead of 0.
>
> Fixes: a4efdb8a423b ("USB: FHCI: Switch to GPIO descriptors")
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> ---
>  drivers/usb/host/fhci-hcd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
> index 95a4446..c8a1b98 100644
> --- a/drivers/usb/host/fhci-hcd.c
> +++ b/drivers/usb/host/fhci-hcd.c
> @@ -639,8 +639,9 @@ static int of_fhci_probe(struct platform_device *ofdev)
>                                         NULL, i, GPIOD_OUT_LOW);
>
>                 if (IS_ERR(fhci->gpiods[i])) {
> -                       dev_err(dev, "incorrect GPIO%d: %ld\n",
> -                               i, PTR_ERR(fhci->gpiods[i]));
> +                       ret = PTR_ERR(fhci->gpiods[i]);
> +                       dev_err(dev, "incorrect GPIO%d: %d\n",
> +                               i, ret);

Nitpick: you do not need a new line. It fits the 80 characters limit very well.

Aside of that:
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

>                         goto err_gpios;
>                 }
>                 if (!fhci->gpiods[i]) {
> --
> 1.8.3.1
>
