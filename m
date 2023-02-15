Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5634869793E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjBOJqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbjBOJpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:45:44 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E194B34C1B;
        Wed, 15 Feb 2023 01:45:40 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 03CBE27C;
        Wed, 15 Feb 2023 10:45:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1676454339;
        bh=nKWV/IHNpYSvJuFJ2X8BWY3xl0gRUWKQlAvz0+npfhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=coueEq9E4cU+0s5+5czKAf1Glloz8W3uZO2t2Nsty3Qmmx8CtHRfeBGeUMD8z4mIN
         4ByDT0uuLRgujVBazAvdms2qItIgT3u23wp/JAFYNxdtRE1PAx1xKl0ip7ZTbx5ijf
         wrgsKetsq43fVY79X8ngLO77nIhzs09HNB3QX8Ms=
Date:   Wed, 15 Feb 2023 11:45:38 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Wentong Wu <wentong.wu@intel.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, srinivas.pandruvada@intel.com,
        pierre-louis.bossart@linux.intel.com, zhifeng.wang@intel.com,
        xiang.ye@intel.com, tian.shu.qiu@intel.com, bingbu.cao@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] media: pci: intel: ivsc: Add acquire/release API
 for ivsc
Message-ID: <Y+ypwnRVwReIEjUo@pendragon.ideasonboard.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <20230213022347.2480307-4-wentong.wu@intel.com>
 <Y+uxbQi7seGf+adP@kekkonen.localdomain>
 <0457831e-a347-8278-01fe-52c011759d90@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0457831e-a347-8278-01fe-52c011759d90@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 10:03:29AM +0100, Hans de Goede wrote:
> Hi Sakari,
> 
> On 2/14/23 17:06, Sakari Ailus wrote:
> > Hi Wentong,
> > 
> > Thanks for the patchset.
> > 
> > On Mon, Feb 13, 2023 at 10:23:47AM +0800, Wentong Wu wrote:
> >> IVSC directly connects to camera sensor on source side, and on
> >> output side it not only connects ISH via I2C, but also exposes
> >> MIPI CSI-2 interface to output camera sensor data. IVSC can use
> >> the camera sensor data to do AI algorithm, and send the results
> >> to ISH. On the other end, IVSC can share camera sensor to host
> >> by routing the raw camera sensor data to the exposed MIPI CSI-2
> >> interface. But they can not work at the same time, so software
> >> APIs are defined to sync the ownership.
> >>
> >> This commit defines the interfaces between IVSC and camera sensor
> >> driver in include/linux/ivsc.h. The camera driver controls
> >> ownership of the CSI-2 link and sensor with the acquire/release
> >> APIs. When acquiring camera, lane number and link freq are also
> >> required by IVSC frame router.
> > 
> > The more I learn about this system, the more I'm inclined to think this
> > functionality should be exposed as a V4L2 sub-device. IVSC doesn't really
> > do anything to the data (as long as it directs it towards the CSI-2
> > receiver in the SoC), but it is definitely part of the image pipeline.
> 
> Yes I happened to discuss this exact same thing with Laurent at FOSDEM
> and we also came to the conclusion that the IVSC chip should be modeled
> as a V4L2 sub-device.

Agreed.

> > I suppose the intended use cases assume a single instance of IVSC (as well
> > as MEI) but there can, and often are, be multiple camera sensors in the
> > system. The decision whether to request pass-through from IVCS can't be
> > done in the camera sensor driver, and should not be visible to the camera
> > sensor driver. Exposing IVSC as a V4L2 sub-device makes this trivial to
> > address, as the IVSC driver's V4L2 sub-device video s_stream() operation
> > gets called before streaming is started.
> > 
> > The information whether IVSC is found between the camera sensor and the
> > host's CSI-2 receiver (IPU in this case) should come from system firmware
> > and accessed most probably by what is called cio2-bridge at the moment.
> > 
> > The privacy status can be a V4L2 control.
> > 
> > Also cc Hans.
> > 
> >>
> >> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> >> ---
> >>  drivers/media/pci/intel/ivsc/Makefile |  1 +
> >>  drivers/media/pci/intel/ivsc/ivsc.c   | 84 +++++++++++++++++++++++++++
> >>  include/linux/ivsc.h                  | 55 ++++++++++++++++++
> >>  3 files changed, 140 insertions(+)
> >>  create mode 100644 drivers/media/pci/intel/ivsc/ivsc.c
> >>
> >> diff --git a/drivers/media/pci/intel/ivsc/Makefile b/drivers/media/pci/intel/ivsc/Makefile
> >> index de0a425c22c2..b8b6fc1083be 100644
> >> --- a/drivers/media/pci/intel/ivsc/Makefile
> >> +++ b/drivers/media/pci/intel/ivsc/Makefile
> >> @@ -4,3 +4,4 @@
> >>  
> >>  obj-$(CONFIG_INTEL_VSC) += mei_csi.o
> >>  obj-$(CONFIG_INTEL_VSC) += mei_ace.o
> >> +obj-$(CONFIG_INTEL_VSC) += ivsc.o
> >> diff --git a/drivers/media/pci/intel/ivsc/ivsc.c b/drivers/media/pci/intel/ivsc/ivsc.c
> >> new file mode 100644
> >> index 000000000000..12996b587639
> >> --- /dev/null
> >> +++ b/drivers/media/pci/intel/ivsc/ivsc.c
> >> @@ -0,0 +1,84 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (C) 2023 Intel Corporation. All rights reserved.
> >> + * Intel Visual Sensing Controller interface
> >> + */
> >> +
> >> +#include <linux/delay.h>
> >> +#include <linux/ivsc.h>
> >> +#include <linux/module.h>
> >> +#include <linux/mutex.h>
> >> +
> >> +#include "mei_ace.h"
> >> +#include "mei_csi.h"
> >> +
> >> +/* lock for ivsc APIs */
> >> +static DEFINE_MUTEX(ivsc_mutex);
> >> +
> >> +int ivsc_acquire_camera(u32 nr_of_lanes, u64 link_freq,
> >> +			void (*callback)(void *, enum ivsc_privacy_status),
> >> +			void *context)
> >> +{
> >> +	int ret;
> >> +
> >> +	mutex_lock(&ivsc_mutex);
> >> +
> >> +	/* switch camera sensor ownership to host */
> >> +	ret = ace_set_camera_owner(ACE_CAMERA_HOST);
> >> +	if (ret)
> >> +		goto error;
> >> +
> >> +	/* switch CSI-2 link to host */
> >> +	ret = csi_set_link_owner(CSI_LINK_HOST, callback, context);
> >> +	if (ret)
> >> +		goto release_camera;
> >> +
> >> +	/* configure CSI-2 link */
> >> +	ret = csi_set_link_cfg(nr_of_lanes, link_freq);
> >> +	if (ret)
> >> +		goto release_csi;
> >> +
> >> +	mutex_unlock(&ivsc_mutex);
> >> +
> >> +	return 0;
> >> +
> >> +release_csi:
> >> +	csi_set_link_owner(CSI_LINK_IVSC, NULL, NULL);
> >> +
> >> +release_camera:
> >> +	ace_set_camera_owner(ACE_CAMERA_IVSC);
> >> +
> >> +error:
> >> +	mutex_unlock(&ivsc_mutex);
> >> +
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(ivsc_acquire_camera);
> >> +
> >> +int ivsc_release_camera(void)
> >> +{
> >> +	int ret;
> >> +
> >> +	mutex_lock(&ivsc_mutex);
> >> +
> >> +	/* switch CSI-2 link to IVSC */
> >> +	ret = csi_set_link_owner(CSI_LINK_IVSC, NULL, NULL);
> >> +	if (ret)
> >> +		goto error;
> >> +
> >> +	/* switch camera sensor ownership to IVSC */
> >> +	ret = ace_set_camera_owner(ACE_CAMERA_IVSC);
> >> +
> >> +error:
> >> +	mutex_unlock(&ivsc_mutex);
> >> +
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(ivsc_release_camera);
> >> +
> >> +MODULE_AUTHOR("Wentong Wu <wentong.wu@intel.com>");
> >> +MODULE_AUTHOR("Zhifeng Wang <zhifeng.wang@intel.com>");
> >> +MODULE_SOFTDEP("pre: mei_csi mei_ace");
> >> +MODULE_DESCRIPTION("IVSC interface");
> >> +MODULE_LICENSE("GPL");
> >> +MODULE_IMPORT_NS(IVSC);
> >> diff --git a/include/linux/ivsc.h b/include/linux/ivsc.h
> >> index 6572ca4f340c..bc9006cd6efc 100644
> >> --- a/include/linux/ivsc.h
> >> +++ b/include/linux/ivsc.h
> >> @@ -16,4 +16,59 @@ enum ivsc_privacy_status {
> >>  	IVSC_PRIVACY_MAX,
> >>  };
> >>  
> >> +#if IS_ENABLED(CONFIG_INTEL_VSC)
> >> +/*
> >> + * @brief Acquire camera sensor ownership to host and setup
> >> + * the CSI-2 link between host and IVSC
> >> + *
> >> + * IVSC provides a privacy mode. When the privacy mode is turned
> >> + * on, camera sensor can't be used. This means that both IVSC and
> >> + * host Image Processing Unit(IPU) can't get image data. And when
> >> + * this mode is turned on, host Image Processing Unit(IPU) driver
> >> + * is informed via the registered callback, so that user can be
> >> + * notified.
> >> + *
> >> + * @param nr_of_lanes Number of data lanes used on the CSI-2 link
> >> + * @param link_freq Frequency of the CSI-2 link
> >> + * @param callback The pointer of privacy callback function
> >> + * @param context Privacy callback function runtime context
> >> + *
> >> + * @retval 0 If success
> >> + * @retval -EIO IO error
> >> + * @retval -EINVAL Invalid argument
> >> + * @retval -EAGAIN IVSC device not ready
> >> + * @retval negative values for other errors
> >> + */
> >> +int ivsc_acquire_camera(u32 nr_of_lanes, u64 link_freq,
> >> +			void (*callback)(void *, enum ivsc_privacy_status),
> >> +			void *context);
> >> +
> >> +/*
> >> + * @brief Release camera sensor ownership and stop the CSI-2
> >> + * link between host and IVSC
> >> + *
> >> + * @retval 0 If success
> >> + * @retval -EIO IO error
> >> + * @retval -EINVAL Invalid argument
> >> + * @retval -EAGAIN IVSC device not ready
> >> + * @retval negative values for other errors
> >> + */
> >> +int ivsc_release_camera(void);
> >> +
> >> +#else
> >> +static inline
> >> +int ivsc_acquire_camera(u32 nr_of_lanes, u64 link_freq,
> >> +			void (*callback)(void *, enum ivsc_privacy_status),
> >> +			void *context)
> >> +{
> >> +	return 0;
> >> +}
> >> +
> >> +static inline int ivsc_release_camera(void)
> >> +{
> >> +	return 0;
> >> +}
> >> +
> >> +#endif
> >> +
> >>  #endif

-- 
Regards,

Laurent Pinchart
