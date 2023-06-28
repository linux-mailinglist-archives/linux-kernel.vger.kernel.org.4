Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B03D741704
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjF1RMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:12:20 -0400
Received: from mail-cwlgbr01on2123.outbound.protection.outlook.com ([40.107.11.123]:48032
        "EHLO GBR01-CWL-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229541AbjF1RMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:12:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ajd19HRAIIid7JNfqlrT9OELNwXBxm1P4WD0gssKCSrvylWUNZQYBZMYaAFn4qccgq+y72oROdapJ45Jy1as0z4XJbyqjQ5K/Dr15u0CNajah0Yt04ufCe+lBxIiGIHbHY+97EHdFWt20DlmB0eC70KotVT91pteXVYoWop1zWs6nrzh82l6wQNnkR3eiIw589zl8H/PwaXxgRPHDe/BPcHx7Eks5RkqUzD3h6MvFfvSyNyJ5GWA1dCJ9+4LE/ixhX/ZGm1UyiQZMYvAdrWBzEX+zylhty/zCJarhQx3imegKUf3jb1JPZ5zzKi+5HnKtiujUzR0w+M2OVXy2jdtbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aE5/ZG94DBIhy8DPmDlvV2z15lYlwyL0XjRAHvJeOs=;
 b=HV06QivX4qgvsHsIqNM9RGb2GFeQI9A/q+gt1K3VkGiEJwOSki5CCQq6yvM8bZmDGH0F7P5NNta+3yG0WJxCQgFaglbEeZ07Al+S/F+sqFSLPaUFjb24afg83zDAuHifWezW1s3i6hpU1WkjXNKxDVjF2lKEsDVoWSsWKNYfOHQQDnkhNFYzVRSzz2dUly8NWC2r809ec8LqPJCR9wuheuOVoaEU0ujxQb1UDiM3zoCuDUpseJONxRE0tWIM5TgCjkrCUDFGvBWUvmrskoh9I6a/HENYLAjADOOYt8/bieyBMsfiJIL8W1WTsX1EWRqBWyuoxrYwBAF27mEOrkxT0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aE5/ZG94DBIhy8DPmDlvV2z15lYlwyL0XjRAHvJeOs=;
 b=t6pxnffOqVajwQtqylBiiBrWhgQWFmo+LdfMynubE+C65OZoXRwszF/WYhLUKXwcjI2A0soS2U3uzy3aTfq0h61g76HHUGU7b7Wu7PSsHj4ebFiexsogqUUswaPZtl9ofTzkDRVja9M+71B6G84X2HtKmeYp4TdYDyZwnS3jbaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6130.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:247::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 17:12:15 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 17:12:15 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH] rust: macros: add `paste!` proc macro
Date:   Wed, 28 Jun 2023 18:11:01 +0100
Message-Id: <20230628171108.1150742-1-gary@garyguo.net>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::35) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: d0975356-1419-42a9-6831-08db77fad254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HiKXXRAQe+Fin4iLHaFJocA8UoUlhqEyFGOxEboxgluhZSix9ZwJEFcWL7qpkdwC915WpK0FDXXZCYWvUCcLKQ4EN44ta7Bz5pfh3nooaBSNklob2HgU31VuoFLO0uP3YYXObaQpeug/RbL4z1SZR6ZPeqNc0Y9MNbCsOdM5U2hHZreFMaIdj45m0VV1aNSuo3AYw/j6Vf7WKtMwyByS0gNfWjso3u4TfoAnf52rmfgn+lJ0tzCHfLNWyGWyoL48WzmwSKGZerx2i5dCClUej5EEiA5fbPd8Vk4lRKurFWE6oQIDhm6CFHB8I5gpsJqUpBHRHK3jV/anipHqRn+YeHmN+0t5ClXWbPcrwJWrO4JjYh1Ojhq4jrMn8EApisDfUNKPWRmip3NqUUVVRP7EtU+irZYGf1Mkw9n2Tc5gaimtdf+L5yoyiPy/6N/0CIrAqCRw1iVqnhaKeN/r+bODbLxcm0L1PMUfEKXTZN4EHtO3ivyMbPoV0UrgRH/NIfMGTrkt1yIf+J2gtuSjuTM90x8Q2GVpxst6+aPrHD5zgfxgeN9WPtaAB8Bq38L4Mct8zvqsF6fnXLgste4WocgFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39830400003)(366004)(346002)(396003)(451199021)(1076003)(7416002)(4326008)(66556008)(316002)(66476007)(36756003)(66946007)(8936002)(8676002)(5660300002)(478600001)(110136005)(2906002)(6506007)(26005)(966005)(86362001)(41300700001)(6486002)(6666004)(186003)(38100700002)(6512007)(2616005)(83380400001)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3eSN0oy32QMD66sQuj9TC7+VgCLfzTSq+ZaSGV/BUZMxnK7ZHGeTxhMe43w+?=
 =?us-ascii?Q?IY6fxGA4Tq0LjRsAZZEMVa/jNYLhObc0pGCI8/yNUvc8n3zy9Ekz+r0+rl4U?=
 =?us-ascii?Q?fO4PVJxOAtVTdvpLsR+OjmMRgaNQygEj+v7JuIrvJUk/VQvzqGeLrcX3dctx?=
 =?us-ascii?Q?a8pSayiodhRphy717JWCNkkdtDoKxJaj6ugNtPcDDcsNgIxuIqUzTuLswDeD?=
 =?us-ascii?Q?4CgN2eBZA2W9Iy2HKB+ebFu9Ad/VmYVVuRXCpAMxuBNTqMT01VGvy8fdq5MM?=
 =?us-ascii?Q?Wj6tG/RguKGV8tE0mf+6IE+rhYrU3p5vm4W4/bTjU8dE/4oqWEAdqUlgKu89?=
 =?us-ascii?Q?6Fq37JarQ57eivv4SFLyZQbbAI6Ioctc8AbXLbQacbr+mzLBV9Zyw3UQL9RO?=
 =?us-ascii?Q?EZ3xd8Z5Ch7NXwnQC2q7g61zrobepTBXlonfDDpUlns5niNrssY2SaZR1vxU?=
 =?us-ascii?Q?+JWc95gNzoUHA1+XCnsD0PPBb3CfNJmGaI9XuEUpGcHExdVD9wyEQxWPi+oO?=
 =?us-ascii?Q?MQIbgdY7kn6sl2nwZiJQCE5klSvTX3fcBsHfhNGkb+m0QT3wyiDTYdOfJCFO?=
 =?us-ascii?Q?8jiZTBI1MsbXLCHNX/S+xKBM6dyUtJtQVaSbzhAt/k2pxjWzTJj5/oRYEsTn?=
 =?us-ascii?Q?Zm3GX2+O9GbcWh1Zz5fx7o4atODU7G74098agI0wP+xFy5PDLb1+rrRonKAC?=
 =?us-ascii?Q?k2AelZjXkOm/uyljnOE+nwQQg39i1RZLIVwzBb+1r40N7UuDpuBTrrCZkpq3?=
 =?us-ascii?Q?AVanvLMMkdt3A+GSn3WDBioVVTTYGCyf2Ig+51fET5NdpXqpS0G21xdlYeYU?=
 =?us-ascii?Q?SOM0sUGCpy5HH7nhTTSneZtHD+2Q0V4dMRbwGIZQCMyLza9rTBsxsdldI/If?=
 =?us-ascii?Q?1QeuRdVfl8r5s0dss22A1VcHd7hsqfjkv7JL5QZGmaXPP02Cu7S4Ckgmd5b0?=
 =?us-ascii?Q?tHj1ac7nixAPVnqKNN6fSjXmqV+87RCF04dZ8TIBVj2Q6ll1a5Ha8dPmAn/Y?=
 =?us-ascii?Q?CWTVmP+B2eJrR5f2N3fVueY1yNUUrrU5bhoRG3w3w6zCecbkTHLL1Kp5PHiL?=
 =?us-ascii?Q?cPuYSa0Nsx9opM622ehI2a8eES7zJ/MTY31ztJsi0RRN+UX6paFLg+IKsBP5?=
 =?us-ascii?Q?aI5TxPfRD0/RjXON/zOGvSQuHecB4zqajltDfjnXU4M5I9D5qFGajg00TYiU?=
 =?us-ascii?Q?c8kKJZy0Wa4GnLZw1nD26Hys9ZWVb5luBYvRRGrULpBJ3qg0iYDKd7Q5cWCA?=
 =?us-ascii?Q?3U6CzzdtsYqVSXjh/AXNO+dISfTk1E5VWM892Yey+w44WUED3SKxb5+qyvB+?=
 =?us-ascii?Q?4qWHU90ySX4kek7lHyWdXuk3WCzM+slKiuIhGsX4qHnk4NG11U+JQ1/ZzH/6?=
 =?us-ascii?Q?tz0RHfAz0NWxlkRvxdDyuyRNcdp2HHyvPnN+i352Wn5yO9E27Z5wKgrMb+qr?=
 =?us-ascii?Q?XccT+f4jMlLCWe4PndpotE8NMs4fVRx7T+5LkLGw6DpiGBLSWMr5Q4jrEELD?=
 =?us-ascii?Q?jgfx/G1tM/CBy4suB2KrUtM/HqlLJqOGtUMxyvK/wSasWx1YhXrfPoVBPLrj?=
 =?us-ascii?Q?P2OZ6/Cu2cNdt77s63ar3Ml2jvWENvxzVCUZjYWC?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d0975356-1419-42a9-6831-08db77fad254
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 17:12:15.8731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XxnrJzQj3x9nvkq/fsruuKhy6Tl0WOOYzQlLxSpV4t+TK0pVeQ0xFzzISVGPFW9BqA4HEm3R3763zWbrRrmbsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro provides a flexible way to concatenated identifiers together
and it allows the resulting identifier to be used to declare new items,
which `concat_idents!` does not allow. It also allows identifiers to be
transformed before concatenated.

The `concat_idents!` example

    let x_1 = 42;
    let x_2 = concat_idents!(x, _1);
    assert!(x_1 == x_2);

can be written with `paste!` macro like this:

    let x_1 = 42;
    let x_2 = paste!([<x _1>]);
    assert!(x_1 == x_2);

However `paste!` macro is more flexible because it can be used to create
a new variable:

    let x_1 = 42;
    paste!(let [<x _2>] = [<x _1>];);
    assert!(x_1 == x_2);

While this is not possible with `concat_idents!`.

This macro is similar to the `paste!` crate [1], but this is a fresh
implementation to avoid vendoring large amount of code directly. Also, I
have augmented it to provide a way to specify span of the resulting
token, allowing precise control.

For example, this code is broken because the variable is declared inside
the macro, so Rust macro hygiene rules prevents access from the outside:

    macro_rules! m {
        ($id: ident) => {
            // The resulting token has hygiene of the macro.
            paste!(let [<$id>] = 1;)
        }
    }

    m!(a);
    let _ = a;

In this versionn of `paste!` macro I added a `span` modifier to allow
this:

    macro_rules! m {
        ($id: ident) => {
            // The resulting token has hygiene of `$id`.
            paste!(let [<$id:span>] = 1;)
        }
    }

    m!(a);
    let _ = a;

Link: http://docs.rs/paste/ [1]
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/macros/lib.rs   | 97 ++++++++++++++++++++++++++++++++++++++++++++
 rust/macros/paste.rs | 94 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 191 insertions(+)
 create mode 100644 rust/macros/paste.rs

diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 3fc74cb4ea19..b4bc44c27bd4 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -7,6 +7,7 @@
 mod concat_idents;
 mod helpers;
 mod module;
+mod paste;
 mod pin_data;
 mod pinned_drop;
 mod vtable;
@@ -246,3 +247,99 @@ pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
 pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
     pinned_drop::pinned_drop(args, input)
 }
+
+/// Paste identifiers together.
+///
+/// Within the `paste!` macro, identifiers inside `[<` and `>]` are concatenated together to form a
+/// single identifier.
+///
+/// This is similar to the [`paste`] crate, but with pasting feature limited to identifiers
+/// (literals, lifetimes and documentation strings are not supported). There is a difference in
+/// supported modifiers as well.
+///
+/// # Example
+///
+/// ```ignore
+/// use kernel::macro::paste;
+///
+/// macro_rules! pub_no_prefix {
+///     ($prefix:ident, $($newname:ident),+) => {
+///         paste! {
+///             $(pub(crate) const $newname: u32 = [<$prefix $newname>];)+
+///         }
+///     };
+/// }
+///
+/// pub_no_prefix!(
+///     binder_driver_return_protocol_,
+///     BR_OK,
+///     BR_ERROR,
+///     BR_TRANSACTION,
+///     BR_REPLY,
+///     BR_DEAD_REPLY,
+///     BR_TRANSACTION_COMPLETE,
+///     BR_INCREFS,
+///     BR_ACQUIRE,
+///     BR_RELEASE,
+///     BR_DECREFS,
+///     BR_NOOP,
+///     BR_SPAWN_LOOPER,
+///     BR_DEAD_BINDER,
+///     BR_CLEAR_DEATH_NOTIFICATION_DONE,
+///     BR_FAILED_REPLY
+/// );
+///
+/// assert_eq!(BR_OK, binder_driver_return_protocol_BR_OK);
+/// ```
+///
+/// # Modifiers
+///
+/// For each identifier, it is possible to attach one or multiple modifiers to
+/// it.
+///
+/// Currently supported modifiers are:
+/// * `span`: change the span of concatenated identifier to the span of the specified token. By
+/// default the span of the `[< >]` group is used.
+/// * `lower`: change the identifier to lower case.
+/// * `upper`: change the identifier to upper case.
+///
+/// ```ignore
+/// use kernel::macro::paste;
+///
+/// macro_rules! pub_no_prefix {
+///     ($prefix:ident, $($newname:ident),+) => {
+///         kernel::macros::paste! {
+///             $(pub(crate) const fn [<$newname:lower:span>]: u32 = [<$prefix $newname:span>];)+
+///         }
+///     };
+/// }
+///
+/// pub_no_prefix!(
+///     binder_driver_return_protocol_,
+///     BR_OK,
+///     BR_ERROR,
+///     BR_TRANSACTION,
+///     BR_REPLY,
+///     BR_DEAD_REPLY,
+///     BR_TRANSACTION_COMPLETE,
+///     BR_INCREFS,
+///     BR_ACQUIRE,
+///     BR_RELEASE,
+///     BR_DECREFS,
+///     BR_NOOP,
+///     BR_SPAWN_LOOPER,
+///     BR_DEAD_BINDER,
+///     BR_CLEAR_DEATH_NOTIFICATION_DONE,
+///     BR_FAILED_REPLY
+/// );
+///
+/// assert_eq!(br_ok(), binder_driver_return_protocol_BR_OK);
+/// ```
+///
+/// [`paste`]: https://docs.rs/paste/
+#[proc_macro]
+pub fn paste(input: TokenStream) -> TokenStream {
+    let mut tokens = input.into_iter().collect();
+    paste::expand(&mut tokens);
+    tokens.into_iter().collect()
+}
diff --git a/rust/macros/paste.rs b/rust/macros/paste.rs
new file mode 100644
index 000000000000..42fde0930b05
--- /dev/null
+++ b/rust/macros/paste.rs
@@ -0,0 +1,94 @@
+use proc_macro::{Delimiter, Group, Ident, Spacing, Span, TokenTree};
+
+fn concat(tokens: &[TokenTree], group_span: Span) -> TokenTree {
+    let mut tokens = tokens.iter();
+    let mut segments = Vec::new();
+    let mut span = None;
+    loop {
+        match tokens.next() {
+            None => break,
+            Some(TokenTree::Literal(lit)) => segments.push((lit.to_string(), lit.span())),
+            Some(TokenTree::Ident(ident)) => {
+                let mut value = ident.to_string();
+                if value.starts_with("r#") {
+                    value.replace_range(0..2, "");
+                }
+                segments.push((value, ident.span()));
+            }
+            Some(TokenTree::Punct(p)) if p.as_char() == ':' => {
+                let Some(TokenTree::Ident(ident)) = tokens.next() else {
+                    panic!("expected identifier as modifier");
+                };
+
+                let (mut value, sp) = segments.pop().expect("expected identifier before modifier");
+                match ident.to_string().as_str() {
+                    // Set the overall span of concatenated token as current span
+                    "span" => {
+                        assert!(
+                            span.is_none(),
+                            "span modifier should only appear at most once"
+                        );
+                        span = Some(sp);
+                    }
+                    "lower" => value = value.to_lowercase(),
+                    "upper" => value = value.to_uppercase(),
+                    v => panic!("unknown modifier `{v}`"),
+                };
+                segments.push((value, sp));
+            }
+            _ => panic!("unexpected token in paste segments"),
+        };
+    }
+
+    let pasted: String = segments.into_iter().map(|x| x.0).collect();
+    TokenTree::Ident(Ident::new(&pasted, span.unwrap_or(group_span)))
+}
+
+pub(crate) fn expand(tokens: &mut Vec<TokenTree>) {
+    for token in tokens.iter_mut() {
+        if let TokenTree::Group(group) = token {
+            let delimiter = group.delimiter();
+            let span = group.span();
+            let mut stream: Vec<_> = group.stream().into_iter().collect();
+            // Find groups that looks like `[< A B C D >]`
+            if delimiter == Delimiter::Bracket
+                && stream.len() >= 3
+                && matches!(&stream[0], TokenTree::Punct(p) if p.as_char() == '<')
+                && matches!(&stream[stream.len() - 1], TokenTree::Punct(p) if p.as_char() == '>')
+            {
+                // Replace the group with concatenated token
+                *token = concat(&stream[1..stream.len() - 1], span);
+            } else {
+                // Recursively expand tokens inside the group
+                expand(&mut stream);
+                let mut group = Group::new(delimiter, stream.into_iter().collect());
+                group.set_span(span);
+                *token = TokenTree::Group(group);
+            }
+        }
+    }
+
+    // Path segments cannot contain invisible delimiter group, so remove them if any.
+    for i in (0..tokens.len().saturating_sub(3)).rev() {
+        // Looking for a double colon
+        if matches!(
+            (&tokens[i + 1], &tokens[i + 2]),
+            (TokenTree::Punct(a), TokenTree::Punct(b))
+                if a.as_char() == ':' && a.spacing() == Spacing::Joint && b.as_char() == ':'
+        ) {
+            match &tokens[i + 3] {
+                TokenTree::Group(group) if group.delimiter() == Delimiter::None => {
+                    tokens.splice(i + 3..i + 4, group.stream());
+                }
+                _ => (),
+            }
+
+            match &tokens[i] {
+                TokenTree::Group(group) if group.delimiter() == Delimiter::None => {
+                    tokens.splice(i..i + 1, group.stream());
+                }
+                _ => (),
+            }
+        }
+    }
+}
-- 
2.34.1

