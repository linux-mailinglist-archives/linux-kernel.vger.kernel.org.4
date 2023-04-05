Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891D16D881D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbjDEUWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjDEUV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:21:59 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2114.outbound.protection.outlook.com [40.107.11.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54E919BF;
        Wed,  5 Apr 2023 13:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGO2aor7EpuTXKFK6Beehzo7GRXv4rKFR/HQZ25aWfiZ7cmI6GDnvWGuZVFiBTNrBVorLGHkCGi2eHGRkZNLnReuBVlQ2o9E7dV0JI4zTpS2fxnBUxcQD7BJbJAjz6sdf/bJiZVBzAqw8yJxzAxpNEBNJXQhXYIhGlnlqKEKC60DjwnfbiOMBJxkcKjmchZu4YBJQIJt0Z/IHk8f4exO8YLVKJbEO1FiyOGbRqcfK9kb+MsPz2xBwJF6CnGp4ax7mPQFE3AfsxAkgPAWEZMkW1TfosrmOykHKMOVmNP1cfSHiQpF9kM6PvcALYu09dIJoiZbXR0hQv3/QjEn0bxzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IR7vRC2vX6Lzfkubl7Aq+rBnaj6wlaGavvDszwm9iM=;
 b=EBi6c8GPOVq47svYlCv+oRQmUsdfDBcbJoRe3w3PP6RcozVgAbZYxtTyDIxlX8KQLmEk83fuCXCyo3MtuIaCNWatCcukGuU4mTSXjj7xzQJ34Gam7SuilL08UWMu3pD7sPHnitAMLlLd3XsuqduPvozxRAmtDC8LsaWS7DrMBqvi+ML5lCqkUrmkKVbs/6U8PU8AGUYvZg+Zou2oLoVaN95DrjVjQNtu4KRe1wR7mTebnc3g1/7ZHKUO+MnADtx+cOvFGo0WiSTs9FvHu3/0ZuytX15WalQab2cAy/jlVOxd+jWYvU4Bm2Oz4pelMM5Xe1CLOR0Rb/lIjnOsMqXfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IR7vRC2vX6Lzfkubl7Aq+rBnaj6wlaGavvDszwm9iM=;
 b=guB+d52xIcDiRvkL4QfdUGOn+5XBPYq8Qjt3MsuVj3a+7VEfsmds8MKwo9JC6rWccSAi633YphBufH8x4VcTnvrQ3LZwD95WRiJow2TfBYiTIwkS9t6V0w0MV+b7KFYVfk8DefKFp/ebG9tuxsrYbYjGG3zTEuJR+T9xYaCGBc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB1795.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.29; Wed, 5 Apr
 2023 20:21:55 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%5]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 20:21:55 +0000
Date:   Wed, 5 Apr 2023 21:21:54 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 01/13] rust: sync: introduce `LockClassKey`
Message-ID: <20230405212154.79a9fb72.gary@garyguo.net>
In-Reply-To: <20230405175111.5974-1-wedsonaf@gmail.com>
References: <20230405175111.5974-1-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0320.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB1795:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4c6304-a4d1-413e-820d-08db361366a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ejbU5kdFj+BqLB/Kg5RL8GT9p1hg1YOC5Eu4TAwiS9JUJAkgb87EJlsk421sh2/ePlknp03Xf8biaxenMHgPTm4b27I9f6ptiM5iwz9h3YQ6Pcrv53XZmaPcUmjMDforrOd5tdRBssSovyhJPjGVcSEAyok0cB82Hlh+YeWVvD+4u8rurCHyt2LbPGh2GhedsdIqOOWb0i2BHkaRXhRLOZmqhEexjmaSWyXl0PRuHYZEd8v+ZUsf201bMPjBA22N7Td86lhvz+t3Mj1jsOCl2CXCr2NmB3wb6f67ET77Q4CbD+IQ5ho20Ho7Zww4tE+BDoTe73whchcVD8jPCGsL3t/WWVwbUItTD6wlxXDp9NtzVj5C3Dyj7+wx4rfW8bEKelKZ+bzdvdMmntUhP2PDmXMGpMDFPO4tNWq3VAVGkfBPw5UesA4wXH75+6ikG4875CXOv7Hah4NDoae0or1SoJwodwahVVYxKv/BV2czgOplaW6mpOXk3asGRLeEUIFfZoMoIUly00mRkEdpVXpp7cPH8kH8osF5Nifk3ZSbi02f0lxP6IbexWot7LopW39iPbI7SG2bd2GvY1f4UvAIcZiC7TZRWTXscLQKAgG2rW4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(39830400003)(366004)(346002)(396003)(136003)(451199021)(38100700002)(36756003)(86362001)(7416002)(6486002)(5660300002)(2616005)(26005)(1076003)(2906002)(6506007)(186003)(6512007)(6916009)(66946007)(4326008)(478600001)(8676002)(66476007)(316002)(66556008)(54906003)(8936002)(45080400002)(41300700001)(83380400001)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yLsUracyb5VQrPdReImWVB/cql0Xhl6rp8UPUFSk2lbHHZmCtmRnpsXfWuoQ?=
 =?us-ascii?Q?Gk/d3IJqPx3mp0A7Eg9ddRLK0HqhxNFKMD+WRZAbQIRvy1KUn7btS/wUYV9j?=
 =?us-ascii?Q?4Qj38vqku9+h42/clzv9x++E3Pfo25Zz6do7exf32z5dNXAW6vdZaXh6KLvY?=
 =?us-ascii?Q?K7BfuqX1O1US42X9mckOYtbmc9Y421/JYFbQHgYyjgWQ9oLsuxLLfpGhxUfJ?=
 =?us-ascii?Q?fSSgSotFJnKbijI1wfAxAmPEmPvaPF3Yq7nTaj8YFuM7ivJ+AyIpn92qVZie?=
 =?us-ascii?Q?rfDP2+Bkfpl5x1SG4YRiCUqwT1sjXm6IVeoHeFwX1lPvB2rJb8EjQdI438gI?=
 =?us-ascii?Q?6yL5IwI5EjuZOHdRxuFPcvw6zp1ocvjwBERCGnLlCaowYAeD0xb0hM/GPi1G?=
 =?us-ascii?Q?c8dbvS/9RPZ+USYllfmRNaLZH887hEsU5o2qBe2vU8sXdrODgo/NrYXtX40T?=
 =?us-ascii?Q?08NPh84nIlVUMEpKpG1/2ce9m2fTop19ZeaHWBzRgpSjaO+peJEy/AGrUuJu?=
 =?us-ascii?Q?foNZmGwk8E0zmddIL5DNaf6VATkVvREKdt2jvrRAlVYSKakLbD5VQzRAlSRc?=
 =?us-ascii?Q?US5wK9LHoyh+vAmuIlUL4AXjbdP5N6fdF+ZOjbPNsxUr80B9PN5NcZGHRDzj?=
 =?us-ascii?Q?yEC/K69BTwbVPYvxF4bLPqEZ+2UQHU5sksHPet9UxJm8CHFcWP3XxlZwDF13?=
 =?us-ascii?Q?3Hs9Vc9Vdcbto/9wCwVci7N6ZoSyE4ISsOpIJArQgnrPotY+RQ/UR3m9yMd9?=
 =?us-ascii?Q?5z5v7MAbB7JCBxPepTC2yN8g9dAdo4JkLrIYXot7UShj7yNt4WXvewE7yTv0?=
 =?us-ascii?Q?aQ4F9nPbFStrG6g4UxCQxTDoMVvnSz1HCtmCvVVWkxde7DVxElioCWjNsn34?=
 =?us-ascii?Q?OZgqQrY7MoL5WxSvgUoU7KfAZBOWw2K4nTfXgvVFIO+JHExrSXHO6MHLSfMW?=
 =?us-ascii?Q?vQpmNu/2dbK2e/8ZcbUsckYzIrXnaWtlwqZRAwXM94+KlSFbqYbBXEmt/BM0?=
 =?us-ascii?Q?uWHuNSbhXKWfzOgt0ZHW4tBn8ZHMLqBbo97Mm2/kEsqtCZhAqEerWlLMZINj?=
 =?us-ascii?Q?BycCf9OsBJAz8BwFXEwB1V9527cvhfdo2GNBBimyEkXSJDQzA4wb+RxFdlu5?=
 =?us-ascii?Q?LBs7fhdHQiikgJVPZfsGwEEQPlWnBtAXw7HYmI9rHGU4IEGDKKIRUnp1QeFc?=
 =?us-ascii?Q?zJ0K55+W7Xo1edJ65eWRrjLoI6ukn3sfXhWKtuOgjb7QZYqEVvXwrGp4PB8j?=
 =?us-ascii?Q?fUpnf7IB76nJz0CkGWrdoPBJVEIpSavAl6o1pP8r0D7bBH2Pi74KiF459xpp?=
 =?us-ascii?Q?3pEB8bssHXimr96dQD1fgCld+BUsto6EKnYiXWncWMwo9KQM/vXc6AZHsd5C?=
 =?us-ascii?Q?9Od7RaR8OW4f5scmqtr7zXcvrWlQLloUQruvoqn7ytlnt5jwppYyYU6f4W8X?=
 =?us-ascii?Q?n3M6hsYjiY2O1SCn1v6tSPsXyV+x85W62ng86V8QXW9lMujHPvHrPR/UYTHb?=
 =?us-ascii?Q?CVrYJTN53C9JLgzfruFbS4qgDRUwDJCK5HGVpUbiHIYqp5h5XsSw5Z1EQKx1?=
 =?us-ascii?Q?tETc4OcVGWmmPP+a7/+0Y40Nl1rJVNveoZY3lLYh?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4c6304-a4d1-413e-820d-08db361366a4
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 20:21:55.8750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3GnXBaU62wDRjTp4i/K4HqzmTECXhTIkty2KTrui0zAqAMzVU0OtsEz4jszmdND9FdUnwbWgVBYJI6FihUsFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB1795
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Apr 2023 14:50:59 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> It is a wrapper around C's `lock_class_key`, which is used by the
> synchronisation primitives that are checked with lockdep. This is in
> preparation for introducing Rust abstractions for these primitives.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: Fixed a typo in comment
> 
>  rust/kernel/sync.rs | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 33da23e3076d..84a4b560828c 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -5,6 +5,51 @@
>  //! This module contains the kernel APIs related to synchronisation that have been ported or
>  //! wrapped for usage by Rust code in the kernel.
>  
> +use crate::types::Opaque;
> +
>  mod arc;
>  
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
> +
> +/// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
> +#[repr(transparent)]
> +pub struct LockClassKey(Opaque<bindings::lock_class_key>);
> +
> +// SAFETY: `bindings::lock_class_key` is designed to be used concurrently from multiple threads and
> +// provides its own synchronization.
> +unsafe impl Sync for LockClassKey {}
> +
> +impl LockClassKey {
> +    /// Creates a new lock class key.
> +    pub const fn new() -> Self {
> +        Self(Opaque::uninit())
> +    }
> +
> +    #[allow(dead_code)]
> +    pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
> +        self.0.get()
> +    }
> +}
> +
> +/// Defines a new static lock class and returns a pointer to it.
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! static_lock_class {
> +    () => {{
> +        static CLASS: $crate::sync::LockClassKey = $crate::sync::LockClassKey::new();
> +        &CLASS
> +    }};
> +}
> +
> +/// Returns the given string, if one is provided, otherwise generates one based on the source code
> +/// location.
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! optional_name {
> +    () => {
> +        $crate::c_str!(core::concat!(core::file!(), ":", core::line!()))

nit: prefer `::core` to `core` in macro.

> +    };
> +    ($name:literal) => {
> +        $crate::c_str!($name)
> +    };
> +}

