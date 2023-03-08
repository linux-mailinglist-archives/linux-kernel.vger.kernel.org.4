Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C83C6B15AE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCHW5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCHW5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:57:18 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0562565447
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:57:17 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id v11so87266plz.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678316236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dAK9CzL+zrevBUMkpokUm3TFCKwT1+VpG+72EOhUpw4=;
        b=PYk53ijBC97VpoEV2dqmf6xQpnC+MN1CDULqjxExB4rX2qXKFLCXRKi7w/vRZl3cd9
         rRlFh9+bA9MdpRILUNPVDv3kV8iA4y1nlQPBGSVgKPkAUDCHbYQz0LT+ur0NBBuXW+78
         mGJYzl+Fx/o6Fj5Jc4etvYg1Y8a/LDfNeBhPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAK9CzL+zrevBUMkpokUm3TFCKwT1+VpG+72EOhUpw4=;
        b=xnu8wJm8wDuN8kScAWkoqSKvnDNKoIKkruNd+Ulk+oqQ8tP10SAV/Dxjf6xWQlj5zr
         /cDZIX+loYax3H3HVkd5ABhnV8/QODmol8kh8DnRhHzolbnFd1NbfmnOkHITCMUcKVaj
         1E4KQSDtUWWJIOCr53g+u2K8bXf0E0OmFLfnZxVx9a9RkxW+LO1CN3QvDPglKrgUvFKE
         E2fXDIB3nE2SXeDyirS0huF+L2x47de5nTy0sTpK44nYiBDqBvoCTfUJWxa5Q/DqY3Yd
         CEFo+p1zkjATojITgR2a+sXRswYlf8MO3saTtv9l0kbCkah2P0cTQNn2eoMMpCGR+CrV
         e/hg==
X-Gm-Message-State: AO0yUKVBu6bawgxO1YgK1O3MFyZWzPYNwuyiN5OpNtRtnzKtuPNyaPGj
        mYwHFVzEOLiT4+maofbXCViAZGUDlG468kM/JVv8bQ==
X-Google-Smtp-Source: AK7set/9BekLMEyVSqqqtQLPZi/SWUxzXMuCGCmRLKsX86j2/FOo/nIFNihNMHQlPOAkVNSNDIE+Qw==
X-Received: by 2002:a17:902:e809:b0:19a:9890:eac6 with SMTP id u9-20020a170902e80900b0019a9890eac6mr23775978plg.24.1678316236230;
        Wed, 08 Mar 2023 14:57:16 -0800 (PST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com. [209.85.210.171])
        by smtp.gmail.com with ESMTPSA id kd12-20020a17090313cc00b0019cb6222691sm8758875plb.133.2023.03.08.14.57.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 14:57:15 -0800 (PST)
Received: by mail-pf1-f171.google.com with SMTP id fd25so308696pfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:57:15 -0800 (PST)
X-Received: by 2002:a63:5847:0:b0:4eb:1c07:e5d7 with SMTP id
 i7-20020a635847000000b004eb1c07e5d7mr7049690pgm.6.1678316235129; Wed, 08 Mar
 2023 14:57:15 -0800 (PST)
MIME-Version: 1.0
References: <20230111-uvc_privacy_subdev-v1-0-f859ac9a01e3@chromium.org>
 <CANiDSCuq483Eha-KfUM_1y4zb0sC8rNgf-yki5SjiUo3czaKBw@mail.gmail.com> <CAEDqmY7XqqFrQCEMFe3kmOFJkgOcHoJcUH5bJAueyH0oQivzmw@mail.gmail.com>
In-Reply-To: <CAEDqmY7XqqFrQCEMFe3kmOFJkgOcHoJcUH5bJAueyH0oQivzmw@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 8 Mar 2023 23:57:04 +0100
X-Gmail-Original-Message-ID: <CANiDSCtdx2URrXCy+T5VOWejqP8V-jVLqa2P9RXNbc2vbZnzog@mail.gmail.com>
Message-ID: <CANiDSCtdx2URrXCy+T5VOWejqP8V-jVLqa2P9RXNbc2vbZnzog@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] meida: uvcvideo: reimplement privacy gpio as a
 separate subdevice
To:     Yunke Cao <yunkec@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 at 06:46, Yunke Cao <yunkec@chromium.org> wrote:
>
> Hi!
>
> On Fri, Jan 13, 2023 at 5:26 PM Ricardo Ribalda <ribalda@chromium.org> wrote:
> >
> > Hi Yunke
> >
> > Thank you very much for the patchset :)
> >
> > On Wed, 11 Jan 2023 at 09:52, Yunke Cao <yunkec@chromium.org> wrote:
> > >
> > > privacy_gpio in uvc were added as V4L2_CID_PRIVACY in uvc video node in
> > > https://lore.kernel.org/all/20201223133528.55014-1-ribalda@chromium.org/
> > >
> > > Userspace applications often require to constantly poll privacy control.
> > > Currently, polling privacy control requires keeping the video node open,
> > > which prevents the camera from autosuspending.
> > >
> > > This patchset adds a separate v4l2 subdevice. Userspace access the gpio
> > > via V4L2_CID_PRIVACY in the new subdevice. Applications can poll the
> > > privacy control status without opening the video node and activate the
> > > camera.
> > >
> > > The non-gpio V4L2_CID_PRIVACY in uvc is not affected.
> >
> > Since this is a RFC, lets focus on the idea and not on the code itself.
> >
> > - I am missing a reference to the subdevice from the media device. How
> > will a user figure out that /dev/v4l-subdev0 is the privacy gpio of
> > /dev/media0 and not /dev/media1?. Thake a look to the "ancillary
> > links"
> > - We have already exposed the control as part of the main video
> > device, that means that we need to keep that API. The control on
> > /dev/v4l-subdev0 should "mirror" the control on /dev/video0
> > - There is no need to v4l2_ctrl_fill_event(), if you modify the
> > control with a set controll function, the media controller should take
> > care of everything
>
> Thanks! I will fix these in the next version if we decide to proceed.
>
> >
> > @Sakari Ailus @Hans Verkuil : Assuming a correct implementation, how
> > would you feel about exposing a privacy gpio as a subdevice?
> >
>
> Sakari, Hans, do you think this idea makes sense?

Friendly ping

>
> Best,
> Yunke
>
> >
> > Thanks!!!
> >
> >
> > >
> > > Suggested-by: Ricardo Ribalda <ribalda@chromium.org>
> > > Signed-off-by: Yunke Cao <yunkec@chromium.org>
> > > ---
> > > Yunke Cao (3):
> > >       media: v4l2-ctrls: Expose v4l2_ctrl_fill_event()
> > >       media: uvcvideo: remove entity privacy control in the uvc video node
> > >       media: uvcvideo: reimplement privacy GPIO as a separate subdevice
> > >
> > >  drivers/media/usb/uvc/uvc_ctrl.c          | 17 -------
> > >  drivers/media/usb/uvc/uvc_driver.c        | 44 ++----------------
> > >  drivers/media/usb/uvc/uvc_entity.c        | 76 +++++++++++++++++++++++++++++++
> > >  drivers/media/usb/uvc/uvcvideo.h          | 19 +++++---
> > >  drivers/media/v4l2-core/v4l2-ctrls-core.c |  9 ++--
> > >  include/media/v4l2-ctrls.h                | 12 +++++
> > >  6 files changed, 111 insertions(+), 66 deletions(-)
> > > ---
> > > base-commit: 7dd4b804e08041ff56c88bdd8da742d14b17ed25
> > > change-id: 20230111-uvc_privacy_subdev-1e7a167e86eb
> > >
> > > Best regards,
> > > --
> > > Yunke Cao <yunkec@chromium.org>
> >
> >
> >
> > --
> > Ricardo Ribalda



-- 
Ricardo Ribalda
