Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA3C6D0617
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjC3NMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjC3NMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:12:20 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2117.outbound.protection.outlook.com [40.107.11.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABED8A52;
        Thu, 30 Mar 2023 06:12:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+DO4IVEXKwUC5aTt7ZyIHmIM3ujwVWRwXsHqVh3G495tW0cJcrWrRvPm9dZvAFkHmN7Xz4YQ6Nxsh1k42+96D0MhV7FuSRBvArqfwmb0ZJrPh8Iu3yaW9DV1hHOYFvPfIDYZpdPl4wTToD/pkzCCt06fht/wQkqfMserTN2yqeymF2aleeq740RUm6J/crwHixj7mZSl4TQljJeW5Qd7ZxWuyoYDqTeYSFyrUJeYnbL6pFlM5dd6zWv/zw5LpODGrSJnwwU0PTmgK6in7nm0paalUYQj1B4TnE6Y6V7/X/Vf+wKSCENJlFEqC38BiF4mu4xrzaLJKH2JvbbFTvShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDmbHx9nMFKvqLWtDIhPn9iXjpJUtmra1+iXb848A+U=;
 b=HgComkvBK0a71RFUGmM6nhQVaf0NSxv7tFkjPRpfpj1awWOreJeJnW9cod6TWKPZ0s+Gn49/jmAqqYDaJztp1wrzaeKNdJkmlxOyFFC7Tq3ymEdTiiCG9+XTeLv04WPXVoR+5N7JlA2l3vRUNn68RTwXiJPqJfjwJp6fCuO5kuP9YGvgc5O7otjrlFHSejmYqNqYAED81aZprDoYh05emVwJqcriDKNwv+ArsUd5y6B7r5BdAit7OtBRXkD6r3C6eTJcexedTckWwpUnVnmXSW6J/wF+gb4O355UklmRkfULt6/Rrw6h7h4M4rbZagXaBQhuJ0srLqgNNFDWhILmFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDmbHx9nMFKvqLWtDIhPn9iXjpJUtmra1+iXb848A+U=;
 b=zWjAzQNwQZGCk0RxMHs0uXInWlcMfP8BsIwrApzL9Q3nVeo+EfKfujfcii/9dDmRiK7viAtWwuL0TxPIKPacrk9d6kvr8S9ozwFNCZj7nwuAm0ZrEYGqEHa/ZXapIpycMTbQqt3uGM3h5213VwHBElobVE7EvJsU1UyhLdutVQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB1764.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:50::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 13:12:12 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 13:12:12 +0000
Date:   Thu, 30 Mar 2023 14:11:34 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     y86-dev@protonmail.com, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 01/13] rust: macros: add `quote!` macro
Message-ID: <20230330141134.6d13090d.gary@garyguo.net>
In-Reply-To: <877cuy5ur2.fsf@metaspace.dk>
References: <20230329223239.138757-1-y86-dev@protonmail.com>
        <20230329223239.138757-2-y86-dev@protonmail.com>
        <877cuy5ur2.fsf@metaspace.dk>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0609.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB1764:EE_
X-MS-Office365-Filtering-Correlation-Id: 88601aaa-56dc-4059-2720-08db31205fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFSHT5TzT1awJ4YFv0+jSETCadHAfKL7trvRJD6cuci0KyZXo9+z+oaAC85nnjG/OAW+vEhjn8fFPNkeTl/2KH1MkFQaCjH5RdpbVVquWMFzUGbv70sIKHptyv6rr42ApXy28UZHSug0JyAd9bJ6c5lr/tEhJ/jjuEoWqQ+yyIiz5scG86FbivS82Mpz78IwEoMP/qtt5MTGXt81l9g3FGRQgwm4bj5MZnHd5YghJtmDE+Cqqq1hsjJT6NEQ/KwiaKBFnVZncT5bbMA4nNN6fKAK/w40NXbspsQN2xxn2ucvjkVvrxExpI5+7OtcRGjSvG4XzFTVCG5DWtJgMcIHSyOr3eIYHN+Unep7IZtsm/XG/gM7DbN2Fuu9SR2SJIQnH0BOo29IKIDniE17o9u44BxGDMOdx726VaUkbZk8/84LBe6RKy7mz1RfWzPOSvYu/WkKD1+HH0gz8e+sTGQbkKhokicDiPNy/qfQwIC0MYp7+v3OeMxhvDfR2y2P/HtSaAYbvr90oy0Npa8vqAb+J1Hbstgl4CNx6BmFvUNrX10plJyNWoZFdCjfSeoxNEWAYdAZPQwfWOnteSfhgvfFfR4rNgoaK3j8JqFwA0pZ4Ho=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(136003)(396003)(376002)(366004)(346002)(451199021)(2616005)(36756003)(86362001)(2906002)(6486002)(478600001)(186003)(6506007)(1076003)(6666004)(26005)(6512007)(66556008)(66476007)(6916009)(66946007)(316002)(8676002)(8936002)(7416002)(41300700001)(4326008)(38100700002)(54906003)(5660300002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RDXf3vmCxjkxuEZZqpzKlmT0ulZP3vB29X1aVnATizFcI6ZuVsaccKRtpLP/?=
 =?us-ascii?Q?GAd6kw2i8nSWHjxiRd7CiNIuzIJFcsKoSnp3OXw7bnCD7S23F+d5jwpCsLiN?=
 =?us-ascii?Q?vs7pLe6tqyELi4VyWwOghiXk9Fpsgo4B1XLFuOyQjY+wJJOjN9cl4FNI06NM?=
 =?us-ascii?Q?dchLnczqI7RPDylpaP++blTlIN1+oVQt3J47GRkxSHVcYs0Z93nSRrAYOatG?=
 =?us-ascii?Q?5aB8eVlXs+OMLMVJ3LLm39V909I9ASAw5CXzPDmDfmEMziCv9pt2pHR65Csv?=
 =?us-ascii?Q?w6BXqfIIakc0MhFXMj9PKmCDAHs0qs0WR4CKK27pu5UZNuuTIjCcA74/cKgL?=
 =?us-ascii?Q?cDcCMliQALGftnou+TuDp2T9SX9/ph9il6juhRuAVHH/vKfWiJR7/xCrFzRt?=
 =?us-ascii?Q?/Jr1ZjsjB2+U1cZM41tooDd5Qpo4Sfdf+dR/Tg7oEzvyaivnoCle9FIAsip2?=
 =?us-ascii?Q?1oljCohSZIl5l8mNQGBcErAdG4lFIxKpqcBYZ4/S1kAbLzNrVs0TeVZhfttF?=
 =?us-ascii?Q?VdV0PmE1stPcbrIMUdGUDnTiBG2G5KfwkTnpbchSI6jjuN6NfwmoYVpYb95p?=
 =?us-ascii?Q?/swqe832S4l+bVtIceM/fPMUSTgCCSfJtUGQPHT8oUonKP1FLqjDJgE/kiiA?=
 =?us-ascii?Q?St+sTyVqcaBBlw3IdqOaelU9IApA3/O5ui2AluvlXhcMsoMOO1JzJjDTiKnp?=
 =?us-ascii?Q?/200LZ0G7dXztjzfn6qrkkRDJp1lwziAllQdlZ6Fvdh2HF92jI5lZBrZx6x/?=
 =?us-ascii?Q?ZfvpAY4MvW2x5wPbid++PC/sEjigkXB84gwU5jhgBv9wTolnJvYHS/4uVyZ/?=
 =?us-ascii?Q?NnGHAAhCfT8GdtWPjMPFNdwBcXcyfloezbf0LSDFklXkE6I423MoYreCjFVx?=
 =?us-ascii?Q?Y3xPw6pa5bySokIyGc/GFbtJIEW/YvWSnulBQ5U3Djb3hkAJQ3DUtqz2nB1Y?=
 =?us-ascii?Q?32UpSvf8pjUngfYN2rYhYarw0K2KoijFaVGYjPsqCCqI8iyQSoAYPg84gZNe?=
 =?us-ascii?Q?JWm9k/+TyeRy5sWKjN/wLQfBLxNYZfyHse8GkKBPBx/NCfDMkYSlDEVWLuwm?=
 =?us-ascii?Q?ZexeVg3Za7Ggkh17BgIrOLxlZCVitdRfwWluqCR9yFzdvfRCxdC86wOSElrK?=
 =?us-ascii?Q?EJEay7R9gwa7hLvx5BfGDHwmeX7fcm4XkjCTy8/5oGdQ1p/oUhMsM/Q30k2y?=
 =?us-ascii?Q?R6NlZHneI7pzM0tM+h05UUt2edE+9RhoW1yabUbYG3My3g9/WpwDXZHHKG6M?=
 =?us-ascii?Q?vjJnd/d/VfzFqyxAaHa5pQbm3K4sE++JaW/KxLwOLRNeECyDpStlbrO3r9Jg?=
 =?us-ascii?Q?B3pwCiyKVOc7Bs95NKnZ1Eg2PTr416CksSYipXeVOdkbbdyCcHOUgi1rHgfk?=
 =?us-ascii?Q?dM/a3IaiklG13Ar5ham7GRKUdwx4Co4TGVRrB9su3L0mhVGZ12Qo9rmPhdmb?=
 =?us-ascii?Q?m9jODhJgqs4tkfaBNinfp0buOnHkyax7IPw1uqqAddgDHZkGYlCF43+gcmAo?=
 =?us-ascii?Q?rrQa+QXX8ezbTviM1zbxKxTG9T0ViescLiipJWKm9v7+lwuyZUgpVzQtWdfo?=
 =?us-ascii?Q?n4TX39VrwhyeZuoyK3wvo3+82MN0sXFpehC3IVlW?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 88601aaa-56dc-4059-2720-08db31205fdf
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:12:12.1595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJ7XgMjt5GMr+TFo30adYp2S6xAI/7+KKn2dW6lvps0eSB+qFcWSrmW61cyaWxW0RCt/DNaDiK0gIIw0P/YTEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB1764
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023 13:42:29 +0200
Andreas Hindborg <nmi@metaspace.dk> wrote:

> y86-dev@protonmail.com writes:
> 
> > From: Gary Guo <gary@garyguo.net>
> >
> > Add the `quote!` macro for creating `TokenStream`s directly via the
> > given Rust tokens. It also supports repetitions using iterators.
> >
> > It will be used by the pin-init API proc-macros to generate code.
> >
> > Signed-off-by: Gary Guo <gary@garyguo.net>
> > Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> > ---
> >  rust/macros/lib.rs   |   2 +
> >  rust/macros/quote.rs | 145 +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 147 insertions(+)
> >  create mode 100644 rust/macros/quote.rs
> >
> > diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> > index c1d385e345b9..82b520f024dd 100644
> > --- a/rust/macros/lib.rs
> > +++ b/rust/macros/lib.rs
> > @@ -2,6 +2,8 @@
> >
> >  //! Crate for all kernel procedural macros.
> >
> > +#[macro_use]
> > +mod quote;
> >  mod concat_idents;
> >  mod helpers;
> >  mod module;
> > diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
> > new file mode 100644
> > index 000000000000..7efb009c25a9
> > --- /dev/null
> > +++ b/rust/macros/quote.rs
> > @@ -0,0 +1,145 @@
> > +// SPDX-License-Identifier: Apache-2.0 OR MIT
> > +
> > +use proc_macro::{TokenStream, TokenTree};
> > +
> > +pub(crate) trait ToTokens {
> > +    fn to_tokens(&self, tokens: &mut TokenStream);
> > +}
> > +
> > +impl<T: ToTokens> ToTokens for Option<T> {
> > +    fn to_tokens(&self, tokens: &mut TokenStream) {
> > +        if let Some(v) = self {
> > +            v.to_tokens(tokens);
> > +        }
> > +    }
> > +}
> > +
> > +impl ToTokens for proc_macro::Group {
> > +    fn to_tokens(&self, tokens: &mut TokenStream) {
> > +        tokens.extend([TokenTree::from(self.clone())]);
> > +    }
> > +}
> > +
> > +impl ToTokens for TokenTree {
> > +    fn to_tokens(&self, tokens: &mut TokenStream) {
> > +        tokens.extend([self.clone()]);
> > +    }
> > +}
> > +
> > +impl ToTokens for TokenStream {
> > +    fn to_tokens(&self, tokens: &mut TokenStream) {
> > +        tokens.extend(self.clone());
> > +    }
> > +}
> > +
> > +/// Converts tokens into [`proc_macro::TokenStream`] and performs variable interpolations with
> > +/// the given span.
> > +///
> > +/// This is a similar to the
> > +/// [`quote_spanned!`](https://docs.rs/quote/latest/quote/macro.quote_spanned.html) macro from the
> > +/// `quote` crate but provides only just enough functionality needed by the current `macros` crate.
> > +#[allow(unused_macros)]
> > +macro_rules! quote_spanned {
> > +    ($span:expr => $($tt:tt)*) => {
> > +    #[allow(clippy::vec_init_then_push)]
> > +    {
> > +        let mut tokens = Vec::new();
> > +        let span = $span;
> > +        quote_spanned!(@proc tokens span $($tt)*);
> > +        proc_macro::TokenStream::from_iter(tokens)  
> 
> Should this be `::alloc::vec::Vec` and
> `::proc_macro::TokenStream::from_iter` ?
> 
> Best regards,
> Andreas

Hi Andres,

This macro is used only internally, so I didn't really bother to fully
qualify all the names.

Best,
Gary
