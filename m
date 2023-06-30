Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CA67435CA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjF3Hbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjF3Hbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:31:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC8F2683
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 00:31:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BB4F616E4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57924C433C0;
        Fri, 30 Jun 2023 07:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688110300;
        bh=JOH1MexKJv3DmMyVdmKqtZWMJ96HMb8m4Hxc7GRg9ZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z2i2lysIQXH4O3rrZZ+NJVVPH6sPv06rTsJkUqX2ulkEkRfOKk3J7PnTXY7LvlH6r
         0SMj5BAHOnyj+fVfNWdkJHgE/45ceKpQ4JQ56YnSWOdq6NwxDWrX8m1j4fojABEgVW
         48rzVQrXogNJFscYAN5/KgqIzhA65jF0peHhh8Bw=
Date:   Fri, 30 Jun 2023 09:31:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] include/uapi pps.h: drop not needed PPS_MAX_SOURCES
 define
Message-ID: <2023063017-traverse-accustom-97f4@gregkh>
References: <20230630071826.105501-1-giometti@enneenne.com>
 <20230630071826.105501-2-giometti@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630071826.105501-2-giometti@enneenne.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 09:18:26AM +0200, Rodolfo Giometti wrote:
> Userspace PPS clients should not known about how many PPS sources can
> be defined within the system (nor the rfc2783 say so), so we can
> safely drop this define since is not used anymore in the kernel too.
> 
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> ---
>  drivers/pps/pps.c        | 6 +++---
>  include/uapi/linux/pps.h | 1 -
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> index 5d19baae6a38..1a6131608036 100644
> --- a/drivers/pps/pps.c
> +++ b/drivers/pps/pps.c
> @@ -354,7 +354,7 @@ int pps_register_cdev(struct pps_device *pps)
>  	 * Get new ID for the new PPS source.  After idr_alloc() calling
>  	 * the new source will be freely available into the kernel.
>  	 */
> -	err = idr_alloc(&pps_idr, pps, 0, PPS_MAX_SOURCES, GFP_KERNEL);
> +	err = idr_alloc(&pps_idr, pps, 0, MINORMASK, GFP_KERNEL);
>  	if (err < 0) {
>  		if (err == -ENOSPC) {
>  			pr_err("%s: too many PPS sources in the system\n",
> @@ -449,7 +449,7 @@ EXPORT_SYMBOL(pps_lookup_dev);
>  static void __exit pps_exit(void)
>  {
>  	class_destroy(pps_class);
> -	unregister_chrdev_region(pps_devt, PPS_MAX_SOURCES);
> +	unregister_chrdev_region(pps_devt, MINORMASK);
>  }
>  
>  static int __init pps_init(void)
> @@ -463,7 +463,7 @@ static int __init pps_init(void)
>  	}
>  	pps_class->dev_groups = pps_groups;
>  
> -	err = alloc_chrdev_region(&pps_devt, 0, PPS_MAX_SOURCES, "pps");
> +	err = alloc_chrdev_region(&pps_devt, 0, MINORMASK, "pps");
>  	if (err < 0) {
>  		pr_err("failed to allocate char device region\n");
>  		goto remove_class;
> diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
> index 90f2e86020ba..8a4096f18af1 100644
> --- a/include/uapi/linux/pps.h
> +++ b/include/uapi/linux/pps.h
> @@ -26,7 +26,6 @@
>  #include <linux/types.h>
>  
>  #define PPS_VERSION		"5.3.6"
> -#define PPS_MAX_SOURCES		MINORMASK

Why change this in patch 1, and then delete this here?

That makes no sense.

And if this is exported to userspace, removing it should break things,
right?  If not, why was it there in the first place?

thanks,

greg k-h
