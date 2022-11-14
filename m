Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D2B62827E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbiKNO3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiKNO27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:28:59 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2097.outbound.protection.outlook.com [40.107.11.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F431E3E8;
        Mon, 14 Nov 2022 06:28:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKEFHUGWemVlQeTdQYlcSktw/hPwhmS3s+EyaMr6MMSKYTjJnxOBC7fu/csbzyJ4kVIXOAWSP644eDwaMYU1Z7Zl2suruZc5S4+Q2briXqr2ujsdpHAWg5jYjukHT7yjCK5WlXTqcD9aViun0kEODEh/qcWHdzkoTbL/r0ql9qmC3zxGMYTq4e8VdSiga3YZUC3mBuHbDSuN9dRS3mJJumlq6+mz/36pejFk5oW9a8KiHET3212Et1yDxtxIw7SYOqH83zatTuUEj2y4dwnuKAWhS4r5Lg17Su4IqYeXi60ZJf0mluI42GWUI0X9o6oKs0HEbT1C93H3cNQdxIuRRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huQGqQzPyHyDZ5a3CD5oOmPjN2HpveKB6Ww6KgKkvpw=;
 b=EhG/pJZiQ6J9gl3httNaw4UgjTQnfgNV6VmcgPhz/K4uBcCqr6DYSjj1CgWAGFJECI8icdmACH3nn3cglJwouKtLczGfrpwSkpQ8YRLLL41QG0vi7bcugo4YgFMMfSK7n0M9hEzhG/Fk9Nw3uq/7x4+sLEPV3n4oBLt5CZeJzFJ9u/J7E1NnPdV+Sxf7LU1VCqVJWvnwrV9VDSyepLXcP7uJ6TKVtFI1cwu59HDVh1YmTlFqdRp6W6nPpEZwFMhfZKmVK30rj3GNfBJ04TgALX+W5LCrtYxftnc7bAT+nP6M3FkDh5H1DzKtD295LMbhBUGHdtjk/qTRXHeGphDOXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huQGqQzPyHyDZ5a3CD5oOmPjN2HpveKB6Ww6KgKkvpw=;
 b=j0SpHsRO0Au4pjPEW/pKRgfBkii2q/BPJkIuIkw2ZOvqkXothBOXpJjmgIMz50AHJiPUeB9wtHI+6YNvMdjC0k5B51IBvLeaD7syVnLuP31WRqGZEqG6f25Rl+spBOtwK5PK5kWzAHW8+mUnnA8GrPmUVqpbaUB6Cq9USalYrAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB2356.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 14:28:54 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 14:28:54 +0000
Date:   Mon, 14 Nov 2022 14:28:53 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Finn Behrens <me@kloenk.dev>
Subject: Re: [PATCH v1 08/28] rust: error: declare errors using macro
Message-ID: <20221114142853.5200d36d@GaryWorkstation>
In-Reply-To: <20221110164152.26136-9-ojeda@kernel.org>
References: <20221110164152.26136-1-ojeda@kernel.org>
        <20221110164152.26136-9-ojeda@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0241.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::13) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB2356:EE_
X-MS-Office365-Filtering-Correlation-Id: cd24ea1b-eb7f-4b4f-b753-08dac64c8f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+RqnTtfI+og4pra+JAazVE/Pieme4zvyXZJlaFTCkFygdPvSTCpJkyBjHg5+O8m24Gia4nQJNIPUxP3dTT7PMgY1SSrmwJvxp1cVVMDrhswIUiByBTs2pPv/pUyQeNSGhAfskuiK3IaFNGyl38q4QQIStVambhrRo3brGWah7ip48iKD7oGpCouvjGEighWNrThbupKc8NP3Hz53+A1USoTyYPVH2X+JMND/L9ZI3yITTeCYzWbzHsJr2mTkQE/1WpJPQ1tC6QHL0I4dK5nTOsixc8jzfMp5bQz20p5NN3Ww5PUnlWOJmh4n81RsMAsKKb6VlCg7A+3eumdpmjHYfueh2gFrx8ofLGO8W3SQ2Atg8N5XNSDR3JurAOB2sUXoU3VZGqZ/95vhAPML92E4Ylq04AxD38S4FSiCw2k+kb+nu0rF2X2juQKQ7i1xl/crYKzLtOLuoCh+L2fhcGK9SnDOZQF09qf1NY4X0trjJrDcQ1PgxIZXIwtSfwbej2CAu1RhU4U4rg4z+/KokaLNiDjfCzqeU5qOoKik4EXWhVnzZCQYrwzyyTXioZSGwvRDX+kks55rHxsD6VgzBT7gTFVM99q8Ag4SlmHj+Y7gUGYE9nHx0GPHhsZYfC2PcgZV7dhIYRHrM7e4owZ9y7oSYxLKpklgLbeLM380EUJIr5lDJkVPRXZQ6KKnB/MU7PAr9c3UrL/nEZqXyWCc3SrqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(136003)(376002)(346002)(39830400003)(451199015)(6486002)(478600001)(38100700002)(86362001)(41300700001)(83380400001)(1076003)(2906002)(6506007)(6916009)(316002)(54906003)(66476007)(9686003)(8676002)(6512007)(66556008)(4326008)(5660300002)(33716001)(66946007)(186003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3dRsfyZPPQmAzGWhjjiplqLeQWAvjvJK2iGZJPzdlSjWDaKzXVOcfCH16pY9?=
 =?us-ascii?Q?3Fa0yTAivbnEX66q6GRquiBoZSNVP+l+eKcFQaEq1L5xAspRklyCDAx6jSOw?=
 =?us-ascii?Q?2jdH2rfplctqmxbJ+29HFdj1UtNo5u9GvLGSEvlNoi/BxclixBmrUdx69oOO?=
 =?us-ascii?Q?DUpojqnBgXJ/AZ1BuAwPLigWo2fMPuI45xobKCMSPT8jTa1isF5Y7UtHjd4R?=
 =?us-ascii?Q?sPhTSrxoaCBl9z+19a98mhqdePyX1LiMLkguosSZrtUt8K8nQ3TZ2WCEl07/?=
 =?us-ascii?Q?5EdRAT6kIujOZr0unj2SNK3mdVLTpnwStbtlEb5TQ0fJCIJ/0Id+20xmmtGA?=
 =?us-ascii?Q?j6NZOPCYZ9IsIb+BZa6yf0cOYwsQcb9r93vzXBrZj2MGuSMyWtBaBg5kbNAx?=
 =?us-ascii?Q?YsSrX5b8i1fuUg/wffq+dihM7aY1S1s8alA9M+OfgcpMaRnsU8YJ80Iw1PcQ?=
 =?us-ascii?Q?kYtof+uK8ej6v+OTSGjyMfCHoMH3KLk+v7T6GMo7PhUWvK56NAVAIsAcfdAP?=
 =?us-ascii?Q?JHuccy1odv1rj2E/E9+nlyIwmDpLt4omyMhUwM4fkM/SlMNUND1/9sgZuk5w?=
 =?us-ascii?Q?v+ARbQsDO7ueKx2FYeDRR3UYYcOBo1li2Y5eFCwZH7N2uepnDUZET91YomyF?=
 =?us-ascii?Q?Gnqji4rKqYOvhUUim6E9Hw9QgJujxuZSJRv93Sp3a9CCFxZieSuhVU+um+z+?=
 =?us-ascii?Q?7roFVCZdKBV3mWZrTydGUchZDfygXSp37hjVmeTcpjC4cKBwX8AMLJB+j4/1?=
 =?us-ascii?Q?oCx5mW1MTLEaZsp5pMEKMMmigLKFAQvatvV2cQDon0i6pgcWvtZ+Z0VEoqMY?=
 =?us-ascii?Q?SdRjAbkKMP2HLdbfhIT4kZmNA3cec7RdsqH+YtYcdw/1vszfBK/0BUCqX2Px?=
 =?us-ascii?Q?vS+WkISYjRjYCYjwXk1rIKwJjUwCS6rGNc64FGHMWClNW8QNWdODpNgZ9Dku?=
 =?us-ascii?Q?/Lnexz8XSNdV1IbICcstqcjyvJS+gK8ryp8k+7VrqB7p7pX7meOm9JSBqw1S?=
 =?us-ascii?Q?ZEoY7cUVnHtn4m30yaubShr7VqU+yUvORCRAV9H5a7nsIRYk/dxB4cBoFYmA?=
 =?us-ascii?Q?EwArmYBOQCvAFH5+jkIH4VUm88h6c7OMP9aboUKy9/E/VMGlLT3gvwubMZr5?=
 =?us-ascii?Q?9kZYEGzf0AsYRPReNXGhA7IZtt0a8UIq0InCPYykHwPLdlvlqnr+IhfcXpUo?=
 =?us-ascii?Q?aBldw0YeybxoftyeJcO5b16OWl93uOrpcd4aY5Ae7Il5+57uC+VUg3XXCW46?=
 =?us-ascii?Q?WHdeqK6SQBZl8irgYAHIW3Ov50durbt/l8VKDj2/BpS+e7qbv87eqdFtZSAu?=
 =?us-ascii?Q?OMSIiIEWO86j1ADf90HZdE7gQ7P8bqmE3P3E+JkDG84bgt1gp8AAmRKqTdEq?=
 =?us-ascii?Q?JZ/JzL6mb3/2B6E9CXfs4RmaescczlCNN2ADKpUt36TfBf0Tp7Ag+h2b6Vkw?=
 =?us-ascii?Q?6R1b9QT+7YG/5ItjPRWWkVB9P94WJi2XFGF9yByR+5GgUO6bMGMBsi6GW0Jz?=
 =?us-ascii?Q?7z9Ut6Ed9HL4M6YTh8EWvOxF3PEOO9li5RtKLUe4OWRoThURI7bkjNz2MfJW?=
 =?us-ascii?Q?AMoS3S5Xk0PNZU4NFMHFbxKmK/inIBQu2a/yP+LUKuiOt7SMF/pj03xNy44+?=
 =?us-ascii?Q?b+BUUCTKZiM7KFNGDHvmBaLTcuV3heg/kpUyFSrjWTSU?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cd24ea1b-eb7f-4b4f-b753-08dac64c8f03
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 14:28:54.6795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DbFZQQCI847iG90NBSgYwziULVs8ZIdZIRWa20M1VinUs8UuiB41zTfX6yHxLnVf/vG7IYRS3Z+obpSugfCpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2356
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 17:41:20 +0100
Miguel Ojeda <ojeda@kernel.org> wrote:

> From: Finn Behrens <me@kloenk.dev>
> 
> Add a macro to declare errors, which simplifies the work needed to
> add each one, avoids repetition of the code and makes it easier to
> change the way they are declared.
> 
> Signed-off-by: Finn Behrens <me@kloenk.dev>
> [Reworded, adapted for upstream and applied latest changes]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/error.rs | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 466b2a8fe569..b843f3445483 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -8,8 +8,16 @@ use alloc::collections::TryReserveError;
>  
>  /// Contains the C-compatible error codes.
>  pub mod code {
> -    /// Out of memory.
> -    pub const ENOMEM: super::Error = super::Error(-(crate::bindings::ENOMEM as i32));
> +    macro_rules! declare_err {
> +        ($err:tt $(,)? $($doc:expr),+) => {
> +            $(
> +            #[doc = $doc]
> +            )*
> +            pub const $err: super::Error = super::Error(-(crate::bindings::$err as i32));
> +        };
> +    }
> +
> +    declare_err!(ENOMEM, "Out of memory.");
>  }
>  
>  /// Generic integer kernel error.

