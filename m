Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84EA73CF7E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 10:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjFYIt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 04:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjFYIt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 04:49:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669761A1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 01:49:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4D8360B3E
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75B3C433C0;
        Sun, 25 Jun 2023 08:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687682994;
        bh=wax8i7JqXdLFKWScXULlLfEbHUlfq1nON8woNAJ8woc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rh7pO5TCularHZ+aMnScchvNa37CQkEpu6yF/7VP2Ua2443YGIfxSzGIkYdhpxGP8
         92/Vmluf8XDZbPgeGtRO5VHC2hPp4TrGb2Hpci7XBd36ZBZ8au07Kl855BYSVAKD/T
         thM1v9VduHd24VTOY6Qnmu2aqRortVD0FNa61mwE=
Date:   Sun, 25 Jun 2023 10:49:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, arnd@arndb.de
Subject: Re: [PATCH] cachefiles: allocate static minor for /dev/cachefiles
Message-ID: <2023062536-wrongful-botch-a188@gregkh>
References: <20230615160806.94000-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615160806.94000-1-marcel@holtmann.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 06:08:06PM +0200, Marcel Holtmann wrote:
> The cachefiles misc character device uses MISC_DYNAMIC_MINOR and thus
> doesn't support module auto-loading. Assign a static minor number for it
> and provide appropriate module aliases for it. This is enough for kmod to
> create the /dev/cachefiles device node on startup and facility module
> auto-loading.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  Documentation/admin-guide/devices.txt | 3 ++-
>  fs/cachefiles/main.c                  | 4 +++-
>  include/linux/miscdevice.h            | 1 +
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
> index 06c525e01ea5..21b2dda10006 100644
> --- a/Documentation/admin-guide/devices.txt
> +++ b/Documentation/admin-guide/devices.txt
> @@ -376,8 +376,9 @@
>  		240 = /dev/userio	Serio driver testing device
>  		241 = /dev/vhost-vsock	Host kernel driver for virtio vsock
>  		242 = /dev/rfkill	Turning off radio transmissions (rfkill)
> +		243 = /dev/cachefiles	Filesystem caching on files
>  
> -		243-254			Reserved for local use
> +		244-254			Reserved for local use
>  		255			Reserved for MISC_DYNAMIC_MINOR
>  
>    11 char	Raw keyboard device	(Linux/SPARC only)
> diff --git a/fs/cachefiles/main.c b/fs/cachefiles/main.c
> index 3f369c6f816d..eead7b5016a7 100644
> --- a/fs/cachefiles/main.c
> +++ b/fs/cachefiles/main.c
> @@ -30,11 +30,13 @@ MODULE_PARM_DESC(cachefiles_debug, "CacheFiles debugging mask");
>  MODULE_DESCRIPTION("Mounted-filesystem based cache");
>  MODULE_AUTHOR("Red Hat, Inc.");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("devname:cachefiles");
> +MODULE_ALIAS_MISCDEV(CACHEFILES_MINOR);
>  
>  struct kmem_cache *cachefiles_object_jar;
>  
>  static struct miscdevice cachefiles_dev = {
> -	.minor	= MISC_DYNAMIC_MINOR,
> +	.minor	= CACHEFILES_MINOR,
>  	.name	= "cachefiles",
>  	.fops	= &cachefiles_daemon_fops,
>  };
> diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
> index c0fea6ca5076..d7f989f593b0 100644
> --- a/include/linux/miscdevice.h
> +++ b/include/linux/miscdevice.h
> @@ -71,6 +71,7 @@
>  #define USERIO_MINOR		240
>  #define VHOST_VSOCK_MINOR	241
>  #define RFKILL_MINOR		242
> +#define CACHEFILES_MINOR	243
>  #define MISC_DYNAMIC_MINOR	255
>  
>  struct device;
> -- 
> 2.40.1
> 

Ah, the original was in my spam filter as your email does not show up as
being authenticated, you might want to fix your mail server :(

Anyway, as Christoph said, no, this isn't a good idea, keep it dynamic
and only load it if you need to load it please.  Or, please explain why
it needs to be autoloaded, what dependancy or userspace program is not
working properly because of this?

thanks,

greg k-h
