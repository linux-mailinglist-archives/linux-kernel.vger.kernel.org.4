Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670FC6FAE0B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbjEHLkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbjEHLkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:40:04 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2095.outbound.protection.outlook.com [40.107.11.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D87C3F2D2;
        Mon,  8 May 2023 04:40:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5+zVUrtmD+O9xvZh40zu87sIjByrclyovhustiSi7NV6GLQJPquMMisnovmZ0GqPQBeJXm1TAqVrkVEhaOl/DRizXyCCXQZ/nSqlSwzGEa+c4QaUDQOuqyi3vkSsEGsUeFU0456zcZJWXPnFwohFmSA9/Uv9TRUopsF4fjnQILgT+f0Gj5Rky9LvLx1M0CbR4l/PylfpNVN9gOhppQ26amGxSIz0cUUt1cRm6a6hWBcUSyWIKDEJXcUchDn2JJtu/YGOus+jpQuEZEDQ9m/M9cypjjPZXyZg23G8agEGLADIR5rq2s5PR1bJJJrY1vdl9A1W2P+evSbcuEl0+UMpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0Vcc4x2w1XrcYRwslQCX1jrck2o36AlbrzUrJMTWs0=;
 b=Cdd5MKPVj1hKjCf14b1YrTDPbEoZjtfSfX1cz5KO/y5m6KobL01PdwvNSr8guSDmd80vdKG0rYNWI8B6lDe5/PA375boR4OMIgQIr6icHffakL2vul5eMz+xpQmOjM96AWhtozDPTA999/BUQX2w/FznXpRkdO9Sg3jUfLR9gvgzE2oewTQUrxznvt5k+e0QmOZUipqwWyHn3pN8u7OqXLCVp1iklJ/NHMJpoZUC0QyICTN2a7IM0KPMuHI/Liypno99BM5JRFUPwE9WS/PhArraRyKwuB1A53EbCHdAdI6gvfi2IDqndgPNQRJiOW805hwtjC8fUZR/92W8NxdP3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0Vcc4x2w1XrcYRwslQCX1jrck2o36AlbrzUrJMTWs0=;
 b=omQgtNKcTomBWWV/y3xDhBW9WBZFy9qrwCkXDKoC5k+c+LGWiCGDWNzHKFVTe3AewfVXpqfqXp3F+vK5wQlfqnSLXoVxdhDnyk26igXTvOt59ykpLPo0hY6PXwwOjCKowhICaHct8OKgAmMH2D+p74UjLBPtTYnIZxVkoGy8Uxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO3P265MB1946.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:10b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.17; Mon, 8 May
 2023 11:39:58 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf%4]) with mapi id 15.20.6387.017; Mon, 8 May 2023
 11:39:58 +0000
Date:   Mon, 8 May 2023 12:39:53 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "=?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] rust: error: allow specifying error type on `Result`
Message-ID: <20230508123953.4ccb85e6.gary@garyguo.net>
In-Reply-To: <20230502124015.356001-1-aliceryhl@google.com>
References: <20230502124015.356001-1-aliceryhl@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0407.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::35) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO3P265MB1946:EE_
X-MS-Office365-Filtering-Correlation-Id: f9293be1-030e-4f61-e071-08db4fb8f389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYvMpNBOzH8yNcSSeHB7VQx1DJoYRVg8Q8SFYOLKnZaLofUPUI/53KnDPFBP2enupoHGzZZnz7eoCYzSiOyfOvH+JlczHqbvx93h+jH6O61o0njUXmCKNZIMUfj8YQ0+3VNFKmmqaSTCJeSndfgO2rPkkAEhMo3ITB9L9Ha/MTIS8UI0SqunaFOQcbGtKqaD1SE1J1x4fyvUn4EfjDUo2Uaqjedn3/dzkWZOEz/zFuntTVejnzxOJa45Fod1iu2W9nfBOMw5TwCX5cNl+wXRGE9jl/qEiXJMhmJMMr8O9sVbLjlPy6NpB1muq7FZW2aVMoS+eNqW1p7B5KDV7je0tJxmknLdgvxTQMm6OOQAiUkV5shxGWS8MpDDqOyFc8PaXk/v6z+IrpNAfIxD/eFadCHLILdlM1UnEj+1DnCNeS7LrbPruMHs+pcV4U/Waa6bQQaowT3cBdzZ4QybophAACN6v42GO1s1C+G5oHE8zlJdv4UsleiTZAxatRJJsaLJTV+mgaasGkd+6caZaKjTJ9xwbxltl3zjKbZfdMtvDbp/eoaj/r9NE1EvpIeQILrRrMZfP7QRgFEgyVjtwU2sIw61pEiaDEmMzXqFUAbYqA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39830400003)(396003)(346002)(136003)(451199021)(26005)(6506007)(1076003)(6512007)(6486002)(83380400001)(36756003)(2616005)(38100700002)(86362001)(186003)(54906003)(2906002)(8936002)(8676002)(316002)(41300700001)(478600001)(7416002)(6916009)(4326008)(66476007)(66946007)(5660300002)(66556008)(6666004)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eKGCCnqIAI3+h1DPo+PlppJu0CVILdFr7HMHMDFISMSf8aYTu3AW9OQtvgjI?=
 =?us-ascii?Q?to4Q96Pd+C+5OZkPbe0IeTo1zlOEFO+h9CmAFVo3rn1LPYyxt7VfXb8ji2fn?=
 =?us-ascii?Q?hW9/OGPnYr8ahSVAbnlZ482OGFM0JQ5DoA/81H4LUt9PKMMJjNnIXlRXfq0/?=
 =?us-ascii?Q?z0kaPui65z+qCKpZB3lpHslQuQWprcxLA1LH2yfG/sruwoHjISLAnXMn5L/t?=
 =?us-ascii?Q?QOe0vYG+JhkMJNwH0jHKg9elp7EOC10rMttqJ2z8uChdiJ0znr4Ibd3OkHzs?=
 =?us-ascii?Q?saWi+sH/OyjyDGHakXlOYKG71TDWPZnTSwcKXYURYev30bJTPSIWbT7I/GD8?=
 =?us-ascii?Q?NA5oKHVweBc8gew08St+0KcXpfvME44cA8H+3yiGV+xTzi1UqfD2e9s5h6by?=
 =?us-ascii?Q?3s2rk6YL8LV2hIiqAbfAs+b/4LS4Ob9TUcWgRfXqIxUXr9Qv2rlg+56VL6SF?=
 =?us-ascii?Q?zsVZsSr+FR0dAL8ny1VkUJ6P6H5RjCEs2FpV99OyhuEu8/83A4gcAkt0W/jG?=
 =?us-ascii?Q?aQBo1ifxr/2gHB2505oh7ofzRPvSIarNJNXNsfErpwjPlO39m97ZJj78M1AP?=
 =?us-ascii?Q?bcPZla02fNkXw8CasWbcpTJWHArC9cS6x6V4ySrlVYvPW01+ofG2gyDka2Qd?=
 =?us-ascii?Q?djGwquQwRgf05wDpMhT52l95A9cY5GjBTFM1vbwPr4L2mBdjoIBWvhBHn2F2?=
 =?us-ascii?Q?RY1RhMoE4XZfEKik+mYr87qnoBa3ZSH5j+JntMhTEWGG3heSVARxCdtQE2Jt?=
 =?us-ascii?Q?7Jc909JqyeBaODUJd5S6n0IDACuzPDBkOFgCAoQudqngrlLC01pedC6CNo84?=
 =?us-ascii?Q?avTw/kSMc31zp8kqFHRzdUbtTCfbPYnUJ/FTcKoLp3LHt5KHKZAEHoqp8ce8?=
 =?us-ascii?Q?ZIZYHZVFR9vweSAAikgj/dN0TCZMYqQuW1bsuYkv66qSUKcMNo9voB/vZACl?=
 =?us-ascii?Q?NPS4PWseNAdezcS71pc+sswt5VvTjGifKsoTYFtDRCAgWN4wAMOuU1iP0V3G?=
 =?us-ascii?Q?zpJwtRzeWsc318xC0FXEkBCqtigZ8QIHtQxnVOQHtVlJZKFqOwtYI7IO/fcj?=
 =?us-ascii?Q?bsO91Xi6slehuUIhMkDtOKn9pGPvL+6oWpFhiYOBuHRiAl0TSxN1fk3iamrI?=
 =?us-ascii?Q?vdCENX908548NJGIfBWvtiIDlWpZgDTQ6Uyfrqn1/ywZwK3LmrxSGbUtFLn4?=
 =?us-ascii?Q?AGBk+s9/np9eeIjrgFOskEmZyqtERll/d/dCaB20AI1kU6JpJw2B7G3SQqPB?=
 =?us-ascii?Q?HqO+uydCGsanr0Bdq/mhGXUNygEqAi7+14meY6tjKw+u7ppYugJrXUdoHy91?=
 =?us-ascii?Q?vLMg05Dkz5s+Ij28XuxA4+OgtB4fDP5pBszhQJxt45Lkw2Ad4ZjVi+xD+3rP?=
 =?us-ascii?Q?H3XOi0BBFyVTS9gRiyrej4b6vEjYlluOX9QLD3ZNEM2HsQOosYDjnHF4PXQZ?=
 =?us-ascii?Q?I7y0F2V3xGIIo/eILeZdET6J/cyyOS6swyJi63jvbetaPKc9B8KEOMD3TVv/?=
 =?us-ascii?Q?l9fj1UY7gJ/IIHXwLdw8Y1IBMN2R+6Ti45ilc2ZXH/Zh48ZE1TqSSifwO1Tb?=
 =?us-ascii?Q?tKlbVfdqR1THwMF557M=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f9293be1-030e-4f61-e071-08db4fb8f389
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 11:39:58.2987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWJXt1Gbzh84zWMTfGP37uwZcyn1TmMvG7OBdcjd3qhslOnLqeCB2Q5ST5XeyA37v4rv4sPn5D0oAJv6ZJ6fsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 May 2023 12:40:15 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Currently, if the `kernel::error::Result` type is in scope (which is
> often is, since it's in the kernel's prelude), you cannot write
> `Result<T, SomeOtherErrorType>` when you want to use a different error
> type than `kernel::error::Error`.
> 
> To solve this we change the error type from being hard-coded to just
> being a default generic parameter. This still lets you write `Result<T>`
> when you just want to use the `Error` error type, but also lets you
> write `Result<T, SomeOtherErrorType>` when necessary.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/error.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 5f4114b30b94..01dd4d2f63d2 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -177,7 +177,7 @@ impl From<core::convert::Infallible> for Error {
>  /// Note that even if a function does not return anything when it succeeds,
>  /// it should still be modeled as returning a `Result` rather than
>  /// just an [`Error`].
> -pub type Result<T = ()> = core::result::Result<T, Error>;
> +pub type Result<T = (), E = Error> = core::result::Result<T, E>;
>  
>  /// Converts an integer as returned by a C kernel function to an error if it's negative, and
>  /// `Ok(())` otherwise.
> 
> base-commit: ea76e08f4d901a450619831a255e9e0a4c0ed162

