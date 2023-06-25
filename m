Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C91B73D447
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 23:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjFYVB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 17:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjFYVB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 17:01:26 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2091.outbound.protection.outlook.com [40.107.10.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BED5126;
        Sun, 25 Jun 2023 14:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8LZO+sst1XqiRHwrONdBOPEoJUIO8XlEr7iidvT7HiqieHgTpr8P+DmTzyPGovsJn4BZfbpYVjyO/PL4RL9+pYifz5LrdgMAeAJe2EhAehT7hbKyk4G2uJ77DRnrdYx1kTAmIyJxh8ahSChUraElpLyqOxF4rt8KJ+wY8IrUwOmrHShWVhRI4nC2Gt0Zp5jYYDE8VdzkCX/w6jIO4d4Xeks4Y7fGWP+K61NhfbuUJryLpdY4zLlYQQvCm8HWqarLmavGrYY6h/w02DM01ko3WX4fkFY8dM6QEHX4nvi1WpKttHoeAFzHwGgUtBeHxB2q31ITOYPZKGoBx21QhxvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mk5icy44rHOVrOUYPjDPXaUU7PuqTlRWA7NjXsw72vk=;
 b=aL37cPbyQNSTle92p+P2xrYDnYucOUT4io/Qxt85Zax0dPvGrUEnZPh8gNHp2bwVtz7Scjv10YFehumXAewsbzfqbZylMw2rfMM/75aHE08QsJWwcuemkKA+tpC3xGYNR+4CtM+XuR7oGbKxWNDtVV4a5VeneOCJk6/qmtahKCRei3gPPbu4YcVrHVIZ39sj8KR1bXgB87VHVc3TTN2j0EX0P0iZSpcNmfFHPFqA4MKfrQWM0kiiUHiqT6gO4rsSklm0SkHdB7o+htBtZZRaGMixraiZIT+356xZ3Zkm2J1bg1Q27j/CXKEYvbzFaUbYnaNpazbqDtHOu+7g31SEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk5icy44rHOVrOUYPjDPXaUU7PuqTlRWA7NjXsw72vk=;
 b=s8pjxJBogFmPEi837Scd4SQhwQhlnagNqYDuYfD+P/jhhz/wB3MzCtixit8gX6YGutxiy9hj6FvcOMBbHcfN0iWQoim2GCeBuQparzTtZpCLX1lqaBiVwT6KQaV3D1qes9if9nQDmtT2ayGynIDfXZ6ovSSQYmtJAolP/t6ctmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB7369.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:33e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 21:01:20 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 21:01:19 +0000
Date:   Sun, 25 Jun 2023 22:01:17 +0100
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
Subject: Re: [PATCH 7/7] rust: init: add support for arbitrary paths in init
 macros
Message-ID: <20230625220117.667db9ea.gary@garyguo.net>
In-Reply-To: <20230624092330.157338-7-benno.lossin@proton.me>
References: <20230624092330.157338-1-benno.lossin@proton.me>
        <20230624092330.157338-7-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0509.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::13) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6953b7-09a8-4e9a-e57b-08db75bf532d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkpJnE1mmgZPfmOW0aN9ZDjdPOFbIvF6pM2LIp1RRGYPhZnItezMRiaHQs4/joyI2Jl+ladIGgOfkVAWdJYxPJG3GSbkweo6xuWeqNw636Cby83ULBO0jjQ87nPGO73+C1bLKEYtbi241DnLWVlS887ypHmkGBOa+P4qtvMhYoFQw1uHe/AN0bavlsPaNtVdswy2sgWS5uUBLWGS8hsTEu/GkWvQdLrGMa036JUJVVk+29o1K3GDTIZ35rrHkmK2lvyXeMvjbvmWp405Xe2ltBHM95w/SZXMZyZDCcNeF39lllqA8Adfgl4Z91gGCNvB+V6oVBieJBOny1XEdoq65C6/Sv0uU3fMUSQ9/Tf1BIwEmteidwGB/84ZsAMuYn4Z4fsUfAky0UicjerC5m2fRcEWSkDTTq7XeacZOX+mRpP1Sp9Sa4gPYsqfMbONVsSdCqOpfCQ2bsx0npS0+YwuXTQWA/smB3CwHx/mVoTFNWsARUZDA+/+6s8rH6SQa9G2RoNfc8X6tzZ2Ym07jayh5Mbxm+ecnjFfC9KNCb1se/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(136003)(376002)(346002)(396003)(366004)(451199021)(8936002)(7416002)(36756003)(66946007)(66556008)(66476007)(316002)(6916009)(4326008)(478600001)(5660300002)(8676002)(2906002)(966005)(86362001)(54906003)(41300700001)(6486002)(26005)(186003)(6512007)(6506007)(1076003)(38100700002)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l43f+wo/Q9l5LZ4pfvc8qIY/LjKcPhxMZuSaN+sX26uccUrp0hSCl4qTBe+T?=
 =?us-ascii?Q?f6bohOgIkFxbxGnpt3Yt3ilq7jXCz4p4vchkD3cxIqKL/UAKii25wOl74EK0?=
 =?us-ascii?Q?u/z43/g+QEe4GzheQPxL0Fp/30XriImT5L7qSbsFx71ZlQfuchgBoL0hvGWF?=
 =?us-ascii?Q?eo7dN6dAhE3sFNz8LY1pR8CogUVtHsqPxcRRc6Bh/HxRkldrLfcVZdr8pAIl?=
 =?us-ascii?Q?yzndYKpi86QtPi2Ldy/eSXOdvQE1TnlWtpPJTKPK/BXBOT86NXErhaPHJk45?=
 =?us-ascii?Q?9KtNzKo3pNRIZVCB7Z1RuAwMTSNn4YIhhmY5CpFjLdP2Om2cWC+ADq6K8BU4?=
 =?us-ascii?Q?C63XN9dci8FmFwh0cmUwWEhlFNXelN2BybQELCipVdQIjSsX23OqEzwpTMuo?=
 =?us-ascii?Q?x4qQAmj7F9Uh2SwZS6ibPgKdRpeQv5fE9ujaquF3Ljwr/mY/8sH4G8n1iQoe?=
 =?us-ascii?Q?M9O70ktJHEJysUhL8rOfo8N2JBfqg+MxuNTEYmTmLCiNoKtnlN6+I2e/T3y0?=
 =?us-ascii?Q?vLIDgPK9tuS6ZyQ1n6VPB7HU8fuq4wd1rusQPLd33kDw6m6NMdVI2vKEvoNE?=
 =?us-ascii?Q?8q1e60pMrbsSuzcLm2Ehn9PO4YsVJFS+fZrijixWHAb8O3LicFZ4YBnue2VY?=
 =?us-ascii?Q?G8hucVZt/SCn3cI8tUSFtr+T4BIvRdjTDKLYktSLzrTwKkPnuIwg5Yfsuwd6?=
 =?us-ascii?Q?EJRqrP4g8xaf/0sWyRzI0lM+a8pGY6DRIWMDqHkuKmOy6gqEUXn9x6g4emo/?=
 =?us-ascii?Q?Va3iMvu0ae676F/mFS7uPRTyu+LJ7DlvqoEeBcraV+2O8g6fQ04N6DE9Ux2U?=
 =?us-ascii?Q?3FBCWgW8qOKObmyzPP6P5RzMguuAWqzlEEyu5JFmjXuRLNS8/juHWYvpI5mI?=
 =?us-ascii?Q?5pEFleezKun2B1WDEN3bxWBdka9Hh1AwRbW1psQlDGJaMTn1gMfvr+6Upbaq?=
 =?us-ascii?Q?uz1zkkSStAYYDGypbrTQi7xxplpTmiF+vSEMbOtIXM7YaoeN90eSVCi9EURn?=
 =?us-ascii?Q?WhLWV7TRF8x55SBys3IV+qG0dudckdbxjRspaJAYk5dX6UKtaHqLle/9ZrdS?=
 =?us-ascii?Q?Jq21IarBTCwpODcukwvBlOcJSfrq9z97RMIBLv1Jt8q9N08RddpHk/Mc5WrN?=
 =?us-ascii?Q?6H7SBe2TmZR5AIZKWjAHP1Cee5rlOxiKvwGgvnnFCKSYGE3XGvrYrvXfyzT2?=
 =?us-ascii?Q?Z4WIBZN4k+pnWEE03n7bVI4KrILj8s+jWAgVSNhbA8zQUw16jjTitHPW3/gI?=
 =?us-ascii?Q?HtVntZjYL8xLYhwREeQKUqZrFDBV0cO0shE5OEB+VrPWBpmVqNjCmMTDQKMk?=
 =?us-ascii?Q?AMhkWhnHSSH2rT6UgRi0k9XeChfrr1taOry1CknrKz8mPOerzmrg5DZtih6K?=
 =?us-ascii?Q?EVlKXN4a/UJAfpjJEDVDDGHo+lQ106NMz4Zxm3QrUGUVOaG7r5vZZC9zb3C0?=
 =?us-ascii?Q?v5LOcDUM7CW8Q6YtdF97CVUdCBg/zrs5r2n9MBRMhuoDAK/zeu6GXw3qXgEc?=
 =?us-ascii?Q?HgOZ86T0WGAYP656bYHfE/1VVHoBAbjIM8fUVPapk4XEZrApEdxcHLthhf9l?=
 =?us-ascii?Q?W5e1yDdEB4QecFPXOAxEXIFpXHsiW36PUag/gfpZ?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6953b7-09a8-4e9a-e57b-08db75bf532d
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 21:01:19.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXbssnFxZbBMFlT9FNPw+ysdGclsUcnIt0S1StsxQFEgr8WjO6sqZzzAFbYlWmTV+Kt5fcPJbyOjoR0d7jYoRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB7369
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2023 09:25:39 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> Previously only `ident` and generic types were supported in the
> `{try_}{pin_}init!` macros. This patch allows arbitrary path fragments,
> so for example `Foo::Bar` but also very complex paths such as
> `<Foo as Baz>::Bar::<0, i32>`.
> 
> Internally this is accomplished by using `path` fragments. Due to some
> peculiar declarative macro limitations, we have to "forget" certain
> additional parsing information in the token trees. This is achieved by
> the new `retokenize` proc macro. It does not modify the input, but just
> strips this information. For example, if a declarative macro takes
> `$t:path` as its input, it cannot sensibly propagate this to a macro that
> takes `$($p:tt)*` as its input, since the `$t` token will only be
> considered one `tt` token for the second macro. If we first pipe the
> tokens through `retokenize`, then it parses as expected.

I think this "retokenize" macro could also be functionally replaced by
`paste`. Would you mind to apply my paste patch (referenced in a
previous email) and see if it works?

Best,
Gary

> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
>  rust/kernel/init/__internal.rs |  2 ++
>  rust/kernel/init/macros.rs     | 42 +++++++++++++++++++---------------
>  rust/macros/lib.rs             | 17 +++++++++++++-
>  3 files changed, 41 insertions(+), 20 deletions(-)
> 
> diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.rs
> index 7abd1fb65e41..e36a706a4a1b 100644
> --- a/rust/kernel/init/__internal.rs
> +++ b/rust/kernel/init/__internal.rs
> @@ -9,6 +9,8 @@
> 
>  use super::*;
> 
> +pub use ::macros::retokenize;
> +
>  /// See the [nomicon] for what subtyping is. See also [this table].
>  ///
>  /// [nomicon]: https://doc.rust-lang.org/nomicon/subtyping.html
> diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
> index 5dcb2e513f26..6a82be675808 100644
> --- a/rust/kernel/init/macros.rs
> +++ b/rust/kernel/init/macros.rs
> @@ -998,7 +998,7 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
>  macro_rules! __init_internal {
>      (
>          @this($($this:ident)?),
> -        @typ($t:ident $(::<$($generics:ty),*>)?),
> +        @typ($t:path),
>          @fields($($fields:tt)*),
>          @error($err:ty),
>          // Either `PinData` or `InitData`, `$use_data` should only be present in the `PinData`
> @@ -1012,7 +1012,7 @@ macro_rules! __init_internal {
>      ) => {
>          $crate::__init_internal!(with_update_parsed:
>              @this($($this)?),
> -            @typ($t $(::<$($generics),*>)? ),
> +            @typ($t),
>              @fields($($fields)*),
>              @error($err),
>              @data($data, $($use_data)?),
> @@ -1023,7 +1023,7 @@ macro_rules! __init_internal {
>      };
>      (
>          @this($($this:ident)?),
> -        @typ($t:ident $(::<$($generics:ty),*>)?),
> +        @typ($t:path),
>          @fields($($fields:tt)*),
>          @error($err:ty),
>          // Either `PinData` or `InitData`, `$use_data` should only be present in the `PinData`
> @@ -1037,7 +1037,7 @@ macro_rules! __init_internal {
>      ) => {
>          $crate::__init_internal!(with_update_parsed:
>              @this($($this)?),
> -            @typ($t $(::<$($generics),*>)? ),
> +            @typ($t),
>              @fields($($fields)*),
>              @error($err),
>              @data($data, $($use_data)?),
> @@ -1048,7 +1048,7 @@ macro_rules! __init_internal {
>      };
>      (
>          @this($($this:ident)?),
> -        @typ($t:ident $(::<$($generics:ty),*>)?),
> +        @typ($t:path),
>          @fields($($fields:tt)*),
>          @error($err:ty),
>          // Either `PinData` or `InitData`, `$use_data` should only be present in the `PinData`
> @@ -1062,7 +1062,7 @@ macro_rules! __init_internal {
>      ) => {
>          $crate::__init_internal!(
>              @this($($this)?),
> -            @typ($t $(::<$($generics),*>)? ),
> +            @typ($t),
>              @fields($($fields)*),
>              @error($err),
>              @data($data, $($use_data)?),
> @@ -1073,7 +1073,7 @@ macro_rules! __init_internal {
>      };
>      (with_update_parsed:
>          @this($($this:ident)?),
> -        @typ($t:ident $(::<$($generics:ty),*>)?),
> +        @typ($t:path),
>          @fields($($fields:tt)*),
>          @error($err:ty),
>          // Either `PinData` or `InitData`, `$use_data` should only be present in the `PinData`
> @@ -1092,7 +1092,7 @@ macro_rules! __init_internal {
>          // Get the data about fields from the supplied type.
>          let data = unsafe {
>              use $crate::init::__internal::$has_data;
> -            $t$(::<$($generics),*>)?::$get_data()
> +            $crate::init::__internal::retokenize!($t::$get_data())
>          };
>          // Ensure that `data` really is of type `$data` and help with type inference:
>          let init = $crate::init::__internal::$data::make_closure::<_, __InitOk, $err>(
> @@ -1247,7 +1247,7 @@ fn is_zeroable<T: Zeroable>(ptr: *mut T) {}
>      };
>      (make_initializer:
>          @slot($slot:ident),
> -        @type_name($t:ident),
> +        @type_name($t:path),
>          @munch_fields(..Zeroable::zeroed() $(,)?),
>          @acc($($acc:tt)*),
>      ) => {
> @@ -1263,15 +1263,17 @@ fn is_zeroable<T: Zeroable>(ptr: *mut T) {}
>              // not get executed, so it has no effect.
>              ::core::ptr::write($slot, zeroed);
>              zeroed = ::core::mem::zeroed();
> -            ::core::ptr::write($slot, $t {
> -                $($acc)*
> -                ..zeroed
> -            });
> +            $crate::init::__internal::retokenize!(
> +                ::core::ptr::write($slot, $t {
> +                    $($acc)*
> +                    ..zeroed
> +                });
> +            );
>          }
>      };
>      (make_initializer:
>          @slot($slot:ident),
> -        @type_name($t:ident),
> +        @type_name($t:path),
>          @munch_fields($(,)?),
>          @acc($($acc:tt)*),
>      ) => {
> @@ -1279,14 +1281,16 @@ fn is_zeroable<T: Zeroable>(ptr: *mut T) {}
>          // Since we are in the `if false` branch, this will never get executed. We abuse `slot` to
>          // get the correct type inference here:
>          unsafe {
> -            ::core::ptr::write($slot, $t {
> -                $($acc)*
> -            });
> +            $crate::init::__internal::retokenize!(
> +                ::core::ptr::write($slot, $t {
> +                    $($acc)*
> +                });
> +            );
>          }
>      };
>      (make_initializer:
>          @slot($slot:ident),
> -        @type_name($t:ident),
> +        @type_name($t:path),
>          @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
>          @acc($($acc:tt)*),
>      ) => {
> @@ -1299,7 +1303,7 @@ fn is_zeroable<T: Zeroable>(ptr: *mut T) {}
>      };
>      (make_initializer:
>          @slot($slot:ident),
> -        @type_name($t:ident),
> +        @type_name($t:path),
>          @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
>          @acc($($acc:tt)*),
>      ) => {
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 9f056a5c780a..d329ab622fd4 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -12,7 +12,7 @@
>  mod vtable;
>  mod zeroable;
> 
> -use proc_macro::TokenStream;
> +use proc_macro::{Group, TokenStream, TokenTree};
> 
>  /// Declares a kernel module.
>  ///
> @@ -266,3 +266,18 @@ pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
>  pub fn derive_zeroable(input: TokenStream) -> TokenStream {
>      zeroable::derive(input)
>  }
> +
> +/// Does not modify the given TokenStream, but removes any declarative macro information.
> +#[proc_macro]
> +pub fn retokenize(input: TokenStream) -> TokenStream {
> +    fn id(tt: TokenTree) -> TokenTree {
> +        match tt {
> +            TokenTree::Group(g) => TokenTree::Group(Group::new(
> +                g.delimiter(),
> +                g.stream().into_iter().map(id).collect(),
> +            )),
> +            x => x,
> +        }
> +    }
> +    input.into_iter().map(id).collect()
> +}
> --
> 2.41.0
> 
> 

