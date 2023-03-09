Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819DA6B1B23
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCIGLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCIGLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:11:06 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2A4C3628;
        Wed,  8 Mar 2023 22:11:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id BF1D142118;
        Thu,  9 Mar 2023 06:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1678342262;
        bh=B+9nPUAyV8RcIjHdZiRtvBHrm1qUoJ2YnUJI9mL8OU8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=PlvUU7AChMN+y2uSDSmhUq9MNe+rf6C0ZtCgSk8xWkohNRj8+AyB3wr36ek6paNek
         RiQBVRMogoYUk74mPqQnlLlVUmWj9nxyFm2F+Z4kMItrty/YfZ/AsxRmAqrPd2Sg4E
         Q+5Mps+qnDRYVKtcv/q51vubggpiDtTCB8dVe91p6uBvaAdwhg6i9Kj3C1tawnxOPh
         v93PGOH4x1lR1wVdsLQFREJ3WFtdSb4BoENJX7+st1wqSranqShTxvK7/pgH7lLPfb
         IUd8fUVWqVnyfIbWo2NICrP9hSEh1gRFIbwzsB9NpGu6/qMhiTfDbyNoj0LddnTdfC
         Vq0jJdU85h8Iw==
Message-ID: <dfbed5a2-9ec5-5cd0-c992-27f4dd6c8808@asahilina.net>
Date:   Thu, 9 Mar 2023 15:10:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC 02/18] rust: drm: Add Device and Driver abstractions
Content-Language: en-US
To:     =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
 <20230307-rust-drm-v1-2-917ff5bc80a8@asahilina.net>
 <LgJBjn9Sl_vEeMPI8yvQkT5yQzZGk3eC8zdazRRupvjTuysDp8AJU1KY937LoPXugI78XH35UbTxn5tQzunr_pnr63bV_4HC_Ft6VW_mRL8=@protonmail.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <LgJBjn9Sl_vEeMPI8yvQkT5yQzZGk3eC8zdazRRupvjTuysDp8AJU1KY937LoPXugI78XH35UbTxn5tQzunr_pnr63bV_4HC_Ft6VW_mRL8=@protonmail.com>
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

On 08/03/2023 03.19, Björn Roy Baron wrote:
> ------- Original Message -------
> On Tuesday, March 7th, 2023 at 15:25, Asahi Lina <lina@asahilina.net> wrote:
> 
>> Add the initial abstractions for DRM drivers and devices. These go
>> together in one commit since they are fairly tightly coupled types.
>>
>> A few things have been stubbed out, to be implemented as further bits of
>> the DRM subsystem are introduced.
>>
>> Signed-off-by: Asahi Lina lina@asahilina.net
>>
>> ---
[...]

>> +/// Information data for a DRM Driver.
>> +pub struct DriverInfo {
>> +    /// Driver major version.
>> +    pub major: i32,
>> +    /// Driver minor version.
>> +    pub minor: i32,
>> +    /// Driver patchlevel version.
>> +    pub patchlevel: i32,
>> +    /// Driver name.
>> +    pub name: &'static CStr,
>> +    /// Driver description.
>> +    pub desc: &'static CStr,
>> +    /// Driver date.
>> +    pub date: &'static CStr,
>> +}
>> +
> 
> Could you please add an Invariants section to the doc comments indicating what requirements these function pointers must satisfy?

I can try (as much as I can divine from the C side anyway...). I guess
you want interface docs for each callback, so like what it must do and
what invariants each one must uphold?

Note that this is a kernel crate-only struct (the fields are not public)
so users can't create their own AllocOps variants anyway (plus AllocImpl
is sealed, on top of that), but I guess it makes sense to document for
internal kernel crate purposes. At some point it might make sense to
allow drivers to override these with proper Rust callbacks (and then the
wrappers need to ensure safety), but right now that's not implemented.

>> +/// Internal memory management operation set, normally created by memory managers (e.g. GEM).
>> +///
>> +/// See `kernel::drm::gem` and `kernel::drm::gem::shmem`.
>> +pub struct AllocOps {
>> +    pub(crate) gem_create_object: Option<
>> +        unsafe extern "C" fn(
>> +            dev: *mut bindings::drm_device,
>> +            size: usize,
>> +        ) -> *mut bindings::drm_gem_object,
>> +    >,
>> +    pub(crate) prime_handle_to_fd: Option<
>> +        unsafe extern "C" fn(
>> +            dev: *mut bindings::drm_device,
>> +            file_priv: *mut bindings::drm_file,
>> +            handle: u32,
>> +            flags: u32,
>> +            prime_fd: *mut core::ffi::c_int,
>> +        ) -> core::ffi::c_int,
>> +    >,
>> +    pub(crate) prime_fd_to_handle: Option<
>> +        unsafe extern "C" fn(
>> +            dev: *mut bindings::drm_device,
>> +            file_priv: *mut bindings::drm_file,
>> +            prime_fd: core::ffi::c_int,
>> +            handle: *mut u32,
>> +        ) -> core::ffi::c_int,
>> +    >,
>> +    pub(crate) gem_prime_import: Option<
>> +        unsafe extern "C" fn(
>> +            dev: *mut bindings::drm_device,
>> +            dma_buf: *mut bindings::dma_buf,
>> +        ) -> *mut bindings::drm_gem_object,
>> +    >,
>> +    pub(crate) gem_prime_import_sg_table: Option<
>> +        unsafe extern "C" fn(
>> +            dev: *mut bindings::drm_device,
>> +            attach: *mut bindings::dma_buf_attachment,
>> +            sgt: *mut bindings::sg_table,
>> +        ) -> *mut bindings::drm_gem_object,
>> +    >,
>> +    pub(crate) gem_prime_mmap: Option<
>> +        unsafe extern "C" fn(
>> +            obj: *mut bindings::drm_gem_object,
>> +            vma: *mut bindings::vm_area_struct,
>> +        ) -> core::ffi::c_int,
>> +    >,
>> +    pub(crate) dumb_create: Option<
>> +        unsafe extern "C" fn(
>> +            file_priv: *mut bindings::drm_file,
>> +            dev: *mut bindings::drm_device,
>> +            args: *mut bindings::drm_mode_create_dumb,
>> +        ) -> core::ffi::c_int,
>> +    >,
>> +    pub(crate) dumb_map_offset: Option<
>> +        unsafe extern "C" fn(
>> +            file_priv: *mut bindings::drm_file,
>> +            dev: *mut bindings::drm_device,
>> +            handle: u32,
>> +            offset: *mut u64,
>> +        ) -> core::ffi::c_int,
>> +    >,
>> +    pub(crate) dumb_destroy: Option<
>> +        unsafe extern "C" fn(
>> +            file_priv: *mut bindings::drm_file,
>> +            dev: *mut bindings::drm_device,
>> +            handle: u32,
>> +        ) -> core::ffi::c_int,
>> +    >,
>> +}
>> +

~~ Lina
