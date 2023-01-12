Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1071666EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjALKBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjALKAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:00:35 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3D8BE9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:59:06 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ss4so36154984ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6hhakTnHOXYkigiX8AOqUNYD4wS/fbrNoZrekC179k=;
        b=URXRY+j8e51xBHMw57lpKs/LMrFVB7x7mwxeG7bz2yZvwIBp2wOkbBMERLKwiAR8Yh
         fAFydpho93TTjF/nRVHVy1Z/3nlphqL+963OnecOhBhx47bdmFybz0UfVzq4dZTZfuRu
         SDd05QI+8MDE4VF0kvUSAfm74YnhefnA5rD4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6hhakTnHOXYkigiX8AOqUNYD4wS/fbrNoZrekC179k=;
        b=nm0VZtO2xbYYesnFLfl97TVEccehvQrgdH/oWTpTOWu7PGQyZet1ZIGR8ZknmpeXZt
         xGwGik7IzJhpZgoHxwHiRV6GR56raVRcqy+M+xyc7Be2onAqeJ6jXzElczvsKxaEJPPZ
         q3pPabIw72le3QXGumUwl3REmtNPkdip5MHqyNPhQEsHJwH45Up/ncOV8oUwJhnV6k3R
         ZWaZwQUIAfDZdnGZgxx2aheJ8Br//OQA/pYssW04PwQWvFGrXU8GPQiYZmj6+hjEduvy
         sbL6Ra7Qsa4n2NAAXcB1Pxk6He81O3SaE3aw5gfn/iqBi+FHADZbpXaOpNdhnu/TdkYx
         aXRg==
X-Gm-Message-State: AFqh2kqd60jKoorboX8psk4O1ToHodRyh28nsGIIurqa9mPlRiYtEP32
        dTJ0kucmM5LB0NZuy8qi/wMTXQ==
X-Google-Smtp-Source: AMrXdXsURD2ENiVSwBB98M3WPU/p/YghT0Cf4+cTjj1HWOa1VnfjeV2fgWrRZq2z1t/eBKEg/zFkNQ==
X-Received: by 2002:a17:907:c30c:b0:7c1:337e:5755 with SMTP id tl12-20020a170907c30c00b007c1337e5755mr40130811ejc.26.1673517544651;
        Thu, 12 Jan 2023 01:59:04 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709061f1600b0081bfc79beaesm7230567ejj.75.2023.01.12.01.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 01:59:03 -0800 (PST)
Date:   Thu, 12 Jan 2023 10:59:01 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 02/11] drm/gma500: Use
 drm_aperture_remove_conflicting_pci_framebuffers
Message-ID: <Y7/Z5dvADG6AspV3@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
 <20230111154112.90575-2-daniel.vetter@ffwll.ch>
 <bad82927-1c58-4c2a-c265-571e10d1f67d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bad82927-1c58-4c2a-c265-571e10d1f67d@suse.de>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:04:48AM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 11.01.23 um 16:41 schrieb Daniel Vetter:
> > This one nukes all framebuffers, which is a bit much. In reality
> > gma500 is igpu and never shipped with anything discrete, so there should
> > not be any difference.
> > 
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > ---
> >   drivers/gpu/drm/gma500/psb_drv.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
> > index cd9c73f5a64a..9b0daf90dc50 100644
> > --- a/drivers/gpu/drm/gma500/psb_drv.c
> > +++ b/drivers/gpu/drm/gma500/psb_drv.c
> > @@ -429,7 +429,7 @@ static int psb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >   	 * TODO: Refactor psb_driver_load() to map vdc_reg earlier. Then we
> >   	 *       might be able to read the framebuffer range from the device.
> >   	 */
> > -	ret = drm_aperture_remove_framebuffers(true, &driver);
> > +	ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev, &driver);
> 
> This does not work. The comment just above the changed line explains why.
> The device uses shared memory similar to other integrated Intel chips. The
> console is somewhere in a 16 MiB range, which has been stolen by the BIOS
> from main memory. There's only a 1 MiB memory range on the device to program
> the device. Unless you want to refactor as described, this call has to cover
> the whole memory for now.

Uh. So it's maybe not so pretty, but what if I just call both functions?
That way we get the vga handling through the pci one, and the "make sure
there's no fb left" through the other one. Plus comment of course.

Otherwise we'd need to somehow keep the vga stuff in the non-pci paths,
and that just feels all kinds of wrong to me.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
