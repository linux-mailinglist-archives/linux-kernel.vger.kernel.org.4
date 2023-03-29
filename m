Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E9D6CF495
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjC2Ug3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjC2UgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:36:18 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2115.outbound.protection.outlook.com [40.107.11.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07F45FC8;
        Wed, 29 Mar 2023 13:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSi8+VTvHayGRLho1YzQBNlJEeGq+7OJsE6YgPCysE3HIeYUCShZVmj5wtaF8MA5kDhUOgXOMimcjjbWywwtqMHuKEbx0g0jTiPkkwazr9dPJt91u9/ApeRj0SmuFkoJNMydK2JtX48we7qrBoVAbFPEr9+grsJ5lXp5nlK/NueZidPUU03EKyii/V8JnRqhZPFIQL9aFdp95yGO5jcb9wJuiodXB55mfcif7zcCHvPsgfcwlZZJ7DL64y5ucFA96GVfg8YUMzhyCwqDB/7bagNVHZJZFSXcMqDjcfyQ3kCANkglZaoc/GaU87WIJGqMsWwXrA5gO949GEqdionOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7bcpjhXazC8pVFSGyi6u1MPpHHra4Nrwlf8jhfH3VI=;
 b=QypME55x7N9R4xrH04hYXAsb+ALfllZ7ZEQKGtPi7fMg63KHNpsJ1vRplZOb++t3r5ey8aM6oqIXvgeu6/I0Mwy/0qIa+pQYuttuQPj+w+unbvizZSBmvyTBOCE3NxA3vYP5JoK13jU054lUDIEVWwMZD7zWA3lXIV3iSh7ria5G2zy7zzp/5mOavAaljwbxuTZh+9lBCdc8Ak4d4BoXgPGk1D3KJ5g28Lj26DVw71CrQWGZBsI7cMz5UE0o2l5DbSecx2Wv8rzv9rIYZxjh88Qlfspg6iBemZlKvZ7ig98k9foyPZs2EAA47A0BE/wcxdINfiyHbZON28zOs5nJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7bcpjhXazC8pVFSGyi6u1MPpHHra4Nrwlf8jhfH3VI=;
 b=L66HwaybGvkMZy/JmgFR8EZQm3yDS4Wo6ZWwRGVHeCcXXlZuy6F18MxLxyJO9dvnbtxtHW6nXpuFu50mqaxA06TGsEc6qDplFjX5jUGQamva9cqdm17e7Ae0lqe8fpiruq70P/l5Giewz7dLTjGb0hLUDbau9p8d2104yrJgQ1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB5984.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:36:15 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 20:36:15 +0000
Date:   Wed, 29 Mar 2023 21:36:14 +0100
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
Subject: Re: [PATCH v2 4/6] rust: error: Add to_result() helper
Message-ID: <20230329213614.5fa23dba.gary@garyguo.net>
In-Reply-To: <20230224-rust-error-v2-4-3900319812da@asahilina.net>
References: <20230224-rust-error-v2-0-3900319812da@asahilina.net>
        <20230224-rust-error-v2-4-3900319812da@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: e4316ca1-2949-473a-f71e-08db30953e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vCyRxCh//wneacHOC6o8Ctpmp7eeKGcdA2ZehcmNroNJEfkKxJ8zfN5HLmwNVXfSQM2BJKCvxpmwTWhVBCuUh9e0iMwA2tIX2TuNfjUNPXtdOgxmwl+FlWOuvEz8a6qCIvWwxUfb6SvhkTXRzb93Mag43OZZHrAMt7MDdKYwC28WzKHXB1t6Aj0qb74OhlpnRkjMlyKa3P6vh4PFtvEg+3G0laTvgP1wScVpebLLpQkBkozJ6smkPkWwI8rc4N6+2iA1e8NCkff92x7rW2nfbMEeBjtKX6X59UHtHmEzLKXjH+LUSXWM3kGe4LGZSGuLxynf9OxpguJtBGE0XsH1Lt+j3Ej46FJgm4vUPlq2mXJ2YEPV8j3sKx5IH08VNLJOKQEWqbPPhmFAxuueQZMr2DfZ7KBQMpKz6tTI2+aLnvjoOfyBndFyDxKdh+gkfHCZQ0fslzIirNsxINHeD1URoJOOIfvuCG7tsOXG1qrvhnnE2s2KPBXdzEm1qZU4sWa5EbPDveinuFN9Zcss+HJ2+0IYO5bCVnfjKLZnKYu695o7jsqrRJFC2ET4pCYWD1dr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39830400003)(396003)(451199021)(6486002)(478600001)(6506007)(6512007)(54906003)(186003)(4326008)(5660300002)(41300700001)(2616005)(8936002)(7416002)(2906002)(1076003)(26005)(316002)(38100700002)(66946007)(66556008)(36756003)(8676002)(66476007)(6916009)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n0+5Rv+NtAVn2fLyvdYm72pde9B/fSkj9NWbHnU4UUgvjqcJLJo88Lqaza6v?=
 =?us-ascii?Q?cWj3gf6LH5b10Fpp3AprQs2crHhXeh6z7YGjyx+7lSjADXiNVilu/tvFT4ub?=
 =?us-ascii?Q?0tP8/Ncn8/HY9dsSVVt2TGD5JqR46fltDbeSgQWZhlH0f+Z4uxLYg8fpuXnl?=
 =?us-ascii?Q?e4K20tDOZtpSSDkTXnaK4Lui+14d2VAMbCKIYgxhNAAWejmCZvIpw2pEZXSH?=
 =?us-ascii?Q?oqLp9O/h0Pe/m7bvJfUbRUhV5Ju71e2ogmPlM/4HzRAr3gDpahMy3hq4JJuy?=
 =?us-ascii?Q?tXoqbvA0no8jH3ucOu997tczRpmGWmmixeEFd1cIVg6FK1q2A4UZ5T5iRXNA?=
 =?us-ascii?Q?h4YsWANjQTZ88eYjrA2+zuR6Dn4uFrJxRZXfsPc4eguPIml8NwQbZ6HAwaOI?=
 =?us-ascii?Q?5LSdk6FJXL0poB2G/QNlUbcGS5GKGmTGWAtNyrBnc43FtnIllRH2AJ533Vgk?=
 =?us-ascii?Q?UyMyoi+NDc912PGzN2AhRl4V9c5tbWdox+YWNI6vAuT8e+gH51jYegCbPHZy?=
 =?us-ascii?Q?/I8JvssAEfol2DGbSXxSzlWCYqMGXMK1WLjwB45hjjZlmmkycwqTsLOyc4K1?=
 =?us-ascii?Q?Py6bS0FaAERA1jhsFqaeSeE0I1bNVnmFtZJfa90UsyeTPZ1X+mPIdu4G13ZP?=
 =?us-ascii?Q?SWUMqiQCJy60EvsOeAM+hbXZUiFRy7l6TigaQvUBV5J7ci6PZ+Fl5xncMMuj?=
 =?us-ascii?Q?EQvtpcJNi/qpPnpNqtfu/TPpc2X2V1sCYb3pTZIn93DiBdOvnKxlclUNA/U+?=
 =?us-ascii?Q?V9cPjhJJ/+bSX6Q6wKfxx8C8WXqhfEVBCKeHJqlFSbKRdV4ktgLF0IXG75wd?=
 =?us-ascii?Q?Ogg3Twrqzve9m8rr2R86iIHnauzck4eCdf6DZQDkryXWVN+S7Wf5guJ+qmX/?=
 =?us-ascii?Q?Cwd9NfKovDCGLGlFlmsAovnYkVASFcubj3qJU6Mk5nyv5twY4yeb3yUO5bMK?=
 =?us-ascii?Q?LCqOcPlPZydcsxpOO+h/0iQWgXNKoiA8Vtv7NnyIRqt23PEEeh3LWErs7AMG?=
 =?us-ascii?Q?L9U+lx/TmfXRTEaMpD6fXppAZaFJNwKuXVtGRGafnbw+QIUbkl6bJ6iuDZzY?=
 =?us-ascii?Q?SkzWnztwvOipCEX+1OvuHcCIyLi2OFTsF5R8iYQpQ7lPhCg1TXw9Fot0zvVY?=
 =?us-ascii?Q?Y1ISpnyuimJRSUVOVDXWfO9rosshpFXfKyHgPUfXCSPtSctXWnnnwRz8JwXf?=
 =?us-ascii?Q?/U49BjZBzqbHn55BBmo1pomYYtC6WE/26WIuXV30FGKm8UlA+baOVnfL+vU4?=
 =?us-ascii?Q?KZ5sDmmZqn7Vrrk0expIj+DLNrKqBsA9Azi+/IjOT4jJvr5mf58QNxlQK8DK?=
 =?us-ascii?Q?X/spTeiqhXT5U3PjnaWWaJrijigbw9rZ0NT9KFYUEpqHi0kgFeNdRqjine9Q?=
 =?us-ascii?Q?CDllALUIiyq/3S4HrJq+MKBSjFKSDuAU2rg/btqBTy1Cx6xZB7sOMFwDEc6+?=
 =?us-ascii?Q?hEahakzFe3AqiFrOfxO1ImVKFbolQ0Vz+yQFzwjxwDPYtTLBOlB1W0jep4nY?=
 =?us-ascii?Q?wZPs8MVhe+dZeNeZKlnETS+3BQV4Rb8PIqoW5R5GmTEWt/7ZodS27GMvugnH?=
 =?us-ascii?Q?XVBhG/DPikdNA6s6nOiLlkq4xkVm8P1o+repEeJn?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e4316ca1-2949-473a-f71e-08db30953e51
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:36:15.7969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Axv7ttGaZb7PLgYLwbUO3+fM73QjKHg68DDc5yYIZvuegOknKnEbq8kyPfTTkVbkmWyPWGdbDc9rmCh2ZkaCig==
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

On Wed, 29 Mar 2023 21:04:36 +0900
Asahi Lina <lina@asahilina.net> wrote:

> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Add a to_result() helper to convert kernel C return values to a Rust
> Result, mapping >=0 values to Ok(()) and negative values to Err(...),
> with Error::from_errno() ensuring that the errno is within range.
> 
> Lina: Imported from rust-for-linux/rust, originally developed by Wedson
> as part of the AMBA device driver support.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/kernel/error.rs | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 659468bd1735..4f599c4d1752 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -167,3 +167,13 @@ impl From<core::convert::Infallible> for Error {
>  /// it should still be modeled as returning a `Result` rather than
>  /// just an [`Error`].
>  pub type Result<T = ()> = core::result::Result<T, Error>;
> +
> +/// Converts an integer as returned by a C kernel function to an error if it's negative, and
> +/// `Ok(())` otherwise.
> +pub fn to_result(err: core::ffi::c_int) -> Result {
> +    if err < 0 {
> +        Err(Error::from_errno(err))
> +    } else {
> +        Ok(())
> +    }
> +}
> 

Reviewed-by: Gary Guo <gary@garyguo.net>
