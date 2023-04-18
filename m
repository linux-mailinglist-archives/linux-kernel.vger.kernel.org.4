Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A873B6E6969
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjDRQZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjDRQZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:25:22 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B467713C32;
        Tue, 18 Apr 2023 09:25:02 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-187b70ab997so4676330fac.0;
        Tue, 18 Apr 2023 09:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681835102; x=1684427102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNOE/dyF7FtqvkElewLW1/drwX7fUO4SPOgTWaAx+Y8=;
        b=hrUCAaj4/c0XTt3DxZBdktzdCCdGON/54O9yINi8cn8Dh+bSMtH++sCndJJCjAYAcG
         WEVPkRWkq2nsX9Ybf814hijQJnIIyj05sNowxqA9FpUDSM3GFoGNAd1gTHKmnlel/XL8
         IGVYDzfFM6qo1rJ60rvgDEN4gb3lQVPzCDrXGOhDWp3bOYIBQVo+Z0LJy25tDaMu6I9Y
         AvrC7rVOG+DvNJ9E/VqzjO19q1/tCDJq1ffQ4AaQwmrO/da0WwBIEQQlRwOkvYLM4r7X
         qGVh5r3dRngZDsg0vqWEK19Hjn2EXiul4httWA7ppH4tRUMwuVvsDsHgHYJhbO0p8YB4
         522Q==
X-Gm-Message-State: AAQBX9fc+RyIoBZ7aSCBui3cQ+L7JeGid8Xt7NZ0ULNc+p9xFPKZw18c
        5q/jQGh3H0a40bbw78zbt6mIX/JkYg==
X-Google-Smtp-Source: AKy350bzMR1g5hB4iuk845AUemZNXAqo9D5REaHir64PgiMFVxCquNqHbINnk1UXcAHs8bQz3X/zkg==
X-Received: by 2002:a9d:19e9:0:b0:6a4:1a07:deb7 with SMTP id k96-20020a9d19e9000000b006a41a07deb7mr1315388otk.19.1681835101866;
        Tue, 18 Apr 2023 09:25:01 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x25-20020a05683000d900b006a12509bd94sm2094741oto.13.2023.04.18.09.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:25:01 -0700 (PDT)
Received: (nullmailer pid 1807499 invoked by uid 1000);
        Tue, 18 Apr 2023 16:25:00 -0000
Date:   Tue, 18 Apr 2023 11:25:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: Use of_property_read_bool() for boolean
 properties
Message-ID: <20230418162500.GC1764573-robh@kernel.org>
References: <20230310144710.1543139-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144710.1543139-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 08:47:10AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/mailbox/hi6220-mailbox.c | 5 +----
>  drivers/mailbox/omap-mailbox.c   | 3 +--
>  2 files changed, 2 insertions(+), 6 deletions(-)

Ping!

> 
> diff --git a/drivers/mailbox/hi6220-mailbox.c b/drivers/mailbox/hi6220-mailbox.c
> index fca61f5312d9..1c73c63598f5 100644
> --- a/drivers/mailbox/hi6220-mailbox.c
> +++ b/drivers/mailbox/hi6220-mailbox.c
> @@ -325,10 +325,7 @@ static int hi6220_mbox_probe(struct platform_device *pdev)
>  	writel(~0x0, ACK_INT_CLR_REG(mbox->ipc));
>  
>  	/* use interrupt for tx's ack */
> -	if (of_find_property(node, "hi6220,mbox-tx-noirq", NULL))
> -		mbox->tx_irq_mode = false;
> -	else
> -		mbox->tx_irq_mode = true;
> +	mbox->tx_irq_mode = !of_property_read_bool(node, "hi6220,mbox-tx-noirq");
>  
>  	if (mbox->tx_irq_mode)
>  		mbox->controller.txdone_irq = true;
> diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
> index 098c82d87137..fd28ac2120df 100644
> --- a/drivers/mailbox/omap-mailbox.c
> +++ b/drivers/mailbox/omap-mailbox.c
> @@ -763,8 +763,7 @@ static int omap_mbox_probe(struct platform_device *pdev)
>  
>  		finfo->name = child->name;
>  
> -		if (of_find_property(child, "ti,mbox-send-noirq", NULL))
> -			finfo->send_no_irq = true;
> +		finfo->send_no_irq = of_property_read_bool(child, "ti,mbox-send-noirq");
>  
>  		if (finfo->tx_id >= num_fifos || finfo->rx_id >= num_fifos ||
>  		    finfo->tx_usr >= num_users || finfo->rx_usr >= num_users)
> -- 
> 2.39.2
> 
