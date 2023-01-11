Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5366660BE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjAKQjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjAKQiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:38:52 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B893C0E2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:37:39 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d17so15653992wrs.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNcAm61iAySQJqIY5yrqQqnARMxhOPJyTu3V45Qh3B4=;
        b=Wsf1gzOfYz484Fd8gRg9knlJo6sULkvZmRsR+APG0hxY9wsH9hOqGOtF46uSyZufq8
         Wnyx86Q8KrpuNWQUqQMbL6EbCKdBUNcb5pCsWY2/XQpjo4TITNHONPffVBZn7BgX3pMv
         Hiss/i1f9hT+aZKioam7ZI8XSHp3Ie83nOSSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNcAm61iAySQJqIY5yrqQqnARMxhOPJyTu3V45Qh3B4=;
        b=tgqHBhkq0qeLNZJSVA9p2xkf/Hl+IMInqhkTaChk4XqpNxyhDfQFtU8P+lursI5KNV
         AkxSAqJL283QKvih3xFuYgZ0pKdgeBgdIwkya8ex6YMeOt6E7UKF5FamyqvuUVQy19CM
         sPE6vFJSrTrN2LqONW1BQ5cQ+XMq/13VmBIQ2jMdCwrAdu7jGyogGKkL3IcZCI93ZpdV
         QOcqlYl3Jvplr2nSF51cCPPJezNmmj3tHZDD4VomUF6Z93hM/HqcxtBR6R/KTGOdgwcs
         yH3B9h2WE7wTHb9VzEKpdsp8npbj9D/g5lbeC9zVf9xhPs10/Na2lKcJPUMJaZWWhEOd
         mTug==
X-Gm-Message-State: AFqh2kreb9g+bQtI0MS/88HROv2ytOF6Xwa3FnQJR1YDC35yagMs+KuZ
        2KeXKrVnMO/8eFnAXDGtF6reqw==
X-Google-Smtp-Source: AMrXdXt16zU0EExgUq8c0W1j51fFIxKt69JblEHiwf9Zq+l7bev/4D3WyyD5dTsKur6qsFlRC79pEw==
X-Received: by 2002:adf:e19a:0:b0:241:fbef:29b5 with SMTP id az26-20020adfe19a000000b00241fbef29b5mr64274070wrb.13.1673455054406;
        Wed, 11 Jan 2023 08:37:34 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t19-20020a0560001a5300b002362f6fcaf5sm14197045wry.48.2023.01.11.08.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 08:37:33 -0800 (PST)
Date:   Wed, 11 Jan 2023 17:37:31 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Aaron Plattner <aplattner@nvidia.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 11/11] video/aperture: Only remove sysfb on the default
 vga pci device
Message-ID: <Y77lyzPOUt8JAyPX@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Aaron Plattner <aplattner@nvidia.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
 <20230111154112.90575-11-daniel.vetter@ffwll.ch>
 <2102a618-2d5e-c286-311f-30e4baa4f85b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2102a618-2d5e-c286-311f-30e4baa4f85b@suse.de>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 05:20:00PM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 11.01.23 um 16:41 schrieb Daniel Vetter:
> > This fixes a regression introduced by ee7a69aa38d8 ("fbdev: Disable
> > sysfb device registration when removing conflicting FBs"), where we
> > remove the sysfb when loading a driver for an unrelated pci device,
> > resulting in the user loosing their efifb console or similar.
> > 
> > Note that in practice this only is a problem with the nvidia blob,
> > because that's the only gpu driver people might install which does not
> > come with an fbdev driver of it's own. For everyone else the real gpu
> > driver will restor a working console.
> > 
> > Also note that in the referenced bug there's confusion that this same
> > bug also happens on amdgpu. But that was just another amdgpu specific
> > regression, which just happened to happen at roughly the same time and
> > with the same user-observable symptons. That bug is fixed now, see
> > https://bugzilla.kernel.org/show_bug.cgi?id=216331#c15
> > 
> > For the above reasons the cc: stable is just notionally, this patch
> > will need a backport and that's up to nvidia if they care enough.
> > 
> > References: https://bugzilla.kernel.org/show_bug.cgi?id=216303#c28
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Aaron Plattner <aplattner@nvidia.com>
> > Cc: Javier Martinez Canillas <javierm@redhat.com>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: <stable@vger.kernel.org> # v5.19+ (if someone else does the backport)
> > ---
> >   drivers/video/aperture.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
> > index ba565515480d..a1821d369bb1 100644
> > --- a/drivers/video/aperture.c
> > +++ b/drivers/video/aperture.c
> > @@ -321,15 +321,16 @@ int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *na
> >   	primary = pdev == vga_default_device();
> > +	if (primary)
> > +		sysfb_disable();
> > +
> 
> There's another sysfb_disable() in aperture_remove_conflicting_devices()
> without the branch but with a long comment.  I find this slightly confusing.
> 
> I'd rather add a branched sysfb_disable() plus the comment  to
> aperture_detach_devices(). And then add a 'primary' parameter to
> aperture_detach_devices(). In aperture_remove_conflicting_devices() the
> parameter would be unconditionally true.

Yeah I was on the fence, but should be easy to redo with all the prep work
out of the way. It does mean we call sysfb_disable once for every bar, but
that shouldn't matter in any reasonable case :-)
-Daniel

> 
> Best regards
> Thomas
> 
> >   	for (bar = 0; bar < PCI_STD_NUM_BARS; ++bar) {
> >   		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
> >   			continue;
> >   		base = pci_resource_start(pdev, bar);
> >   		size = pci_resource_len(pdev, bar);
> > -		ret = aperture_remove_conflicting_devices(base, size, name);
> > -		if (ret)
> > -			return ret;
> > +		aperture_detach_devices(base, size);
> >   	}
> >   	if (!primary)
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Ivo Totev




-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
