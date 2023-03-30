Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC096D0291
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjC3LHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjC3LHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:07:44 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2115.outbound.protection.outlook.com [40.107.11.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E2476A6;
        Thu, 30 Mar 2023 04:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvFUQ0MsE1zTzIeCoHsm19yfCVQygua2K1BhBmdDg8qZHh3lHA73ux93patPFTvFoNmhBP2K2LvDYHnCR40s9wAdp5Pcu3zcfmaaEWv3P4eVrnrnoZSjY8iQUy9KqYADW7AKgwhhRcne5DeLA0isGjG1V/GxjfHsDy9cjjoLEhpWZO/yWQWKZ5As1U7BIqK6oNk1Ps/bjyQm8a91RucYKitZu2fbcN/ZJeWU0C8XSeg2Yf5YQVIEpWsqAA5MxebUU8VE1RGzJgjICfmZlV2gbC6C11MZr2vIe72ERIq42UH8P+K306g2S93t46PtkZkVijUDdQG7VhJnseuPi/4j4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqPUIDU2qXj9FhAqs6lJucwbiW6plfupQvwjwmH+30M=;
 b=T7KFzIRVy3v+Oqj3P0MBdHxt4a9J5TfklVDGLD4wVqADT/ZSnuLo+y+ptGW2G82Po6ZzZFVZHrvLzCdaa+J5Q1CUFe4SkKeEgePdUys5lL3LIcOqxWAhJG6h8qCnMDlsJ3qwV1d5BNaY71dd9Rk1Q/4EjNhEamw09a7Dz51PrQ1v93DWfwgBpX1slHRbcaJJqNZz55rVtL8Y9M4l+RS834kVOcSCwvJxCpyvGNvgTP1PH3roQTJbkneetdEPyUWmmNVD93TyJBZ8hglGLuj2izEOsiMpJ9yGjblMptV45V3vVzNj3LC3CHfF9zEuPrv+IHhj1wI9caWRZ4QoNkNZPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqPUIDU2qXj9FhAqs6lJucwbiW6plfupQvwjwmH+30M=;
 b=cGDAmb7Pobiv404PDgp3DQyStV+fKb1YnIOWqTCfXbwEKHgnp4YZZNG10tG/KnBwoK0UjJal7ZCTwsgGHoj/H/A+jP42rPvc3871EaEHJQYSFzA/AkjZ2gSW9U2JMBMX/XDja6hqshGx0IC+MGaqCjxNTRERIFxmUPAo/85SV68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6823.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:349::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 11:07:03 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 11:07:03 +0000
Date:   Thu, 30 Mar 2023 12:07:02 +0100
From:   Gary Guo <gary@garyguo.net>
To:     y86-dev@protonmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 10/13] rust: prelude: add `pin-init` API items to
 prelude
Message-ID: <20230330120702.7974461f.gary@garyguo.net>
In-Reply-To: <20230329223239.138757-11-y86-dev@protonmail.com>
References: <20230329223239.138757-11-y86-dev@protonmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0401.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::10) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: ed96b5e8-8035-40e8-baff-08db310ee497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +stjW/AHenPTQw8BPMzgAQZ2+WJC6aZHSAojJ4TRmgNGyhsXnAcyElO9B15nIuhjqUYO58h2ePiiXcM1nWfbrMqzjx1HpxwmuPcO0mED3vWs7Yn1mXXz+KUIGTM73djTX5cV+jh3K/g2aCPTEL88P+MNxYQHSiKA9VFxhGiy3yihjd1xefmAExJBzEzzfN3vS+euzL0svpiSOmh76750V8sc4L6uJM53sOXgGjgUP6CYfGO7WOW/w4cFlCPmBrHBDHlzBgtOq1L3xKNWGm+LUON3ijwecjouGCSPtx9+TztJMaoovgxAY4RneC4M/26Xx5eO4HEpDsq58KXGX4hrbRH2WeMRD5alwVI0owLAdaOzMwX6/4Q10jlbRecnAV12EfxG3YNeAzqwtgCroL3SZlBaAdhNsLuA7a2r+6LV6+bIDDczgjognYsYdE9W3gYq9Ck+mogJ0KJTWkS6Zzv96nECpE8ncs0gsC68FK4vi7Em9/vXvDOmXP5EE4qx5LuR0jYqT4HwVe8cLIgoOOQ44Lc1JrozySp+Zwu7/z0jOILCp6IDjJuDjN4bJGSNP/YSrQgeq5QQziHo84IeuwdPGGSkJnM14eHGqKnaSZx5XpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(366004)(39840400004)(376002)(451199021)(41300700001)(8936002)(83380400001)(7416002)(5660300002)(2616005)(8676002)(66476007)(4326008)(66556008)(66946007)(6916009)(6512007)(1076003)(86362001)(26005)(316002)(6506007)(2906002)(36756003)(478600001)(186003)(6486002)(54906003)(38100700002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zPt8zlx0MDe/uxR6moQuPl82jSj2F89qGFY8PqoAQpQzgA5JEGhJPeoDbNwa?=
 =?us-ascii?Q?7KKcU78TKxj5XBYY25jGPTFq5HZlcPRSYMvaaK3ROl2t3S9KS8h0S1o6aSnU?=
 =?us-ascii?Q?n227WyUhjvSrE7EUYoA40zvKF5jGHXOTr27jOgAG4dOWpHRwHmwB1/igI39U?=
 =?us-ascii?Q?I41/5PHQR5slIHrKEbvGHWvLHppKZL5wm2stI6stK6Epx0cg/o+2LSYYK2uu?=
 =?us-ascii?Q?XPoMvg/u47HVxfTnwHcFv182wDFXw3hzR8GNZgZKTZE5KTZbePfHVNg4plTp?=
 =?us-ascii?Q?44T5dJJLiEU0g1N/5SeZpbjnKe4scxLkmuK7B5y3RjhlUgWkr4UCIOQtmCIX?=
 =?us-ascii?Q?dGhuArbHdYYicRsaPNx8rlnmnXT2nwG9mZswqUXFu1b+VS7FExOtSdkz/EXZ?=
 =?us-ascii?Q?EQZLxKJbl2uucDR1wQlZVnWxC+6mxW8r03jLZEvhE8x1waSC9EWq70Y6qy5g?=
 =?us-ascii?Q?qsQAVGpDGT5fUc3DPKeAGd9oXghrBuR2XxBTbobdd6NEfapF1mIjXadAoIYp?=
 =?us-ascii?Q?M1SW0KUqvzxT07fs1SQGtmJb6YcMl9yXlQpRAnyndNcYzpfLxzm5XLWYKiMg?=
 =?us-ascii?Q?1mA6E2j7JFrSL30TtZbEfgWYMoxamc8Ck71lU+2mQ9HhuNU/M7WdaJrdxfMx?=
 =?us-ascii?Q?4B3wRUJRVTwphT3dLYiUSHMFWORanWtH2KMKqB6CT0crZwFM256uIlXHPIsS?=
 =?us-ascii?Q?YRorEq0NgKXSXkryhsdzfZ9H1/GiD6gnmk39N8mzoVqKE9Qhl+NjbniAAd7Q?=
 =?us-ascii?Q?0HmESmFYUfQ7T/zCuAVubHj5eXljv1Mayn7wSadSizoJrQWQZ3x5nJ6TXmMu?=
 =?us-ascii?Q?BvDOWfbznD8OtzR16ZIEa7mpAg8R7GQuChzbrrSgaFpaVhi4HiZlDUEacoRh?=
 =?us-ascii?Q?1AEfTN2NLiAg0DAamX8mPGnBwcS2zbY074fzoOH7ePfK6dhFeCpoVrKoRn+k?=
 =?us-ascii?Q?wV7r43UJEyAPF0F0xSVAQAcO9KByXHytLVNlZV1kp1xmL2z0P/J9xINbyViV?=
 =?us-ascii?Q?ak5EuqoxaoBGMJHHrNM/cWc6Fe3x2T+w1f6dJT5Yii9dP2eUj9mUcMd7YQI6?=
 =?us-ascii?Q?9b71Z40OKW2243qoQD0xL67C1+Z45blCpKWcNn3aH8ygWhgTaDsRF74kVkNT?=
 =?us-ascii?Q?w+UTWf9xCoWceq8uP6fuFT9KVCn2dSCOBhpZEc/r7Nkl1OhNu0Voe+N2V0za?=
 =?us-ascii?Q?HdZcYIYz5LmG/5vR56hmi1KH1Igu04J+YLIH3Bp8xR3/N4d75ebx0sD3sJMq?=
 =?us-ascii?Q?lTfbsYM7VmeLvkLbDnjkySlpEiWRmZCnYljO74Tlav6Fj6VybxzD2+Chfb4L?=
 =?us-ascii?Q?NNuQ84B2Y98ijVOOqEwCpLRm6hIe4zNVvCBaHlTHyMTjl0N/gK6lPvXjby9m?=
 =?us-ascii?Q?8GLnyYEXN8+FOAddBF29ZPWqQm8VjEWV98NXAaPaHWOuvfrjy3wuVrawJ7nq?=
 =?us-ascii?Q?+h+mJ0bVXzQY5AbSaUfBuEEQnWLXwSGC7G0mcowE80iG3+wAga+hiFfYZJxY?=
 =?us-ascii?Q?+KPZ9Nu2Zi4tTVGGNlesTAR0OMc8H4WtBTpO7RB6a7VdsAaghOEd10M5v3jo?=
 =?us-ascii?Q?1PphYlWkKeKfOdXXaQXtoE6cylWac/JiFAwUtnT/?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ed96b5e8-8035-40e8-baff-08db310ee497
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 11:07:03.8714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qEMyRT2GoWiMeSdr9siVioz0YmssjHVFwtElMIc8XqCfGruD3VrUFXBz7oaFddh+8I51mQDxoPTpSxHXa7j5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6823
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 22:33:40 +0000
y86-dev@protonmail.com wrote:

> From: Benno Lossin <y86-dev@protonmail.com>
> 
> Add `pin-init` API macros and traits to the prelude.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/prelude.rs | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index 0bc1c97e5604..fcdc511d2ce8 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -18,7 +18,7 @@ pub use core::pin::Pin;
>  pub use alloc::{boxed::Box, vec::Vec};
> 
>  #[doc(no_inline)]
> -pub use macros::{module, vtable};
> +pub use macros::{module, pin_data, pinned_drop, vtable};
> 
>  pub use super::build_assert;
> 
> @@ -27,8 +27,12 @@ pub use super::build_assert;
>  pub use super::dbg;
>  pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
> 
> +pub use super::{init, pin_init, try_init, try_pin_init};
> +
>  pub use super::static_assert;
> 
>  pub use super::error::{code::*, Error, Result};
> 
>  pub use super::{str::CStr, ThisModule};
> +
> +pub use super::init::{InPlaceInit, Init, PinInit};
> --
> 2.39.2
> 
> 

