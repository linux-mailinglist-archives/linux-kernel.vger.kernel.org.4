Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865656A6B70
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjCALLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjCALLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:11:21 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D390F3B85E;
        Wed,  1 Mar 2023 03:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677669077; x=1709205077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wn5o+3fWtlmjWmb55KDnTMeVNUIXS3rz1+lL5QLzzGs=;
  b=kxaiq6XcUffQFPHwUpwPC+q0jl7SiyZxy8v7KDWXbVNrlQ3YioMLJU91
   YSu+tFt4m5mMbxrorJokO+gSUtxuQpuIwqO7yt2EV/ls7uwNn6XdQSkjH
   jOQ2kPU/Z6b+LqXrttKChUGO4QueR2OplSKAYjOv856LSKazILWs15KMv
   41ZO9nJyqsnADKZdARacslFVH45vlmYSAz79hyNw9D+ADSM7IE0z9ry6s
   yIxMmuj1Ask0b7H2HBLuVgwXi80KqjMh63iT9EjWTtReNY9atWaDw0atb
   QGasQFjKJS1r4r3CNUM8R183VeJL5Oaj4A7+GMO0WjWQ4QnoTukHoyKLC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="333109152"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="333109152"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 03:11:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="784297095"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="784297095"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 03:11:14 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 3A35312230C;
        Wed,  1 Mar 2023 13:11:12 +0200 (EET)
Date:   Wed, 1 Mar 2023 13:11:12 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Wu, Wentong" <wentong.wu@intel.com>
Cc:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "Ye, Xiang" <xiang.ye@intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 3/3] media: pci: intel: ivsc: Add acquire/release API
 for ivsc
Message-ID: <Y/8y0KKZP/7qGvzM@kekkonen.localdomain>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <20230213022347.2480307-4-wentong.wu@intel.com>
 <Y+uxbQi7seGf+adP@kekkonen.localdomain>
 <DM6PR11MB43169FAE93274F64AA7E06F28DAC9@DM6PR11MB4316.namprd11.prod.outlook.com>
 <Y/26BpJ15rpSAypW@kekkonen.localdomain>
 <DM6PR11MB43167D398FE7F280C54140B28DAD9@DM6PR11MB4316.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB43167D398FE7F280C54140B28DAD9@DM6PR11MB4316.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wentong,

On Wed, Mar 01, 2023 at 07:26:40AM +0000, Wu, Wentong wrote:
> 
> 
> > -----Original Message-----
> > From: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Sent: Tuesday, February 28, 2023 4:24 PM
> > 
> > Hi Wentong,
> > 
> > On Tue, Feb 28, 2023 at 06:35:41AM +0000, Wu, Wentong wrote:
> > > Hi Sakari,
> > >
> > > few questions as switching to v4l2 sub-dev framework.
> > >
> > > > -----Original Message-----
> > > > From: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > Sent: Wednesday, February 15, 2023 12:06 AM
> > > >
> > > > Hi Wentong,
> > > >
> > > > Thanks for the patchset.
> > > >
> > > > On Mon, Feb 13, 2023 at 10:23:47AM +0800, Wentong Wu wrote:
> > > > > IVSC directly connects to camera sensor on source side, and on
> > > > > output side it not only connects ISH via I2C, but also exposes
> > > > > MIPI CSI-2 interface to output camera sensor data. IVSC can use
> > > > > the camera sensor data to do AI algorithm, and send the results to
> > > > > ISH. On the other end, IVSC can share camera sensor to host by
> > > > > routing the raw camera sensor data to the exposed MIPI CSI-2
> > > > > interface. But they can not work at the same time, so software APIs are
> > defined to sync the ownership.
> > > > >
> > > > > This commit defines the interfaces between IVSC and camera sensor
> > > > > driver in include/linux/ivsc.h. The camera driver controls
> > > > > ownership of the CSI-2 link and sensor with the acquire/release
> > > > > APIs. When acquiring camera, lane number and link freq are also
> > > > > required by IVSC frame router.
> > > >
> > > > The more I learn about this system, the more I'm inclined to think
> > > > this functionality should be exposed as a V4L2 sub-device. IVSC
> > > > doesn't really do anything to the data (as long as it directs it
> > > > towards the CSI-2 receiver in the SoC), but it is definitely part of the image
> > pipeline.
> > > >
> > > > I suppose the intended use cases assume a single instance of IVSC
> > > > (as well as
> > > > MEI) but there can, and often are, be multiple camera sensors in the
> > > > system. The decision whether to request pass-through from IVCS can't
> > > > be done in the camera sensor driver, and should not be visible to
> > > > the camera sensor driver. Exposing IVSC as a V4L2 sub-device makes
> > > > this trivial to address, as the IVSC driver's V4L2 sub-device video s_stream()
> > operation gets called before streaming is started.
> > > >
> > > > The information whether IVSC is found between the camera sensor and
> > > > the host's CSI-2 receiver (IPU in this case) should come from system
> > > > firmware and accessed most probably by what is called cio2-bridge at the
> > moment.
> > > >
> > > > The privacy status can be a V4L2 control.
> > >
> > > This should be a control or event? If control, how user-space handle
> > > privacy stuff?
> > 
> > Changing control events generates events for the user space.
> > 
> > <URL:https://hverkuil.home.xs4all.nl/spec/userspace-api/v4l/dev-event.html>
> 
> Ok, V4L2_EVENT_CTRL event which reports 'struct v4l2_event_ctrl' data to user space
> 
> > 
> > >
> > > For the required link freq and lane number, is v4l2 control the
> > > correct way to configure them? If yes, seems there is no CID value for
> > > them so that we should custom some CID value(link freqm, lane number,
> > > and
> > > privacy) for ivsc in linux/v4l2-controls.h, is this acceptable?
> > 
> > You should obtain these using the V4L2 fwnode interface. Please see e.g.
> > drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c how that driver registers
> > a V4L2 async sub-device and a V4L2 async notifier.
> 
> Ok, something like v4l2_ctrl_find(source->ctrl_handler,
> V4L2_CID_LINK_FREQ); is to get sensor's link frequency, and the code like
> 'v4l2_subdev_call(source, pad, get_mbus_config, source, &mbus_config);
> num_of_lanes = mbus_config.bus.mipi_csi2.num_data_lanes;' is to get
> sensor's lane number.

Please use the V4L2 fwnode interface instead.

The privacy control should only be needed in the user space.

-- 
Regards,

Sakari Ailus
