Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341D56D950A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbjDFLZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbjDFLZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:25:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D352E61A7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:25:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-502aa0f24daso126725a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 04:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680780351;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hroPDDqbeK3KP3ft/vk5XXJhx4hlY+C3UjJVTgzuyfY=;
        b=VRl9UtQfF7A9tPxqhu/i6AA4YLuIE9ggXBEL9ZyuchaTkPNo7wuDK+vnz2hQ+0/bPw
         TSIKhRD6SA4Z5er4CXRULeRH39V+Y0WalgcRvaUTx8mpQ0PNTxILEYv9A50gi0EUOKyM
         42dwpNZOXYiJD2zR/Mrh1SlgOPF/McxwSXF90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680780351;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hroPDDqbeK3KP3ft/vk5XXJhx4hlY+C3UjJVTgzuyfY=;
        b=szeUFRX3TUtIIpbM1H5g5m9VaWl8IW6rKiC9XSfdwabf3rGd5mjX66c82jr3IKQ9R5
         Omg0wKvoj1emAOW2gQb9pIh42Vfdz2vc31HmeQwjpvuDJDwwDe95Poo01RmcLbfAkFqd
         pQewLXWsSOFFPXUntncYzN0B7fBMRXpapVkgCGqX8av9XBHxovalNpHuKSMd/dBEHu/g
         XVPx0e2Ei9WcPrS27FBU49ghMn46wZQ0di2dLVpF63JzLHB2uGfaQfQLli4297y4RDU0
         DxEs/KOcODmn35uWRD9taN88gZH0DYnn0s55MCOjirvFI822USDZ1R4MbkO85HARst5k
         HoYg==
X-Gm-Message-State: AAQBX9ffrsYf5js+z+qMzWSc0/mUDwDjQRMua4PQADQVsCFWyz2sLoZ8
        NGEyxHf+ed2lTJbxRyh+Yg6FFA==
X-Google-Smtp-Source: AKy350YPfn28LG1fbLn36Juw7fvJRCV/Dyp+bOKOoRgXlKhXaL/TLKj7dKKe5UkKfvhy3hU+bF/k9A==
X-Received: by 2002:a17:906:2219:b0:92f:39d9:1e50 with SMTP id s25-20020a170906221900b0092f39d91e50mr4936235ejs.3.1680780351274;
        Thu, 06 Apr 2023 04:25:51 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id p14-20020a1709061b4e00b00930a4e5b46bsm672302ejg.211.2023.04.06.04.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:25:50 -0700 (PDT)
Date:   Thu, 6 Apr 2023 13:25:48 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Asahi Lina <lina@asahilina.net>
Cc:     David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Karol Herbst <kherbst@redhat.com>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [Linaro-mm-sig] Re: [PATCH RFC 18/18] drm/asahi: Add the Asahi
 driver for Apple AGX GPUs
Message-ID: <ZC6sPBuH3vz7vMO2@phenom.ffwll.local>
Mail-Followup-To: Asahi Lina <lina@asahilina.net>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Karol Herbst <kherbst@redhat.com>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
 <20230307-rust-drm-v1-18-917ff5bc80a8@asahilina.net>
 <ZC2JPR3fGm0uE9yW@phenom.ffwll.local>
 <6200f93d-6d95-5d03-cc1c-22d7924d66eb@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6200f93d-6d95-5d03-cc1c-22d7924d66eb@asahilina.net>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 02:02:55PM +0900, Asahi Lina wrote:
> On 05/04/2023 23.44, Daniel Vetter wrote:
> > On Tue, Mar 07, 2023 at 11:25:43PM +0900, Asahi Lina wrote:
> > > +/// Look up a GEM object handle for a `File` and return an `ObjectRef` for it.
> > > +pub(crate) fn lookup_handle(file: &DrmFile, handle: u32) -> Result<ObjectRef> {
> > > +    Ok(ObjectRef::new(shmem::Object::lookup_handle(file, handle)?))
> > > +}
> > 
> > So maybe my expectations for rust typing is a bit too much, but I kinda
> > expected this to be fully generic:
> > 
> > - trait Driver (drm_driver) knows the driver's object type
> > - a generic create_handle function could ensure that for drm_file (which
> >    is always for a specific drm_device and hence Driver) can ensure at the
> >    type level that you only put the right objects into the drm_file
> > - a generic lookup_handle function on the drm_file knows the Driver trait
> >    and so can give you back the right type right away.
> > 
> > Why the wrapping, what do I miss?
> 
> Sigh, so this is one of the many ways I'm trying to work around the "Rust
> doesn't do subclasses" problem (so we can figure out what the best one is
> ^^).
> 
> The generic shmem::Object::lookup_handle() call *is* fully generic and will
> get you back a driver-specific object. But since Rust doesn't do
> subclassing, what you get back isn't a driver-specific type T, but rather a
> (reference to a) shmem::Object<T>. T represents the inner driver-specific
> data/functionality (only), and the outer shmem::Object<T> includes the
> actual drm_gem_shmem_object plus a T. This is backwards from C, where you
> expect the opposite situation where T contains a shmem object, but that just
> doesn't work with Rust because there's no way to build a safe API around
> that model as far as I know.

Ah I think I just got confused. I did untangle (I think at least) the
Object<T> trick, I guess the only thing that confused me here is why this
is in the shmem module? Or is that the rust problem again?

I'd kinda have expected that we'd have a gem::Object<T> here that the
lookup_handle function returns. So for the shmem case I guess that would
then be gem::Object<shmem::Object<T>> for the driver type T with driver
specific stuff? I guess not very pretty ...

> Now the problem is from the higher layers I want object operations that
> interact with the shmem::Object<T> (that is, they call generic GEM functions
> on the object). Options so far:
> 
> 1. Add an outer wrapper and put that functionality there.
> 2. Just have the functions on T as helpers, so you need to call T::foo(obj)
> instead of obj.foo().
> 3. Use the undocumented method receiver trait thing to make shmem::Object<T>
> a valid `self` type, plus add auto-Deref to shmem::Object. Then obj.foo()
> works.
> 
> #1 is what I use here. #2 is how the driver-specific File ioctl callbacks
> are implemented, and also sched::Job<T>. #3 is used for fence callbacks
> (FenceObject<T>). None of them are great, and I'd love to hear what people
> think of the various options...
> 
> There are other unexplored options, like in this GEM case it could be
> covered with a driver-internal auxiliary trait impl'd on shmem::Object<T>
> buuut that doesn't work when you actually need callbacks on T itself to
> circle back to shmem::Object<T>, as is the case with File/Job/FenceObject.

Ok I think I'm completely lost here. But I also havent' looked at how this
is all really used in the driver, it's really just the shmem:: module in
the lookup_handle function which looked strange to me.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
hvettp://blog.ffwll.ch
