Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7866B1AAE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 06:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCIFZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 00:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCIFZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 00:25:28 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9531D82A8E;
        Wed,  8 Mar 2023 21:25:23 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DD45542037;
        Thu,  9 Mar 2023 05:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1678339521;
        bh=AqKhfVbrCgFD4lko5eegMh8R3NTuYq179Kx+ape/AUw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Wx2g6hHKeCsXfkUgKO1J8pnackR4HNu+sLnMeFYf24PIEcG3Dr33trh9lN1i7NCYH
         iBXJX4d1fX4S9wXV87qH+AvPl3dzcsbiKtejK806oWJHYyRm1eGW50G8xuSxHfHI90
         OGepcjoxSmmGebCwmACxpon1dVMSfoC3C63+EZv+4Vm3TnKk2IvwKX6Q2qTyJYsz/t
         5+dvsMlkXmq1LOhoNPBODzISgSa4rqkkMhvr0r+Dbc3br4rSjTAL1uL1RdnjAHCiq4
         Yn/+w25IH6X8rrPCfs/hGRb5U4eY46B8GERplcPGPsP0U1EjoPg7u5myHLU5UtvHHY
         zV/fpXAc/uWlA==
Message-ID: <488728fc-ada2-20a3-79be-8109d891a8cb@asahilina.net>
Date:   Thu, 9 Mar 2023 14:25:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC 06/18] rust: drm: gem: shmem: Add DRM shmem helper
 abstraction
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linaro-mm-sig@lists.linaro.org, rust-for-linux@vger.kernel.org,
        Karol Herbst <kherbst@redhat.com>, asahi@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Mary <mary@mary.zone>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-sgx@vger.kernel.org, Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        linux-media@vger.kernel.org
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
 <20230307-rust-drm-v1-6-917ff5bc80a8@asahilina.net>
 <ff51483e-2d72-3a7b-0632-58ea36cc3d8e@igalia.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <ff51483e-2d72-3a7b-0632-58ea36cc3d8e@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 22.38, Maíra Canal wrote:
> On 3/7/23 11:25, Asahi Lina wrote:
>> The DRM shmem helper includes common code useful for drivers which
>> allocate GEM objects as anonymous shmem. Add a Rust abstraction for
>> this. Drivers can choose the raw GEM implementation or the shmem layer,
>> depending on their needs.
>>
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>> ---
>>   drivers/gpu/drm/Kconfig         |   5 +
>>   rust/bindings/bindings_helper.h |   2 +
>>   rust/helpers.c                  |  67 +++++++
>>   rust/kernel/drm/gem/mod.rs      |   3 +
>>   rust/kernel/drm/gem/shmem.rs    | 381 ++++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 458 insertions(+)
>>
> 
> [...]
> 
>> +unsafe extern "C" fn gem_create_object<T: DriverObject>(
>> +    raw_dev: *mut bindings::drm_device,
>> +    size: usize,
>> +) -> *mut bindings::drm_gem_object {
>> +    // SAFETY: GEM ensures the device lives as long as its objects live,
>> +    // so we can conjure up a reference from thin air and never drop it.
>> +    let dev = ManuallyDrop::new(unsafe { device::Device::from_raw(raw_dev) });
>> +
>> +    let inner = match T::new(&*dev, size) {
>> +        Ok(v) => v,
>> +        Err(e) => return e.to_ptr(),
>> +    };
>> +
>> +    let p = unsafe {
>> +        bindings::krealloc(
>> +            core::ptr::null(),
>> +            Object::<T>::SIZE,
>> +            bindings::GFP_KERNEL | bindings::__GFP_ZERO,
>> +        ) as *mut Object<T>
>> +    };
>> +
>> +    if p.is_null() {
>> +        return ENOMEM.to_ptr();
>> +    }
>> +
>> +    // SAFETY: p is valid as long as the alloc succeeded
>> +    unsafe {
>> +        addr_of_mut!((*p).dev).write(dev);
>> +        addr_of_mut!((*p).inner).write(inner);
>> +    }
>> +
>> +    // SAFETY: drm_gem_shmem_object is safe to zero-init, and
>> +    // the rest of Object has been initialized
>> +    let new: &mut Object<T> = unsafe { &mut *(p as *mut _) };
>> +
>> +    new.obj.base.funcs = &Object::<T>::VTABLE;
>> +    &mut new.obj.base
>> +}
> 
> It would be nice to allow to set wc inside the gem_create_object callback,
> as some drivers do it so, like v3d, vc4, panfrost, lima...

This is actually a bit tricky to do safely, because we can't just have a
callback that takes the drm_gem_shmem_object instance inside
gem_create_object because it is not fully initialized yet from the point
of view of the gem shmem API. Maybe we could have some sort of temporary
proxy object that only lets you do safe things like set map_wc? Or maybe
the new() callback could return something like a ShmemTemplate<T> type
that contains both the inner data and some miscellaneous fields like the
initial map_wc state?

I think we can also just wait until the first user before we do this
though... the goal of the abstractions is to support the APIs we
actually use. I know you need this for vgem, so please feel free to
implement it as a separate patch! I think it's best if you get credit
for the abstraction changes you need, so we can all work together on the
design so it works for everyone's use cases instead of just having me
make all the decisions ^^ (and it's fine if we have to refactor the APIs!)

~~ Lina
