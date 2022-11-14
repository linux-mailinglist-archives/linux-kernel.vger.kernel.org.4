Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAFE62835B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbiKNO7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiKNO6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:58:50 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2124.outbound.protection.outlook.com [40.107.11.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC67F1DA67;
        Mon, 14 Nov 2022 06:58:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBWx1D/j3t1TCpxo2wgFpDAO7a1cvIFwAmOA4S+v1VtFJ31mnOagwygzuBy+SjcoOv+BI8VxcjKDgWmmhL6CSxwTHO6mat40Y9bz3VTrH7ZWS0SETm+zoFRMtuWiygkOvz334a9JkAcTXgofDIZaII9jmG5qnMcfzgfOk/HZOL8JNr0quvfuqwrcOOkJfB7cSmf6nqhS8QOXkDaMOxXAVSQxhHCvdSaUq99uesgCxyYAqPfZ/llLiLDu5Rf+rnDLs1sJ8/oF8seXTx3R2p/JPCFcwhXdodMRxq+mXOuZuS7geWOGGcf/0n+t845s083uMpIc6JXZlPOq8r8GLvJOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwLvjN7UqFR4+ktK51aUJTCFdTr2wbHU1dP6fXqAVdE=;
 b=S4wKE4S4SeV1N+iBxbJWz/7DhQKACnrHDhHticPYk9JPYJRrUC5IFCngnbL+oy6DWMZvm1yL3A3bC1xQRK/ZIyVr+NiMwC6+5qEbr4QtUz6puVPC657zhvKi6QUPr5NYNqxwN1P1VGUTVajTombYDaX9/SbumqZJP3bjfB6FzK6VhE40SGndvWu/yK2OOJ6oYMH+CwZqZ3wKnuYDeq/bAriA/xlaDbI9cHC9V5JM6mien9cjxJUeMG9j5xYd8g2/xkrvdLZoJpcGf2OuYAfih8rrSWx5PM6HWjtRRaqh0iu7QyfLg+AZwMI5qKcHg0iw3UALGPGxV/VpcligJ5RiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwLvjN7UqFR4+ktK51aUJTCFdTr2wbHU1dP6fXqAVdE=;
 b=FUyWpup5knN7vNQhe72Seot8AGJNuAzRmDWLwksUR6u/yfHPxWtL4H/pjCGgQqH6LqJY9XUQHD0RlDxAcmj+PLNdahrrQa6RQXEVZw2ZcqUnwKuGCdil3HR/GIf2EohVEirwk8fBTZ5076pn3GfZBCnOhl1JUu+YSoQoL7qOj0Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO3P265MB1915.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 14:58:46 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 14:58:46 +0000
Date:   Mon, 14 Nov 2022 14:58:45 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v1 22/28] rust: str: add `fmt!` macro
Message-ID: <20221114145845.519fe889@GaryWorkstation>
In-Reply-To: <20221110164152.26136-23-ojeda@kernel.org>
References: <20221110164152.26136-1-ojeda@kernel.org>
        <20221110164152.26136-23-ojeda@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0391.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO3P265MB1915:EE_
X-MS-Office365-Filtering-Correlation-Id: ab11f999-36db-43de-d465-08dac650bb42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1XA43U3x3I9X6wxs1WcKeGiHlEYp8sc4FldRidoxl5KSLsZkwFhvjoWd1KcUSFdUKtQFOxsxAOp8zIol/eAa+Qf/9HdWvj2gbxa9yfr0kWXV+Hi4VOeJJZKdgH/x3CmpF7sut2tln6mwoXVJfB5RjbWTHBvBDNYZPXTNSXiUC3CFpZdlu69Cu2xTcmOtygEfipBZQA1fHT1Sf1hYGjoD3nJUxtSBJHKS1k1yw+EVhiEkjjHWi4F5LPdIpjvCGm/eD1mmPQTQC5zO0r/zR2SlyUtShIFQyPJ3s5BaoU0wu8EbdQbiNUWL5NyFSPdA915nt2DOfwY9iyxpU4v/OTFf9P/wGnUtoc2DP4To8QsfQSMcE5Cw1X5smQcOaApYhVj2qCcwTPWzAqZ46iJ2zfrPawXGMHx+qZRuhVU9e+5IQ1lnUowFZa9kPNng+GsO0UrMeCYBuPdz8Zl1odnuWa4IHMWSujmkV68ewg0pjpydh3tIUitHfZhG488fLOrdQ0OonQy2u+XirsGoFfSz8FmxEu/rggdiMxLC1GNTrKeuU36Cx2mtHnl6wCw6vLUHAggh13TfuDNgb/uaT+Xqyzxk2X6Ya5yGBZPz4ZTbtShhBRlI8OlAsT4NUNbTEd2KrtRTUmRK8Gl1r7jrYtY5pPxm5A7Ux4/W8OVpP/r6Z30ystyQL+A16FkAs+lTBHOVShXITCUpgo3YRDuDGWPAUoGmslRp/qZz1WIEYsvKcytEV4n+1B92DZnveerN9md0kPe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(396003)(136003)(366004)(39830400003)(451199015)(2906002)(8676002)(33716001)(66556008)(66946007)(86362001)(6916009)(316002)(54906003)(478600001)(6486002)(5660300002)(41300700001)(8936002)(38100700002)(6512007)(1076003)(186003)(6506007)(9686003)(4326008)(66476007)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sn/idpsNd7bssk5guTGsVDBJj3J4BxAMc0uUi0ADxWVRPR2om3jPXnamSwPy?=
 =?us-ascii?Q?Wd7rJkSberqmGdmoi9bVelXcbn2m4qnrbl0zzSrlTnEc09TNnUYXrUFeTKFg?=
 =?us-ascii?Q?Q+Sskjc3E6t76Ue9G9/uOpz42sTtu2ZNpj0PIRcGI7PNc2SsTBPPtXYl68Wv?=
 =?us-ascii?Q?QOayCtcw0f/ybaPeURocnacJ36pw+EySxP85CPHUEMn28zVOdqPVJFYhXEJs?=
 =?us-ascii?Q?eCHpMGsyDgGn9Na1XHe3AXNStCwoawNYv/o+dbggYyAHcC+4N0wuj+rGOs4k?=
 =?us-ascii?Q?f4/1XwxYgVymmCdRvO1UQzN06JuWP9ZaADWwuRWI2TE5szsn1Vpr6d7jy4rW?=
 =?us-ascii?Q?HBpiq44afTnsNv3Ou0NG0lyHzJb5eQG5QP5bwbcig1LFc4biGhSPjKH8s6Bz?=
 =?us-ascii?Q?2M9hnniFZQPWH8NMUA3y6wF8VsMvJJ2w4ZQAqpAKQOgVxfGYFIkTtIaAYCUx?=
 =?us-ascii?Q?mPqyw/PUw+WqQUs+vKxOBiJz2z9STYR0AFkaED/1Ztj1eDj7dmZlFHhGNMKY?=
 =?us-ascii?Q?NSkeQQQajqLe0g0ZIoDXnd/tTeWm3m4xb3ahtS9UtFRieWjC7MVwgDkpNLoR?=
 =?us-ascii?Q?KTcpYa6Y42wbg/XVYUryTU3NwXV//Jzzo6S9+3P3ZhJ4k9Rn0PiQs+oCw84/?=
 =?us-ascii?Q?4g0J2RS6yK79VJNQZHCeU5RM0yVrqsPr0s7HHnMFj2DgNhh5N35TG81++iq3?=
 =?us-ascii?Q?EGzoKzxGGY9pp88/Afjr+v2WZYD9shUAWqq1BDXEo4w7VtNa2XSbdYQ5xRUU?=
 =?us-ascii?Q?DtGpaf9Js2eRPfTbQxv58XAPnaukGZX5+IIJTImetG1T2s6fSjGlYb8cC3KE?=
 =?us-ascii?Q?9eKApolWphouwqHI4FU7/xlXipmpaMkH1c0pSY95WajY4VK0XBjA4JftZBxd?=
 =?us-ascii?Q?JOjOR4apsSCmD2AkXV+XrkhPq7ID3TOkVbogimKxPGt+X5M1LAUqwX8XzoLr?=
 =?us-ascii?Q?zaLHdkwCNf7T+Li4fcL2HXgwU4lX5vJcNYHgTgG+1vTvVKT8PWhzfWwDvKBn?=
 =?us-ascii?Q?+tUPYdiGbP2Y7SFZz33PUHyXBhJsInBrdwZez56OtY1wY6a419LNi9eZh+Nz?=
 =?us-ascii?Q?ULxVSnOr6ivDm4Ig6YzDwuguaXcWq8p/m0GQ1uKqyxpzUp98mZ4ZL4RzonpO?=
 =?us-ascii?Q?R98wk20mjfUkSFNwtgePlPj2BrcaJdjNU6qrZEc+M95lWlExVqPfsfXgWrPC?=
 =?us-ascii?Q?sfNkTkNW+JcKqsHNfGP4c3+JYjR1C8hSZSUtrjRKSpdhcE90rvE9S1vWQEVy?=
 =?us-ascii?Q?ZpNbSiOxuhiv0T58rtQQcY/VdRUSXIbccSQdeuhdAwgybK5TR+Gozwe9M2HN?=
 =?us-ascii?Q?iVYURdmha+iiDxct4TF/B7AOiYYIkgY63pMhkEtajr+LlpyNe4Iit40IjNfm?=
 =?us-ascii?Q?xft3jLEV/EBf4moQwth1NExqklE4DmoA9L6hoVFbST33xUJ5oDQUPW2ujsg0?=
 =?us-ascii?Q?Bf3NcQL2zRYPAiz6qhFefoGI5ORC1ePSe+r3jqr+3R3tuFEO9flD+8NSbZlU?=
 =?us-ascii?Q?pjp8IXOCBt2EburQ2aSev9zL627tUXsnCTD4oxDqyXp6fv+O/kwKuoZ/JiI4?=
 =?us-ascii?Q?IXGsaan5BF8ObKQabBi2VxNV7EDUPuyCXL73p1ZC6vtTVuoWXs6DSkB3gDQx?=
 =?us-ascii?Q?Yw0qNjYppIXXSBHhaqUgSjqpLJkZa5RqT48vrRJ/1FJk?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ab11f999-36db-43de-d465-08dac650bb42
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 14:58:46.8373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mwm0wezDzkrcyhzhMEVdjOPxETY3LEcYUK48Ggt6Y/IPt6iB1UPtLX8ANczZG8wmFtMPJvcj5IGD3Knt5ObFtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1915
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 17:41:34 +0100
Miguel Ojeda <ojeda@kernel.org> wrote:

> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Add the `fmt!` macro, which is a convenience alias for the Rust
> `core::format_args!` macro.
> 
> For instance, it may be used to create a `CString`:
> 
>     CString::try_from_fmt(fmt!("{}{}", "abc", 42))?
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> [Reworded, adapted for upstream and applied latest changes]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/str.rs | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 877148b77e71..ffac633423db 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -592,3 +592,9 @@ impl Deref for CString {
>          unsafe { CStr::from_bytes_with_nul_unchecked(self.buf.as_slice()) }
>      }
>  }
> +
> +/// A convenience alias for [`core::format_args`].
> +#[macro_export]
> +macro_rules! fmt {
> +    ($($f:tt)*) => ( core::format_args!($($f)*) )
> +}

