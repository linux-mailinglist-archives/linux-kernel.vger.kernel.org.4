Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D091173D42E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 22:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjFYUqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 16:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjFYUqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 16:46:48 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2118.outbound.protection.outlook.com [40.107.11.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9797113;
        Sun, 25 Jun 2023 13:46:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqbAZ755DNzGVItyl3A9a5WVuO+HXBQd4FVZE5aZ2YxG3n0W7/t7gkSYGrD2beRKSBwwEjWhlO17Twftf0HSVW6HZ3GHg3Ww6ozzJx7ne6mDNfcVnHg+XkUHbPx6+/BkqBXMNhuVLOXWigePKJ/P5RuOZoKHKk6aM8cJb45rJTHOWD+5d47ObN0On2NKCw5u+ZgIByKvXsOhST5qIIRZuuiryc9/EKVxl1Fg7Ek94qFN7yhjk3xJXWXq/gHAYSP1PBuXyXTQNqZOnX5ihT5e7S96LNZore9dw2Mn1/G0vigkzRWEOZDWIC/QLs8RcsMxFwR7Ma5ySIN02BxbQvpsQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYSjce05f6pUFb+SXkbuw7/LOb8HcLqI/h6nePF5C3U=;
 b=QTWZf41V2BKKWyMUjicEjs5lM1IY9UQXGAWNReF7cfx+Wu0VYBQV1n63XJFMWvxMkpwrly4Q0rRt8O9ARywNnyGGmW/OnUjNyRNBrGuwHgnCbYXl+eTvHVhVjp67lzTTtK15D/VEJVrevaL4YWZa5Wl9xXKLLaow/ScIfX9ZsRgDb+bRx3X+9iE9nu5mv/Yq0A7r9XSZ0umBoRAJ9zPhKzs97dME81KQzat8/+h/V/Rzt7OYa8/6qrNNX7Hs75U+Ke6PUY/MptJEzp41zWDnbXxeGOlNvxIhqVNciTdTGVBwAd+9C/MmLTCxaMmL2sUzUO08/fcw58t9TUSlU+PFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYSjce05f6pUFb+SXkbuw7/LOb8HcLqI/h6nePF5C3U=;
 b=GTsUkbylcHCknlhvkhc87kmq8Zo6K75HhflD8q6hAmVe4dWWW8xPNyx3ImLCeC7J1oxDX7bED+EG75p7JCHLF4Gy1KlSdEGZRKpepG0M9jG7oe+rfUTNUTFTB4CdmWTDRvOyuBKsAv7q8oMgVjY/oTdYkxhIFdqedlDk/+7cMbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB1815.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:30::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 20:46:39 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 20:46:39 +0000
Date:   Sun, 25 Jun 2023 21:46:28 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 2/7] rust: add derive macro for `Zeroable`
Message-ID: <20230625214628.32d55a54.gary@garyguo.net>
In-Reply-To: <20230624092330.157338-2-benno.lossin@proton.me>
References: <20230624092330.157338-1-benno.lossin@proton.me>
        <20230624092330.157338-2-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0650.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::20) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB1815:EE_
X-MS-Office365-Filtering-Correlation-Id: 32391ceb-6f87-4265-c98c-08db75bd4634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1Vs+xo1lxFm2hZLrh1YkuKohwowf/wZlseqwf4f6FQBZBNQ04dAGh7qV1K6pZ7Z7VeuGXdoXGUrzaF1sA/dzjcF2te42COhwu3ImCcqibzOLj5hevUBubxhMImrYch0uZTY2uoG2zD2l5y7BOjRD5MLFYxyFBkylXwzUdOsrcuy1CwoaCgvukRZm8HujOo3syoIBdIhRZUYKGNZ5n5YInp8HaVOjB9aPD1hGRY6pqqekgG45Ugy6I/pV2PvtB+sRZoIGqXnL9nM4tTXWLOPan01qeMD4pWp1FGWGf8DXTYMtXlEcSk4g15omwkg26DQj/4AkD3neZppZz4V58n7ITwP/UFl89LpBStl0S0pqbT5qiaUOFVKu4WG/R1U+pKU5q0KsNsDvrhFznGyL2+Pb6+bvVMNtGCiXi4RTpTc1k5TbWy0ayakiI4Ol55ALIcuBH+wCNj8K0r2VHINMd4Ng+ZpJvOTSioB0Z31B34XVaVxFhZcbaAI/y9W43ppU7jrSg1CvXJN4bH8cNEts5iVIr5KkFzeoM2l4gJb/bAmwWbJANGoail3bBCbVx/RdbCTngDQ7JPuTfJcuD6og3CmtpTg4Ahc49qoJCjoSRcUt8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(346002)(39830400003)(396003)(451199021)(36756003)(5660300002)(7416002)(6916009)(8936002)(8676002)(41300700001)(86362001)(66556008)(66476007)(38100700002)(4326008)(316002)(66946007)(1076003)(6506007)(26005)(6512007)(2906002)(186003)(2616005)(478600001)(6666004)(83380400001)(54906003)(6486002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hx3FyO0cVsl2h8uWPmAi4ruwPKJr5eaLIbvDOLH655qv4rHTEAgtW0VAqEBn?=
 =?us-ascii?Q?tv/pIBu/jAHiZDka/kgPMuQy0RzhwQYBPO0Q3gZH0jzkakRS5c41YjsHGYEQ?=
 =?us-ascii?Q?Ub8iRM0M4vAfr4owqLSryuIxQ3v7HkIYoKVrp3n019jeZ9L5loI/hOSmuIpO?=
 =?us-ascii?Q?liLWj72tEg3zOrhSmEfclSri3bplhF+e0H7eEKxNbZ3F+iDy+VHIA5FpixM2?=
 =?us-ascii?Q?HXO6afOhO7MfvOxtYMT9rdyLcYzlKDWGR7iZsfEPfKDiBNU23mkH6TMNIoAi?=
 =?us-ascii?Q?+5XjF3lOE2GRbII0lryUWTSqH/gPO+VE4nwGggxqHpYyHjsjcl9g6LWD1n/X?=
 =?us-ascii?Q?xlcyFzhBLTkMjNKXPGerZEJRBe1KSnU8OuRD9j+KjFf8QAsoX6IXh/uGGsR1?=
 =?us-ascii?Q?ln2E/CIEjz6UnHeyC9GizRJ6ZsD3w929YmMF2OBpT+SnSZQEdSgFGhzPnilU?=
 =?us-ascii?Q?LTpdg6dKq/zUpmk/rbIPDIzYz/eCdgVlT7+LCxaoF+K3TALSzmC2/kkbFPTl?=
 =?us-ascii?Q?1CJKvoNH3Wxu65eLfv1xi6X9BBzLh01udNTRxY6sFQjSQMVgHzFFkDOdzCtn?=
 =?us-ascii?Q?X6LazXZhf7scDsaZfp3oFIdOt6Jf0nPEoicFbQX5sb6eRRPTwWeb+qMAPVJa?=
 =?us-ascii?Q?6UCjdWrGPQb05shWoq/gac8JdTgI6dLNgWbPXAmfS/WLoreME3mFP1ZuION0?=
 =?us-ascii?Q?cFCpJhfUZiSH9MjuQB7BkIeLvxXUkD1ll1BzMqX+GU7eidR+CeNqlwwsuklz?=
 =?us-ascii?Q?dYUnQ2o7On4eAYVZV2sxdst6jX45tLcnfL2TigV92XCp7G6cGv0124B5ie3C?=
 =?us-ascii?Q?F40Fj+C0sXyHDGHpInX31EkntpkLH8DUaZbbO2QqkAgx943qsvUzGYZ73D16?=
 =?us-ascii?Q?qM/oi2YpXu3kdWx/3txvkNBI7xoN15ixaJBSzzPl02c/N8rgph4z1KNYO7A5?=
 =?us-ascii?Q?Z4QQBdKHTIQe61WexAdzOrQ6shzgH8TFK/plmflO+VtF/wfA+B5Zy9K/y9NH?=
 =?us-ascii?Q?ogLys1wOPPZ/IAjyxL/RQMFFO4BvUgMKSPDmDLrDZVFHvYwh/7HQH/SwD1w1?=
 =?us-ascii?Q?1yt+hG3QMEZkqYKZNPM6RhrvkwEtWWedVmfWinrQbVxvTnc3/k5/Y5R3Dnzl?=
 =?us-ascii?Q?1YaKaU72JtWF5EPGPlkKtKU+kS1lIDfUyZMD3YOoMQyvLV3N/VpejiZg+bXa?=
 =?us-ascii?Q?erJne2aBgfUxcPvLC5fRXgPcCSEVm6/+KqKZneUx+bLm25wPpK89fZKeKK67?=
 =?us-ascii?Q?X6Lseja24cvdvpU9se+uXyZEhnOSU2RS9FYJyS70EfgTn8Vi/ErIsmjJRFdb?=
 =?us-ascii?Q?JPVIPMHubL7ezgUfb9wesop4MZ1j94lGQQd/O0EqW0WonUd0YHB+RqIBnZVi?=
 =?us-ascii?Q?6irAIppNGgnEN28q3EaMAB1w8J5H80bm5Ya6Jq7V4lxKGHH+wcOPEUq688Qk?=
 =?us-ascii?Q?8wFxjlvwjElJyxRZJe+J/kYilxI1iuFl19HV/tzjL9DXwoVi+kenxKAn09K2?=
 =?us-ascii?Q?itFkQsG0t2uDCLIVvjLAU/R8xLqHd/GUdRIFfUCrpCgQ76JnWwY3WvXKCv7s?=
 =?us-ascii?Q?G6l2NZNqhOajy5uQhquommiCy9x4sZt/QAAGj3F/?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 32391ceb-6f87-4265-c98c-08db75bd4634
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 20:46:39.1279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jiUFFx+PbTGUWdHy0DaEhwUQvdC9iJ6+7NDbmjaO/3kMvxlZfDjkpT11dZB4o1Eg5XvIOTWrAcn8oK5q8/DUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1815
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2023 09:25:03 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> Add a derive proc-macro for the `Zeroable` trait. The macro supports
> structs where every field implements the `Zeroable` trait. This way
> `unsafe` implementations can be avoided.
> 
> The macro is split into two parts:
> - a proc-macro to parse generics into impl and ty generics,
> - a declarative macro that expands to the impl block.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/init/macros.rs | 28 ++++++++++++++++++++++++++++
>  rust/kernel/prelude.rs     |  2 +-
>  rust/macros/lib.rs         | 20 ++++++++++++++++++++
>  rust/macros/quote.rs       |  6 ++++++
>  rust/macros/zeroable.rs    | 25 +++++++++++++++++++++++++
>  5 files changed, 80 insertions(+), 1 deletion(-)
>  create mode 100644 rust/macros/zeroable.rs
> 
> diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
> index fbaebd34f218..e8165ff53a94 100644
> --- a/rust/kernel/init/macros.rs
> +++ b/rust/kernel/init/macros.rs
> @@ -1213,3 +1213,31 @@ macro_rules! __init_internal {
>          );
>      };
>  }
> +
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! __derive_zeroable {
> +    (parse_input:
> +        @sig(
> +            $(#[$($struct_attr:tt)*])*
> +            $vis:vis struct $name:ident
> +            $(where $($whr:tt)*)?
> +        ),
> +        @impl_generics($($impl_generics:tt)*),
> +        @ty_generics($($ty_generics:tt)*),
> +        @body({
> +            $(
> +                $(#[$($field_attr:tt)*])*
> +                $field:ident : $field_ty:ty
> +            ),* $(,)?
> +        }),
> +    ) => {
> +        // SAFETY: every field type implements `Zeroable` and padding bytes may be zero.
> +        #[automatically_derived]
> +        unsafe impl<$($impl_generics)*> $crate::Zeroable for $name<$($ty_generics)*>
> +        where
> +            $($field_ty: $crate::Zeroable,)*
> +            $($($whr)*)?
> +        {}
> +    };
> +}
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index c28587d68ebc..ae21600970b3 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -18,7 +18,7 @@
>  pub use alloc::{boxed::Box, vec::Vec};
> 
>  #[doc(no_inline)]
> -pub use macros::{module, pin_data, pinned_drop, vtable};
> +pub use macros::{module, pin_data, pinned_drop, vtable, Zeroable};
> 
>  pub use super::build_assert;
> 
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 3fc74cb4ea19..9f056a5c780a 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -10,6 +10,7 @@
>  mod pin_data;
>  mod pinned_drop;
>  mod vtable;
> +mod zeroable;
> 
>  use proc_macro::TokenStream;
> 
> @@ -246,3 +247,22 @@ pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
>  pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
>      pinned_drop::pinned_drop(args, input)
>  }
> +
> +/// Derives the [`Zeroable`] trait for the given struct.
> +///
> +/// This can only be used for structs where every field implements the [`Zeroable`] trait.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// #[derive(Zeroable)]
> +/// pub struct DriverData {
> +///     id: i64,
> +///     buf_ptr: *mut u8,
> +///     len: usize,
> +/// }
> +/// ```
> +#[proc_macro_derive(Zeroable)]
> +pub fn derive_zeroable(input: TokenStream) -> TokenStream {
> +    zeroable::derive(input)
> +}
> diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
> index dddbb4e6f4cb..b76c198a4ed5 100644
> --- a/rust/macros/quote.rs
> +++ b/rust/macros/quote.rs
> @@ -124,6 +124,12 @@ macro_rules! quote_spanned {
>          ));
>          quote_spanned!(@proc $v $span $($tt)*);
>      };
> +    (@proc $v:ident $span:ident ; $($tt:tt)*) => {
> +        $v.push(::proc_macro::TokenTree::Punct(
> +                ::proc_macro::Punct::new(';', ::proc_macro::Spacing::Alone)
> +        ));
> +        quote_spanned!(@proc $v $span $($tt)*);
> +    };
>      (@proc $v:ident $span:ident $id:ident $($tt:tt)*) => {
>          $v.push(::proc_macro::TokenTree::Ident(::proc_macro::Ident::new(stringify!($id), $span)));
>          quote_spanned!(@proc $v $span $($tt)*);
> diff --git a/rust/macros/zeroable.rs b/rust/macros/zeroable.rs
> new file mode 100644
> index 000000000000..cddb866c44ef
> --- /dev/null
> +++ b/rust/macros/zeroable.rs
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use crate::helpers::{parse_generics, Generics};
> +use proc_macro::TokenStream;
> +
> +pub(crate) fn derive(input: TokenStream) -> TokenStream {
> +    let (
> +        Generics {
> +            impl_generics,
> +            ty_generics,
> +        },
> +        mut rest,
> +    ) = parse_generics(input);
> +    // This should be the body of the struct `{...}`.
> +    let last = rest.pop();
> +    quote! {
> +        ::kernel::__derive_zeroable!(
> +            parse_input:
> +                @sig(#(#rest)*),
> +                @impl_generics(#(#impl_generics)*),
> +                @ty_generics(#(#ty_generics)*),
> +                @body(#last),
> +        );
> +    }
> +}
> --
> 2.41.0
> 
> 

