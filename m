Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E56E7246C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbjFFOt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238161AbjFFOtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:49:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C182123
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:48:05 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126253223039.31.openmobile.ne.jp [126.253.223.39])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8606BAB;
        Tue,  6 Jun 2023 16:47:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686062830;
        bh=K2gaqtTkXezyTdLUzCJIlQtK/ygyOYqpgIB0q9PaxfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vzOfTt1vxgtrmOZvXfsCF6chsV584A/W8ybzo3wzv/vxa3giRlx7M1ZhvfNUlMi3B
         MnDX8tDTEI+TCIn08KRw1m360AwRqBHS473hiUtqfMpDjvX6Kmnl/BRmjQuqgKaqkr
         FxuQ6fJwJ7O7Ms2Msi2ee1Eo76nZQKnW/eKWUbH0=
Date:   Tue, 6 Jun 2023 17:47:32 +0300
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
Subject: Re: [PATCH v9 2/8] drm/print: Fix and add support for NULL as first
 argument in drm_* macros
Message-ID: <20230606144732.GG5197@pendragon.ideasonboard.com>
References: <cover.1686047727.git.code@siddh.me>
 <ae42791195a788bb77b3f9c2b87bca5d4e78cf83.1686047727.git.code@siddh.me>
 <20230606140512.GA5197@pendragon.ideasonboard.com>
 <18891219d8e.6a7d8f15119986.32609419593331086@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18891219d8e.6a7d8f15119986.32609419593331086@siddh.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:04:39PM +0530, Siddh Raman Pant wrote:
> On Tue, 06 Jun 2023 19:35:12 +0530, Laurent Pinchart wrote:
> > Hi Siddh,
> > 
> > Thank you for the patch.
> 
> Anytime :)
> 
> > On Tue, Jun 06, 2023 at 04:15:16PM +0530, Siddh Raman Pant wrote:
> > > Comments say macros DRM_DEBUG_* are deprecated in favor of
> > > drm_dbg_*(NULL, ...), but they have broken support for it,
> > > as the macro will result in `(NULL) ? (NULL)->dev : NULL`.
> > 
> > What's the problem there ?
> 
> (NULL)->dev is invalid C. It's a macro, so preprocessor substitutes
> that text directly, there is no evaluation. GCC will throw an error
> regarding dereferencing a void* pointer.
> 
> > >  /* Helper for struct drm_device based logging. */
> > >  #define __drm_printk(drm, level, type, fmt, ...)                     \
> > > -     dev_##level##type((drm)->dev, "[drm] " fmt, ##__VA_ARGS__)
> > > +({                                                                   \
> > > +     struct device *__dev_ = __drm_dev_ptr(drm);                     \
> > > +     if (__dev_)                                                     \
> > > +             dev_##level##type(__dev_, "[drm] " fmt, ##__VA_ARGS__); \
> > > +     else                                                            \
> > > +             pr_##level##type("[drm] " fmt, ##__VA_ARGS__);          \
> > 
> > If I recall correctly, dev_*() handle a NULL dev pointer just fine. Do
> > we need to manually fall back to pr_*() ?
> 
> I took drm_dev_printk (on line 261 of drm_print.c) as the reference,
> wherein it uses a conditional for determining whether dev_printk or
> printk should be called.
> 
> I suppose it is to avoid printing "(NULL device *)", which dev_printk
> does if it gets a NULL device pointer (refer the definition on line
> 4831 of drivers/base/core.c). Though if I'm wrong, kindly let me know.

You're right, it's probably best to avoid the "(NULL device *)".

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
