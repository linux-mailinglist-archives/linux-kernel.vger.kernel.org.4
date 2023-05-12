Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0EF6FFFF7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 07:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239826AbjELFlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 01:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjELFlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 01:41:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A88422F
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 22:41:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3078d1c8828so6463309f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 22:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683870074; x=1686462074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GRLM54m4oNof2pLRboZuVsUjfYt5aZs+58w3qZaftDY=;
        b=kFDBkoGue96E/tX+H3qVJQxr7ukww/c4REfNOx2RBujhBTRXlOAWnKt7r5cgdmU1JB
         aLbCxazsL0mhKGxbhhvjS8IfqoH3LM/EowWfU8d7xMWLq0aoJEm7bB1cCjf9PNdn7ouS
         kSpIZd/d+Yltor7bIu1hKBwJ9yBiI2s8iaqDDV2gpJ/7aQxO8XfZsjmQbt6Yn0gvnxeC
         62syf98HY8bSC9t8PPyWPDuc1G+8QULNXUhMeESQNcVLjnhIrHnUwdl50P9usyctng/r
         zPG9OvzLbkPciHHy6ze9sycFdfYz1cEJ8gQlQPbthO0M99+wnRpxxtJx3hfrfgeaGGV3
         rS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683870074; x=1686462074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRLM54m4oNof2pLRboZuVsUjfYt5aZs+58w3qZaftDY=;
        b=SKegNPga+DY1IJYJucnw9zRxfd6wIVCe0DMUzxbgyGPS9uP8MvyDmiCpLVgpA+rcur
         32Usb+5gDV/w6pVPNqGSiTpRRUcHInt0UI/HcckIus0eK6eZRum8LmwdjB7qAjCxqNgp
         D2COVT2y8BmqX787J8J0If6q/lcdgCOQhTvkDzcrTJ5Ge6htm8wJp4+uscCZPmFBP5cU
         2EdUCi3mVnLzOqJWqcS31ttuk+Q43adY71T9yhQl58ilAQbThmWFEMfgG8OwSUwrawur
         i9PLmcIyl3ip0W1qHmotJAK3uFi466MuG2MbbLt0LxkebxS6Jp5yrbvIVRpbZK3+dC4c
         cjbg==
X-Gm-Message-State: AC+VfDwFMaKfjzW7VTzXir8GjOIXjYNp7dbcGQbVs64gdUBgHU1wutIS
        4OuM/sPbRKC+zazgGzT/4UKgxQ==
X-Google-Smtp-Source: ACHHUZ6seLDwpj4RolVQYyb0o1iErqMDr1kmvf6fp+MtcMehIqrlZQ8vKDd63c9pWnSxB6RtD1MWgA==
X-Received: by 2002:adf:cd0e:0:b0:304:6a26:1f6 with SMTP id w14-20020adfcd0e000000b003046a2601f6mr17996620wrm.59.1683870074239;
        Thu, 11 May 2023 22:41:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b00307c0afc030sm5251841wrn.4.2023.05.11.22.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 22:41:12 -0700 (PDT)
Date:   Fri, 12 May 2023 08:41:07 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     oe-kbuild@lists.linux.dev,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: drivers/iio/accel/kionix-kx022a.c:1053 kx022a_probe_internal()
 warn: passing zero to 'dev_err_probe'
Message-ID: <f5f669fc-ebb4-46df-8957-84c714481ace@kili.mountain>
References: <46296e39-dbc1-4f27-b89c-af6f08d9f318@kili.mountain>
 <a1ad0e10-23d2-a860-e9a1-2680313d643f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1ad0e10-23d2-a860-e9a1-2680313d643f@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 08:16:02AM +0300, Matti Vaittinen wrote:
> > 7c1d1677b3227c Matti Vaittinen 2022-10-24  1046  	irq = fwnode_irq_get_byname(fwnode, "INT1");
> > 7c1d1677b3227c Matti Vaittinen 2022-10-24  1047  	if (irq > 0) {
> > 7c1d1677b3227c Matti Vaittinen 2022-10-24  1048  		data->inc_reg = KX022A_REG_INC1;
> > 7c1d1677b3227c Matti Vaittinen 2022-10-24  1049  		data->ien_reg = KX022A_REG_INC4;
> > 7c1d1677b3227c Matti Vaittinen 2022-10-24  1050  	} else {
> > 7c1d1677b3227c Matti Vaittinen 2022-10-24  1051  		irq = fwnode_irq_get_byname(fwnode, "INT2");
> > 7c1d1677b3227c Matti Vaittinen 2022-10-24  1052  		if (irq <= 0)
> >                                                                      ^^^^^^^^
> > This code assumes fwnode_irq_get_byname() can return zero.
> > 
> > 7c1d1677b3227c Matti Vaittinen 2022-10-24 @1053  			return dev_err_probe(dev, irq, "No suitable IRQ\n");
> > 
> > But fortunately, it can't otherwise this would return success.
> > 
> 
> Ouch. Actually, the fwnode_irq_get_byname() can return zero on device-tree
> mapping error. I did actually send a patch to address this some time ago:
> https://lore.kernel.org/lkml/cover.1666710197.git.mazziesaccount@gmail.com/
> 

Ah.  I just went by the documentation instead of looking at the code.

Originally a bunch of irq functions return NO_IRQ on error which was a
design mistake...  irq_of_parse_and_map() still returns zero on error
instead of negative error codes.  I wrote a check for that yesterday.

drivers/gpu/drm/msm/dsi/dsi_host.c:1949 msm_dsi_host_init() warn: irq_of_parse_and_map() returns zero on failure
drivers/dma/ti/edma.c:2405 edma_probe() warn: irq_of_parse_and_map() returns zero on failure
drivers/dma/ti/edma.c:2421 edma_probe() warn: irq_of_parse_and_map() returns zero on failure
drivers/net/ethernet/xilinx/ll_temac_main.c:1570 temac_probe() warn: irq_of_parse_and_map() returns zero on failure
drivers/net/ethernet/xilinx/ll_temac_main.c:1573 temac_probe() warn: irq_of_parse_and_map() returns zero on failure
drivers/ata/sata_mv.c:4094 mv_platform_probe() warn: irq_of_parse_and_map() returns zero on failure

It would be good if we could apply your patch, otherwise I could create
an explicit check for fwnode_irq_get_byname() returns.

Ideally, everything would just return negative error codes on error.
It's harder to change irq_of_parse_and_map() because it doesn't return a
mix of errors and zero, but just zero.  We would have to rename it to
something else, otherwise backports would get messed up.

regards,
dan carpenter
