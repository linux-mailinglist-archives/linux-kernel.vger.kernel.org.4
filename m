Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AB463B8FE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 05:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbiK2ELd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Nov 2022 23:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiK2EL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 23:11:29 -0500
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420F343AE7;
        Mon, 28 Nov 2022 20:11:27 -0800 (PST)
Received: by mail-pj1-f43.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so10991942pjo.3;
        Mon, 28 Nov 2022 20:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3S7Szlfu+6YZU/8Q6fl28W8yYnxCPpIVD7qVbNLywrk=;
        b=sGbG9w18LadExjTa+4m1L/5rpkeNTw0tF0bwOU2FJP8tuqQR3hUaHrqr9dvgGgrE24
         XcFoY/cWohqe7VA5+9p8uCaTVI34ekzg92/kFLeXbtEMYCmquXluCkJKonryHutPQGSd
         UtbYTVlgAaA2n4EY08X3BWbRQPCqMvaif4CYDLbRl4AWC7ew1W4lBZ54Xj9WnML4lgTH
         nHVAGi7wOYR0MOEKq4S6p38QDOIBC625J40kvJ6CpSz2EYEy4le5Mh2Rd2b81es4p3z/
         07AEktTKgFl6A48wNNMYpuS9vhPtUk6bLcfSI3sWxmiGXWdOmiazt2pwHnds2kY2BrpC
         cgQg==
X-Gm-Message-State: ANoB5plL5rVY6ZLSsMkrxOMzUW4K9aOej58ZlrSiGSMgvmb/2g2CEe4a
        vYAMlIv9s9FBHYNT8Mi+3uUalEwYCT/4IllaEWI=
X-Google-Smtp-Source: AA0mqf5z0GfamfOPGZuLgQZWqiA6v4MD9gsgw/bLGMb9Hjhf2eLefkmQjJXXrx9t7mVzfXDFl1fagrq1zZGoNcwTTiA=
X-Received: by 2002:a17:902:b608:b0:189:7a8b:537d with SMTP id
 b8-20020a170902b60800b001897a8b537dmr13414989pls.95.1669695086694; Mon, 28
 Nov 2022 20:11:26 -0800 (PST)
MIME-Version: 1.0
References: <1669692810-26744-1-git-send-email-wangyufen@huawei.com>
In-Reply-To: <1669692810-26744-1-git-send-email-wangyufen@huawei.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 29 Nov 2022 13:11:15 +0900
Message-ID: <CAMZ6Rq+Y=7Cr8n68UMQ9FyfcZdNnHwaW5dabVf4CnaMadW90DQ@mail.gmail.com>
Subject: Re: [PATCH] USB: FHCI: fix error return code in of_fhci_probe()
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue. 29 nov. 2022 à 12:33, Wang Yufen <wangyufen@huawei.com> wrote:
> Fix to return a negative error code of PTR_ERR(fhci->gpiods[i])
> instead of 0.
>
> Fixes: a4efdb8a423b ("USB: FHCI: Switch to GPIO descriptors")
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> ---
>  drivers/usb/host/fhci-hcd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
> index 95a4446..afef72a 100644
> --- a/drivers/usb/host/fhci-hcd.c
> +++ b/drivers/usb/host/fhci-hcd.c
> @@ -639,6 +639,7 @@ static int of_fhci_probe(struct platform_device *ofdev)
>                                         NULL, i, GPIOD_OUT_LOW);
>
>                 if (IS_ERR(fhci->gpiods[i])) {
> +                       ret = PTR_ERR(fhci->gpiods[i])
>                         dev_err(dev, "incorrect GPIO%d: %ld\n",
>                                 i, PTR_ERR(fhci->gpiods[i]));

Can you add some extra clean-up and reuse ret in the dev_err()?

                         dev_err(dev, "incorrect GPIO%d: %ld\n", i, ret);

Alternatively you can also consider %pe to print the mnemotechnic
instead of the value:

                         dev_err(dev, "incorrect GPIO%d: %pe\n",
                                 i, fhci->gpiods[i]);


Yours sincerely,
Vincent Mailhol
