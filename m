Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92EB605E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiJTLLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJTLLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:11:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469743054F;
        Thu, 20 Oct 2022 04:11:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED930B82708;
        Thu, 20 Oct 2022 11:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B94C433D6;
        Thu, 20 Oct 2022 11:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666264303;
        bh=fqppNzeCEo1NHzHf6cVOz8qZAjKWYPqQw/5w9Joza68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GLnd7QnW7rjUEnIqOp/2/3h7dC8jkxN0JEK33g+5Kz8JjIeO9McVsGH2QRz7NDTaq
         UbZnJpwvv4oKO3cF+LcDbUgMY8O1JOg8S3ha1Ad/TfDN/InH94SiDjG5NrzUET4vmZ
         rZk9HtBogEblGTtmpixEL6l1FHFu1QA2DpcZEIdk=
Date:   Thu, 20 Oct 2022 13:11:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     wangwenmei168@163.com
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, gehao <gehao@kylinos.cn>
Subject: Re: [RESEND PATCH] xhci: Fix Renesas PCIe controllers passthrough
 issue
Message-ID: <Y1Es7JWPNtcK2Qsu@kroah.com>
References: <20221020103914.262202-1-wangwenmei168@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020103914.262202-1-wangwenmei168@163.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 06:39:14PM +0800, wangwenmei168@163.com wrote:
> From: gehao <gehao@kylinos.cn>

This does not match your from: line in the email at all, so we can't
take this :(

Please work with your company's email system to make it possible to send
kernel patches if you wish to be able to contribute.

> 
> When we use uPD720201 USB 3.0 Host Controller passthrough to VM
> guest os will report follow errors and it can not working.
> 
> xhci_hcd 0000:09:00.0: Host took too long to start, waited 16000
> microseconds.
> xhci_hcd 0000:09:00.0: startup error -19.
> 
> Because when we passthroug some device to our guest os,
> dev->iommu_group =NULL,so it will return from this function,
> Actually it still control by host os.
> I think that this condition is not necessary.
> 
> For host os with IOMMU,it is safe.
> For host os with noiommu,doing anything when there is no
> iommu is definitely.
> For guest os,the addresses we can access are restricted.
> 
> After add this path,they all work well.

This line isn't needed in a changelog, right?

> 
> Signed-off-by: gehao <gehao@kylinos.cn>
> ---
>  drivers/usb/host/xhci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 5176765c4013..e8f4c4ee3ea3 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -241,12 +241,8 @@ static void xhci_zero_64b_regs(struct xhci_hcd *xhci)
>  	 * changing the programming leads to extra accesses even if the
>  	 * controller is supposed to be halted. The controller ends up with
>  	 * a fatal fault, and is then ripe for being properly reset.
> -	 *
> -	 * Special care is taken to only apply this if the device is behind
> -	 * an iommu. Doing anything when there is no iommu is definitely
> -	 * unsafe...

How many different systems did you test this on to verify that this is
now ok to do?

thanks,

greg k-h
