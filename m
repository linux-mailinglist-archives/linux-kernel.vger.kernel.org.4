Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520486A2C10
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 23:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjBYWT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 17:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBYWT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 17:19:26 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2128.outbound.protection.outlook.com [40.107.10.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56313AD26;
        Sat, 25 Feb 2023 14:19:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eo1Iq/9z6WgvfNGKb6KypawSBwei/BcXcfsfntvPJ+8PM4C9PVIHxaADqHAwLpRe7loUIqyTj/eBi//xXAU0yNCTbK7oAdgoreydkHCQ9nxDG0dZ6luMVXNUqZ1a0pPpzPtCy+lOPHpU48H+UC2f1zIuwvHxpb35q2OxwPJ3gZw/acMQowdq37Vi3QQz89pUN4Q+7NW4NkebGhUStkTt0gsX7YnXtz6+hZcjuTUywJH0GBBMZ0kiYQGzMYo/2MocdZFc6TIcRXdExTaWCiP0dW5Re+s2ld+lgJDZmyEA6eTe3dVyz2NmThHaLBqO5ncddd8a9cwEqqzok2xgfl32Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9SpIewA6ht6srK08bD0aiGj+ttmcfOuM9jW3b8YEJw=;
 b=JSY7Cx160NC/x2s+BpVPkPgV1+efWtpSpIpn6hmVMcga1m9l6W1XaY1hjoUhFdnQ4dxUlIEhdNZ5JhQFwrVzZLnc9HCf1jYQj0rOkmDPE/A8tjwDeXtHa+D6DB4t79io56tNrwgH++CkHIeCsM0K4FUaJ/NnV5J8mPpBQzokh9If7XsrhyMw/JfJf5yWUM7aBEVAWfihUf/wCuNfV7u8sCucr/KyzeW3PjPWEDDOqpw3AFnRHjDoZ+CDhSToW/bvf6xhcTzIsYBVW9U2WhXV7UBmmUnzYBblA7En/IpUffiM2Z3flxdMngOnMjrJw7IdtSrvw81Ef1E5YWQM6EbdQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9SpIewA6ht6srK08bD0aiGj+ttmcfOuM9jW3b8YEJw=;
 b=sYRvlDkCeOXzM7rBmmPOBxX8QwxMwdIvX8w4avOF89SNuG1smugZFQASRUJ0pY1wHopr6DTZ0FhmIm5uCr+0Isf9ye8B+eBMq760e+rXo8rvj2Sy0OmF7TjHyO6SSh42CBLYMZeUmUagOMCLiFEHkR8W6evy62Lu++JBwfny1H4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5066.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Sat, 25 Feb
 2023 22:19:23 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%3]) with mapi id 15.20.6134.025; Sat, 25 Feb 2023
 22:19:23 +0000
Date:   Sat, 25 Feb 2023 22:19:21 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH 2/5] rust: error: Add Error::from_kernel_errno()
Message-ID: <20230225221921.4b4bc87d.gary@garyguo.net>
In-Reply-To: <20230224-rust-error-v1-2-f8f9a9a87303@asahilina.net>
References: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
        <20230224-rust-error-v1-2-f8f9a9a87303@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0320.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5066:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db54e8f-0eab-4e29-2e6b-08db177e5928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvzmj+9BlJgqdXbMnuS/HL1W4KWVTveq9D3Ntjc7qgaTXbT5EW90eKkIYQCBhfkHoHkGxugpfZriGCtQUUqGA29IB4tjZfL0GbcSRIydOnuYzLlHUvl6ykgjNENCxgzATzaVIqPFWyIqPgYw66sIzqlsPhAIW3NWUwMx+DJigPNO9ofuiG0x8xboZIOrNaTY60l4nOM58l+Abi9kK1vqUeYs4vbuRpV9gKtGpERV4lgiF38ddYK319VJVrAI+NRAoU12yOc2bGHGnMY1VV9ZwZbjmD2NxaP4my1kOFpuTG3EwDBbWMYMxCniLZT9rI1Pz/JHGPggHEwgDLS++eoFgiodpkeMKMcQdo0vtWjN8uLcNERuMGJS7fkKChSs4S+sjisrZ2cIQYmIzXJaKAYxaqMO8BLC+7zd7ytvaEZgSa01m/xNdjhXaj+UEz//RRpC69jW6YgFKQux+DauwmxBt90A5LnF6c24/H2wwZtIfLrZE9+qCritjY7lVPYE4bjOWDOiFDHa+souCKfoch/IAj6y09mideFvuF++kibr47FC9wQu3p1QAfkGtboJq0lyYTy9TFDJoAaTzQLE9CmtrENX/3CanbWDHf5ICZrNir7sEFlzMA8e/BI3rwf+L9WLGVEY6MLrvlHyCW+PNi871w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(396003)(39830400003)(376002)(366004)(346002)(136003)(451199018)(8936002)(7416002)(5660300002)(2906002)(66946007)(66556008)(66476007)(4326008)(6916009)(8676002)(54906003)(478600001)(316002)(6486002)(41300700001)(6512007)(26005)(1076003)(6506007)(186003)(2616005)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sbw3orA6ed9y6XxGm2LYtjCmw1Lsr+5EMI1Wd+u4tJO+OI1WbM0b2rgC5uzr?=
 =?us-ascii?Q?pF/lMbnVpwSIUrsHMGa/C2n7VHvVRqrYav1G0PQf3E1523hBqMrv/D5Fc81s?=
 =?us-ascii?Q?ALTmTyhwnpHY+ppMSsviPw7GUdkQ+K02g/ZNt+ewR4vw1tiE6diQHyzysL86?=
 =?us-ascii?Q?1nshiqu9OolsDJYxSCEXA7Z4/LbSEwxVyXoIGMiaQfib2TLmgda9MNMGcAk2?=
 =?us-ascii?Q?yGwLJBQPxeJGtYLBf4D4pJlmt/cVGeFvimWlkEcUyFDlwJJppmJMVzgXwlR8?=
 =?us-ascii?Q?nNGnPnhrM2JkCLkXgP1ShLV9neOEF6QQOLWrkiQ76fWD/IsJ1gNTOGb+QsOz?=
 =?us-ascii?Q?pUGDwmXywagbWPRYfKuYDl7IJ5N14sQlSlUkilKE3wAoV0rg0GpkcBRwdADn?=
 =?us-ascii?Q?khp2KGBBiLjXzrU/VAqdipgwDb4TgnXlVAeb+ErdbtrPQDe4zVQ398t548fj?=
 =?us-ascii?Q?V1kWNWVx0sCd7gk6XUWsKlJnG67O7tnYAyxWODSzuhEtTG+uptUCfjbNZnF6?=
 =?us-ascii?Q?uss0lshDzyQmm5uZRT+e7SkudNVZEFpBjhC3xcSMklIceXAPIy0z0e2xndIT?=
 =?us-ascii?Q?EBn4QMjz1VCa5GQfTLtBhnLNnCmkTcJ2S3vqXfSfCgv4yW6bgPFY0rz9B2sm?=
 =?us-ascii?Q?PhXbqRNWBFwuZwd41DdvyUpmAfBF3bY5bZt72ghgh25FP3fRdjswzaOzOhCP?=
 =?us-ascii?Q?8UUqTZMFfxhpD6JprXKm4P6IYABvX+v4W5HBpfqnHwwha3V0mRAuHW2RzcTN?=
 =?us-ascii?Q?KgMZhbPPXn1LoqCnTryoQMXS0i4GkqYm5TIRKN8XnmaJvaRtLADB78Mf4ANl?=
 =?us-ascii?Q?+cFo2E1AqsC9xqHzaOSuWVMl3Wg53aXm/+Ts42tZ+gQNTfb/A2NEYf3l/aTN?=
 =?us-ascii?Q?H62FxGNJ1PuXOMroy7GTH7j0ea3bHSLepcws2J4AWWPG8oE81dura9uLHk3m?=
 =?us-ascii?Q?r9Mr8VhqdeKtVGZD3HrxZYQrmu7aDPvvNJ4aIueHwcqagRrLKKwiTex1S/Kg?=
 =?us-ascii?Q?K5vd/Y3uGt/Zeu7HMIEQBCAPwCeAc3cQhB9402VXws4t/eUNTb3R11KD8xa6?=
 =?us-ascii?Q?BK/wWbJOEl7waVRlNvzvzJg690vU86LxUCEfC86A6byW6Jk2CebZqAhfRgya?=
 =?us-ascii?Q?WmefJGWILjZAWXDSWchcdBxiZ3H9K8Cgsmd58TYgsEIhh10r+BfnFDneCd/l?=
 =?us-ascii?Q?w97NpvIEWgyDidccJZhsPe3vRnsxzTdUU77rF7sN55xLqWbelhg03udDqw+0?=
 =?us-ascii?Q?/YLNByQ/JNXlEWzW9wFwk2gGJi3z17se0EBENaexiPUuDq3/L6aZbrA9sqeS?=
 =?us-ascii?Q?2PfbZZh0iKJyOjGRTjlMdJau1Hz85smzhN1UoL5n4D1q8TD2dXBnOiemdFKf?=
 =?us-ascii?Q?g4xJR3zW5YRYTvwjrbBmbe6E92LMuduZbv1BOJDOpkl/UGw9yubCCnL5anDZ?=
 =?us-ascii?Q?CSyxlXR/7+ipm3TAyJcPp7B7ELfb7lOmrCUDYLPFkO5fQ1sVA27qGIdJf3WT?=
 =?us-ascii?Q?lrEKNJT5h7Gh5t7nuQzpSHmvSvYvi5rP2icy9ux/0N2JVEZEUVfXCMAQzTUl?=
 =?us-ascii?Q?dvHS5ruoKs6iOLgUTuCxU04AKcwA4pTuqLUmrTwd?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db54e8f-0eab-4e29-2e6b-08db177e5928
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 22:19:23.3118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Kd3DCJk9vT2CdomCETcxZfFzj3okxrr2+00840hMVHkS02JpUyJA3RxF0/MoGNXFM4f4eO4gesMkZqNcp0L4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 17:50:20 +0900
Asahi Lina <lina@asahilina.net> wrote:

> From: Miguel Ojeda <ojeda@kernel.org>
> 
> Add a function to create `Error` values out of a kernel error return,
> which safely upholds the invariant that the error code is well-formed
> (negative and greater than -MAX_ERRNO). If a malformed code is passed
> in, it will be converted to EINVAL.
> 
> Lina: Imported from rust-for-linux/rust as authored by Miguel and Fox
> with refactoring from Wedson.
> 
> Co-developed-by: Fox Chen <foxhlchen@gmail.com>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/kernel/error.rs | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 8611758e27f4..3b439fdb405c 100644
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
> +    pub(crate) fn from_kernel_errno(errno: core::ffi::c_int) -> Error {

Maybe just `from_errno`? I don't know why `kernel` would need to be
emphasised here.

Best,
Gary
