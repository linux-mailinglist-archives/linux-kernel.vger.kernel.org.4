Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D70C6A25A1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 01:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBYA3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 19:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBYA3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 19:29:51 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2101.outbound.protection.outlook.com [40.107.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF88F2942D;
        Fri, 24 Feb 2023 16:29:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bloUKFTHdxKbTE7js/J5ydal8sB6kQ68/iS8+U/P2ga4ECCdv8w2q3uSdzfmaYQj/z97XhMRk5dypS3PQnsj8wGdJukUfeNJ55kt9iMe9rOZGq/uDAzPfpQQFtSxGH0VYZtPX+wM9d9yPJblQuTTWbL361X9MGsHBVhEjEPjJlTMLzBGc7RKplSw/SreXWbSEaLDOi1GIWM9YgGRCJUj+LIsLzsxvsgoSJmP58j1QOGEksllhCgCL8rQvBBI1Hv8mVI37KzbseyCOi56C72cmSBOyKYYS+JMIbhTlFPF4VrBP/RD+lmXuT8aYkOSaeLPtk2gmHWJhFieqGWhoic9aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGyowKTrdlChRzyX3cHkInL9Sj5Sx+n8EeuF00g/d0k=;
 b=Fsv7jWl+Z7c7PAXd65/bKYKFQ1mnAo7pIbfYTA5zDkDw8D+zd1MIu6FaqctGQDxssXFvjiofNhsdgkkayQriOuY+pTK2KLwWMjQYEktKZRYwJ2npOr0hdvsiKCyS2PQXWhw0YFqeDKLcfD/ljI2O7+UybsDTDF7TJtVb+3pOvHsF+sf+Qn5MR8qLGeey8YwbQwDyAiEDK1E/fn6uQwDQJeBhlRw0vyYl+5NAGgRgUeAXRWxmaYWFYuYNWrkZXCF6k6Khuf7/FMxLfhQrSdQD8HM9s3YcHd4/CQN2hqVopTqwSPLyVlNvm84n4hp3VyfAkgC7bqFPD3D1FOXnSyx6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGyowKTrdlChRzyX3cHkInL9Sj5Sx+n8EeuF00g/d0k=;
 b=hB8G7ptvPrbRO6IKVaSJFsJXqKdGaRPoUfK+JyOkX8LTjeXVzvJ/UYF9YUq6R+zZcwnv81ltXY6+FJyNd8ZFE1HiaCHpu9i2gVvClRXB21MW4n4NddnxbaY+13niIkLo595W6MeuEm2t0/UPiIEjanBy1spN1p28Kv44DAcgkhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6222.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Sat, 25 Feb
 2023 00:29:20 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:29:20 +0000
Date:   Sat, 25 Feb 2023 00:29:18 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH 1/3] rust: macros: Make expect_punct() return the Punct
 directly
Message-ID: <20230225002918.4cfcc4d8.gary@garyguo.net>
In-Reply-To: <20230224-rust-macros-v1-1-b39fae46e102@asahilina.net>
References: <20230224-rust-macros-v1-0-b39fae46e102@asahilina.net>
        <20230224-rust-macros-v1-1-b39fae46e102@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::9) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7b2ae2-a817-4408-e42e-08db16c755eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xdl1DhnhdfDX88KsEGgytpH5ByFBamT1lPdBN10j9gq9wlpjQ6A6ty4jHD59vNWLDIGexAjESJ0CLA5+31c7TegypEPH5PWGMFBPwd8t/nFs/ZtdarwWIxk1yO635AA7xA+DCFML+Z3nSxEDGLoRXmUU8XsjgqoVcEjQj82BF/gC6ZG9tBfHU2kjI3gwFHoYXJAxdB15+MufgZRhrCC5JCwHy4Bh6TVj181aJEZpiFRmQNgsxGpgKDTdguKla/zGdQAfGVq8WAGvK5NaFBOjzh++dmSzgrgquZsF0bbsHFfqeyFxgDKHjeVN1wR4EnAI6MYFA32Aj/eytZjYyf49NrA47VCdpNry5AVoPMSoAjyq/rWPiWmIIoC6vjKBcdxB7rJRjEP8d8HhbiYCxviqIWZtzERqFf2dIxDTfNFEAIaSofriRe34dYm0bmYf1jyEVPqkFc8L56n6LvsYRVLbOnKTlFWlnvFUAcxUfqOcVM/Xuxh5kSwK5qkiAlqV+At8D4VxHoqJ6aLiao3LQkKSFQgVlgz+tEW+iCI+0DIVJmbmWAdKGp+u1QXHizGkGOr1HA1jqrj+YbX19T4ZmvsaojPXWYMtnGJdC17YNbxYd3c6I1TIWPsVfpTAHpsk2RgYyTvIwAeP6ctOUi0YrrjkKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(39830400003)(346002)(136003)(451199018)(83380400001)(36756003)(2906002)(1076003)(6506007)(6512007)(86362001)(54906003)(478600001)(41300700001)(8936002)(6486002)(186003)(26005)(2616005)(316002)(6916009)(8676002)(4326008)(66476007)(5660300002)(66946007)(66556008)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jiMJzZ/Fd1UoAlGsS1qm1n42XRwbG71XiV6vJxsR3beM7Q1HPSg+rFEPabNs?=
 =?us-ascii?Q?BV55ogvX8TbnZa+zO2ir1AAzowMLfgNarM/LS4L1r2r7GYHWQoldjVPmQmDD?=
 =?us-ascii?Q?tmccTCyfKYRpyTef97gm3f8oZjZmCE108yKUssPJ+XtBaYHmLtesJMQifOlO?=
 =?us-ascii?Q?Ef7qkd4dsOmDBjNs+3v1CtqDOm5IJhxN4QtvvGj4bxAGUFvl8xGB1Gi3EE9Y?=
 =?us-ascii?Q?Ie+m6/C3mcB10rLdyopDtxDPBHTbX19eHTJuKZ6Fbq9DbrGy6ohatI/Ca3LY?=
 =?us-ascii?Q?FH2X65jZ2uYxK6MM2ij8nHW477R2WgP/sxO6UMlgKVt7m1KIzFcAAiySQ4+s?=
 =?us-ascii?Q?07cWIDnDXbxLzdJb9gz/eqbYRqnY41nBae4Ece6v6f3J4Zi5nkgbKIXqi2Kd?=
 =?us-ascii?Q?IJIky+t1xcT7O2nUdLa+u+Cu6INl7lbYQLcZzy9TpqJLhZ5RciSnoK//1cXe?=
 =?us-ascii?Q?s1g7J1gVqbDezPo8QhW1Dtu0HJqdYMjgxjH9AypctbP2XvSyY6p5xs8VkpBy?=
 =?us-ascii?Q?uxn3Y07quVdpVQVStryyq0WFJWEQGeQtiBLBukDprYLidyvO7v9Q7WtKHiGj?=
 =?us-ascii?Q?aXfK88GlqhSIxCAbDhQPoilFAFVTPgLW2SCyHRRo5331989A8Y6h1nEdhBL7?=
 =?us-ascii?Q?lFdnOMDJPaNMuzlPFRVRHwd3oHwWQ39sHjNFjzz0GXoQgjsRMLiRVU3DPEs/?=
 =?us-ascii?Q?fncwvH4x7S+OqBqHQPNT+z7Tc1y1l9RUU3mWs3wmjhMAWnNC2qyeV5I6cD+t?=
 =?us-ascii?Q?0PjN7Frs0IDsR/W11f8bgZZpvHn0NwUxQ1384JU2Yd0tk7uqPR0K0ptK0u3y?=
 =?us-ascii?Q?ekct1L/EzB7zNLyoQk8gj7v5McPLzjlVJfSBMrmRsAdzt/ArHZ8C6QmnXHBE?=
 =?us-ascii?Q?Jr4DK0ZT1lgPt42MZlZfgNiPpzbez0wt3wbEuUx2+9Z5OVGXYqx+mrBUIIOq?=
 =?us-ascii?Q?XPf9HWWelq3sQbC/VtTb1FaoJpbzJbL3w0OFWf1UWWP6CJxa0MBo2sMNRFAU?=
 =?us-ascii?Q?csxUGmIO8huOJfvY91u+XaGEyN58EYTR8Nzf7BMjw7u0PtFSDxTaGXFyeExS?=
 =?us-ascii?Q?qquVdbMw8zW0b9A6+ptxY5IC5ronOFmIpTJFYtXVcWpYNQFjoewIiJJtEOyk?=
 =?us-ascii?Q?6ght5BNSNYatquWuaxGTCv3Mm9W+zGnrb8hRojaQJ1wjVHdGg8nhI9/LPbh9?=
 =?us-ascii?Q?fuN79AmkyyO7sMmvrKxUFcTHLGs5BOIm+JaUClow5dilFNSvVqAm5WLOWZpx?=
 =?us-ascii?Q?PiBrOeoWHrRWaZC+8PBmA83Gemyn/7h8xv6HPBPcCuDozU0znbs0z209zYGU?=
 =?us-ascii?Q?UPa3BmkmuYS89RPUZHtdgr4kMqZEL+F7h1LBphQpKF+aPIqZJXQLK06Q7eKj?=
 =?us-ascii?Q?uyjgUURrjgkc3tXUEbC2OVrm3BaH7Ms+bHbY+mW90HrwcnjD9Rsw5gSR8U2n?=
 =?us-ascii?Q?fHDJtJpuSkUWkd5lCR40E4vJ86lU0wknozppQXz3hRfSqvFKWyLfHUeP77Ph?=
 =?us-ascii?Q?XfrwRX6Rn8djDGaI7RkdUR/oZFt/qtYDkt9rAA4YnSlub5ufEWqFKjclpOY9?=
 =?us-ascii?Q?6xWVF0Kzk7nSCd4EUGUdM3WEfCcKW2hcUUZdzgBT?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7b2ae2-a817-4408-e42e-08db16c755eb
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:29:20.0289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdZ4A98NwmXLMQLRIXOUvyaYcCtJpgonAF9mlF/57uO7SJXmVSPDmkDFA+UxqTbw4T8IRFeVkeOEpI/exdvuxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6222
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 16:25:55 +0900
Asahi Lina <lina@asahilina.net> wrote:

> This makes it mirror the way expect_ident() works, and means we can more
> easily push the result back into the token stream.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/macros/concat_idents.rs | 2 +-
>  rust/macros/helpers.rs       | 6 +++---
>  rust/macros/module.rs        | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/macros/concat_idents.rs b/rust/macros/concat_idents.rs
> index 7e4b450f3a50..6d955d65016e 100644
> --- a/rust/macros/concat_idents.rs
> +++ b/rust/macros/concat_idents.rs
> @@ -15,7 +15,7 @@ fn expect_ident(it: &mut token_stream::IntoIter) -> Ident {
>  pub(crate) fn concat_idents(ts: TokenStream) -> TokenStream {
>      let mut it = ts.into_iter();
>      let a = expect_ident(&mut it);
> -    assert_eq!(expect_punct(&mut it), ',');
> +    assert_eq!(expect_punct(&mut it).as_char(), ',');
>      let b = expect_ident(&mut it);
>      assert!(it.next().is_none(), "only two idents can be concatenated");
>      let res = Ident::new(&format!("{a}{b}"), b.span());
> diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
> index cf7ad950dc1e..65706ecc007e 100644
> --- a/rust/macros/helpers.rs
> +++ b/rust/macros/helpers.rs
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -use proc_macro::{token_stream, TokenTree};
> +use proc_macro::{token_stream, Punct, TokenTree};
>  
>  pub(crate) fn try_ident(it: &mut token_stream::IntoIter) -> Option<String> {
>      if let Some(TokenTree::Ident(ident)) = it.next() {
> @@ -38,9 +38,9 @@ pub(crate) fn expect_ident(it: &mut token_stream::IntoIter) -> String {
>      try_ident(it).expect("Expected Ident")
>  }
>  
> -pub(crate) fn expect_punct(it: &mut token_stream::IntoIter) -> char {
> +pub(crate) fn expect_punct(it: &mut token_stream::IntoIter) -> Punct {
>      if let TokenTree::Punct(punct) = it.next().expect("Reached end of token stream for Punct") {
> -        punct.as_char()
> +        punct
>      } else {
>          panic!("Expected Punct");
>      }
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index a7e363c2b044..07503b242d2d 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -104,7 +104,7 @@ impl ModuleInfo {
>                  );
>              }
>  
> -            assert_eq!(expect_punct(it), ':');
> +            assert_eq!(expect_punct(it).as_char(), ':');
>  
>              match key.as_str() {
>                  "type" => info.type_ = expect_ident(it),
> @@ -119,7 +119,7 @@ impl ModuleInfo {
>                  ),
>              }
>  
> -            assert_eq!(expect_punct(it), ',');
> +            assert_eq!(expect_punct(it).as_char(), ',');
>  
>              seen_keys.push(key);
>          }
> 

