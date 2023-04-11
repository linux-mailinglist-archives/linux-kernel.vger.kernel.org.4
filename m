Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED6B6DE5D5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjDKUmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDKUmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:42:13 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2118.outbound.protection.outlook.com [40.107.10.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280C73C11;
        Tue, 11 Apr 2023 13:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJ/hOxp6SmvstlTGOoAWyoxqJCLClx//AfQa5EJL7sWbGg9EocrrzpoF+gFF7ZiHRKV9xRlVjfPuYoBJ8p0ZAXuuDgOvXD6rujFTjrLxHNg2HvZqpGsSiLsHcotoQs9ueQTUv6F0i9tp59BzJJD8AgMJgaxWbZpAT3GI9yOBCCVpTOcjsFinfhjXZV8ZiAcnI7AiSfF6eQJH5Y0ai7NUdIxQUiTHqSVxbojWGfWIr+WGhUYhfPXo+x+JeQcEE//1GkNl8AaeqEWuHmVZ5Tbz8f4mfRMXgXLt9/UYiz28ofTyx9zjAzxIkQFVGTBqEq8IpQK4FmdqVUPorzIB9reChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqwC5unwidSgHLYiSoVzcIV3hVwfwuv1W0lvHjhmOoE=;
 b=egXwhIBfXg8SeTrr2b9Tz8vpTwFCLYV8K/m4WQbGvEaqlujxVPLss++Sru1I1dOf4NEkILG1vipBSpbKqul+CvaokppqaGyQQr1Az98+MQF4YA4/Klw5Ub7TTj06aocIJJ9G2YDn8QMJxN99eC3wDBLq1SZBbrGLmrxKjY0rIYo5PK7RdZdvnjTQW0Ww9G0VtHB8+HzzcbbkJ0K+spqbdP8UJ5VLAUKhL1qLLY0fNg/bZrYdwQuvH4QYVu2heumn8F2R3Ira9k5vL03yGV8Q/kt6QD2OjfixonEIzXBUGub8tgffqq2CT3zA/i/3tUyi3X0BvCBLOYdNuLLNQzdqnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqwC5unwidSgHLYiSoVzcIV3hVwfwuv1W0lvHjhmOoE=;
 b=F69OdPX6l0a86wTqLH+UuvjiTA6ivoxrVmRF3UeFGbd8XRzy1fsUXJH4BASmGew1mgZp7rymraZkwD2H7xKlSPfrZvEwXS+T8XXG30hBm8Vl7VTjjRafkTQyF1hKD5I6JXOoMYXEsTg5jegVtaISrbREEntaXogOn79IeuKzMaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB7375.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:31b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 20:42:07 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%6]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 20:42:07 +0000
Date:   Tue, 11 Apr 2023 21:42:05 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v4 02/13] rust: sync: introduce `Lock` and `Guard`
Message-ID: <20230411214205.5753343f.gary@garyguo.net>
In-Reply-To: <20230411054543.21278-2-wedsonaf@gmail.com>
References: <20230411054543.21278-1-wedsonaf@gmail.com>
        <20230411054543.21278-2-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0095.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d318aa-3ed9-44f8-5719-08db3acd3762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 03M5UT5R8qSEvsisq3KgfciBFgDf3iz9vvu45dCxVRHf65cVSrwcsB6bMa89uMgwq5mM8szD0u3Ne1YXVmdH1gYR7R7o0NGebu/f337Foi0faGHO0urHEoaUkT0yAyYwS43mFdWteu0uwWC08CfOHpvMczejWl2mJAe4+kgScu7TTaelftvZMaC5Fwfe1ekOCRdCqJd/XGwtDQcG6OKzI7PHp/R+2HxQrOb6ZzLnfVFJwKuHdv0pewTGDUtUpXrLR92MuJurMSZe89HNY1/XLQfkfqGug3IRe9M09X6N1I7OcOZD/eqD31rAMCvZc2OPw00ID/Ur0vZQUn75t50KdoRqPiaRa5z+4gUXGSnkPZGzZt5rLMxFzvDeiwetbWZKkVtiJR+tjCDHcaMd6kpOjjZ31uVTqj60j4qqBefmKMUw0dhFdchoPSexmws+uzAVX72R6lfAaaBWCAYp3cpBkJVz2jT6X1jcgXQ21GMrRTIBfAVRJGfAl9hchdWMcH2K4Wlan56caFKGNuxKP4M0GL6vS5D44Yd7exvZvXLn9VY2Gpz785r8dUFpEm7+QLkVLtmqz10ovN7kVvrde3ElCybWTuY7RjJqiSEFFTDptwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(346002)(136003)(376002)(366004)(451199021)(478600001)(45080400002)(1076003)(26005)(316002)(6506007)(186003)(54906003)(2906002)(5660300002)(4326008)(66946007)(8676002)(6916009)(66476007)(6486002)(41300700001)(8936002)(66556008)(83380400001)(86362001)(36756003)(6512007)(2616005)(38100700002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WWYx/DklYQJ4A2uYxKhAcZ/5oXy/Xd4kcjxOFe+vzQ5Ie3TvKf5F7V7TLDk0?=
 =?us-ascii?Q?7U6xFgtCUMmv8iF+/7f4B7UoiWFDNvhRuiAvPUvgbslj8HjvD7L2nMs8R+Cb?=
 =?us-ascii?Q?aP9v2mvkdYZCPzVur1t26SCg/tUAHFj56937Enjun9TFJFddBazzXqivNrCX?=
 =?us-ascii?Q?RlNO/Qy/g8agppj6EOzL0kEkN9hBMflUcsVZlEO1N4VkGA66ZxSh+Ijozmyh?=
 =?us-ascii?Q?biifAyFmeSUv+61Sk53Ofcad64E8BCUfMwget6Eeo6p74PPlT7Tz2v0jh6ll?=
 =?us-ascii?Q?xlQlU9eYjUWtKCO268hPP1jTQqtGLQNAVXsfFgbxt46/aC3rgMqLXV7ecD4Y?=
 =?us-ascii?Q?QC1akWlEW/aiCKjM7o3roCLzjnDJsRniVtzmY7+f/nyc/tdyJddFKLQ3v+gy?=
 =?us-ascii?Q?uUfh3Nykak7UIMMlJNrnYbgBFik/5GjivdK270j83n7k6WED7gjLVJp5Q7pg?=
 =?us-ascii?Q?H11fGtpqX4QY27HGQMJqSonG0Gql4NRkrzdk2mgpV2p+KO0f7GBI5Rd2/+HQ?=
 =?us-ascii?Q?dr/h/PC9jY8twvX5jo/pK5nmNqMVhMJ7Fwk61LvfCbtoII+6yQIhtJuIlTnu?=
 =?us-ascii?Q?LMhraxRmZiiMmyZsJ2ITVf2YsdNi3DyMHya1Zo7oxG+XFK8jJxoJVBwXaV1D?=
 =?us-ascii?Q?ncXpvkvQuVplCNmmT4u4yRPLG1/pLMuQhtV3vNG38mJW0O1obzgbpANenFlM?=
 =?us-ascii?Q?WKUSHVToX4CWd6hVQ8+pe2mjJHpQHmf/uGpaECXYd//cMvQAqddHjcl2corM?=
 =?us-ascii?Q?1s2nhnNJ3O7tpLzcQdGAjE2kvL4ibi+5fZO0/n/QfUqRb47AjrmeKJL0qPeM?=
 =?us-ascii?Q?iiw5Nv7B1Y+Mg3yq4m0MnuGbSfCvVnasFx2MvxC+Dcp5Fo1ZQsoa+dMkzj0t?=
 =?us-ascii?Q?1D0+YQWjsUMnv6qSOFnZXoJboyU4Eletcq5sE//N2K1ALZiQFevTp3wt5ZUh?=
 =?us-ascii?Q?AUtWCviuUgGwgwJLwUAWUmYkFh3bs0niJJHk1voJJSBGc9tTrcZ2cR3VIACf?=
 =?us-ascii?Q?/HX/459kSbHVH0+gZdFO106/V0amjjLfPoTjFc6ZJP3F1Uzs9MIl2WQWaMBg?=
 =?us-ascii?Q?dOJjV3yqVMPTWLMjw/BT3/l8gHozukjc7G2n8AtEtse0ysdSOXmtrS4JRAOY?=
 =?us-ascii?Q?ZMIcXTTKT36ezGmGjBqnKzMV94tiFBBfd6KtI6GtQIdshIOelrz2xKY7D47F?=
 =?us-ascii?Q?F8SHT2vkyH1wri6kFyO6MG0jOAiUiX921ANNJZOlkRmC0T0ryhVdCEGdfj+e?=
 =?us-ascii?Q?pVMU5u2MtV82ucfJYDQ0DBc6i+AD6YDiAHkBcIg4a2naeLLqyKEjIiG6SAt3?=
 =?us-ascii?Q?g7cvgQEEERQw6+g2naJDYuvteZ3ONF1OtsG4mpA6RM3jw8bID2+hEmDleGld?=
 =?us-ascii?Q?o95X7EiasTxRlVu2Qdh1pRaz6n+lITpC84p8pZtCBltEnM4SdncvoVzLipMh?=
 =?us-ascii?Q?tp/yY/iWyUSQVfWR0Cwy40cGBFQ0dFamoEM37DRifuO57IZYoCDARcS7B9+G?=
 =?us-ascii?Q?LKwSC7UFbv/OjUSMtFS2N20MOchXq5RIJMsElHWTGDV+th1KeqzoHR8rv6ai?=
 =?us-ascii?Q?pZRNkmwTptwZuhmEZCIuE6UUY3YZ2fBhhuMBx048?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d318aa-3ed9-44f8-5719-08db3acd3762
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 20:42:07.6366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBqPmhvXfwvPuQcIKje6VMLYUZxpsH5ecBeUivb+mP2NKdM0m6zW+wlvWnTsHZ6OfPJQU0hDm28q7NKDCOVT5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7375
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 02:45:32 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> They are generic Rust implementations of a lock and a lock guard that
> contain code that is common to all locks. Different backends will be
> introduced in subsequent commits.
> 
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: No changes
> v2 -> v3: Use new Opaque::ffi_init from Benno's series
> v3 -> v4: Fixed name of parameter in Lock comment
> 
>  rust/kernel/sync.rs      |   2 +-
>  rust/kernel/sync/lock.rs | 162 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 163 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/sync/lock.rs
> 
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 541d235ffbeb..81b0998eaa18 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -8,6 +8,7 @@
>  use crate::types::Opaque;
>  
>  mod arc;
> +pub mod lock;
>  
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
>  
> @@ -25,7 +26,6 @@ impl LockClassKey {
>          Self(Opaque::uninit())
>      }
>  
> -    #[allow(dead_code)]
>      pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
>          self.0.get()
>      }
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> new file mode 100644
> index 000000000000..1a8ecccf4f24
> --- /dev/null
> +++ b/rust/kernel/sync/lock.rs
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generic kernel lock and guard.
> +//!
> +//! It contains a generic Rust lock and guard that allow for different backends (e.g., mutexes,
> +//! spinlocks, raw spinlocks) to be provided with minimal effort.
> +
> +use super::LockClassKey;
> +use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque};
> +use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
> +use macros::pin_data;
> +
> +/// The "backend" of a lock.
> +///
> +/// It is the actual implementation of the lock, without the need to repeat patterns used in all
> +/// locks.
> +///
> +/// # Safety
> +///
> +/// - Implementers must ensure that only one thread/CPU may access the protected data once the lock
> +/// is owned, that is, between calls to `lock` and `unlock`.
> +pub unsafe trait Backend {
> +    /// The state required by the lock.
> +    type State;
> +
> +    /// The state required to be kept between lock and unlock.
> +    type GuardState;
> +
> +    /// Initialises the lock.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be valid for write for the duration of the call, while `name` and `key` must
> +    /// remain valid for read indefinitely.
> +    unsafe fn init(
> +        ptr: *mut Self::State,
> +        name: *const core::ffi::c_char,
> +        key: *mut bindings::lock_class_key,
> +    );

Any reason that this takes FFI types rather than just `&'static CStr` and `&'static LockClassKey`?

> +
> +    /// Acquires the lock, making the caller its owner.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that [`Backend::init`] has been previously called.
> +    #[must_use]
> +    unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState;
> +
> +    /// Releases the lock, giving up its ownership.
> +    ///
> +    /// # Safety
> +    ///
> +    /// It must only be called by the current owner of the lock.
> +    unsafe fn unlock(ptr: *mut Self::State, guard_state: &Self::GuardState);
> +}
> +
> +/// A mutual exclusion primitive.
> +///
> +/// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock banckend
> +/// specified as the generic parameter `B`.
> +#[pin_data]
> +pub struct Lock<T: ?Sized, B: Backend> {
> +    /// The kernel lock object.
> +    #[pin]
> +    state: Opaque<B::State>,
> +
> +    /// Some locks are known to be self-referential (e.g., mutexes), while others are architecture
> +    /// or config defined (e.g., spinlocks). So we conservatively require them to be pinned in case
> +    /// some architecture uses self-references now or in the future.
> +    #[pin]
> +    _pin: PhantomPinned,
> +
> +    /// The data protected by the lock.
> +    data: UnsafeCell<T>,
> +}
> +
> +// SAFETY: `Lock` can be transferred across thread boundaries iff the data it protects can.
> +unsafe impl<T: ?Sized + Send, B: Backend> Send for Lock<T, B> {}
> +
> +// SAFETY: `Lock` serialises the interior mutability it provides, so it is `Sync` as long as the
> +// data it protects is `Send`.
> +unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B> {}
> +
> +impl<T, B: Backend> Lock<T, B> {
> +    /// Constructs a new lock initialiser.
> +    #[allow(clippy::new_ret_no_self)]
> +    pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
> +        pin_init!(Self {
> +            data: UnsafeCell::new(t),
> +            _pin: PhantomPinned,
> +            // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
> +            // static lifetimes so they live indefinitely.
> +            state <- Opaque::ffi_init(|slot| unsafe {
> +                B::init(slot, name.as_char_ptr(), key.as_ptr())
> +            }),
> +        })
> +    }
> +}

There is not drop implementation on `Lock`, which implies all locks can
be just forgotten?

I believe we discussed a case where this is can lead to UAF when a lock
is dropped while it is locked (e.g. because the guard is forgotten).

> +
> +impl<T: ?Sized, B: Backend> Lock<T, B> {
> +    /// Acquires the lock and gives the caller access to the data protected by it.
> +    pub fn lock(&self) -> Guard<'_, T, B> {
> +        // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
> +        // that `init` was called.
> +        let state = unsafe { B::lock(self.state.get()) };
> +        // SAFETY: The lock was just acquired.
> +        unsafe { Guard::new(self, state) }
> +    }
> +}
> +
> +/// A lock guard.
> +///
> +/// Allows mutual exclusion primitives that implement the `Backend` trait to automatically unlock
> +/// when a guard goes out of scope. It also provides a safe and convenient way to access the data
> +/// protected by the lock.
> +#[must_use = "the lock unlocks immediately when the guard is unused"]
> +pub struct Guard<'a, T: ?Sized, B: Backend> {
> +    pub(crate) lock: &'a Lock<T, B>,
> +    pub(crate) state: B::GuardState,
> +    _not_send: PhantomData<*mut ()>,
> +}
> +
> +// SAFETY: `Guard` is sync when the data protected by the lock is also sync.
> +unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
> +
> +impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'_, T, B> {
> +    type Target = T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: The caller owns the lock, so it is safe to deref the protected data.
> +        unsafe { &*self.lock.data.get() }
> +    }
> +}
> +
> +impl<T: ?Sized, B: Backend> core::ops::DerefMut for Guard<'_, T, B> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: The caller owns the lock, so it is safe to deref the protected data.
> +        unsafe { &mut *self.lock.data.get() }
> +    }
> +}
> +
> +impl<T: ?Sized, B: Backend> Drop for Guard<'_, T, B> {
> +    fn drop(&mut self) {
> +        // SAFETY: The caller owns the lock, so it is safe to unlock it.
> +        unsafe { B::unlock(self.lock.state.get(), &self.state) };
> +    }
> +}
> +
> +impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
> +    /// Constructs a new immutable lock guard.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that it owns the lock.
> +    pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
> +        Self {
> +            lock,
> +            state,
> +            _not_send: PhantomData,
> +        }
> +    }
> +}

