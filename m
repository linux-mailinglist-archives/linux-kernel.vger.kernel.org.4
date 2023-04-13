Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125AD6E1594
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 22:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjDMUBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 16:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjDMUB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 16:01:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34608A52
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 13:01:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-2f44739a2afso84816f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 13:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681416085; x=1684008085;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LoVUNaZaM2XfpV6KT9jjTvveGKx0rUw/FJ3BSvzxFDA=;
        b=QeCMIubWV2ZxjUSHK/YaYnO6aOMuTOVF3qS7K8TyjovrtKBrfuYOPntlMgGyMFruap
         c2pdeQsFGbxIr4fcwVeuI0s1ofA8uh4RjAlceoeFGIgElrdzwRJLt3HV22O/VHwMWvPg
         g9WSb3e3rDnYTPjuzJDUr7MyGE1Sd0TR2PMXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681416085; x=1684008085;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LoVUNaZaM2XfpV6KT9jjTvveGKx0rUw/FJ3BSvzxFDA=;
        b=fNtPONWltmKEd4NGeiSGQgvrGv3+TxBuP+nFjyhooLdTUQlF+y55WZ+oD6Utm7w9zb
         7DG+bgEQK2IzyWqMEFxrQiQm0AHkuBsUmjPig+C1C9V68VBjYEZWRI3Vvh65K4rPfNJu
         OJo5FFHkSv1i7kp6zj/wHz2y5Sy6CALty2qcOrFFDEpORV3gZgLdeEizgGaX5hSZ1osQ
         3kD9nx4UEX7W6kRSmi4+G/QetVtIzDdJIwtrkuYx09R+jq/QzH68cz1WluIA/ij0nKX2
         c8A7NnDBH3wrjrsW7chZyTG+QEsXE/THuHQsvKU9LUnnPDrj+YNspjyqXL/oZoCT8zq6
         XLTw==
X-Gm-Message-State: AAQBX9cqm5Tu3snL7o0hX+K9yIP3lf6RxBrrukBPg3PCcmYm3eMOJ4by
        WAfzfYnj+1jtg0+Lbt6S/qXGew==
X-Google-Smtp-Source: AKy350Z+twkvFRjVeJgVSWcMWzX3CHPi3LHk5n6KqDKM64KPi/KoFdjY01LEeLcmORKirWVo8YW3iQ==
X-Received: by 2002:a05:600c:19cc:b0:3f0:80fe:212d with SMTP id u12-20020a05600c19cc00b003f080fe212dmr2932147wmq.3.1681416085158;
        Thu, 13 Apr 2023 13:01:25 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id l20-20020a7bc454000000b003ed2276cd0dsm2620041wmi.38.2023.04.13.13.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 13:01:24 -0700 (PDT)
Date:   Thu, 13 Apr 2023 22:01:22 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>, Li Yi <liyi@loongson.cn>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] drm/fbdev-generic: fix potential out-of-bounds access
Message-ID: <ZDhfkq92hbGc630z@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
        Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>, Li Yi <liyi@loongson.cn>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
References: <20230409132110.494630-1-15330273260@189.cn>
 <ZDV0Te65tSh4Q/vc@phenom.ffwll.local>
 <42f16d0d-4e1a-a016-f4cc-af24efa75f1c@189.cn>
 <ZDbuCWKfFlWyiOGp@phenom.ffwll.local>
 <dbac96b2-0fea-591b-517d-2a23cc36b8de@189.cn>
 <CAKMK7uG_h7htCDARudZpHOOMG4iOOLZmz0_WskvWGf+DKGwU1w@mail.gmail.com>
 <531f0bdf-2ae8-0361-183b-57b40df6345f@189.cn>
 <ZDhQW6El6ztyHK4M@phenom.ffwll.local>
 <1bbc7228-c2fe-0af0-c15c-b378bc4d111c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bbc7228-c2fe-0af0-c15c-b378bc4d111c@suse.de>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 09:20:23PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 13.04.23 um 20:56 schrieb Daniel Vetter:
> [...]
> > 
> > This should switch the existing code over to using drm_framebuffer instead
> > of fbdev:
> > 
> > 
> > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > index ef4eb8b12766..99ca69dd432f 100644
> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -647,22 +647,26 @@ static void drm_fb_helper_damage(struct drm_fb_helper *helper, u32 x, u32 y,
> >   static void drm_fb_helper_memory_range_to_clip(struct fb_info *info, off_t off, size_t len,
> >   					       struct drm_rect *clip)
> >   {
> > +	struct drm_fb_helper *helper = info->par;
> > +
> >   	off_t end = off + len;
> >   	u32 x1 = 0;
> >   	u32 y1 = off / info->fix.line_length;
> > -	u32 x2 = info->var.xres;
> > -	u32 y2 = DIV_ROUND_UP(end, info->fix.line_length);
> > +	u32 x2 = helper->fb->height;
> > +	unsigned stride = helper->fb->pitches[0];
> > +	u32 y2 = DIV_ROUND_UP(end, stride);
> > +	int bpp = drm_format_info_bpp(helper->fb->format, 0);
> 
> Please DONT do that. The code here is fbdev code and shouldn't bother about
> DRM data structures. Actually, it shouldn't be here: a number of fbdev
> drivers with deferred I/O contain similar code and the fbdev module should
> provide us with a helper. (I think I even had some patches somewhere.)

Well my thinking is that it's a drm driver, so if we have issue with limit
checks blowing up it makes more sense to check them against drm limits.
Plus a lot more people understand those than fbdev. They should all match
anyway, or if they dont, we have a bug. The thing is, if you change this
further to just pass the drm_framebuffer, then this 100% becomes a drm
function, which could be used by anything in drm really.

But also *shrug*.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
