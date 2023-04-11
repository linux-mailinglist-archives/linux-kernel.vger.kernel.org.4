Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19C16DE5F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDKUr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDKUr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:47:27 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2098.outbound.protection.outlook.com [40.107.11.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AABBD;
        Tue, 11 Apr 2023 13:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbG1I6EvzWvqv5rdwiEJaghNjzqh8rvWYRY6MLxg8nFpfw5oW+UhPeVHE82QyYQGDuia0vEqOsPror/y5TM5eHIKJWXjaIGVT8AMdJc5Qsng2TFSVFjhn1Gft8W1JEO1OIRTYmBbT0e6rK36BeAJspjc/4U9WFaS8zxE4ISydYZV47M1/dVESCM3yhYwbpp1ew+9XN0YkCNgXRtB3C9mbGsdkkcoc8hw6pAsBqvtGalnUkkzNKxRimZ5gEeuzrs/XHEVowHsKf5yEapSrbu+nM/I8FBi/xXuKxUObQo20/0CRrWxbacIsnNSnCIl7SaEpNzIBhgWYakX7kjX4GSHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rNi8eKCTekjHjTT7na0UN9Xo/IxxAEt0EDRQCyN9K0=;
 b=jKxcBjjnktDQ5idONj0AM5xlq5Ou1eyzmWcVTbFJMHWnl7hMJD6WuOlpG29rrFe3YGyXe0qtS8gxo8ifbdC2qh8lYjuOXnK+vHeCmfdE4+cARefWCsixVqS0zAvpCK8uHiup42NV9PKxopf6xbNdacc1wEKmIck/CZotHOlbZyO0iL8f1xbKBuB1HXBAUOcPaDAzA/BxV9scQy1zDjJwjU3YySfd1K2YfWlLSVgIHjcbcdd905abByM1s07QPq0+fcN1mcGXCFCSrUFza0keAdqTM+bryyZwvq7C6qKKF4fWJUAwvRBUzHpupa/sBGxmEtxMU28nodt0jbJ1YF1dvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rNi8eKCTekjHjTT7na0UN9Xo/IxxAEt0EDRQCyN9K0=;
 b=VF2yNsHoM1p4labHWzM8bplvg7T4zKhKznZHH8msBnNi2xLGoWY0Aq2WM1lOX2n5Qx7rY3YYsG3/xvZF6QdQuNJkMl70dmkpcWXLswgCBafscJn9CgS9JU2kchESFNYJMPME4NLhsFd6XDrX83MC6j7X+SezsFP2J3QHKUMmNrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6850.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 20:47:22 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%6]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 20:47:22 +0000
Date:   Tue, 11 Apr 2023 21:47:21 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v4 09/13] rust: add basic `Task`
Message-ID: <20230411214721.2d6f8fda.gary@garyguo.net>
In-Reply-To: <20230411054543.21278-9-wedsonaf@gmail.com>
References: <20230411054543.21278-1-wedsonaf@gmail.com>
        <20230411054543.21278-9-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0222.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::10) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: b965f7d1-b344-4ba4-9c0a-08db3acdf350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJV4wKXK1wFyt+/DbPRZuw622UKjmUVpfIrGproIN02xRZ3E0ucxcZP71k+JFLOx52b7rhWLyNB6vsqHctIuQChxFd4FDWl+95mMMM+FE6Q6XoJisuLNpeBCyzD95aiJdF4zYBmDnBcIKqAufdk7VZkGHEBpNZ08KYpQtSI0ZDRbH0IGbVtmmmDD+BgBRzO8PyqoA61dfe5KhHhQRQn7peeS3iRsPFO0OvVXCGEOg1THNcKFRV7i4n9TMtcSlbszLw6I4p7s9C4a3EmBbiUQ1D8r+fr55cdtQnS79uA6/UmJ4bRsjffe2gsVMlPgDBtOKfY+rQSIr9ibYLwzi5AvBLymQsJQaltWUYSiGzZSo9Bu4R2DLhTGHkuKS1SMoHnaOYH3HOFhgqo36y+R9WNZjDkv+dLYBZp9GaVILaYAg4aiCZRIbJXxYR0nemu1A9gu+/oFbAEn2TFBPRvi1FByekAUfCo+3MpzbE+CPgL3R7CXExaTzMbClQ+e2BIcYor6D9A6BblNLxCT/kInUJ+nK5poJQnnTvPA9nW6GEGxYzpnD/JBAjIW21yPcBEKyO/RLbn32XcgX+EW3t4YTz81nIKoj8JrAtI1CYv5t6PpyMM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(346002)(136003)(376002)(366004)(451199021)(478600001)(45080400002)(1076003)(26005)(316002)(6506007)(186003)(54906003)(2906002)(5660300002)(4326008)(66946007)(8676002)(6916009)(66476007)(6486002)(7416002)(41300700001)(8936002)(66556008)(83380400001)(86362001)(36756003)(6512007)(2616005)(38100700002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9lsO9N2Kufjn9GKXx3359jJeCGo3hG93166N8sVgCkUutPfxBjXgmhduXy6G?=
 =?us-ascii?Q?t6LrjCsInaIamoKUC78YNNTGawVhR9X5Rr43CmCgXkAt5dzZrVfFxz4pSfGF?=
 =?us-ascii?Q?dmlUB6AcwbTxxzZFFljbaCvNP6Qn1b7T2mzta9bFn2Y2FdY/8cNGEoQ8sPzc?=
 =?us-ascii?Q?8nXF01Nw7ZlkxwiYbJ/QUWdyaCJVlwYnzQs6YLPd8OxhaALzHnoAJV61DVFK?=
 =?us-ascii?Q?AZ8GzWuz/ZotgAIZKyJqvcQNOYa+S6NEYmD1dANJXKS2+UqKaVnd/1OoNu9G?=
 =?us-ascii?Q?4aV1EwDi2J6M29KkXju4fV+TgGWXzSMy3I2opiGfdwcPZavW0stYNXd3h4ZY?=
 =?us-ascii?Q?HERaaIjutc0Z+KLe9c21TTaf4gKe9qxVpsPqH92CEa0DCAhPpThcUHFRrvfo?=
 =?us-ascii?Q?tb1elxYsHa5sGqtfnkZEYs+ZrQx6y8FiSsBpXoFZAXfSuy90ozdTxX/IzFb7?=
 =?us-ascii?Q?gTNmMNE6dPJEEHH30/7wGWjDeL5qjsG8H41nWcv115mx9pCidOMeB5H1h9e+?=
 =?us-ascii?Q?ipvuFMqSbVrufyyGEK96pgOE6jJU2WVY2/oXqOWdDVVmpO1QyzmXPWHZEVVc?=
 =?us-ascii?Q?1/cE1et/F8JBvf8UH0blQvq1PC/tglIKj3lY5HVAVb0VGe2QvUzT6t9O9aS5?=
 =?us-ascii?Q?bNyUib2SepGaVPYi3oAEQ/P8Sz83FOiS6NF2pzDuiv+Oh+ex9ecIDgC4KZvw?=
 =?us-ascii?Q?vRk4jHZ264bZkb7Mu1TCGRDEYh+TG4imzBGtHxweSjtefqVblLFFUmR4tcdP?=
 =?us-ascii?Q?TPuqYEe8MMqpGx0hWOyARNQU4/Rh9o1dmkHPwEDiK1F9ML6XYoiHgFfunUSb?=
 =?us-ascii?Q?R8biKaxOB/M9Ccute+MdOz4O67qAMQHTubgWGTPbhd5lKg4vrHsZm10x4QVN?=
 =?us-ascii?Q?5WfdRNfKHLvDZlyGvhPqYrUZtS1rdNgVgzPSDoi295+RdFhCiNaQ0pi43+Sn?=
 =?us-ascii?Q?4hHcWO7CfAmtnydIMOpPZdZjj8U6zeffEV+Jbuezxy8B2S3tCeK8iBQlNisR?=
 =?us-ascii?Q?SZb4pKw7pnkTMlA8p9jpQ06eaccmom86K8g5PZfGA+bjSTs2QFFFJ9pwEJ5Z?=
 =?us-ascii?Q?oHlqIph4sapaud2qFqu2nV/kUbnYM4vJNwyk6YEeZf4LjdoaXjRDCjMot5XT?=
 =?us-ascii?Q?sk3/bmtE7KAi1lIs8+jAmNgzAh82Q7YX+SdD5Zd4UWFHEZlQDGsZiLWvE8lP?=
 =?us-ascii?Q?54qdNzOYlXUikDLbiliNOHFAmu2nU8cn2cWhf7LBBOAiOTug6Pvzu441UNIh?=
 =?us-ascii?Q?uuR6r75jhk8c2Y6oiQ6grmRyR2Tty6HciHqOS6FAyL9XwGAsyAcilpQfpgUF?=
 =?us-ascii?Q?mKvN8wQZ5DYl8LVh9XjJF+39DbXh9VQ8d4nooeqlPtJW83YQqZFveyC/BzYr?=
 =?us-ascii?Q?i3MgLQw3+WXqJSlJTsylsDr1ficE4/m/1J1VBC/F/RuWeb2gHfM1PYC63EKk?=
 =?us-ascii?Q?mFVnm8ldnIxkBl/dv0wWK0uvB52KPFZsQlh+DW7PdfJZPInosLlrmksG4CBN?=
 =?us-ascii?Q?JBSPFbhcnKGK8e45E7oJSc0I+HNv51s06V7G0jPDq6GuYCcSULSEm86B3p91?=
 =?us-ascii?Q?zsILR3QEcxUfB51hl4gsv03Y91yFRwhestGi8rXb?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b965f7d1-b344-4ba4-9c0a-08db3acdf350
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 20:47:22.8981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GvqCvUgBa36rj5kpj68Xt5CtW0kY//4kG0gsmOKQAaoEMc807sR9K9R4HZokXd64REPhLfR9M5daSAQpj56vQ==
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

On Tue, 11 Apr 2023 02:45:39 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> It is an abstraction for C's `struct task_struct`. It implements
> `AlwaysRefCounted`, so the refcount of the wrapped object is managed
> safely on the Rust side.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: No changes
> v2 -> v3: Wrap task_struct with `Opaque` instead of `UnsafeCell`
> v3 -> v4: No changes
> 
>  rust/bindings/bindings_helper.h |  1 +
>  rust/helpers.c                  | 19 +++++++++
>  rust/kernel/lib.rs              |  1 +
>  rust/kernel/task.rs             | 75 +++++++++++++++++++++++++++++++++
>  4 files changed, 96 insertions(+)
>  create mode 100644 rust/kernel/task.rs
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 75d85bd6c592..03656a44a83f 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -8,6 +8,7 @@
>  
>  #include <linux/slab.h>
>  #include <linux/refcount.h>
> +#include <linux/sched.h>
>  
>  /* `bindgen` gets confused at certain things. */
>  const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
> diff --git a/rust/helpers.c b/rust/helpers.c
> index efd5b1e86f6e..f545923aedd8 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -24,6 +24,7 @@
>  #include <linux/refcount.h>
>  #include <linux/mutex.h>
>  #include <linux/spinlock.h>
> +#include <linux/sched/signal.h>
>  
>  __noreturn void rust_helper_BUG(void)
>  {
> @@ -76,6 +77,12 @@ void rust_helper_spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_spin_unlock_irqrestore);
>  
> +int rust_helper_signal_pending(struct task_struct *t)
> +{
> +	return signal_pending(t);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_signal_pending);
> +
>  refcount_t rust_helper_REFCOUNT_INIT(int n)
>  {
>  	return (refcount_t)REFCOUNT_INIT(n);
> @@ -112,6 +119,18 @@ long rust_helper_PTR_ERR(__force const void *ptr)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_PTR_ERR);
>  
> +void rust_helper_get_task_struct(struct task_struct *t)
> +{
> +	get_task_struct(t);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_get_task_struct);
> +
> +void rust_helper_put_task_struct(struct task_struct *t)
> +{
> +	put_task_struct(t);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 2d7606135ef6..ee27e10da479 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -44,6 +44,7 @@ mod static_assert;
>  pub mod std_vendor;
>  pub mod str;
>  pub mod sync;
> +pub mod task;
>  pub mod types;
>  
>  #[doc(hidden)]
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> new file mode 100644
> index 000000000000..d70cad131956
> --- /dev/null
> +++ b/rust/kernel/task.rs
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Tasks (threads and processes).
> +//!
> +//! C header: [`include/linux/sched.h`](../../../../include/linux/sched.h).
> +
> +use crate::{bindings, types::Opaque};
> +use core::ptr;
> +
> +/// Wraps the kernel's `struct task_struct`.
> +///
> +/// # Invariants
> +///
> +/// All instances are valid tasks created by the C portion of the kernel.
> +///
> +/// Instances of this type are always ref-counted, that is, a call to `get_task_struct` ensures
> +/// that the allocation remains valid at least until the matching call to `put_task_struct`.
> +#[repr(transparent)]
> +pub struct Task(pub(crate) Opaque<bindings::task_struct>);
> +
> +// SAFETY: It's OK to access `Task` through references from other threads because we're either
> +// accessing properties that don't change (e.g., `pid`, `group_leader`) or that are properly
> +// synchronised by C code (e.g., `signal_pending`).
> +unsafe impl Sync for Task {}
> +
> +/// The type of process identifiers (PIDs).
> +type Pid = bindings::pid_t;

This'll just end up being `i32`. I think it'll be more desirable that
this is defined as a new type.

> +
> +impl Task {
> +    /// Returns the group leader of the given task.
> +    pub fn group_leader(&self) -> &Task {
> +        // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
> +        // have a valid group_leader.
> +        let ptr = unsafe { *ptr::addr_of!((*self.0.get()).group_leader) };
> +
> +        // SAFETY: The lifetime of the returned task reference is tied to the lifetime of `self`,
> +        // and given that a task has a reference to its group leader, we know it must be valid for
> +        // the lifetime of the returned task reference.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Returns the PID of the given task.
> +    pub fn pid(&self) -> Pid {
> +        // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
> +        // have a valid pid.
> +        unsafe { *ptr::addr_of!((*self.0.get()).pid) }
> +    }
> +
> +    /// Determines whether the given task has pending signals.
> +    pub fn signal_pending(&self) -> bool {
> +        // SAFETY: By the type invariant, we know that `self.0` is valid.
> +        unsafe { bindings::signal_pending(self.0.get()) != 0 }
> +    }
> +
> +    /// Wakes up the task.
> +    pub fn wake_up(&self) {
> +        // SAFETY: By the type invariant, we know that `self.0.get()` is non-null and valid.
> +        // And `wake_up_process` is safe to be called for any valid task, even if the task is
> +        // running.
> +        unsafe { bindings::wake_up_process(self.0.get()) };
> +    }
> +}
> +
> +// SAFETY: The type invariants guarantee that `Task` is always ref-counted.
> +unsafe impl crate::types::AlwaysRefCounted for Task {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> +        unsafe { bindings::get_task_struct(self.0.get()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
> +        unsafe { bindings::put_task_struct(obj.cast().as_ptr()) }
> +    }
> +}

