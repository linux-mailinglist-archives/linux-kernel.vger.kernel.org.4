Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875B36A640D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCAAJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCAAJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:09:11 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD1836FF2;
        Tue, 28 Feb 2023 16:09:09 -0800 (PST)
Received: from pendragon.ideasonboard.com (153.162-64-87.adsl-dyn.isp.belgacom.be [87.64.162.153])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C3D2B890;
        Wed,  1 Mar 2023 01:09:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1677629347;
        bh=MBzbbWDrrkAxbUuaD2TGOQxtyNYWc0ZUOtxTEcjAoYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oLl/Bxh3SfaCn+021Zy2dGu+1TgHIqRm3DyszRxlMqaP21bEZEK4oa4e/uPCRgAGW
         Eg4KGegTWxyHJuAm0sAw/nKdGvGETiB8ClSrMyeET7Ik+j59xu9za3usYPKn8CUDkE
         Jo45c2oFK1ekpdcvEtpViyNbPe7rArqGMim41MGs=
Date:   Wed, 1 Mar 2023 02:09:03 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Wu, Wentong" <wentong.wu@intel.com>,
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
Message-ID: <Y/6Xn9Uvy7+MhqSd@pendragon.ideasonboard.com>
References: <20230213022347.2480307-4-wentong.wu@intel.com>
 <Y+uxbQi7seGf+adP@kekkonen.localdomain>
 <0457831e-a347-8278-01fe-52c011759d90@redhat.com>
 <Y+ypwnRVwReIEjUo@pendragon.ideasonboard.com>
 <DM6PR11MB43166A8D4225C8460C29803B8DA19@DM6PR11MB4316.namprd11.prod.outlook.com>
 <Y+9iwMbW0kk6eJKe@pendragon.ideasonboard.com>
 <DM6PR11MB4316A36ACA077501B92C1D0E8DA49@DM6PR11MB4316.namprd11.prod.outlook.com>
 <Y/MxGRrKsgVat3zZ@kekkonen.localdomain>
 <DM6PR11MB4316B3105394F258D8205DBC8DA49@DM6PR11MB4316.namprd11.prod.outlook.com>
 <dfa64234-ddac-d88a-3127-a18da145bdf0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfa64234-ddac-d88a-3127-a18da145bdf0@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 10:03:08AM +0100, Hans de Goede wrote:
> On 2/20/23 09:57, Wu, Wentong wrote:
> >> -----Original Message-----
> >> From: Sakari Ailus <sakari.ailus@linux.intel.com>
> >> Sent: Monday, February 20, 2023 4:37 PM
> >>
> >> Hi Wentong,
> >>
> >> On Mon, Feb 20, 2023 at 03:50:55AM +0000, Wu, Wentong wrote:
> >>>> -----Original Message-----
> >>>> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>> Sent: Friday, February 17, 2023 7:19 PM
> >>>>
> >>>> Hi Wentong,
> >>>>
> >>>> On Fri, Feb 17, 2023 at 06:10:22AM +0000, Wu, Wentong wrote:
> >>>>> On Sent: Wednesday, February 15, 2023 5:46 PM, Laurent Pinchart wrote:
> >>>>>> On Wed, Feb 15, 2023 at 10:03:29AM +0100, Hans de Goede wrote:
> >>>>>>> On 2/14/23 17:06, Sakari Ailus wrote:
> >>>>>>>> On Mon, Feb 13, 2023 at 10:23:47AM +0800, Wentong Wu wrote:
> >>>>>>>>> IVSC directly connects to camera sensor on source side, and
> >>>>>>>>> on output side it not only connects ISH via I2C, but also
> >>>>>>>>> exposes MIPI
> >>>>>>>>> CSI-2 interface to output camera sensor data. IVSC can use
> >>>>>>>>> the camera sensor data to do AI algorithm, and send the results to ISH.
> >>>>>>>>> On the other end, IVSC can share camera sensor to host by
> >>>>>>>>> routing the raw camera sensor data to the exposed MIPI
> >>>>>>>>> CSI-2 interface. But they can not work at the same time, so
> >>>>>>>>> software APIs are defined to sync the ownership.
> >>>>>>>>>
> >>>>>>>>> This commit defines the interfaces between IVSC and camera
> >>>>>>>>> sensor driver in include/linux/ivsc.h. The camera driver
> >>>>>>>>> controls ownership of the CSI-2 link and sensor with the
> >>>>>>>>> acquire/release APIs. When acquiring camera, lane number
> >>>>>>>>> and link freq are also required by IVSC frame router.
> >>>>>>>>
> >>>>>>>> The more I learn about this system, the more I'm inclined to
> >>>>>>>> think this functionality should be exposed as a V4L2 sub-device.
> >>>>>>>> IVSC doesn't really do anything to the data (as long as it
> >>>>>>>> directs it towards the CSI-2 receiver in the SoC), but it is
> >>>>>>>> definitely part of the image pipeline.
> >>>>>>>
> >>>>>>> Yes I happened to discuss this exact same thing with Laurent
> >>>>>>> at FOSDEM and we also came to the conclusion that the IVSC
> >>>>>>> chip should be modeled as a V4L2 sub-device.
> >>>>>>
> >>>>>> Agreed.
> >>>>>
> >>>>> Thanks for your quick review and conclusion, I'm fresh to media
> >>>>> sub-system, is there any convention that I should follow to
> >>>>> upstream this kind of v4l2 sub-device driver so that not too much
> >>>>> back and forth?
> >>>>
> >>>> This is a tentative proposal, as I'm not very familiar with the
> >>>> hardware
> >>>> architecture:
> >>>>
> >>>> - The subdev should have two pads, a sink pad connected to the camera
> >>>>   sensor, and a source pad connected to the CSI-2 receiver in the IPU.
> >>>>
> >>>> - As for any new driver, the subdev driver should use the active state
> >>>>   managed by the v4l2-subdev core. This requires calling
> >>>>   v4l2_subdev_init_finalize() at probe time. See
> >>>>   https://git.linuxtv.org/media_tree.git/commit/?id=a2514b9a634a for an
> >>>>   example of a subdev driver converted to this mechanism.
> >>>>
> >>>> - As we're talking about CSI-2, the subdev driver should use the streams
> >>>>   API that was recently merged, and in particular support the
> >>>>   .get_frame_desc(), .set_routing(), .enable_streams() and
> >>>>   .disable_streams() operations.
> >>>>
> >>>> - I don't see a need to support V4L2 controls in the subdev driver, but
> >>>>   I may be missing something.
> >>>>
> >>>> - The driver should be validated with v4l2-compliance, part of
> >>>>   v4l-utils.
> >>>>
> >>>
> >>> Thanks for the detail, but I have one more question, during probe of
> >>> sensor(v4l2-sudev) driver, it will configure camera sensor connected
> >>> to IVSC via I2C, but before that it should acquire camera sensor's
> >>> ownership from IVSC, how v4l2 framework guarantee this?
> >>
> >> Please wrap the lines at 74 characters or so when replying.
> > 
> > Thanks, I will.
> > 
> >> Do you mean accessing the sensor via I²C also requires acquiring the sensor
> >> from IVSC?
> > 
> > Yes
> 
> Hmm, that is going to be a problem since  we really want to have
> independent driver for the 2 which are not aware of each other.
> 
> I think that maybe we can model this part of the ivsc functionality
> as an i2c-mux. But then we will need to somehow change the parent
> of the i2c device for the sensor to the output of this mux ...
> 
> I guess this means adding some code (some hack likely) to
> drivers/platform/x86/intel/int3472/discrete.c which' proe function 
> is already guaranteed to run before the sensor's i2c-client gets
> instantiated, because of the ACPI _DEP on the INT3472 ACPI device
> in the DSDT.
> 
> This is going to be a tricky problem to tackle.

From a framework point of view I would also recommend i2c-mux, but when
it comes to the ACPI integration... I can feel your pain and I'm sorry
about that :-(

-- 
Regards,

Laurent Pinchart
