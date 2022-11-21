Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC106319C4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 07:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKUGfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 01:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiKUGfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 01:35:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691E231347;
        Sun, 20 Nov 2022 22:35:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16B91B80C8B;
        Mon, 21 Nov 2022 06:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566AEC433C1;
        Mon, 21 Nov 2022 06:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669012536;
        bh=7CYs8BBS+Jsc6TV659IdrBe1it3eg5ejFxeuLhuykqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fTe+qp9151qJnBdXHiBQ4c5KYz3rxfymOdaO0T/mInww2BFb8qiVSoAXLzE5iCPfg
         cWI1T7EZtTvH3s5kCeRyt4OLu6oMgasStG2eyRjdHJ+SA/5KUjZeMF3mC8IAtiZDl/
         LCX8qZSPG85grDCOFDitpDEj4bvjY25G/MCheuTc=
Date:   Mon, 21 Nov 2022 07:35:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] usb: typec: pd: Add symlink to linked device
Message-ID: <Y3scND+8DVe8SGeD@kroah.com>
References: <20221121062106.2569297-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121062106.2569297-1-pmalani@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 06:20:39AM +0000, Prashant Malani wrote:
> There exists a symlink from a device to its USB Power Delivery object,
> but not the other way around. Add a symlink from the USB PD object to
> the device which it's associated with, and call it "device".
> 
> This is helpful to identify said device (a Type-C peripheral for
> example) during uevents, since during USB PD object
> creation/destruction, a uevent is generated for the PD object,
> but not the device linked to it.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Benson Leung <bleung@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  .../ABI/testing/sysfs-class-usb_power_delivery       |  6 ++++++
>  drivers/usb/typec/pd.c                               | 12 ++++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-usb_power_delivery b/Documentation/ABI/testing/sysfs-class-usb_power_delivery
> index ce2b1b563cb3..e7d19193875f 100644
> --- a/Documentation/ABI/testing/sysfs-class-usb_power_delivery
> +++ b/Documentation/ABI/testing/sysfs-class-usb_power_delivery
> @@ -4,6 +4,12 @@ Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
>  Description:
>  		Directory for USB Power Delivery devices.
>  
> +What:		/sys/class/usb_power_delivery/.../device
> +Date:		November 2022
> +Contact:	Prashant Malani <pmalani@chromium.org>
> +Description:
> +		Symbolic link to the directory of the device to which the USB PD object is linked.

Line is way too long.

But wait, a "device" has a specific meaning in a sysfs file, and that is
not what is happening here.

Please don't make fake "device" symlinks when these are not really using
a device here.  Either fix it up to properly use the device structures
in the code, or call this something else.

What in userspace wants to see this symlink?

thanks,

greg k-h
