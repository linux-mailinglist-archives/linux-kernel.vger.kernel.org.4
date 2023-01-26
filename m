Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD05567C95A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbjAZLC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236665AbjAZLC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:02:56 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF422313B;
        Thu, 26 Jan 2023 03:02:54 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0104A2B3;
        Thu, 26 Jan 2023 12:02:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674730972;
        bh=VXTem+t9dM+VDk9w0VKGh8hc/0bNhFcoS03nbbkEXXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JTJrD37nWQ4ToLeEKb+RpXHLTHUeRr6JYacydA/eUbkE0tcW+TXh6ptpHlT+IITdU
         3GxnYHR5Y+eYM4fVk6BRkhYWkXBRpPn9VezR/9AuGGExLYnjIzovwVDF7TYcc+8YOO
         CqdfrB5kNnVDzu6Ml0VZjON6oQ9t/RDhQH3ABMY8=
Date:   Thu, 26 Jan 2023 13:02:47 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     ayaka <ayaka@soulik.info>, randy.li@synaptics.com,
        Brian.Starkey@arm.com, frkoenig@chromium.org,
        hans.verkuil@cisco.com, helen.koike@collabora.com,
        hiroh@chromium.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, narmstrong@baylibre.com, nicolas@ndufresne.ca,
        sakari.ailus@iki.fi, stanimir.varbanov@linaro.org,
        tfiga@chromium.org
Subject: Re: [RFC PATCH v6 03/11] media: v4l2: Add extended buffer (de)queue
 operations for video types
Message-ID: <Y9Jd12nYGk2xTYzx@pendragon.ideasonboard.com>
References: <20210114180738.1758707-1-helen.koike@collabora.com>
 <20210114180738.1758707-4-helen.koike@collabora.com>
 <20230125200026.16643-1-ayaka@soulik.info>
 <7609d523-667a-49a8-45f5-8186de20c24b@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7609d523-667a-49a8-45f5-8186de20c24b@xs4all.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 09:57:51AM +0100, Hans Verkuil wrote:
> On 25/01/2023 21:00, ayaka wrote:
> > I am currently refresh this patchset, but I didn't see the need beyond v4l2_ext_pix_fmt, which I had done.
> > On 2/23/21 20:58, Hans Verkuil wrote:
> >> On 14/01/2021 19:07, Helen Koike wrote:
> >>> Those extended buffer ops have several purpose:
> >>> 1/ Fix y2038 issues by converting the timestamp into an u64 counting
> >>>     the number of ns elapsed since 1970
> > 
> > I think application just use the timestamp field for tracking the
> > buffer. It would be just a sequence buffer.
> > At least for the most widely cases, the video encoder and decoder
> > and ISP, this field is not a wall time.
> 
> For video capture and video output this is typically the monotonic
> clock value.
> 
> For memory-to-memory devices it is something that is just copied from
> output to capture.
> 
> So ISPs definitely use this as a proper timestamp.

There are both inline (live-to-memory) and offline (memory-to-memory)
ISPs. The former certainly need a proper timestamp.

> >>> 2/ Unify single/multiplanar handling
> >>> 3/ Add a new start offset field to each v4l2 plane buffer info struct
> >>>     to support the case where a single buffer object is storing all
> >>>     planes data, each one being placed at a different offset
> >
> > I really care about this. But I think the data_offset field in
> > struct v4l2_plane is enough. The rest is the problem of the kernel
> > internal API and allocator.
> 
> data_offset has proven to be very confusing and is rarely used because
> of that.
> 
> We do need some sort of an offset field as proposed here, but it
> shouldn't be named data_offset.

The existing data_offset field was indeed added for other purposes, to
let drivers report where the actual image data starts for devices that
prepend some sort of header. That's indeed not what we want here, we
instead need something similar to the offsets field of struct
drm_mode_fb_cmd2.

> > I am thinking just add a field recording the offset input from the user.
> > When we return the buffer back to the user, the value of the offset
> > should be same as the it is queued.
> > 
> > Meanwhile, the API compatible that I want to keep is user using the
> > ext_pix API could access those drivers support old API.
> > But I don't want the user would expect they could get correct pixel
> > format using the old ioctl(). It could create many duplicated pixel
> > formats. If we want to keep the compatible here, that is the job of
> > libv4l.
> > 
> > Besides, I think make the driver using the new API be compatible
> > with the old ioctl() would lead a huge problem. User won't like to
> > update its code if it could work even in a less performance mode
> > because this code are for all the other hardware vendors/models.
> > Unless we make this a feature, they could make a new branch in their
> > code(don't count them would upate the kernel of the other products).
> 
> New drivers that require the additional information that these new ioctls give can
> decide to just support these new ioctls only. But for existing drivers you want
> to automatically support the new ioctls.

-- 
Regards,

Laurent Pinchart
