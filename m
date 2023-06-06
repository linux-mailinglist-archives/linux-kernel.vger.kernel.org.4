Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02468724A8B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbjFFRti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbjFFRtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:49:35 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCB210FF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:49:34 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126253223039.31.openmobile.ne.jp [126.253.223.39])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A7C302BC;
        Tue,  6 Jun 2023 19:49:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686073746;
        bh=Wfzm05QKSXtSKpr/M7q7S0IxtecYSBK8fJ2Y6B5EI7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ErqSfbfjEHkyXpnZVELPiDZOlZyVabpXFU9jTgUvAiAhE/M4elDW2I3AbLNTQuH1R
         FE/c6zTs01+nxiplb53owhiULMhkkLKdDMEBa8v9U7i+P0b7oorHQ4+1CCDkHbsg6O
         9U5MflNUkJW5dtTI56XnnZ0WPEoeS4Sr4R5Cp7lk=
Date:   Tue, 6 Jun 2023 20:49:28 +0300
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
Message-ID: <20230606174928.GB14101@pendragon.ideasonboard.com>
References: <cover.1686047727.git.code@siddh.me>
 <20230606150545.GJ5197@pendragon.ideasonboard.com>
 <18891c17458.393a54b1127185.1502341592143085000@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18891c17458.393a54b1127185.1502341592143085000@siddh.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 10:59:14PM +0530, Siddh Raman Pant wrote:
> On Tue, 06 Jun 2023 20:35:45 +0530, Laurent Pinchart wrote:
> > This is a nice series, thank you for working on that.
> > 
> > Now that the deprecated macros are used in drivers only, would it make
> > sense to move them to a drm_print_deprecated.h header, to make sure no
> > new driver uses them ?
> 
> Sure, but then should that header be included wherever drm_print.h is
> included with a find and replace, to avoid breakage?

The idea would be to include the drm_print_deprecated.h header in
drivers that still use the deprecated macros.

> Not every file can be seen at a case-by-case basis or by coccinelle
> as far as I understand its usage. Consider the following:
> 
> DRM_INFO is used on line 210 of amd/amdgpu/amdgpu_acpi.c, but the
> file does not even include drm_print.h directly. It includes the
> amdgpu.h header, which includes the amdgpu_ring.h header, which
> finally has the "#include <drm/drm_print.h>" line.
> 
> If a simple find and replace has to be done, then that can be added
> at the end of the series.

Maybe a simple grep for the deprecated macros would be enough to
identify all the files that still use them ?

-- 
Regards,

Laurent Pinchart
