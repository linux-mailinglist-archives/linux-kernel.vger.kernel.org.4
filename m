Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E566608C6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbjAFVVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbjAFVUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:20:24 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6304684605
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 13:19:54 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w13so1179447wrk.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 13:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8w9WwD8cU2sQXh0jUahrAS8aHOv0f+YBYRs6lEtmg5Y=;
        b=SwR0Sc5cdgkg+mkvu6a3CJHKQL0OejJJ1UVxD8va7F59QP/HTDoX7BJZMHJ4wA5cUu
         aHJJiex6JlUC2CVpCYbC6ubNLhZfKI+sODLh/OHlscJY5sOnEhpiYDVqrlIJEfelKfpP
         UcGIrGMBhr4baq4nUgAr5PdpyouKVr3EhkFjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8w9WwD8cU2sQXh0jUahrAS8aHOv0f+YBYRs6lEtmg5Y=;
        b=thSYS4dxqMxSq0MsEyZdhjz5zyFo3Y78v8lUx8Ymbfae4JyHurS4xgecQmkXb5Aofq
         vz3JcvM6oMAZz3YSle/2VsY7pbSiYfGXzX6tJo7Nwp63EBWWtXeX4dJBVvLHikL4bPv7
         YJkr9VbmgJ0NcnyakSCJmpIBFpqGCEcuYzTD+xwk7kAxwMtetB2Hx8belI2jnjtITTZW
         b2B2rM5ItfIsM+GHiuFLbZgmInH4zcECLy8XYsGw77W+92caY48Zi6yjme6KSKX3RiU8
         wWa7lXYXfIllRGQwb/1dJRtkoylf74EXVU1XdL308hfidMrhzCUvvg7HslfZ3d4qlWfX
         jYgg==
X-Gm-Message-State: AFqh2kq1jEdE94nBPmr+Dn6ZLdAKfM64wdBpR5iE3JVUW5jVT9I8nTQ+
        bc+HY/7i9E0J4LMfSUyCIxQAVw==
X-Google-Smtp-Source: AMrXdXua9Jskr4PiCR6lh7uqkSdITN6NhzScvm3xwzZMIh86YT0olwp/PfO66lwq/di/e5hf05XfBw==
X-Received: by 2002:adf:dc84:0:b0:29f:1d23:a4e9 with SMTP id r4-20020adfdc84000000b0029f1d23a4e9mr10695486wrj.21.1673039989904;
        Fri, 06 Jan 2023 13:19:49 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c4f5200b003c71358a42dsm10079885wmq.18.2023.01.06.13.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 13:19:49 -0800 (PST)
Date:   Fri, 6 Jan 2023 22:19:46 +0100
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
Message-ID: <Y7iQckF/6EMYVpQt@phenom.ffwll.local>
Mail-Followup-To: Hang Zhang <zh.nvgt@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20221230063528.41037-1-zh.nvgt@gmail.com>
 <2711de96-fcbe-5611-657a-ab29becd2ff6@gmx.de>
 <CAKMK7uEOX5n64cjzMt9GRQaS13HFPFyOeqdrkmzc035U5_T8tg@mail.gmail.com>
 <CAKMK7uE7CAXO50JPQ6ziQGGehqfDK2UanBQbfLdUH2RwrwXUvw@mail.gmail.com>
 <CAO2zrtYDcOfvxpG6wPghPnWZVks+NL6N9VaynsBVoX7nHBcxuw@mail.gmail.com>
 <Y7hvhtHeivfsnBtE@phenom.ffwll.local>
 <CAO2zrtb9H=OWPbrgmqTxQnHqETt-P4K6AxiwdtN7guxUYL2NCw@mail.gmail.com>
 <Y7h++5sU/hGJ/yTS@phenom.ffwll.local>
 <CAO2zrtaB3GZRSzgWu2kV_jTojwuhtL_kFz0gpzPPVGe9D8kVbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO2zrtaB3GZRSzgWu2kV_jTojwuhtL_kFz0gpzPPVGe9D8kVbQ@mail.gmail.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 03:25:14PM -0500, Hang Zhang wrote:
> On Fri, Jan 6, 2023 at 3:05 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Fri, Jan 06, 2023 at 02:58:27PM -0500, Hang Zhang wrote:
> > > On Fri, Jan 6, 2023 at 1:59 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > BTW, if this is worthed a fix and the performance of console_lock() is a
> > > major concern, then I think there may be alternative solutions like adding
> > > a lock_fb_info() to the free call chain - if that's better in performance,
> > > or maybe selectively protect the matroxfb ioctl but not vblank ioctl as you
> > > mentioned.
> >
> > Please start out with explaining what kind of bug your checker is seeing,
> > and why. Not how you're trying to fix it. Because I'm pretty sure there
> > isn't a bug, but since I've already spent a pile of time looking at this,
> > I want to make sure.
> 
> We are sorry for the inconvenience caused, we'll follow these practices and
> guidelines in the future. Thank you!

Once more: Please explain what you're static checker is seeing. I want to
understanding this, and I'm hoping at least someone involved in this
static checker can explain what it thinks is going on.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
