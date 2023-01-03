Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936EA65C0DA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbjACNbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjACNbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:31:35 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5A3331;
        Tue,  3 Jan 2023 05:31:34 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D412B108;
        Tue,  3 Jan 2023 14:31:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672752692;
        bh=yNlGV98JYDrjz2RPMUriL/9rOq8JIcs4XzQg9P5ZBPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=INoUCiTVREZqqzX095qKwFp9WzPRhFsU8T/Qp6tzEogjdtsjm6VBOjN91Wn8keOIu
         CqIE7mUOxiBjomYfMpGEd6NZk5tj68pVIZA6DW6fSendxuJgbtRgtjUtnjNPf1vqd7
         WqhW5X2Rw6lQRJbMLcJweLBSxT6WSf/IBJDx4hz0=
Date:   Tue, 3 Jan 2023 15:31:28 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] media: v4l2-dev: sysfs: Support streaming attribute
Message-ID: <Y7QuMKi3ZdMDUwCw@pendragon.ideasonboard.com>
References: <20221223231736.2111774-1-kieran.bingham@ideasonboard.com>
 <Y6lu14VsuH1LbqFH@pendragon.ideasonboard.com>
 <yvFnaY1MM7I5C7H18aJdvQ6XEQn979YkGYpCjRLsnJvCRr2vYWVKorYqFXGxP3tWKeJ5B0oEA4Fn4W2-IqPd_N_wivEM4uKJD4WX53RiSmY=@protonmail.com>
 <Y7LYp01J5co9KSfJ@paasikivi.fi.intel.com>
 <Y7LdpQ9s7lS+x9mO@pendragon.ideasonboard.com>
 <167273840266.530483.6812185939521706359@Monstersaurus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <167273840266.530483.6812185939521706359@Monstersaurus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Tue, Jan 03, 2023 at 09:33:22AM +0000, Kieran Bingham wrote:
> Quoting Laurent Pinchart (2023-01-02 13:35:33)
> > On Mon, Jan 02, 2023 at 01:14:15PM +0000, Sakari Ailus wrote:
> > > On Wed, Dec 28, 2022 at 01:44:38AM +0000, Barnabás Pőcze wrote:
> > > > On 2022. december 26., hétfő 10:52, Laurent Pinchart wrote:
> > > > > On Fri, Dec 23, 2022 at 11:17:35PM +0000, Kieran Bingham wrote:
> > > > > 
> > > > > > Provide a streaming attribute to allow userspace to interogate if a device
> > > > > > is actively streaming or not.
> > > > > > 
> > > > > > This will allow desktop notifications to report if a camera or device
> > > > > > is active on the system, rather than just 'open' which can occur when
> > > > > > configuring the device.
> > > > > > 
> > > > > > Bug: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2669
> > > > > > Signed-off-by: Kieran Bingham kieran.bingham@ideasonboard.com
> > > > > > ---
> > > > > > 
> > > > > > This is a quick POC to see if such a facility makes sense.
> > > > > > I'm weary that not all video devices may have the queues registered on
> > > > > > the struct video_device, but this seems like an effective way to be able
> > > > > > to determine if a device is actively streaming on a system.
> > > > > 
> > > > > I can imagine multiple problems, from race conditions to permissions and
> > > > > privacy. In order to comment on the fitness of this solution to address
> > > > > the problem you're trying to solve, could you describe the actual
> > > > > problem ?
> > > > 
> > > > The issue is explained in the following thread:
> > > > https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2669#note_1697388
> > > > 
> > > > In short, the user wants to show a "camera-in-use" indicator when the laptop camera
> > > > is used. The script that the user previously had only checked if /dev/video0
> > > > was open in any process, if it was, the indicator was shown. However, libcamera
> > > > - at least at the moment - keeps the file descriptor open as long as the Camera
> > > > object exists, which pipewire keeps alive for the entire lifetime of the device,
> > > > therefore the "camera-in-use" indicator is always shown.
> > > 
> > > A sysfs attribute is not a great way to address this.
> > > 
> > > libcamera certainly has information on whether streaming is ongoing. The
> > > information should come from there. Or Pipewire. Dbus perhaps?
> > 
> > I tend to agree, I think this is best solved in userspace where PipeWire
> > can have a centralized view of all cameras in the system, and of their
> > users.
> 
> I fear that misses the entire point I was trying to make.
> 
> Lets say pipewire 'is' available and in use and can be used to capture
> video streams for video calls, that's fine. But what happens if a user
> runs a gstreamer pipeline without using the pipewire source, or a
> suspcious process runs "yavta" and captures an image or stream
> discreetly...
> 
> Only the kernel has a true centralised view of what devices are in use.

That's right, but at the same time, the kernel as little view of what a
"camera" is.

At the beginning of V4L a video capture node was a TV capture card (soon
with a few exceptions), then it also modelled a camera, for the past ten
years at least it's "just" a DMA engine in many cases, and relatively
recently even evolved to simply model a data flow endpoint with the
addition of metadata video nodes. This doesn't even mention usage of
video capture nodes in codecs or other memory to memory devices. Video
devices are now in many cases just one of the many components in a
camera pipeline.

In most cases drivers can reasonably decide which video devices most
likely represent a "camera", but that an approximation in any case, and
not a general guarantee. In userspace the situation is worse, the link
between a video device and a camera has been long lost.  We started
recovering it with libcamera, which is, today, the only open-source
component available in Linux systems that has knowledge of cameras, not
just video device nodes.

> > > Alternatively libcamera could close the video devices while not streaming
> > > but that would involve e.g. releasing possible video buffer allocations as
> > > well, increasing streaming start latency.
> 
> Or is it just that in that case 'lsof' should be sufficient?
> 
> The problem I have with that is - just like with the issue when the
> Privacy LED comes on during power up/probe - then any time a device is
> opened to identify the device and not necessarily use it - the 'camera
> in use' notification would get flashed...

Regardless of whether an open device node indication or a streaming
status is used, you don't want to indicate a camera is used because the
user is watching a movie and the V4L2-based codec is in use. You thus
need to at least filter out unrelated video devices in userspace, and if
you want to do so for privacy reasons, hardcoding in PipeWire (or
anywhere else) a heuristic will be prone to false positives or false
negatives. That isn't a good idea in my opinion, I believe this problem
can only be solved by handling the concept of "camera" in userspace.

> > Closing video (and subdev) nodes when the camera is not in use would be
> > good I think. It doesn't mean we have to open them when starting
> > capture, explicit open/close operation (or similar, maybe introducing a
> > capture session object in the libcamera API would also make sense, it
> > should be considered as part of the same issue) could help with this.
> 
> I'm not talking about libcamera in this thread. It's how does a user
> correctly identify when a camera is in use globally in a system.

-- 
Regards,

Laurent Pinchart
