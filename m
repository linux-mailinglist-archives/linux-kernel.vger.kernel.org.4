Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4146D0299
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjC3LJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjC3LJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:09:16 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2096.outbound.protection.outlook.com [40.107.10.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8104EB8;
        Thu, 30 Mar 2023 04:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4BSDRA7xfVPx2oW4aMbr4/JVx+rAdAqANkZ4YUuwTEgE/S8uoJgxFy/+qyMknZ6AnUSUDqD56K3M7RYzIFKtz8TDfdrVbXn/dQgrBmzj0TQFNudOigt210QyXjwt0jlaHbIgpsQpOWcXwRjes3QtBH/isc8jlLpPoEh1CGUdZ4b4THwh1mn3v7vHay2i3p0Em6hPcq1YV+TUIdwr9FhTX0xg4j/594YulwsrGoloY3hmqmUauW4A/kp+APUaZ/CU1iw4ZQ60RfHbRelCjvniBg1Z2b+WxpIz0C6WGmkk7t8ynqc85Ri9Ad8mns+ByeCzSN6K/5agNlOeE+vOopD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZQce+rvtO5kWwATcmSCorAR48xPPc9rrmeXmR+rxGA=;
 b=njTow4ousVJPYp1Tgb4M1/3u4slriqDszgVQgvUyWU81CKrd7x6Np29Ze/145zXOP2yp/P9cycGIZ+DK7ilECl32JTDWmzUgh6Ls8HVa0PP8SDI87KDDnnfVyW70/czniZfDdV17fA+5LM3O0d6LmDvqnTtYOYnXPVJTXX20eTrMYv0Yq9PsqqgAXXwDSfWKT6R4QRiM/c6fb4zF3aB3Irbeha8d5TpurIVgtY2MkB3q0ZvQh3LXOxrg4Ga7wDbh7TOJUNODzs+lpaOSTpD7IJ52yFuuFIMuq9DBr4mZbp67rkHlq98EVqc4lzZ3D0YZBYR26wY5OTJu8GCpacE1tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZQce+rvtO5kWwATcmSCorAR48xPPc9rrmeXmR+rxGA=;
 b=DwXS/99+ZXBK4dqFFb2+ldGgryu39ll2e2yGFXSm9PPtCQp9cWlogi58n+dQEykdG1XCTNznaQSX6tajOz17iOp0fx4QIOzMGmug46kKnDTjm/g42pZIlXJkTJMwC/H1fnlQnTCPdtEGsqbGZ5JUTbA8OuxTRq3cubx34kP4lPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6332.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 11:09:12 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 11:09:12 +0000
Date:   Thu, 30 Mar 2023 12:09:11 +0100
From:   Gary Guo <gary@garyguo.net>
To:     y86-dev@protonmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 13/13] rust: sync: add functions for initializing
 `UniqueArc<MaybeUninit<T>>`
Message-ID: <20230330120911.12c50468.gary@garyguo.net>
In-Reply-To: <20230329223239.138757-14-y86-dev@protonmail.com>
References: <20230329223239.138757-14-y86-dev@protonmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0452.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::7) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b28171e-8be7-4c0b-593e-08db310f3138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wTXaedrS4vXGU2u07iPd+2l7CmIGcuh45h0XcQk/fPJp41E1Jtxk8NI9iZZvNdIRqGGN9dxerOBCynLq/Cq1vkaqENI/qTzyenBiQNUy60Edn16X3C6MD/5ZKnw+8Kaq/leo5fMAL9O96szqTbAfEvfjwG050aLh0QwEJC5dhQiyDMnCLsJpaAeGbGyQJfI1jKBT6lMM6/JsXOm3+ql4lFIypH2kD/004T4WDf0SqF4e09Jx0stzKHNVW7ZC8ZWFRfN1AfG1PInhxVVHdzymc3y8+EwBxQlK/iw30d5V/3mSkndQ/XoE1OjWqFwtw0/WGS/RW5BGmtQ/ZY1pU/dBPjOU3qQduH3YiyxhmjM3FYy/gqiSYCBuG9MxuozfpX+KoWrActfLC86i7qr37pNG/8pbiL5LSyUbL0TJqvFWoapWg0P/fdOFd8DqcfwdtzmNyKKrT9yQ+X/XX2Zu7DKfIkHQMaLqlCoBVxQI9+FQ5TLUBVE6wIUUiNWneejUck5A/AH0F/Jc7+bQz9XTYYrloHC+3GWhNyXvxIqDejDtxuKK7eiGU6EbFEiY33jUJOIe3FHKBk7JyRqBrZYdXBPdYRh90S0kD5mfPUPrdPH8FWQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39840400004)(136003)(451199021)(1076003)(26005)(316002)(54906003)(7416002)(36756003)(66556008)(66946007)(66476007)(38100700002)(8676002)(41300700001)(86362001)(6916009)(6512007)(4326008)(478600001)(6506007)(6486002)(2616005)(8936002)(5660300002)(2906002)(186003)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m7eKTlX94HJBhSi93euyJNuz+2gcH/EEUzDVy/lXz0HntblSmQ/xf7SoTO0o?=
 =?us-ascii?Q?WaUxnNZnmNZshdVGlUxKTawYCLrD8U0ZRCmtzpV5ZcywDaTmrCYvh1ClwY+M?=
 =?us-ascii?Q?1CY/rGpYOKxrwednYYiiVlyC/Ixxi8t4Rlh4tLF+o4/10vNH/Yy7nngGoOUo?=
 =?us-ascii?Q?K2lB790ZDrruBgOAw0swnraaO5cJP+OVc4IFezC3BztKGymjCXhGzm9DxWaT?=
 =?us-ascii?Q?fwyQ+bnqf81uYgJAxv1hY8XbaZtrgxhfmT+LH93Fb7qNvq5vYcXTCtxAVThM?=
 =?us-ascii?Q?F6hcFAG3so2Ma1qM6FgJABHWjPxWUcJ7J6NHvxwqKBTIbtVsZmLE8dHIU/Ls?=
 =?us-ascii?Q?ANR5CoJBW5kFQ//kC2BcA9gJ8zUmRgvzJxaffXOA+VvRC+IynJVlGEY2lGcd?=
 =?us-ascii?Q?uxHdfNPNCbmVvLzk1odJT6CpkNW7q9twoE7XPtbb9qGYeYenO3+P6mhPcHtT?=
 =?us-ascii?Q?jMliQaXHjv953eRaeHb0Yc5gFLmmsKZp/XelTZdCA5aGqhpA3QVA19tTVUr2?=
 =?us-ascii?Q?XD8e7zXUlr9xYwZ598KtLod5Bn6OQqKKQQlzDScN7ezDqnevs/6ntdNCF6nR?=
 =?us-ascii?Q?+JD3gVunwgjsJ8rJwi5ej26JtB4vq9fmAW6mipydGWaKj2rmY8+6zTlZBucw?=
 =?us-ascii?Q?gJbNW9KMpkrc45M0+XmP11mlGe8hubAXldf0YblOj2ZULMCEa9VNUty/5zT0?=
 =?us-ascii?Q?Xyma77bgJnC3WzP1LMcjpF7cUDuCJDBJaIxtp0A96b4siDR4m3q9zB+lAv4j?=
 =?us-ascii?Q?WSBwx6K/EH7rVINvWfpMDUoo+7wYt08RRDs6Bk/iiIqUEwps2Yc163aAZHMf?=
 =?us-ascii?Q?iDswr5lptG26YCsVuyPPp5xYRWYzna4Vjcbgq1X/wT75J/GGvO4DwHLYoolm?=
 =?us-ascii?Q?C6ve9qe9H/Ef6/nnzP9JmcY15e3lXDf17cPWPECcK+wfbBtFFbBsGZD/wxgo?=
 =?us-ascii?Q?P0GHZPReJrYDjY1vf3YmMmtMRMY/VFaa6LyqYm3CER6xO4Uy98tKRZtZrzxV?=
 =?us-ascii?Q?10qbXnj2L1B0FCIyUu9TVePVlMPqIMfK2BcFLTLMKP3WuNUD5LtQrrwKf7eb?=
 =?us-ascii?Q?gz96NI7mqd8I7tAuqHf6T1tWquNnASV0yWc3KClexFUsTvX3efkkiTT5R7rG?=
 =?us-ascii?Q?IBxqmq0Kw3QqTIcCOha6VQcdIhea6D2ouG0hVDjp+ThRe+cB4VP0hK9gK4YR?=
 =?us-ascii?Q?dsreMEfi2YRM3jMrmCS++Pi5LxufmvazHqP06pdDuhYG2GZmthkgqMOh2+IJ?=
 =?us-ascii?Q?+vGUFrS/JBpeUv/qQg6sWkRw50GBNCzQqq5nbcnoA6pGv2KyFJRW8p8Y8A58?=
 =?us-ascii?Q?TGygpvI81XqjmS7j1Sdg/nrbnz1w1pwjItXtuTJc6YQMBWWb0tRZaVmUHLBF?=
 =?us-ascii?Q?+TXHQkk7eSgBvduTDRUwME4VajCc1h4cZrTmmN/hyaiTtgxEn4EHOJysAKMw?=
 =?us-ascii?Q?8QhBazBaheAJOJkaG3ya2o0IvKkn5TxvDx10z/iSgjXOeHc3pLuxC5ebxu1n?=
 =?us-ascii?Q?MmU+w1bF5+6M3bWOPKZoQSQMiUvHxgxw+OXu4KYEhxEX0C3jBlC5onyU+uuA?=
 =?us-ascii?Q?S2t8q1w0et8CR1IYg1HSNsny6sXE4eHioyeGn1P/?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b28171e-8be7-4c0b-593e-08db310f3138
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 11:09:12.4453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTApT2c7hFA3aaMxLmLh5+xBKD7hQuP9GGrrAZm/w9tfqSeNCuFeNWt5e1/wV1L63c30Q2cMbG6CsCSBVTEztA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6332
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 22:33:53 +0000
y86-dev@protonmail.com wrote:

> From: Benno Lossin <y86-dev@protonmail.com>
> 
> Add two functions `init_with` and `pin_init_with` to
> `UniqueArc<MaybeUninit<T>>` to initialize the memory of already allocated
> `UniqueArc`s. This is useful when you want to allocate memory check some
> condition inside of a context where allocation is forbidden and then
> conditionally initialize an object.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/arc.rs | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 4ed6329a5e5f..64b0e9d67025 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -540,6 +540,30 @@ impl<T> UniqueArc<MaybeUninit<T>> {
>              inner: unsafe { Arc::from_inner(inner.cast()) },
>          }
>      }
> +
> +    /// Initialize `self` using the given initializer.
> +    pub fn init_with<E>(mut self, init: impl Init<T, E>) -> core::result::Result<UniqueArc<T>, E> {
> +        // SAFETY: The supplied pointer is valid for initialization.
> +        match unsafe { init.__init(self.as_mut_ptr()) } {
> +            // SAFETY: Initialization completed successfully.
> +            Ok(()) => Ok(unsafe { self.assume_init() }),
> +            Err(err) => Err(err),
> +        }
> +    }
> +
> +    /// Pin-initialize `self` using the given pin-initializer.
> +    pub fn pin_init_with<E>(
> +        mut self,
> +        init: impl PinInit<T, E>,
> +    ) -> core::result::Result<Pin<UniqueArc<T>>, E> {
> +        // SAFETY: The supplied pointer is valid for initialization and we will later pin the value
> +        // to ensure it does not move.
> +        match unsafe { init.__pinned_init(self.as_mut_ptr()) } {
> +            // SAFETY: Initialization completed successfully.
> +            Ok(()) => Ok(unsafe { self.assume_init() }.into()),
> +            Err(err) => Err(err),
> +        }
> +    }
>  }
> 
>  impl<T: ?Sized> From<UniqueArc<T>> for Pin<UniqueArc<T>> {
> --
> 2.39.2
> 
> 

