Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCA47252DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 06:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjFGEdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 00:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFGEce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 00:32:34 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061B81FF7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 21:30:46 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126233170111.36.openmobile.ne.jp [126.233.170.111])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D56332B6;
        Wed,  7 Jun 2023 06:30:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686112218;
        bh=yOoSdsEWv7NH++TRQ7A5AmADmeDU2Han4n3O5WQdd6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvZo1H58PEsl6InTU6IxfFDp2EM0i5JqO9H2PALxEzwv5QTBy2CrSv4cboL7MwraX
         /9NK+8D8Z8GzJpritnYhWXoTOrAbPDV16Co2PYPKUilY3tm+nfq/wwBVALvgbUjJy9
         J1e9b+wsuI6fvc/1k+c0NTD2pBEJB4+AXLWv3pTo=
Date:   Wed, 7 Jun 2023 07:30:41 +0300
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
Subject: Re: [PATCH v9 0/8] drm: Remove usage of deprecated DRM_* macros
Message-ID: <20230607043041.GE14101@pendragon.ideasonboard.com>
References: <cover.1686047727.git.code@siddh.me>
 <20230606150545.GJ5197@pendragon.ideasonboard.com>
 <18891c17458.393a54b1127185.1502341592143085000@siddh.me>
 <20230606174928.GB14101@pendragon.ideasonboard.com>
 <18891edf10b.42f0ffa4128414.8582548531031990480@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18891edf10b.42f0ffa4128414.8582548531031990480@siddh.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 11:47:50PM +0530, Siddh Raman Pant wrote:
> On Tue, 06 Jun 2023 23:19:28 +0530, Laurent Pinchart wrote:
> > The idea would be to include the drm_print_deprecated.h header in
> > drivers that still use the deprecated macros.
> 
> Yeah, what I meant was in a "first pass" kind of sense.
> 
> > > Not every file can be seen at a case-by-case basis or by coccinelle
> > > as far as I understand its usage. Consider the following:
> > > 
> > > DRM_INFO is used on line 210 of amd/amdgpu/amdgpu_acpi.c, but the
> > > file does not even include drm_print.h directly. It includes the
> > > amdgpu.h header, which includes the amdgpu_ring.h header, which
> > > finally has the "#include " line.
> > > 
> > > If a simple find and replace has to be done, then that can be added
> > > at the end of the series.
> > 
> > Maybe a simple grep for the deprecated macros would be enough to
> > identify all the files that still use them ?
> 
> Hmm, so the drm_print_deprecated.h should be included individually on
> all the files, regardless of whether they include drm_print.h directly
> or not?
> 
> Actually that makes sense, so further inclusion of top-level header
> would not automatically include the deprecated macros.

That's the idea, yes. It would also clearly flag drivers that need to be
converted to the new macros.

> Since this needs some thought, I will be sending v10 without this.
> This change can be sent later separately, as it will anyways be a
> huge patch, and 10 is already a big enough revision number.

Sounds good to me.

-- 
Regards,

Laurent Pinchart
