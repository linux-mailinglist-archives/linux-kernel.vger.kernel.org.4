Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C44602E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiJROfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiJROfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:35:09 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 018B59F342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:35:04 -0700 (PDT)
Received: (qmail 1214035 invoked by uid 1000); 18 Oct 2022 10:35:03 -0400
Date:   Tue, 18 Oct 2022 10:35:03 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v2] usb: ehci-orion: Extend DMA mask to 64 bit for AC5
 platform
Message-ID: <Y065l3SCyY8Ixazf@rowland.harvard.edu>
References: <20221018113401.32229-1-vadym.kochan@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018113401.32229-1-vadym.kochan@plvision.eu>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 02:34:00PM +0300, Vadym Kochan wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> AC5 is a 64-bit platform so extend the dma mask accordingly.
> 
> Checked this mask on armv7 a38x SoC (which has this
> USB controller) platform with simple fs ops on the storage device
> but on older 4.14 Linux version.
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
> v2:
>    Add missing description.
> 
>  drivers/usb/host/ehci-orion.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
> index a3454a3ea4e0..c6205abebbdf 100644
> --- a/drivers/usb/host/ehci-orion.c
> +++ b/drivers/usb/host/ehci-orion.c
> @@ -230,7 +230,7 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
>  	 * set. Since shared usb code relies on it, set it here for
>  	 * now. Once we have dma capability bindings this can go away.
>  	 */
> -	err = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	err = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>  	if (err)
>  		goto err;
>  

NAK.  The description says this changes the DMA mask on AC5 platforms to 
64 bits, but that isn't what the patch actually does.  It changes the 
DMA mask on _all_ platforms using the orion hardware.

Alan Stern
