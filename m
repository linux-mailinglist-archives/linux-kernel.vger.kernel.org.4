Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB43C65C877
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbjACUxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjACUxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:53:39 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BAFC740;
        Tue,  3 Jan 2023 12:53:39 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ADF68108;
        Tue,  3 Jan 2023 21:53:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672779216;
        bh=RNsvYxmwZ8XfD1iFTcFXZot2OugFLWLTtJgztnPBcVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vGszHIl3GXio32Wsrv/8UXpqsafWe3DDvnsLFVYhRDJE2g/WORE9t1+SwHYMOwwca
         hfKL/Y4LTKCZzdxubZmA0aUvHXFXyoWsvM8XNcNNbGNVERXJ/TOfhkxbclQl1lnCKO
         eFaY/5Q/Ybt3KsgB/Z0GMY2l0iJ/fiIYrmVd3+VU=
Date:   Tue, 3 Jan 2023 22:53:32 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH v3 0/8] Follow-up patches for uvc v4l2-compliance
Message-ID: <Y7SVzNGrpdWXmvuI@pendragon.ideasonboard.com>
References: <20220920-resend-v4l2-compliance-v3-0-598d33a15815@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-v4l2-compliance-v3-0-598d33a15815@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Tue, Jan 03, 2023 at 03:36:18PM +0100, Ricardo Ribalda wrote:
> This patchset contains the fixes for the comments on "v10 of Fix
> v4l2-compliance errors series". In particular to the patches
> 
> -uvcvideo: uvc_ctrl_is_accessible: check for INACTIVE
> -uvcvideo: improve error handling in uvc_query_ctrl()
> 
> And the patch:
> -uvcvideo: Fix handling on Bitmask controls

I've applied 1/8 to 7/8 to my tree and pushed the result to
https://git.kernel.org/pub/scm/linux/kernel/git/pinchartl/linux.git/log/?h=next/uvc.
You can submit a new version of 8/8 only based on that branch.

> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> To: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> 
> ---
> Changes in v3 (Thanks Laurent):
> - Add a new patch for refactoring __uvc_ctrl_add_mapping
> - Use standard names for menus
>   - Return error on uvc_mapping_get_menu_value
>   - Add const
>   - StyLe!
> - Do not return positive errors in uvc_query_ctrl()
>    - Improve commit message
> - improve error logging in uvc_query_ctrl()
>    - Fix comment
>    - Improve doc
> - Fix handling on Bitmask controls
>    - s/uvc/UVC
>    - Reflow comments to 80 chars
>    - Test with GET_RES first
>    - Remove clamp to (0,..)
> - Return -EACCES for Wrong state error
>    - Full rewrite of commit message
> - uvc_ctrl_is_accessible: check for INACTIVE
>    - Update commit message
>    - Remove try variable
>    - Update documentation
> - Implement mask for V4L2_CTRL_TYPE_MENU
>    - Include linux/bits.h
> - Link to v2: https://lore.kernel.org/r/20220920-resend-v4l2-compliance-v2-0-7c0942040004@chromium.org
> 
> Changes in v2:
> - Include "Get menu names from framework series"
>   https://lore.kernel.org/r/20220920-standard-menues-v2-0-a35af3243c2f@chromium.org
> - Link to v1: https://lore.kernel.org/r/20220920-resend-v4l2-compliance-v1-0-81364c15229b@chromium.org
> 
> ---
> Hans Verkuil (2):
>       media: uvcvideo: Check for INACTIVE in uvc_ctrl_is_accessible()
>       media: uvcvideo: improve error logging in uvc_query_ctrl()
> 
> Ricardo Ribalda (6):
>       media: uvcvideo: Return -EACCES for Wrong state error
>       media: uvcvideo: Do not return positive errors in uvc_query_ctrl()
>       media: uvcvideo: Fix handling on Bitmask controls
>       media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
>       media: uvcvideo: Refactor __uvc_ctrl_add_mapping
>       media: uvcvideo: Use standard names for menus
> 
>  drivers/media/usb/uvc/uvc_ctrl.c   | 238 ++++++++++++++++++++++++++++---------
>  drivers/media/usb/uvc/uvc_driver.c |  10 +-
>  drivers/media/usb/uvc/uvc_v4l2.c   | 108 ++++++++++++-----
>  drivers/media/usb/uvc/uvc_video.c  |  15 +--
>  drivers/media/usb/uvc/uvcvideo.h   |   8 +-
>  include/uapi/linux/uvcvideo.h      |   4 +-
>  6 files changed, 281 insertions(+), 102 deletions(-)
> ---
> base-commit: 69b41ac87e4a664de78a395ff97166f0b2943210
> change-id: 20220920-resend-v4l2-compliance-4fdbe4fbd7b5

-- 
Regards,

Laurent Pinchart
