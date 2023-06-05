Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82A27228D6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjFEObw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjFEObs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:31:48 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2097.outbound.protection.outlook.com [40.107.11.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69A8F1;
        Mon,  5 Jun 2023 07:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceTZapZecnYDzmhl8xrXAoH+f97dbeM2Rjpib/6k+wGOi197tjNRL4T2BVRZcqwOrPa27R5ictUHdE711h/ICHg6aOryit6JLQFvIXOsoM/fKi6JovtkH4OTXLzH9IoQoXmBQia0VsvqQceGgjVvKwnDiLYzsTPrpMXVU2LZYRpDTltz9a3ttJvFmSBacBrbd5L4Qmk0HMUxmLS3/FIu2ntS/bzLTUF4yJoMi0eheOk1vyIRvk1EOn0WFf+61gHhrJqkPCBlbqqniIwbhAcwfYkLd/TzCo+1tnSR+pGRg9+9q4cE/hOfIaBMY8IArt9owS93pT0jMWbImwYmC3jrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cog1w8AFtoEz+eixFO5Ja8Qcpiuhzcl8huW5fcmX+v0=;
 b=is7h0IIKQx8FmbfAjrOYjeQDnAjonfgaKQaKMlQmKSexuAlbyQOGtvm+aNl6fiTX9nX782Rh1NJ0GRgv6kr3GvnLiy824/XEr/5LU1pDe22snSryFc/g/ozSMoEPPjjz3gZJ7MmN5TW0mdXJpNytAcU0Lg0C5r64U3uxdSFehp0FWuoPA/u2DPCRN5v4qO8lrW9vSUjeEPvJ9MH/4hgrDunHJmkJPaIl1B+UhCglBgaLDn47Rmois8aqDSjQY2JoLY2UVMfZi71grEdcEwYbhHMmYHUSYq5awDoDHFAJRcwARwEWfMSGSdu3Gs1GMlvLUz/ZSN97xs13p5y7GziwRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cog1w8AFtoEz+eixFO5Ja8Qcpiuhzcl8huW5fcmX+v0=;
 b=MQ6PJce8OKgNP0FdtmieHrsvWmHlcmAQd8ChT2KQ4BEHXQSnuX//sV9K3HxBKCQTtwnQu0DN2/Ms6Fsh36cfGOjp73Me/gv8yql9wia0/gKts36vjhHxUHBt+/SzZy+0vm7cg1/rDICvY94aZEg4K8zC96lZUWAAeMOw+wEbTM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LOYP265MB2335.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Mon, 5 Jun
 2023 14:31:44 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2e6d:c339:6006:9013]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2e6d:c339:6006:9013%5]) with mapi id 15.20.6477.016; Mon, 5 Jun 2023
 14:31:44 +0000
Date:   Mon, 5 Jun 2023 15:31:42 +0100
From:   Gary Guo <gary@garyguo.net>
To:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v2 3/8] rust: sync: add `Arc::{from_raw, into_raw}`
Message-ID: <20230605153142.28a4093c.gary@garyguo.net>
In-Reply-To: <87v8g61119.fsf@metaspace.dk>
References: <20230601134946.3887870-1-aliceryhl@google.com>
        <20230601134946.3887870-4-aliceryhl@google.com>
        <87v8g61119.fsf@metaspace.dk>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0039.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LOYP265MB2335:EE_
X-MS-Office365-Filtering-Correlation-Id: a808b2f4-17f5-4f7f-82a9-08db65d19620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/+0ImnjldYYGGlxoQh3IqWHCEU66spDR5AAyrKZ8QZoIx+xfzDxJeOqc5K8jntMFmrCJe8WPJCe4kp2+rg/yVmnGQHMT1FPPGHs7ecd+WKsVI5GM5ZGKJ/DwBiZBBtUf98f0wEhqWHOE5RG5KK9NLPyAawb239iT2Rwxr4GQAO2QjfAa9CFTwAD1H81WONV6lomxqAxTaxJGRSzxduHfdTaNjcLWrwujUu8pexADQuBu4MThKSS13RKLs2SVEVwvEL6p3t1Gm9OTTsvi4b2F3bgDSLDC7lv7mEgU37P0VbB5V6/43TUbpLcGW0Sh3IVD4uMft2/LQtQIpSGceBkjLYJsiLWfPt6EfqB/FTK2SaR7CMhWn23AoXQFCqz6T3RWcDCbkNFzVktEmWao/aF+voSXJNsrDaVYXIu5HcPOtYFpM6kMdlVl8MPEihSoe24N1g+wd40fa8rzKGkPTWQL2UePI//sLKQJLIeeO8YJdGyOyqElMj4qT++tx89PbYhFqeyFCHDKAPlurBQwkoVbclzVTl2mxq/SYdFr3LdRCcN51vQU5uj/zIaWC+uGy1o/Lnihi/yjsVMKQi3K9kMcPtLc5NtnW+0m1IbAF7VV6c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(136003)(376002)(366004)(396003)(346002)(451199021)(6506007)(26005)(1076003)(6512007)(186003)(2616005)(966005)(7416002)(83380400001)(6486002)(36756003)(2906002)(8676002)(8936002)(54906003)(478600001)(4326008)(5660300002)(38100700002)(6916009)(86362001)(45080400002)(316002)(41300700001)(66556008)(66476007)(66946007)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0n6YMDhg9HjybfuFTt2XuCqCBN8NLXKv8OIWLFr3T8kKg3c9vIm55/EsbY5T?=
 =?us-ascii?Q?rr/TpBUFx3dfGALAP7qYzhfrcsvX+58O0r61lYvsPmzA+dfq/o/R3ZlxC70Q?=
 =?us-ascii?Q?Ht9q0Kwaw/2N5sI7gYQAs9u817g+bNtIoZ/p4ce5G86d7Kv//KhBNWQ3QJSu?=
 =?us-ascii?Q?Gj+VQmJtXnefn5AUTTC4TXbZ6RxzS46qR4ZQABtQbfLdY5jfCpkNm7WD82+f?=
 =?us-ascii?Q?jRM2hAQW2hAsZ+VvViBVaADK0Gb+ohgMbH53JWgyVIoCVXUwkBwywX2lkM1M?=
 =?us-ascii?Q?rkSczkgranWUbrGhCeHKbSGnMpABrKmBqWRAct+13n1LzhLip/y5+GauSpre?=
 =?us-ascii?Q?sCM9c8Z7KSxC7HVHnTZ39vgG8jXhqlFwS8H4K680HtP8nFtERSrGDhIaQBex?=
 =?us-ascii?Q?U/SYrbFpsKKdmofLkvPXZsFf2YNURXbOmv/cvkoMN1SEDa+3n4FL3F2OCFEx?=
 =?us-ascii?Q?6w5bbLTGc8reWPjBrTwkvkGG5uK+uMvVBJ+JSgS4vRo4zeOqaJRw8k464vbt?=
 =?us-ascii?Q?LTt+eAmbVQRPFXxLIg5sLYHvDQ3pd4i/BcTHdA49xLs3IotCbr+UaO0lKce8?=
 =?us-ascii?Q?e9Q7AkZ5wkmIyfJhBXMYeK24ZNh8pbs0KaXXWdB+TrRIOtjtgSc1fvHK2La0?=
 =?us-ascii?Q?lxvSh5yt+xubmASJ51HOtV9BPf6cqcjmTWnGox9KA8br91uCV01rUzfFAzDc?=
 =?us-ascii?Q?SIRSzxi5zft4SBe5GA/i+6x8sV7Djy/n/SKHv/zdlsdn+7OLAkSCtRUuELHr?=
 =?us-ascii?Q?mvMkjfXOQUs8r7UzXtThHMHGyV+mFMsOB48pqr/SmpBgaEFcNlW3lR/mS5of?=
 =?us-ascii?Q?ww18QA4GALnq569Tsoeuxz46N1UNYe5j/prEhG5Vl0yRQlMY130F5KcEVQXj?=
 =?us-ascii?Q?ZtY3PHqF3HEGTio1wHdv7GHF3WsgHJpfcVQD3MotDTNewQ4imSyI2u9F9Kfw?=
 =?us-ascii?Q?/z53QiGVlXOYvTGTdtLeJcV96zhRU0DPis2d2hXZcVhop6smRD7t0RO0hRL8?=
 =?us-ascii?Q?WlXn5TcQhty/brmmprJ+bwzZqknJsDYUFfhSCXPwn1RLWPGWJtWrZro/9XUU?=
 =?us-ascii?Q?2rfZdcMAwhxmdmCGDC+ujkRWXrVbqXxcK9bwsrs8JrstrIWNYWSu9D4h8cwI?=
 =?us-ascii?Q?wufnuld8SapJy7CE3jeLPb0hjwI5b6MRU+IpmWtGH6tTjV+N0Mx25xV64OLv?=
 =?us-ascii?Q?nMirva9eLfBob43fSPlXo6saQ9Zmfx1XYXoTKCLKx62TB7v/6g8w3y6TMzao?=
 =?us-ascii?Q?CTYIRAIFWSwr3Se5hlF87yhuyt4vO1yo8txFoijsxyxzpQMvd3mfHT58DAR0?=
 =?us-ascii?Q?cppyRYdySIvC0hGf9PzJAfWNS4kGFpW+T2PxuQA34rpLjtgY3MtBdtUkqB25?=
 =?us-ascii?Q?5bf7KHuTGRq5XBf8xSrWMA5YF+aTuD0FaxHGTE/ivHi+jxnO+jlsBPUlzUjK?=
 =?us-ascii?Q?R9N81QQxctA4dF6++6Vg88SJtIKVNca/LBZYiFUiij88knydJ9gr/mFnk0hm?=
 =?us-ascii?Q?hckItGH6ZGyS3OasPisyZQiL8b+jrhbWMt+i+cQY0WeVeiB5MWuD8OGD0EfP?=
 =?us-ascii?Q?/AFNkFEQr+LZTsSflkpTsf2aGK/9F6kHxSR4gtrQ?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a808b2f4-17f5-4f7f-82a9-08db65d19620
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 14:31:44.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbyLmsMAYsnU8YUS3k1fHLBXAXfXiPSSzvw81huymZ0IEnSJU15WjodYrel61ALSWNe8ebP3QMsJmDJ+x7BFyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2335
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2023 12:51:08 +0200
"Andreas Hindborg (Samsung)" <nmi@metaspace.dk> wrote:

> Alice Ryhl <aliceryhl@google.com> writes:
> 
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > These methods can be used to turn an `Arc` into a raw pointer and back,
> > in a way that preserves the metadata for fat pointers.
> >
> > This is done using the unstable ptr_metadata feature [1]. However, it
> > could also be done using the unstable pointer_byte_offsets feature [2],
> > which is likely to have a shorter path to stabilization than
> > ptr_metadata.
> >
> > Link: https://github.com/rust-lang/rust/issues/81513 [1]
> > Link: https://github.com/rust-lang/rust/issues/96283 [2]
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > ---
> >  rust/kernel/lib.rs      |  1 +
> >  rust/kernel/sync/arc.rs | 42 ++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 42 insertions(+), 1 deletion(-)
> >
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 7ea777b731e6..ad9142928fb1 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -17,6 +17,7 @@
> >  #![feature(const_refs_to_cell)]
> >  #![feature(dispatch_from_dyn)]
> >  #![feature(new_uninit)]
> > +#![feature(ptr_metadata)]
> >  #![feature(receiver_trait)]
> >  #![feature(unsize)]
> >  
> > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > index a89843cacaad..684be9f73aca 100644
> > --- a/rust/kernel/sync/arc.rs
> > +++ b/rust/kernel/sync/arc.rs
> > @@ -24,7 +24,7 @@
> >  };
> >  use alloc::boxed::Box;
> >  use core::{
> > -    alloc::AllocError,
> > +    alloc::{AllocError, Layout},
> >      fmt,
> >      marker::{PhantomData, Unsize},
> >      mem::{ManuallyDrop, MaybeUninit},
> > @@ -212,6 +212,46 @@ unsafe fn from_inner(inner: NonNull<ArcInner<T>>) -> Self {
> >          }
> >      }
> >  
> > +    /// Convert the [`Arc`] into a raw pointer.
> > +    ///
> > +    /// The raw pointer has ownership of the refcount that this Arc object owned.
> > +    pub fn into_raw(self) -> *const T {
> > +        let ptr = self.ptr.as_ptr();
> > +        core::mem::forget(self);
> > +        // SAFETY: The pointer is valid.
> > +        unsafe { core::ptr::addr_of!((*ptr).data) }
> > +    }
> > +
> > +    /// Recreates an [`Arc`] instance previously deconstructed via [`Arc::into_raw`].
> > +    ///
> > +    /// This code relies on the `repr(C)` layout of structs as described in
> > +    /// <https://doc.rust-lang.org/reference/type-layout.html#reprc-structs>.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must have been returned by a previous call to [`Arc::into_raw`]. Additionally, it
> > +    /// can only be called once for each previous call to [`Arc::into_raw`].
> > +    pub unsafe fn from_raw(ptr: *const T) -> Self {
> > +        let refcount_layout = Layout::new::<bindings::refcount_t>();
> > +        // SAFETY: The caller guarantees that the pointer is valid.
> > +        let val_layout = unsafe { Layout::for_value(&*ptr) };
> > +        // SAFETY: We're computing the layout of a real struct that existed when compiling this
> > +        // binary, so its layout is not so large that it can trigger arithmetic overflow.
> > +        let val_offset = unsafe { refcount_layout.extend(val_layout).unwrap_unchecked().1 };
> > +
> > +        // This preserves the metadata in the pointer, if any.
> > +        //
> > +        // Note that `*const T` and `*const ArcInner<T>` have the same metadata as documented at
> > +        // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.
> > +        let metadata = core::ptr::metadata(ptr as *const ArcInner<T>);  
> 
> Thanks for updating the comment with the link. I looked into this and I
> find that what we are doing here, even though it works, does not feel
> right at all. We should be able to do this:
> 
>         let metadata = core::ptr::metadata(ptr);
>         let ptr = (ptr as *mut u8).wrapping_sub(val_offset) as *mut ();
>         let ptr = core::ptr::from_raw_parts_mut(ptr, metadata);
> 
> but the way `Pointee::Metadata` is defined will not allow this, even
> though we know it is valid. I would suggest the following instead:
> 
>         let metadata = core::ptr::metadata(ptr);
>         // Convert <T as Pointee>::Metadata to <ArcInner<T> as
>         // Pointee>::Metadata. We know they have identical representation and thus this is OK.
>         let metadata: <ArcInner<T> as Pointee>::Metadata = *unsafe {
>             &*((&metadata as *const <T as Pointee>::Metadata as *const ())
>                 as *const <ArcInner<T> as Pointee>::Metadata)
>         };

This could just be a `transmute_copy`.

>         let ptr = (ptr as *mut u8).wrapping_sub(val_offset) as *mut ();
>         let ptr = core::ptr::from_raw_parts_mut(ptr, metadata);
> 
> Even though it is a bit more complex, it captures what we are trying to
> do better.

I agree this captures the semantics better.

Best,
Gary
