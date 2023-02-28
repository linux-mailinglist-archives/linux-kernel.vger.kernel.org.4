Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6476A5453
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjB1IXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjB1IXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:23:41 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5D4C679;
        Tue, 28 Feb 2023 00:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677572620; x=1709108620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1DJvCDeMigg+spVqqPvrDVHVTHo7+Gu7nzVH6GcvuPQ=;
  b=V3wNFiAaIdGTp+J6StsSd+Yv+oJT0cZ/CJZMIf4DDVBKop2czNEUQVBz
   S3w+T39y8rCs+Mqopqs1GLcu1+0OkDO1Rae03thlTeunBB1w/XRvdrWzi
   3zAsvUxQk1pnfoy2tHJhWT2P9LfZH73D40RJDxX2uje5NQRaznfLjBpor
   8mT37AZAVBoiganSABZPpvX2woEWnjypl0Z3LNhf+qT8kM5vGLpuFyExZ
   pYTWfM0hr5eMUfXH9IHRaJ9s16pR8L284kmTHkKZaiI1TaduNZQL0TT6c
   LJok2dobQJqnAKjmWWszj8R/fsdUeY/x1ox275W0D+crzWD07A2xl6twM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313754619"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="313754619"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 00:23:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="742892251"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="742892251"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 00:23:37 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 91CE41207EA;
        Tue, 28 Feb 2023 10:23:34 +0200 (EET)
Date:   Tue, 28 Feb 2023 10:23:34 +0200
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
Message-ID: <Y/26BpJ15rpSAypW@kekkonen.localdomain>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <20230213022347.2480307-4-wentong.wu@intel.com>
 <Y+uxbQi7seGf+adP@kekkonen.localdomain>
 <DM6PR11MB43169FAE93274F64AA7E06F28DAC9@DM6PR11MB4316.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB43169FAE93274F64AA7E06F28DAC9@DM6PR11MB4316.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wentong,

On Tue, Feb 28, 2023 at 06:35:41AM +0000, Wu, Wentong wrote:
> Hi Sakari,
> 
> few questions as switching to v4l2 sub-dev framework.
> 
> > -----Original Message-----
> > From: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Sent: Wednesday, February 15, 2023 12:06 AM
> > 
> > Hi Wentong,
> > 
> > Thanks for the patchset.
> > 
> > On Mon, Feb 13, 2023 at 10:23:47AM +0800, Wentong Wu wrote:
> > > IVSC directly connects to camera sensor on source side, and on output
> > > side it not only connects ISH via I2C, but also exposes MIPI CSI-2
> > > interface to output camera sensor data. IVSC can use the camera sensor
> > > data to do AI algorithm, and send the results to ISH. On the other
> > > end, IVSC can share camera sensor to host by routing the raw camera
> > > sensor data to the exposed MIPI CSI-2 interface. But they can not work
> > > at the same time, so software APIs are defined to sync the ownership.
> > >
> > > This commit defines the interfaces between IVSC and camera sensor
> > > driver in include/linux/ivsc.h. The camera driver controls ownership
> > > of the CSI-2 link and sensor with the acquire/release APIs. When
> > > acquiring camera, lane number and link freq are also required by IVSC
> > > frame router.
> > 
> > The more I learn about this system, the more I'm inclined to think this
> > functionality should be exposed as a V4L2 sub-device. IVSC doesn't really do
> > anything to the data (as long as it directs it towards the CSI-2 receiver in the
> > SoC), but it is definitely part of the image pipeline.
> > 
> > I suppose the intended use cases assume a single instance of IVSC (as well as
> > MEI) but there can, and often are, be multiple camera sensors in the system. The
> > decision whether to request pass-through from IVCS can't be done in the camera
> > sensor driver, and should not be visible to the camera sensor driver. Exposing
> > IVSC as a V4L2 sub-device makes this trivial to address, as the IVSC driver's V4L2
> > sub-device video s_stream() operation gets called before streaming is started.
> > 
> > The information whether IVSC is found between the camera sensor and the
> > host's CSI-2 receiver (IPU in this case) should come from system firmware and
> > accessed most probably by what is called cio2-bridge at the moment.
> > 
> > The privacy status can be a V4L2 control.
> 
> This should be a control or event? If control, how user-space handle
> privacy stuff?

Changing control events generates events for the user space.

<URL:https://hverkuil.home.xs4all.nl/spec/userspace-api/v4l/dev-event.html>

> 
> For the required link freq and lane number, is v4l2 control the correct
> way to configure them? If yes, seems there is no CID value for them so
> that we should custom some CID value(link freqm, lane number, and
> privacy) for ivsc in linux/v4l2-controls.h, is this acceptable?

You should obtain these using the V4L2 fwnode interface. Please see e.g.
drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c how that driver
registers a V4L2 async sub-device and a V4L2 async notifier.

-- 
Kind regards,

Sakari Ailus
