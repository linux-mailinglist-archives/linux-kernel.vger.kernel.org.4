Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5005265C880
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbjACUzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238658AbjACUy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:54:58 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB0314D2F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:54:57 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 18so9263042pfx.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 12:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KuxDXQh+XemD0kf38vi8EFpiKm6e7LclyzdQcARACLo=;
        b=RdpSkdEM4iH8oPLGWi8GEmnSlQs49WiclBJ/Q/bGh6wtD4HZHr0A4iGAy2f7pn/Rzo
         SQ56nD6okXOMV9wSyIm2nxuV3pgoKnHbqH/GztUYgCuoamIAF/AeoaFK5gYdYxl1o/Ve
         i3w1BTINvKOm1xBTn18rFL8ZSQBIVTwRZlQ2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuxDXQh+XemD0kf38vi8EFpiKm6e7LclyzdQcARACLo=;
        b=jAznOFADG5N+F5HrjPS3VF/Ao//KbWlCoaSBp5cRY/nehN3p7GqrihBhrYfFNYjstr
         VWl5R+jeyhxm6Wq7O+j3Ei1t4iUT7hiU40MnsOhkB14sQMRX/aNWEsstVRXvObBHMGAG
         BbVmxVuO4dc97EO+RWjJmWkoU3Awoe0tlaj9d5GAMMJwB9dc+zBhaGzrJBYunDgqCVeD
         zlm3IXjfUG7oo9N+WaE+9RpNr67HL0RxH6uagLW0yUYhq11Q+HrJdlpentGiNhZjFIqz
         rtLfQ9PoRHgbAYVi16NQK5l8lwmoE49f+feT2B3S/13W+xG7S250eMNxJCQHyMU49bdj
         jlUQ==
X-Gm-Message-State: AFqh2koC//K9Gebf/bP3tN8dc/pJ2x1elc4HK/53WcgxqHvzyiRtrF8n
        cQjAHlHC3cNOzp7lFt+Jr2fRtbouvg311ypKj6k=
X-Google-Smtp-Source: AMrXdXs1kv+UVwxputjOjXG+QrqSwH5dFWil8cgdQVpzuvRD7edh6wKvi347zW3ivfAiNjlNZpKDbQ==
X-Received: by 2002:a62:1d97:0:b0:578:ac9f:79a9 with SMTP id d145-20020a621d97000000b00578ac9f79a9mr43189547pfd.15.1672779296480;
        Tue, 03 Jan 2023 12:54:56 -0800 (PST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com. [209.85.214.180])
        by smtp.gmail.com with ESMTPSA id 123-20020a621881000000b00528a097aeffsm20890206pfy.118.2023.01.03.12.54.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 12:54:55 -0800 (PST)
Received: by mail-pl1-f180.google.com with SMTP id b2so33904525pld.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 12:54:55 -0800 (PST)
X-Received: by 2002:a17:90a:ee91:b0:21f:eb8:f6f0 with SMTP id
 i17-20020a17090aee9100b0021f0eb8f6f0mr2963218pjz.4.1672779294677; Tue, 03 Jan
 2023 12:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20220920-resend-v4l2-compliance-v3-0-598d33a15815@chromium.org> <Y7SVzNGrpdWXmvuI@pendragon.ideasonboard.com>
In-Reply-To: <Y7SVzNGrpdWXmvuI@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 3 Jan 2023 21:54:43 +0100
X-Gmail-Original-Message-ID: <CANiDSCsug_CobAAZvL0b8-wJ_0f4b8-fsiiLmkvkPRM01MNOUw@mail.gmail.com>
Message-ID: <CANiDSCsug_CobAAZvL0b8-wJ_0f4b8-fsiiLmkvkPRM01MNOUw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Follow-up patches for uvc v4l2-compliance
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Tue, 3 Jan 2023 at 21:53, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> On Tue, Jan 03, 2023 at 03:36:18PM +0100, Ricardo Ribalda wrote:
> > This patchset contains the fixes for the comments on "v10 of Fix
> > v4l2-compliance errors series". In particular to the patches
> >
> > -uvcvideo: uvc_ctrl_is_accessible: check for INACTIVE
> > -uvcvideo: improve error handling in uvc_query_ctrl()
> >
> > And the patch:
> > -uvcvideo: Fix handling on Bitmask controls
>
> I've applied 1/8 to 7/8 to my tree and pushed the result to
> https://git.kernel.org/pub/scm/linux/kernel/git/pinchartl/linux.git/log/?h=next/uvc.
> You can submit a new version of 8/8 only based on that branch.

Thanks :)

>
> > To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > To: Mauro Carvalho Chehab <mchehab@kernel.org>
> > Cc: linux-media@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Hans Verkuil <hans.verkuil@cisco.com>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >
> > ---
> > Changes in v3 (Thanks Laurent):
> > - Add a new patch for refactoring __uvc_ctrl_add_mapping
> > - Use standard names for menus
> >   - Return error on uvc_mapping_get_menu_value
> >   - Add const
> >   - StyLe!
> > - Do not return positive errors in uvc_query_ctrl()
> >    - Improve commit message
> > - improve error logging in uvc_query_ctrl()
> >    - Fix comment
> >    - Improve doc
> > - Fix handling on Bitmask controls
> >    - s/uvc/UVC
> >    - Reflow comments to 80 chars
> >    - Test with GET_RES first
> >    - Remove clamp to (0,..)
> > - Return -EACCES for Wrong state error
> >    - Full rewrite of commit message
> > - uvc_ctrl_is_accessible: check for INACTIVE
> >    - Update commit message
> >    - Remove try variable
> >    - Update documentation
> > - Implement mask for V4L2_CTRL_TYPE_MENU
> >    - Include linux/bits.h
> > - Link to v2: https://lore.kernel.org/r/20220920-resend-v4l2-compliance-v2-0-7c0942040004@chromium.org
> >
> > Changes in v2:
> > - Include "Get menu names from framework series"
> >   https://lore.kernel.org/r/20220920-standard-menues-v2-0-a35af3243c2f@chromium.org
> > - Link to v1: https://lore.kernel.org/r/20220920-resend-v4l2-compliance-v1-0-81364c15229b@chromium.org
> >
> > ---
> > Hans Verkuil (2):
> >       media: uvcvideo: Check for INACTIVE in uvc_ctrl_is_accessible()
> >       media: uvcvideo: improve error logging in uvc_query_ctrl()
> >
> > Ricardo Ribalda (6):
> >       media: uvcvideo: Return -EACCES for Wrong state error
> >       media: uvcvideo: Do not return positive errors in uvc_query_ctrl()
> >       media: uvcvideo: Fix handling on Bitmask controls
> >       media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
> >       media: uvcvideo: Refactor __uvc_ctrl_add_mapping
> >       media: uvcvideo: Use standard names for menus
> >
> >  drivers/media/usb/uvc/uvc_ctrl.c   | 238 ++++++++++++++++++++++++++++---------
> >  drivers/media/usb/uvc/uvc_driver.c |  10 +-
> >  drivers/media/usb/uvc/uvc_v4l2.c   | 108 ++++++++++++-----
> >  drivers/media/usb/uvc/uvc_video.c  |  15 +--
> >  drivers/media/usb/uvc/uvcvideo.h   |   8 +-
> >  include/uapi/linux/uvcvideo.h      |   4 +-
> >  6 files changed, 281 insertions(+), 102 deletions(-)
> > ---
> > base-commit: 69b41ac87e4a664de78a395ff97166f0b2943210
> > change-id: 20220920-resend-v4l2-compliance-4fdbe4fbd7b5
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
