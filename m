Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C86628AED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiKNVAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbiKNVAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:00:14 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07698C13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:00:10 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x2so19139366edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40S/F5BELCFB3y9d/ai9+Kw1YT1iYA4dyds8YjgYhaY=;
        b=Xw5Wf5b7B/XodNUpFS/B6Ov4czpPP8CjSWwIVohdOnh3SKVillyHvAllg5+8ECplGF
         n9lo0tIQqE6XEVUignZBgYlhd6MluozJKU64iwAsu1y0OmB+TE1uck7m/XujJPgQDC/6
         B6uZdE55WIUqCXlRbCJCG7To74VkzcDaYN8B73XyYaeoQps8qMdaInj/+bFm61XUubav
         fi+p3m0NWbVKskCSuw+s8StvrNSh40vQ3F6P1b9o2FCALPAoNmCEFSwZomqjTTa8y8HE
         Dy9zoCioYuk/gJRhFJOoRkmQGxYurCA0e2M2zetIV0lLsoXjqjs1/VNWm4/Tm0z5oAo9
         Ziww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40S/F5BELCFB3y9d/ai9+Kw1YT1iYA4dyds8YjgYhaY=;
        b=2Ldk3xipYxOL7YR/geWaYVl6MMKJhit8fbILoon0TF8m3LciaNigb83ummhTRHEfwq
         mdXQwk2DhEYSJsZJ7NMhOV5eEp70atEbLTPkjHz4NNUwI+cbOkxhVud45cyADJxkR9te
         b57LrrdosXZ1crSdbnBtiNs5zpJcu7Xc5wAdZWX5vPbo1cCpM6NAoU5wT0Xhl7VasYfY
         +Eph7xycnLW/oDy3Z5FtlkUMoNG9v+UrDGD/Fn986t7H286lquLR0nWpKGa62EutOsaY
         jFKc060JJfzaTLpY0G73uq+NsopamFSzHFm3vpBqrFJy8BPeMde++C4zZIaDB1DjH9yE
         iCgw==
X-Gm-Message-State: ANoB5pnRL1MZPd0T+1WbJCwgA0twpHWZ58/O1csfpkwmAXc4WO3edEAy
        i2hJL8hfaS8WUEYaUMmWvhk=
X-Google-Smtp-Source: AA0mqf6G5js9yVA+Wu3EQp7CP6PyKNGeW/0xYFHxWYs1E7lEod9nMTctxOBnOzt/UHlB+0vW018ZPg==
X-Received: by 2002:a05:6402:1cc4:b0:462:df63:5ec5 with SMTP id ds4-20020a0564021cc400b00462df635ec5mr12618430edb.147.1668459608543;
        Mon, 14 Nov 2022 13:00:08 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id kw26-20020a170907771a00b00781d411a63csm4585087ejc.151.2022.11.14.13.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 13:00:08 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 3/3] bus: sunxi-rsb: Clear interrupt status before each transfer
Date:   Mon, 14 Nov 2022 22:00:06 +0100
Message-ID: <2170633.72vocr9iq0@jernej-laptop>
In-Reply-To: <20221114015749.28490-4-samuel@sholland.org>
References: <20221114015749.28490-1-samuel@sholland.org> <20221114015749.28490-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

Dne ponedeljek, 14. november 2022 ob 02:57:49 CET je Samuel Holland 
napisal(a):
> Currently, the driver clears the interrupt status bits after anything
> could have set them. However, this requires duplicating the same logic
> in several places.
> 
> Instead of clearing the status flags in the interrupt handler, disable
> all further interrupts by clearing the RSB_CTRL_GLOBAL_INT_ENB bit.

where is this bit cleared?

> Then we can delay the status register write until the start of the next
> transfer, so it only has to be done in one place.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v3:
>  - Add a patch refactoring how the status bits are cleared
> 
>  drivers/bus/sunxi-rsb.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> index 3aa91aed3bf7..cb622e60897b 100644
> --- a/drivers/bus/sunxi-rsb.c
> +++ b/drivers/bus/sunxi-rsb.c
> @@ -279,6 +279,7 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
> 
>  	int_mask = RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | 
RSB_INTS_TRANS_OVER;
>  	writel(int_mask, rsb->regs + RSB_INTE);
> +	writel(int_mask, rsb->regs + RSB_INTS);

Wouldn't be better to clear status before enabling interrupts? Unless global 
interrupt flag is cleared beforehand, but I don't see that anywhere.

Best regards,
Jernej

>  	writel(RSB_CTRL_START_TRANS | RSB_CTRL_GLOBAL_INT_ENB,
>  	       rsb->regs + RSB_CTRL);
> 
> @@ -286,7 +287,6 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
>  		timeout = readl_poll_timeout_atomic(rsb->regs + 
RSB_INTS,
>  						    status, 
(status & int_mask),
>  						    10, 
100000);
> -		writel(status, rsb->regs + RSB_INTS);
>  	} else {
>  		timeout = !wait_for_completion_io_timeout(&rsb-
>complete,
>  							  
msecs_to_jiffies(100));
> @@ -296,12 +296,9 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
>  	if (timeout) {
>  		dev_dbg(rsb->dev, "RSB timeout\n");
> 
> -		/* abort the transfer */
> +		/* abort the transfer and disable interrupts */
>  		writel(RSB_CTRL_ABORT_TRANS, rsb->regs + RSB_CTRL);
> 
> -		/* clear any interrupt flags */
> -		writel(readl(rsb->regs + RSB_INTS), rsb->regs + 
RSB_INTS);
> -
>  		return -ETIMEDOUT;
>  	}
> 
> @@ -503,15 +500,11 @@ EXPORT_SYMBOL_GPL(__devm_regmap_init_sunxi_rsb);
>  static irqreturn_t sunxi_rsb_irq(int irq, void *dev_id)
>  {
>  	struct sunxi_rsb *rsb = dev_id;
> -	u32 status;
> 
> -	status = readl(rsb->regs + RSB_INTS);
> -	rsb->status = status;
> +	/* disable interrupts */
> +	writel(0, rsb->regs + RSB_CTRL);
> 
> -	/* Clear interrupts */
> -	status &= (RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR |
> -		   RSB_INTS_TRANS_OVER);
> -	writel(status, rsb->regs + RSB_INTS);
> +	rsb->status = readl(rsb->regs + RSB_INTS);
> 
>  	complete(&rsb->complete);
> 
> @@ -532,9 +525,6 @@ static int sunxi_rsb_init_device_mode(struct sunxi_rsb
> *rsb) if (reg & RSB_DMCR_DEVICE_START)
>  		ret = -ETIMEDOUT;
> 
> -	/* clear interrupt status bits */
> -	writel(readl(rsb->regs + RSB_INTS), rsb->regs + RSB_INTS);
> -
>  	return ret;
>  }




