Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484E866A25B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjAMSsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjAMSsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:48:11 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171342D8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:48:09 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ud5so54362561ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EG7jr/g9OljSlpvTsWEcmSixEQmShFVdzLVLaGMM5uM=;
        b=FHNytH06W0UmXriNfArsKvuBHWyeeP40z9gCwoD//tkNxKoF3yEHvkTmM2lpJYyPvh
         aUyQRjEdDyKDeYHV4ZnvgLw5xckxaKf3W0c5KQwF8eb11onD2e1VJmqQ2Atq0Kyojgno
         GKVKsYXK5U/vmuLBdCYPIZKreg21A3xg5cKdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EG7jr/g9OljSlpvTsWEcmSixEQmShFVdzLVLaGMM5uM=;
        b=DCYoOw49G5SOCcrrGdg0JQ5eMNJGfKkn+iNCon1oULs15UjBlx5mzuG7EcpIiVJrBV
         3zgDqWSu1Uh+Nut1fQRLME5B6bv+eWgdtNOXd5n/nlMxjjS7uSiSvEc3PGAf5a4ND3Rc
         8dJbD49YEOSyypgVWWYc+0VCTo2KmxMgnHMkLc7ubTdIaW5bd5fzjRwUkJcu2+PTxR8r
         EbTdfCMWaYy0EPAblx6o03WZh/q7vhSOt8AbzObuIU/stF0OJFLF5VAAhCS5TYLoR9wF
         oUb1lmwDaiZ2HYjUX/L0nSt4JZRPlFzHNiY2eeFA3ntRExdENX+RdpP1hmQ46ggarRpF
         ayQA==
X-Gm-Message-State: AFqh2kpDaMHCbanseEI+yo4YIhXotQ0ZCeCzLsynZHXGRCfN3vKfJ9xA
        sGSJ878s+D6gzNp+H3i4JgwTWw==
X-Google-Smtp-Source: AMrXdXsDpOBPrtmtkIdWBJZbgTmyQYDq0rUmqeQfEqwOFTt1cJYFl4hQ+nnqLt3BH5+kuiBBd52u2A==
X-Received: by 2002:a17:906:cec4:b0:84d:269c:760a with SMTP id si4-20020a170906cec400b0084d269c760amr23264615ejb.51.1673635687677;
        Fri, 13 Jan 2023 10:48:07 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k2-20020a170906970200b0073dbaeb50f6sm8691799ejx.169.2023.01.13.10.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:48:05 -0800 (PST)
Date:   Fri, 13 Jan 2023 19:48:03 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     jim.cromie@gmail.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, jbaron@akamai.com, gregkh@linuxfoundation.org,
        daniel.vetter@ffwll.ch
Subject: Re: [RFC PATCH 00/17] DRM_USE_DYNAMIC_DEBUG regression
Message-ID: <Y8GnY7k22KkG/AmN@phenom.ffwll.local>
Mail-Followup-To: jim.cromie@gmail.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, jbaron@akamai.com, gregkh@linuxfoundation.org
References: <20221206003424.592078-1-jim.cromie@gmail.com>
 <Y79Btep8JnPKvuAp@phenom.ffwll.local>
 <CAJfuBxxZ0Kjc0G5Ngv7bmokkC4AJKZ07OMCKyLmHBGSsjG7qfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfuBxxZ0Kjc0G5Ngv7bmokkC4AJKZ07OMCKyLmHBGSsjG7qfA@mail.gmail.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:29:57AM -0700, jim.cromie@gmail.com wrote:
> On Wed, Jan 11, 2023 at 4:09 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Mon, Dec 05, 2022 at 05:34:07PM -0700, Jim Cromie wrote:
> > > Hi everyone,
> > >
> > > DRM_USE_DYNAMIC_DEBUG=y has a regression on rc-*
> > >
> > > Regression is due to a chicken-egg problem loading modules; on
> > > `modprobe i915`, drm is loaded 1st, and drm.debug is set.  When
> > > drm_debug_enabled() tested __drm_debug at runtime, that just worked.
> > >
> > > But with DRM_USE_DYNAMIC_DEBUG=y, the runtime test is replaced with a
> > > post-load enablement of drm_dbg/dyndbg callsites (static-keys), via
> > > dyndbg's callback on __drm_debug.  Since all drm-drivers need drm.ko,
> > > it is loaded 1st, then drm.debug=X is applied, then drivers load, but
> > > too late for drm_dbgs to be enabled.
> > >
> > > STATUS
> > >
> > > For all-loadable drm,i915,amdgpu configs, it almost works, but
> > > propagating drm.debug to dependent modules doesnt actually apply,
> > > though the motions are there.  This is not the problem I want to chase
> > > here.
> > >
> > > The more basic trouble is:
> > >
> > > For builtin drm + helpers, things are broken pretty early; at the
> > > beginning of dynamic_debug_init().  As the ddebug_sanity() commit-msg
> > > describes in some detail, the records added by _USE fail to reference
> > > the struct ddebug_class_map created and exported by _DEFINE, but get
> > > separate addresses to "other" data that segv's when used as the
> > > expected pointer. FWIW, the pointer val starts with "revi".
> >
> > So I honestly have no idea here, linker stuff is way beyond where I have
> > clue. So what's the way forward here?
> >
> 
> Ive fixed this aspect.
> Unsurprisingly, it wasnt the linker :-}

Awesome!

> > The DEFINE/USE split does like the right thing to do at least from the
> > "how it's used in drivers" pov. But if we're just running circles not
> > quite getting there I dunno :-/
> > -Daniel
> >
> 
> Sending new rev next.
> I think its getting close.

Thanks a lot for keeping on pushing this.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
