Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205E270E145
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbjEWQBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjEWQBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:01:22 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2100.outbound.protection.outlook.com [40.107.10.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E22CDD;
        Tue, 23 May 2023 09:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfheD1hhymHBdD0jYmKl4Zk5BdLsmzVdtL3bmVD0Jlsk4ewV9ONvZn8oKhs+ePP/B6152JH/BZunR2/mi0ZDsIrhLxqKOegz4N9bMmBuM2Cb+vGM+Ij1ia0ZQvVQQldnkVY5rFX5HlxTaGPdbgT4DcvTzk6ajUYUQE3Y0UMzicL4HV7qIpy2geKAuyHeizuq2j+Oylg1BE0nCbgWRBdePYJcF6AxxS1TLSS50XXHGW8asZY4Yrm8Qk1IX++fhwFW/e8F3LI5f4NIwG/EPwr/gEL6Dk54mQxCBSSJjSB7iF7WqRhmO4U9fwCJ9sc4Tfi3R7HBoxFsbKlxnvPDkbPkWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhEwRIyfXcjVhfjy5WLvhIwhCM6WUZLCnP0ZBTWBpcA=;
 b=OqeMGrm3ez3IH6RPQ4+qjZQdzsIwf7xAjdL+bpT1aJfLf3y/MdQwMZq1difT+q8tY4oXmyvY4KIt6AsLQac7C+P9LhwZsBZzxE+T4Mz54vfiG77cLZun2xO4MT9KHfg4ZZnELbaM5tuCVFSlFSsrzVw2dNeeP1FP8fapRGHzsDDQcwWO+wq5pjCIhRpnbLFesXeC+ZPpr+l4DFGBca1J29yiCdoy3thS5KSn+wEreLgQFxTK6srBCj9l8PzpGqEQ8gvPuP1dlzTSbDNhtxbunCqURsiJgmv0nXZ6OKdTQ2DAg+mvXy6QBdlwNNFaGLPO2OhBDF9JW83XBsDOHWpM9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhEwRIyfXcjVhfjy5WLvhIwhCM6WUZLCnP0ZBTWBpcA=;
 b=GiZvArkiRcZ+QG907y+gftJiEhIFWAQnxd+oEBp/7nbwkX519lZ6M14T8TuSO8IKozoGNlFYsW+ccN4xBhdV+dM9a14/FkBluwCfWG/mot4JNrPs4v3nADzxOor5TOmebTVySVPxpsE2sjPgAjNlbYajSM0bUuHcXfZoU8IL+AU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB5136.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Tue, 23 May
 2023 16:01:16 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf%4]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 16:01:16 +0000
Date:   Tue, 23 May 2023 17:01:14 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "=?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v1 2/2] rust: sync: implement `AsRef<T>` for `Arc<T>`
Message-ID: <20230523170114.0e4e12c8.gary@garyguo.net>
In-Reply-To: <20230517200814.3157916-2-aliceryhl@google.com>
References: <20230517200814.3157916-1-aliceryhl@google.com>
        <20230517200814.3157916-2-aliceryhl@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0160.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::21) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB5136:EE_
X-MS-Office365-Filtering-Correlation-Id: d546a09e-2482-4aad-69d0-08db5ba6f079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3Vi2dPlAugnKbOkTdyOUpciI1YfSjcjSUU4iYrnDV8Dg0loGEuI7osSX9emD5Yxb783TDCeS2gq8ZMTWvc4lQUMZVHx4Y1ADwtK7zTExPAtEnVFXp3/HYPWySmNFO8boaIkxhthoyWnYoNlIQ7A6YhV5r2pDmPT7muXqeidtGA4XSncKwJ5RPB5DNxHhQw2rpjr+5fBX4vXGol8u6eKXtiLTqStk0NhSIa7yHl/Ea1srk2yy5e31shDoyfRuN0K6M/kFoJQ38HUpoTbC3dlLwqA5DywBHGEJ5Bsogvc+oAFvqp8Cyn9WDWVnV8Fn2pFHTXs/y6K5ZXbXT4a+Zr8byFseGYjcsGaS64wR+sdJNlaLjEWtClOYD6k+4kNyQ302y7Ij5GEooTPJFBc6MG/A3523GuGnvRpsjvDbSE2pK3+tRZOfVuIAQ0klrNp71agQ8jtXA+0wB8zt6luUa0E9/6I5DB70ilio/fJzyc7vdNoO7MsJJLd0c4H1vfhfX+QIJSGG/Jmj/DW5JKwINd1wAtE+J3a9IGbBqo86njRENEAnvS9oy7JQJRHRb1Tye36BmBqxUQxIb5XlYxIrWCntl85UZFtYqf16IVaV1AquJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(6029001)(396003)(376002)(346002)(136003)(39830400003)(366004)(451199021)(1076003)(6512007)(6506007)(26005)(186003)(2616005)(36756003)(6486002)(2906002)(5660300002)(316002)(54906003)(478600001)(45080400002)(66946007)(66476007)(66556008)(86362001)(4326008)(38100700002)(6916009)(8936002)(41300700001)(8676002)(7416002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gf6TZT4unONAsDWlxzfcrElKTssCBVsv5t5qucCOkC5xxjuseuG4ghs8a1p8?=
 =?us-ascii?Q?h0MSgX9vuGrO7qciDrgyDuqlua17Q3JXVzYAowoly08Acjzwa4QAdbctpqjh?=
 =?us-ascii?Q?CpqaytyeLAFavIXvjQtkf7+qEPxl4PoTeJy5xlkQah3giigWSCBLTkwr2jbw?=
 =?us-ascii?Q?GBMZRgUypU/4vPFfZGLVbeIVWt1szks/pTmoeNFhgJN/tZnd4xKNJ6mjN0JL?=
 =?us-ascii?Q?FrAdGV7ss70RMnCHgnS8mEHPfxjpFef8U5XosBoztQGO8Oyr1iLg1HNp7oii?=
 =?us-ascii?Q?aSqYJEVX9Jvn1inSYpUqEJ+ivruelxciz8QzAEBApJMislSR2lGCMw+HvV/H?=
 =?us-ascii?Q?DoGNkpXGKEOIXsyFAPIuONXDavVd8fCBv38R4SW+mH+JaqJaBb0K5peUVup8?=
 =?us-ascii?Q?abpw3EIY9jyQ1D1Z1O/jJaEtzyJZF5e/9VOWuNm38wuXjEePSYPvKCXXn/OC?=
 =?us-ascii?Q?9OuEgyyjjA4JrOuvr1X6LRwkLmkjvTj9LRq+1xM2YnkMByDAJJI4taY/QWpa?=
 =?us-ascii?Q?5r9gTrcp0m7UYeb+TsEIyR72X5qQcHO/xKF37gPCtolmoXIVNcV/3crY1fRr?=
 =?us-ascii?Q?OpwF+Om8L8rtW09igfVRtKSKvvKdg9WW8nRmIzYft60PlvhoibFTSuziaVqo?=
 =?us-ascii?Q?amEL0gGIKIF66VL1XFAFb91aPCs9uo/aDQvKxogtwp6kI+SoOAkACzDjIIpH?=
 =?us-ascii?Q?GelQuAUtQnXz20N2qConUQq/saLPNenBLZay0rty+W+oiwO/m+xSowjrR6V8?=
 =?us-ascii?Q?rIgtYMMYYG44pSx/9DCKiVYIds07roPD+cjshkaNcVa6/jxVXMCXpO5+/E8q?=
 =?us-ascii?Q?Ajc7cQyxBqgE1XuBOKLmx/o+uy5bB5yuJ8C33GV2DpCodOym0dDFF66A2KrU?=
 =?us-ascii?Q?PgVbprRpApEOPSO/qj8q/XTeZnkdd7ckWaoaxW+2lSmJD//TkpB8S+iHTPNe?=
 =?us-ascii?Q?p9nfTvTXrPYn/1HKJD7blNhZpT0dqX1oiw32GoisJWS49AHUrrEc32MorwuT?=
 =?us-ascii?Q?CBEausWzM0nEblHfey2hFCDvj3a5wOPnfHYx4pXdS1BEWqPcvgM2YWzJdiK0?=
 =?us-ascii?Q?CYwW4tr0T0/PgeabRnPzqfcn5cknNdzSoNSgPrEizHXcDsFhRFETBTA+SajF?=
 =?us-ascii?Q?5VgEUg4mz0TTU+ehR3X2Eoj37ztYxlcHgBtvvPCdLreWWJzArO0BX6FlDH64?=
 =?us-ascii?Q?FIuT1knxpsl2zM53uqI5O5p642bgjvbqWVm8B7IR6kF0T8KE877OeuvVG1wx?=
 =?us-ascii?Q?Gdq/DzRLbJSuzh3y13y0gZF10s5YtqfoFKMQUzWzPGiRvkIcIHga4vJkhZzL?=
 =?us-ascii?Q?cOK8egYvZ7wRlpidk2a/Rx1TVgYi+wsGGuUlpm2kOqQmzQF9VKRBoZAqOM1Q?=
 =?us-ascii?Q?6N7Zkxh684Lg1O2hxUW8rmIadoyVEp9dBTSSCrqlAoJlPDnnUVwhFV7N6ROX?=
 =?us-ascii?Q?rxIByWL/dw5FvS3t3IgSah08++x6DkEc03kztyCzK6ADj74EZxEZnhWS00Oo?=
 =?us-ascii?Q?ke0gZG5kCXpGmYWo/MmoetcnVIp3bo4ZnxbhRLP4smwVQYjUq+yqY0XIwGF/?=
 =?us-ascii?Q?A8itG66zpOXzWmQChWpozpCuQnhOL5vHpHgXw4UZ?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d546a09e-2482-4aad-69d0-08db5ba6f079
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 16:01:16.1662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XL2j9xif4dk8Vs/QNY8tO9ow01/pXMgUMNvluLbhLz/abwdSL5GI2ZCKip32yJq22ilWcF5IW+U4xanGQbphVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 20:08:14 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> This trait lets you use `Arc<T>` in code that is generic over smart
> pointer types.
> 
> The `AsRef` trait should be implemented on all smart pointers. The
> standard library also implements it on the ordinary `Arc`.
> 
> Co-developed-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/arc.rs | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 274febe3bb06..9ec911e4a0c7 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -264,6 +264,12 @@ impl<T: ?Sized> Deref for Arc<T> {
>      }
>  }
>  
> +impl<T: ?Sized> AsRef<T> for Arc<T> {
> +    fn as_ref(&self) -> &T {
> +        self.deref()
> +    }
> +}
> +
>  impl<T: ?Sized> Clone for Arc<T> {
>      fn clone(&self) -> Self {
>          // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.

