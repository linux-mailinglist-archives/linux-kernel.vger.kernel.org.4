Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DFB65C2F1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjACPYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238041AbjACPX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:23:57 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70B21055E;
        Tue,  3 Jan 2023 07:23:55 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8F22B108;
        Tue,  3 Jan 2023 16:23:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672759433;
        bh=LDqnQYWWwfalGU5z5r/QKv44ZlrXmBotvMvowzy8No8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lZJcQFhlIIM+OIg6bXNhJ0VBi+sfewuRUYTk3CbEwo0oblIKUpnH+iIvM8cwa3FbE
         NTfpXs+Z/1g76xHFRsD5KHeL740W9LXTAu+ndtbS1ltkStNnfu+7EKyTNfoZL12jkV
         6nY0i69QIt+seOzWOWDoqri/HvajcaDYwLXLn8ho=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y7QuMKi3ZdMDUwCw@pendragon.ideasonboard.com>
References: <20221223231736.2111774-1-kieran.bingham@ideasonboard.com> <Y6lu14VsuH1LbqFH@pendragon.ideasonboard.com> <yvFnaY1MM7I5C7H18aJdvQ6XEQn979YkGYpCjRLsnJvCRr2vYWVKorYqFXGxP3tWKeJ5B0oEA4Fn4W2-IqPd_N_wivEM4uKJD4WX53RiSmY=@protonmail.com> <Y7LYp01J5co9KSfJ@paasikivi.fi.intel.com> <Y7LdpQ9s7lS+x9mO@pendragon.ideasonboard.com> <167273840266.530483.6812185939521706359@Monstersaurus> <Y7QuMKi3ZdMDUwCw@pendragon.ideasonboard.com>
Subject: Re: [RFC PATCH] media: v4l2-dev: sysfs: Support streaming attribute
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?utf-8?q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        open list <linux-kernel@vger.kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:   Tue, 03 Jan 2023 15:23:51 +0000
Message-ID: <167275943112.2799906.2650046969237060663@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Laurent Pinchart (2023-01-03 13:31:28)
> Hi Kieran,
>=20
> On Tue, Jan 03, 2023 at 09:33:22AM +0000, Kieran Bingham wrote:
> > Quoting Laurent Pinchart (2023-01-02 13:35:33)
> > > On Mon, Jan 02, 2023 at 01:14:15PM +0000, Sakari Ailus wrote:
> > > > On Wed, Dec 28, 2022 at 01:44:38AM +0000, Barnab=C3=A1s P=C5=91cze =
wrote:
> > > > > On 2022. december 26., h=C3=A9tf=C5=91 10:52, Laurent Pinchart wr=
ote:
> > > > > > On Fri, Dec 23, 2022 at 11:17:35PM +0000, Kieran Bingham wrote:
> > > > > >=20
> > > > > > > Provide a streaming attribute to allow userspace to interogat=
e if a device
> > > > > > > is actively streaming or not.
> > > > > > >=20
> > > > > > > This will allow desktop notifications to report if a camera o=
r device
> > > > > > > is active on the system, rather than just 'open' which can oc=
cur when
> > > > > > > configuring the device.
> > > > > > >=20
> > > > > > > Bug: https://gitlab.freedesktop.org/pipewire/pipewire/-/issue=
s/2669
> > > > > > > Signed-off-by: Kieran Bingham kieran.bingham@ideasonboard.com
> > > > > > > ---
> > > > > > >=20
> > > > > > > This is a quick POC to see if such a facility makes sense.
> > > > > > > I'm weary that not all video devices may have the queues regi=
stered on
> > > > > > > the struct video_device, but this seems like an effective way=
 to be able
> > > > > > > to determine if a device is actively streaming on a system.
> > > > > >=20
> > > > > > I can imagine multiple problems, from race conditions to permis=
sions and
> > > > > > privacy. In order to comment on the fitness of this solution to=
 address
> > > > > > the problem you're trying to solve, could you describe the actu=
al
> > > > > > problem ?
> > > > >=20
> > > > > The issue is explained in the following thread:
> > > > > https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2669#no=
te_1697388
> > > > >=20
> > > > > In short, the user wants to show a "camera-in-use" indicator when=
 the laptop camera
> > > > > is used. The script that the user previously had only checked if =
/dev/video0
> > > > > was open in any process, if it was, the indicator was shown. Howe=
ver, libcamera
> > > > > - at least at the moment - keeps the file descriptor open as long=
 as the Camera
> > > > > object exists, which pipewire keeps alive for the entire lifetime=
 of the device,
> > > > > therefore the "camera-in-use" indicator is always shown.
> > > >=20
> > > > A sysfs attribute is not a great way to address this.
> > > >=20
> > > > libcamera certainly has information on whether streaming is ongoing=
. The
> > > > information should come from there. Or Pipewire. Dbus perhaps?
> > >=20
> > > I tend to agree, I think this is best solved in userspace where PipeW=
ire
> > > can have a centralized view of all cameras in the system, and of their
> > > users.
> >=20
> > I fear that misses the entire point I was trying to make.
> >=20
> > Lets say pipewire 'is' available and in use and can be used to capture
> > video streams for video calls, that's fine. But what happens if a user
> > runs a gstreamer pipeline without using the pipewire source, or a
> > suspcious process runs "yavta" and captures an image or stream
> > discreetly...
> >=20
> > Only the kernel has a true centralised view of what devices are in use.
>=20
> That's right, but at the same time, the kernel as little view of what a
> "camera" is.
>=20
> At the beginning of V4L a video capture node was a TV capture card (soon
> with a few exceptions), then it also modelled a camera, for the past ten
> years at least it's "just" a DMA engine in many cases, and relatively
> recently even evolved to simply model a data flow endpoint with the
> addition of metadata video nodes. This doesn't even mention usage of
> video capture nodes in codecs or other memory to memory devices. Video
> devices are now in many cases just one of the many components in a
> camera pipeline.
>=20
> In most cases drivers can reasonably decide which video devices most
> likely represent a "camera", but that an approximation in any case, and
> not a general guarantee. In userspace the situation is worse, the link
> between a video device and a camera has been long lost.  We started
> recovering it with libcamera, which is, today, the only open-source
> component available in Linux systems that has knowledge of cameras, not
> just video device nodes.
>=20
> > > > Alternatively libcamera could close the video devices while not str=
eaming
> > > > but that would involve e.g. releasing possible video buffer allocat=
ions as
> > > > well, increasing streaming start latency.
> >=20
> > Or is it just that in that case 'lsof' should be sufficient?
> >=20
> > The problem I have with that is - just like with the issue when the
> > Privacy LED comes on during power up/probe - then any time a device is
> > opened to identify the device and not necessarily use it - the 'camera
> > in use' notification would get flashed...
>=20
> Regardless of whether an open device node indication or a streaming
> status is used, you don't want to indicate a camera is used because the
> user is watching a movie and the V4L2-based codec is in use. You thus
> need to at least filter out unrelated video devices in userspace, and if
> you want to do so for privacy reasons, hardcoding in PipeWire (or
> anywhere else) a heuristic will be prone to false positives or false
> negatives. That isn't a good idea in my opinion, I believe this problem
> can only be solved by handling the concept of "camera" in userspace.

Indeed, with v4l2 based codecs, this gets far more complex.

I think it's a shame we can't get this state globally, in a way that
can't be 'hidden' or 'subverted' but I'll just consider this patch
dropped.

--
Kieran


>=20
> > > Closing video (and subdev) nodes when the camera is not in use would =
be
> > > good I think. It doesn't mean we have to open them when starting
> > > capture, explicit open/close operation (or similar, maybe introducing=
 a
> > > capture session object in the libcamera API would also make sense, it
> > > should be considered as part of the same issue) could help with this.
> >=20
> > I'm not talking about libcamera in this thread. It's how does a user
> > correctly identify when a camera is in use globally in a system.
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart
