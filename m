Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44AF6B24EF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCINIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjCINIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:08:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D8C7EDD;
        Thu,  9 Mar 2023 05:07:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C10A461B68;
        Thu,  9 Mar 2023 13:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946C5C4339B;
        Thu,  9 Mar 2023 13:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678367276;
        bh=OkIirOLzi4noUGuDrFd3QCCm818DgLRyVk2I/IlEGhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s/ndqFodvUQCwUqKRxSkbEyGEIKCjnv25Whg8kctG5EDX/jW38cY18B0TcYyHuby8
         JSMK7w7Asw8Y2lBm/fn8/UDZzSA7hDzpW3uAKOFvL/eLtfj5zSiJAMMG62eXk6FLH2
         X7k4lCc3QB1RdXJMWAJxIDk9nPqWQOMtwGY9K19A=
Date:   Thu, 9 Mar 2023 14:07:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, eric.auger@redhat.com,
        alex.williamson@redhat.com, cohuck@redhat.com,
        song.bao.hua@hisilicon.com, mchehab+huawei@kernel.org,
        maz@kernel.org, f.fainelli@gmail.com, jeffrey.l.hugo@gmail.com,
        saravanak@google.com, Michael.Srba@seznam.cz, mani@kernel.org,
        yishaih@nvidia.com, jgg@ziepe.ca, jgg@nvidia.com,
        robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
        masahiroy@kernel.org, ndesaulniers@google.com,
        rdunlap@infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, okaya@kernel.org,
        harpreet.anand@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, pieter.jansen-van-vuuren@amd.com,
        pablo.cascon@amd.com, git@amd.com
Subject: Re: [PATCH v9 1/7] cdx: add the cdx bus driver
Message-ID: <ZAnaKahHaVUXxlcw@kroah.com>
References: <20230307131917.30605-1-nipun.gupta@amd.com>
 <20230307131917.30605-2-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307131917.30605-2-nipun.gupta@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 06:49:11PM +0530, Nipun Gupta wrote:
> Introduce AMD CDX bus, which provides a mechanism for scanning
> and probing CDX devices. These devices are memory mapped on
> system bus for Application Processors(APUs).
> 
> CDX devices can be changed dynamically in the Fabric and CDX
> bus interacts with CDX controller to rescan the bus and
> rediscover the devices.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cdx |  12 +
>  MAINTAINERS                             |   7 +
>  drivers/Kconfig                         |   2 +
>  drivers/Makefile                        |   1 +
>  drivers/cdx/Kconfig                     |  17 +
>  drivers/cdx/Makefile                    |   8 +
>  drivers/cdx/cdx.c                       | 407 ++++++++++++++++++++++++
>  drivers/cdx/cdx.h                       |  62 ++++
>  include/linux/cdx/cdx_bus.h             | 147 +++++++++
>  include/linux/mod_devicetable.h         |  15 +
>  scripts/mod/devicetable-offsets.c       |   4 +
>  scripts/mod/file2alias.c                |  12 +
>  12 files changed, 694 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-cdx
>  create mode 100644 drivers/cdx/Kconfig
>  create mode 100644 drivers/cdx/Makefile
>  create mode 100644 drivers/cdx/cdx.c
>  create mode 100644 drivers/cdx/cdx.h
>  create mode 100644 include/linux/cdx/cdx_bus.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
> new file mode 100644
> index 000000000000..063d1a0dd866
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> @@ -0,0 +1,12 @@
> +What:		/sys/bus/cdx/rescan
> +Date:		March 2023
> +Contact:	nipun.gupta@amd.com
> +Description:
> +		Writing a non-zero value to this file cause rescan of the bus
> +		and devices on the CDX bus. Any new devices are scanned and
> +		added to the list of Linux devices and any devices removed are
> +		also deleted from Linux.
> +
> +		For example::
> +
> +		  # echo 1 > /sys/bus/cdx/rescan

See my comments on patch 7/7 about "non-zero" not being a good idea.

thanks,

greg k-h
