Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639BA5B3208
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiIIIkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiIIIkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A945A3E2;
        Fri,  9 Sep 2022 01:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCA2161F2E;
        Fri,  9 Sep 2022 08:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0F7C433D6;
        Fri,  9 Sep 2022 08:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662712817;
        bh=9yRkOSU/jhy0yb04tTkefir1DzZzdH+ZB6co9dc3weA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtxazmq0gg7UBZZPr703Rdav5VN1PcwrIbH3jAm1cj+ISTUgnYKITIY/biMRN4D4c
         fNUIzObZwhVj02H9U7PD4lZs17pS6H9nX8OgT0q+xzXY/ssqdA7/M6cetrnLV78TuT
         yu4N0uW2ZivKsvuf2Sfah1jGpOxHsW0bKCX9HQo4=
Date:   Fri, 9 Sep 2022 10:40:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
Cc:     appanad@amd.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, git@amd.com
Subject: Re: [PATCH v4 2/4] drivers: misc: Add Support for TMR Manager
Message-ID: <Yxr77l3UGbphuJkM@kroah.com>
References: <20220909061916.2935431-1-appana.durga.kedareswara.rao@amd.com>
 <20220909061916.2935431-3-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909061916.2935431-3-appana.durga.kedareswara.rao@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 11:49:14AM +0530, Appana Durga Kedareswara rao wrote:
> Triple Modular Redundancy(TMR) subsystem contains three microblaze cores,
> subsystem is fault-tolerant and continues to operate nominally after
> encountering an error. Together with the capability to detect and recover
> from errors, the implementation ensures the reliability of the entire
> subsystem.  TMR Manager is responsible for performing recovery of the
> subsystem detects the fault via a break signal it invokes microblaze
> software break handler which calls the tmr manager driver api to
> update the error count and status, added support for fault detection
> feature via sysfs interface.
> 
> Usage:
> To know the break handler count(Error count):
> cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/errcnt
> 
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
> ---
> Changes for v4:
> --> None.
> Changes for v3:
> --> Corrected month in the sysfs-driver-xilinx-tmr-manager file
> --> Updated the Kconfig to compile the driver as a module
> --> Removed unneeded status sysfs attribute
> Changes for v2:
> --> Fixed Month in the sysfs description.
> --> Fixed line over 80 char in driver.
> --> Replaced kstrtol with kstrtoul as suggested by Michal.
> --> Added error check for xlnx,magic1 value.
> 
>  .../testing/sysfs-driver-xilinx-tmr-manager   |  16 ++
>  MAINTAINERS                                   |   7 +
>  drivers/misc/Kconfig                          |  10 +
>  drivers/misc/Makefile                         |   3 +-
>  drivers/misc/xilinx_tmr_manager.c             | 222 ++++++++++++++++++
>  5 files changed, 257 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
>  create mode 100644 drivers/misc/xilinx_tmr_manager.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
> new file mode 100644
> index 000000000000..2a97be6ae849
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
> @@ -0,0 +1,16 @@
> +What:		/sys/devices/platform/amba_pl/<dev>/errcnt
> +Date:		Sep 2022
> +Contact:	appana.durga.kedareswara.rao@amd.com
> +Description:	This control file provides the fault detection count.
> +		This file cannot be written.
> +		Example:
> +		# cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/errcnt
> +		  1
> +
> +What:		/sys/devices/platform/amba_pl/<dev>/dis_block_break
> +Date:		Sep 2022
> +Contact:	appana.durga.kedareswara.rao@amd.com
> +Description:	Write any value to it, This control file enables the break signal.
> +		This file is write only.
> +		Example:
> +		# echo <any value> > /sys/devices/platform/amba_pl/44a10000.tmr_manager/dis_block_break
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f1390b8270b2..5fc5ec13985e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13277,6 +13277,13 @@ W:	http://www.monstr.eu/fdt/
>  T:	git git://git.monstr.eu/linux-2.6-microblaze.git
>  F:	arch/microblaze/
>  
> +MICROBLAZE TMR MANAGER
> +M:	Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
> +S:	Supported
> +F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
> +F:	Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
> +F:	drivers/misc/xilinx_tmr_manager.c
> +
>  MICROCHIP AT91 DMA DRIVERS
>  M:	Ludovic Desroches <ludovic.desroches@microchip.com>
>  M:	Tudor Ambarus <tudor.ambarus@microchip.com>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 94e9fb4cdd76..1508cc29b05a 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -496,6 +496,16 @@ config VCPU_STALL_DETECTOR
>  
>  	  If you do not intend to run this kernel as a guest, say N.
>  
> +config TMR_MANAGER
> +	tristate "Select TMR Manager"
> +	depends on MICROBLAZE && MB_MANAGER
> +	help
> +	  This option enables the driver developed for TMR Manager. The Triple
> +	  Modular Redundancy(TMR) manager provides support for fault detection
> +	  via sysfs interface.

What is the module name?

And the fault detection api is in debugfs, not sysfs, right?

thanks,

greg k-h
