Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1693769C6DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjBTIhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjBTIhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:37:19 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FE92D69;
        Mon, 20 Feb 2023 00:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676882238; x=1708418238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jxtDfmPIeTjZeqawHLLxOC4dAYSn0w1qazsf43PNwgg=;
  b=W41hQueJoGLWF1iAE8mB+lNJjcplhuzSDZFxiHGKCUiH4FSCLjckRQ8H
   LKvDviDKzMzb/CymRMS0NUfIXXFdEjIRGWvPhyR0nphz5cUs68erh6/9z
   j0eeWlX1FUbpK+5KO0rZr9iR9mnVdsYXuFU8N/vRlSlST7StxK1speQp1
   7i+XTPrJoyboK/tFHzb1Sq4DDRYtxOEuXTY1YHTcERQZglK745LEyyId4
   Jx4ejeDWzdRFf5N+cg2ORxXCUeqrBu+gmXL6lcTztkD3i6AgAlq43O6Fs
   EX++NcWrtgI5MVImhZW6OdDJxqYpOqU5Z/idbwN95hmcP4BZ+iGhacd5p
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="312719642"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="312719642"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 00:37:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="814057181"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="814057181"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 00:36:44 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id AA14E11F7FD;
        Mon, 20 Feb 2023 10:36:41 +0200 (EET)
Date:   Mon, 20 Feb 2023 10:36:41 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Wu, Wentong" <wentong.wu@intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>,
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
Message-ID: <Y/MxGRrKsgVat3zZ@kekkonen.localdomain>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <20230213022347.2480307-4-wentong.wu@intel.com>
 <Y+uxbQi7seGf+adP@kekkonen.localdomain>
 <0457831e-a347-8278-01fe-52c011759d90@redhat.com>
 <Y+ypwnRVwReIEjUo@pendragon.ideasonboard.com>
 <DM6PR11MB43166A8D4225C8460C29803B8DA19@DM6PR11MB4316.namprd11.prod.outlook.com>
 <Y+9iwMbW0kk6eJKe@pendragon.ideasonboard.com>
 <DM6PR11MB4316A36ACA077501B92C1D0E8DA49@DM6PR11MB4316.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR11MB4316A36ACA077501B92C1D0E8DA49@DM6PR11MB4316.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wentong,

On Mon, Feb 20, 2023 at 03:50:55AM +0000, Wu, Wentong wrote:
> 
> 
> > -----Original Message-----
> > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Sent: Friday, February 17, 2023 7:19 PM
> > 
> > Hi Wentong,
> > 
> > On Fri, Feb 17, 2023 at 06:10:22AM +0000, Wu, Wentong wrote:
> > > On Sent: Wednesday, February 15, 2023 5:46 PM, Laurent Pinchart wrote:
> > > > On Wed, Feb 15, 2023 at 10:03:29AM +0100, Hans de Goede wrote:
> > > > > On 2/14/23 17:06, Sakari Ailus wrote:
> > > > > > On Mon, Feb 13, 2023 at 10:23:47AM +0800, Wentong Wu wrote:
> > > > > >> IVSC directly connects to camera sensor on source side, and on
> > > > > >> output side it not only connects ISH via I2C, but also exposes
> > > > > >> MIPI
> > > > > >> CSI-2 interface to output camera sensor data. IVSC can use the
> > > > > >> camera sensor data to do AI algorithm, and send the results to ISH.
> > > > > >> On the other end, IVSC can share camera sensor to host by
> > > > > >> routing the raw camera sensor data to the exposed MIPI CSI-2
> > > > > >> interface. But they can not work at the same time, so software
> > > > > >> APIs are defined to sync the ownership.
> > > > > >>
> > > > > >> This commit defines the interfaces between IVSC and camera
> > > > > >> sensor driver in include/linux/ivsc.h. The camera driver
> > > > > >> controls ownership of the CSI-2 link and sensor with the
> > > > > >> acquire/release APIs. When acquiring camera, lane number and
> > > > > >> link freq are also required by IVSC frame router.
> > > > > >
> > > > > > The more I learn about this system, the more I'm inclined to
> > > > > > think this functionality should be exposed as a V4L2 sub-device.
> > > > > > IVSC doesn't really do anything to the data (as long as it
> > > > > > directs it towards the CSI-2 receiver in the SoC), but it is
> > > > > > definitely part of the image pipeline.
> > > > >
> > > > > Yes I happened to discuss this exact same thing with Laurent at
> > > > > FOSDEM and we also came to the conclusion that the IVSC chip
> > > > > should be modeled as a V4L2 sub-device.
> > > >
> > > > Agreed.
> > >
> > > Thanks for your quick review and conclusion, I'm fresh to media
> > > sub-system, is there any convention that I should follow to upstream
> > > this kind of v4l2 sub-device driver so that not too much back and
> > > forth?
> > 
> > This is a tentative proposal, as I'm not very familiar with the hardware
> > architecture:
> > 
> > - The subdev should have two pads, a sink pad connected to the camera
> >   sensor, and a source pad connected to the CSI-2 receiver in the IPU.
> > 
> > - As for any new driver, the subdev driver should use the active state
> >   managed by the v4l2-subdev core. This requires calling
> >   v4l2_subdev_init_finalize() at probe time. See
> >   https://git.linuxtv.org/media_tree.git/commit/?id=a2514b9a634a for an
> >   example of a subdev driver converted to this mechanism.
> > 
> > - As we're talking about CSI-2, the subdev driver should use the streams
> >   API that was recently merged, and in particular support the
> >   .get_frame_desc(), .set_routing(), .enable_streams() and
> >   .disable_streams() operations.
> > 
> > - I don't see a need to support V4L2 controls in the subdev driver, but
> >   I may be missing something.
> > 
> > - The driver should be validated with v4l2-compliance, part of
> >   v4l-utils.
> > 
> 
> Thanks for the detail, but I have one more question, during probe of
> sensor(v4l2-sudev) driver, it will configure camera sensor connected to
> IVSC via I2C, but before that it should acquire camera sensor's ownership
> from IVSC, how v4l2 framework guarantee this?

Please wrap the lines at 74 characters or so when replying.

Do you mean accessing the sensor via I²C also requires acquiring the sensor
from IVSC?

-- 
Regards,

Sakari Ailus
