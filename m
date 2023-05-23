Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2F870E155
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbjEWQCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbjEWQC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:02:29 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2111.outbound.protection.outlook.com [40.107.11.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2573997;
        Tue, 23 May 2023 09:02:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsQfgiPgBzsIIDDQevEdxXZPkCwcjzAaef4OeTTTiIg9G3hCep2JxqrJQDgfCDjA1gdwF0lRQr3D18L7vZkeyYi7XxYgT8UOHTbGC7t3QmtnH4Lr7KaO5Wasc0V0pCbalMJa7sShMPd28Oe9HNl+yjSgsbQBBACu+XFVfTXhf+Avsd+niOQEd3s3INt+ohvz/oTc6JYJJ/B9blsvhDciLacJarOuaAtQaqIj10JbaXNL3udCG/PKKtvIFXeXcciTMt8hd/soXPdQp3pSCUmylz3Bl1JtMP4OJe1AowZwh99R27QDMKYAcew8cGDQv8aINghwsetKiZ4m0+3Pecl4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4L4ApzCPZSC2sarFb5ZQRjcYQkGxUGYRqyzSqMofbdI=;
 b=GrdoqZ7fvgvW187PWMnv+MesmMNlY/kcD2NTcY/2fXzMn7k3q3zN8psjDwUDdFnos/gXLOwgICOgG/wdz+aPauMLF10SZXET/5yS18hGmP+cZJH/CE/km6wVybCtpfYJDSc8Bxs2Ey797/YoL6J+zE7n/3vN+hJd0gxA2xtPf8lLbnzwrpPV9djYGisTM+ww4VggfOJr1+arSFRVnz6UQslFE2xkZZca3EFC7Sb1lszf+kw0sPY4RlqvZrvjg8HF3i8X08UA7IjK5g/oOmb3XelQ9oI0fTXeE9rr19kJcNz6dVjspnatYfcmE8sD3iYDGeLFUiR52eQFFxGgt6DbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4L4ApzCPZSC2sarFb5ZQRjcYQkGxUGYRqyzSqMofbdI=;
 b=KyY9piqhZ2Y24akpB0PyLPas68+p+pLkXagauNnnIy6OeRz8h9K2DZFNOmViDbOIZru7tANFXyEEjMRZH+fAnuTjxf/yS0TFCtaJAfSpoT7+uqaM+9cSEyCMfHB4p1kqjhEjH7utTJ3jxggHi9DnQr2YAhtXKp/Q6be8qHkF34o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB7077.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Tue, 23 May
 2023 16:02:24 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf%4]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 16:02:24 +0000
Date:   Tue, 23 May 2023 17:02:21 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 1/4] rust: macros: fix usage of `#[allow]` in `quote!`
Message-ID: <20230523170221.77935844.gary@garyguo.net>
In-Reply-To: <20230424081112.99890-1-benno.lossin@proton.me>
References: <20230424081112.99890-1-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0073.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::6) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: 4321a183-c117-4bcc-ca42-08db5ba7193f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9MZqPTUDdQ76RVys29YVausLlFQYnZ2HyYoXlUcvfWtkcLxuQmELsJMUI4pPOF2x1YNhnzD4d1b9NVhYq2WgDX8pMifwiDPqhL/NKkippZYDB8p5PPiuBXMNf/FULSmi68Dsa8CRWL3EB+EN4th0BUNycrwiFEgoJjyyxTTeJAVLREoDZA5E3SnmK5lyztWQgd6BVeG0kdEnxlHqOSZhCu9pjjGDzlaDcItk1NI36wL0C4DHsmNK8jjgl6TqvIxIc1YovMRq7bQvSlpVQZJegFy9WNqJg35Ge4cZzGCc1+MknUUhGS0wFzH7mRfyWU3rVdO72IeAiPmXaTMrjmChgbYDT7bt9Gp5TAopYVyurShIF0FqG7yeDDReIyCVyEqWqNjsO+XzrkHdkmGi83lX05ffkWi/AMXfnX/UJD0QBGs38tSXVGifc0IDCCMBfCwd0UwmBwvMFkS5rVs8MfEei/rHsPbf+bNymnKLQYyHHpWs1i8TMT1PePn9ROyJFa/AfwbNHNROr010UHF45xyn6LJvJB7RIT7epUp1Uw+XVMIHOVDhcOtP4jh0mkwFrvXr7dYKmlws4sDytLBRv1Y3x3mabsZFA85huap2fqknCKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(39830400003)(366004)(451199021)(1076003)(6512007)(6506007)(26005)(186003)(2616005)(83380400001)(36756003)(6486002)(2906002)(6666004)(5660300002)(316002)(54906003)(478600001)(66946007)(66476007)(66556008)(86362001)(4326008)(38100700002)(6916009)(8936002)(41300700001)(8676002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yWYjncZyeJOTKI2xLfYl3FyH1qunRMC5ViznAba95mGL7CjSmqro9wKla+HR?=
 =?us-ascii?Q?BeJme1IVk8mu9wOs+uiqe0y7ELrEMTicYGl4cCTvEMqGDwuyi4R/V8opokJq?=
 =?us-ascii?Q?zGxDl7SjLJaTOvPHaM6ykhJ1xTOjC81fHwyzij1bXvHFHP6iZ2iC75K+ENra?=
 =?us-ascii?Q?Z53FSHpdWrhJBlafjj7tPuPohLWVwbia5F1ArA9eiPggzdPRcfmAfYvZFR/5?=
 =?us-ascii?Q?043N5MB8hcIIiApFWM9+OIUjFXcjt+aksJVv2/+dq7rYDh2Y+G1nu+JMUMhz?=
 =?us-ascii?Q?5mfAbMyItoOvXOzg+aBYanxZR7RvthZKXnoe8ZMqqb2wl1cTUgquUqgo4W/m?=
 =?us-ascii?Q?843TLrb97WnNGqYagn1PRNK85WIDheFAlid84rCu92dyeZrGYFX5DLIUhHWn?=
 =?us-ascii?Q?vdnA9/2EuFgTenh8a7WvHqjDZoLRoZG88uHDRp8B/XRdS3dO5flcgG5Bkf5a?=
 =?us-ascii?Q?i/OAfykmQRtLqhaQBG/CUpN6WlXMNCYMVY2kQqFCkuR48okjU1NlUk2OSA/k?=
 =?us-ascii?Q?lb2i8y8KU7ndHpq+/vrXvAR4aw8GQG5srckUvb14rYSN2/Avc+yCiVgl7GYn?=
 =?us-ascii?Q?c4yQzFPEPQ9MqKq1bpokglyN6qtPsB7BrfMB8kfUd8uI9YN/xFPpHS2HLPuZ?=
 =?us-ascii?Q?rN9Z7rZH0339No0EH9ZQfM91nOANFuFqfjGh5W/o0HQ1F0u2NTZKBYnv5e3O?=
 =?us-ascii?Q?tKV27O3olUMeQ25yBRH69FaTd+UL5wsT8AC622tiI9ihrGH2fazHLXTtN4nn?=
 =?us-ascii?Q?HgAoqFYJTj0dNiTKBzoVujm91zOK00lnBibvNeBrPRjZu5oUPwnABzdan798?=
 =?us-ascii?Q?wQbWwXHN/rDKImLZbL/pSzmYJ0Fx4SQy3lwuiHGEyp9007VjyNKozr8W1uAL?=
 =?us-ascii?Q?W66VnFQ9lv6oxCeZ1WZolIfhh660/NBMp4GGIfNqFp+smHsb4IWuXKBA1mwB?=
 =?us-ascii?Q?zY4Qf1bvYxK597YZRDke+fAhSJ9R9CHjE+ar+57gg5zOB2pCz4ORIK8iEALq?=
 =?us-ascii?Q?FKgoKsmh3OmSEuccEncYOMion/RP6jAM4+zKljOYLrAtgv3zbN7rcl+aRAWq?=
 =?us-ascii?Q?5OLZWzxw4iMhZCjpkL0RqlBu9FA9xP5k9Qk3+1Zirw0DytH62mJyWIrhDOgn?=
 =?us-ascii?Q?EuiOs+J4CtKyeb5hMGySeMYWNMlx08P6KKhkrp6wICVo92z6IEga/uGqDys2?=
 =?us-ascii?Q?bWITWwaFFsYgbAFd8RcZgxJMbS9SkVSmR7MMfCXyNq6IiD8VMxxg9z45OJqL?=
 =?us-ascii?Q?19Iatq0bkXmfz2ZnjmeSsN5HgkwQTDDGdN+E4zVcTuyMo9j+m3BmdP9AoRqb?=
 =?us-ascii?Q?J+yHxILFvhXA2GKak6WtZRsqL/2N/tF9w+FVUyYPc9+qxl58fm4aT9S3883r?=
 =?us-ascii?Q?TawR1zSFKtOzLrAPqBKqTOElsl4oSUum5uS5gvPqG3mxlCR0rzVAct4Txz0T?=
 =?us-ascii?Q?ZnI8Azek0ZX9Ey4ohOjkeM2ARtDpfGntA5NPxlHT+0x+mi4CSMmxX7RhT3vJ?=
 =?us-ascii?Q?eBWTs+PXAxIcKxk9Q6QQucZd6gqkIwtyQfx9592NMCYB5sh4dJt7b2yNJvNs?=
 =?us-ascii?Q?aoehbuJLaVIySvb7SVF1IMmOaq5ZEhKEtlFlc5tY?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4321a183-c117-4bcc-ca42-08db5ba7193f
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 16:02:24.5578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6IQsMFTzuUJc1M+7NHEjCcY7m84Ln5oWaoSyyAJV2isZT2jv0De9G7yx973dSWDq4lnWsYpJFdimUK5ShWcBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB7077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 08:11:33 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> When using `quote!` as part of an expression that was not the last one
> in a function, the `#[allow(clippy::vec_init_then_push)]` attribute
> would be present on an expression, which is not allowed.
> This patch refactors that part of the macro to use a statement instead.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/macros/quote.rs | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
> index c8e08b3c1e4c..dddbb4e6f4cb 100644
> --- a/rust/macros/quote.rs
> +++ b/rust/macros/quote.rs
> @@ -39,12 +39,14 @@ impl ToTokens for TokenStream {
>  /// [`quote_spanned!`](https://docs.rs/quote/latest/quote/macro.quote_spanned.html) macro from the
>  /// `quote` crate but provides only just enough functionality needed by the current `macros` crate.
>  macro_rules! quote_spanned {
> -    ($span:expr => $($tt:tt)*) => {
> -    #[allow(clippy::vec_init_then_push)]
> -    {
> -        let mut tokens = ::std::vec::Vec::new();
> -        let span = $span;
> -        quote_spanned!(@proc tokens span $($tt)*);
> +    ($span:expr => $($tt:tt)*) => {{
> +        let mut tokens;
> +        #[allow(clippy::vec_init_then_push)]
> +        {
> +            tokens = ::std::vec::Vec::new();
> +            let span = $span;
> +            quote_spanned!(@proc tokens span $($tt)*);
> +        }
>          ::proc_macro::TokenStream::from_iter(tokens)
>      }};
>      (@proc $v:ident $span:ident) => {};
> 
> base-commit: ea76e08f4d901a450619831a255e9e0a4c0ed162
> --
> 2.40.0
> 
> 

