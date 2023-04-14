Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBE56E25E7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjDNOiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDNOiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:38:15 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2098.outbound.protection.outlook.com [40.107.10.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A7810D4;
        Fri, 14 Apr 2023 07:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MewErR/3c6NrX4KSGd1iHE5t8Mg+CHj2OWlNiKMOQ7ENwhrjk7PduowBa1tNCdF6RHt8mH5F7scCxEBKNDQinktO+bHK74K0gRrMm4dibKhwBTkqU0R3oMnQDC5v33WfW9Z8e+NVauWu9nzwyVSvtgkSWbFZVyV/Wmaw1p5u31puhbrJUOrbH21hRGzWIhc7W0F9OTt9KstKKCjCdX6EAK8l3+JpR5e6ErAKKjbjW0jZrmgk19IznVhKuUlfTzNylq+eQj/zS8qC7G6gNLSrCVppWOeHUjjpMjvG7E60TkdIHo5aZYbyuM1FdD0u4rSwL4Fn4doM6/HA+OPYy6Abaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRE+zw5X+gBoqQddWUwMU2x0u6xK+YHBE4VDrsxDHn0=;
 b=DBfG0yONaRqvChVwfnO7aMRVutO/KCSdXZFKkeh7ht0i0zVdMpTC8Z/vvNuI2ImpxZyDqaNuLIP7u7LjHcJGadvvpoJRBg0TLZOJSfgqpSMEdbgdU/u+p6TErifM5KYt0OMY2dtHgwu07Km9d9sV1tSiZnLn+qHOTT0U99Borv9rHzZXmrkSoius5lr5BdsKoaMkIkuH1j73rNdnMgkBHrl40GuzXqAA6Gza3ufGTUZBar56bMFWbmWAGL/NDqY4M8yhos37YLPKIx3E5wFNicvkJ8S7+Dr9S95lh+uOsPlY8SSZU4jM0lybnJMJGnSGW35FrSbk08QENB1erxDAAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRE+zw5X+gBoqQddWUwMU2x0u6xK+YHBE4VDrsxDHn0=;
 b=q42LdW4Q7rZVCbubEfyIu1+QSiYb6WG7fkrJz+MuJ5kInCgertEG7wIqiFkcHRIFVWsS43HbwBXGsXW0bUPkQdPrDaIQrnBm+gPd9+f48Wmjag3EtDNHlLBtmfe/6YHlGMLpOHBrXOEXcyWLOqiP/ldJy0hh8XDbj7cutF0sTNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6317.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:22a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 14:38:09 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%6]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 14:38:09 +0000
Date:   Fri, 14 Apr 2023 15:38:06 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v4 08/13] rust: introduce `ARef`
Message-ID: <20230414153806.5dabfdb3.gary@garyguo.net>
In-Reply-To: <201a4df3-7af4-5b02-5853-f8d274831f90@proton.me>
References: <20230411054543.21278-1-wedsonaf@gmail.com>
        <20230411054543.21278-8-wedsonaf@gmail.com>
        <f8575380-e710-d505-837c-bfcabe0eff00@proton.me>
        <CANeycqp_WfJxFDrxJGQ=UO2HOKtKYJCbOwGu50vZKyQSzYuiPQ@mail.gmail.com>
        <9619d06c-d631-1edb-cf92-3a998e7b98f2@proton.me>
        <CANeycqpT6thLZeuFOQqdOFwamYuFLHN5=vwEaSVgC9cNzFtg_A@mail.gmail.com>
        <201a4df3-7af4-5b02-5853-f8d274831f90@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0664.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: f66dfb2b-bca5-4476-8edd-08db3cf5ddca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpWBcHy/PV2Dfe/0LUt5uELC/goqmjYnoEeAYdpgWvhTpwmqog8j8fM/q9T3HV7XA3nGqMf1tPU4NZspixcZq+E2EvpifP+d+AN0SjbguwpwtqiKWFjtZxlVHYa4FzciJcn9YlzNAWTyd33UM8U6s8b9+vn9USuDwb3Z7mWa3CfSrVIulRD9kh6E23ArRukBQPL7OYSwnUlgLpgvmLMDcK53A/sG6oy5wX/s0QJT+dv8di9y4/IXs7B0iDqostoWTYhRs+luFN8WNMlaPV5ODhmEPQ8TOWpZkFwMEvAPHfTTL0l8vVwrZvUNSJuUhEU4dD8xeUTFvsSnvVGpiwkERxlHFxtPPlm50hDxiP0wSoQJ6gS+0F/K5NMuCTDYZeidO3/IohI/Jiw4DB5eWmir+toutHE/mkyz4x0ixw7bN8siwGlBc9usKIHTmxEpdomYCj1D2Znmt1McJr9yp1Jknyiq+e0+r0Ial8EMnplK+BfCz4hzpsMFBZEwYZdB5GDYOwm0VpKId9WGmxjXj/O4kZVdYBuzq+LdNlqbw6YhCmrV/Jn9VINEFjBSPPMapYBpaamrrvIZCmvSJ7TA34CmCFxKF4HDcxcpHfL40XCuU9E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(39830400003)(366004)(396003)(451199021)(316002)(53546011)(41300700001)(6506007)(1076003)(6512007)(86362001)(26005)(38100700002)(6486002)(186003)(6666004)(2616005)(66556008)(66476007)(83380400001)(66946007)(6916009)(4326008)(36756003)(54906003)(45080400002)(8936002)(8676002)(5660300002)(2906002)(30864003)(7416002)(478600001)(66899021)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j9R/7TAGNEb/Hj3Gil0jK7Es6SOV68zrSHxUOLITaR2Hx0rls2yMrUIxrqQ4?=
 =?us-ascii?Q?Bw0SFwrTNtL4r6UtEyEP2Cd4GzLghPCGs/o2zNVlHtUR6GV7cuhTi7BE4TqI?=
 =?us-ascii?Q?kyo04apHlApq/ZVd6C6WjnhGSajfrQT5MN3TAtqQO+SJEEa8NEsBrpO9pL0s?=
 =?us-ascii?Q?xEo5dx5rQ4fw3yHIjO9PhM3OUIBUDMr8yuLlSmb7fGkz5L6cTsufqNA3+PbT?=
 =?us-ascii?Q?8YOHKUJkH5llYJjM65psPusMUMIM54XhM+CNq1kIBRr2nMfunbZX/2uOiWpL?=
 =?us-ascii?Q?NM0Mf/wgWsEsF79DWXCHI4XXatmvQpGQoXwjN9LofVXnmq0/XzWWjaGMbaiy?=
 =?us-ascii?Q?WjZMVuEQ0F+/2OvEMqh5LKJQlXAyYdyLeCCs3XxrwlH+HCZ6azD/RV1bH0Sa?=
 =?us-ascii?Q?TOnHRo3MP1o/ZPicLnJjXcXzc0n0sreHIHDJEmORL1NGGwKpXglHK1pr7qQk?=
 =?us-ascii?Q?fL4Nmh8k0CGs8b+KnWq3+equj7Q+FSRZKVyWW+/eyKkJEOTIxB92qJ7QPDti?=
 =?us-ascii?Q?29D9nzJJ8tYoMzDOXR9FszIQaGB+glTI5/GJGRJZNSv9fxf6f9KTp2HhpHRa?=
 =?us-ascii?Q?Jws4NJ2CyUVOWwGzi/LXDstVBRZpff6HxE7kRBab9YGznus4DvK3YLRowmDR?=
 =?us-ascii?Q?fucjVtPGSoJtOqDmUYL1G/X3uLx5pH2WPlOzpz2OKiOFj7MXWGj0dyCMIH8O?=
 =?us-ascii?Q?zTMLhpE+rcm3vUH6+0htOlzlXUtFUo73g3n6KHlN6PjpPy7ZrgaYlxpeqxys?=
 =?us-ascii?Q?L8vSoli4J7n+B6bK7sR04NhD6F5PF80SOLbDRwC7FyA9hqVzU7zuBivxNJh5?=
 =?us-ascii?Q?9QmJPBYppisqWFbe0omJr+Pd8uCtj51K4k4qqImFORWxinQ6PefOORWASSRV?=
 =?us-ascii?Q?tkOfcFNnXOTPSRhk8a1vB/MJPZloTo10SuIz5KTmkS9z5pu+JcrnS3xOHF5k?=
 =?us-ascii?Q?3StxIQdzdnscEdRyWxFcdVdUX4pfCTptakOqwInbyxtvfGWpSCPbnahkyQBg?=
 =?us-ascii?Q?d3MG8gE//F7bLfYobFrnbyZpQ3d16+US50CFGRghIUCcHN3mBsRp6LDXZE7c?=
 =?us-ascii?Q?9+PFUdKR0zOtnYaXPx0L4gQtXzCbCIXeECNpLu/neOTT7Evh46LWrKRWsdFW?=
 =?us-ascii?Q?V/UOm0MYZk2UIBskA+fK/QvMNWExWn3LQcDFOhQZSEBrFrozFIJyAnVKIfVf?=
 =?us-ascii?Q?IQ2NR8lJSsRritYwQNITktzc+B93qqH+FYHO0Mv0Ib4mhsqzs5ILyLZPy6e0?=
 =?us-ascii?Q?OXsyJg5nPLR1V13GpmrA2NMwE+xIHsvth/qdhtjjZE5Jx0A1g0QlluKESKDr?=
 =?us-ascii?Q?KEZqycdrNobI2Dqxp76yrKAXLsH5BwtFPnE+quhWn2azDl1+Gm/roLwmXpl6?=
 =?us-ascii?Q?2MSc4xlZ8EyJSyMZFnB0S0K1NFbMpkxP6WjKJq78K9asqlBa+1wi3yCTm0wT?=
 =?us-ascii?Q?vHkfDZF+nGwdlqAeaQcAX/cQ7zSWOX/EeYMkxUpmIpv0QRvq8xwpdsoR53JS?=
 =?us-ascii?Q?lL2PSW3l3E6VxSXYZcgpcenyfX77zsZ0aP4GcQO++UnfoQHXNsx4atXakHsA?=
 =?us-ascii?Q?xg7yL7YOWOjRNDoYRD0uiHoYA/v6Yen+Gnk4UWIc?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f66dfb2b-bca5-4476-8edd-08db3cf5ddca
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 14:38:09.0815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6j4ffs9R76Um7h3lkT//0wxaRB8b5qBgV5caHukwtng6iKq9iJIU6mnlbfVlxs5RH5srlDiziBMcH70U25bzuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6317
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023 09:46:53 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 14.04.23 11:00, Wedson Almeida Filho wrote:
> > On Thu, 13 Apr 2023 at 19:30, Benno Lossin <benno.lossin@proton.me> wrote:  
> >>
> >> On 13.04.23 19:06, Wedson Almeida Filho wrote:  
> >>> On Thu, 13 Apr 2023 at 06:19, Benno Lossin <benno.lossin@proton.me> wrote:  
> >>>>
> >>>> On 11.04.23 07:45, Wedson Almeida Filho wrote:  
> >>>>> From: Wedson Almeida Filho <walmeida@microsoft.com>
> >>>>>
> >>>>> This is an owned reference to an object that is always ref-counted. This
> >>>>> is meant to be used in wrappers for C types that have their own ref
> >>>>> counting functions, for example, tasks, files, inodes, dentries, etc.
> >>>>>
> >>>>> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> >>>>> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> >>>>> ---
> >>>>> v1 -> v2: No changes
> >>>>> v2 -> v3: No changes
> >>>>> v3 -> v4: No changes
> >>>>>
> >>>>>     rust/kernel/types.rs | 107 +++++++++++++++++++++++++++++++++++++++++++
> >>>>>     1 file changed, 107 insertions(+)
> >>>>>
> >>>>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> >>>>> index a4b1e3778da7..29db59d6119a 100644
> >>>>> --- a/rust/kernel/types.rs
> >>>>> +++ b/rust/kernel/types.rs
> >>>>> @@ -6,8 +6,10 @@ use crate::init::{self, PinInit};
> >>>>>     use alloc::boxed::Box;
> >>>>>     use core::{
> >>>>>         cell::UnsafeCell,
> >>>>> +    marker::PhantomData,
> >>>>>         mem::MaybeUninit,
> >>>>>         ops::{Deref, DerefMut},
> >>>>> +    ptr::NonNull,
> >>>>>     };
> >>>>>
> >>>>>     /// Used to transfer ownership to and from foreign (non-Rust) languages.
> >>>>> @@ -268,6 +270,111 @@ impl<T> Opaque<T> {
> >>>>>         }
> >>>>>     }
> >>>>>
> >>>>> +/// Types that are _always_ reference counted.
> >>>>> +///
> >>>>> +/// It allows such types to define their own custom ref increment and decrement functions.
> >>>>> +/// Additionally, it allows users to convert from a shared reference `&T` to an owned reference
> >>>>> +/// [`ARef<T>`].
> >>>>> +///
> >>>>> +/// This is usually implemented by wrappers to existing structures on the C side of the code. For
> >>>>> +/// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to create reference-counted
> >>>>> +/// instances of a type.
> >>>>> +///
> >>>>> +/// # Safety
> >>>>> +///
> >>>>> +/// Implementers must ensure that increments to the reference count keep the object alive in memory
> >>>>> +/// at least until matching decrements are performed.
> >>>>> +///
> >>>>> +/// Implementers must also ensure that all instances are reference-counted. (Otherwise they
> >>>>> +/// won't be able to honour the requirement that [`AlwaysRefCounted::inc_ref`] keep the object
> >>>>> +/// alive.)  
> >>>>
> >>>> `dec_ref` states below that it 'Frees the object when the count reaches
> >>>> zero.', this should also be stated here, since implementers should adhere
> >>>> to that when implementing `dec_ref`.  
> >>>
> >>> This section is for safety requirements. Freeing the object doesn't
> >>> fall into this category.  
> >>
> >> It still needs to be upheld by the implementer, since it is guaranteed by
> >> the documentation on the `dec_ref` function. Even non-safety requirements
> >> are listed on the `unsafe` traits, if users should be able to rely on them.
> >> If users should not rely on this, then maybe change the docs of `dec_ref`
> >> to "when the refcount reaches zero, the object might be freed.".  
> >
> > I disagree that non-safety requirements should be listed under the
> > Safety section.
> >
> > This section is meant for rules that implementers must adhere to to
> > ensure their implementations are safe. So it's usually read before
> > writing a "SAFETY:" comment for their "unsafe impl" blocks -- adding
> > extraneous information is counterproductive.  
> 
> Sure, I think it you could still mention it outside of the safety section.
> 
> >>>>> +pub unsafe trait AlwaysRefCounted {
> >>>>> +    /// Increments the reference count on the object.
> >>>>> +    fn inc_ref(&self);  
> >>>>
> >>>>
> >>>>  
> >>>>> +
> >>>>> +    /// Decrements the reference count on the object.
> >>>>> +    ///
> >>>>> +    /// Frees the object when the count reaches zero.
> >>>>> +    ///
> >>>>> +    /// # Safety
> >>>>> +    ///
> >>>>> +    /// Callers must ensure that there was a previous matching increment to the reference count,
> >>>>> +    /// and that the object is no longer used after its reference count is decremented (as it may
> >>>>> +    /// result in the object being freed), unless the caller owns another increment on the refcount
> >>>>> +    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then calls
> >>>>> +    /// [`AlwaysRefCounted::dec_ref`] once).
> >>>>> +    unsafe fn dec_ref(obj: NonNull<Self>);
> >>>>> +}
> >>>>> +
> >>>>> +/// An owned reference to an always-reference-counted object.
> >>>>> +///
> >>>>> +/// The object's reference count is automatically decremented when an instance of [`ARef`] is
> >>>>> +/// dropped. It is also automatically incremented when a new instance is created via
> >>>>> +/// [`ARef::clone`].
> >>>>> +///
> >>>>> +/// # Invariants
> >>>>> +///
> >>>>> +/// The pointer stored in `ptr` is non-null and valid for the lifetime of the [`ARef`] instance. In
> >>>>> +/// particular, the [`ARef`] instance owns an increment on the underlying object's reference count.
> >>>>> +pub struct ARef<T: AlwaysRefCounted> {
> >>>>> +    ptr: NonNull<T>,
> >>>>> +    _p: PhantomData<T>,
> >>>>> +}
> >>>>> +
> >>>>> +impl<T: AlwaysRefCounted> ARef<T> {
> >>>>> +    /// Creates a new instance of [`ARef`].
> >>>>> +    ///
> >>>>> +    /// It takes over an increment of the reference count on the underlying object.
> >>>>> +    ///
> >>>>> +    /// # Safety
> >>>>> +    ///
> >>>>> +    /// Callers must ensure that the reference count was incremented at least once, and that they
> >>>>> +    /// are properly relinquishing one increment. That is, if there is only one increment, callers
> >>>>> +    /// must not use the underlying object anymore -- it is only safe to do so via the newly
> >>>>> +    /// created [`ARef`].
> >>>>> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
> >>>>> +        // INVARIANT: The safety requirements guarantee that the new instance now owns the
> >>>>> +        // increment on the refcount.
> >>>>> +        Self {
> >>>>> +            ptr,
> >>>>> +            _p: PhantomData,
> >>>>> +        }
> >>>>> +    }
> >>>>> +}
> >>>>> +
> >>>>> +impl<T: AlwaysRefCounted> Clone for ARef<T> {
> >>>>> +    fn clone(&self) -> Self {
> >>>>> +        self.inc_ref();
> >>>>> +        // SAFETY: We just incremented the refcount above.
> >>>>> +        unsafe { Self::from_raw(self.ptr) }
> >>>>> +    }
> >>>>> +}
> >>>>> +
> >>>>> +impl<T: AlwaysRefCounted> Deref for ARef<T> {
> >>>>> +    type Target = T;
> >>>>> +
> >>>>> +    fn deref(&self) -> &Self::Target {
> >>>>> +        // SAFETY: The type invariants guarantee that the object is valid.
> >>>>> +        unsafe { self.ptr.as_ref() }
> >>>>> +    }
> >>>>> +}
> >>>>> +
> >>>>> +impl<T: AlwaysRefCounted> From<&T> for ARef<T> {
> >>>>> +    fn from(b: &T) -> Self {
> >>>>> +        b.inc_ref();
> >>>>> +        // SAFETY: We just incremented the refcount above.
> >>>>> +        unsafe { Self::from_raw(NonNull::from(b)) }
> >>>>> +    }
> >>>>> +}  
> >>>>
> >>>> This impl seems unsound to me, as we can do this:
> >>>>
> >>>>        struct MyStruct {
> >>>>            raw: Opaque<bindings::my_struct>, // This has a `refcount_t` inside.
> >>>>        }
> >>>>
> >>>>        impl MyStruct {
> >>>>            fn new() -> Self { ... }
> >>>>        }
> >>>>
> >>>>        unsafe impl AlwaysRefCounted for MyStruct { ... } // Implemented correctly.
> >>>>
> >>>>        fn evil() -> ARef<MyStruct> {
> >>>>            let my_struct = MyStruct::new();
> >>>>            ARef::from(&my_struct) // We return a pointer to the stack!
> >>>>        }
> >>>>
> >>>> similarly, this can also be done with a `Box`:
> >>>>
> >>>>        fn evil2() -> ARef<MyStruct> {
> >>>>            let my_struct = Box::new(MyStruct::new());
> >>>>            ARef::from(&*my_struct)
> >>>>            // Box is freed here, even just dropping the `ARef` will result in
> >>>>            // a UAF.
> >>>>        }  
> >>>
> >>> This implementation of `AlwaysRefCounted` is in violation of the
> >>> safety requirements of the trait, namely:
> >>>
> >>> /// Implementers must ensure that increments to the reference count
> >>> keep the object alive in memory
> >>> /// at least until matching decrements are performed.
> >>> ///
> >>> /// Implementers must also ensure that all instances are
> >>> reference-counted. (Otherwise they
> >>> /// won't be able to honour the requirement that
> >>> [`AlwaysRefCounted::inc_ref`] keep the object
> >>> /// alive.)
> >>>
> >>> It boils down `MyStruct::new` in your example. It's not refcounted.
> >>>  
> >>>> Additionally, I think that `AlwaysRefCounted::inc_ref` should not be safe,
> >>>> as the caller must not deallocate the memory until the refcount is zero.  
> >>>
> >>> The existence of an `&T` is evidence that the refcount is non-zero, so
> >>> it is safe to increment it. The caller cannot free the object without
> >>> violating the safety requirements.
> >>>  
> >>>> Another pitfall of `ARef`: it does not deallocate the memory when the
> >>>> refcount reaches zero. People might expect that this code would not leak
> >>>> memory:
> >>>>
> >>>>        let foo = Box::try_new(Foo::new())?;
> >>>>        let foo = Box::leak(foo); // Leak the box, such that we do not
> >>>>                                  // deallocate the memory too early.
> >>>>        let foo = ARef::from(foo);
> >>>>        drop(foo); // refcount is now zero, but the memory is never deallocated.  
> >>>
> >>> This is also in violation of the safety requirements of `AlwaysRefCounted`.  
> >>
> >> It seems I have misunderstood the term "always reference counted".
> >> We should document this in more detail, since this places a lot of
> >> constraints on the implementers:
> >>
> >>       Implementing `AlwaysRefCounted` for `T` places the following constraint on shared references `&T`:
> >>       - Every `&T` points to memory that is not deallocated until the reference count reaches zero.
> >>       - The existence of `&T` proves that the reference count is at least 1.  
> >
> > This is implied by the existing safety rules.  
> 
> This was not obvious to me at all, I think we should extend the docs and
> make this very clear.
> 
> >>       This has some important consequences:
> >>       - Exposing safe a way to get `T` is not allowed, since stack allocations are freed when the scope
> >>         ends even though the reference count is non-zero.  
> >
> > Stack allocations are ok, as long as they wait for the refcount to
> > drop to zero before the variable goes out of scope.  
> 
> "Exposing a **safe** way", you cannot under any circumstances allow safe
> code access to by value `T` when it implements `AlwaysRefCounted`, since
> safe code can create a `&T` without upholding the invariants.
> 
> In your controlled function, you can create `T`s on the stack if you want,
> but giving them out to safe code is the problem.
> 
> >>       - Similarly giving safe access to `Box<T>` or other smart pointers is not allowed, since a `Box` can
> >>         be freed independent from the reference count.  
> >
> > `ARef<T>` is a smart pointer and it is definitely allowed.  
> 
> Yes, I meant smart pointers except `ARef`. E.g. putting `T` inside of an
> `Arc` has the same problem as `Box<T>`.
> 
> >
> > Similarly to stack allocations I mention above, a `Box<T>`
> > implementation is conceivable as long as it ensures that the
> > allocation is freed only once the refcount reaches zero, for example,
> > by having a drop implementation that performs such a wait. (IOW, when
> > `Box<T>` goes out of scope, it always calls `drop` on `T` before
> > actually freeing the memory, so this implementation could block until
> > it is safe to do so, i.e., until the refcount reaches zero.)  
> 
> Is this something you want to do? Because to me this sounds like something
> that could end up deadlocking very easily.
> 
> AIUI `AlwaysRefCounted` is intended for wrapper structs that are never
> created on the Rust side. They are created and destroyed by C.

No.

It's perfectly legal for Rust code to implement this trait, and it
might even be desirable in some cases, because it gives more control
than relying on `Arc` and `Drop`.

For example, if a type is usable in RCU, then you might want to have
some code like this:

impl AlwaysRefCounted for MyType {
    fn inc_ref(&self) {
        self.refcnt.fetch_add(1, Ordering::Relaxed);
    }

    fn dec_ref(this: NonNull<Self>) {
       let refcnt = this.as_ref().refcnt.fetch_sub(1, Ordering::Relaxed) - 1;
       if refcnt == 0 {
           // Unpublish the pointer from some RCU data structure
           synchronize_rcu();
           // proceed to drop the type and box
       }
    }
}

The example given above can't rely on dtor because `drop` takes a
mutable reference.

> The scenario
> of putting them into a `Box` or `Arc` should never happen, since Rust does
> not have a way to create them.
> 
> As soon as this is not the only use case for this trait, I feel like this
> trait becomes very dangerous, since there are many different ways for you
> to mess up via normal coding patterns.
> 
> Hence I think it is better to spell out the dangerous patterns here and
> forbid them, since the only use case should never use them anyway.
> 
> Also in the `Box` case, the same problem as with `&mut T` exists, since
> you can derive a `&mut T` from it.
> 
> >  
> >>       This type is intended to be implemented for C types that embedd a `refcount_t` and that are both
> >>       created and destroyed by C. Static references also work with this type, since they stay live
> >>       indefinitely.  
> >
> > Embedding a `refcount_t` is not a requirement. I already mention in
> > the documentation that this is usually used for C structs and that
> > Rust code should use `Arc`.  
> 
> I would prefer if we change the wording in the docs from `usually` to
> `only`. If you agree with my interpretation above, then Rust types should
> not implement this trait.
> 
> >  
> >>       Implementers must also ensure that they never give out `&mut T`, since
> >>       - it can be reborrowed as `&T`,
> >>       - converted to `ARef<T>`,
> >>       - which can yield a `&T` that is alive at the same time as the `&mut T`.  
> >
> > I agree with this. And I don't think this is a direct consequence of
> > the safety requirements, so I think it makes sense to add something
> > that covers this.
> >  
> >>>>> +
> >>>>> +impl<T: AlwaysRefCounted> Drop for ARef<T> {
> >>>>> +    fn drop(&mut self) {
> >>>>> +        // SAFETY: The type invariants guarantee that the `ARef` owns the reference we're about to
> >>>>> +        // decrement.
> >>>>> +        unsafe { T::dec_ref(self.ptr) };
> >>>>> +    }
> >>>>> +}
> >>>>> +
> >>>>>     /// A sum type that always holds either a value of type `L` or `R`.
> >>>>>     pub enum Either<L, R> {
> >>>>>         /// Constructs an instance of [`Either`] containing a value of type `L`.
> >>>>> --
> >>>>> 2.34.1
> >>>>>  
> >>>>  
> >>  
> 

