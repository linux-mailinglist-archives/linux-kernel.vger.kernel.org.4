Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6A66092B4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJWMkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiJWMkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA2355093
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 05:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9704860D3B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 12:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E43C433C1;
        Sun, 23 Oct 2022 12:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666528814;
        bh=FmVFRhk3qD4REO2lsQJB9hM4oYxuxGIm3ofymF1zil8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wczGpU3nt9t6iNldBXgI9N7AKW/cdPInA2hcFjIaLy5F61/zVXXN5SwlyWfin+vYZ
         6DOmPahPf1WgDsuKqF2S0zYRUam0wB8PQrKfk/x0Kf2APmaBeMYdvX9F7bg97PT5g7
         fQSAVmCqDy64M+zDkqNtxORh2p59G71wxBHXe/a8=
Date:   Sun, 23 Oct 2022 14:40:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Subject: Re: [RFC PATCH 2/3] drm: define new accel major and register it
Message-ID: <Y1U2K+fAnGbYug/+@kroah.com>
References: <20221022214622.18042-1-ogabbay@kernel.org>
 <20221022214622.18042-3-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022214622.18042-3-ogabbay@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 12:46:21AM +0300, Oded Gabbay wrote:
> The accelerator devices will be exposed to the user space with a new,
> dedicated major number - 261.
> 
> The drm core registers the new major number as a char device and create
> corresponding sysfs and debugfs root entries, same as for the drm major.
> 
> In case CONFIG_ACCEL is not selected, this code is not compiled in.
> 
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> ---
>  Documentation/admin-guide/devices.txt |  5 +++
>  drivers/gpu/drm/drm_drv.c             | 45 +++++++++++++++++++++++
>  drivers/gpu/drm/drm_internal.h        |  3 ++
>  drivers/gpu/drm/drm_sysfs.c           | 52 +++++++++++++++++++++++++++
>  include/drm/drm_ioctl.h               |  1 +
>  5 files changed, 106 insertions(+)
> 
> diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
> index 9764d6edb189..06c525e01ea5 100644
> --- a/Documentation/admin-guide/devices.txt
> +++ b/Documentation/admin-guide/devices.txt
> @@ -3080,6 +3080,11 @@
>  		  ...
>  		  255 = /dev/osd255	256th OSD Device
>  
> + 261 char	Compute Acceleration Devices
> +		  0 = /dev/accel/accel0	First acceleration device
> +		  1 = /dev/accel/accel1	Second acceleration device
> +		    ...
> +
>   384-511 char	RESERVED FOR DYNAMIC ASSIGNMENT
>  		Character devices that request a dynamic allocation of major
>  		number will take numbers starting from 511 and downward,
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 8214a0b1ab7f..b58ffb1433d6 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -67,6 +67,10 @@ static bool drm_core_init_complete;
>  
>  static struct dentry *drm_debugfs_root;
>  
> +#ifdef CONFIG_ACCEL
> +static struct dentry *accel_debugfs_root;
> +#endif
> +
>  DEFINE_STATIC_SRCU(drm_unplug_srcu);
>  
>  /*
> @@ -1031,9 +1035,19 @@ static const struct file_operations drm_stub_fops = {
>  	.llseek = noop_llseek,
>  };
>  
> +static void accel_core_exit(void)
> +{
> +#ifdef CONFIG_ACCEL
> +	unregister_chrdev(ACCEL_MAJOR, "accel");
> +	debugfs_remove(accel_debugfs_root);
> +	accel_sysfs_destroy();
> +#endif
> +}

Why is all of this in drm_drv.c?

Why not put it in drm/accel/accel.c or something like that?  Then put
the proper stuff into a .h file and then you have no #ifdef in the .c
files.

Keeping #ifdef out of C files is key, please do not do things like you
have here.  Especially as it ends up with this kind of mess:

> +static int __init accel_core_init(void)
> +{
> +#ifdef CONFIG_ACCEL
> +	int ret;
> +
> +	ret = accel_sysfs_init();
> +	if (ret < 0) {
> +		DRM_ERROR("Cannot create ACCEL class: %d\n", ret);
> +		goto error;
> +	}
> +
> +	accel_debugfs_root = debugfs_create_dir("accel", NULL);
> +
> +	ret = register_chrdev(ACCEL_MAJOR, "accel", &drm_stub_fops);
> +	if (ret < 0)
> +		goto error;
> +
> +error:
> +	/* Any cleanup will be done in drm_core_exit() that will call
> +	 * to accel_core_exit()
> +	 */
> +	return ret;
> +#else
> +	return 0;
> +#endif
> +}


That's just a mess.

thanks,

greg k-h
