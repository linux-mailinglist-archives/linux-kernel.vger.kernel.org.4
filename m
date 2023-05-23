Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFE370E16C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbjEWQEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbjEWQEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:04:12 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2115.outbound.protection.outlook.com [40.107.11.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A84DD;
        Tue, 23 May 2023 09:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LytUgFTMS47YVh+E/QB9V7sXDpHnDX7CleL1cHIuEkjRgWONPeeJvfQlfUIiJxo8EAm2rFFex1AO20Oku7whRYvM5KSjxZ7EoFNs+nE7ftbelBRdHTVYWqsqav+sq0pjW+9h54B1LLhHA9kOW+4AZwMinRKwYBPo2Sf8UGZB8eviejNZss2ZxL2uL3sUjgfeMVCRet4aY4sNeF7R1+58fCkkjCD7Gly7duDfFA/nGpv5t+f1YDRD9mlwqnEfvatseDUYu33nMn3jrqgRZbubEecOpdc57uHEvb956a66nAQPSWaAcV7AKmY9yTUEttQaFYyFD/tfQ/lYJBTg062eAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=us9RPz3y5jAh6TrAUiMrMoeIqqAtFavbPtn/WKR8eAc=;
 b=coCzZjGTrWXsI3l9sg2RUpCWvKeNybOxvtuHPVq8hXq5Xs31XuDWvSwPDanCBAKLlo9R8voA4pmBy5Bj1K+B/e9zk0qxm2xP+m6JXxJrN7elRNA4T1BsTnfNlzXgf8QLwgv8iGzBlz5LZENYp0C29dPqSf8WmKwTHmEpuNiV+wsJBRkghUNNT8ypajWeUA/PaFlvIZi2G6bQBo0o/knNl/R1PXv+knw/dkHmiABzFqRkbFwhSl2OoqCoy+FA2bn6SIGDYOK8h4cLV9vsdEcTQofxZMhFMUtuTnwbb6bYObvns9pb87Jwhs3sbO543bE88i1Kurf7AeYm3yM76cHkgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=us9RPz3y5jAh6TrAUiMrMoeIqqAtFavbPtn/WKR8eAc=;
 b=oF+uNp0bsLF2HshQiCR96+TfjBvZwsi7WMehPMM9x9r6BVTSK5hRuR0uV+meEcozIGiloHJnD0/ov9DDdupMumpo3OoXM5FXkKM7PY43OEdArlMdjpx7DvTXLoWgNROuVxXXIRV4YDTZWM3jM6stPdf9spbOA1hd67n5n46XSok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB5083.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:194::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Tue, 23 May
 2023 16:04:07 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf%4]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 16:04:07 +0000
Date:   Tue, 23 May 2023 17:04:05 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 2/4] rust: macros: refactor generics parsing of
 `#[pin_data]` into its own function
Message-ID: <20230523170405.3c229965.gary@garyguo.net>
In-Reply-To: <20230424081112.99890-2-benno.lossin@proton.me>
References: <20230424081112.99890-1-benno.lossin@proton.me>
        <20230424081112.99890-2-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e11980-7c6d-44ef-1d98-08db5ba75693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kEay4Up916YoCCdwInl7B45lg2QQPN3GIFqQZdRWaISDMSgLDMndHzp4pHpPLwTjAPVr3K2kYh++9XpgiS84YsrfoD/M61zp0ow4fsfRcAIWsN/jUDcIpeUsJx08crfJvcP37+91jNlDxCQFgyv6LF+YIqMqQboTGGCH8GhHGZyGTEuwdbzVhWru5mD4EQX12NtQkfa2FxDzSil0hF2n84TjeVfubD/gjFs3xTtse/vjv1iA75xG2AaIHklB9j4mOG9nevgAiooaxorMrxpGzXys3hGtWsJdQjhyL5OO++fzlufgMFf7v1o9Dwh+TJTErPiaPwwBO/TSeAA++tA2BanBWlRI2OdgJWQIUXPPAmAiPQ8LGNEcmIj48/qG4nulpCsx0/4HDjUtYy/PlsR8+F6wa0IpPXPyCPxIbXcBNFcsX2XPtKI9FMFuPWUZiF9dNPLSfkTJ51J7zCGpqh4ic+g9s+eoFpIQSMpaZkU90AaLmMgwpU4KgTaamIQjlN0ywr9c4Fld6qr80u7Y2M3nuu7CXEu/Epaxag71QJpm1nSo29z5Bd6Ppxt4MX32tF+u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(136003)(366004)(346002)(376002)(396003)(451199021)(86362001)(54906003)(316002)(41300700001)(66946007)(4326008)(66556008)(66476007)(6916009)(478600001)(6486002)(38100700002)(8676002)(8936002)(5660300002)(83380400001)(2616005)(36756003)(26005)(6512007)(2906002)(186003)(1076003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9SNL3vyFNMYkeIE/17OsNtN+vz75kAKcldE4BMMGkHzENKV8dZvdql5LsJVr?=
 =?us-ascii?Q?WoJKvyZK/FE+Asu3Eiu70+jezSsgzUgN1XR1F5Zjr0YPYf9VjTj6zbvVXq8Q?=
 =?us-ascii?Q?Ea1HKSCENjTDynbvJvlStNXhbUuzVG3GqLlTq5SPm9MROofW6iPbvxD/aTZ/?=
 =?us-ascii?Q?Ddn9R/SwEoejdKkBXKDawPGgTfozNHX0BRSFg/uL7QgMJndRh+WCj5IRUiLa?=
 =?us-ascii?Q?79TaNlUNc5NB/UhNx1CeeSK5cEAwLy13elRneWBDZz/dYDhadx3f3SiZCHpH?=
 =?us-ascii?Q?hoMcjcvs2G/BubwvZqCdesyFuGNNIuHyFCCHIhlVIAYLUlMAO0AeLMiT4G/l?=
 =?us-ascii?Q?r7+hsgzX6De+xBmhsmU5mrkk5EJn1u1R21MUU0SoLNHt/Q+nO54Pz6vgPGda?=
 =?us-ascii?Q?4M/7OWG0GYuoyoDasIXViSV/e77EzxUvbIg3bkZr2oIsMHUtR8Jks8UVHlH8?=
 =?us-ascii?Q?anbCIK+0x9/FboCsRBdCN3FaURxdkZNSZT36cbdgeqyAZ+tHFzUwTN/+7I/U?=
 =?us-ascii?Q?tMSFUvniIz37o7+jid+Lpvgfh16K7sQ1ZfeQqsbpDGPwBuQyYHq7DNCjnUgH?=
 =?us-ascii?Q?y7670ty12PZw1qUNGFgpxXr/qEH04qetRypYYMramnTxtYqkcSzcQBwdehCp?=
 =?us-ascii?Q?lvGcZNahqTxQywJeQMXgU+sllNDcuqDvGo6tEsrelUcyuew4v76vnLulDMlg?=
 =?us-ascii?Q?U3io/D9y8ovDCzeHE8YcZJIfdiwmMhBvNNf3sdKriDiZpqrgtjEj46i2kO1V?=
 =?us-ascii?Q?lXbXgx9GDDSd2j5CV7na0IT8HWHPP6CpCjfOdhZdLiQvpYTKwN3TJhqEbWkZ?=
 =?us-ascii?Q?VQSp8fvCKIORBVIK9sZNdsPovvhd47c7mHi0qY7xmD600q1VFQWif08SPzjj?=
 =?us-ascii?Q?FzXNyBHscDBqdtLmPQRVhVjz2CmX0cqnSrA/eP/mV5AHMPCZmw3WnqemXsGQ?=
 =?us-ascii?Q?bQFoyPqjBXYYBOB7AxRlY57O+tbNhJhuAkrbAKASQZKwxZujWZL4bBN1vClC?=
 =?us-ascii?Q?UnVV65o/SfOztTmJH/0FMeqegLnS9YRaFa0V5qekZqJFwoDYdUWEB+Oj26Zu?=
 =?us-ascii?Q?KJ0rOsaRuqrQ4WAOIGf1GTJ1zzNXQn2vnA8Itm7J4cOErQUWqXhl/AcmhT90?=
 =?us-ascii?Q?OO+d2ExUvtgAhSN77jWhvRsPrVH00VPX6gXYNQtoipEjgT/Or1nIOneGowAR?=
 =?us-ascii?Q?Tf3/UBzTdi7g4j71EpQXjrpbBoaTCgNrHeRldmsfkR3+LVERzHk4ZW6qjd48?=
 =?us-ascii?Q?2m6/N1M5QPQwWm2WRHKXbYhS11Z7SP6CTDu+L7IVzLb+5rDdApKe09jGmN+Z?=
 =?us-ascii?Q?ZzL47qGaCEoA+Kj2DwqU6TFIlrNQMdQ3o1xLCT17RZT78vL+neq9NcR+nvj3?=
 =?us-ascii?Q?f2fV0TBhVh9zh6Cg+tz/YeovXZKSN6IeZqbmlz5auX4lDe1SnmI4o8jHHwTI?=
 =?us-ascii?Q?PyxewjTSyxUwmNUwcLXl39N87O4ygX5BNqrKBFGg79AzxeBuVSM1n32NImN5?=
 =?us-ascii?Q?cWWlMUBg1O41OF5HXX/D+fJpIU97IbBtkzTmmPH7Sg+Z4DVwTgt1uKFv6CvW?=
 =?us-ascii?Q?eTEgd1QYIuauqpHLFMafqbanuSJ/sNmt0rFR1yum?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e11980-7c6d-44ef-1d98-08db5ba75693
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 16:04:07.4825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FKcolfJzS7HVenLy8L1pf1oPLZHOzxAUcRgOfMr2NXGDoO9+awaE7mmib4haoMsOSq0VHqQMqUyDrNsLbukWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 08:11:38 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> Other macros might also want to parse generics. Additionally this makes
> the code easier to read, as the next commit will introduce more code in
> `#[pin_data]`. Also add more comments to explain how parsing generics
> work.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/macros/helpers.rs  | 86 ++++++++++++++++++++++++++++++++++++++++-
>  rust/macros/pin_data.rs | 70 +++++----------------------------
>  2 files changed, 94 insertions(+), 62 deletions(-)
> 
> diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
> index b2bdd4d8c958..afb0f2e3a36a 100644
> --- a/rust/macros/helpers.rs
> +++ b/rust/macros/helpers.rs
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
> 
> -use proc_macro::{token_stream, Group, TokenTree};
> +use proc_macro::{token_stream, Group, Punct, Spacing, TokenStream, TokenTree};
> 
>  pub(crate) fn try_ident(it: &mut token_stream::IntoIter) -> Option<String> {
>      if let Some(TokenTree::Ident(ident)) = it.next() {
> @@ -69,3 +69,87 @@ pub(crate) fn expect_end(it: &mut token_stream::IntoIter) {
>          panic!("Expected end");
>      }
>  }
> +
> +pub(crate) struct Generics {
> +    pub(crate) impl_generics: Vec<TokenTree>,
> +    pub(crate) ty_generics: Vec<TokenTree>,
> +}
> +
> +/// Parses the given `TokenStream` into `Generics` and the rest.
> +///
> +/// The generics are not present in the rest, but a where clause might remain.
> +pub(crate) fn parse_generics(input: TokenStream) -> (Generics, Vec<TokenTree>) {
> +    // `impl_generics`, the declared generics with their bounds.
> +    let mut impl_generics = vec![];
> +    // Only the names of the generics, without any bounds.
> +    let mut ty_generics = vec![];
> +    // Tokens not related to the generics e.g. the `where` token and definition.
> +    let mut rest = vec![];
> +    // The current level of `<`.
> +    let mut nesting = 0;
> +    let mut toks = input.into_iter();
> +    // If we are at the beginning of a generic parameter.
> +    let mut at_start = true;
> +    for tt in &mut toks {
> +        match tt.clone() {
> +            TokenTree::Punct(p) if p.as_char() == '<' => {
> +                if nesting >= 1 {
> +                    // This is inside of the generics and part of some bound.
> +                    impl_generics.push(tt);
> +                }
> +                nesting += 1;
> +            }
> +            TokenTree::Punct(p) if p.as_char() == '>' => {
> +                // This is a parsing error, so we just end it here.
> +                if nesting == 0 {
> +                    break;
> +                } else {
> +                    nesting -= 1;
> +                    if nesting >= 1 {
> +                        // We are still inside of the generics and part of some bound.
> +                        impl_generics.push(tt);
> +                    }
> +                    if nesting == 0 {
> +                        break;
> +                    }
> +                }
> +            }
> +            tt => {
> +                if nesting == 1 {
> +                    // Here depending on the token, it might be a generic variable name.
> +                    match &tt {
> +                        // Ignore const.
> +                        TokenTree::Ident(i) if i.to_string() == "const" => {}
> +                        TokenTree::Ident(_) if at_start => {
> +                            ty_generics.push(tt.clone());
> +                            // We also already push the `,` token, this makes it easier to append
> +                            // generics.
> +                            ty_generics.push(TokenTree::Punct(Punct::new(',', Spacing::Alone)));
> +                            at_start = false;
> +                        }
> +                        TokenTree::Punct(p) if p.as_char() == ',' => at_start = true,
> +                        // Lifetimes begin with `'`.
> +                        TokenTree::Punct(p) if p.as_char() == '\'' && at_start => {
> +                            ty_generics.push(tt.clone());
> +                        }
> +                        _ => {}
> +                    }
> +                }
> +                if nesting >= 1 {
> +                    impl_generics.push(tt);
> +                } else if nesting == 0 {
> +                    // If we haven't entered the generics yet, we still want to keep these tokens.
> +                    rest.push(tt);
> +                }
> +            }
> +        }
> +    }
> +    rest.extend(toks);
> +    (
> +        Generics {
> +            impl_generics,
> +            ty_generics,
> +        },
> +        rest,
> +    )
> +}
> diff --git a/rust/macros/pin_data.rs b/rust/macros/pin_data.rs
> index 954149d77181..c593b05d9e8c 100644
> --- a/rust/macros/pin_data.rs
> +++ b/rust/macros/pin_data.rs
> @@ -1,71 +1,19 @@
>  // SPDX-License-Identifier: Apache-2.0 OR MIT
> 
> -use proc_macro::{Punct, Spacing, TokenStream, TokenTree};
> +use crate::helpers::{parse_generics, Generics};
> +use proc_macro::TokenStream;
> 
>  pub(crate) fn pin_data(args: TokenStream, input: TokenStream) -> TokenStream {
>      // This proc-macro only does some pre-parsing and then delegates the actual parsing to
>      // `kernel::__pin_data!`.
> -    //
> -    // In here we only collect the generics, since parsing them in declarative macros is very
> -    // elaborate. We also do not need to analyse their structure, we only need to collect them.
> 
> -    // `impl_generics`, the declared generics with their bounds.
> -    let mut impl_generics = vec![];
> -    // Only the names of the generics, without any bounds.
> -    let mut ty_generics = vec![];
> -    // Tokens not related to the generics e.g. the `impl` token.
> -    let mut rest = vec![];
> -    // The current level of `<`.
> -    let mut nesting = 0;
> -    let mut toks = input.into_iter();
> -    // If we are at the beginning of a generic parameter.
> -    let mut at_start = true;
> -    for tt in &mut toks {
> -        match tt.clone() {
> -            TokenTree::Punct(p) if p.as_char() == '<' => {
> -                if nesting >= 1 {
> -                    impl_generics.push(tt);
> -                }
> -                nesting += 1;
> -            }
> -            TokenTree::Punct(p) if p.as_char() == '>' => {
> -                if nesting == 0 {
> -                    break;
> -                } else {
> -                    nesting -= 1;
> -                    if nesting >= 1 {
> -                        impl_generics.push(tt);
> -                    }
> -                    if nesting == 0 {
> -                        break;
> -                    }
> -                }
> -            }
> -            tt => {
> -                if nesting == 1 {
> -                    match &tt {
> -                        TokenTree::Ident(i) if i.to_string() == "const" => {}
> -                        TokenTree::Ident(_) if at_start => {
> -                            ty_generics.push(tt.clone());
> -                            ty_generics.push(TokenTree::Punct(Punct::new(',', Spacing::Alone)));
> -                            at_start = false;
> -                        }
> -                        TokenTree::Punct(p) if p.as_char() == ',' => at_start = true,
> -                        TokenTree::Punct(p) if p.as_char() == '\'' && at_start => {
> -                            ty_generics.push(tt.clone());
> -                        }
> -                        _ => {}
> -                    }
> -                }
> -                if nesting >= 1 {
> -                    impl_generics.push(tt);
> -                } else if nesting == 0 {
> -                    rest.push(tt);
> -                }
> -            }
> -        }
> -    }
> -    rest.extend(toks);
> +    let (
> +        Generics {
> +            impl_generics,
> +            ty_generics,
> +        },
> +        mut rest,
> +    ) = parse_generics(input);
>      // This should be the body of the struct `{...}`.
>      let last = rest.pop();
>      quote!(::kernel::__pin_data! {
> --
> 2.40.0
> 
> 

