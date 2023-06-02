Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584B17205F4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbjFBPZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbjFBPZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:25:53 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C8FE4E;
        Fri,  2 Jun 2023 08:25:46 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126156168104.26.openmobile.ne.jp [126.156.168.104])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 884CD844;
        Fri,  2 Jun 2023 17:25:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685719522;
        bh=qxxf/d08ZqtGMHoK4SpD04QNfH/WTFybI3QFyM9eykE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2utsvl2PPql1S26cGr98mxyumTzYpnMf8fkfVhmQC1PL+7oJw3DjO0NKIVxMuTPE
         e0OwTdriIiArAmQZiIsZo0zBs2RQeg6kXpu6VDrXeBLHnzu4pq3d/4ZlkEwu7qNACz
         pSSxCP15nsCEwyX0cyLHJwc+g/DQCKpa7GvVlFf0=
Date:   Fri, 2 Jun 2023 18:25:43 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dmitry Perchanov <dmitry.perchanov@intel.com>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, sakari.ailus@intel.com,
        Evgeni Raikhel <evgeni.raikhel@intel.com>, demisrael@gmail.com,
        Nir Azkiel <nir.azkiel@intel.com>
Subject: Re: [PATCH v4] media: uapi: v4l: Intel metadata format update
Message-ID: <20230602152543.GJ26944@pendragon.ideasonboard.com>
References: <7e0e6a37eee28185ec2fbd4f1d42569c8da6726d.camel@intel.com>
 <944dd3c67fc7e9c1b8d6bd0491d61fdbb9489e70.camel@intel.com>
 <20230602144624.GA3343@pendragon.ideasonboard.com>
 <2eef3b075da7e91b938222a345e3f18f3765619f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2eef3b075da7e91b938222a345e3f18f3765619f.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Fri, Jun 02, 2023 at 06:00:04PM +0300, Dmitry Perchanov wrote:
> Hi Laurent,
> 
> Thanks for review!
> I will gladly accept your proposed changes.
> 
> Comments inline.
> 
> On Fri, 2023-06-02 at 17:46 +0300, Laurent Pinchart wrote:
> > On Thu, Jun 01, 2023 at 07:08:46PM +0300, Dmitry Perchanov wrote:
> > > Update metadata structure for Intel RealSense UVC/MIPI cameras.
> > > Compliant to Intel Configuration version 3.
> > > 
> > > Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
> > > ---
> > >  .../media/v4l/pixfmt-meta-d4xx.rst            | 52 ++++++++++++++++---
> > >  1 file changed, 46 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst b/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
> > > index 4e437ba97a0e..7482f298d0cc 100644
> > > --- a/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
> > > +++ b/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
> > > @@ -12,7 +12,7 @@ Intel D4xx UVC Cameras Metadata
> > >  Description
> > >  ===========
> > >  
> > > -Intel D4xx (D435 and other) cameras include per-frame metadata in their UVC
> > > +Intel D4xx (D435, D455 and others) cameras include per-frame metadata in their UVC
> > >  payload headers, following the Microsoft(R) UVC extension proposal [1_]. That
> > >  means, that the private D4XX metadata, following the standard UVC header, is
> > >  organised in blocks. D4XX cameras implement several standard block types,
> > > @@ -26,6 +26,8 @@ V4L2_META_FMT_UVC with the only difference, that it also includes proprietary
> > >  payload header data. D4xx cameras use bulk transfers and only send one payload
> > >  per frame, therefore their headers cannot be larger than 255 bytes.
> > >  
> > > +This document implements Intel Configuration version 3 [9_].
> > > +
> > >  Below are proprietary Microsoft style metadata types, used by D4xx cameras,
> > >  where all fields are in little endian order:
> > >  
> > > @@ -43,7 +45,7 @@ where all fields are in little endian order:
> > >      * - __u32 ID
> > >        - 0x80000000
> > >      * - __u32 Size
> > > -      - Size in bytes (currently 56)
> > > +      - Size in bytes, include ID (all protocol versions: 60)
> > >      * - __u32 Version
> > >        - Version of this structure. The documentation herein corresponds to
> > >          version xxx. The version number will be incremented when new fields are
> > 
> > Should this read "version 3" instead of "version xxx" ?
> 
> This can read 1, 2 or 3, depends on firmware version.
> All cameras have same firmware. The latest will report 3.

The sentence reads

"The documentation herein corresponds to version xxx."

As you're updating the documentation to correspond to version 3, I
thought it would be best to make that explicit. Another option would be

"The documentation herein covers versions 1, 2 and 3."

I think I like that better. What do you think ?

> > > @@ -72,13 +74,17 @@ where all fields are in little endian order:
> > >        - Bottom border of the AE Region of Interest
> > >      * - __u32 Preset
> > >        - Preset selector value, default: 0, unless changed by the user
> > > -    * - __u32 Laser mode
> > > -      - 0: off, 1: on
> > > +    * - __u8 Emitter mode (v3 only) (__u32 Laser mode for v1) [8_]
> > > +      - 0: off, 1: on, same as __u32 Laser mode for v1
> > > +    * - __u8 RFU byte (v3 only)
> > > +      - Spare byte for future use
> > > +    * - __u16 LED Power (v3 only)
> > > +      - Led power value 0-360 (F416 SKU)
> > >      * - :cspan:`1` *Capture Timing*
> > >      * - __u32 ID
> > >        - 0x80000001
> > >      * - __u32 Size
> > > -      - Size in bytes (currently 40)
> > > +      - Size in bytes, include ID (all protocol versions: 40)
> > >      * - __u32 Version
> > >        - Version of this structure. The documentation herein corresponds to
> > >          version xxx. The version number will be incremented when new fields are
> > > @@ -101,7 +107,7 @@ where all fields are in little endian order:
> > >      * - __u32 ID
> > >        - 0x80000002
> > >      * - __u32 Size
> > > -      - Size in bytes (currently 40)
> > > +      - Size in bytes, include ID (v1:36, v3:40)
> > >      * - __u32 Version
> > >        - Version of this structure. The documentation herein corresponds to
> > >          version xxx. The version number will be incremented when new fields are
> > > @@ -124,6 +130,14 @@ where all fields are in little endian order:
> > >        - Requested frame rate per second
> > >      * - __u16 Trigger
> > >        - Byte 0: bit 0: depth and RGB are synchronised, bit 1: external trigger
> > > +    * - __u16 Calibration count (v3 only)
> > > +      - Calibration counter, see [4_] below
> > > +    * - __u8 GPIO input data (v3 only)
> > > +      - GPIO readout, see [4_] below (Supported from FW 5.12.7.0)
> > > +    * - __u32 Sub-preset info (v3 only)
> > > +      - Sub-preset choice information, see [4_] below
> > > +    * - __u8 reserved (v3 only)
> > > +      - RFU byte.
> > >  
> > >  .. _1:
> > >  
> > > @@ -140,6 +154,8 @@ where all fields are in little endian order:
> > >    0x00000010 Exposure priority
> > >    0x00000020 AE ROI
> > >    0x00000040 Preset
> > > +  0x00000080 Emitter mode
> > > +  0x00000100 LED Power
> > >  
> > >  .. _3:
> > >  
> > > @@ -165,6 +181,8 @@ where all fields are in little endian order:
> > >    0x00000040 Framerate
> > >    0x00000080 Trigger
> > >    0x00000100 Cal count
> > > +  0x00000200 GPIO Input Data
> > > +  0x00000400 Sub-preset Info
> > >  
> > >  .. _5:
> > >  
> > > @@ -211,3 +229,25 @@ Left sensor: ::
> > >  Fish Eye sensor: ::
> > >  
> > >    1 RAW8
> > > +
> > > +.. _8:
> > > +
> > > +[8] The "Laser mode" is replaced by three different fields.
> > 
> > "... has been replaced in version 3 by ..."
> > 
> > > +"Laser" renamed to "Emitter" as there multiple technologies
> > 
> > s/there/there are/
> 
> Accepted. Thanks!
>
> > > +for camera projectors. As we have another field for "Laser Power"
> > > +we introduced "LED Power" for extra emitter.
> > > +
> > > +The __u32 "Laser mode" integer is divided by two bytes and short: ::
> > 
> > The "Laser mode" __u32 field has been split into: ::
>
> Accepted. Thanks!
> 
> > > +   1 __u8 Emitter mode
> > > +   2 __u8 RFU byte
> > > +   3 __u16 LED Power
> > > +
> > > +This is a change between versions 1 and 3. All versions 1,2 and 3
> > 
> > s/1,2/1, 2/
>
> Accepted. Thanks!
> 
> > > +are backward compatible with same data format and they are supported.
> > > +See [2_] for which attributes are valid.
> > > +
> > > +.. _9:
> > > +
> > > +[9]
> > > +LibRealSense SDK metadata source:
> > 
> > I'll remove the blank line after '[9]', that is
> > 
> > > +[9] LibRealSense SDK metadata source:
>
> Accepted. Thanks!
> 
> > I can fix all this when applying if you're fine with the changes.
>
> Yes, I agree. Thank You for your effort!
>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > > +https://github.com/IntelRealSense/librealsense/blob/master/src/metadata.h

-- 
Regards,

Laurent Pinchart
