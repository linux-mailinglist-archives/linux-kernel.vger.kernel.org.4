Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B16765BD38
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbjACJda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbjACJd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:33:28 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8122E10FD;
        Tue,  3 Jan 2023 01:33:27 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0689B108;
        Tue,  3 Jan 2023 10:33:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672738405;
        bh=Th77TtW0d0ivkQvCf1yb5Viacuy+hOj20gy2rCLjpgw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LYUdXMYK4i5bL1g0xlDIiUZOmi62RXw3XJu8KPj+fXpdeUNJQZCG224SQxGrxwqM2
         DIWPc4eGeKvHay2lYd2nrsGvnMstCPrJIxCgr1jEFrMiget6u65Yy4O0aflEOXt8/7
         fKu8q9En3TBiMIc86quqndgSWRDnvT3ryt3R9mio=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y7LdpQ9s7lS+x9mO@pendragon.ideasonboard.com>
References: <20221223231736.2111774-1-kieran.bingham@ideasonboard.com> <Y6lu14VsuH1LbqFH@pendragon.ideasonboard.com> <yvFnaY1MM7I5C7H18aJdvQ6XEQn979YkGYpCjRLsnJvCRr2vYWVKorYqFXGxP3tWKeJ5B0oEA4Fn4W2-IqPd_N_wivEM4uKJD4WX53RiSmY=@protonmail.com> <Y7LYp01J5co9KSfJ@paasikivi.fi.intel.com> <Y7LdpQ9s7lS+x9mO@pendragon.ideasonboard.com>
Subject: Re: [RFC PATCH] media: v4l2-dev: sysfs: Support streaming attribute
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     =?utf-8?q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        open list <linux-kernel@vger.kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Date:   Tue, 03 Jan 2023 09:33:22 +0000
Message-ID: <167273840266.530483.6812185939521706359@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Laurent Pinchart (2023-01-02 13:35:33)
> Hello,
>=20
> On Mon, Jan 02, 2023 at 01:14:15PM +0000, Sakari Ailus wrote:
> > On Wed, Dec 28, 2022 at 01:44:38AM +0000, Barnab=C3=A1s P=C5=91cze wrot=
e:
> > > On 2022. december 26., h=C3=A9tf=C5=91 10:52, Laurent Pinchart wrote:
> > > > On Fri, Dec 23, 2022 at 11:17:35PM +0000, Kieran Bingham wrote:
> > > >=20
> > > > > Provide a streaming attribute to allow userspace to interogate if=
 a device
> > > > > is actively streaming or not.
> > > > >=20
> > > > > This will allow desktop notifications to report if a camera or de=
vice
> > > > > is active on the system, rather than just 'open' which can occur =
when
> > > > > configuring the device.
> > > > >=20
> > > > > Bug: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/26=
69
> > > > > Signed-off-by: Kieran Bingham kieran.bingham@ideasonboard.com
> > > > > ---
> > > > >=20
> > > > > This is a quick POC to see if such a facility makes sense.
> > > > > I'm weary that not all video devices may have the queues register=
ed on
> > > > > the struct video_device, but this seems like an effective way to =
be able
> > > > > to determine if a device is actively streaming on a system.
> > > >=20
> > > > I can imagine multiple problems, from race conditions to permission=
s and
> > > > privacy. In order to comment on the fitness of this solution to add=
ress
> > > > the problem you're trying to solve, could you describe the actual
> > > > problem ?
> > >=20
> > > The issue is explained in the following thread:
> > > https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2669#note_1=
697388
> > >=20
> > > In short, the user wants to show a "camera-in-use" indicator when the=
 laptop camera
> > > is used. The script that the user previously had only checked if /dev=
/video0
> > > was open in any process, if it was, the indicator was shown. However,=
 libcamera
> > > - at least at the moment - keeps the file descriptor open as long as =
the Camera
> > > object exists, which pipewire keeps alive for the entire lifetime of =
the device,
> > > therefore the "camera-in-use" indicator is always shown.
> >=20
> > A sysfs attribute is not a great way to address this.
> >=20
> > libcamera certainly has information on whether streaming is ongoing. The
> > information should come from there. Or Pipewire. Dbus perhaps?
>=20
> I tend to agree, I think this is best solved in userspace where PipeWire
> can have a centralized view of all cameras in the system, and of their
> users.

I fear that misses the entire point I was trying to make.

Lets say pipewire 'is' available and in use and can be used to capture
video streams for video calls, that's fine. But what happens if a user
runs a gstreamer pipeline without using the pipewire source, or a
suspcious process runs "yavta" and captures an image or stream
discreetly...

Only the kernel has a true centralised view of what devices are in use.

> > Alternatively libcamera could close the video devices while not streami=
ng
> > but that would involve e.g. releasing possible video buffer allocations=
 as
> > well, increasing streaming start latency.

Or is it just that in that case 'lsof' should be sufficient?

The problem I have with that is - just like with the issue when the
Privacy LED comes on during power up/probe - then any time a device is
opened to identify the device and not necessarily use it - the 'camera
in use' notification would get flashed...

> Closing video (and subdev) nodes when the camera is not in use would be
> good I think. It doesn't mean we have to open them when starting
> capture, explicit open/close operation (or similar, maybe introducing a
> capture session object in the libcamera API would also make sense, it
> should be considered as part of the same issue) could help with this.

I'm not talking about libcamera in this thread. It's how does a user
correctly identify when a camera is in use globally in a system.
--
Kieran
