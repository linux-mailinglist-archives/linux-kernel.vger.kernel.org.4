Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EB66DE60B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjDKUyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDKUyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:54:19 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2102.outbound.protection.outlook.com [40.107.11.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3203B18E;
        Tue, 11 Apr 2023 13:54:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fW7Cy3vgQQG2jAHsp6lwZCPRPyt3oJ3jshXmqklj2bNgzTLpLX3uKkJwtD84Kx4WttvccLVR/NVF/BQYznVETDbVg0fUbEySH39WYFBLd1m93vf/coQPqIUE51uY187+cK6b2YqDpL2Xv6ArFAE0L/NmFqbS0iXfPLOaJvMJmocxoqeZxnDCBWQQQ2l870/5WU3htrkH6msuKWKzoQ34W3SZYmsdYIAlpVpMdw42wk/IfHQ2VGn52WLIx73WBDecIv+mwPhtkNVGS977mvM7y3SMZtpuNIsIsWyJ0k1Bf2c4MVbsoJ7/MwW35rvSWxOzsmJ9opXoOeSCUeObXPJygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHT9/3IgM5DNaAMZXlnaYpZVXq8+qLlTkVCrgCGuvjQ=;
 b=RNFsUtmIC3wZF2VhHg1sEynhehm/JoqSubRF6JUghkCvGxuvCWBfpeLCuq3G2EOr+/okqZvt9l+hDSlKRa0Tuk5q4/DXNuOHShAnA5Md9H32GpfY84EeiWDkNXgmKyYW+ofMey8H+jB2g/wBZSEXWqiHaJv5KGk6NJYSPTEDK2sUWxJ2ko5CUQob8mxp3sGHaAk0IUKX6qzrnJMwTgYpwOjJHd21wh5I6Dgm3Dx+5sstmijymqcAYoHImrroC+eHU1D5oCuw7Rp9addZfjb37mZXWEC43cj5AcZ7Sz6ECRaRwk+IOciiydBo2lmuI/8SgU0zpEU2XNCxulfP9B747Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHT9/3IgM5DNaAMZXlnaYpZVXq8+qLlTkVCrgCGuvjQ=;
 b=eGO6oL3eYoAHWM749nzDpZ/oD/gxFv1ElRD/FZNZjBqtL/MZsi1SI8YSlSZd9BqyKbwCWdURHawVO7KmfpLGxzaHEoUgz3NCdPCp2PX8n+n9HA3HlHYvhmc6zy+yKIQliZXE2zsB9ESSQ0yqub5TqHYyJ9r5JwJivb7z8htV8yA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6850.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 20:54:15 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%6]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 20:54:15 +0000
Date:   Tue, 11 Apr 2023 21:54:13 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v4 11/13] rust: lock: add `Guard::do_unlocked`
Message-ID: <20230411215413.7720246f.gary@garyguo.net>
In-Reply-To: <20230411054543.21278-11-wedsonaf@gmail.com>
References: <20230411054543.21278-1-wedsonaf@gmail.com>
        <20230411054543.21278-11-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cdcbdb9-8fb2-492f-0a8c-08db3acee8fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7smx6Pe1/DdfkpSXQaQMeRKkCmkkH8iQXrRUJpntTofGXbbflk2hTCT+U8x7moNfzVHIDa3VY05fvmyINBCgX0Y+YqfyQCy2+uT9Jhw+zoqZKeARmKa4adyjeaDNUYnTJIlYB0+RHWJuu9xP2HKrs9CYkO4c0FunSyhyA253brw9aPJjwgGTLjz/eko/OjrBcJOE9D1Xt/60iKCGv4+g0hhBrpT1jQGtbeKI9BVB2UCpxEfT++ouFxlzNU9pAUASnqStHc11yIQMOFiD9/j+TMkSMnqf742mojxzUus7wQ12kQJExOJGxcBq1OG1DjTjjUGQQJrEl+XLJeikaK0uUIFzMMfkY1YQsx94TOjnIZ7vjjaa0N/mXZssuT6iG6e3iIs04eV2k5wKM1MGHsffXZLt+0KUhKnQFt8eqkvx1cJChNgpDRkCFwG539mF/W6U76TAUZ9645BoBUJVjC7MlfBcw8e4+fDqazPTk4lAg47mA9tZEKn+Qd+0RF2j7ms7fYarkQWN1PmgMAElf96IU3pL0LzGXRUqhCFYB1vOL2iswaLJ7oq9XDJIlylMX0zCwsVqim0+4i97ju3XIZ4YYHbebGRJPyE0fdg39z/GYaw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(346002)(136003)(376002)(366004)(451199021)(478600001)(45080400002)(1076003)(26005)(316002)(6506007)(186003)(54906003)(2906002)(5660300002)(4326008)(66946007)(8676002)(6916009)(66476007)(6486002)(41300700001)(8936002)(66556008)(83380400001)(86362001)(36756003)(6512007)(2616005)(38100700002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pyjhf0djOQxuI94h03sKck/YHgQJ6RmGx8rxjs+QBw0f+bHOReS951PtStMQ?=
 =?us-ascii?Q?sCJg0x/MPghsQkZUSCEuwviXxjOHpvp6gFWYnbdh2FPmtAVk71K9Sl00wnfk?=
 =?us-ascii?Q?b3JQKoUBCObs5VmYAfmlUcpwdClr9k0IzGXdoKfVTbIsCS/q+9WUNRbxD5tr?=
 =?us-ascii?Q?CxkwPadYKXkxxonUpobKz5oc4p8TB8YJk1gus7ckvsrNlq/GVTvLGubiV0cJ?=
 =?us-ascii?Q?Pq3Jjc9bMP+DxHP4+MauiufPwV6ezugSA/wVCtCA4SAj9AtKidwOf3YvfOX7?=
 =?us-ascii?Q?R3EI1Enz76Ou/6otpFOU3xvPlZLpOb5+JMw0yZPr7Vp6oSN7Ych5rsOZ3Cwp?=
 =?us-ascii?Q?cMbsk0xEiyFisVJp+NA4JZeKWi0qW6Pw2XET6yA3eVXre51vUe/MTcZQR2Zg?=
 =?us-ascii?Q?IcFCWfXPcxrux7ksTigFjob/rNalHz5ToGkJoSMlF1gbHGNfmy+pGyDaf3DB?=
 =?us-ascii?Q?+fL9R2Q3CVuJqXxfUeSmukBAKnxIX2FGMJvxZJVmLS5UuK+zNb1L8HPOzXsQ?=
 =?us-ascii?Q?iCzHV2h19EL/Ok3omQt5S4O23jd2AAffIytkbhpppY+/oBJTb2qShxnkQcYq?=
 =?us-ascii?Q?R2vV041t+sI3Rbg4M4p1WOKbWPbyPde7jikFlaovFnT3SWVBlO//jY9NAn1g?=
 =?us-ascii?Q?tKW4PknRwnahi1ByKLTkw91Ieizsw/1fncsmUKr4C4A38RGTuKpCXDonLSKe?=
 =?us-ascii?Q?pTmFMT+3FXx8de96nJGGrbeh6t5xiR6hHUvGPcr9MHpY6HVX+JZ0g4QUmFew?=
 =?us-ascii?Q?rs8Lnp50FzA5caJqRccq8yoBJNxICmJDa/V3i5ohjbjb8Q/ZDrPyUzEyWwSe?=
 =?us-ascii?Q?1CHVeeQaQ0OwvoaxO36Ugt86gUgTHZsj2i0Ih3bz/+I35Wr1wQiaXj+Hm2Dk?=
 =?us-ascii?Q?9nG76gUwJlOUCzncZR+2ovcIZc0EKlOVAgS1Y0LZ2ZJrnbDugDUBtP0paeu3?=
 =?us-ascii?Q?WJg6VTFTBvt23+u/9kQuqji8wAsDt6W/NOX/Gx9XzB7vExXA8qzWI5aw6J8l?=
 =?us-ascii?Q?jGIMl9+BLnVIZ9oBGBUF14lU3UhfqV4NRSrmhSvPGU1WwmCQUpHzPzn8Baip?=
 =?us-ascii?Q?1vZO2xFakKEK3haChmW3XhnaXn2IQEhKiHrxiv4nJ6bbncnMKj5EU9sQQ+f/?=
 =?us-ascii?Q?1FhRjc2wL6pAvvdLD1CRLr1INcY/BB5Wt3yvemvSd9jrzxMC1dJ9ovPBjFA8?=
 =?us-ascii?Q?E0o91tO3ViF5jVcFWmdHplE7rAkAb6MPnG9IgyBmcLJzUCDmvB2Fa87naBnq?=
 =?us-ascii?Q?26Th9MksDh9ESH7FIitmG4GzpQj62rcRIAoHN4qH5rs+s4U/W4Jf0ySsdVsn?=
 =?us-ascii?Q?4psqZaUL2tWM5IwbT5aZOwyGWEBrFCB7qYH5zqBIC0kdFDNQc6KavNqhPeyQ?=
 =?us-ascii?Q?CmcKMHsNxJT4hOm+mVJyHVRxMCCs96ivrwNk7pMhyh+h/0ZbFWqmT1KvQhRG?=
 =?us-ascii?Q?nUxNfmzr5SOFUoG5Skv9IAslE/jBRRFo/n8NRCqcandeXO3m1dyd2UcBAwz+?=
 =?us-ascii?Q?nHRvA3RDyZZvidT4qlRSsvp5Fb36JCjHLPkZdbCZzjfbJjtfyBqzNqFBXYVY?=
 =?us-ascii?Q?YI++k7QQ7GNFhfU1IporYDSjqcGnHQtTH6DZoarG?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdcbdb9-8fb2-492f-0a8c-08db3acee8fa
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 20:54:15.0681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRPwjD7rtM+ob2uvUZn4Jl4MAJAzs2OxgMrrfdK9xMf58cJBmvQB84FsRCzPZkiJa2SjIFNnP56dT0ShbQ9yXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6850
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 02:45:41 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> It releases the lock, executes some function provided by the caller,
> then reacquires the lock. This is preparation for the implementation of
> condvars, which will sleep after between unlocking and relocking.
> 
> We need an explicit `relock` method for primitives like `SpinLock` that
> have an irqsave variant: we use the guard state to determine if the lock
> was originally acquired with the regular `lock` function or
> `lock_irqsave`.
> 
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: No changes
> v2 -> v3: No changes
> v3 -> v4: No changes
> 
>  rust/kernel/sync/lock.rs          | 25 +++++++++++++++++++++++++
>  rust/kernel/sync/lock/spinlock.rs | 17 +++++++++++++++--
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 819b8ea5ba2b..cde57756795f 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -22,6 +22,9 @@ pub mod spinlock;
>  ///
>  /// - Implementers must ensure that only one thread/CPU may access the protected data once the lock
>  /// is owned, that is, between calls to `lock` and `unlock`.
> +/// - Implementers must also ensure that `relock` uses the same locking method as the original
> +/// lock operation. For example, it should disable interrupts if [`IrqSaveBackend::lock_irqsave`]
> +/// is used.
>  pub unsafe trait Backend {
>      /// The state required by the lock.
>      type State;
> @@ -55,6 +58,17 @@ pub unsafe trait Backend {
>      ///
>      /// It must only be called by the current owner of the lock.
>      unsafe fn unlock(ptr: *mut Self::State, guard_state: &Self::GuardState);
> +
> +    /// Reacquires the lock, making the caller its owner.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `state` comes from a previous call to [`Backend::lock`] (or
> +    /// variant) that has been unlocked with [`Backend::unlock`] and will be relocked now.
> +    unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
> +        // SAFETY: The safety requirements ensure that the lock is initialised.
> +        *guard_state = unsafe { Self::lock(ptr) };
> +    }
>  }
>  
>  /// The "backend" of a lock that supports the irq-save variant.
> @@ -164,6 +178,17 @@ pub struct Guard<'a, T: ?Sized, B: Backend> {
>  // SAFETY: `Guard` is sync when the data protected by the lock is also sync.
>  unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
>  
> +impl<T: ?Sized, B: Backend> Guard<'_, T, B> {
> +    #[allow(dead_code)]
> +    pub(crate) fn do_unlocked(&mut self, cb: impl FnOnce()) {
> +        // SAFETY: The caller owns the lock, so it is safe to unlock it.
> +        unsafe { B::unlock(self.lock.state.get(), &self.state) };
> +        cb();
> +        // SAFETY: The lock was just unlocked above and is being relocked now.
> +        unsafe { B::relock(self.lock.state.get(), &mut self.state) };

This should be

	let _guard = ScopeGuard::new(|| unsafe {
	    B::relock(self.lock.state.get(), &mut self.state) }
	});
	cb();

Although we currently use `-Cpanic=abort`, I think as a general rule we
should still try to make code unwind-safe, so it can remain sound if
someone takes the code and use it for userspace (e.g. for testing
purpose, or maybe sharing codebase with tools).

> +    }
> +}
> +
>  impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'_, T, B> {
>      type Target = T;
>  
> diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
> index 34dec09a97c0..e2a2f68e6d93 100644
> --- a/rust/kernel/sync/lock/spinlock.rs
> +++ b/rust/kernel/sync/lock/spinlock.rs
> @@ -4,6 +4,7 @@
>  //!
>  //! This module allows Rust code to use the kernel's `spinlock_t`.
>  
> +use super::IrqSaveBackend;
>  use crate::bindings;
>  
>  /// Creates a [`SpinLock`] initialiser with the given name and a newly-created lock class.
> @@ -95,7 +96,8 @@ pub type SpinLock<T> = super::Lock<T, SpinLockBackend>;
>  /// A kernel `spinlock_t` lock backend.
>  pub struct SpinLockBackend;
>  
> -// SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion.
> +// SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. `relock` uses the
> +// same scheme as `unlock` to figure out which locking method was used originally.
>  unsafe impl super::Backend for SpinLockBackend {
>      type State = bindings::spinlock_t;
>      type GuardState = Option<core::ffi::c_ulong>;
> @@ -127,13 +129,24 @@ unsafe impl super::Backend for SpinLockBackend {
>              None => unsafe { bindings::spin_unlock(ptr) },
>          }
>      }
> +
> +    unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
> +        let _ = match guard_state {
> +            // SAFETY: The safety requiments of this function ensure that `ptr` has been
> +            // initialised.
> +            None => unsafe { Self::lock(ptr) },
> +            // SAFETY: The safety requiments of this function ensure that `ptr` has been
> +            // initialised.
> +            Some(_) => unsafe { Self::lock_irqsave(ptr) },
> +        };
> +    }
>  }
>  
>  // SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. We use the `irqsave`
>  // variant of the C lock acquisition functions to disable interrupts and retrieve the original
>  // interrupt state, and the `irqrestore` variant of the lock release functions to restore the state
>  // in `unlock` -- we use the guard context to determine which method was used to acquire the lock.
> -unsafe impl super::IrqSaveBackend for SpinLockBackend {
> +unsafe impl IrqSaveBackend for SpinLockBackend {
>      unsafe fn lock_irqsave(ptr: *mut Self::State) -> Self::GuardState {
>          // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
>          // memory, and that it has been initialised before.

