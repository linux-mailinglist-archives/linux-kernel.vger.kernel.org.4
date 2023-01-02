Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A65165B2B7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 14:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjABNfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 08:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjABNfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 08:35:42 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC67D6457;
        Mon,  2 Jan 2023 05:35:39 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DE5137C5;
        Mon,  2 Jan 2023 14:35:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672666537;
        bh=7ZCichT9U5yO3QhGgXlLnhU3dvOgvOBgbW8mxgs7C8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VGlJBGBcctUT06hZ4A2GU2BM3A0uUtbYNeqDg3FSsOwTuwUg1MD0lggvfS4/dGEyT
         qMWQCbS2PTbHxQ74ZaIKjTjFMlpbynoTfg2Rz9ERIGwz3eyH7xPXHaWT6xPsA3YT8A
         cG3XIQGw1jL/AL1CbQ4ksxcZFGx2V8BNuMqwIm88=
Date:   Mon, 2 Jan 2023 15:35:33 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] media: v4l2-dev: sysfs: Support streaming attribute
Message-ID: <Y7LdpQ9s7lS+x9mO@pendragon.ideasonboard.com>
References: <20221223231736.2111774-1-kieran.bingham@ideasonboard.com>
 <Y6lu14VsuH1LbqFH@pendragon.ideasonboard.com>
 <yvFnaY1MM7I5C7H18aJdvQ6XEQn979YkGYpCjRLsnJvCRr2vYWVKorYqFXGxP3tWKeJ5B0oEA4Fn4W2-IqPd_N_wivEM4uKJD4WX53RiSmY=@protonmail.com>
 <Y7LYp01J5co9KSfJ@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7LYp01J5co9KSfJ@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jan 02, 2023 at 01:14:15PM +0000, Sakari Ailus wrote:
> On Wed, Dec 28, 2022 at 01:44:38AM +0000, Barnabás Pőcze wrote:
> > On 2022. december 26., hétfő 10:52, Laurent Pinchart wrote:
> > > On Fri, Dec 23, 2022 at 11:17:35PM +0000, Kieran Bingham wrote:
> > > 
> > > > Provide a streaming attribute to allow userspace to interogate if a device
> > > > is actively streaming or not.
> > > > 
> > > > This will allow desktop notifications to report if a camera or device
> > > > is active on the system, rather than just 'open' which can occur when
> > > > configuring the device.
> > > > 
> > > > Bug: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2669
> > > > Signed-off-by: Kieran Bingham kieran.bingham@ideasonboard.com
> > > > ---
> > > > 
> > > > This is a quick POC to see if such a facility makes sense.
> > > > I'm weary that not all video devices may have the queues registered on
> > > > the struct video_device, but this seems like an effective way to be able
> > > > to determine if a device is actively streaming on a system.
> > > 
> > > I can imagine multiple problems, from race conditions to permissions and
> > > privacy. In order to comment on the fitness of this solution to address
> > > the problem you're trying to solve, could you describe the actual
> > > problem ?
> > 
> > The issue is explained in the following thread:
> > https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2669#note_1697388
> > 
> > In short, the user wants to show a "camera-in-use" indicator when the laptop camera
> > is used. The script that the user previously had only checked if /dev/video0
> > was open in any process, if it was, the indicator was shown. However, libcamera
> > - at least at the moment - keeps the file descriptor open as long as the Camera
> > object exists, which pipewire keeps alive for the entire lifetime of the device,
> > therefore the "camera-in-use" indicator is always shown.
> 
> A sysfs attribute is not a great way to address this.
> 
> libcamera certainly has information on whether streaming is ongoing. The
> information should come from there. Or Pipewire. Dbus perhaps?

I tend to agree, I think this is best solved in userspace where PipeWire
can have a centralized view of all cameras in the system, and of their
users.

> Alternatively libcamera could close the video devices while not streaming
> but that would involve e.g. releasing possible video buffer allocations as
> well, increasing streaming start latency.

Closing video (and subdev) nodes when the camera is not in use would be
good I think. It doesn't mean we have to open them when starting
capture, explicit open/close operation (or similar, maybe introducing a
capture session object in the libcamera API would also make sense, it
should be considered as part of the same issue) could help with this.

-- 
Regards,

Laurent Pinchart
