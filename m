Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546155E6B56
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiIVS5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiIVS5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:57:46 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2844E7C27
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:57:42 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id g2so6892117qkk.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=h9c+xPWJyC5OnFGo12v4TpTLnof1p8+esOXYmciFsQA=;
        b=axhceb0omg3rX8tkuuP0AQ9Uwq2axBINJntz4zOv/BEVfSxg/ddN5kY3Gx/C6vrdw3
         N8hqgRa5R76RpCqg4mTHnN1dbWkPdjFId8w5nvxn7A758diY5owUDU4phu9NrtF3TRjT
         AgIvXm92Oiy4/Fv7p63YBmwatogCuf/3r0pDbYlAiDeNGHkjx2XnylVlLFmbm8jiq93t
         pxusF/6VqWeyojGb6Qk9yeub6PRZsXQCBF3bcJAWHvEG9OeH3noFYuWi5tp+0MGcV7ua
         SAmWYz21zlNRLFScWZssJ1x6kr7EW2DUHxCjTYisq41CBg3nS44wrqYhQJhVGi09hKPg
         P20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=h9c+xPWJyC5OnFGo12v4TpTLnof1p8+esOXYmciFsQA=;
        b=jiXLMH8Or1Ya6RnNmJNpm3y4SLBCztFN9zggvxCOQMj3Vx2NlOEZCmAkwTeC9FYVSr
         kewUfmp+fYux9fHPNqKPNnOmyfJJOrTxYnqh3rS4kYzagZCjC4J08jaMx2vIvvwszSmH
         ySTIDAkJmwx+c3c7ohMBOtnMbb3a/Q8h7q3DbPJDaXM5mHlhwK1vEude4tLb34Ir0OdL
         vqnJWcILoyvAtBcESFamiYnzVpbnY/h+VOLadjORsDb9/QRnwypyTZSukziFh1jFjSZU
         jucYdsrM5aareITBsCz06FFZtg1mBB9Qs0mCT0HWJ0Zny/SMOo2xztyYQCbWJjA4FxmP
         ceiw==
X-Gm-Message-State: ACrzQf3AVJrSXefi/wy+HZA8SF4GD3CdvGI1bDHR5o2wH7lcDkYqkqkV
        qZqdQ5fsXk5sc+uXjxpwaAvnWeYn1dFH
X-Google-Smtp-Source: AMsMyM7lRX/UtjmtPjX7vd4fBl38n/2HwjotYxOaQHYiv6AR68EPDuLkUGmGjF8Iz8qfIhSJckxh4Q==
X-Received: by 2002:a05:620a:1d02:b0:6ce:5820:2fdc with SMTP id dl2-20020a05620a1d0200b006ce58202fdcmr3246580qkb.638.1663873061853;
        Thu, 22 Sep 2022 11:57:41 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id g17-20020ac87751000000b003434e47515csm3889217qtu.7.2022.09.22.11.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 11:57:41 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:5d3f:d09:85d2:d6e])
        by serve.minyard.net (Postfix) with ESMTPSA id AEF841800BD;
        Thu, 22 Sep 2022 18:57:40 +0000 (UTC)
Date:   Thu, 22 Sep 2022 13:57:39 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     joel@jms.id.au, andrew@aj.id.au,
        openipmi-developer@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH] ipmi: kcs: aspeed: Update port address comments
Message-ID: <YyywI8265vECnEHv@minyard.net>
Reply-To: minyard@acm.org
References: <20220920020333.601-1-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920020333.601-1-chiawei_wang@aspeedtech.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 10:03:33AM +0800, Chia-Wei Wang wrote:
> Remove AST_usrGuide_KCS.pdf as it is no longer maintained.

Even if it's no longer maintained, is it useful?  It seems better to
leave in useful documentation unless it has been replaced with something
else.

-corey

> 
> Add more descriptions as the driver now supports the I/O
> address configurations for both the KCS Data and Cmd/Status
> interface registers.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  drivers/char/ipmi/kcs_bmc_aspeed.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
> index cdc88cde1e9a..19c32bf50e0e 100644
> --- a/drivers/char/ipmi/kcs_bmc_aspeed.c
> +++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
> @@ -207,17 +207,24 @@ static void aspeed_kcs_updateb(struct kcs_bmc_device *kcs_bmc, u32 reg, u8 mask,
>  }
>  
>  /*
> - * AST_usrGuide_KCS.pdf
> - * 2. Background:
> - *   we note D for Data, and C for Cmd/Status, default rules are
> - *     A. KCS1 / KCS2 ( D / C:X / X+4 )
> - *        D / C : CA0h / CA4h
> - *        D / C : CA8h / CACh
> - *     B. KCS3 ( D / C:XX2h / XX3h )
> - *        D / C : CA2h / CA3h
> - *        D / C : CB2h / CB3h
> - *     C. KCS4
> - *        D / C : CA4h / CA5h
> + * We note D for Data, and C for Cmd/Status, default rules are
> + *
> + * 1. Only the D address is given:
> + *   A. KCS1/KCS2 (D/C: X/X+4)
> + *      D/C: CA0h/CA4h
> + *      D/C: CA8h/CACh
> + *   B. KCS3 (D/C: XX2/XX3h)
> + *      D/C: CA2h/CA3h
> + *   C. KCS4 (D/C: X/X+1)
> + *      D/C: CA4h/CA5h
> + *
> + * 2. Both the D/C addresses are given:
> + *   A. KCS1/KCS2/KCS4 (D/C: X/Y)
> + *      D/C: CA0h/CA1h
> + *      D/C: CA8h/CA9h
> + *      D/C: CA4h/CA5h
> + *   B. KCS3 (D/C: XX2/XX3h)
> + *      D/C: CA2h/CA3h
>   */
>  static int aspeed_kcs_set_address(struct kcs_bmc_device *kcs_bmc, u32 addrs[2], int nr_addrs)
>  {
> -- 
> 2.25.1
> 
