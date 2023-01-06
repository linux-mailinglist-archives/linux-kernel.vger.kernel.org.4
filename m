Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FB66609AC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjAFWrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjAFWq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:46:57 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331C485CBA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 14:46:56 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so4618496wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 14:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzqP04USoFIby+HEXep+3hJAGRxvsp5L+xLira7xfHg=;
        b=gfw7TY3dKnUK/QGyYCdXS9j6zn3HRs3r64YEs5PPtxKUu5b7cb1NGSMmS4vCE3qSuU
         OvSSUAFk+9rBRp9a9JJFYCGhVGlgfJ3lDjIDIqPTV7nKzXonqiDG4DB5+WkRIE1QfLXi
         wKnqyXYXC1u+fLaTfS+Sh20g7fQvee7Wjysx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzqP04USoFIby+HEXep+3hJAGRxvsp5L+xLira7xfHg=;
        b=NRi4F3dUOj9/UAkfeH7MaRjxaXSrCNvcIpConG5j6Wd1ATC+62ZWXGdPNPjjOlKNO+
         CMTSNIM/nUAmGIUAmRbkOhcBuULXmOpJSPfIARMnuv6x9+2YvmuoUCH3T3bV/eJta53C
         /3UNVuuw4ZJGSfsk5aaTkBrOUY9/Dr/uIwJyXatxallP/sXfQxvdZ13ebRH1NO+URSs0
         cR5gzZa/Dx6tM8u7lsF1KVlF/nqqgiWKRaUyC9gEdmBwMiPRgr0VZwKQ/I+YApup6bdf
         Fiax2K4YM1SqhKpZ/7jmCol3YKhX9w/A1npvAJK5hitJcmcWtpQC5UK6gVrgQmdPRzfW
         vlIw==
X-Gm-Message-State: AFqh2koCIYiu+hqDFPHmOWVZ5a2xMl80mG9ZRVtnS4guXFw8KrDDOn2t
        7cg0jmA4sZ9+bJA6t7IoNjJDS45nNa2Xwkbm
X-Google-Smtp-Source: AMrXdXslz4blP81M3W6GoFIqzvARXTxMb6uRo+Cakzp+vFWOecq/6a74aUHECo6VNF8l8x7L4fm6JQ==
X-Received: by 2002:a05:600c:ace:b0:3d1:fe0a:f134 with SMTP id c14-20020a05600c0ace00b003d1fe0af134mr40601523wmr.19.1673045214780;
        Fri, 06 Jan 2023 14:46:54 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d8-20020a05600c34c800b003c5571c27a1sm3771606wmq.32.2023.01.06.14.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 14:46:54 -0800 (PST)
Date:   Fri, 6 Jan 2023 23:46:52 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Hang Zhang <zh.nvgt@gmail.com>
Cc:     Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] fbmem: prevent potential use-after-free issues with
 console_lock()
Message-ID: <Y7ik3ONV5ba7UXQB@phenom.ffwll.local>
Mail-Followup-To: Hang Zhang <zh.nvgt@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <2711de96-fcbe-5611-657a-ab29becd2ff6@gmx.de>
 <CAKMK7uEOX5n64cjzMt9GRQaS13HFPFyOeqdrkmzc035U5_T8tg@mail.gmail.com>
 <CAKMK7uE7CAXO50JPQ6ziQGGehqfDK2UanBQbfLdUH2RwrwXUvw@mail.gmail.com>
 <CAO2zrtYDcOfvxpG6wPghPnWZVks+NL6N9VaynsBVoX7nHBcxuw@mail.gmail.com>
 <Y7hvhtHeivfsnBtE@phenom.ffwll.local>
 <CAO2zrtb9H=OWPbrgmqTxQnHqETt-P4K6AxiwdtN7guxUYL2NCw@mail.gmail.com>
 <Y7h++5sU/hGJ/yTS@phenom.ffwll.local>
 <CAO2zrtaB3GZRSzgWu2kV_jTojwuhtL_kFz0gpzPPVGe9D8kVbQ@mail.gmail.com>
 <Y7iQckF/6EMYVpQt@phenom.ffwll.local>
 <CAO2zrtY+mMBTLimW6aZhOGFqqw53EVdP0CT8ieW6iVUXevZ7ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO2zrtY+mMBTLimW6aZhOGFqqw53EVdP0CT8ieW6iVUXevZ7ag@mail.gmail.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 05:12:57PM -0500, Hang Zhang wrote:
> On Fri, Jan 6, 2023 at 4:19 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Fri, Jan 06, 2023 at 03:25:14PM -0500, Hang Zhang wrote:
> > > On Fri, Jan 6, 2023 at 3:05 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > On Fri, Jan 06, 2023 at 02:58:27PM -0500, Hang Zhang wrote:
> > > > > On Fri, Jan 6, 2023 at 1:59 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > > BTW, if this is worthed a fix and the performance of console_lock() is a
> > > > > major concern, then I think there may be alternative solutions like adding
> > > > > a lock_fb_info() to the free call chain - if that's better in performance,
> > > > > or maybe selectively protect the matroxfb ioctl but not vblank ioctl as you
> > > > > mentioned.
> > > >
> > > > Please start out with explaining what kind of bug your checker is seeing,
> > > > and why. Not how you're trying to fix it. Because I'm pretty sure there
> > > > isn't a bug, but since I've already spent a pile of time looking at this,
> > > > I want to make sure.
> > >
> > > We are sorry for the inconvenience caused, we'll follow these practices and
> > > guidelines in the future. Thank you!
> >
> > Once more: Please explain what you're static checker is seeing. I want to
> > understanding this, and I'm hoping at least someone involved in this
> > static checker can explain what it thinks is going on.
> >
> > Thanks, Daniel
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> 
> Thank you for your interest, Daniel. The checker tries first to find
> the free and
> use sites of a certain object (in this case "fb_info"), then reason
> about whether
> the use can actually happen after the free (e.g., taking into account
> factors like
> state set/check, locks, etc.), if so, it will flag a potential
> use-after-free. As a static
> checker, is doesn't execute a program or generate a PoC. We then manually
> review each flagged issue by inspecting all related code. In this
> case, the checker
> (and us) are unaware of the lifetime management logic, which may cause
> problems.

Lifetime management is and absolute basic part in the linux kernel. So if
your checker flags every free which isn't protected by a lock, then you'll
creating endless amounts of false positives. Is this really what you're
doing?

I'm still very confused ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
