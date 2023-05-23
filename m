Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0239670E0CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbjEWPnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjEWPnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:43:40 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2103.outbound.protection.outlook.com [40.107.11.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF5BDD;
        Tue, 23 May 2023 08:43:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2zEPaqL0Uzxi48f0OFUA6R+4WQ9Nfj7gMDSsUOL4BwNkb32rPKYIPep0cmCultve4CJ+1O5iSCdVmEuw+FjNa7trg3aEd00oGmU8Q8fCaItLP0L8/6Yz3Pr4yS/l2TN+tFUiZ38mZpYaehYktCMTUnCxKOsgisbK3roekxAXv7lRqh7WxZJZ+sDDiYP2vxEahnM2+1URVKzLj/G/6FKSwt5fW0jpgNgQKDzAEfB4JCGZ++zFcdC8xQLvtWM6kEQkB9ZwjFXpDgWWaJ7Z2IUbmGKiQ8hrYXRDYmDgZP3qjvpsGZW1Hx8sS4h017GhcXMTE+Lvyh/h5Jkym3JAvlSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6w1+/rEN03LcNB5+IUVVRVTLljqSOf/epGJaOWy59o=;
 b=jkwAOKLebhKMupcDV5Pej8+DwBZNZ3lyncv1Gro5XD9Y6Dc5wkiWbiFLVmBMYe4ytoArjMm/8dp79ct+qTElbON6cyyL0DoCLFP0qvV7WuifW1Jdyg2y8r092D8wknbTeOGsiQhBr3LrHg1WJ1z1xeCE2Agv6pIkknTry1PC9kjvJlQevYkU9eywa6QE3h87tIptTioRc1Wfjy5dyyaKsJlZuTXAW9fxja7n/fQQwkLL9G443UeVwj/p2G7RGAyrAAEOc2PiEAqAVwk50R9zrJEEU0q3cLv4ThOBxBnRMisZD1Tj/fbaMylVU6KvBsjBoX+3MR1qUYGrHre0/x+1jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6w1+/rEN03LcNB5+IUVVRVTLljqSOf/epGJaOWy59o=;
 b=A6Lh7N3YkHhmGRdy5jR0+Ij2KqD5TXga8kJnTyjA+MPphUtejNcXM3OiEtsqdaxu5c168mLsEFMlFSbCJAoWTb2RAE3OnzypPoSe5nx3hn9n7n8Ab6pgYO2EBvjJKByT6/mZuYekNxQfaxVpm6rK058Xuf1JK4c5JtpiHv8v3gs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:183::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Tue, 23 May
 2023 15:43:35 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf%4]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 15:43:35 +0000
Date:   Tue, 23 May 2023 16:43:33 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "=?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 3/7] rust: sync: add `Arc::{from_raw, into_raw}`
Message-ID: <20230523164333.2c4b0d85.gary@garyguo.net>
In-Reply-To: <20230517203119.3160435-4-aliceryhl@google.com>
References: <20230517203119.3160435-1-aliceryhl@google.com>
        <20230517203119.3160435-4-aliceryhl@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0443.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::16) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: dfbb8e11-9588-415a-59a7-08db5ba4787e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cw9+KJbHBSlW8rOF5zDXzq0TYSCzammuR6vdlNSgK0Mt2UBE7c+hweAUwFJT5VXr7jUKESxpQ/V7oBMQQbavRFOzM54sOHbkPLebU811m/0V8JBUETNVQ7Q97b6bSP6S3DB87y7pAGbDNgyQjR44eZpFZCyGJBv5/H/u4hLVH6a9RUuUo4Reh2v/TPYs95LJ3hxXMMOAdHluJ/V4XwhLCv19uILIl38/mJBYnjvOpc8hUvfO34gtm9YJH/sqyR6qJ7JbWjwEMp2jRLkxuKL39JJuxfH/zoryvgNWqS6RRWMo2mA5Nagb29d5Fm1ATV96m7HZRErx8hCdNukgzr7x35B26pJAawIyzRzaTWTnpWtg4yLmklA5XyuM+txtXH05RfYCzMaowu6a5hDNfoB1Xq03UKJyeA1KeMSopfc/x0rYN0IzRuSdpdO3Z5M73R1N8mqygo7nO23D18OaIj/fGjTggLL7lOcYFKqPbZN5HWtLtzTS1/dA4YZbDc8uZvluf3a67xK6upc8j7kwlEEJm8n7D2FJhYHaNbUMFEWNAdX7pBzx1t/cJhqIINcJlcL5dczMx4NpmKUg7KXx9yWWsU+CLVn13f3sDGH+p9TuCWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(136003)(39830400003)(366004)(451199021)(5660300002)(8936002)(8676002)(966005)(86362001)(1076003)(26005)(6506007)(6512007)(2906002)(2616005)(36756003)(186003)(7416002)(6916009)(66556008)(66476007)(4326008)(45080400002)(66946007)(316002)(54906003)(478600001)(38100700002)(6486002)(41300700001)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?03uJnsbIihydYbRLyR5qNuZmxcOdb6hCg9662nQr+UswVJoz5cUIRsyjbPt0?=
 =?us-ascii?Q?YoTKY+Vi+VmYT0alFUzmc7ru9iqH4QFdEmtDarPiTcBk0ArD6zCzU5sqw/sN?=
 =?us-ascii?Q?KkXeylS1K3HQwrPoxpk9PSaseeoOuAyr0j7ak4K7LjSw8LWhnMg5wqC/MiEu?=
 =?us-ascii?Q?fRZEvxN0YyGKpifbeeMBwsK7hn53IuoPrYkff7pmEhrusUF0bNij/srGh1qt?=
 =?us-ascii?Q?rC18Fq35ZfaC04XTEgkfWQeB6J/hnlCE0U8w03O5ntpe1gdqfa5B9so3u/Kh?=
 =?us-ascii?Q?YqoP6vlGxhoN2z+fPepiX1oMdKp2MEp/8e6ry/eipaSbXAwtL8p/iBHQbVXc?=
 =?us-ascii?Q?DpVaDvG8JdVHVWSSxmSJdfnKcpDy/4YmVoYRbaKWq1fTg5OY7IV637RcxmeB?=
 =?us-ascii?Q?AK52rU9AVHirvB1HQ9Klq52Cu+sN33zrDEJhyKp18xMSA/W2IM6yQSz4D/m0?=
 =?us-ascii?Q?uXzzMNyDKS/rdHolsN7MlEtGu0+578jmOS8yL2lIb2QOYgEYCFEamM+tXicq?=
 =?us-ascii?Q?lZjxtEcHWKwmJ1AQ3Zo/+4sKu4QvCgyPuQHdyWZEKG349pOfysmWc7fQIGCD?=
 =?us-ascii?Q?/2tx6O1sNOjk6Igv5r/OVIwVK9LCERi8y7UHI4ArTXAp683Y9gDt+ol7WfKG?=
 =?us-ascii?Q?drh1u8uchbeDD5PoqmgEZx2domIMnhQlJsQZk/JpJ0ORrDgB8HV2HU0ZUJsz?=
 =?us-ascii?Q?InRI3FaOotIUfk/YvdaThPtnMJgrNw1aIJDHzxF6/f+ShElPB7Uo2Kkv33nt?=
 =?us-ascii?Q?6O5IVVx2Iu6D+h4Hx42u32uhEnGQvmgpa/zYQzBTtchspMTxESfqw2nzsgU6?=
 =?us-ascii?Q?b3LS7eD7tPkHqMt4mXPwAdsSipFCJCsxZkvIEeVKu7o4g0X4CXff1Hg1ecE2?=
 =?us-ascii?Q?FtCXthDXmj6kpSM5E0sOZyO+beEve6pZW59KADFWZklsIJy0h5O0st023Z3d?=
 =?us-ascii?Q?M4FyStOOUatZz28C3TM4n3CYvp/a2F+kR6MU4kHvSdPvTHpRfWlXEfuRtrRB?=
 =?us-ascii?Q?SfAbVO0lkpkh75O/f7FtkQWMRZh48b7TnSWgZ85+cE8uMjNbxNg2iJf2p3EI?=
 =?us-ascii?Q?U13wnlWxrNyphswHEYgUHUFwi1KAz7aIvEVd0I/wdG5lRT2BttkAwRpSojAg?=
 =?us-ascii?Q?gzacthA91cmjhk0Qszdgz228jUW3WG8kiUPFq2zhkrJwjzatIzLAdqyD/a9c?=
 =?us-ascii?Q?Zjk7TBEZ4CcN5Qr+YkAA0Q/EbvxHII8TZhh2h8ZsoMeMzcF1Idqn26kstRk8?=
 =?us-ascii?Q?JeAdecUubDWrlegUbRnL3hvTWwx8wZLqMujUkEmMRw8sSTxDserAnfVMW4Vk?=
 =?us-ascii?Q?FMbceSeISikxHgfTUIpHPIVLC393YYKpzIzmIxp1dnc8CS5ZpYzLREHGKJOf?=
 =?us-ascii?Q?IxUqLHw9xUtUidc/UayT3wPF6vqyTa9pl68NP/pOEKRD/aklMrRRwJ85MYC2?=
 =?us-ascii?Q?8Xqyb7yvvfqHvqci3qP1VRYIXhB6wg/eOzhl1MQ22LokHMbFFwlcY1LxliGw?=
 =?us-ascii?Q?IgN7a6oi3Xd12Fm60LquIRFEe6+6syzw+r9n09XbPBZx3Hchoy3CEHIMJRms?=
 =?us-ascii?Q?o2HKPlvLa6OYMbpiD5vh17MOxKFD2wU8vvd0vwIX?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbb8e11-9588-415a-59a7-08db5ba4787e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 15:43:35.8874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ExKZgiEcP4jSSW/oKgbOCUgwov1rZzBu1N2n9p589O3RQHHw2LXgOyhhAnx/U4zZV5psDQahF6XbYJKFtSHnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 20:31:15 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> These methods can be used to turn an `Arc` into a raw pointer and back,
> in a way that preserves the metadata for fat pointers.
> 
> This is done using the unstable ptr_metadata feature [1]. However, it
> could also be done using the unstable pointer_byte_offsets feature [2],
> which is likely to have a shorter path to stabilization than
> ptr_metadata.
> 
> Link: https://github.com/rust-lang/rust/issues/81513 [1]
> Link: https://github.com/rust-lang/rust/issues/96283 [2]
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/lib.rs      |  1 +
>  rust/kernel/sync/arc.rs | 44 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index cdf9fe999328..82854c86e65d 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -22,6 +22,7 @@
>  #![feature(generic_associated_types)]
>  #![feature(new_uninit)]
>  #![feature(pin_macro)]
> +#![feature(ptr_metadata)]
>  #![feature(receiver_trait)]
>  #![feature(unsize)]
>  
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index e6d206242465..7c55a9178dfb 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -210,6 +210,50 @@ impl<T: ?Sized> Arc<T> {
>          }
>      }
>  
> +    /// Convert the [`Arc`] into a raw pointer.
> +    ///
> +    /// The raw pointer has ownership of the refcount that this Arc object owned.
> +    pub fn into_raw(self) -> *const T {
> +        let ptr = self.ptr.as_ptr();
> +        core::mem::forget(self);
> +        // SAFETY: The pointer is valid.
> +        unsafe { core::ptr::addr_of!((*ptr).data) }
> +    }
> +
> +    /// Recreates an [`Arc`] instance previously deconstructed via [`Arc::into_raw`].
> +    ///
> +    /// This code relies on the `repr(C)` layout of structs as described in
> +    /// <https://doc.rust-lang.org/reference/type-layout.html#reprc-structs>.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must have been returned by a previous call to [`Arc::into_raw`]. Additionally, it
> +    /// can only be called once for each previous call to [`Arc::into_raw`].
> +    pub unsafe fn from_raw(ptr: *const T) -> Self {
> +        // SAFETY: The safety requirement ensures that the pointer is valid.
> +        let val_align = core::mem::align_of_val(unsafe { &*ptr });
> +        let refcount_size = core::mem::size_of::<Opaque<bindings::refcount_t>>();
> +
> +        // Use the `repr(C)` algorithm to compute the offset of `data` in `ArcInner`.
> +        //
> +        // Pseudo-code for the `#[repr(C)]` algorithm can be found here:
> +        // <https://doc.rust-lang.org/reference/type-layout.html#reprc-structs>
> +        let mut val_offset = refcount_size;
> +        let val_misalign = val_offset % val_align;
> +        if val_misalign > 0 {
> +            val_offset += val_align - val_misalign;
> +        }

Given the layout of the whole ArcInner can be calculated as

	Layout::new::<bindings::refcount_t>().extend(Layout::for_value(&*ptr)).unwrap_unchecked().0.pad_to_align()

The offset of `data` could be more intuitively calculated by

	Layout::new::<bindings::refcount_t>().extend(Layout::for_value(&*ptr)).unwrap_unchecked().1

or

	Layout::new::<bindings::refcount_t>().align_to(val_align).unwrap_unchecked().pad_to_align().size()

Best,
Gary
