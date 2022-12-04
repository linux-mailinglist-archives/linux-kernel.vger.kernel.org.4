Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CE6641A1A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 01:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiLDAUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 19:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLDAUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 19:20:43 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2123.outbound.protection.outlook.com [40.107.11.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740EC12630;
        Sat,  3 Dec 2022 16:20:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWJBJHUeWdHF1JNqEgHHqHBHwAqiCGtTjP/d9ReguxUCwkRgEWYqF5+wLPyf6qayANMUJ1J+K4K056nxe4f2N3DjNe52kQDFnU8FJ+eUJOSgx/yeHyhx/8jrK676hJDZ9yBnROYtz328Rlh+e4EUH623WY5RVSZCsWlsIKa8ZAVyfKv9rECZdAimjCgknLA2E/mxFfeTAJGWTfi+LSwcEW+ksv7p2737kCtFeobp3QBXodTZpgBhbcacDZvnWBEfwdV/e3fB8pbE4lyWvZypmiAvLh6Ho9UoBPof5a53ZXk4/2e5fHVhZ65pELRSSZMKwwy1m1iAUo+DuymhwNQDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GiNkd+KqMmrLrrCE7ytSsIfjPOyFRoBFYxPW2eGdlM=;
 b=ia1PhgpMhN273W/9AtLnjAmhtH2RpWs5zBO8xYEWfy97Vvwi3c8Jcb3DhCcNUoo0aOSJe1y/jW7y4rboUbsHhZhPIQCwNDnu/sCGwMNUnYK2CusNonNyG6hOv3qkQahvHcGHaqyqDOjx92jGe9TguqfNIHyr6DA0Z6E6IXP/WYT1DuA4Qq8DiqHowyxpxtFqqHWr2FNf5/4jc5pk/rWNdEMxhWSn17y3kcAhIRDu4r2FzoJT1+O13XBovpUPKNA4MIr8gCnMborz4WTPFonHEQofeB7vdU3izQkU/04PPfO0JpohcySqicvo/A371NWwhlJnm0PVxfykgiSzH0DzSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GiNkd+KqMmrLrrCE7ytSsIfjPOyFRoBFYxPW2eGdlM=;
 b=IcfypPdS+yPlLQP1NuvzjKZzuuYkPEqFyHrujdMjd7LNEYea4VaWRcXa8jzw4nngbMblN2qvjjetP2fJku0e/tJuq10uT2/rFrxQZ9DcxOMCBMviD81+JgZX1fneaa6dTNK+NBjM9+gZmsJQ0ALXMqBq12FGAJmET/1LrFUHV7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB7170.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:32d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Sun, 4 Dec
 2022 00:20:38 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7%5]) with mapi id 15.20.5880.013; Sun, 4 Dec 2022
 00:20:38 +0000
Date:   Sun, 4 Dec 2022 00:20:37 +0000
From:   Gary Guo <gary@garyguo.net>
To:     ojeda@kernel.org, Finn Behrens <me@kloenk.dev>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v2 05/28] rust: macros: add `concat_idents!` proc macro
Message-ID: <20221204002037.29e7da42@GaryWorkstation>
In-Reply-To: <20221202161502.385525-6-ojeda@kernel.org>
References: <20221202161502.385525-1-ojeda@kernel.org>
        <20221202161502.385525-6-ojeda@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0141.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ca7a24-ed66-42c4-f79c-08dad58d5edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GTQ5ccaYr15EZCv2NqvZIKHewlqcNJofPvlL5nirQIyjl3dPDZun6SQzgbTfcdMhNhGw6uYc1y4B30EJKsXQW6fuA4Xa1f2f45G53SiBDeDXo1TJmXmU229WM7EIul5cOUNl57tjUXYFckjCFflbimCdhXBzMaru8WC1ndYtyYCEOPE010TW/ZybZVp+oCcqJz7vT/L2qU6y4iEzuHWjg0UZkieF+eYiv4YWb6nvJQ9+mNL+M4EMGpItCsZCboHR29WdYmjxfP/0e1USyhe8NFdIwm3T11rsG8FryBrkFWxdfJroomc4R26jPZvYNcaWXVBf2ajX6ZxGQMD+PMPkpEga6XViS2IwSieb95dy/jzvKuE24DcRbHzdIj8am2Fkc751WmbCC0O4lUA2nW137qs3mgW2XzcJECdHJLOOr4/hd/aY5b3y2XqS4hzM/l/YfA/xn+mRjBLJNsCfCqV4b0OADZ7BhqA8gbbGXBAflTWXMpe0qmuSz2ytevZ5brFZmquV7v+Fj6YeMB7TJjj2ndmzm6sQbMcqukomY5HQ2Rb2YMOivTUD5DVysyCVPsVS+vyXFVCcaqTCiYq5H6CY0qgXkGv4lO2hrNUki7bIhf51ihftEsN60XojDa90Kk65k8xDv0s7OSF8VFqEGo8QcEHk8EOijyD8L5dh1rRUfK8TswRWwReg9uUpY/JBeiI0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(396003)(346002)(136003)(39830400003)(451199015)(2906002)(86362001)(83380400001)(66574015)(316002)(6916009)(54906003)(6506007)(9686003)(6512007)(186003)(6486002)(1076003)(478600001)(41300700001)(5660300002)(8936002)(38100700002)(4326008)(66946007)(66556008)(66476007)(8676002)(33716001)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHhMVVZCR0lTTHY0Z1poNE8zR2tMcDQ4aTVGajZSUHZ1UkJEaC8yc01xaFJu?=
 =?utf-8?B?TThuMThoYk0vY3JobytYbXA3aXJCN1VDNVo0WUg2VWZnR0RsQXI4L3cxNmRH?=
 =?utf-8?B?Zk5ESEpKUW5WQm50RUVGQSt2Ump6TmUvWFRGSFpVdlJlWTZHUElxYlpIa0NR?=
 =?utf-8?B?THZYSFpoeldRV1ZsdGlDK1NXeDRTcnM2ZDNLS3pBMHNGUThLanRaQ2EwUFc2?=
 =?utf-8?B?STRBWnlSK0NkYlJEdmZ5UTZXd04vTjFiOHNSSG9BNTlZZHRZSWN0ZzJBSHdx?=
 =?utf-8?B?YzJPTTRsd1NTeisrc29NWmxhekhaN2lDUXRkWDZsYjM0N1RRMGZrNVcrc2Ny?=
 =?utf-8?B?Wkg5U0Q3UFVDY01vY0dPdHRiUC9YKzRpWkJEZjNJNnN3ZnJqanF3N2RjRi9o?=
 =?utf-8?B?TlFoa01OL08wVmsrdWZ4cGZTNTdCaWxMaHpDOC9HdmxGbmhrMFp4bzRXZXJv?=
 =?utf-8?B?aDZVWTlvblc2NXMxd2prSGExYkJGYnhRVFhjK0tpbm5wL2o2VmgxY1JEMEo0?=
 =?utf-8?B?SU13eDgxeFdYYk1Dclp4dUNWN0JtL2lNM1dCVVFUOURJVVdkUzVhdXlnUWs3?=
 =?utf-8?B?bWozN1BPVkcwV3lLcGpQTERWQlRTTWxXSmlNcG1yZytZd21WZEdqL3pydnBx?=
 =?utf-8?B?elJvRk1OcWhJYi83aXpLYlpjNmFHZDg3bldRajhqQ3o3S2ZaRVBaYkJKcEtn?=
 =?utf-8?B?WlBHOTJrL3BLUStnWWQxSUhJYzBKV2hKWUp0dEZSNkNjbm1INHJPZ2hOczBu?=
 =?utf-8?B?MERnUmVhWkVGTEVGems4bG4xRXpBbW1JNDI3aEExSEdKYUNwaVozdmVWL25p?=
 =?utf-8?B?djRNV0NHREZVYUdQUW1sSWhPSkdDcTh3K2wyL3dEWG5RcUVwZWQ2b3NpRkVD?=
 =?utf-8?B?WG4vUGh6eTZkeW0vRjBaTXlNU0NVZW94RTlxbk54YjUyTEJFTlhoalgrV3lm?=
 =?utf-8?B?bkY0YXZCYy9NSkFnYmRqaW1oSG5HK1prUjV1T0lEcjBuRzVwYUZ1dGVkclNR?=
 =?utf-8?B?NnMwWGdYZGtoMGJZMy9kUnNJS1JoK2VLZUlOWmZ4MVM2Rmh1dmlETVFkdFFn?=
 =?utf-8?B?M0FrOXVhZEVkbWNpc1RiRVVySmFGbUwrZzJER0d0SnBtRzNyL2dPbVNFUFov?=
 =?utf-8?B?bGQxSjlwMnRqaWV0bzk3SFViLzVjbmNPRlo0RVlxajFKMi85YlRiSTJsOWpl?=
 =?utf-8?B?enAwUUdFNUZxRytMV3QyVWhzYjh0Qy9iWjZXR2lQR1JWWDgxdDZ4SEdSUmpk?=
 =?utf-8?B?YlVWOThoTmYxeXFpQ29Rc2JIU3c1eVlrOUptNmkxZHFNNUdjcVNvdEpZZTd5?=
 =?utf-8?B?TUpHdjRZWE41YmJ3Ukdmb09TV0N6eWU3WjVqSHlTdzQ4K2FGa25hZzA0TERG?=
 =?utf-8?B?YzBaQjlYQXZXbU9Hais4MjBOMzhxYjlscFFIZWt4R0NTY1BhV2FSMm10UkY2?=
 =?utf-8?B?eDI5Q0t0TitMMVhRZW4rM0VrbFFaVGMrZkdOZGF4Y2Zwby9ocFFIUk84Wkd0?=
 =?utf-8?B?NDFXclB5WFpBZEprUldSNFdjYTdjeVlwUXJQZnlkWElKTWk0dmtuTGIyQlBG?=
 =?utf-8?B?VnJ2WkZYaldZL1FwOGFsQmFqcnhBZDBKK28wUFBQTWhDcitaNEkzenNDQUgz?=
 =?utf-8?B?aG5kZGQxMFkvaHh2Rnp5Nm05eTZxQk5YM3BqTUI0ckxxOEFyaEhuOXh0QVhl?=
 =?utf-8?B?dFlxclFuUStteUl2MFBwaU9sWkpZOE1Tc3VCaEVNbmhuaUpnOGhkYm1BMzAr?=
 =?utf-8?B?UlFMcU1Ia0Vsb0VqMGQvOEJGTWVFZXk3T0R1KzZjY29GNlNoWDdBOUVvWHlK?=
 =?utf-8?B?OVBzQnhqQnZyeEQrMHlYaDE1ZUgvNlB4RFhvQ09mM2F3clAvcEZxWmZVZWMz?=
 =?utf-8?B?UW9NS1FjWTI1UTJKUGNaMW10cTlOOTgyeXVSclhqbnRycldPSVNuOUpNS2FL?=
 =?utf-8?B?WlR1Q0F0Y1lTSFp1S2svT1pSYXNNdHdZem5OSHpqaS91dGtuQktXdytpYm5Y?=
 =?utf-8?B?dkdLU044WUxWTnFWbFVnMU05UmVUcDFXZFg1S1dTbEJXTE5peFZveGZrU0NU?=
 =?utf-8?B?MTg4WnRLVG1nMUFOZkJwbWRoU2xWa3FCcXpqbytQN1pxVW9TNFFkNmdBdEJ4?=
 =?utf-8?B?Z1BldTVtNXA0anlWWWZaMlVMREV5RHpNWVcrVDJaU0hHcHc2TTdxRlpRdWtB?=
 =?utf-8?Q?lP+lwJcTmNEr/YEvXUvVKdvl8RAms3rno0tjyGGXl6xT?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ca7a24-ed66-42c4-f79c-08dad58d5edc
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2022 00:20:38.5772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CD0sfC3cGO38y0aWLAB23kJJyjWvn7PTKafedVEriEv/LODUHhUAI1XRNZdXs2omUtkaVvHbB+3SdseLKHH6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB7170
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Dec 2022 17:14:36 +0100
ojeda@kernel.org wrote:

> From: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
>=20
> This macro provides similar functionality to the unstable feature
> `concat_idents` without having to rely on it.
>=20
> For instance:
>=20
>     let x_1 =3D 42;
>     let x_2 =3D concat_idents!(x, _1);
>     assert!(x_1 =3D=3D x_2);
>=20
> It has different behavior with respect to macro hygiene. Unlike
> the unstable `concat_idents!` macro, it allows, for example,
> referring to local variables by taking the span of the second
> macro as span for the output identifier.
>=20
> Signed-off-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> Reviewed-by: Finn Behrens <me@kloenk.dev>
> [Reworded, adapted for upstream and applied latest changes]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/macros/concat_idents.rs | 23 +++++++++++++++++++
>  rust/macros/lib.rs           | 44 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
>  create mode 100644 rust/macros/concat_idents.rs
>=20
> diff --git a/rust/macros/concat_idents.rs b/rust/macros/concat_idents.rs
> new file mode 100644
> index 000000000000..7e4b450f3a50
> --- /dev/null
> +++ b/rust/macros/concat_idents.rs
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use proc_macro::{token_stream, Ident, TokenStream, TokenTree};
> +
> +use crate::helpers::expect_punct;
> +
> +fn expect_ident(it: &mut token_stream::IntoIter) -> Ident {
> +    if let Some(TokenTree::Ident(ident)) =3D it.next() {
> +        ident
> +    } else {
> +        panic!("Expected Ident")
> +    }
> +}
> +
> +pub(crate) fn concat_idents(ts: TokenStream) -> TokenStream {
> +    let mut it =3D ts.into_iter();
> +    let a =3D expect_ident(&mut it);
> +    assert_eq!(expect_punct(&mut it), ',');
> +    let b =3D expect_ident(&mut it);
> +    assert!(it.next().is_none(), "only two idents can be concatenated");
> +    let res =3D Ident::new(&format!("{a}{b}"), b.span());
> +    TokenStream::from_iter([TokenTree::Ident(res)])
> +}
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 91764bfb1f89..15555e7ff487 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -2,6 +2,7 @@
> =20
>  //! Crate for all kernel procedural macros.
> =20
> +mod concat_idents;
>  mod helpers;
>  mod module;
> =20
> @@ -70,3 +71,46 @@ use proc_macro::TokenStream;
>  pub fn module(ts: TokenStream) -> TokenStream {
>      module::module(ts)
>  }
> +
> +/// Concatenate two identifiers.
> +///
> +/// This is useful in macros that need to declare or reference items wit=
h names
> +/// starting with a fixed prefix and ending in a user specified name. Th=
e resulting
> +/// identifier has the span of the second argument.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// use kernel::macro::concat_idents;
> +///
> +/// macro_rules! pub_no_prefix {
> +///     ($prefix:ident, $($newname:ident),+) =3D> {
> +///         $(pub(crate) const $newname: u32 =3D kernel::macros::concat_=
idents!($prefix, $newname);)+
> +///     };
> +/// }
> +///
> +/// pub_no_prefix!(
> +///     binder_driver_return_protocol_,
> +///     BR_OK,
> +///     BR_ERROR,
> +///     BR_TRANSACTION,
> +///     BR_REPLY,
> +///     BR_DEAD_REPLY,
> +///     BR_TRANSACTION_COMPLETE,
> +///     BR_INCREFS,
> +///     BR_ACQUIRE,
> +///     BR_RELEASE,
> +///     BR_DECREFS,
> +///     BR_NOOP,
> +///     BR_SPAWN_LOOPER,
> +///     BR_DEAD_BINDER,
> +///     BR_CLEAR_DEATH_NOTIFICATION_DONE,
> +///     BR_FAILED_REPLY
> +/// );
> +///
> +/// assert_eq!(BR_OK, binder_driver_return_protocol_BR_OK);
> +/// ```
> +#[proc_macro]
> +pub fn concat_idents(ts: TokenStream) -> TokenStream {
> +    concat_idents::concat_idents(ts)
> +}

Reviewed-by: Gary Guo <gary@garyguo.net>
