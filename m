Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B631A6DE5F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjDKUpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjDKUpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:45:22 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2121.outbound.protection.outlook.com [40.107.11.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A254EFE;
        Tue, 11 Apr 2023 13:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ks21msVRC9zpLTdl3PL129Ngj1rDnC7yT9mIJiTbk14CcNJUIErHHkHUr+EwdY6wPW0IN7M/n8b8jkgbYf1bG6UF5CMSmpbEi+Nxy+MNB664/BrmwXq2046RFStkRT3GEgDdth5r6rfNngWj9ELTZeKrJBblke49y3sZMDM1f5eo6FiJoE6XOWXjyeKfHO4J2o8w/1bONq/cqOB3aGKxgDE0DQ1yCxB6bHeUMNA3jtL8cJC0EucQSiV73xHrYyGaIEc34AKXno4Js791jBeRdJfrvSpK3Wo/G+r+sLeoJXEoZ4aAif1Y6sK5U9NlKmvDrg/hRxFLXpS3Dgbj/4m1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFBMJqwEdzL6JglkpB2E/Nz9XmKCKYzaJ3J/bPNx2bA=;
 b=M5IdoorzY3EovlnI0zugHIHk7+HYlkUhkYNDtxmBRdK+5hFz6i6fhwx0isAadZd9gazoZAf9eD4r+rWlPKrKwyNHuVvx0R9TezVFYwaCo/KxJxwugaFA12+L0nJWZnlswQEz5kwU4vTVBacYYz78P01iKExFUdFwQLli7U4JCGtVcOroF4gMQNpDBEQDbOTpJHVCIQ5N8eyJKLslzDPQnvfPH1uTzp8G+kO+GOZ+4Jr6awikk8Tda7psj35jFpzyfmLCzo92G87iuriF1tvWzBa1k64tdqN0XF33bOCORrniUntDoKQOflCbw4xrTN+/zgzOazS3eMroQBKzmMg0dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFBMJqwEdzL6JglkpB2E/Nz9XmKCKYzaJ3J/bPNx2bA=;
 b=g9NUCCs18XyL+u1xnbrn9rFPO0nZ8iPmZU+wOYU5nt7Z+g0s9sUNMBsT6oB0ciCnZ2wep+kiR9DOhodywKXHqkP6R7nXe++i4y/ShbSrqNQ/pD+h/yh4BwLtyljnajPrtuNKUjCgK8UK15RTL+TShw/eHmsmurVYvluML5RqGek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6850.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 20:45:09 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%6]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 20:45:09 +0000
Date:   Tue, 11 Apr 2023 21:45:08 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v4 08/13] rust: introduce `ARef`
Message-ID: <20230411214508.5c2c3e82.gary@garyguo.net>
In-Reply-To: <20230411054543.21278-8-wedsonaf@gmail.com>
References: <20230411054543.21278-1-wedsonaf@gmail.com>
        <20230411054543.21278-8-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0296.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::10) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 383cd59f-871f-431b-d279-08db3acda3be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pA30oZ0azS6CkQxKaP6b+8+MV8ts5gaAn1W+o6xrPSzD2J5pAH4dwWX64kTOk2BJfUB3C7ndeN7UVKxa8ztiqL3Wm0xeeK6bLHEK+yXaKyQ8oFFW2EtjxQ5UkjQTBvqTgTOQZ8OvAOP3j4yCq8+/s+wr5ZX7Un/Ei5nZsbxiFlWnd1TGrQssdTSfWR+S3TSuiZk6hF2X9NHPTVIxd5gQ7RMLIQ4bHWyGjXMg5OMDYpijNgBwPh8KT70tIvjKm7EbJWLBG3ln2yKjAfBwcypf8pRHAMbz3O6iT+N1RjQoqQU1ADC/M98KYzrTGHLI9013JXBTTbWqSgnNxMJbFhXpFlnis0REPOd8G4iSaHh/sXs3T/8GXLgYiM2vh1scdqL54fggdHwpIbw0myNm42/r/WUUDkle6VB/kb2xRKtW5N1p7oDPDFmcqdu0jnjnCIj5dbyeAlgzg26KlIl/Z6WVu5WwxZgHLLcQoXuI57X3Usnp/r9uH95t2GE+H4e1DQXO/VdD50bdpt/jObQCNgIu0iHTS0Iy2FUZra9LWXYtWZcYXrNm1WHy5C1YMEeYB6iG+dYYoXZYD1P3J5ZP9FFzy9KiG+lIONQ7XPrtPe+U4a4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(346002)(136003)(376002)(366004)(451199021)(478600001)(45080400002)(1076003)(26005)(316002)(6506007)(186003)(54906003)(2906002)(5660300002)(4326008)(66946007)(8676002)(6916009)(66476007)(6486002)(41300700001)(8936002)(66556008)(86362001)(36756003)(6512007)(2616005)(38100700002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sJT+dr14qzP1RBKP/7ECg+xqQRqnfYg/ZyhFVNxOq3qYkYw09oS1gQ5idzQg?=
 =?us-ascii?Q?oQNorILgMqgQv/6JD09bWEM7GZZH+mKB60HdAll7V7FQ8vwdNTefXastMhUf?=
 =?us-ascii?Q?d2329ypX8tL9ryaz8+nw8kgj+Sq+lb8lcus3vMqvThIbPMOctxXIYyOWnDlK?=
 =?us-ascii?Q?g56TkChYkbhXxfDZkPKx1re5wX01BmEeI9Yaszxi6Bsb3rvdLWFZeS56CeEi?=
 =?us-ascii?Q?lSMh7SxISAd8ulYOjXzT1mpFd7I08UZBgwq9SsLVmPsdOYCUGbXDijHIylmL?=
 =?us-ascii?Q?SPxRmq9ZoL/pIUJvYdVAJDRyLL+vYFv7d34lYnj/BH07z7klXov0zWxhJBFq?=
 =?us-ascii?Q?Hb+lmrwHnenVt8SOsrwMis7iYznLIVinf4xs9FKkSCavbX5d4932O+DlYQMk?=
 =?us-ascii?Q?0NSZ8GcVaTvlR8xg3hJThmrV+a3SecNmrtVgeRjbOn7S2gwtFomV1NUNjbyo?=
 =?us-ascii?Q?wwFh0xUU5INEjpfbdslOKYvY+9H52PEcsQXPpedv0jmn/Y1XPf/jamlzO2Ni?=
 =?us-ascii?Q?/cRSHvmanNBePTU49sTECWD61sBAbVqr5dDxEqo1IrdmiTOSX/H06Lu0c2BN?=
 =?us-ascii?Q?Z2h87bchZUgU9bThMZTFP2ORd6nQ/TTDc4XnPt8zID7lwkXtn/fhqL6vTZKD?=
 =?us-ascii?Q?bwXxqh5BWc+AFd95uU9Wyla3fNJXmrIeGX1k2rWkM8KvO4t638SYE0oOEwGr?=
 =?us-ascii?Q?szY1A/1zLeEcD//BqQebLe/lN4oK/uy+hrKrA5+4XLaZZLE6cDVootnEU91F?=
 =?us-ascii?Q?2UM3FBowwHGLQNYsLyZEF/2l2SSixxl+knWj91oEMehQTdaj/3f4Q8F0T+cJ?=
 =?us-ascii?Q?MBXfWGmnta5vvEYQvr0LOE3iCahwkg3nV0cVTw8Qx+yl8UqhLJ9z5+Ezq4/F?=
 =?us-ascii?Q?VO7T6H/Fmux5u45hxsbYgQzZpzoSJe/Rh0Ky7ALR3/3zRtHdxDywf5wXxKxx?=
 =?us-ascii?Q?I/BGPE/lWgZ3YxrOZY2fv6OZoW33lAbTLgbOXLj/HxR9ax7vaLd/ZQ9Trvhn?=
 =?us-ascii?Q?UNni/0YsiOeP0N2IQle9pmuMPDqgQJs9/TtMy88v97Q1Dk+pJQkCX5bj8OSf?=
 =?us-ascii?Q?Z+Cf/DhgaM5So7GTm21iBU9wtQEl6DGCpnTYc01FoHtb6Nb5+BXKOmGaIGC8?=
 =?us-ascii?Q?vdY9I8CTWYTIyYXdWOoclpDbxcbsiLQ3J//ivli46h2yGGh1vveX0Wfx1mG+?=
 =?us-ascii?Q?02iFVq09L8k9zPBE0NtUUOA0o7867yVzp/mN8dF1LlZi/Zk2P9ksOLimi+Kk?=
 =?us-ascii?Q?Ecqk70gWMyln+bxuZE3cu4zGVL1+iR+c8W+YYdsR7R2MxI7j/ZpuLgmkOCzj?=
 =?us-ascii?Q?6OxqXQPcf97Qe45WvbdnDYIGRliSB37E6hxtq9nbSxmYuQlKnQKbrwu4moIK?=
 =?us-ascii?Q?PwZluZGUP5UKFjqlgNvC3Ok3H8uALyegBgLocEB/tXy4gdjvpSicrhgEjppq?=
 =?us-ascii?Q?yl7PeRX9HqGy5rI3/AYdS0lfK6eERZovDoc6PREhfIF+gaqSDi5pmXbRJTeZ?=
 =?us-ascii?Q?yBuy4fmStOjmJmQzneUf0+DXQdx1uEp2ktLcLzmdZWzq9M237P6yKwjiOS/s?=
 =?us-ascii?Q?VEAs66L0mgP7DUXUKjj1ABg5abiXZEeOwQxZH+83?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 383cd59f-871f-431b-d279-08db3acda3be
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 20:45:09.4279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPRtckFpHEFL2t6HFBsstxI+ktVjisQOVxU4kPUjGzsu6QORx3SgO5rJLlzXek25oJ8H0KXNvLEft1g082yA7Q==
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

On Tue, 11 Apr 2023 02:45:38 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This is an owned reference to an object that is always ref-counted. This
> is meant to be used in wrappers for C types that have their own ref
> counting functions, for example, tasks, files, inodes, dentries, etc.
> 
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> v1 -> v2: No changes
> v2 -> v3: No changes
> v3 -> v4: No changes
> 
>  rust/kernel/types.rs | 107 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index a4b1e3778da7..29db59d6119a 100644
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
> @@ -268,6 +270,111 @@ impl<T> Opaque<T> {
>      }
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

