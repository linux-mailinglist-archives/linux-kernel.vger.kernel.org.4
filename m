Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E33E6D13FC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCaAXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCaAXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:23:46 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2099.outbound.protection.outlook.com [40.107.11.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F43830F0;
        Thu, 30 Mar 2023 17:23:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hF7qdhPA99Kaw7EXrwfFFZNL1Em8ntlzkwG+XAl+1Q1HCzYSB1ngNPhc62y0UWAhGaH6zdy5osLaLPuMXJ1qeAzVppl4q89OAaf4nSaJAJ0+GLFQaAond0UYvunVejwkVHWf7Nzt9pzPC2QQ8wQK5Wr088Z1AQ/VlvuDlVqaokT3Ka4/bKNxbGF8na24j9tPXBZp76pi6BVn/zoH4K8mIjQkRohe0Y7aOwiHiaB62c7wtsbg+zgGSgqcdMLO1vv33e6mRNaDfi1wIVMmeR11KGK+L0KYwKMQybXkZMJVG2k6dQfZVDzUE2diJnc7lrUzRX4YIkW2tJ/VqyA0iCDZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1b7qRBup3CJcHR6OEG/XJENBYsk0Y8IorVUD1/1ssdY=;
 b=KIOWffBG1CR8W8t1xU6SaDdZLEcYQA/zRiZoQu/6uS/M7zbkTH3e90EFnrRIO1erEUMTxfHimT7jYK38s958RKTDGsmlsTaCiv2+GTiJ+PKfJTULN95vsIMe7fcCjxDw7vnBJ10NKXhPJDKt5efkgd+5Vy/OudxnbxLdV5C6wqaWauebfUIwXZoYWeiFBNEtuahpJETDKKKx/Ow5soyB2fGel1kE/VhWjX/1WAUIF098sW0VV9ME+gKKSh+yXLTvtDHNdC5z0FpWINnkE6x0Fdt+FvetIHaPjyFmBFdxPB9xSVosvBxoNw1U6xaEODxzyQcvpYcqUMeYZexrPrfkfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1b7qRBup3CJcHR6OEG/XJENBYsk0Y8IorVUD1/1ssdY=;
 b=FLLS1jidbR6+cZZRdTQKPHDCpII6Vv6vCY7rYnKD0QkD/D3H1lt4Osmfm9OKAmcW4/TD5m/O+RwcHHJSxeCzu+46xuHbXRdy24D1235oyy6leAMVjt8AfSDjo6PnBTBg0IiKoXtpdO9Lg1p470/OJ2Y1W1yZCccuX0qHK8cxQxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15f::14)
 by LO0P265MB5525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:274::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 00:20:29 +0000
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::714d:960c:b616:d73f]) by CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::714d:960c:b616:d73f%9]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 00:20:29 +0000
Date:   Fri, 31 Mar 2023 01:20:06 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <alice@ryhl.io>
Cc:     y86-dev@protonmail.com, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v3 09/13] rust: init: add `Zeroable` trait and
 `init::zeroed` function
Message-ID: <20230331012006.251b5729.gary@garyguo.net>
In-Reply-To: <19db6213-297b-a33d-7331-3c1a5b72fad9@ryhl.io>
References: <20230329223239.138757-10-y86-dev@protonmail.com>
        <19db6213-297b-a33d-7331-3c1a5b72fad9@ryhl.io>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0101.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::16) To CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:15f::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB5186:EE_|LO0P265MB5525:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bec74f5-5e68-48e4-8f0e-08db317dbbcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGTg/pENA5Aa0JAl6uUVAEphGeyiZnEMTtgO/R255x7og258CnHER+DkGjwANmHPhXzd819y0OXZpKmGXGv6VBoAhuGgWcbxThRvvTygQ4aAiDH51AsaUTCgq3hI0TnrAh8Tvosmi18r8vXa1NripN8bsgViPsH7XYnWA3EMQUojvs604vmam/ZJK7kiabw8PohaYCuCDjqlNRteNmoOAEaAbl5pKsrJN006OGLfcx6u4pEK/5pfKbaZlDKdd+GPHTdw3lETPkM9H/pPGpTWyuOdiRNx9BOWa+rezjpH3/JIlikoFCEBoJaXq70c4JBxKl+zNlihbh/TeK9iIKxp/CeJf63KE61hRHK21XdW3rZKa69ypzZsgJkvpIZNzO2D5JkZse2wsjmg5x/GHzSLAHVDTLvKNCsbvzcS/GnU6S28Gyg5wNZbtLKreCXKDa9xN1SUGry+A6CyfvC5Po1euJFZF5iyYhCcNFOT8YCRI/98CZwLbTxhjTx2UN8xBgS2ygPgZXl8fTsUGcS77EKSrjW0HSSTrufHCbAUkyD9/pYTDllE0aue0JbTcBPSla//VHVT7rUarEZCE5RhUYf6MDLMhSDUH0mjcy/tb3DimYY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(136003)(376002)(366004)(396003)(346002)(451199021)(36756003)(6916009)(54906003)(8676002)(4326008)(66556008)(66946007)(66476007)(6486002)(966005)(316002)(5660300002)(8936002)(478600001)(41300700001)(7416002)(2906002)(86362001)(38100700002)(2616005)(6666004)(6512007)(6506007)(1076003)(53546011)(26005)(186003)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g3zOGwd39VI0uE1hDVMDVIdYMlH+Tgt7oJN2vAvjXL4oMunnsSxqNvm0uh3J?=
 =?us-ascii?Q?MHS/8MjLlbmndgyQ7R7myr0Dm5q/JlRh1MMo+QeuBJ8pD4txqdrTBfkza5RM?=
 =?us-ascii?Q?ZLjU96f1VlKK330TRvBhb+2rvoz7F3zUgyFv8q+Rtm59UbRdk4nwmrZIK8sR?=
 =?us-ascii?Q?FFhctHQ8x4bj0FXI+0vgFE7wbacJ6uTO9zHOLlGNU0GiVngY2QNM3gaKC57R?=
 =?us-ascii?Q?Q+EjXhEXLENl7ncoIMbqslCMrCQCWVllhApF5l2xW3i2xp/9+fKixSkoBRt/?=
 =?us-ascii?Q?UzXyZLWUF3X3/Nr5vaGVy4c63xMq1+1ylz3+aSscxaxT27xF33+qxTEL/F9u?=
 =?us-ascii?Q?EOq4ZiRlPLWLVWwrlzkO2bxuODAXr5QMjUnYrBg5iY/XWWmwhpXF9u8qOcpU?=
 =?us-ascii?Q?pHZ8vgwyMikybEBbSKHTK/XsmmEGZux53NJ3dg5lydHl/mymUHYWY/6NT7jn?=
 =?us-ascii?Q?ZndiOFJRpH+2BESsur1uXp2MovxmoRxsouq8Au3VjdA8zJ3k+LCTDilpKEOA?=
 =?us-ascii?Q?7WTHQWrrMDhjBQCKsrI+MvMxK2X9eZHPx2ICLeFVTWbwVMglUVqTKI7pbcWk?=
 =?us-ascii?Q?7c8e44+OZZSthstfHZABPD8P0DFsmgTxkenhzQRztFV5cFOGfOzH4+Xrpv2V?=
 =?us-ascii?Q?qOxkISyRatRDJsQHNEZphN8ZPOoqy/CsKplARLAsoRnUC8JAvFZAjYHgpBq8?=
 =?us-ascii?Q?kLhMmE0apErwjPnK8X+B7QbSna4gwF1ZlzkD+58yRESigyKLYarWhtnL0JIN?=
 =?us-ascii?Q?x/LE0oWd6RuSXBUsXU0wdrTCLO5wxPznGqK+7XjJzpetJ2RkBR7Ektq2bMM7?=
 =?us-ascii?Q?Sl1Z74z+glbgMlva4NpHCZL6wTU84qs1HG2LoY100Fm4gJvjpGjtwYQhJ2P/?=
 =?us-ascii?Q?2iTxEWkUkVBntanWGZj8pqYr9Lz1Rg6iumfaENstlOKm/+M4xJGZWe9XnCYy?=
 =?us-ascii?Q?hG4eKj9GZ7mK6zLuk+GfiE1c7BbnxmyL39XwOVJ4C+nRRr5L1sy6B8ORjw2x?=
 =?us-ascii?Q?G5qwOjjYTtlCb37Sa8zcDD2agrlilbT94DSyswtru3bV45WjaWUO7p1csik2?=
 =?us-ascii?Q?lEh6OGxpr3eXawPt1dzMudbyZR9QpHNOzjBE09CF/NtDjCsGpmqM+xo5vRcc?=
 =?us-ascii?Q?7DaFNDfVcictPBT1Mae1K1JQA4kyd4H25EVEPz05CmCMs1+/LFNMxQgxlzrn?=
 =?us-ascii?Q?quoLP8h+XSXR/MQMYKAaWcFSOlyE+E3tOhNyF099+MPLnU5CAsEhhcE/kDJO?=
 =?us-ascii?Q?s/T4fmjVbLQRNFn4uuHHIHiRizX/mG1auPaXcm2c0PyGNuXuvytzd8lmlDbz?=
 =?us-ascii?Q?mHyf24aE34av+r+CuGDdirdcel67AKG9Cf0f9TerEvDKUEmfTk2n7FmdCDAM?=
 =?us-ascii?Q?G5QyVJ62Te6FbGjAMgdYEvHkVQHlLMzOCCWqe0KB07Yi9G/z9jyJxmih41cF?=
 =?us-ascii?Q?iQEQaJAwm/HrWp/cUMrisyc6Vglz9AaSSelpWPZraJHAKFeKtjsD9PQFiqmV?=
 =?us-ascii?Q?1xu9Cupo117kkZcs+NMPyCdbuJUHHOegTZYrFnrWWBwckHzz0KFVw/pSf5pl?=
 =?us-ascii?Q?PCzJt6km7ZmOS9nQL7oLrbYvp+kroixufXH8FWrr?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bec74f5-5e68-48e4-8f0e-08db317dbbcd
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 00:20:29.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHsjOZ8LRFShUJlHo0FJ3dfjXpSa/bJs7n2eWtRqrJTXOxYScSPYEbsdItnIUDilGiDpRKZYqupLkD7KGkC4Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5525
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023 00:40:34 +0200
Alice Ryhl <alice@ryhl.io> wrote:

> On 3/30/23 00:33, y86-dev@protonmail.com wrote:
> > From: Benno Lossin <y86-dev@protonmail.com>
> > 
> > Add the `Zeroable` trait which marks types that can be initialized by
> > writing `0x00` to every byte of the type. Also add the `init::zeroed`
> > function that creates an initializer for a `Zeroable` type that writes
> > `0x00` to every byte.
> > 
> > Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> > ---
> > +// SAFETY: `null` pointer is valid.
> > +unsafe impl<T: ?Sized> Zeroable for *mut T {}
> > +unsafe impl<T: ?Sized> Zeroable for *const T {}  
> 
> Actually, I just realized that this is not ok for unsized types. When T 
> is unsized, the raw pointer is a fat pointer with a vtable, and the 
> vtable part is not necessarily zeroable.
> 
> However, it would be ok to do it for `*const [T]` since the fat part of 
> the pointer is just the length in this case, and a length of zero is fine.
> 
> See more here:
> https://github.com/Lokathor/bytemuck/blob/8391afa876ba2e99dffb0c991cc7fa775287d106/src/zeroable.rs#L56-L65

Good catch. vtable completely slipped my mind when I am reviewing this
code.

Vtable is not *not necessary zeroable*, but actually never zeroable.
Although currently not yet formally specified, the compiler has always
assumed vtable part of fat pointers to be non-null, well aligned and
dereferenceable.

Best,
Gary
