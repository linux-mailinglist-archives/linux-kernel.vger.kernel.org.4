Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D3464AFAC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 07:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiLMGOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 01:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiLMGOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 01:14:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADFDFACF;
        Mon, 12 Dec 2022 22:14:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E38E6119B;
        Tue, 13 Dec 2022 06:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D592C433F0;
        Tue, 13 Dec 2022 06:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670912068;
        bh=9qlkAvr6fL5DQQbYvPUZpYWAoWwScOvU8dCgcv4X4YU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0vdyolHyyEUHy6X9A9C6XD/uQh1YVvVOFjQmqTsXuYE9UkwHSEHvpVVXT3TWetHy6
         1OmgINN0XCrWc2bpG6nft5EErNgUuvCc+7mYJlN/Gh2uQos+MfOm/6eChVaQ0WPbe0
         xcUC2se8q3QosMbmzTwc6+VXSag3PYvrq4g5tsuQ=
Date:   Tue, 13 Dec 2022 07:14:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     neal_liu@aspeedtech.com, joel@jms.id.au, andrew@aj.id.au,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] usb: gadget: aspeed_udc: Add check for dma_alloc_coherent
Message-ID: <Y5gYQZ3iA/k9EPJn@kroah.com>
References: <20221213025120.23149-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213025120.23149-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 10:51:19AM +0800, Jiasheng Jiang wrote:
> Add the check for the return value of dma_alloc_coherent
> in order to avoid NULL pointer dereference.
> 
> Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/usb/gadget/udc/aspeed_udc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> index 01968e2167f9..6cf46562bb25 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -1516,6 +1516,8 @@ static int ast_udc_probe(struct platform_device *pdev)
>  					  AST_UDC_EP_DMA_SIZE *
>  					  AST_UDC_NUM_ENDPOINTS,
>  					  &udc->ep0_buf_dma, GFP_KERNEL);
> +	if (!udc->ep0_buf)
> +		return -ENOMEM;

How did you test this?  I ask as it is obviously not correct.  Please
always test your patches before submitting them as adding new bugs when
claiming that you are fixing a problem is not good.

And how did you find this potential problem?  What tool did you use and
why did you not follow the documentation for properly describing the
tool?

thanks,

greg k-h
