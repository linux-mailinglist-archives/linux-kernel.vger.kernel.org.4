Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B1B7479A5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 23:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjGDViA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 17:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjGDVh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 17:37:58 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58468E4F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 14:37:57 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688506676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Txn4LgpzVMybHzVUCvnoV6NNG7J8zu9FLUCQ+DXavTc=;
        b=bjlJgNyh0acXl+ggsFf8yd/eg/e5mieSWOAOpji/v7dn8DVxKt6YjHsrZ4Kco5JozRZ35q
        mzTFJA01YrykqJz5TNTtic5rGCDzjtUU1emobx1puzcATYR4Zp9OgG8g6M2QYurvmVjJ8U
        Gb/rCjZohd4AdXyUbJF5o6Ztu9QXJPqkESJAMNCDiaF7CqiYy7wZmY9R+IkfOmRssw6ueM
        1pvr5xNbzNG3Mf4pg9ZjwibNaNTs2bIhdYzHdS/akPbcXR1hNNPTdECh5P49csqNnD+R+s
        31rtSYAIYcW3YFKfxUWO3xBtd42Cn96izrWxcGVsk0haGoaSybB1jPUnprTqfQ==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CCB721BF203;
        Tue,  4 Jul 2023 21:37:55 +0000 (UTC)
Date:   Tue, 4 Jul 2023 23:37:55 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 5/5] i3c: dw; add print if cannot get resources
Message-ID: <2023070421375530819b2c@mail.local>
References: <20230621162005.473049-1-ben.dooks@codethink.co.uk>
 <20230621162005.473049-6-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621162005.473049-6-ben.dooks@codethink.co.uk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please fix the typo in the subject.

On 21/06/2023 17:20:05+0100, Ben Dooks wrote:
> The devm_reset_control_get_optional_exclusive() call does
> not print any errors, neiterh does the clk_prepare_enable
Also fix this one.

> or devm_request_irq() call.
> 
> Add some basic error printing to make the probe failures
> easier to debug.

I guess all those dev_err could be dev_dbg so we don't litter the driver
with strings that will only ever be useful during bring up.

> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/i3c/master/dw-i3c-master.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 9332ae5f6419..ffc84ff6225c 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -1429,12 +1429,16 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>  
>  	master->core_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
>  								    "core_rst");
> -	if (IS_ERR(master->core_rst))
> +	if (IS_ERR(master->core_rst)) {
> +		dev_err(&pdev->dev, "cannot get core_rst\n");
>  		return PTR_ERR(master->core_rst);
> +	}
>  
>  	ret = clk_prepare_enable(master->core_clk);
> -	if (ret)
> +	if (ret) {
> +		dev_err(&pdev->dev, "cannot enable core_clk\n");
>  		goto err_disable_core_clk;
> +	}
>  
>  	reset_control_deassert(master->core_rst);
>  
> @@ -1446,8 +1450,10 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>  	ret = devm_request_irq(&pdev->dev, irq,
>  			       dw_i3c_master_irq_handler, 0,
>  			       dev_name(&pdev->dev), master);
> -	if (ret)
> +	if (ret) {
> +		dev_err(&pdev->dev, "cannot get irq\n");
>  		goto err_assert_rst;
> +	}
>  
>  	platform_set_drvdata(pdev, master);
>  
> -- 
> 2.40.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
