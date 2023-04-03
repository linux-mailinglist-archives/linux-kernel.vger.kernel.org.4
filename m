Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AC36D4BD1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjDCP1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCP1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:27:39 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2132.outbound.protection.outlook.com [40.107.11.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B81C18C;
        Mon,  3 Apr 2023 08:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8cd2pLlpgIFYK570KSToxLvQiJEZBFJzB6AET+tZ3Z9NdVoPCvITwyYvm+XtOcMuH9KjKnCICnZYWmHC52vjyy8ICdd3iw26kDjs5xPYrTNBKvwVGUV2br4m9xd5WAnODeu8iD/RJS2i8fhrcjXh0ZvaLmHnydeODEQiI280fHTYU5Bdz+9i1Yb2zQMEEB2/SLoQhzV1g14jUYBlEP8CqQQVfw40MijO9FRFIbTi0DEcKs6GJ+TkXirmXGjcDR1dSnGOAGlpYCkdDVL2btqM92oMqru0GrO2UKsVhs9QPLcOSlgC06Tsw74c4L+P4CqV4231Kbv+LAzr55JqdaXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPAjl5xsky7UkfTLxxhBRWc0YRfTL2g4XMeQbM7WmMo=;
 b=BI2Svoc/GBx8NdmkjiYHaQtbJWxvRsFh92rKUgjrp2HgbQ7xS6m3Fpm6yd+voEq76eay4A7x4a/N6eNHE+ZhuEKj5hTOHqBh9NVe+lHSM3YFgMtVc5hH4aveCRIOEy3lX9rhGR/4KJHBH5AbnnZQGGc3Ao8e7cCze6fMh9/FMkL+YnGp8H+LmbFKZMAMoT1kpol8hp8NvnNnQOtcsR1/JhowoC9OpjkoXB134vn6VGK/wsaKdxvfiXOWWCic10nEWxc/bvz26ci5CgudLycOmFue9R8mXWgHlH8h1S/17c65dW9kfN/XVBw0Aa2hKq+Dtd4/LSe3QH/a8kIkEgWgQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPAjl5xsky7UkfTLxxhBRWc0YRfTL2g4XMeQbM7WmMo=;
 b=k4IJGrfV9fVKwyueEozc7LBsvAzFMKrMMqKxlhQb9+JeaYYtoAWxtdDcg1AQX0QJDQ7FxAf7yyP0HnTk2dznnwy6ENOYW9HQwtn02RYm6WH0h8Pip+c+a/TjSuYC5yW58kjENYcBN6XrVzxYU3rSz0QGFbS705qz6ZDAHk1HZ9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB1988.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:6a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 15:27:34 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%5]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 15:27:34 +0000
Date:   Mon, 3 Apr 2023 16:27:32 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH v3 2/6] rust: error: Add Error::to_ptr()
Message-ID: <20230403162732.4509df69.gary@garyguo.net>
In-Reply-To: <20230224-rust-error-v3-2-03779bddc02b@asahilina.net>
References: <20230224-rust-error-v3-0-03779bddc02b@asahilina.net>
        <20230224-rust-error-v3-2-03779bddc02b@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0355.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::18) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB1988:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e0f6ba-9927-49e9-81a0-08db3457f297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZyGaCJeOeLUI7F2piXPXfVouz4nmK+dSWvjp/dASsEocDALh2n5AlPuQdNDJ77vZCBnJnQlKpaKteQLrjqpyfbAXNUUiLOAuR2Ee0Eh9bOBjDIfSdTV4v0k73H2G8YydzZyAu9oPrSnJaepnYK4kZCXyCWIemh6MrJ//PKrX9y5sR1QjPUmlJ4SgQd4fW6TEG3e2kjbUGYDi0BDWeFWqSmsnr3zJ7QZyR3EkImXYrJ5BWGlFCujCANTY+fJCQTKwyHhRmEsfA7MI9Io4npoxQlBcBKyZNcAqiuyBey+B6olhZolfJ3qKidxAN5h/Z5SRKg0ddz57nIEZzYw/7xfE0imGOKjJMQiXAOXA2GjBxtbnMT+G1Rts3q+m6R42g5ShuBa8o4fXi2ZXGds70mTT8x2b8QteIFyOYMpBQnj3ia7erl0LLb3bSPp2SQeYgGlLawycxpCaB2nc/v4E42pprXjvMcVpwgQSNIU/ZhstOwhvq7qpnKvEuavv9Z61wCVzI+AjZwczYMk6thBzou2iaCGkl3uC0kb1QAuL+T5Ou73fefjnVNiDkMaOOgBsV/5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(346002)(39830400003)(376002)(451199021)(6916009)(8676002)(66476007)(4326008)(66556008)(66946007)(478600001)(316002)(54906003)(8936002)(41300700001)(7416002)(38100700002)(5660300002)(186003)(2616005)(6486002)(26005)(6506007)(6512007)(1076003)(86362001)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IrJLASMOXe8qCHkHqSaGpB4qjAGq76tWZA/s/2Sd/inoFs5AAvj85/GnR8JC?=
 =?us-ascii?Q?W5MfPUfRaPaHzD3jbxwA4+egX+dUIr/tXtNtKKTNdsqzIajA/9g5SgkrcOYX?=
 =?us-ascii?Q?D7Gu4u0iuXcR3ipe39vx62QTeD60vwHfMO344gIu6l8pDyuXLqD155ZVjluP?=
 =?us-ascii?Q?cDx9YzqQ14fmqvr9wK2K7m64odSaMqdYSvMu0VtDrOQa/erHARx7dlsWFfn8?=
 =?us-ascii?Q?002uxeJATq23sRykkK5A4uFBTyyVn69OgUIdstAI8oAz69xo7D93979kMvVe?=
 =?us-ascii?Q?G6i+4uFwvqd1ZntFaKQu7XiQjz3AyHk/NZHvToI194nstt9kLSLtT/2i7Qgl?=
 =?us-ascii?Q?P8FjCSElQ7RkCu+JQkgooBRvAjRlmXB/9vnmfnXaACcEtdMIwy3UBMlZNoMj?=
 =?us-ascii?Q?cK/v7NptI0GCD7Ftz82vUEv7J016kGBjJGXlL4oBMTGFkDA7nu17nP5Cz04v?=
 =?us-ascii?Q?qdAvxdSPH7Q/dAigcV/Af+djVSrL9xM/9LYUrIhpa6x9QZ1L6wo4zINBaFha?=
 =?us-ascii?Q?jJ8AI7RabLxpw9BRo0aif3ZsgGkAURJF7e0+4YVzc5mkQh1UuKMf3rLbY1np?=
 =?us-ascii?Q?kdJ8LJRkP9kvEsqoub12BgEibqZ7HHXoS5RMS3NLFLFLxYG493ZLxYr7D42h?=
 =?us-ascii?Q?UP9X68RePMktGnlcFStVm2wlhUC1bWO5BVhfhfEkwtcRX3vjcGTSN+JQUlvB?=
 =?us-ascii?Q?ouWyDvQyLoK6p7mEPYXIfR9BahTVvm03iFTvVHvf2+8roqpA0bHvGDQowa6Q?=
 =?us-ascii?Q?tuqZvZhz9tGIxOHa7YZx01NArYRWyZT1XnujNTJxejIfFcPJgTJI4SD1csbC?=
 =?us-ascii?Q?mlM51w3UdF8FDz9vpdIcsNoHMoqBkSK7zXHNVvc4EIw1beK2w7WY4HAgplh+?=
 =?us-ascii?Q?jsmid03/Rn0weIfVxEwTEPmhjcvBLUarM1a6QVqYXoFwrXRGj1FMAyMAZE3e?=
 =?us-ascii?Q?ZJ0rp+oIutTmlooARUDE0CnVMD6CndzgXsv24tDi7ofCiY/PmfAo1Cgvwbyt?=
 =?us-ascii?Q?Q3lB/Nu0ptaaJY8tbBKmxlO3eVvUS9mZ4N6W9EXo9ZXwbUQ2nKoxiYh2ruaR?=
 =?us-ascii?Q?alieNFA4ndQo2lNhTDnKbRb/1uMPsVrFwL9+0rPZthMhIZQ1Kjc7sXwrIZPQ?=
 =?us-ascii?Q?P9CpIU3calbPL9tiwvyNECbq1IMkvnrU5VS/V7xq6ropHhr+iK9f8fzt3N5N?=
 =?us-ascii?Q?x3mYUD9iG7WqYgvq8Gt+M9C69pQ1//ugfAQTW676XuY82SGuMlIbs8zgXyhg?=
 =?us-ascii?Q?D7M2tZDxR+Cc/p1tN9qsnGUPQ8zWTKeqAgukiC5jUZLYJq+GQzkGE8bNPAiv?=
 =?us-ascii?Q?+aujGnqltlAiber8OqAmbbuX4kMLaRTadLOeb6bhEqTs9B/Wd9NMss/pgWKt?=
 =?us-ascii?Q?o0GL1Hd0GH/kfFNJ+DxAz6H5DZ0Gb1+HEX0HoDh30EArRjx9kbpRy2afov2f?=
 =?us-ascii?Q?neaFXsPWHOx0toM1N8XgPL8Kodd+ryfJYunTecZCBQV4KiGBQaMf/+iZQCcV?=
 =?us-ascii?Q?4CNS/1TAP8J3q3m0wngKYaYNkGTz9z0AyaBTmEM7DOAD9eHm3m1Xp1U/uDkL?=
 =?us-ascii?Q?PokWrM23GL0PhcBQmNNPkfPvv5PicgVyAi2BUMlD?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e0f6ba-9927-49e9-81a0-08db3457f297
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 15:27:34.0997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jsTi5laJW4ljUnFUgpbMrDqH2FlQ99uhdnq+sMWOydWhT/5n+QdGJXF321N7gKTQA2oEeTSUCx9UmikRiJa+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB1988
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 18:48:11 +0900
Asahi Lina <lina@asahilina.net> wrote:

> This is the Rust equivalent to ERR_PTR(), for use in C callbacks.
> Marked as #[allow(dead_code)] for now, since it does not have any
> consumers yet.
> 
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Asahi Lina <lina@asahilina.net>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/helpers.c       | 7 +++++++
>  rust/kernel/error.rs | 7 +++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 09a4d93f9d62..89f4cd1e0df3 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -20,6 +20,7 @@
>  
>  #include <linux/bug.h>
>  #include <linux/build_bug.h>
> +#include <linux/err.h>
>  #include <linux/refcount.h>
>  
>  __noreturn void rust_helper_BUG(void)
> @@ -46,6 +47,12 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
>  
> +__force void *rust_helper_ERR_PTR(long err)
> +{
> +	return ERR_PTR(err);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_ERR_PTR);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 35894fa35efe..154d0ca6e2dc 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -76,6 +76,13 @@ impl Error {
>      pub fn to_errno(self) -> core::ffi::c_int {
>          self.0
>      }
> +
> +    /// Returns the error encoded as a pointer.
> +    #[allow(dead_code)]
> +    pub(crate) fn to_ptr<T>(self) -> *mut T {
> +        // SAFETY: self.0 is a valid error due to its invariant.
> +        unsafe { bindings::ERR_PTR(self.0.into()) as *mut _ }
> +    }
>  }
>  
>  impl From<AllocError> for Error {
> 

