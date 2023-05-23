Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A770E17F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbjEWQNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbjEWQM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:12:58 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2090.outbound.protection.outlook.com [40.107.11.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BE2C2;
        Tue, 23 May 2023 09:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTGvVfSrQPUIRvsj8RP9armER4YFdnePeCU1Rd87y1214d4wXoeIriavR1sAwTEg0SH3ftZSn3GaPxgRhXGlx+TBSWKx7qLrm0dzXCcPrVwAU4ep7FnCS5SfzCXplHi9hRJUNenSAzrSI1naIGpuxGFN5FbpzdQFzd39StorYaStKhEze587sUWHC5P63dMUTgiCoWidbS2X4NLMp9kJYvIZE9J5C3xlO1UHg+lMn+aeGdvZIpE4tk/slTR2knCWByS80zRDSfwbSz/rfuxGpoc5TChZOf5TrWrq+MzNnQK34zSyVe/i2TLBckL/2+4kNXFmBHa8+Rf1kIsp8n2EXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijJ/J1cK0nZrRr4BfMcaxs5kYbR2NX66u96JDsWDaJ8=;
 b=RVo6PLhapFfxlHkAleF0sp4+9dzJO2TYberuuS1XGQtf9s4xljHlry3Ikcgi1eQ/BVU2itODyZ4QI44u8Xcrb79MyhjiV/eLWWW234cPZ8qPylrAyhTPTw8SbZN0CAPiWYHe5m/4cLoclKGS1zi+L6YqHTxW2QFE5pMTA+VDJwf1S2UvWRUuTn7utwNIaOmnsBjahuZjZGZovuocnXZRa5z8ijA+nmyxjQqKH5dtzZZfhdlWdrDPByxFoiMEm72zq5+LLNKJ9L2rGEoZBETEddm/Y4QhtQka5HW3mt5dX05lz0YzlEflwwUvb1oGmBIn0z3PvC4aDQstBu2TiOlhlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijJ/J1cK0nZrRr4BfMcaxs5kYbR2NX66u96JDsWDaJ8=;
 b=KRt5q35zuGihjHBd+eC2WG3Mdo7G+5p3OJ7U4zUQ+vqej0966Ul3lGBZr9EOtSijnyp/kJGyBiZzWZS5BrY1NIPQ1ewgG4MFflVQAMS7ycLnUH3PsSnnMek3ce0irFj987gpo/k8cQsfgPfSl0f6WORlnWuqWLeuS2g+hhjamIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO3P265MB2331.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:103::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Tue, 23 May
 2023 16:12:54 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf%4]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 16:12:54 +0000
Date:   Tue, 23 May 2023 17:12:51 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH 3/4] rust: macros: replace Self with the concrete type
 in #[pin_data]
Message-ID: <20230523171251.786e55f5.gary@garyguo.net>
In-Reply-To: <20230424081112.99890-3-benno.lossin@proton.me>
References: <20230424081112.99890-1-benno.lossin@proton.me>
        <20230424081112.99890-3-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::14) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO3P265MB2331:EE_
X-MS-Office365-Filtering-Correlation-Id: c828f21e-2c8b-4ed1-c81c-08db5ba8906f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WVxe4Q129cAPNx+ta3g9q3b8fAbYTJ84UPcSscq8Bt/XAOpiGUu1Z7N85HkSXIZJ+Qst+HlQ+wcZIWvsVBIppM2AtK57ICrG0H5xty3jmorNZI7adeOI4nsdRiuLuQInJ8hXihsXEpE/n7FG22iOi4t+j2sF8ZFynzd9FWzrX8gOxDmcVvgROhZlbYTZZ/4e22naeKhnA7AF1j40KcNuliBSok+yZbtFJFTVOzHBOuMzYCGgDq1tr+dwLidd5dTMzoyvJefRMfGWdzfqfFpfX3J/mwdY10fE4LEeZc1tVUBV11OJm8ygGIEWCHZ0Ddnj4wgILIgBCTIuYWB3DCZ7NNuBsf3UhKC26OjW7bPQZAZBaX+2BqIhRvnzqBft74DNjrQkx4YbLKKwx/DJm3R4Xluqdq78+ZtUuHb6ddbL2y+rBoJ/auXFuWjjdWlyJVLctGAInYM/GE8r0nrHEWQJRpVArLXLLV0PfoM2d30jagBEuMDgnadX48m7SIGrTynooST46bEa1urv66S6FmKwa/hC7EiBbrIWdsPsxwLxxUwKMdFH9hutzEENKaP9H0bu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(366004)(39840400004)(451199021)(1076003)(6512007)(6506007)(26005)(186003)(2616005)(83380400001)(36756003)(6486002)(2906002)(6666004)(5660300002)(316002)(54906003)(478600001)(66946007)(66476007)(66556008)(86362001)(4326008)(38100700002)(6916009)(8936002)(41300700001)(8676002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dXiCIMA2FBgaRpmFPGD2aXhfjlBCMkFnkuOOTFoQ3LyMw5MtGar1kZBJSdgw?=
 =?us-ascii?Q?Lddcv9TWwZlSN82y7wYEVikHuoxtPpkLnjpChwARp32sNn5H4XcGaj6uh2hY?=
 =?us-ascii?Q?ba/EKt9ms5mHag/tM/64xEv9B4N5403XhiV07X6Lwa0fvMl/LyOihS6++oe/?=
 =?us-ascii?Q?em8O12EDey39e/woeZss42gZmC6LYBCnK/3sh0x4VMZHPZvri0/07ypkKm9e?=
 =?us-ascii?Q?Aki2iWkjKi03w2DYJL2H/if+4VdnPKigz4wJDRIn+VAnFMCSV+PVvoqeCqDC?=
 =?us-ascii?Q?uj9zHTT4s2p81J55gVGWlhiVB0Ev9i8uAHWLta9san4RJM3Eplk8D8Lp9emX?=
 =?us-ascii?Q?sjXQNLvFcx8OG5LzvDgwWvE4D/etS5c0HCXyUpAStT+VjpGzhz/9i0PrXSh8?=
 =?us-ascii?Q?ShRLr/HGr2M4pjXhIna7tGe3a38F+mZmZ+h+tXRmKh6sQSR6MP8ABhiR78R3?=
 =?us-ascii?Q?FX6bDDvixHo5rJVWzJK/MaF5qBj3vLqaTs33MHl0CU5iBxGYf+qoqJJT3bJE?=
 =?us-ascii?Q?xYNr+tLsi269xXewMSB4FdEMhGQT37NGPgYJ3H4UNF5PiPfib53Q1WNSwhaT?=
 =?us-ascii?Q?7qj2kXq4w958smZfG4Pv0dWfOfovpF7+fGvTT8x7bqM9mcvCTe8/S7l4CKdi?=
 =?us-ascii?Q?Id+tB34ZMg62WT5oQghoHCKNbDnf38HWZ86XVlvVq1zqeHKltel1/ZHbjqAN?=
 =?us-ascii?Q?P3+5/mGmbFZ3fXAZoVqjJbbvT/lSwg38fR58OatZKTZU2PlHPo9l8Wdk4bDk?=
 =?us-ascii?Q?1VLQ7hZQ35KvvwFfiUMoACWPdbUpq/Rt6wwFrNWn3OkSWGwPqrAlt7NQaz0P?=
 =?us-ascii?Q?TEfT0cwuEPWCza6a3ve/OSi29W8fCeIXlVj0bFnrRTMaobpSF6sPJw/cCCNR?=
 =?us-ascii?Q?pRxcFbsqb8nNogTjyEjneyr5ma8ehJhhRawjELsQ34hBB5SVA2OKP+SFhUgt?=
 =?us-ascii?Q?9LztdLlORnNoM7t2yqppwSBNZkCMnmTzbdmyHuyvnYYVE+KyeL0EgTmZ4pQh?=
 =?us-ascii?Q?mUuO97pv6Z7mnxUrX2zq93DcnzYQjcu1H8X5IvdVoh1js6PmCuee8mUgMY9n?=
 =?us-ascii?Q?+8FhBkB/fIp9G/ntfFS0OnBy/wIFizjYwHFKKK+MxEtzddmGFhc4rqzqtZKA?=
 =?us-ascii?Q?Ba5ablz5D08tJntCbrKoDT8aFWAy7LY0KnUjJg5g07+mMqNVLPi2+YktLukm?=
 =?us-ascii?Q?58RaFimdW5L0II91cxP35O1GEYetZeRU/IlvKX23GrJMHCi1Mipn/IRnSaoM?=
 =?us-ascii?Q?/PnH16BGUM9sQcWIU6/JNPR6sdhvPHLdVc0gis5A08+LVop+dcvSWAkdRRqr?=
 =?us-ascii?Q?U0OiLnlUEyuHjI08xn2VNOH0Ay1Wcxe823zRhcpK3kT34upROAVnwGJ6Dtda?=
 =?us-ascii?Q?fFK97SiXWngIudQxlxmDAq/10o5dpexVI1f3Gqz9kcGlFOdOz8vORQfxHXcG?=
 =?us-ascii?Q?JruLvJZXXa6oCuYdvKWtUNAqLNbQKC4XjIBVUi49ons9wBHG5T0eo/26PEpA?=
 =?us-ascii?Q?EtDfLQsehpQi1GzgRZfsWT4G4fKFvMKfZ7/wkoNBCQohMqgzfnN9Cs/SMYuH?=
 =?us-ascii?Q?x37mduCcyB52I6VRGblODa7UaqePQRZGSfaKp/Nk?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c828f21e-2c8b-4ed1-c81c-08db5ba8906f
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 16:12:54.0377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URzY0l+v8/qIGEh8NUDHgG7tgozgjsNu0NyxhcSQ8gaPjCjX6WScMpwWlmu8d24E1OuyWfpoHcUh17SPyRdJ0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB2331
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 08:11:43 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> When using `#[pin_data]` on a struct that used `Self` in the field
> types, a type error would be emitted when trying to use `pin_init!`.
> Since an internal type would be referenced by `Self` instead of the
> defined struct.
> This patch fixes this issue by replacing all occurrences of `Self` in
> the `#[pin_data]` macro with the concrete type circumventing the issue.
> Since rust allows type definitions inside of blocks, which are
> expressions, the macro also checks for these and emits a compile error
> when it finds `trait`, `enum`, `union`, `struct` or `impl`. These
> keywords allow creating new `Self` contexts, which conflicts with the
> current implementation of replacing every `Self` ident. If these were
> allowed, some `Self` idents would be replaced incorrectly.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Reported-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/macros/pin_data.rs | 108 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 104 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/macros/pin_data.rs b/rust/macros/pin_data.rs
> index c593b05d9e8c..6d58cfda9872 100644
> --- a/rust/macros/pin_data.rs
> +++ b/rust/macros/pin_data.rs
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: Apache-2.0 OR MIT
> 
>  use crate::helpers::{parse_generics, Generics};
> -use proc_macro::TokenStream;
> +use proc_macro::{Group, Punct, Spacing, TokenStream, TokenTree};
> 
>  pub(crate) fn pin_data(args: TokenStream, input: TokenStream) -> TokenStream {
>      // This proc-macro only does some pre-parsing and then delegates the actual parsing to
> @@ -12,16 +12,116 @@ pub(crate) fn pin_data(args: TokenStream, input: TokenStream) -> TokenStream {
>              impl_generics,
>              ty_generics,
>          },
> -        mut rest,
> +        rest,
>      ) = parse_generics(input);
> +    // The struct definition might contain the `Self` type. Since `__pin_data!` will define a new
> +    // type with the same generics and bounds, this poses a problem, since `Self` will refer to the
> +    // new type as opposed to this struct definition. Therefore we have to replace `Self` with the
> +    // concrete name.
> +
> +    // Errors that occur when replacing `Self` with `struct_name`.
> +    let mut errs = TokenStream::new();
> +    // The name of the struct with ty_generics.
> +    let struct_name = rest
> +        .iter()
> +        .skip_while(|tt| !matches!(tt, TokenTree::Ident(i) if i.to_string() == "struct"))
> +        .nth(1)
> +        .and_then(|tt| match tt {
> +            TokenTree::Ident(_) => {
> +                let tt = tt.clone();
> +                let mut res = vec![tt];
> +                if !ty_generics.is_empty() {
> +                    // We add this, so it is maximally compatible with e.g. `Self::CONST` which
> +                    // will be replaced by `StructName::<$generics>::CONST`.
> +                    res.push(TokenTree::Punct(Punct::new(':', Spacing::Joint)));
> +                    res.push(TokenTree::Punct(Punct::new(':', Spacing::Alone)));
> +                    res.push(TokenTree::Punct(Punct::new('<', Spacing::Alone)));
> +                    res.extend(ty_generics.iter().cloned());
> +                    res.push(TokenTree::Punct(Punct::new('>', Spacing::Alone)));
> +                }
> +                Some(res)
> +            }
> +            _ => None,
> +        })
> +        .unwrap_or_else(|| {
> +            // If we did not find the name of the struct then we will use `Self` as the replacement
> +            // and add a compile error to ensure it does not compile.
> +            errs.extend(
> +                "::core::compile_error!(\"Could not locate type name.\");"
> +                    .parse::<TokenStream>()
> +                    .unwrap(),
> +            );
> +            "Self".parse::<TokenStream>().unwrap().into_iter().collect()
> +        });
> +    let impl_generics = impl_generics
> +        .into_iter()
> +        .flat_map(|tt| replace_self_and_deny_type_defs(&struct_name, tt, &mut errs))
> +        .collect::<Vec<_>>();
> +    let mut rest = rest
> +        .into_iter()
> +        .flat_map(|tt| {
> +            // We ignore top level `struct` tokens, since they would emit a compile error.
> +            if matches!(&tt, TokenTree::Ident(i) if i.to_string() == "struct") {
> +                vec![tt]
> +            } else {
> +                replace_self_and_deny_type_defs(&struct_name, tt, &mut errs)
> +            }
> +        })
> +        .collect::<Vec<_>>();
>      // This should be the body of the struct `{...}`.
>      let last = rest.pop();
> -    quote!(::kernel::__pin_data! {
> +    let mut quoted = quote!(::kernel::__pin_data! {
>          parse_input:
>          @args(#args),
>          @sig(#(#rest)*),
>          @impl_generics(#(#impl_generics)*),
>          @ty_generics(#(#ty_generics)*),
>          @body(#last),
> -    })
> +    });
> +    quoted.extend(errs);
> +    quoted
> +}
> +
> +/// Replaces `Self` with `struct_name` and errors on `enum`, `trait`, `struct` `union` and `impl`
> +/// keywords.
> +///
> +/// The error is appended to `errs` to allow normal parsing to continue.
> +fn replace_self_and_deny_type_defs(
> +    struct_name: &Vec<TokenTree>,
> +    tt: TokenTree,
> +    errs: &mut TokenStream,
> +) -> Vec<TokenTree> {
> +    match tt {
> +        TokenTree::Ident(ref i)
> +            if i.to_string() == "enum"
> +                || i.to_string() == "trait"
> +                || i.to_string() == "struct"
> +                || i.to_string() == "union"
> +                || i.to_string() == "impl" =>
> +        {
> +            errs.extend(
> +                format!(
> +                    "::core::compile_error!(\"Cannot use `{i}` inside of struct definition with \
> +                        `#[pin_data]`.\");"
> +                )
> +                .parse::<TokenStream>()
> +                .unwrap()
> +                .into_iter()
> +                .map(|mut tok| {
> +                    tok.set_span(tt.span());
> +                    tok
> +                }),
> +            );
> +            vec![tt]
> +        }
> +        TokenTree::Ident(i) if i.to_string() == "Self" => struct_name.clone(),
> +        TokenTree::Literal(_) | TokenTree::Punct(_) | TokenTree::Ident(_) => vec![tt],
> +        TokenTree::Group(g) => vec![TokenTree::Group(Group::new(
> +            g.delimiter(),
> +            g.stream()
> +                .into_iter()
> +                .flat_map(|tt| replace_self_and_deny_type_defs(struct_name, tt, errs))
> +                .collect(),
> +        ))],
> +    }
>  }
> --
> 2.40.0
> 
> 

