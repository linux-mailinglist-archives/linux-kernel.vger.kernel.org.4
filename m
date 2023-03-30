Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4061E6D0261
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjC3LBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjC3LBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:01:14 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2127.outbound.protection.outlook.com [40.107.10.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E03B93FF;
        Thu, 30 Mar 2023 04:01:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WX22CXseQu5gghNuWRbSwYbQDVjUXr36zVj19eepP9MFRJq7chl0sJ3vzXS7OEC5lDrNIZg2D+Ckbc4+M8SU+/XOCgEiIgfgYUt95m7LxxZ/ytWjvamYh7SvNF8vp80cEPxp78KjGfCBKe1OdzZaYhSpqHe7GxdOvNn/CR0UZwyCD82t4Er5A8/wNS2cYtBW3MKQVm7RELhn7CGQcptkrLKmgu2q/GEUyQLDxs6iH/I3dqrG54kEfbK6i6KFFPgfamhBNDUra1RTFYfVfzlUoJZIbEYTQG1378jnYpOGoUkjvypYiI8AT3JHXIR7Pp3dz4Jxid2GfajBxKCwrd8CNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OlaIzSQ3XSOPxbYDYR5q7x9wvqGZq/LERK12w9BEjo=;
 b=ETRem8aI1iWd9z1y33XLo0NdGUbczKLb/LzEbecUge09I7hTmR2M4ATcHmn0E/g/jAiW0EPlICFndBimHdTkklVWYmwbzDZunOJiMk1Uq6oJAfydSEFLP3cNO1ObcC8SPkhsMybdvSGSYN1BuI6KGy+VO3jhEx9G00xR3Y8ViVnFUhJKATTAXy7kfGuhuyUgNgjQeh+WgVZiXVTturZEYBJ1rFbxqsqcR2hamngZ+MYsKxBgk2t6LH+StYrdy6DG0z6KgArnrF8HMf3kIDxN5cteHmWz+RYA8gfJfS28ebmUfPcKf5xVPXyxWc0vOM1AM/Qi1SAwceDd2Mz2AtDaew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OlaIzSQ3XSOPxbYDYR5q7x9wvqGZq/LERK12w9BEjo=;
 b=WqgndNciUtQRirwiwyq7V7p+w96cpTJGsfk4QUJFzZ8L6Gd+/WBabUjQxI8F4RzEoQLVtTfjaLLAwBbWzhCwjjZp1XQPdQxdNI2PKGeXNpzXg9Qux2ErO1EfGOwKuhg12aov7xxUtvZLM5zH0fQtS+pCNkDjrPGgCVhD6BdqDS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB5202.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:191::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 11:01:05 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 11:01:05 +0000
Date:   Thu, 30 Mar 2023 12:01:03 +0100
From:   Gary Guo <gary@garyguo.net>
To:     y86-dev@protonmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 07/13] rust: init: add `PinnedDrop` trait and macros
Message-ID: <20230330120103.2baaeb1b.gary@garyguo.net>
In-Reply-To: <20230329223239.138757-8-y86-dev@protonmail.com>
References: <20230329223239.138757-1-y86-dev@protonmail.com>
        <20230329223239.138757-8-y86-dev@protonmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0097.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::12) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: 691c3577-8b4c-4200-3c54-08db310e0f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kc/9VacqCF2KP6mdWa1BQOhB0RrWRPohtdmY17xjzAjOFPrJXYUbvTbc3Tdz2WUC84SZQ6dccroYLTXG5Pqrri40kOPIaWXu8W43r5kskf6OfqDAznzyDghvFe0J2Mk02gsqOTd/M0mTHqzWfMljj1XFULIAGlQSOZiDpVavSK9mpmdcxuxtEVt+b83lmEhdqc4CSTSG1Rd1oeQM7H9amsSgG7it1ftyoATstwF39mJKk+TQP1CL96fbKQNrR5wHEcon4AyjnTrmEzOtzAdfv3xghksDmov++r4LTdLGzBHdLJP9U1BbhnaGzxw4y+5aiOxaIep2GXNHaynu4nLL4Qv5Ys7/xWGj1c4qapffnhtnAVZxG0qSGy1nXCTc7RzSyg3NQZIi0mvoiuUV8pmEhc4PyPJ09Y39VuY6tlUiz2iPKcFdWgJ44ZZ6cE2/buGAI3queyTprxzhwaqcUSeQd6ZLIFQrE/4ScGImnpJG9r6lkoyGJJ6LRQ+Hw1KIVm0zGaMCU/AJiZTKljUY52R5SZ822GvprdlgThwxMRo24yEox5OIWM+O6fT1PmknMiVtudrLtpR3WZF2LrYEnHpl25xK7N52vRJljKIO5n8Lx5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(39840400004)(396003)(376002)(346002)(136003)(451199021)(26005)(6512007)(86362001)(1076003)(186003)(5660300002)(66556008)(4326008)(6916009)(66476007)(66946007)(316002)(54906003)(8936002)(8676002)(478600001)(36756003)(41300700001)(6486002)(7416002)(6506007)(38100700002)(2906002)(2616005)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w3Bchl14vWsBax8b51Zqt+B91gFDHLJgWovUmn5q26swfgeuIoa9+uEgzLbN?=
 =?us-ascii?Q?nGt6CrRWbR0IxYZGZ0nZSEjqbIqDcyOKq8ZRlnvjKJaFIaKLO73V6FvpV0r1?=
 =?us-ascii?Q?ttizZAGhuAzz+Hn++7k76ZLPop07h7yh3S9YZQzwDt3R0Hh7xiRdkoBpQJlW?=
 =?us-ascii?Q?1Usb6Jn+Qh1ppTOCGSjnO/Vf7A00vbzsptWrzVHj9PU9WCKlNnOAbfKfFW9D?=
 =?us-ascii?Q?ET/tp0AwU9L36eusIonEiBfNoP8Rpx121/XeUYJVedu3H2mxTpPLFzz3ZaTT?=
 =?us-ascii?Q?G9Z5H42rLbsKzkJxwHSh7ZI5XSla/seDXQc+rQxscAdllCrIvV60hspJmEex?=
 =?us-ascii?Q?Bc1nZ7oVuXEgyaObnMFtjrTAZJBA2cV9E4UPb+Trar57DBvzYzwTx3BXtvlk?=
 =?us-ascii?Q?ydL/mZnqB3fVUtVE/hBKBid5Mhxy79/KVrWKSvBNx1+5ADlkEmCPpH0AW37i?=
 =?us-ascii?Q?q9ei8TpTnEri7w4BzSSSNz9CLeO+cZGeJWN1mne/4yA8a0hhz44HofhF8TtH?=
 =?us-ascii?Q?yJ6KHVeRP0J3INv3FZEnLvq+o5O54Ykprwui+i6NNqsMUXi5i38oEplgEICc?=
 =?us-ascii?Q?6fvS1D1pAmhy7Lo97Z3gD2UBivFXyeJF/V4rMHPKXhtBWlDZftpUEoxb/mmH?=
 =?us-ascii?Q?erYyTa8gumZu5+bqSWYfwjDvPJ4q/qO82tzee0EB5FqpqlZuCPohG7CXpcZE?=
 =?us-ascii?Q?7+tTcpf43XHhMaODMvRS4SXx57KXjG5t6WaJC6xLvBEGTk0UtSYIHFMki/3I?=
 =?us-ascii?Q?6rWJbuwFd+j4m6FBVurDI+89R5vTZhezuyP5cKh6nlcqRYIrIRvQVT8QfuJq?=
 =?us-ascii?Q?5JhA1hZAMa3NpsOscX0fjA++CqGrExNbQf/avBjB3YlD07yHlXQlJAFIJ8wA?=
 =?us-ascii?Q?GYv0k7rY6cmb+Z64iS/SCFJ1zFjgpEp7wfV6CWELyNEwTh6Q8e4uzuQ/zIbh?=
 =?us-ascii?Q?PylvHMrlG7nTY+xiVxjFpAQIKRe2aPeQgALwmYsSqvnnERop6yD1MVxqsH12?=
 =?us-ascii?Q?aJ4SEm5c3rqm9Umy9YgKON8mHerH8KtDUApSpFntzKmD9EWf+j3/E5QikmkA?=
 =?us-ascii?Q?IcvOud4Ort5SLH7iRtZ8JNT/R1c+832xDR+zY7gYXfEB+S6UiDpYH2MeDUod?=
 =?us-ascii?Q?5AZe2bbcyq2ta2cCelxaMy6is5bhmJI17po1aBVAAI4aXJY72DZorYM6TCeL?=
 =?us-ascii?Q?Q/4qfRbIMbm2Ph9Ov+b7nu4IaUjcK7hfIU7bfi43GLaZkII0X1SIRNhstqHe?=
 =?us-ascii?Q?jG7bmf13uWrM69mw9MLYFiyLxvsV/547/i2RspqIE8G012jG/8jUfhFlXGgt?=
 =?us-ascii?Q?7d6r+2PPF6fMNBHpfuZ/d5QxRVJOeKTS+O6rdQCq5Wn38smq62Z6Mwbg4VHH?=
 =?us-ascii?Q?vbMd1RHOWDVmaWRQj834eIxYRe3uO3lm2+AbnaaTwZteAQLdrdtuwbsEF5wn?=
 =?us-ascii?Q?Qj8jNXshNdI4BdxPI0jP+I5LWwbbIAEbmfnLysivoE2YVljvECvjxCztXs8Z?=
 =?us-ascii?Q?o0TI6N9j7hvjFoDb8Zga3kQtvHXJVrsAwEbfsNkX9qHDgampIUKxLwb56HlO?=
 =?us-ascii?Q?g9uJDMz1EqiNGhP5JgGoixX04s+KmEgr+1kxBE+K?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 691c3577-8b4c-4200-3c54-08db310e0f02
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 11:01:05.5476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+KUQf0mB0LtdBTbDVOcyyB4UtxE2++VTGlVhKS8LWqLPviJSHrSeW28RN1SvgN06jAXp+MMow3QcOtW1UD/6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5202
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 22:33:24 +0000
y86-dev@protonmail.com wrote:

> From: Benno Lossin <y86-dev@protonmail.com>
> 
> The `PinnedDrop` trait that facilitates destruction of pinned types.
> It has to be implemented via the `#[pinned_drop]` macro, since the
> `drop` function should not be called by normal code, only by other
> destructors. It also only works on structs that are annotated with
> `#[pin_data(PinnedDrop)]`.
> 
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> ---
>  rust/kernel/init.rs            | 111 ++++++++++++++
>  rust/kernel/init/__internal.rs |  15 ++
>  rust/kernel/init/macros.rs     | 263 +++++++++++++++++++++++++++++++++
>  rust/macros/lib.rs             |  49 ++++++
>  rust/macros/pinned_drop.rs     |  49 ++++++
>  5 files changed, 487 insertions(+)
>  create mode 100644 rust/macros/pinned_drop.rs
> 
> diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.rs
> index 692942a008b3..4a3c7bf27a06 100644
> --- a/rust/kernel/init/__internal.rs
> +++ b/rust/kernel/init/__internal.rs
> @@ -132,3 +132,18 @@ impl<T: ?Sized> Drop for DropGuard<T> {
>          }
>      }
>  }
> +
> +/// Token used by `PinnedDrop` to prevent calling the function without creating this unsafely
> +/// created struct. This is needed, because the `drop` function is safe, but should not be called
> +/// manually.
> +pub struct OnlyCallFromDrop(());
> +
> +impl OnlyCallFromDrop {
> +    /// # Safety
> +    ///
> +    /// This function should only be called from the [`Drop::drop`] function and only be used to
> +    /// delegate the destruction to the pinned destructor [`PinnedDrop::drop`] of the same type.
> +    pub unsafe fn create() -> Self {

Although this is impl detail and the name doesn't really matter, but I
am wondering why this is called `create` instead of just `new`.

> +        Self(())
> +    }
> +}
