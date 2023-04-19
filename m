Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F2C6E79D3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjDSMiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjDSMiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:38:08 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2100.outbound.protection.outlook.com [40.107.10.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A5183;
        Wed, 19 Apr 2023 05:38:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sy91eoBkl5smra0SrJG3tci97AzaC8/gJzFa3OSvKEOQyyewORFGuiDCLu164aQLmzs4KWj3YtOJSbknhbYo60g5GIj0VW2nhU2m94D0VLkSB4ZeZtqFA/PwQbMvEYOgsx25NRkG1dXTFP+/xtjD4y6EyAum46Kv61Nrp7BPmRqUJqlYawJ8fXk7+ngOXKrwGxP3Zi6+fWr0SWAjBdYeKRKV7FZBNjcZOO4MNC6vBSCwwKRDVEy9ZIf4HkN4Q0L8K8EGKFy0nEjrHl9zKKH4YHJBHSinNIkyhbSMRxw9AKSHXRXd+y5wOBChkzjaz5uvAmyWjmsXJjIm2b5bzZiHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96CxkOnVD7MyCxUKu39s8yzmocls13zxOdopgrCIdDI=;
 b=ak/uFp8Kfq5yRvKgtCcLpPA1NeOPD40P73PUHakLeQveP1yt1nz7Zc3C9Y/dJqDf+ptIToJrgd3ydsO66ABw5g6js/8cgRagZXlrLuyQJkIDikIaqNgu0QKpXAr6PT3JvGJOPNoWj22FYfLj6a9QcxcHHrPJDo+uWhSVm38SmE5UrKyHucevmfgPtYKS5xpRmgdz3xN9N6g0hBnpVQ8IXf71GxYI/TDBXt7VJkMtsesCX+3qvwm79eg7MSzZn2QZOJuWMPAbAk3ixolYEVV1DIYP4e6SUnSeKySp225DXklBYszNsv9i1TQRrdoCU89YUmuDsgaLdmDUrPsa9Ilo1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96CxkOnVD7MyCxUKu39s8yzmocls13zxOdopgrCIdDI=;
 b=CdnIx+qe4vWTnAflx4OdtD/eLISnUWJCExty8ryU2Jj1RXeiirbsh4J+El6VqlSi2fcfZxqilxbUoK4XVsZSznLCMm8v8zxjI06vxTvYlHXZtaMvdKAR0CzsmzHbsY9/a2T7sU8ttUBm9qcatCmrGOiYYGEpy1/FQ+QVWKAYaVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15f::14)
 by CWLP265MB4971.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:13e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 12:38:03 +0000
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1b25:7ea3:7339:6a0f]) by CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1b25:7ea3:7339:6a0f%4]) with mapi id 15.20.6319.020; Wed, 19 Apr 2023
 12:38:03 +0000
Date:   Wed, 19 Apr 2023 13:38:00 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Josh Stone <jistone@redhat.com>,
        William Brown <william.brown@suse.com>,
        Georgy Yakovlev <gyakovlev@gentoo.org>,
        Jan Alexander Steffens <jan.steffens@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 3/3] rust: upgrade to Rust 1.68.2
Message-ID: <20230419133800.0da0857a.gary@garyguo.net>
In-Reply-To: <20230418214347.324156-4-ojeda@kernel.org>
References: <20230418214347.324156-1-ojeda@kernel.org>
        <20230418214347.324156-4-ojeda@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0411.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::20) To CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:15f::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB5186:EE_|CWLP265MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8787f0-8fbc-465d-38b9-08db40d2eab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzDZRhGWlroJvRboNUMaiIZKwVF2X92exqbq9sKMgyjqWLmudsrLjVWlnMA27pfaGKYtbpnN9wERRG/RofX/6yPbPaDXPcnAfoSeiokehdqQsLNgaWGYa1OuOmj/Us7YDLB2VlEyS/qx0uxvq+z+nKZrhUxoez+LkHsOLOjShI8qa0sVPVOFwyMhVms7L+Ak/+iGz4Dd6WNEhdT+qO0ZChq1UfgUUEh4Jr/WNq9b83NpPRdMSvCtW9xdlMBMHc4RbxMPk/U8qlHQh/0qkVM3Est9JtmIGNBN9yV7MRD3ScX62mPjFN9pzgKLnbgoGOR/OCDbbs65IXWdpx7xGNPjbpPtT9nqGqbYfCiuJcngCbGiTxpyYkZmjE6A2u2JpJ5/MWXzJCAZcAq0N58ad5uc4SM7iKnZGqUdsM4P44EWawDUQa86chIAR/3GV6N2lzGkP3l1pg5y8fVNewRed9exILeEKsBydgt53Vsqp9icgAjDteRTrwI7gvWOjQpLGC1fnDAfigg0sFfTJ6cuaQrcq5jdOSUiene8FM2xAk8oiiA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(136003)(346002)(366004)(396003)(376002)(451199021)(5660300002)(7416002)(8676002)(8936002)(41300700001)(6916009)(316002)(4326008)(66476007)(66556008)(66946007)(2906002)(66899021)(54906003)(478600001)(86362001)(26005)(38100700002)(966005)(36756003)(6486002)(83380400001)(6506007)(1076003)(186003)(6512007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J0fLGQiH3VguQt8O14zXtuwC0M3JRN3X6+mYu08aLqECWayV4NoCITsGwDR3?=
 =?us-ascii?Q?VwlY4nynPM9pc2tk8kI6WdTfoQXp6S0f+zyoAiGSj/YQkIaTZBDiWuWd5Muk?=
 =?us-ascii?Q?eG3N5qr36v3Bb5EmlqiyeUWRVPeyUXdg245uAbMwp4pNAPjwRGrsP2Ccn76E?=
 =?us-ascii?Q?0EP/ITWKncBgI8lfDw+Q6gf2MgGNZC5e2BdQq7q9aynkU7/NQsmRJqHwNT1G?=
 =?us-ascii?Q?8/BMfhn4+G+Hqa+w27BmDzCEyfcerPrp0SOeC6J5nq71OuelZ5vIK8fBiFEH?=
 =?us-ascii?Q?OTC0HGD54cn3H7Oydz7Mx5yST4WV6gd9X+2WOnoX07LAno8RTYOe1AMiZQom?=
 =?us-ascii?Q?afId+itn5a54JeO8GTYyY5LbzbNTlkqpCuo1du14j9cZ3INtxzfMSAs+9f1w?=
 =?us-ascii?Q?qpKlNzHbLeOT9GmOO5FSQoG+fQ4t18L5qR+dCsx9SSeHkP/+/fZYT8O1pLou?=
 =?us-ascii?Q?/PMOPSGRAUcF9iH3cwB6L9Ax7Pd6SBqYftqLwjCKJaL6yfYtZ/oyoLGA74pm?=
 =?us-ascii?Q?KaF7gjmZ6oLtmP52PNDpRjrod5LaipVbLSiAdpsGiYCSyP8cHTGjDI2Bzx9w?=
 =?us-ascii?Q?9TglLN+c+cjVjFewcLa0jyu9SRQsOCwTEkY9h03ZLBlL9H/xV9OqkV9KPFPF?=
 =?us-ascii?Q?66t+WJFg4sQ/wgvD5uhyI38ptHBaRj23AbI5UsfYT1b9l4xiI/oFQXGa6ZaI?=
 =?us-ascii?Q?Q69tOUz/QUa9aVe4+wbo5GOcDuZiLZ7vD+/uStrpZXkozaaESva9MmbiC51F?=
 =?us-ascii?Q?c6zXj9Pga3kVub938BuGqdN6t4ID4Qy+up17cupvFQnuJLHa3NglG4zHgKFT?=
 =?us-ascii?Q?tK2ZJEY+sOhRk7uoyjRyrNlVPuF1wcw4qUj7P9Fm3AqbiTdRLmD2tm8w7GXC?=
 =?us-ascii?Q?/SkTpADN+E/lpd9ZgZmc+dPNn8Tzz1ClvOMw28QOjlk3J1jTOYeknxwxHosD?=
 =?us-ascii?Q?TrUjC3u4MsrwZFMg+8xXP/5ruTqkmz80mHXAgsXvdbqbPiYQi3P639+jKoJt?=
 =?us-ascii?Q?3d5UIt5bz8mlXlJLEJJAEGRC/vPQNOxG2nRjzcDPqlktDcDIdN7uwgmuYHED?=
 =?us-ascii?Q?ajHyR7EaF7GeBAPqlNQcAD20SMrxLHqR7hU7JKYTx0DOScUPozyILKLEKnY3?=
 =?us-ascii?Q?kXCU7/20glGKUauSE89khxsa3Qq/AvnFcR6e1GiNfz/98V7LN+BXPRx6Dazx?=
 =?us-ascii?Q?932GxLvO96yQv1yoalfe4vvMx+fkfLmqftv+isXAfdlp9KnuIGdTvxnmYViU?=
 =?us-ascii?Q?2xOkcrlCDuQCK71B0Wg7y9kQ4GDeiFqDVSpi9VWHFNJPTljZAQPjfmPC8Inz?=
 =?us-ascii?Q?I0zD9yvzQT8nIiPNRIT6H8ALqRtn44NTXMaEFWFpXfT6pMr8Nau1YdH+kLiS?=
 =?us-ascii?Q?h19Jb0KfkQUAByViXyaoI4fRv1GVNW58QtsTvGPqkZdo7z854u/TX9v5ko0e?=
 =?us-ascii?Q?I0k8roaBior5j/AM7+R1PUyeS8GyQp5uYSCRzr65VznGnyOIkHqOIHn06Fgc?=
 =?us-ascii?Q?y9GEuZ0qcVu8o3V1E0zep6ct7CCwCz+jRElXKAz6viOFnqGO+qk8d5YXCkVF?=
 =?us-ascii?Q?UfDJ8vR05bNy/xaWACCMybKneLsUAIWw07s6kCvt?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8787f0-8fbc-465d-38b9-08db40d2eab7
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 12:38:02.9619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVecpYUTmOYAoGmuDw/ibTKaMsHKXcKaV+s2DefjoZNQO2NdC/RkTXLVLMbKXuAAUJe8O8z+RwRol/2+ttAAug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB4971
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 23:43:47 +0200
Miguel Ojeda <ojeda@kernel.org> wrote:

> This is the first upgrade to the Rust toolchain since the initial Rust
> merge, from 1.62.0 to 1.68.2 (i.e. the latest).
> 
> # Context
> 
> The kernel currently supports only a single Rust version [1] (rather
> than a minimum) given our usage of some "unstable" Rust features [2]
> which do not promise backwards compatibility.
> 
> The goal is to reach a point where we can declare a minimum version for
> the toolchain. For instance, by waiting for some of the features to be
> stabilized. Therefore, the first minimum Rust version that the kernel
> will support is "in the future".
> 
> # Upgrade policy
> 
> Given we will eventually need to reach that minimum version, it would be
> ideal to upgrade the compiler from time to time to be as close as
> possible to that goal and find any issues sooner. In the extreme, we
> could upgrade as soon as a new Rust release is out. Of course, upgrading
> so often is in stark contrast to what one normally would need for GCC
> and LLVM, especially given the release schedule: 6 weeks for Rust vs.
> half a year for LLVM and a year for GCC.
> 
> Having said that, there is no particular advantage to updating slowly
> either: kernel developers in "stable" distributions are unlikely to be
> able to use their distribution-provided Rust toolchain for the kernel
> anyway [3]. Instead, by routinely upgrading to the latest instead,
> kernel developers using Linux distributions that track the latest Rust
> release may be able to use those rather than Rust-provided ones,
> especially if their package manager allows to pin / hold back /
> downgrade the version for some days during windows where the version may
> not match. For instance, Arch, Fedora, Gentoo and openSUSE all provide
> and track the latest version of Rust as they get released every 6 weeks.
> 
> Then, when the minimum version is reached, we will stop upgrading and
> decide how wide the window of support will be. For instance, a year of
> Rust versions. We will probably want to start small, and then widen it
> over time, just like the kernel did originally for LLVM, see commit
> 3519c4d6e08e ("Documentation: add minimum clang/llvm version").
> 
> # Unstable features stabilized
> 
> This upgrade allows us to remove the following unstable features since
> they were stabilized:
> 
>   - `feature(explicit_generic_args_with_impl_trait)` (1.63).
>   - `feature(core_ffi_c)` (1.64).
>   - `feature(generic_associated_types)` (1.65).
>   - `feature(const_ptr_offset_from)` (1.65, *).
>   - `feature(bench_black_box)` (1.66, *).
>   - `feature(pin_macro)` (1.68).
> 
> The ones marked with `*` apply only to our old `rust` branch, not
> mainline yet, i.e. only for code that we may potentially upstream.
> 
> With this patch applied, the only unstable feature allowed to be used
> outside the `kernel` crate is `new_uninit`, though other code to be
> upstreamed may increase the list.
> 
> Please see [2] for details.
> 
> # Other required changes
> 
> Since 1.63, `rustdoc` triggers the `broken_intra_doc_links` lint for
> links pointing to exported (`#[macro_export]`) `macro_rules`. An issue
> was opened upstream [4], but it turns out it is intended behavior. For
> the moment, just add an explicit reference for each link. Later we can
> revisit this if `rustdoc` removes the compatibility measure.
> 
> Nevertheless, this was helpful to discover a link that was pointing to
> the wrong place unintentionally. Since that one was actually wrong, it
> is fixed in a previous commit independently.
> 
> Another change was the addition of `cfg(no_rc)` and `cfg(no_sync)` in
> upstream [5], thus remove our original changes for that.
> 
> Similarly, upstream now tests that it compiles successfully with
> `#[cfg(not(no_global_oom_handling))]` [6], which allow us to get rid
> of some changes, such as an `#[allow(dead_code)]`.
> 
> In addition, remove another `#[allow(dead_code)]` due to new uses
> within the standard library.
> 
> Finally, add `try_extend_trusted` and move the code in `spec_extend.rs`
> since upstream moved it for the infallible version.
> 
> # `alloc` upgrade and reviewing
> 
> There are a large amount of changes, but the vast majority of them are
> due to our `alloc` fork being upgraded at once.
> 
> There are two kinds of changes to be aware of: the ones coming from
> upstream, which we should follow as closely as possible, and the updates
> needed in our added fallible APIs to keep them matching the newer
> infallible APIs coming from upstream.
> 
> Instead of taking a look at the diff of this patch, an alternative
> approach is reviewing a diff of the changes between upstream `alloc` and
> the kernel's. This allows to easily inspect the kernel additions only,
> especially to check if the fallible methods we already have still match
> the infallible ones in the new version coming from upstream.
> 
> Another approach is reviewing the changes introduced in the additions in
> the kernel fork between the two versions. This is useful to spot
> potentially unintended changes to our additions.
> 
> To apply these approaches, one may follow steps similar to the following
> to generate a pair of patches that show the differences between upstream
> Rust and the kernel (for the subset of `alloc` we use) before and after
> applying this patch:
> 
>     # Get the difference with respect to the old version.
>     git -C rust checkout $(linux/scripts/min-tool-version.sh rustc)
>     git -C linux ls-tree -r --name-only HEAD -- rust/alloc |
>         cut -d/ -f3- |
>         grep -Fv README.md |
>         xargs -IPATH cp rust/library/alloc/src/PATH linux/rust/alloc/PATH
>     git -C linux diff --patch-with-stat --summary -R > old.patch
>     git -C linux restore rust/alloc
> 
>     # Apply this patch.
>     git -C linux am rust-upgrade.patch
> 
>     # Get the difference with respect to the new version.
>     git -C rust checkout $(linux/scripts/min-tool-version.sh rustc)
>     git -C linux ls-tree -r --name-only HEAD -- rust/alloc |
>         cut -d/ -f3- |
>         grep -Fv README.md |
>         xargs -IPATH cp rust/library/alloc/src/PATH linux/rust/alloc/PATH
>     git -C linux diff --patch-with-stat --summary -R > new.patch
>     git -C linux restore rust/alloc
> 
> Now one may check the `new.patch` to take a look at the additions (first
> approach) or at the difference between those two patches (second
> approach). For the latter, a side-by-side tool is recommended.
> 
> Link: https://rust-for-linux.com/rust-version-policy [1]
> Link: https://github.com/Rust-for-Linux/linux/issues/2 [2]
> Link: https://lore.kernel.org/rust-for-linux/CANiq72mT3bVDKdHgaea-6WiZazd8Mvurqmqegbe5JZxVyLR8Yg@mail.gmail.com/ [3]
> Link: https://github.com/rust-lang/rust/issues/106142 [4]
> Link: https://github.com/rust-lang/rust/pull/89891 [5]
> Link: https://github.com/rust-lang/rust/pull/98652 [6]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

I took this opportunity to re-review our diff with upstream alloc crate.

All the try_ series methods added to `Vec` and `RawVec` looks correct to
me.

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  Documentation/process/changes.rst |   2 +-
>  rust/alloc/alloc.rs               |  55 ++--
>  rust/alloc/boxed.rs               | 446 ++++++++++++++++++++++++++--
>  rust/alloc/collections/mod.rs     |   5 +-
>  rust/alloc/lib.rs                 |  71 +++--
>  rust/alloc/raw_vec.rs             |  16 +-
>  rust/alloc/slice.rs               | 447 ++++------------------------
>  rust/alloc/vec/drain.rs           |  81 +++++-
>  rust/alloc/vec/drain_filter.rs    |  60 +++-
>  rust/alloc/vec/into_iter.rs       | 125 ++++++--
>  rust/alloc/vec/is_zero.rs         |  96 ++++++-
>  rust/alloc/vec/mod.rs             | 464 +++++++++++++++++++++++-------
>  rust/alloc/vec/set_len_on_drop.rs |   5 +
>  rust/alloc/vec/spec_extend.rs     |  63 +---
>  rust/bindings/lib.rs              |   1 -
>  rust/kernel/build_assert.rs       |   2 +
>  rust/kernel/init.rs               |   5 +
>  rust/kernel/lib.rs                |   4 -
>  rust/kernel/std_vendor.rs         |   2 +
>  scripts/Makefile.build            |   2 +-
>  scripts/min-tool-version.sh       |   2 +-
>  21 files changed, 1274 insertions(+), 680 deletions(-)
