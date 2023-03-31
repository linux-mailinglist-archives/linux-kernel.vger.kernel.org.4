Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68226D15BE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 04:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCaCr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 22:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCaCr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 22:47:26 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2097.outbound.protection.outlook.com [40.107.11.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ACDDBEE;
        Thu, 30 Mar 2023 19:47:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXdnO4MKMSjmbgutflt+UXtAadZwPVZ7mZUSz+5RzvDZYWMnC1w8gAxuJDrQwiBXV25qIshohdR9oDNQztPSap1Wi1xMpVHXLlPphrQiGAUOPFqm1UiO6OSwAKO3b13GaZVYB1Thafex8shoIbcwU/BMuE1c69BrVxjjXfAbk+i0MAAZNZOdFGTAgH5cKgpfByP2yTArhX6E5XqfDeY9n+CnQucoC2mB/VxO0UEouSeT3VH5L0HQQHr3ybbBKt3yLPgrzwylbfIe26lkagtDhmeM9dfAVSAb82n9ZxbVrZuJ+QVrhtxZiP9Jtopq2SsoSfu4hlTVZr1jP/iKnpBHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nntFGo2evxpJKYp7eUVBIazqN/9oYWwdtdP2IczESbk=;
 b=JVZ8iDcZoOYZq2ud0J7qxhTV7cHFwdvq5qwT+3CLb3bm2W6Zw7abR9Ea+Q2wPVI9bTt4d/9yl8ILnr/q7/q/rU2L3hhFA1BvEdUHbDDEgjKRM9smb8/4P59Vd88U4B74VO5DYvOgF003j6001eo4GcrO/lpNhBw+Z8giISxQd2R9Q4lt6b2Bzx+TpiI/HfoS1gRrufiFT7iukiNLA6QCRG2+S+jOHVQ+AbV/2uAQrtsflJCLz0G2X0L27rtcFvAHjNlcJ8SOSg7kJeSM4eaESu9gCT8TLr0gQekJNMfx99S6/M4mO+IzIU+1Ma0Uln/tZn2AjFSHn2Vd6zdaP4bZiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nntFGo2evxpJKYp7eUVBIazqN/9oYWwdtdP2IczESbk=;
 b=kDurYrJiGr1gqHbKz6CW5GBT6KwbPIj1qtrb+MJk0wNGYuSRXstWTvTtMKdAc8lp5WT+mfgDhJRqH0hCmQGzyOXe0MGm297nuLpyaPWFRhWzFyDJw3afVBAYzrVUW6px5ppmFLHEZKX5JYFPQVr+fzRqiGvrVVEm2orH4QnCI7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6164.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:24d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 02:47:21 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%4]) with mapi id 15.20.6254.023; Fri, 31 Mar 2023
 02:47:21 +0000
Date:   Fri, 31 Mar 2023 03:47:01 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 10/13] rust: introduce `Task::current`
Message-ID: <20230331034701.0657d5f2.gary@garyguo.net>
In-Reply-To: <20230330043954.562237-10-wedsonaf@gmail.com>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
        <20230330043954.562237-10-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0444.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::24) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 0897653c-da54-4945-3002-08db31923fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aK3ohAEhLdG2E3gAMT1tdwNy1SXadNToOApNdqVqasvCgenEDLIEAjW2hDbYUGbrwwjNYVUHm+rfZqwxoPeeFrd6kSzWJiDFvh55nkeokDe6PH7PPR43Iiw3gDymV9KCaIU5aeGAiOMOoY4tbOz+vTejf5H9IV6PelFnf8KhOvzJ0xw33CsxtAZU/5fdt4W1VsBsrTK2XaBG/PUKSQJzt6bTjM5uLLN2m8a6SoBDMLfwA412uUfnFKyNwuw3bgbHUbvb20Wzmo8hCFVZA1+IxXORReL+vfmQlST9pxdhQoTTXIBmrYD6AKgUqOR0Y9G8nDT8R8ZsLViYmnPC2mC+0I/aC9PaehvqUoJDq/xxc8abWxpt4+/cy9jGBT8TOSFuoPvlq1iM12rOdCj1AsxYdyRfDCveSj1RBZmnXXzxXK1SoeRe7xU0UjX/Ia8a7nYaBZzIrRl0WCsR8jUui61u23KJP1ruJJAIUQ8ZshVWUO7iR0b5Mv8QJXtRKFGLxR3WcioLrRvqjGh6F3IJcvCveldCukINHVSNJwarv2OnPaortLG0S/X6lWQfzmPgVJZz9Im1DtDNOu3AwOyqdrAM7BW9KDrEl+agrgafqAlwagA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39840400004)(136003)(346002)(396003)(451199021)(2906002)(7416002)(5660300002)(8936002)(66946007)(478600001)(36756003)(41300700001)(66556008)(66476007)(4326008)(6916009)(8676002)(316002)(6506007)(54906003)(45080400002)(6486002)(186003)(6512007)(2616005)(6666004)(26005)(1076003)(86362001)(83380400001)(38100700002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9q3hhbZuIzXyq1CgkatUG1t40/IkWCVhvig+Z9Nyo0Mc/cODOZHHrPZr8VkL?=
 =?us-ascii?Q?kkFCodV5edNERUBE6lHYkFVQMmIKKNY9szRcS5yhM6qJe1KP5YjR9lBedmg7?=
 =?us-ascii?Q?93B2W3U/8L4r1x1ukkVmKo/Y7S1SKb5kBcsr6fYMmHCQ/pymcD7/rRDbkxVr?=
 =?us-ascii?Q?LHGBuDtEUnXGYXZtFmynLXcnq8WuMijk9eMGQq3KOAeSFvUWEgOmVTR52/CY?=
 =?us-ascii?Q?CvT2evv3iTT1KiYQBdG8TnXFEkO7ffML74b8nbCICLlBIz2K+foTWRi17ISy?=
 =?us-ascii?Q?Hce8oLq21AbihOvvlgFZ6ZsiAgbro3wMCR3iAWLTETYZWh7rjrE4F9gqcMDs?=
 =?us-ascii?Q?4DNBrb6OHB2E0nKDpyR6CoFORN7kvpeIMOZemc3ywT74uWVBF+Y9OSc/qEQs?=
 =?us-ascii?Q?oQoBlI1vLBME2uwLNheSz2JNKe+W8MGF8BXtUQ9d8lGClk3heJFwKrkLfVoH?=
 =?us-ascii?Q?qaOV/K62x1P2K4xJo1TSJRBIl+qC/aUqH/eBEROjNkfV1CWBQN7Snfmv8Hoj?=
 =?us-ascii?Q?Pq0AOy/3gviLuOrrM9JK78d5kZVguNLdVnOKqRr1TVz1nWaDxj3GQn6XoMuu?=
 =?us-ascii?Q?p90eSaL3G2FqIVnzjCuJHEhE5OKv2UGn7OooKmJgjshyEGXyOjmCXw1XnUQj?=
 =?us-ascii?Q?fKEk39vijcU382aEzqgrZ32LJSNV5Jv1Tsyn5j6E3JK8BUmEPCop9qd0JHLA?=
 =?us-ascii?Q?rPzKkTwC1SzotiE9Ieh9KxLu0A4ZrPKA5mjCvVxkDlJwH2OC0Y1Gve4p4azz?=
 =?us-ascii?Q?UjCAAN4bBNpoDB0VFrCJHBRlxrg2UOXMB+3/7kPKF1WOerRbQmnRrSi4LPIn?=
 =?us-ascii?Q?E0A/mGfBqjiasOrjve9bzb7/GClLyjlSmTXVnxXn7izwVp3fCGrET+fwEdqS?=
 =?us-ascii?Q?4XuWWDBFHRWQ5QwdynuCuY7c9oB129Dy4Vu4qckez+ECV4mtPx3NoaY+6nWf?=
 =?us-ascii?Q?WhvXDqLiG0YT1KpFXICiM/XBm2Qb3ZgfFUFyPlOlfLsfr+ub+769+PGBt8eb?=
 =?us-ascii?Q?/QuTjr7ZFWkUTDrOQpooqyPse3B4Fa2khNwBFAcTKP6QHDeZb6sSMyI4K9xE?=
 =?us-ascii?Q?CuEbEIxQnBTb0a6W3XBeFUcyBeGcroLpXFe61NSb5jX2rqpSp96udCwwgyyG?=
 =?us-ascii?Q?j5Zw1zYt1fClVr0PNUUAmxuktbhsozLsLTZ8ky78Pf7vPLezVaPVb1BEKMBW?=
 =?us-ascii?Q?4Zwdv5b/1OWY249dg9aOHk4AbC8vzd+8yCIohldRN0bnf0hZQyGSLV339vp8?=
 =?us-ascii?Q?poGion4y33MMtUWEuDG1OK6Why2w0nXsWD1Z1UVArWjrNAXriYzEJShCpF41?=
 =?us-ascii?Q?WANsLw6n/DkT5U0Ua/T06xXCFyWLNAr+cuZY+Fzjpk2ObmbplurUjfSX4TO3?=
 =?us-ascii?Q?IZ0+hwurmKSk0Tz8Ry213EiU7HXyIuENcagGyjL3Nw58fF2mOEfLitFzBIW8?=
 =?us-ascii?Q?fol8XT4LvkIMGprc2HRt5qEIfdnxtOwGvTFCeyi4udqUbtBrLxVxvPRYvO5E?=
 =?us-ascii?Q?Y0Vepzvq4DgJ0HK/8530Yh3XerAnRWRiLInyzJyuTQXrtb718kY9NeRAH0Y4?=
 =?us-ascii?Q?w4ZC2pvfszEpPCFwYKBVpmRA2/AZDrEXNczWvz7b?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0897653c-da54-4945-3002-08db31923fe9
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 02:47:21.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmvNYIwM26Cg8+1+xH5CssddYyHMk+LNlAh5uD42YLpKPTc2br1BrE4wj/2nvv7airLGPV+CaOHsSzomDlL+pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6164
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023 01:39:51 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This allows Rust code to get a reference to the current task without
> having to increment the refcount, but still guaranteeing memory safety.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  rust/helpers.c      |  6 ++++
>  rust/kernel/task.rs | 83 ++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 58a194042c86..96441744030e 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -100,6 +100,12 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
>  
> +struct task_struct *rust_helper_get_current(void)
> +{
> +	return current;
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_get_current);
> +
>  void rust_helper_get_task_struct(struct task_struct *t)
>  {
>  	get_task_struct(t);
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 8d7a8222990f..8b2b56ba9c6d 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -5,7 +5,7 @@
>  //! C header: [`include/linux/sched.h`](../../../../include/linux/sched.h).
>  
>  use crate::bindings;
> -use core::{cell::UnsafeCell, ptr};
> +use core::{cell::UnsafeCell, marker::PhantomData, ops::Deref, ptr};
>  
>  /// Wraps the kernel's `struct task_struct`.
>  ///
> @@ -13,6 +13,46 @@ use core::{cell::UnsafeCell, ptr};
>  ///
>  /// Instances of this type are always ref-counted, that is, a call to `get_task_struct` ensures
>  /// that the allocation remains valid at least until the matching call to `put_task_struct`.
> +///
> +/// # Examples
> +///
> +/// The following is an example of getting the PID of the current thread with zero additional cost
> +/// when compared to the C version:
> +///
> +/// ```
> +/// use kernel::task::Task;
> +///
> +/// let pid = Task::current().pid();
> +/// ```
> +///
> +/// Getting the PID of the current process, also zero additional cost:
> +///
> +/// ```
> +/// use kernel::task::Task;
> +///
> +/// let pid = Task::current().group_leader().pid();
> +/// ```
> +///
> +/// Getting the current task and storing it in some struct. The reference count is automatically
> +/// incremented when creating `State` and decremented when it is dropped:
> +///
> +/// ```
> +/// use kernel::{task::Task, ARef};
> +///
> +/// struct State {
> +///     creator: ARef<Task>,
> +///     index: u32,
> +/// }
> +///
> +/// impl State {
> +///     fn new() -> Self {
> +///         Self {
> +///             creator: Task::current().into(),
> +///             index: 0,
> +///         }
> +///     }
> +/// }
> +/// ```
>  #[repr(transparent)]
>  pub struct Task(pub(crate) UnsafeCell<bindings::task_struct>);
>  
> @@ -25,6 +65,20 @@ unsafe impl Sync for Task {}
>  type Pid = bindings::pid_t;
>  
>  impl Task {
> +    /// Returns a task reference for the currently executing task/thread.
> +    pub fn current<'a>() -> TaskRef<'a> {
> +        // SAFETY: Just an FFI call with no additional safety requirements.
> +        let ptr = unsafe { bindings::get_current() };
> +
> +        TaskRef {
> +            // SAFETY: If the current thread is still running, the current task is valid. Given
> +            // that `TaskRef` is not `Send`, we know it cannot be transferred to another thread
> +            // (where it could potentially outlive the caller).
> +            task: unsafe { &*ptr.cast() },
> +            _not_send: PhantomData,
> +        }
> +    }
> +

I don't think this API is sound, as you can do `&*Task::current()` and
get a `&'static Task`, which is very problematic.

A sound API would be

	pub fn with_current<R>(f: imp FnOnce(&Task) -> R) -> R { ... }

(which also is how thread local works in Rust)

You would have to write `Task::with_current(|cur| cur.pid())` though,
which unfortunately is a bit less ergonomic.

Best,
Gary
