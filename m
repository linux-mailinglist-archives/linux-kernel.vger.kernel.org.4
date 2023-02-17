Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F45869AA32
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjBQLTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjBQLTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:19:34 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E2816AE2;
        Fri, 17 Feb 2023 03:19:32 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DE0E32D8;
        Fri, 17 Feb 2023 12:19:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1676632770;
        bh=PvT62c8I4s3eL7qSkxcqUk7u2C/GILqs28vFdJJm2ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rp3ICJuExXrGLHJxHgzBA49qPrlbMqqFnWZVuElnDLYlgUvmxYLJI2PKdkGJOX7Il
         qrx2cMfplkP7+J40jH0vjdtkLj1etMKGKdYMEsNrxWLzE7z0sXaBqR3o2IJNjKiuCe
         aW/HMlasjDsxwRACdUW+SPfRFnaYehDNMjzkTmlI=
Date:   Fri, 17 Feb 2023 13:19:28 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Wu, Wentong" <wentong.wu@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "Ye, Xiang" <xiang.ye@intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] media: pci: intel: ivsc: Add acquire/release API
 for ivsc
Message-ID: <Y+9iwMbW0kk6eJKe@pendragon.ideasonboard.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <20230213022347.2480307-4-wentong.wu@intel.com>
 <Y+uxbQi7seGf+adP@kekkonen.localdomain>
 <0457831e-a347-8278-01fe-52c011759d90@redhat.com>
 <Y+ypwnRVwReIEjUo@pendragon.ideasonboard.com>
 <DM6PR11MB43166A8D4225C8460C29803B8DA19@DM6PR11MB4316.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR11MB43166A8D4225C8460C29803B8DA19@DM6PR11MB4316.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wentong,

On Fri, Feb 17, 2023 at 06:10:22AM +0000, Wu, Wentong wrote:
> On Sent: Wednesday, February 15, 2023 5:46 PM, Laurent Pinchart wrote:
> > On Wed, Feb 15, 2023 at 10:03:29AM +0100, Hans de Goede wrote:
> > > On 2/14/23 17:06, Sakari Ailus wrote:
> > > > On Mon, Feb 13, 2023 at 10:23:47AM +0800, Wentong Wu wrote:
> > > >> IVSC directly connects to camera sensor on source side, and on
> > > >> output side it not only connects ISH via I2C, but also exposes MIPI
> > > >> CSI-2 interface to output camera sensor data. IVSC can use the
> > > >> camera sensor data to do AI algorithm, and send the results to ISH.
> > > >> On the other end, IVSC can share camera sensor to host by routing
> > > >> the raw camera sensor data to the exposed MIPI CSI-2 interface. But
> > > >> they can not work at the same time, so software APIs are defined to
> > > >> sync the ownership.
> > > >>
> > > >> This commit defines the interfaces between IVSC and camera sensor
> > > >> driver in include/linux/ivsc.h. The camera driver controls
> > > >> ownership of the CSI-2 link and sensor with the acquire/release
> > > >> APIs. When acquiring camera, lane number and link freq are also
> > > >> required by IVSC frame router.
> > > >
> > > > The more I learn about this system, the more I'm inclined to think
> > > > this functionality should be exposed as a V4L2 sub-device. IVSC
> > > > doesn't really do anything to the data (as long as it directs it
> > > > towards the CSI-2 receiver in the SoC), but it is definitely
> > > > part of the image pipeline.
> > >
> > > Yes I happened to discuss this exact same thing with Laurent at FOSDEM
> > > and we also came to the conclusion that the IVSC chip should be
> > > modeled as a V4L2 sub-device.
> > 
> > Agreed.
> 
> Thanks for your quick review and conclusion, I'm fresh to media
> sub-system, is there any convention that I should follow to upstream
> this kind of v4l2 sub-device driver so that not too much back and
> forth?

This is a tentative proposal, as I'm not very familiar with the hardware
architecture:

- The subdev should have two pads, a sink pad connected to the camera
  sensor, and a source pad connected to the CSI-2 receiver in the IPU.

- As for any new driver, the subdev driver should use the active state
  managed by the v4l2-subdev core. This requires calling
  v4l2_subdev_init_finalize() at probe time. See
  https://git.linuxtv.org/media_tree.git/commit/?id=a2514b9a634a for an
  example of a subdev driver converted to this mechanism.

- As we're talking about CSI-2, the subdev driver should use the streams
  API that was recently merged, and in particular support the
  .get_frame_desc(), .set_routing(), .enable_streams() and
  .disable_streams() operations.

- I don't see a need to support V4L2 controls in the subdev driver, but
  I may be missing something.

- The driver should be validated with v4l2-compliance, part of
  v4l-utils.

> > > > I suppose the intended use cases assume a single instance of IVSC
> > > > (as well as MEI) but there can, and often are, be multiple camera
> > > > sensors in the system. The decision whether to request pass-through
> > > > from IVCS can't be done in the camera sensor driver, and should not
> > > > be visible to the camera sensor driver. Exposing IVSC as a V4L2
> > > > sub-device makes this trivial to address, as the IVSC driver's V4L2
> > > > sub-device video s_stream() operation gets called before streaming is started.
> > > >
> > > > The information whether IVSC is found between the camera sensor and
> > > > the host's CSI-2 receiver (IPU in this case) should come from system
> > > > firmware and accessed most probably by what is called cio2-bridge at
> > > > the moment.
> > > >
> > > > The privacy status can be a V4L2 control.
> > > >
> > > > Also cc Hans.
> > > >
> > > >> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> > > >> ---
> > > >>  drivers/media/pci/intel/ivsc/Makefile |  1 +
> > > >>  drivers/media/pci/intel/ivsc/ivsc.c   | 84 +++++++++++++++++++++++++++
> > > >>  include/linux/ivsc.h                  | 55 ++++++++++++++++++
> > > >>  3 files changed, 140 insertions(+)  create mode 100644
> > > >> drivers/media/pci/intel/ivsc/ivsc.c

[snip]

-- 
Regards,

Laurent Pinchart
