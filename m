Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA186968C4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjBNQGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBNQGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:06:36 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EB913E;
        Tue, 14 Feb 2023 08:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676390790; x=1707926790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rKhEmpR0jbfTuleiAwxKfDM2qYv1QqWCM+221GbFDcE=;
  b=j9qreGXYuTNja64hGs3/0w7wrN0lrZBJ3iSxUEq4ohwv3kgy61uGfmld
   3xlWRj7eLoVMJ5xGIBMBZUiYtf1QZwgvnCHURCik+qW6MpXziyJH+YVwg
   xzJgQFm8YfkkDbrWst47v27Pfww/4ckzLwvQwJ8nGenUKCDeN59DFmkT1
   kyFbXKZUY6zjsiHoC/+tFEQ+Kl1I/Cb7r2/+vXkr1ZOvQnLaUFiieJ2lg
   Tgq7KVf3y4nfqYL6A+FmBYshXnKY0KQojNrJdedIuaIU0eBkL/bNxKrFO
   VnLibhEKCaWR4KzoRaCcBtgsdSQoEB3XWqCCkpshcqnmI1ztld7x1Wgcs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="393595817"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="393595817"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 08:06:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="812083384"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="812083384"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 08:06:07 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 1B0691222A8;
        Tue, 14 Feb 2023 18:06:05 +0200 (EET)
Date:   Tue, 14 Feb 2023 18:06:05 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Wentong Wu <wentong.wu@intel.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        srinivas.pandruvada@intel.com,
        pierre-louis.bossart@linux.intel.com, zhifeng.wang@intel.com,
        xiang.ye@intel.com, tian.shu.qiu@intel.com, bingbu.cao@intel.com,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 3/3] media: pci: intel: ivsc: Add acquire/release API
 for ivsc
Message-ID: <Y+uxbQi7seGf+adP@kekkonen.localdomain>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <20230213022347.2480307-4-wentong.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213022347.2480307-4-wentong.wu@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wentong,

Thanks for the patchset.

On Mon, Feb 13, 2023 at 10:23:47AM +0800, Wentong Wu wrote:
> IVSC directly connects to camera sensor on source side, and on
> output side it not only connects ISH via I2C, but also exposes
> MIPI CSI-2 interface to output camera sensor data. IVSC can use
> the camera sensor data to do AI algorithm, and send the results
> to ISH. On the other end, IVSC can share camera sensor to host
> by routing the raw camera sensor data to the exposed MIPI CSI-2
> interface. But they can not work at the same time, so software
> APIs are defined to sync the ownership.
> 
> This commit defines the interfaces between IVSC and camera sensor
> driver in include/linux/ivsc.h. The camera driver controls
> ownership of the CSI-2 link and sensor with the acquire/release
> APIs. When acquiring camera, lane number and link freq are also
> required by IVSC frame router.

The more I learn about this system, the more I'm inclined to think this
functionality should be exposed as a V4L2 sub-device. IVSC doesn't really
do anything to the data (as long as it directs it towards the CSI-2
receiver in the SoC), but it is definitely part of the image pipeline.

I suppose the intended use cases assume a single instance of IVSC (as well
as MEI) but there can, and often are, be multiple camera sensors in the
system. The decision whether to request pass-through from IVCS can't be
done in the camera sensor driver, and should not be visible to the camera
sensor driver. Exposing IVSC as a V4L2 sub-device makes this trivial to
address, as the IVSC driver's V4L2 sub-device video s_stream() operation
gets called before streaming is started.

The information whether IVSC is found between the camera sensor and the
host's CSI-2 receiver (IPU in this case) should come from system firmware
and accessed most probably by what is called cio2-bridge at the moment.

The privacy status can be a V4L2 control.

Also cc Hans.

> 
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> ---
>  drivers/media/pci/intel/ivsc/Makefile |  1 +
>  drivers/media/pci/intel/ivsc/ivsc.c   | 84 +++++++++++++++++++++++++++
>  include/linux/ivsc.h                  | 55 ++++++++++++++++++
>  3 files changed, 140 insertions(+)
>  create mode 100644 drivers/media/pci/intel/ivsc/ivsc.c
> 
> diff --git a/drivers/media/pci/intel/ivsc/Makefile b/drivers/media/pci/intel/ivsc/Makefile
> index de0a425c22c2..b8b6fc1083be 100644
> --- a/drivers/media/pci/intel/ivsc/Makefile
> +++ b/drivers/media/pci/intel/ivsc/Makefile
> @@ -4,3 +4,4 @@
>  
>  obj-$(CONFIG_INTEL_VSC) += mei_csi.o
>  obj-$(CONFIG_INTEL_VSC) += mei_ace.o
> +obj-$(CONFIG_INTEL_VSC) += ivsc.o
> diff --git a/drivers/media/pci/intel/ivsc/ivsc.c b/drivers/media/pci/intel/ivsc/ivsc.c
> new file mode 100644
> index 000000000000..12996b587639
> --- /dev/null
> +++ b/drivers/media/pci/intel/ivsc/ivsc.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Intel Corporation. All rights reserved.
> + * Intel Visual Sensing Controller interface
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/ivsc.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +
> +#include "mei_ace.h"
> +#include "mei_csi.h"
> +
> +/* lock for ivsc APIs */
> +static DEFINE_MUTEX(ivsc_mutex);
> +
> +int ivsc_acquire_camera(u32 nr_of_lanes, u64 link_freq,
> +			void (*callback)(void *, enum ivsc_privacy_status),
> +			void *context)
> +{
> +	int ret;
> +
> +	mutex_lock(&ivsc_mutex);
> +
> +	/* switch camera sensor ownership to host */
> +	ret = ace_set_camera_owner(ACE_CAMERA_HOST);
> +	if (ret)
> +		goto error;
> +
> +	/* switch CSI-2 link to host */
> +	ret = csi_set_link_owner(CSI_LINK_HOST, callback, context);
> +	if (ret)
> +		goto release_camera;
> +
> +	/* configure CSI-2 link */
> +	ret = csi_set_link_cfg(nr_of_lanes, link_freq);
> +	if (ret)
> +		goto release_csi;
> +
> +	mutex_unlock(&ivsc_mutex);
> +
> +	return 0;
> +
> +release_csi:
> +	csi_set_link_owner(CSI_LINK_IVSC, NULL, NULL);
> +
> +release_camera:
> +	ace_set_camera_owner(ACE_CAMERA_IVSC);
> +
> +error:
> +	mutex_unlock(&ivsc_mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ivsc_acquire_camera);
> +
> +int ivsc_release_camera(void)
> +{
> +	int ret;
> +
> +	mutex_lock(&ivsc_mutex);
> +
> +	/* switch CSI-2 link to IVSC */
> +	ret = csi_set_link_owner(CSI_LINK_IVSC, NULL, NULL);
> +	if (ret)
> +		goto error;
> +
> +	/* switch camera sensor ownership to IVSC */
> +	ret = ace_set_camera_owner(ACE_CAMERA_IVSC);
> +
> +error:
> +	mutex_unlock(&ivsc_mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ivsc_release_camera);
> +
> +MODULE_AUTHOR("Wentong Wu <wentong.wu@intel.com>");
> +MODULE_AUTHOR("Zhifeng Wang <zhifeng.wang@intel.com>");
> +MODULE_SOFTDEP("pre: mei_csi mei_ace");
> +MODULE_DESCRIPTION("IVSC interface");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IVSC);
> diff --git a/include/linux/ivsc.h b/include/linux/ivsc.h
> index 6572ca4f340c..bc9006cd6efc 100644
> --- a/include/linux/ivsc.h
> +++ b/include/linux/ivsc.h
> @@ -16,4 +16,59 @@ enum ivsc_privacy_status {
>  	IVSC_PRIVACY_MAX,
>  };
>  
> +#if IS_ENABLED(CONFIG_INTEL_VSC)
> +/*
> + * @brief Acquire camera sensor ownership to host and setup
> + * the CSI-2 link between host and IVSC
> + *
> + * IVSC provides a privacy mode. When the privacy mode is turned
> + * on, camera sensor can't be used. This means that both IVSC and
> + * host Image Processing Unit(IPU) can't get image data. And when
> + * this mode is turned on, host Image Processing Unit(IPU) driver
> + * is informed via the registered callback, so that user can be
> + * notified.
> + *
> + * @param nr_of_lanes Number of data lanes used on the CSI-2 link
> + * @param link_freq Frequency of the CSI-2 link
> + * @param callback The pointer of privacy callback function
> + * @param context Privacy callback function runtime context
> + *
> + * @retval 0 If success
> + * @retval -EIO IO error
> + * @retval -EINVAL Invalid argument
> + * @retval -EAGAIN IVSC device not ready
> + * @retval negative values for other errors
> + */
> +int ivsc_acquire_camera(u32 nr_of_lanes, u64 link_freq,
> +			void (*callback)(void *, enum ivsc_privacy_status),
> +			void *context);
> +
> +/*
> + * @brief Release camera sensor ownership and stop the CSI-2
> + * link between host and IVSC
> + *
> + * @retval 0 If success
> + * @retval -EIO IO error
> + * @retval -EINVAL Invalid argument
> + * @retval -EAGAIN IVSC device not ready
> + * @retval negative values for other errors
> + */
> +int ivsc_release_camera(void);
> +
> +#else
> +static inline
> +int ivsc_acquire_camera(u32 nr_of_lanes, u64 link_freq,
> +			void (*callback)(void *, enum ivsc_privacy_status),
> +			void *context)
> +{
> +	return 0;
> +}
> +
> +static inline int ivsc_release_camera(void)
> +{
> +	return 0;
> +}
> +
> +#endif
> +
>  #endif

-- 
Kind regards,

Sakari Ailus
