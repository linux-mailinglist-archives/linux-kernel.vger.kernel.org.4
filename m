Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B9E6CF494
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjC2Uf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjC2Ufy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:35:54 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2138.outbound.protection.outlook.com [40.107.11.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CD35FC8;
        Wed, 29 Mar 2023 13:35:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty3sttnTVjhRH7hjMd8Ch2OfY2AwfuqXv60QJWHIGs+MEfSs3bQjBP9b5WSPfy+Ske+9u4S0V4ErA8WbOdBSzR6WuB3ZMKONvFDkbbOYMd3rc6tmMpgoRs+iAY3rQxFWIY61jV6nF+H0K2sWw1l/5n82K0cHyZEVw0YHlHy8AexLRoMmlWyRmOc24Nm7t24ODTqicvsBnkFKyEarKcKEKAzAEKpfUWUYxQ5IjiVfM2tGLL+b8ScJSz22TBO9LF0KYyvm2aZNMgWJTdbqW8UFUd5qUMs4kNzyDqWtq1K/m5ReKAFrPY5reMIxxHgMFHIx2EFTPeoX2OjSKEao5tBYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOWnJCiEuqmlpD59WoIO29Tsi877ws8Y+7UVaMPoA2U=;
 b=deDMf+pY0lIgvW9+lpACBQXgnqRbCay5I+sJkDJR9wQK+nUd2zi/wFXe34C+tiPMynEr7mtbKQUzShoCXaU1f3dgoEiIboPvIX+JAHuULnhwVKeToeQ8Sftpq2xA0W0SH0owX88p6U0J8PZsrnGBG9rFnResyJJCwHJiftfhSwyezHDAvQ/8H/E+Y4vkS+1C/j8sX7M/Cduzr/8mFD1hWbc4oNoNExajJxeRGVP8w+2UgUymrj5krBPuDYtdXjaTchDytd7Mt8zJtju6trUDtoP4EaaNy2OiOfL5NWQtKF9UZIRuX9FPIdmiPj3ALIXtoWcsCDZqeCj961TuEK7THg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOWnJCiEuqmlpD59WoIO29Tsi877ws8Y+7UVaMPoA2U=;
 b=CBsf6zjmVE7uTxBFqqL+SyPpOj48hJxCYaqy/H352GFMuyPfbiNI973z4XsAuUa5aoTDtBPHD8CWROrf42JRvP2ltKT3kcrXERckKcvE/rBf262YwGZhMZhdC7ktWQlj9/F7H0v8QvrEUdN/dQ3LookYl7n3vicAH53ap3HFP0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB5984.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:35:50 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 20:35:50 +0000
Date:   Wed, 29 Mar 2023 21:35:48 +0100
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
Subject: Re: [PATCH v2 3/6] rust: error: Add Error::from_errno()
Message-ID: <20230329213548.14a47ede.gary@garyguo.net>
In-Reply-To: <20230224-rust-error-v2-3-3900319812da@asahilina.net>
References: <20230224-rust-error-v2-0-3900319812da@asahilina.net>
        <20230224-rust-error-v2-3-3900319812da@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0334.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::15) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: f2521da6-f3d4-4bf9-54b4-08db30952f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KArt71kFeW6oabsjEqqBDOfYBiqBuGq0QwuCYo+hawEccwTJCZTikfVG+MQSF2uunQjix8L34vUHXxntR4knZ/a9jip9AYKWOl0fW29dS75nWs+zVjLtGMqvDwvfp3F+cYJ/2DA+gupauZ1a/dz3XFetPiC0epTLCpPI/yQF3FAbCPb3mrziFF6aHKkXFkyFh2mPcHaiFqDpCY1j8nvMXU0uApBOh7UoAR1YSlzaFGl8A1XVqxvGXRVLHt/lErv/5VOWD/ksbumblV6yVITG4GT+U02Gn+FIoH8WzVtt0I51lit62e7WTcC2P1TNleuapKZk0QRxhjuXxs7E6SowO+sF0T4weWi2wOxypaNbez9xOK3LR42S75ZcyWD8KB/k8CFGJ4OibQftRQ/sIB+tJ18sB+ID3qyerqgzUdFtRgc5QLSvpKFl1h6E5LyYLhDBd98klyCMBy75ErK6xXsXy1fVxBNZwYYFz6VWQ92AUbvebnNnymwHuDhIn/zYNr7TEEaasVJXzAonYnzWWZNJyKBr6H2Ayn4mHZeRnf53Xh93jUSemzqZeX+GV9Egh0XE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39830400003)(396003)(451199021)(6486002)(478600001)(6506007)(6512007)(54906003)(186003)(4326008)(5660300002)(41300700001)(2616005)(8936002)(7416002)(2906002)(1076003)(26005)(316002)(38100700002)(66946007)(66556008)(36756003)(8676002)(66476007)(6916009)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w1ZswPClcfZ6Z3219uqgYw20V1Xc+SToR2Bjv7XxfDFROHebtkzjALRl6esp?=
 =?us-ascii?Q?NMjF3UPPpGeRhHgXXCBMyFS6sMTwUWix/N4PS4p2b5E7GxS/xy0PXvslv1pV?=
 =?us-ascii?Q?xTmtyh6c0bHe7oGjsvdwUPWvTDguHDeVsXhudu6PbD8OQVAXw4p/TMwwf7I4?=
 =?us-ascii?Q?rYbjYpper6u+kQpQ2o8nJzUcymBlW2YRtaFtS//VfOARtpbZBtX+NNXBqkw5?=
 =?us-ascii?Q?tpGn47Yv5e5+3qi+eTR9yxNO9nnSlTP45du24Dl9LUmkp5/gaIymKvI4T+7Y?=
 =?us-ascii?Q?+ckafY6L1uiZPa5+mwgIK03g+NwU28x9i1FzpWsAtcNI15YHiiLgC09v10az?=
 =?us-ascii?Q?v00GHpgAUOE95KgKXGlidmq9uMBVbcBoRog/KpqTMLwbILCS7+bG2uMehDfl?=
 =?us-ascii?Q?zxDe0buMMvLUnTO8bUwnsDCvq7EftAYhVSoF5XyunmKyCNt0qAMxz5JoUlXu?=
 =?us-ascii?Q?QorKgFALz5iR0I+zix9Jnl2QMQP8mb8lh58by4w0KLpDGCxylDR2YW2r2W90?=
 =?us-ascii?Q?PUmo0ggNFrhokZHLkPkA9xgc4t0KQtF9RcruQrKSY0BjmEQETXlxGVYzJfRw?=
 =?us-ascii?Q?caKRlluxbchskA8H9GT0DqbPFpCKRVie+n/9Za+qxabh+kgYs4xta0R2hqNd?=
 =?us-ascii?Q?eS3pM9F7owHk1XuUm6Kpb0JnhKnpLM/NntoBJvy6u5XJaan5gt4SQuUppbm3?=
 =?us-ascii?Q?qlFzpVELEwfFO4NpKRTiQhnT74ilkIW0v2BVDBNcNW3HK8WBjXpgeYdbo0ZY?=
 =?us-ascii?Q?UmOc4gdw+f6e3pdbh66cb+p0HqDi0ACSDAGba5bIJIH72ZxbqIlEgQ+JJVxR?=
 =?us-ascii?Q?eeDUfBeXvXEx3P9E3Fjipz6FB/3D1SkY+0cWYdCHyQEi+DYxAGJwrZ5xce0b?=
 =?us-ascii?Q?OYUNSnUbH5hGTTEkZBRH60vRKP5rTbq0gComZxzeszZWRu5pn1roXmOeS4Zd?=
 =?us-ascii?Q?21Mugll5XDl+PesMAi702ymHed7vTOYeuhruwzvDnEpKu4Ivse5bzzA0Rpyx?=
 =?us-ascii?Q?/fDs5bp9Ft8DB/1x+nf+ux0nW15Zi14SxczeyXVLiwcn5pBlExlPgfSC84Uj?=
 =?us-ascii?Q?W14ZTesG/395olxuYhdBapIvim8tJyepkGMbnm3aBomcz5F9xfAyt50CTYj7?=
 =?us-ascii?Q?YMlMd3iE50QLV+Ok0W4swTQGxkcozSjEVPGpUtoBFNk7WoeYQV9l/mJ3xqk4?=
 =?us-ascii?Q?hByfwdeCwE3pJSgfYr+dlHYxmu+W37ghVX3Mto8OaFD5JeDW3LoICvbaEKNA?=
 =?us-ascii?Q?mbMFhF01oGGP1PxUGT73ImTE4J+8WIVBtwh96XActMAVVH4QCfKNSekebssl?=
 =?us-ascii?Q?E+ar9MghmjWZSRDUSu9ZVV7sw6agg3XsgLy4gaR1KkH+0mlWHuGl4RJ1pydr?=
 =?us-ascii?Q?c2eXGFIoiHObu2K74fFyA19CesmTfhXgPeW4lHdo32gmtTZHlGqoTfLuzv12?=
 =?us-ascii?Q?ezofa3n7qLVpx3mMfIrPgFL/d9x3p5g/8n9sjZWbearYWkYdAArFGJ1hU/oh?=
 =?us-ascii?Q?RGCeAy0p8eOsbdx/DqUECw+MCuQ7LYnF1oLj6ciGqR1zW3KcFIEP2wq26dUl?=
 =?us-ascii?Q?2H0eFOUcqSZTFQlHT4PZI8eIS1B+7cd4f1UwI5jh?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f2521da6-f3d4-4bf9-54b4-08db30952f06
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:35:50.1282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7H8HC6GepUOQO2c3DN3htNfTj0r9imSfq26ZJFqGd/cN5tBoySvI9FM3aSc2ZIp44biG2wpgiNcc8BzXZmDY/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB5984
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 21:04:35 +0900
Asahi Lina <lina@asahilina.net> wrote:

> From: Miguel Ojeda <ojeda@kernel.org>
> 
> Add a function to create `Error` values out of a kernel error return,
> which safely upholds the invariant that the error code is well-formed
> (negative and greater than -MAX_ERRNO). If a malformed code is passed
> in, it will be converted to EINVAL.
> 
> Lina: Imported from rust-for-linux/rust as authored by Miguel and Fox
> with refactoring from Wedson, renamed from_kernel_errno() to
> from_errno().
> 
> Co-developed-by: Fox Chen <foxhlchen@gmail.com>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/kernel/error.rs | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index e97e652a1aec..659468bd1735 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -72,6 +72,25 @@ pub mod code {
>  pub struct Error(core::ffi::c_int);
>  
>  impl Error {
> +    /// Creates an [`Error`] from a kernel error code.
> +    ///
> +    /// It is a bug to pass an out-of-range `errno`. `EINVAL` would
> +    /// be returned in such a case.
> +    pub(crate) fn from_errno(errno: core::ffi::c_int) -> Error {
> +        if errno < -(bindings::MAX_ERRNO as i32) || errno >= 0 {
> +            // TODO: Make it a `WARN_ONCE` once available.
> +            crate::pr_warn!(
> +                "attempted to create `Error` with out of range `errno`: {}",
> +                errno
> +            );
> +            return code::EINVAL;
> +        }
> +
> +        // INVARIANT: The check above ensures the type invariant
> +        // will hold.
> +        Error(errno)
> +    }
> +
>      /// Returns the kernel error code.
>      pub fn to_errno(self) -> core::ffi::c_int {
>          self.0
> 

Reviewed-by: Gary Guo <gary@garyguo.net>
