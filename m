Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE75666304
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbjAKSsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbjAKSr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:47:56 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B3B3C732
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 10:47:55 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id y205so3496219iof.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 10:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4OQq5enpe7uRtVIP5uPdIxkFgnD6rZwRWFBHq4d9gkI=;
        b=ZtKOhPcK0GTSIlyIhnr2fU5AT2NjJlk9UJoPOyfsMLRjdllYyKV64qjazsNzsOMmlb
         FSAXVnBCYdeNYH6c633YANE2da8Qlbt7Z5sSxP6r15a2vAurfB7QS53Wu9AxWhoPqKtS
         m0DfctcTOF/KMp62PgaFXDDsWPHJKilO17tx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OQq5enpe7uRtVIP5uPdIxkFgnD6rZwRWFBHq4d9gkI=;
        b=K9j9IPL7Tjzcx+Ic5O4blvpc4cVDaQY0k7vnPv31YCZGMuhxjiLcVRtdMKpp+xHarT
         NnPMKVfM+SKkb8YqT+SeaT8ZUlwOdYly17muDFLKuCCK7iJvz6j/5u/TwK5CM2Cklrt3
         m68nOmvVWJ0JA3TTXPIEf2rzybffckuZ+sMpB/yszTrYZw4BDkR5xGg07ohgOUl57dXc
         FhS+cwdgiq/8UtABsyHNBK2/do17CLbzZc4PdHO15kQeGGEH6/6kBVxjr+aMYfEQK31Y
         tQSTjjHsTcHY9ViE1SJ8coinbUzY42VuhNXeL/5wXIrKopaq2DtcbXLgh7y72lJJ0Vth
         0JDA==
X-Gm-Message-State: AFqh2kpK5C2g06EuEQFZgR07udC0MHKTmU65LjMHGz2B4MndW8Jprome
        9i2+7k8FgOc6RCR01SWV8jlfkA==
X-Google-Smtp-Source: AMrXdXtim/CfcPszSVRQEjo3AWNfMIwqK9s+RWgNA+uETTtDhb+IUaVTvMGd99fgsRm1V6tSDRdbPA==
X-Received: by 2002:a6b:bd05:0:b0:6eb:3bcc:a9ca with SMTP id n5-20020a6bbd05000000b006eb3bcca9camr51838960iof.8.1673462875113;
        Wed, 11 Jan 2023 10:47:55 -0800 (PST)
Received: from chromium.org ([2620:15c:183:200:632c:a4be:969f:51ab])
        by smtp.gmail.com with ESMTPSA id e2-20020a056602158200b006dfa5af69f5sm5320863iow.0.2023.01.11.10.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 10:47:54 -0800 (PST)
Date:   Wed, 11 Jan 2023 11:47:52 -0700
From:   Drew Davenport <ddavenport@chromium.org>
To:     "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
Cc:     "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "Heikkila, Juha-pekka" <juha-pekka.heikkila@intel.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915/display: Check source height is > 0
Message-ID: <Y78EWH8YCdkHZrvP@chromium.org>
References: <20221226225246.1.I15dff7bb5a0e485c862eae61a69096caf12ef29f@changeid>
 <e9cfd7b7b23294592192869bd16a20596f3276c2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9cfd7b7b23294592192869bd16a20596f3276c2.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 05:55:17PM +0000, Teres Alexis, Alan Previn wrote:
> Is there a better place for this check higher up the intel specific atomic-check? (so the check won't be skl specific - i notice that intel_adjusted_rate is also called by
> ilk_foo as well and non-backend-specific functions). Else, perhaps intel_adjusted_rate should add a check + WARN? (if we are trying to propagate this slowly across HW).

Would intel_plane_atomic_check_with_state be a more appropriate
place to check that the src width and height are at least 1? This is
where skl_plane_check and other HW's foo_plane_check functions are called
from.

I don't think that the potential divide-by-zero will be hit in the case
where intel_adjusted_rate is called from ilk_pipe_pixel_rate because the
src rect will not have a fractional part to it in this case. I'm assuming
that something earlier on would catch and reject a src with zero
width/height.

Drew

> 
> 
> ...alan 
> 
> On Mon, 2022-12-26 at 22:53 -0700, Drew Davenport wrote:
> > The error message suggests that the height of the src rect must be at
> > least 1. Reject source with height of 0.
> > 
> > Signed-off-by: Drew Davenport <ddavenport@chromium.org>
> > 
> > ---
> > I was investigating some divide-by-zero crash reports on ChromeOS which
> > pointed to the intel_adjusted_rate function. Further prodding showed
> > that I could reproduce this in a simple test program if I made src_h
> > some value less than 1 but greater than 0.
> > 
> > This seemed to be a sensible place to check that the source height is at
> > least 1. I tried to repro this issue on an amd device I had on hand, and
> > the configuration was rejected.
> > 
> > Would it make sense to add a check that source dimensions are at least 1
> > somewhere in core, like in drm_atomic_plane_check? Or is that a valid
> > use case on some devices, and thus any such check should be done on a
> > per-driver basis?
> > 
> > Thanks.
> > 
> >  drivers/gpu/drm/i915/display/skl_universal_plane.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
> > index 4b79c2d2d6177..9b172a1e90deb 100644
> > --- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
> > +++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
> > @@ -1627,7 +1627,7 @@ static int skl_check_main_surface(struct intel_plane_state *plane_state)
> >  	u32 offset;
> >  	int ret;
> >  
> > -	if (w > max_width || w < min_width || h > max_height) {
> > +	if (w > max_width || w < min_width || h > max_height || h < 1) {
> >  		drm_dbg_kms(&dev_priv->drm,
> >  			    "requested Y/RGB source size %dx%d outside limits (min: %dx1 max: %dx%d)\n",
> >  			    w, h, min_width, max_width, max_height);
> > -- 
> > 2.39.0.314.g84b9a713c41-goog
> > 
> 
