Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B263D664396
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbjAJOsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238714AbjAJOr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:47:57 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2105.outbound.protection.outlook.com [40.107.11.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4436E4FD7F;
        Tue, 10 Jan 2023 06:47:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKQPH+HFWqJCVqZ2JscwU6R5HWiayzO8oE29BJALO8WCQj+GbBj9N6oZohfk3wjrqa4+0ehthaZJWtjbHIQFyDLc3r1II8gYuAQFly5bOLGCsw4k8vYE9PjxsZ0m026J/UFi+Efvxsmk5/mqp09p2CeFWmVO7GC0/EZdI9IgswCM35JFIKAstd+i7xKBEvS22Y0mn5GbyH2b4rk51EZct0pzkvbXcxBBKLOOhdsIQpJqclsZY0aT5pFsNAzUhNI8asdEYmnBUzCOHed/19g+nYMoyEj2Kn+vKCe58TLtDQdESOwzwVM6ecqf7r4SOBNOM7jJityNT6Qsrr82p3mjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ont0KjCpcMkpToXrEPKhqsHsiHrRUgGsmldGI7N2CVM=;
 b=mfcBWkRZiTiTjKlyWmOlTxG9Bl6pJnoOtwsWOpVA2UB+g9t5RmxwKV2FV80Q8wkv6ryjz1pT65PJPmardx/En82kV2rbWowemea0X31Up0H+lu1xmQjFF2pTu5PAGQOcgwHnzrg7rI5W1Au9SmY1yesvM2Y7rsNhu02wZpLjNXQ64mib9kPojjLfUj4lCXCRvG8J57Q51BRGqZQQkDFWP04+DkXtAYOg9kXASKPkQDSPV7fsK466IUmuj+H+i96EtPdO6qQlCAwkS9a228tGhCRkh9tAQP8kVlREyuGLLeA7m78OmxFMkPM69fVL+jD1I20qVOoqGXYF+8sUAE4s2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ont0KjCpcMkpToXrEPKhqsHsiHrRUgGsmldGI7N2CVM=;
 b=e0XF/nb7RPUI3cYOQQ7uEZcq7Sxi0XS3DTfpN4DIDz8WLEWeO1wu0JclO1KxY4bh+F2d4hggFUdDboNghXmviLXcPiPJMeesFj9lYtHqCS0BL5CIyHm1lW70U0tzoD9r9A5Qd3T945tGWK/ZorFdPEK5EQbVBkRFAtuJY1LtPiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB2578.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 14:47:52 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8%7]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 14:47:52 +0000
Date:   Tue, 10 Jan 2023 14:47:25 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev,
        Domen Puncer Kugler <domen.puncerkugler@nccgroup.com>
Subject: Re: [PATCH] rust: print: avoid evaluating arguments in `pr_*`
 macros in `unsafe` blocks
Message-ID: <20230110141707.39e4fe6a.gary@garyguo.net>
In-Reply-To: <20230109204912.539790-1-ojeda@kernel.org>
References: <20230109204912.539790-1-ojeda@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0043.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB2578:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e259860-3f5c-42b6-0e2f-08daf319a677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQnA1XoKoivHY11ADYa+zahTqiz8PnKVK0RHgZzUnzphmTx4JL922/BXAvrVqemn4eYBhPMFCxunbWwqGu7pFqEsR3d0LClPDYPPsICegDUhIb5wnk4zub5m/Q8Ki14ffeM7Nekzz67OY28nWfMr+mRSo89JeJYHAlJFckTU1gkJ67XNIxdENbY67zimlonqtzyBXOagkAfJ3eFONLNSemCw9s8vYpchcTgHlF69aNt7lBNbJkXQMdWT25tzqRwbrEpWUOI5ZBrLcgqBgpSDwv7PNBa8Uqt63Ccmz1092zicSnDILT38Y9D4umXhBZPGiWeusso4ywvQUsBaW9rvFnG7FirivbHVqFiE11VxZcR651I+VXP78HZVC57clpSWJHgycJgOhnhRu+sA+OAVOD0CBmx3U6yiKWHXYbPs+NpmvMAK395cWkUjywwIxYTsDJcObJKJ3QcxxdyPvmJXLdE5oZ4u9+w0kHnUrFrODi01GXSdCIsl7MLxpCzr1dtyXiwWkIUiwipsnt+3Kafdt/00Db/BV26S3eBUeGWAvdb/fKWN9XMhasFTNHDsfTLhJ0f86D1L+U9E8LqjjWWAB1MMmBGmZWor32e3OSy8MnSOdFMoK0XInjbVyj7OtnaCxhrGvN++MH0q35JPEPRfqP3z7MA/jGo7RPhX5vD6+KKtxmGNtZFiOlhKOfgDE0AopXjfjMzdifHQ3WgU0NCgy305No4pkDRS+a3CmAfq4Zs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(39830400003)(366004)(376002)(346002)(136003)(451199015)(6506007)(26005)(478600001)(6486002)(186003)(1076003)(6916009)(6512007)(966005)(2616005)(66476007)(8676002)(66946007)(6666004)(41300700001)(4326008)(54906003)(316002)(83380400001)(86362001)(38100700002)(66556008)(2906002)(8936002)(5660300002)(36756003)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?prsVnYT8lgFXF6FzVtBKmuqZ6TFbeaL1wJsGH+UQDWlsacsgIPnqs5DXzi1U?=
 =?us-ascii?Q?8kZsd/ei70j5J9ezO+WDB7LjP0rryPv8hkKdLixpjO5K3Hv3/lG2e1bI4r21?=
 =?us-ascii?Q?rxAp+RYwS8c7SNE76hLfn3LtOofnr7fh3LlGoixfVdn89n7Ceeawh93j9vYJ?=
 =?us-ascii?Q?h87Vzhm2YcFHBnPfHeTfPiq9o194iDnG+5xuFJEqTrX7mRZGovnMawHRNl7u?=
 =?us-ascii?Q?ApQkCgIgKkJjLHhlfy+JNxji44eQDH17c/vUsBcumg7XLcGHbFBAiGzcmHcH?=
 =?us-ascii?Q?auK/5yw5HJgTN9kTCoIcTohyjepyU+gBVW+fE5PLLBO759bbLvTLOcSZjaQX?=
 =?us-ascii?Q?nNDQ9eypxGjj5BQIP3EEgQb0qZh0laGgX7NY0Ue4P1R7jdYJ2u71CvW65uw+?=
 =?us-ascii?Q?+NrmBRaaKB3o5S+2pKyUg87rO8XQDW2gwL05Bp30XAi/f6MCVLnC2OmVzNHP?=
 =?us-ascii?Q?tVd2Zq/BsAKLS8hw6aRbSbg5N8HPD181SgqQ4Eb1RtjH6Ty5FMBcxEyfNxqS?=
 =?us-ascii?Q?Jn6xmaPg5hHD6+gsuMI6egB2t79yRKqaZOOQCS2pLzCRNudSpKFnV9KTRdLt?=
 =?us-ascii?Q?cECHX9grWEFFIVhYa/UqIqzzVP0npPek6NHEKMYbee/KgU7rO9L8mKqpffqF?=
 =?us-ascii?Q?r7m1kvKmEUnbs4Hxcjcr01HoNx6T1p5uqg4GIhwpsmqYG3yep5knRdYd460x?=
 =?us-ascii?Q?Q4aWnJ1spsV5gAFR3mP3179MHTtiob/sULxFr4iSDSHUWYAk0QDIl/VJqbia?=
 =?us-ascii?Q?iCeINeEjEAVCDFm8uf2bF3Kkz/rqiKvqnzYGdsuWnKQm7CsZZHgexl9Iwarw?=
 =?us-ascii?Q?CKXQDZ83Avf+KcKy7hOPcV1F+khLYlvJskOUk6nUuMUmt7V5AiWNpt27JmG/?=
 =?us-ascii?Q?N9eNRTORclYkeBjaOzanVK6s24dl4GsnyBeWqjyREtMmtwuu+ElQmMKdXpqU?=
 =?us-ascii?Q?WXgZrnw0FTKTKlbm+7Y4YdAVc7m/U8wR+eeWlGJM2qtVdf9HC6hyluy0Z2sq?=
 =?us-ascii?Q?4B/Lzz48Qfr9A+OR4r7j8Qts0StiQ3uB+BrTl/NIOceKGeqF+4rGusAywzCO?=
 =?us-ascii?Q?Wek3+LmT3B7R/KIr2zERlZIazi7a9rjhvcBZXH8vCd9DGQEK4ufnrbLNnAHP?=
 =?us-ascii?Q?kF15Kn/bR/27S+1eW1pqBKjh/yqkemlDhCITCaS69mKpRlob6k0y5Q5ZnWpC?=
 =?us-ascii?Q?ZOO6rvkS9V12lN3OlIQ+Db6p29g7aV4cUSZYbMQHUE1QCrtquBrRuNB/RgX+?=
 =?us-ascii?Q?POkLs34BmkuA0LIxA+m87fyCgGcC0C4c8eqMnmmAvlNcDgR2DDoLx+P5pb36?=
 =?us-ascii?Q?X1l7X40rJZesEUWoWXHrUo7N7u0KS3ddGTPGTWPq9hLgiSde4bdLNFiWF8cV?=
 =?us-ascii?Q?vKkxqjmYYULh7kSqvpayuI7TZUyCfds571JxQnRP7m8DHEaQFgQgA9mDAPmt?=
 =?us-ascii?Q?4FzKu0arRUR28VUYBhthxPuqgy4ljyuAijwun1NNx3QyKJnM7z3/9qU/c2yq?=
 =?us-ascii?Q?hYy+MFw/Z4pzYDWamB8VDyZcqR0lJzNPYR+xZDQT0MWk766PZbIT/iPLeXsN?=
 =?us-ascii?Q?u8w6vF5MMEOZEUyIdN6y3Vyr7AMtpCseK4XX3ocH?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e259860-3f5c-42b6-0e2f-08daf319a677
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 14:47:52.0617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trLgAr7bXdmm/fntEiqmEJ23aP35sSX7EshrqPk8YcEP5uPYEtHz2XvD69N87Qkx8kPCl41OpuzaS/zHXFRHgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2578
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Jan 2023 21:49:12 +0100
Miguel Ojeda <ojeda@kernel.org> wrote:

> At the moment it is possible to perform unsafe operations in
> the arguments of `pr_*` macros since they are evaluated inside
> an `unsafe` block:
> 
>     let x = &10u32 as *const u32;
>     pr_info!("{}", *x);
> 
> In other words, this is a soundness issue.
> 
> Fix it so that it requires an explicit `unsafe` block.
> 
> Reported-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Reported-by: Domen Puncer Kugler <domen.puncerkugler@nccgroup.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/479
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/print.rs | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
> index 29bf9c2e8aee..30103325696d 100644
> --- a/rust/kernel/print.rs
> +++ b/rust/kernel/print.rs
> @@ -142,17 +142,24 @@ pub fn call_printk_cont(args: fmt::Arguments<'_>) {
>  macro_rules! print_macro (
>      // The non-continuation cases (most of them, e.g. `INFO`).
>      ($format_string:path, false, $($arg:tt)+) => (
> -        // SAFETY: This hidden macro should only be called by the documented
> -        // printing macros which ensure the format string is one of the fixed
> -        // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
> -        // by the `module!` proc macro or fixed values defined in a kernel
> -        // crate.
> -        unsafe {
> -            $crate::print::call_printk(
> -                &$format_string,
> -                crate::__LOG_PREFIX,
> -                format_args!($($arg)+),
> -            );
> +        // To remain sound, `arg`s must be expanded outside the `unsafe` block.
> +        // Typically one would use a `let` binding for that; however, `format_args!`
> +        // takes borrows on the arguments, but does not extend the scope of temporaries.
> +        // Therefore, a `match` expression is used to keep them around, since
> +        // the scrutinee is kept until the end of the `match`.
> +        match format_args!($($arg)+) {
> +            // SAFETY: This hidden macro should only be called by the documented
> +            // printing macros which ensure the format string is one of the fixed
> +            // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
> +            // by the `module!` proc macro or fixed values defined in a kernel
> +            // crate.
> +            args => unsafe {
> +                $crate::print::call_printk(
> +                    &$format_string,
> +                    crate::__LOG_PREFIX,
> +                    args,
> +                );
> +            }
>          }
>      );
>  
> 
> base-commit: b7bfaa761d760e72a969d116517eaa12e404c262

