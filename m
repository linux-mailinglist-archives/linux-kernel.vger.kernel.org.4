Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A54361746D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiKCCua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiKCCuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB4C13F27;
        Wed,  2 Nov 2022 19:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2748261C3C;
        Thu,  3 Nov 2022 02:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB72C433C1;
        Thu,  3 Nov 2022 02:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667443819;
        bh=1Xb1IbsQxSNdC1FhUMa7ArhE3num/nt0p4tiyUrNpbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xe7FHmXbq3DFHk/A219wviEIAIS4Js2aIstNq6oHcV7ybI+jI60Z80JWzRGhbzrAK
         yXpXObeQXEJtgiQV2HNjwnv/RjB+lQgSUxpwjqKz+mOTrWUgAITFvpCFuqa67Stdtb
         QLq1CendIM3l4gOr24bg7X+xQhTXJPwhoL04Ogds=
Date:   Thu, 3 Nov 2022 03:51:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     jirislaby@kernel.org, f.fainelli@gmail.com, sbranden@broadcom.com,
        l.sanfilippo@kunbus.com, guomengqi3@huawei.com, rjui@broadcom.com,
        ilpo.jarvinen@linux.intel.com,
        bcm-kernel-feedback-list@broadcom.com, athierry@redhat.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_bcm2835aux: return PTR_ERR when fail to
 acquire clk
Message-ID: <Y2Mso+AwtEURmPMI@kroah.com>
References: <20221023065053.4057108-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023065053.4057108-1-zengheng4@huawei.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 02:50:53PM +0800, Zeng Heng wrote:
> Add error handling process when fail to acquire clk by
> `devm_clk_get_optional`.
> 
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  drivers/tty/serial/8250/8250_bcm2835aux.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
> index 15a2387a5b25..1c623e93232c 100644
> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
> @@ -119,6 +119,8 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
>  
>  	/* get the clock - this also enables the HW */
>  	data->clk = devm_clk_get_optional(&pdev->dev, NULL);
> +	if (IS_ERR(data->clk))
> +		return PTR_ERR(data->clk);

How was this tested to verify that it works properly?

thanks,

greg k-h
