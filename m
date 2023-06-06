Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944857249EA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbjFFROA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjFFRN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:13:58 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4752318E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:13:57 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126253223039.31.openmobile.ne.jp [126.253.223.39])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E828BAB;
        Tue,  6 Jun 2023 19:13:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686071610;
        bh=Y4+aPNtD+8i5z2EkM/v0YcopLYBAi67VEz/R3NjWN3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kNaEjfV2/a9eQ5DBvaWRM3349hA8qEN9AA3xbrvZfiPkX/PMcNC47Pp1asekxx3pe
         TosYoyjh3/lkGnyJ5kmk0lyZ+ZJ+5t6XZoW36Tqoj7wLNANrm5glEOXxK6KgS0HNn2
         hIJaumLsOUCR8REHqgA1gEp5Z1xXh9/XnDTh6blo=
Date:   Tue, 6 Jun 2023 20:13:51 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Suraj Upadhyay <usuraj35@gmail.com>
Subject: Re: [PATCH v9 5/8] drm: Remove usage of deprecated DRM_ERROR
Message-ID: <20230606171351.GK25679@pendragon.ideasonboard.com>
References: <cover.1686047727.git.code@siddh.me>
 <247297c1171bc0ddbde0e90d33961fd5636caf0f.1686047727.git.code@siddh.me>
 <20230606144452.GE5197@pendragon.ideasonboard.com>
 <18891ac9112.109b85f8126467.5521217359687209203@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18891ac9112.109b85f8126467.5521217359687209203@siddh.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 10:36:25PM +0530, Siddh Raman Pant wrote:
> On Tue, 06 Jun 2023 20:14:52 +0530, Laurent Pinchart wrote:
> > Hi Siddh,
> > 
> > Thank you for the patch.
> 
> Anytime :)
> 
> > >       if (!crtcs || !modes || !enabled || !offsets) {
> > > -             DRM_ERROR("Memory allocation failed\n");
> > > +             drm_err(client->dev, "Memory allocation failed\n");
> > 
> > We could probably drop this message as memory allocation functions are
> > already vocal on failure, but that's a separate fix.
> 
> Okay. Should I send a patch at the end of the series removing the
> superfluous messages you pointed out in drm core?

That would be nice, thanks.

> > >       if (!drm_core_init_complete) {
> > > -             DRM_ERROR("DRM core is not initialized\n");
> > > +             drm_err(NULL, "DRM core is not initialized\n");
> > 
> > Could this use dev ?
> 
> No, the drm_device's dev pointer is assigned later. See line 621.
> 
> > >       if (!vma_offset_manager) {
> > > -             DRM_ERROR("out of memory\n");
> > > +             drm_err(dev, "out of memory\n");
> > 
> > Same here, I think the message could be dropped.
> 
> Okay.
> 
> > >       if (!ht->table) {
> > > -             DRM_ERROR("Out of memory for hash table\n");
> > > +             drm_err(NULL, "Out of memory for hash table\n");
> > 
> > Same.
> 
> Okay.
>  
> > With the commit message fixed as mentioned in the review of an earlier
> > patch in this series, and the issue in drm_dev_init() addressed if
> > needed,
> > 
> > Reviewed-by: Laurent Pinchart laurent.pinchart+renesas@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
