Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B2C6D6266
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjDDNL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbjDDNLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:11:23 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2117.outbound.protection.outlook.com [40.107.10.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8913170C;
        Tue,  4 Apr 2023 06:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4jlSHnjPl1h2Ud47GwtLMEX+FFCZQ0ytOTt+tojjyeqrvpvVXysdee1S9O/9GiZgMzvRAeyN/jtRpKKvLOqLi7ANRgwGaW9ok33ciSRy7xzsuyNdRl96OFK5kkOHaKiKNQPSiITaDox8IKYaS9vIVTuHzgG28eHAi8qhOnHIMfJYxYKrGxDblpOaE8FsvO7NeJMQGGw6kn1ytcHNDIztUtcRSjQBfmzObW4fFWyRZb5BmOgGoqwhRCeWg3JJ8gg4VjolX8e8Zh1S9h75fhWXQIyw0DkIMv4mFItkv/m242E+xPRPxBdNIxPnzTHOM2QteFC3jRf9lOqsJvbZ/CfOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mddkWgCLR8mKQbUELfmtvPs82p6xVxTzryUemsGLIo4=;
 b=JmuLqbBhliFwHqYa11QQF9fdYVSxDmwaGFaGP9btxZNQSb0/T1/mUZ8Jzbua/R8DRUyfDcstSLTK8pf7hKQi7r+DmEVvkK0DLqD1N4+iSyIqHSEReNdin8Pso6nNLAnCkJzivJRWvoJRW+yoonuWXayrlaippnxzpvYu2IoRDre3HlY0XGdn9kJPd+m7cwM46EIOeTof+m6bnWEGrbqc7ZeKkgOS5fLHTYRnZJvNd5Iuh8MWubYsRCW6ctOz4FvTXZrnmWvJbEqpUmLu4Xd4HHDw+YebFYg70R4KCC8KCKJ9iMRbIOnZhNBwiCKNQ6/Ig+B8u//etIFkpTyjf3FRmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mddkWgCLR8mKQbUELfmtvPs82p6xVxTzryUemsGLIo4=;
 b=nOwLaV2v52P9z1NShlbI3iWfw0TgezNPqnXLs46Esh4f8/6+XVxZZitaEikjpr8BA2IVb8kH9fnlI3COItNB+73qrJJhSpyVgIGf+OkiupXkeDIgEaCyYmsA6FM90GKU+O5UEdczYTRkqm+csNI8pN8rQGwJludBwGPaCgMNHR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB5086.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:251::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 13:11:18 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%5]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 13:11:18 +0000
Date:   Tue, 4 Apr 2023 14:11:16 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <y86-dev@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v5 01/15] rust: enable the `pin_macro` feature
Message-ID: <20230404141116.23ac0e05.gary@garyguo.net>
In-Reply-To: <20230403154422.168633-2-y86-dev@protonmail.com>
References: <20230403154422.168633-1-y86-dev@protonmail.com>
        <20230403154422.168633-2-y86-dev@protonmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::21) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 4320c2a4-0b2d-4abd-2156-08db350e13d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/O2mIb482dcMOQuqowBLogu5yB89e8bQ+UPlSSJvYtFvmL5tItscO25TObXWMNjb0Jm4vm7XHEB7ox40hN+nPBJUj7F9nRgAf8M+AUxaAqHKQJhTrA33F46mMikVjp/HYd//0OkJOsec1SItEkTYIYtI0J9bGe3Tm5SaT/IJ2qSDSAAsDidKyQDe4BIzy/rZh2O/p4/SvNypqq8xZJD/ilOGvsz5twPl6XXTQgiWmf15H10mZDrYX/JPZmT1jEEpX/l/hceDJpi/4YrdFVaXjBVS7F2AERuB8kFTrPPVLQSPj77XwQzbVv0dGpMfj23FyrxHMDoagvb8QbhqOU58RelnAYZLmwbJsElXlspK7XFFhEBRIaYNuwkETXRzqLTa4hgT9gggzauwHi8wrFNe2vo0BfLvPe6sUcg6zdPPyDVv9p3t1qQjaLwNrweH3OQCShpeqNT0kt0km9JiLcJQvDLRZ34Ho+l5Pm+T5nCD6gshntmYfiC8DuRszb3erqO+Fwfz7ZIvSCFrKD7ozCwiatwhu4pSva40g/QRvLy0KCQRUnN7WTAicPILPG5yMLOu+A70E0beDdFKQsug/IYyGT+yCw+byYWPuycY3CQRNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(376002)(396003)(39830400003)(451199021)(66946007)(66556008)(66476007)(41300700001)(8676002)(4326008)(7416002)(5660300002)(8936002)(54906003)(478600001)(6506007)(6486002)(1076003)(6512007)(26005)(186003)(2616005)(83380400001)(316002)(110136005)(86362001)(38100700002)(2906002)(36756003)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i5t0tahuZV/vZXu+16VtinLoNwXfXYMQ7s3+VC9PITOfvPvZ8rObb+vZcpSE?=
 =?us-ascii?Q?5hmdU5qqYFHF59GzQEHjV/0UAfnTyZ3QdRMi5yZ13mGhFyHiFWv3hhj0t4Jp?=
 =?us-ascii?Q?FxJIoBeN6F4yBgXdj0yQ/Ya0QXsAoC8WK2w2knUZ69M4OAlbGox6L8zbsu7+?=
 =?us-ascii?Q?TxPc5GxhXugFCK7euHNeFs/vn6IdwXYbKIIiPZKqJ5SeH/CcmGgxYUNl9Bs6?=
 =?us-ascii?Q?PFO3QBdDy/mW/potk4UvjDaK16RqqjccxvRF0dU3kJsjB0QJZQlzwrhJu5c+?=
 =?us-ascii?Q?uj24t3XlwIYE4KIInuIrm9m/36QN/plKMX1hEfsQNojYVLtx+0doxzOQJuJk?=
 =?us-ascii?Q?xcO051189mBPdARwfYecH32+kzFx5iSjMsOuHz5tlz0tPhDi09p5l8QYLQl+?=
 =?us-ascii?Q?nrvFyZRuXN0QF4kGPVfWixtiXHbX/85qJ9qO+fwE1Ymf36kMFxj07Mb64QfP?=
 =?us-ascii?Q?xKIwI17/CJN8F3JYc+Nampmx7ye3vdb0ZIcq1SGBY1WNuzmDNWIY1juco+E5?=
 =?us-ascii?Q?VQFxsvHk+e/EIuM0di15NWWEyFtRzfGbAohxy4Aiztmti1dnmISS9arLtDGG?=
 =?us-ascii?Q?Ck1LC6ce1ssYS/HKYSSMy0Q5+32Ez/F0vK1/k2vMNtHul2eVxfihmsO1axm4?=
 =?us-ascii?Q?37cSqVMpRgq1g3DnKejlbi97wQQ+9sWaqxfskK1HOXQ46sSCMNT/AjZsa+BX?=
 =?us-ascii?Q?po0D0nE7C1Z1E1h3uJNQ0Wk1eUInGk4zTIsjRnhQADWQK30DH4b3Io2rCp3B?=
 =?us-ascii?Q?zRaJFsBlC1VK/CGPFh0udQtWEe8IHduz2lFq8VdWFuGLobudnhwyDtw1MNSI?=
 =?us-ascii?Q?epJVytmAjC+q6nld9CtYaoNRgUBGCsQAZzYlKsErV0iYLCBxsxoUU6G7dFBq?=
 =?us-ascii?Q?gMX4RSY2OaABjaP2GPosUexAbyxo1qOWiQIUjCqkV005ZlY2ysqH2sfsUb7i?=
 =?us-ascii?Q?H7G2QCT5tFSN7neD5/rAkOvcDQIg7S4sxzbdKnMuqKH/vsO5f2nmNzEBjuuc?=
 =?us-ascii?Q?0tC41ke/bBYiZPhwgjY1o1jx8uLzmSbUMLFvNntZYQT1Td63zt9k1Z4nqID9?=
 =?us-ascii?Q?RHO6M0zi4i0IUXkchHLk2hka2gDFBMasUQoU81aKdafa0xYhcOTPjkZZOm9o?=
 =?us-ascii?Q?OZbPCoqQBovHF06oafsIpZxRKTHvE2H1n1fdkmzX/xTK/SH79Mqnj+yL5n5U?=
 =?us-ascii?Q?5Z2ujS1k13knzKT+LYs+GK+mFyE2JPRl5TyCHdVwzvvg8BsRvE6fIqMmDfuN?=
 =?us-ascii?Q?N9ZaC/URdt5Kf6RAFIjUv7Yd2klnkTfZXF7hIkwYW7xDzQHdFOiO88FfdEuq?=
 =?us-ascii?Q?qmFg7VF1yxSmIg3h/+Tf0qFpUQ91naAq6lHy14G4zaiRIPVK0uL/uAInCBcS?=
 =?us-ascii?Q?FLocpXS1NP1wvavQAagQWOIvDfkLwJx+Xqg/gjAFEzlBVcjGmXfQMNPiu6N+?=
 =?us-ascii?Q?R3/8jgkOxE62jot9RTmEYTd4kh9AuioFyJF/kd/te5ekNdocp8nXICA5lRDH?=
 =?us-ascii?Q?iecffe1XfkIlj95bhWbauXxkxAMYRqfN10wpjbFOSqpWYwaan7NeKORH/JuX?=
 =?us-ascii?Q?VnJ1CIpIvQ1EcFxn+4LvpJ3vi+DheoQIJ0xjboTT?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4320c2a4-0b2d-4abd-2156-08db350e13d4
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 13:11:18.3343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 276+GJ6Y3PA+a5ceHSjiZ5rBCjkBDE6e81t4g+huDb1sa0X2vOL6LNA8XYp4pFSBZgjLSPoghUXuSPuRjKpXyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5086
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 15:44:46 +0000
Benno Lossin <y86-dev@protonmail.com> wrote:

> This feature enables the use of the `pin!` macro for the `stack_pin_init!`
> macro. This feature is already stabilized in Rust version 1.68.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Acked-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/lib.rs     | 1 +
>  scripts/Makefile.build | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 223564f9f0cc..4317b6d5f50b 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -17,6 +17,7 @@
>  #![feature(core_ffi_c)]
>  #![feature(dispatch_from_dyn)]
>  #![feature(generic_associated_types)]
> +#![feature(pin_macro)]
>  #![feature(receiver_trait)]
>  #![feature(unsize)]
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 76323201232a..ba4102b9d94d 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -277,7 +277,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
>  # Compile Rust sources (.rs)
>  # ---------------------------------------------------------------------------
> 
> -rust_allowed_features := core_ffi_c
> +rust_allowed_features := core_ffi_c,pin_macro
> 
>  rust_common_cmd = \
>  	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
> --
> 2.39.2
> 
> 

