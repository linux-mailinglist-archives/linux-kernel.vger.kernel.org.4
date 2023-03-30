Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473326D07F1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjC3OSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjC3OSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:18:38 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2117.outbound.protection.outlook.com [40.107.11.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89431CC2C;
        Thu, 30 Mar 2023 07:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJA0rw38LOZ0HIY1jSLwJY3i3a4KEvs6VYr3ju3QTUYd/ZFxTNZAITaqbCT4g1aNoqQr7kzRJsGPolCrsmD6KqPznq+ss9kXh4/ARy/ZCavSDEKhKdWGJ1Vkge59LRckQVvwdhoDBNni4uPaOx7FetnvwkMN7mUbNi7bIrv3ZzoYf/vSfDttdZhchjJ5Guu7F/iHvHQOvIEsWx5+AGNkpoQrhSAWvcN6CSpwlA9OytYTGOURZPEfP5O+5y74c9ksLixSel2CaRHn+N4hQ6OJp/JTYzKoNyjAn/UGl0FVhoNRmEMqG3QMBcE/NegPOeXpF8EGbZKu2ajBUyhlkbR8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQztMGI/Big+PDfTjOMsWQbqSuvcXJiht2yCGruKEI4=;
 b=Q4zrC5cDVh6Ib+ygMB1Uf/jmbx1aVwR/3EVN/Xf5zPR0Il527bfrQnqJ3IzRAhUnV7fOhbuEbvc7vMrGN9Tih7Fm99cnHNp7fWkyzOIiXXyl83MTuLd2cy0iNGjDcqpdQAR75MwXGdA5aJCIawtqCbzsWxpkuhLeWn16ZFQtuC61qAMRZHW2VBNxGCp436Cw7QggeI/dxKBcGmwk/sma4ZcifjVEXYg78HhOjCcnIy8qs5H7yb9n3Jom9Ns2vVtMgpH4pTYTz1s8cZtbWP8xF+JhQWypb/hMb0uvz/+0obb6oJzwXWUX0kz22TkSAqivYxVc/hzSRAKSlHCVQlKa2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQztMGI/Big+PDfTjOMsWQbqSuvcXJiht2yCGruKEI4=;
 b=LgDRpZcxRaJtEtJKvgaAOSeHUMUvitzmYTt0GkjbHA4wUUT6Xt1cGkpUmhKp+QjNyd3boYGf1a5hlJQ/8+0s4Z+bWgAJ9OUfWRcZtITgHNZFsjJIUT5FzOgPnZSoINiOP15HYy9esMT0FtcASaRubxkxaBAoh+IzDKuazIuxPS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LOYP265MB2256.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:11a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 14:17:29 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 14:17:29 +0000
Date:   Thu, 30 Mar 2023 15:17:28 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 08/13] rust: introduce `ARef`
Message-ID: <20230330151728.5f84a692.gary@garyguo.net>
In-Reply-To: <20230330043954.562237-8-wedsonaf@gmail.com>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
        <20230330043954.562237-8-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0035.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LOYP265MB2256:EE_
X-MS-Office365-Filtering-Correlation-Id: 09877d05-75ee-4ffd-6e63-08db31297ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gLEX1F1oHlx7QtwBccZPxJlhl0VowH2RYQIMVTTjRP6hdw4IxHzvlxjH/ojX0NG8XHVMa+PLQwVbBcg0V8FFj5rnOfUqLIRip9uslECGHBA43UdzfpBa3WeY/RjV1tMJldJvVUCK00g9DqCvHLG5ZGFnMhq3QUIQoa6P+712tM1UkNWkuAKeoBbW9XqWQQqfTwSKhAz23aJn7LSu7rnS4AvMMm6JOb6FabVynWAQyAwA7LXpKphwGF7Qg9V7S9xtx3JsaZu9VH1V1e+7RnBrJevp0aGCLKMKsKzTFdONTIWBQmzAnR8nOR2F4UWaVLwsfT2csAqi0SV4yGDqNocLKEdkxPeFskyW5uYPPMKeKg/NTmONPmiBLZIPDkAheUN9dqvruiTEqncufCrLyi42XsqiZ60kjKGE16u2vofFZ7GyOKpVEvArqtcvKqcHrr0jnVQPfc00zSgrlDVRtJBsYWMtqUMRFBn6LVe+RYIScvrukowdWax7M7brIVzRS5MTzd7/aUgkI4rO3BgT7WfkFv2CEURN7ERRBR/gHcN2QJGM81y6KEHW0gJ3yc2TakvX2gwUxB7sr0uP1gwL0LaXfOLApCcFPp4dYbcnonNGXjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(136003)(366004)(396003)(346002)(376002)(451199021)(38100700002)(6916009)(8936002)(5660300002)(66946007)(36756003)(66476007)(8676002)(41300700001)(66556008)(4326008)(6486002)(2616005)(54906003)(26005)(1076003)(86362001)(6506007)(2906002)(6512007)(186003)(478600001)(45080400002)(316002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OgVTariO+ho7mcreQlWE/EWEtWvZmW5H1PFU3vNBWXOi1D0cIh/UsG3HAWjN?=
 =?us-ascii?Q?IPHWWx56Rio+c6em33+3SG771YzttJdS0Ylr+W/bj/+u2oO8w5hNn2Jyi88D?=
 =?us-ascii?Q?qmZZ30/hjAPkgOnXVdXdJRTwjMXqWWq8MrBauS13L+hsUtTQPO1kK/KOYiTS?=
 =?us-ascii?Q?spJvlg9IaHvxSXMtyBzuHmkeFPEOMUjuiakxtqVX3FAYA70qW7MLccMhsNQH?=
 =?us-ascii?Q?RnbXKBsZ/eNHc2gisXXiX4b0DZtHMjLOUXcM8EZZd7muPu0ewwWrZtR6EVoC?=
 =?us-ascii?Q?SN1lxE1Tbqu/d5Un0PNPlOC4gD6/fTOBUJBwkEluw4AiX1mimZBW99AZpyb7?=
 =?us-ascii?Q?yNmwJ4jqhR33jUQh+BwvQXbOOIv1j0fyC9EKYNakA8NpJqcxSYNRsSzPzr7Y?=
 =?us-ascii?Q?wQr3lVyL5DVJw2w0wiobLLlik51UmgQh4qEQnb91A8gIrBUcwsmLKVFVGaeu?=
 =?us-ascii?Q?zmAVh8Oywsdy54jexHZ7EiS+o0QbEa2K21zs3FKZjdbl8FnBHCcw4pYTz5Ft?=
 =?us-ascii?Q?92Di4bQkuhz3x+fPXtnuYoFskbd2aeuY266MtLuOd5mV8YCWYcBJfTXi7L1X?=
 =?us-ascii?Q?4Y2mcpYhdD9PVOmh1PoALpI5s7yAjGS0SaPjstpqePtQaiDJWjvbBjoASt0y?=
 =?us-ascii?Q?JGx7Awq0t/6GRjaAkzzv96UkHFOk1AtJWA4NRGLKFtU0Ze072Qii7akJoRQa?=
 =?us-ascii?Q?1HulJmH1gM2EygPnry8fpZAKYXF+ZO5O9eGwFUwgVUUEiU4L5DPZ0UPHi2m5?=
 =?us-ascii?Q?xa4dEAko1hunXlfJBw/snr6m1wBNKSUTvjBDUqfUgSdIwm4Yv/5xB0lAdVq9?=
 =?us-ascii?Q?QP5giMZjuW8cZsyQHX4goN1m/MUL9jpG5YRCHCty4Bba4uIAoQRQDUPco+Zi?=
 =?us-ascii?Q?dQ7GZDNBAMNqVFO6eD01HawWhrSaUeTeYeVlzzI0KoXYG1jnAncqdGVKynWf?=
 =?us-ascii?Q?CZZfNWGAULx0P51thlKutGuxGjCQaRfISR1pScFywbs84pTl/pCD43U0g/+O?=
 =?us-ascii?Q?6sBK8uQ6AhnrEPs56sDTXv7SCYemi+FXaNFx0v3FTz2EnO1rJoo5gCr5yLMB?=
 =?us-ascii?Q?9YtwU2VLAYgwcIHVY78yZVzLet715D1UQH5TnhXgwUVPoqYAmDl+9yFQCvBp?=
 =?us-ascii?Q?to0fxlLFfUt1RyqRMjQDGl9lfqepV47j7P3rMZerJJj1E79z6Ub9Pyw48ZoS?=
 =?us-ascii?Q?u9epAhZTzze5Bh71YlPx7cfalpRDkJRpUwuWX0OVX0qe2fxCBdaUpAGQFfxF?=
 =?us-ascii?Q?HO+KM5OjE5G7+3XMAi4XSEHNJLkfrbuxWVip70O9tWyobkA0W2Vol9arKeBT?=
 =?us-ascii?Q?PM1Csx33mttuJUDdlTlbc3Fwa95BhSpTHyUlN5BtCxkB6OPTdGDJlaxuJTnh?=
 =?us-ascii?Q?5iEMB8U0lhg6ynxDOTs/Pz0f+k+Xk2lD6+1rKnZZg3h/6vQBTtqbJg8BYdwR?=
 =?us-ascii?Q?SHGr9g/Hsos32FcLRFulifmUqw6LfqCKTmBQXxPBjPiIp7GfXy6u+gMM0zwS?=
 =?us-ascii?Q?Dc+cIv8r5wZvtVYhxlkvMIxetybzmj9lIFECgjkr1BReU+xg1c/dyVkH+L8J?=
 =?us-ascii?Q?JbQPUSTTDxsKC0nZUmA28lxJmsFI/gXtZsSkMijQ?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 09877d05-75ee-4ffd-6e63-08db31297ef6
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:17:29.7938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPDbq3Z/uHNeyDF9GxTxV8dp7e5KC9HUWPlT9viQjt8HdTzR/dz/KHZLCNCFjsk2YSSm4wJkpZsQvo9XLMU0zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2256
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023 01:39:49 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This is an owned reference to an object that is always ref-counted. This
> is meant to be used in wrappers for C types that have their own ref
> counting functions, for example, tasks, files, inodes, dentries, etc.
> 
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/types.rs | 107 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index dbfae9bb97ce..b071730253c7 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -6,8 +6,10 @@ use crate::init::{self, PinInit};
>  use alloc::boxed::Box;
>  use core::{
>      cell::UnsafeCell,
> +    marker::PhantomData,
>      mem::MaybeUninit,
>      ops::{Deref, DerefMut},
> +    ptr::NonNull,
>  };
>  
>  /// Used to transfer ownership to and from foreign (non-Rust) languages.
> @@ -295,6 +297,111 @@ opaque_init_funcs! {
>      "Rust" manual_init4(arg1: A1, arg2: A2, arg3: A3, arg4: A4);
>  }
>  
> +/// Types that are _always_ reference counted.
> +///
> +/// It allows such types to define their own custom ref increment and decrement functions.
> +/// Additionally, it allows users to convert from a shared reference `&T` to an owned reference
> +/// [`ARef<T>`].
> +///
> +/// This is usually implemented by wrappers to existing structures on the C side of the code. For
> +/// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to create reference-counted
> +/// instances of a type.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that increments to the reference count keep the object alive in memory
> +/// at least until matching decrements are performed.
> +///
> +/// Implementers must also ensure that all instances are reference-counted. (Otherwise they
> +/// won't be able to honour the requirement that [`AlwaysRefCounted::inc_ref`] keep the object
> +/// alive.)
> +pub unsafe trait AlwaysRefCounted {
> +    /// Increments the reference count on the object.
> +    fn inc_ref(&self);
> +
> +    /// Decrements the reference count on the object.
> +    ///
> +    /// Frees the object when the count reaches zero.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that there was a previous matching increment to the reference count,
> +    /// and that the object is no longer used after its reference count is decremented (as it may
> +    /// result in the object being freed), unless the caller owns another increment on the refcount
> +    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then calls
> +    /// [`AlwaysRefCounted::dec_ref`] once).
> +    unsafe fn dec_ref(obj: NonNull<Self>);
> +}
> +
> +/// An owned reference to an always-reference-counted object.
> +///
> +/// The object's reference count is automatically decremented when an instance of [`ARef`] is
> +/// dropped. It is also automatically incremented when a new instance is created via
> +/// [`ARef::clone`].
> +///
> +/// # Invariants
> +///
> +/// The pointer stored in `ptr` is non-null and valid for the lifetime of the [`ARef`] instance. In
> +/// particular, the [`ARef`] instance owns an increment on the underlying object's reference count.
> +pub struct ARef<T: AlwaysRefCounted> {
> +    ptr: NonNull<T>,
> +    _p: PhantomData<T>,
> +}
> +
> +impl<T: AlwaysRefCounted> ARef<T> {
> +    /// Creates a new instance of [`ARef`].
> +    ///
> +    /// It takes over an increment of the reference count on the underlying object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the reference count was incremented at least once, and that they
> +    /// are properly relinquishing one increment. That is, if there is only one increment, callers
> +    /// must not use the underlying object anymore -- it is only safe to do so via the newly
> +    /// created [`ARef`].
> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
> +        // INVARIANT: The safety requirements guarantee that the new instance now owns the
> +        // increment on the refcount.
> +        Self {
> +            ptr,
> +            _p: PhantomData,
> +        }
> +    }
> +}
> +
> +impl<T: AlwaysRefCounted> Clone for ARef<T> {
> +    fn clone(&self) -> Self {
> +        self.inc_ref();
> +        // SAFETY: We just incremented the refcount above.
> +        unsafe { Self::from_raw(self.ptr) }
> +    }
> +}
> +
> +impl<T: AlwaysRefCounted> Deref for ARef<T> {
> +    type Target = T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: The type invariants guarantee that the object is valid.
> +        unsafe { self.ptr.as_ref() }
> +    }
> +}
> +
> +impl<T: AlwaysRefCounted> From<&T> for ARef<T> {
> +    fn from(b: &T) -> Self {
> +        b.inc_ref();
> +        // SAFETY: We just incremented the refcount above.
> +        unsafe { Self::from_raw(NonNull::from(b)) }
> +    }
> +}
> +
> +impl<T: AlwaysRefCounted> Drop for ARef<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: The type invariants guarantee that the `ARef` owns the reference we're about to
> +        // decrement.
> +        unsafe { T::dec_ref(self.ptr) };
> +    }
> +}
> +
>  /// A sum type that always holds either a value of type `L` or `R`.
>  pub enum Either<L, R> {
>      /// Constructs an instance of [`Either`] containing a value of type `L`.

