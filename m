Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B8B6E60CB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjDRMLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjDRMKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:10:31 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF0876A1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:09:47 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id gb12so26193515qtb.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1681819786; x=1684411786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=381gUO9FATr4AJzfeukRCfAEeb1NcxgdtUMMeujbbMo=;
        b=NXPE/WMDmhobtTHmn4WpOfH1SiPLQorKBOBBYQMnXs39D9Wz9F5OCOCWWBPaosZTOU
         NQe2kAIejkOb9v+ymsvspcuZVd7mgkiNVLV9AML/SXdfatN9rVj6mTcHLdcG0sHERv4x
         4dPtsEIDeC7NikkmfkHJaKiTQ9jEjJM/ILPi7PJ7Ec7Nnqf4lhnBQssM1s+RqUYAjm69
         +v5Ep0F95o3VZVYQRCe8ZRkYymqx3b25vOeMvO+aWTCA/8aCKr8LlWGBrXi0ZooU9L0d
         ueTIxwhMw6cnEuZ5N28+C+d8DDkOU7i2xA7fISYrU6mHXdaiMGrNDxvnQZGXZKuk/1Ka
         /+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681819786; x=1684411786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=381gUO9FATr4AJzfeukRCfAEeb1NcxgdtUMMeujbbMo=;
        b=i0BU2zEGfm/pfgywBCJQiqHV6ee9/q7B8lHdbJjYWbWR245//YoTaW0sh62kIC5QpX
         aIRQ2kuljPIVbcYfanx4FKQnWxLrSpBg1g2Uyj5ZoNuGyU1N0WxwK/iICL5uuH2aezN+
         C0wcPnXBt0n1Tks0Cc+fa9v/ZJnk7I9+TGFlSom5Tj+vdMPZAKheD9LJ82rO/bC1T77P
         5Dt43CTzzMY+VvXPaDbyaEwBSOhD9X2zgaQv0KD1IHqq1PyL/5FvfyO+KrE4vilVjRQZ
         tMtkuK9g9Sa261Jbt7CJAEQhXZfYGgdbQaa25uTBt2Pzc+3ZeX8Oot5r6lkf80dmCxt0
         bJIg==
X-Gm-Message-State: AAQBX9fLzUdOxoCYA/xBY2MmmbeUNFwMMzpHO95PVZjTvZOrtlzxb+Ed
        mQu84RfrIZD1DMHoTmJr0tI71Q==
X-Google-Smtp-Source: AKy350a9fCwJ2jD8LhxUySOu6VjzudNIN9Ipzc5PO8QkO5micOfG+iwVt1W+70n7yC2M33/vzwnm8A==
X-Received: by 2002:a05:622a:250:b0:3ea:bec4:ef57 with SMTP id c16-20020a05622a025000b003eabec4ef57mr22175880qtx.13.1681819786550;
        Tue, 18 Apr 2023 05:09:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id bm24-20020a05620a199800b007468bf8362esm98151qkb.66.2023.04.18.05.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 05:09:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pok9Y-00BqaN-WA;
        Tue, 18 Apr 2023 09:09:45 -0300
Date:   Tue, 18 Apr 2023 09:09:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, masahiroy@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu, git@amd.com,
        harpreet.anand@amd.com, pieter.jansen-van-vuuren@amd.com,
        nikhil.agarwal@amd.com, michal.simek@amd.com
Subject: Re: [PATCH v4] vfio/cdx: add support for CDX bus
Message-ID: <ZD6IiHjWQOv47ZMg@ziepe.ca>
References: <20230418113655.25207-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418113655.25207-1-nipun.gupta@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 05:06:55PM +0530, Nipun Gupta wrote:

> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index 89e06c981e43..aba36f5be4ec 100644
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -57,6 +57,7 @@ source "drivers/vfio/pci/Kconfig"
>  source "drivers/vfio/platform/Kconfig"
>  source "drivers/vfio/mdev/Kconfig"
>  source "drivers/vfio/fsl-mc/Kconfig"
> +source "drivers/vfio/cdx/Kconfig"

keep sorted

>  endif
>
>  source "virt/lib/Kconfig"
> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
> index 70e7dcb302ef..1a27b2516612 100644
> --- a/drivers/vfio/Makefile
> +++ b/drivers/vfio/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_VFIO_PCI) += pci/
>  obj-$(CONFIG_VFIO_PLATFORM) += platform/
>  obj-$(CONFIG_VFIO_MDEV) += mdev/
>  obj-$(CONFIG_VFIO_FSL_MC) += fsl-mc/
> +obj-$(CONFIG_VFIO_CDX) += cdx/

keep sorted

> diff --git a/drivers/vfio/cdx/Makefile b/drivers/vfio/cdx/Makefile
> new file mode 100644
> index 000000000000..82e4ef412c0f
> --- /dev/null
> +++ b/drivers/vfio/cdx/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
> +#
> +
> +obj-$(CONFIG_VFIO_CDX) += vfio-cdx.o
> +
> +vfio-cdx-objs := vfio_cdx.o

Linus has asked about "suttering" filenames before, suggest to call
this

"vfio/cdx/main.c"

> +static long vfio_cdx_ioctl(struct vfio_device *core_vdev,
> +			   unsigned int cmd, unsigned long arg)
> +{
> +	struct vfio_cdx_device *vdev =
> +		container_of(core_vdev, struct vfio_cdx_device, vdev);
> +	struct cdx_device *cdx_dev = to_cdx_device(core_vdev->dev);
> +	unsigned long minsz;
> +
> +	switch (cmd) {
> +	case VFIO_DEVICE_GET_INFO:
> +	{
> +		struct vfio_device_info info;
> +
> +		minsz = offsetofend(struct vfio_device_info, num_irqs);
> +
> +		if (copy_from_user(&info, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (info.argsz < minsz)
> +			return -EINVAL;
> +
> +		info.flags = VFIO_DEVICE_FLAGS_CDX;
> +		info.flags |= VFIO_DEVICE_FLAGS_RESET;
> +
> +		info.num_regions = cdx_dev->res_count;
> +		info.num_irqs = 0;
> +
> +		return copy_to_user((void __user *)arg, &info, minsz) ?
> +			-EFAULT : 0;
> +	}
> +	case VFIO_DEVICE_GET_REGION_INFO:
> +	{
> +		struct vfio_region_info info;
> +
> +		minsz = offsetofend(struct vfio_region_info, offset);
> +
> +		if (copy_from_user(&info, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (info.argsz < minsz)
> +			return -EINVAL;
> +
> +		if (info.index >= cdx_dev->res_count)
> +			return -EINVAL;
> +
> +		/* map offset to the physical address  */
> +		info.offset = vfio_cdx_index_to_offset(info.index);
> +		info.size = vdev->regions[info.index].size;
> +		info.flags = vdev->regions[info.index].flags;
> +
> +		if (copy_to_user((void __user *)arg, &info, minsz))
> +			return -EFAULT;
> +		return 0;
> +	}
> +	case VFIO_DEVICE_RESET:
> +	{
> +		return cdx_dev_reset(core_vdev->dev);
> +	}
> +	default:
> +		return -ENOTTY;
> +	}
> +}

Please split this into functions, eg look at PCI

Jason
