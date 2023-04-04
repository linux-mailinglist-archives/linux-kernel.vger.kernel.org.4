Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE306D653B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbjDDOZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbjDDOZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:25:24 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2099.outbound.protection.outlook.com [40.107.10.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A01D3C17;
        Tue,  4 Apr 2023 07:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxg5CXjGYFNxyRUYysEcHqGIzyoUyfz9bEWVrILtFfnt2QWM43Hx35sWKuvVuEsxYuCJzNKQzblKNu7Pd+6F3arzyFdwzZoLN37RlrPEPu0tnb8EDjX8UqLfZ2mZ3gjYufiLQDvZo/ctG7Sw9fqimW9T8iN83RSp4q+4SvNUlpOfuDUJwr+DCcm70D2EK3LpBrnbZif1JU7SgsbepxXX5N4B9ComPcK+lSyHMzhp002fAQa/FEunbu3hJutn2s9LR2qCqSUEEFQGd9TNTYNv+ZH4uCcVguq1OTqQubaZvPVFORV13eBb1GNr+GeVbaw1mTuiZEP9cZ12kva7I9vI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hWE2YH/Z5mSSTYa6sP0+kfeHP7pxzrCq6BAnqhRMgc=;
 b=K+O5jZh9ux2m+W30komef4Ix2RpnJLUKEVXLFbWe36qykbhm3Mfri3JNzsDhyTI8sdc3xR1zZuUFv0JQ91L8eraDKGgKl5mH+V/Z2SJ5N8H/2JwaJiRPIA1UHwq8E4UggKbJ/V8RIkaIYa4hwIvU9drB/tUm296HdodOFK0lYTqid3Smch6aVTPU99CEdMY/dZ3UrI/hZvwhH/XUqZfpRNvyNW7E6h/GRjI/XjcnD6Fix7Lf3HC9toYmGnKhM+bbKPY1/UirLttGXLSpAHZaDzsNBVLz6LoZV3ROzXNKAxQn0BZBZpEvcF63XmTtN1c8grWrKxu7yPLIm+ebUWJQ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hWE2YH/Z5mSSTYa6sP0+kfeHP7pxzrCq6BAnqhRMgc=;
 b=J3ZNIZain3+3GJ+weMcQ6fiDdoNkOyKqNLGAfLrOnpShiJmA9tWNNv4ufJdAflWLb0jnRxsCrSppVOAcZt/4o2lx2gC5DWbS69nDtosXQSbtMuj3dd9vNWJMK5YRUrK+Tr3RrTo3lWLzHQULch1WjjOLvYpIn4+3Un/+dec1LZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5499.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 14:25:18 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%5]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 14:25:18 +0000
Date:   Tue, 4 Apr 2023 15:25:16 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Neal Gompa <neal@gompa.dev>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH v3] rust: xarray: Add an abstraction for XArray
Message-ID: <20230404152516.0368a92b.gary@garyguo.net>
In-Reply-To: <20230224-rust-xarray-v3-1-04305b1173a5@asahilina.net>
References: <20230224-rust-xarray-v3-1-04305b1173a5@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0230.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::6) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5499:EE_
X-MS-Office365-Filtering-Correlation-Id: 7841446f-3e71-487f-6f51-08db35186a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9371RJs1MNdUYtpbgStuV51E2vFcO3wUkIvZlad7fIJHssIpU7D4GJo+hiSsIUAr0bmBSsCK6b/F9uLgHHfY/BjubEuL7pGhziOazZvW/u+QiUFIrJm/WDt09GzJG0dySGZDH28M46D2LLZbdehH8UnCP9IPAzaYCVwKjHuXnQByA18bAfQKOQdWToOk/xbdiQ2keNdgAmk4gYivAsTh8LV5l+7QWC6u5EZji6jCkF+E+QpT58ty/0nEQVZKlZ5q1fxAX4z/48gomB25bPJgkM+KW12oPbINIAknv77xkrSQTyYN693d9WPMzTuxb2J8dByjMdydzMfiI/+L0b7CK6jIC5KC9ybqiuUu/OQJO8yM4ZBW+Re50wo3T8a48xP6A7q/uMGghRyJWcQNAcChSgRfvhyOs0wsJEpWOik1cMUXm+kXv1fg9Htv0Icfpj02KvCzTLFHNuTZqFvTdtJgQiPk5yJxWNRl3Qv8HxqnCnjvpt+xa+xB7CkrszRTo6xfnQaFvnFF2epNE7ztY0jPjDCRUWeYfd2eVCBYagJeC4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(136003)(39830400003)(396003)(451199021)(478600001)(4326008)(8676002)(66946007)(66556008)(66476007)(41300700001)(316002)(54906003)(30864003)(8936002)(5660300002)(7416002)(38100700002)(6916009)(186003)(83380400001)(2616005)(966005)(6486002)(26005)(6506007)(1076003)(6512007)(86362001)(36756003)(2906002)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3qP37CiDTImCZIagG47Dt1pfX5Cu1WrfO+jbG8syJ0Qf0JCUbd0LJI5h+YXC?=
 =?us-ascii?Q?JcrTOb+EdZSs6aUWDs8SgoxLPSu3Ke+4oUH//PIVbmJjKRz+DScDzyovy2uy?=
 =?us-ascii?Q?3jjwjpBSqfi+OvfE1bYDmegLUxqgMQp2lIIa/cMoGXuisfpw4zaLnQNEqUlE?=
 =?us-ascii?Q?C6WEzqFoL+ME+fr481e2ME2/2Pk4TsCAplplDePEms5QoymENFHuBHwD/9CC?=
 =?us-ascii?Q?0FdKws5VO2qcRTFKmzmc0Xosn/7zuNEpeRDKJmWAGOrjqbhdDVp1wcUbTELk?=
 =?us-ascii?Q?m8ITBZGRpGje6Vj2HOZESGuNnAbKF+YTLoyrUnjybtB5QpbyY7N3QExhDmEi?=
 =?us-ascii?Q?zh4X/uoFGuMPBriCRrwKU6Fms+SLqLZZHv2l/LIvZAACUnIWKkX0+0tmPKv7?=
 =?us-ascii?Q?avaAUksznyQI4Lif510kKaBbpClSI/M9/v8NY4T7sucUkPYCM1GnuvKtSxLJ?=
 =?us-ascii?Q?xZ9p6dUuIwGpsMZk5tjHdn3xcPgRRhlhhRHccyq2ZYUBjKPDD90vHjB51Iqq?=
 =?us-ascii?Q?8pQT+teXVxn58bksdMKRNOzbttvj280Gm20Fu0yzHOXzqAOHGukj9rAr/mzd?=
 =?us-ascii?Q?FTmV7fN4Wew0NpjCgT5jj1qPhiYxg1jHfGTlarR9tuSLWjQbx7FHqte/8kDz?=
 =?us-ascii?Q?wnoOmrlyuQuNHLa52OmdR3uBSeUer+Qxn1qeN3XEowQmfTp8UX9SQi5L6rku?=
 =?us-ascii?Q?PrpSDkLLwSzIowhNt944zcbvhY7Y8wKyN7oO0sdATE0UIgKUITyZttRj08tb?=
 =?us-ascii?Q?5wzJgR7vAIXOyskh6kxcgHYIYg8GrYYPv4cgor4dCaa0GTUhZvFnKhmESQEF?=
 =?us-ascii?Q?TXHyn2Q5i2fGOda/Zfckpw7Xdv4ihnJtmWWwqJH4y5kD9Sow+EoPnXTHnj5T?=
 =?us-ascii?Q?1ay8u3c6g6gToubfMHqDkSxilX3LzpAtYDhXO1M0vkcvnlaMl7suS+vTiZfA?=
 =?us-ascii?Q?dpWOZDL9q6N7xu+eu2pFnAwlFO/X0j7aMZwybpGWiLFUKM8cLlyBVveV9VJf?=
 =?us-ascii?Q?QIYl5kJs1XDixBi5VYEi/9lUAapy6KGV2/NZBFKnOsZdN5AsoYy4OQ4CkWjj?=
 =?us-ascii?Q?iY2H0l99CjAPAzV0YG5Pkr5dWzlqeRXuO7PkCmtSvHtlV7ZQ2x+V1dVhvbAM?=
 =?us-ascii?Q?LgqpRqVtLWLFHh6I0e3q7VgDzejaInN5L2pB+CiFWGSGCbLv5ivpEACiKZcO?=
 =?us-ascii?Q?cWaxA/seLMxy1hf0o533I5rCnn0SyRMGpUpdRsCvhePj4mP4HQkriA3sfptf?=
 =?us-ascii?Q?loDXdMgq6akPqAXPvvVWT0fT+65QH81gC22GDl3k84WB3hL9xrDb52e7Gpfx?=
 =?us-ascii?Q?OqE1kg042ZQJTBi7YpEXQf0lxRs/N/NobYcz8RVarImCfaE/aMxlu6M3A5vl?=
 =?us-ascii?Q?oAprTgHB7Vogfr2+dD1E7E3cpWBzfC3yxkimMjiPxfJEOUr1KJjZ0OKS3W5c?=
 =?us-ascii?Q?nUPOsi/EQEdQZ+g287o3YrAaMeo2YpwiFpaRGHBPcMsL6nQlG5M+CdwgwdKX?=
 =?us-ascii?Q?/a8FVu5SuHWR2akZB3/cqiL/QUynMNofDFDL6qm5NACwzbSyVw8iWxd1xgae?=
 =?us-ascii?Q?Cw6ozBeZYFaqwNlYdrMb1dCgwIm9WXQbcH8j0Y94?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7841446f-3e71-487f-6f51-08db35186a22
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 14:25:18.0794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWZskYPzsutkKntuKXSpWaKPqc0+9raIbKOAaaSUqD+lM8ONgFTl7qoeW6579BmPKS/J78U/HvPiOhfkHvmbqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5499
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 19:14:23 +0900
Asahi Lina <lina@asahilina.net> wrote:

> The XArray is an abstract data type which behaves like a very large
> array of pointers. Add a Rust abstraction for this data type.
> 
> The initial implementation uses explicit locking on get operations and
> returns a guard which blocks mutation, ensuring that the referenced
> object remains alive. To avoid excessive serialization, users are
> expected to use an inner type that can be efficiently cloned (such as
> Arc<T>), and eagerly clone and drop the guard to unblock other users
> after a lookup.
> 
> Future variants may support using RCU instead to avoid mutex locking.
> 
> This abstraction also introduces a reservation mechanism, which can be
> used by alloc-capable XArrays to reserve a free slot without immediately
> filling it, and then do so at a later time. If the reservation is
> dropped without being filled, the slot is freed again for other users,
> which eliminates the need for explicit cleanup code.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
> 
> Hi everyone!
> 
> This abstraction is part of the set of dependencies for the drm/asahi
> Apple M1/M2 GPU driver.
> 
> The branch at [1] contains the full series of patches rebased on
> upstream leading to the complete driver, for reference on how it is
> intended to be used.
> 
> Thank you everyone who helped review this on GitHub [2]! I hope I didn't
> forget any CCs...
> 
> Note that I dropped the convenience `Deref` impl for `Guard`, since I
> couldn't figure out how to do it safely. Suggestions welcome, or we can
> leave it for a future improvement ^^
> 
> [1] https://github.com/AsahiLinux/linux/tree/gpu/rebase-20230224
> [2] https://github.com/Rust-for-Linux/linux/pull/952
> 
> Changes in v3:
> - Updated to the error v2/v3 series API.
> - Renamed `err` to `ret` for consistency with the other instance.
> - Link to v2: https://lore.kernel.org/r/20230224-rust-xarray-v2-1-4eeb0134944c@asahilina.net
> Changes in v2:
> - Added Pin requirement for all XArray operations, to close a
>   soundness hole due to the lock in the XArray (locks are not safe to
>   move while locked). Creation does not require pinning in place, since
>   the lock cannot be acquired at that point.
> - Added safety note to Drop impl about why we don't need to do the lock
>   unlock dance to ensure soundness in case of a dropped lock guard.
> - Downstream drm/asahi driver was also rebased on this version to prove
>   it works (previously it was still on a pre-v1 version).
> - This still depends on the Error series (v1). v2 of that will need a
>   trivial rename of Error::from_kernel_errno -> Error::from_errno. If
>   this version of XArray ends up looking good, I'll send a trivial v4 of
>   XArray with the rename, after sending the v2 of the Error series.
> - Link to v1: https://lore.kernel.org/r/20230224-rust-xarray-v1-1-80f0904ce5d3@asahilina.net
> ---
>  rust/bindings/bindings_helper.h |  17 +++
>  rust/helpers.c                  |  37 +++++
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/xarray.rs           | 302 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 357 insertions(+)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 75d85bd6c592..bd364f9e25fe 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -8,7 +8,24 @@
>  
>  #include <linux/slab.h>
>  #include <linux/refcount.h>
> +#include <linux/xarray.h>
>  
>  /* `bindgen` gets confused at certain things. */
>  const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
>  const gfp_t BINDINGS___GFP_ZERO = __GFP_ZERO;
> +
> +const gfp_t BINDINGS_XA_FLAGS_LOCK_IRQ = XA_FLAGS_LOCK_IRQ;
> +const gfp_t BINDINGS_XA_FLAGS_LOCK_BH = XA_FLAGS_LOCK_BH;
> +const gfp_t BINDINGS_XA_FLAGS_TRACK_FREE = XA_FLAGS_TRACK_FREE;
> +const gfp_t BINDINGS_XA_FLAGS_ZERO_BUSY = XA_FLAGS_ZERO_BUSY;
> +const gfp_t BINDINGS_XA_FLAGS_ALLOC_WRAPPED = XA_FLAGS_ALLOC_WRAPPED;
> +const gfp_t BINDINGS_XA_FLAGS_ACCOUNT = XA_FLAGS_ACCOUNT;
> +const gfp_t BINDINGS_XA_FLAGS_ALLOC = XA_FLAGS_ALLOC;
> +const gfp_t BINDINGS_XA_FLAGS_ALLOC1 = XA_FLAGS_ALLOC1;
> +
> +const xa_mark_t BINDINGS_XA_MARK_0 = XA_MARK_0;
> +const xa_mark_t BINDINGS_XA_MARK_1 = XA_MARK_1;
> +const xa_mark_t BINDINGS_XA_MARK_2 = XA_MARK_2;
> +const xa_mark_t BINDINGS_XA_PRESENT = XA_PRESENT;
> +const xa_mark_t BINDINGS_XA_MARK_MAX = XA_MARK_MAX;
> +const xa_mark_t BINDINGS_XA_FREE_MARK = XA_FREE_MARK;
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 04b9be46e887..21a8e086472f 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -22,6 +22,7 @@
>  #include <linux/build_bug.h>
>  #include <linux/err.h>
>  #include <linux/refcount.h>
> +#include <linux/xarray.h>
>  
>  __noreturn void rust_helper_BUG(void)
>  {
> @@ -65,6 +66,42 @@ long rust_helper_PTR_ERR(__force const void *ptr)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_PTR_ERR);
>  
> +void rust_helper_xa_init_flags(struct xarray *xa, gfp_t flags)
> +{
> +	xa_init_flags(xa, flags);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_xa_init_flags);
> +
> +bool rust_helper_xa_empty(struct xarray *xa)
> +{
> +	return xa_empty(xa);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_xa_empty);
> +
> +int rust_helper_xa_alloc(struct xarray *xa, u32 *id, void *entry, struct xa_limit limit, gfp_t gfp)
> +{
> +	return xa_alloc(xa, id, entry, limit, gfp);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_xa_alloc);
> +
> +void rust_helper_xa_lock(struct xarray *xa)
> +{
> +	xa_lock(xa);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_xa_lock);
> +
> +void rust_helper_xa_unlock(struct xarray *xa)
> +{
> +	xa_unlock(xa);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_xa_unlock);
> +
> +int rust_helper_xa_err(void *entry)
> +{
> +	return xa_err(entry);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_xa_err);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 223564f9f0cc..3eb0a18acd55 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -38,6 +38,7 @@ pub mod std_vendor;
>  pub mod str;
>  pub mod sync;
>  pub mod types;
> +pub mod xarray;
>  
>  #[doc(hidden)]
>  pub use bindings;
> diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> new file mode 100644
> index 000000000000..365a3288a787
> --- /dev/null
> +++ b/rust/kernel/xarray.rs
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! XArray abstraction.
> +//!
> +//! C header: [`include/linux/xarray.h`](../../include/linux/xarray.h)
> +
> +use crate::{
> +    bindings,
> +    error::{Error, Result},
> +    types::{ForeignOwnable, Opaque, ScopeGuard},
> +};
> +use core::{
> +    marker::{PhantomData, PhantomPinned},
> +    pin::Pin,
> +    ptr::NonNull,
> +};
> +
> +/// Flags passed to `XArray::new` to configure the `XArray`.
> +type Flags = bindings::gfp_t;
> +
> +/// Flag values passed to `XArray::new` to configure the `XArray`.
> +pub mod flags {
> +    /// Use IRQ-safe locking.
> +    pub const LOCK_IRQ: super::Flags = bindings::BINDINGS_XA_FLAGS_LOCK_IRQ;
> +    /// Use softirq-safe locking.
> +    pub const LOCK_BH: super::Flags = bindings::BINDINGS_XA_FLAGS_LOCK_BH;
> +    /// Track which entries are free (distinct from None).
> +    pub const TRACK_FREE: super::Flags = bindings::BINDINGS_XA_FLAGS_TRACK_FREE;
> +    /// Initialize array index 0 as busy.
> +    pub const ZERO_BUSY: super::Flags = bindings::BINDINGS_XA_FLAGS_ZERO_BUSY;
> +    /// Use GFP_ACCOUNT for internal memory allocations.
> +    pub const ACCOUNT: super::Flags = bindings::BINDINGS_XA_FLAGS_ACCOUNT;
> +    /// Create an allocating `XArray` starting at index 0.
> +    pub const ALLOC: super::Flags = bindings::BINDINGS_XA_FLAGS_ALLOC;
> +    /// Create an allocating `XArray` starting at index 1.
> +    pub const ALLOC1: super::Flags = bindings::BINDINGS_XA_FLAGS_ALLOC1;
> +}
> +
> +/// Wrapper for a value owned by the `XArray` which holds the `XArray` lock until dropped.
> +pub struct Guard<'a, T: ForeignOwnable>(NonNull<T>, Pin<&'a XArray<T>>);
> +
> +impl<'a, T: ForeignOwnable> Guard<'a, T> {
> +    /// Borrow the underlying value wrapped by the `Guard`.
> +    ///
> +    /// Returns a `T::Borrowed` type for the owned `ForeignOwnable` type.
> +    pub fn borrow(&self) -> T::Borrowed<'_> {
> +        // SAFETY: The value is owned by the `XArray`, the lifetime it is borrowed for must not
> +        // outlive the `XArray` itself, nor the Guard that holds the lock ensuring the value
> +        // remains in the `XArray`.
> +        unsafe { T::borrow(self.0.as_ptr() as _) }
> +    }
> +}
> +
> +impl<'a, T: ForeignOwnable> Drop for Guard<'a, T> {
> +    fn drop(&mut self) {
> +        // SAFETY: The XArray we have a reference to owns the C xarray object.
> +        unsafe { bindings::xa_unlock(self.1.xa.get()) };
> +    }
> +}
> +
> +/// Represents a reserved slot in an `XArray`, which does not yet have a value but has an assigned
> +/// index and may not be allocated by any other user. If the Reservation is dropped without
> +/// being filled, the entry is marked as available again.
> +///
> +/// Users must ensure that reserved slots are not filled by other mechanisms, or otherwise their
> +/// contents may be dropped and replaced (which will print a warning).
> +pub struct Reservation<'a, T: ForeignOwnable>(Pin<&'a XArray<T>>, usize, PhantomData<T>);
> +
> +impl<'a, T: ForeignOwnable> Reservation<'a, T> {
> +    /// Stores a value into the reserved slot.
> +    pub fn store(self, value: T) -> Result<usize> {
> +        if self.0.replace(self.1, value)?.is_some() {
> +            crate::pr_err!("XArray: Reservation stored but the entry already had data!\n");
> +            // Consider it a success anyway, not much we can do
> +        }
> +        let index = self.1;
> +        // The reservation is now fulfilled, so do not run our destructor.
> +        core::mem::forget(self);
> +        Ok(index)
> +    }
> +
> +    /// Returns the index of this reservation.
> +    pub fn index(&self) -> usize {
> +        self.1
> +    }
> +}
> +
> +impl<'a, T: ForeignOwnable> Drop for Reservation<'a, T> {
> +    fn drop(&mut self) {
> +        if self.0.remove(self.1).is_some() {
> +            crate::pr_err!("XArray: Reservation dropped but the entry was not empty!\n");
> +        }
> +    }
> +}
> +
> +/// An array which efficiently maps sparse integer indices to owned objects.
> +///
> +/// This is similar to a `Vec<Option<T>>`, but more efficient when there are holes in the
> +/// index space, and can be efficiently grown.
> +///
> +/// This structure is expected to often be used with an inner type that can either be efficiently
> +/// cloned, such as an `Arc<T>`.
> +pub struct XArray<T: ForeignOwnable> {
> +    xa: Opaque<bindings::xarray>,
> +    _p: PhantomData<T>,
> +    _q: PhantomPinned,
> +}
> +
> +impl<T: ForeignOwnable> XArray<T> {
> +    /// Creates a new `XArray` with the given flags.
> +    pub fn new(flags: Flags) -> XArray<T> {
> +        let xa = Opaque::uninit();
> +
> +        // SAFETY: We have just created `xa`. This data structure does not require
> +        // pinning.
> +        unsafe { bindings::xa_init_flags(xa.get(), flags) };
> +
> +        // INVARIANT: Initialize the `XArray` with a valid `xa`.
> +        XArray {
> +            xa,
> +            _p: PhantomData,
> +            _q: PhantomPinned,
> +        }
> +    }
> +
> +    /// Replaces an entry with a new value, returning the old value (if any).
> +    pub fn replace(self: Pin<&Self>, index: usize, value: T) -> Result<Option<T>> {
> +        let new = value.into_foreign();
> +        // SAFETY: `new` just came from into_foreign(), and we dismiss this guard if
> +        // the xa_store operation succeeds and takes ownership of the pointer.
> +        let guard = ScopeGuard::new(|| unsafe {
> +            T::from_foreign(new);
> +        });
> +
> +        // SAFETY: `self.xa` is always valid by the type invariant, and we are storing
> +        // a `T::into_foreign()` result which upholds the later invariants.
> +        let old = unsafe {
> +            bindings::xa_store(
> +                self.xa.get(),
> +                index.try_into()?,
> +                new as *mut _,
> +                bindings::GFP_KERNEL,
> +            )
> +        };

XArray's doc says the pointer must be 4-byte aligned, but I didn't see
any checks.

> +
> +        let ret = unsafe { bindings::xa_err(old) };
> +        if ret != 0 {
> +            Err(Error::from_errno(ret))
> +        } else if old.is_null() {
> +            guard.dismiss();
> +            Ok(None)
> +        } else {
> +            guard.dismiss();
> +            // SAFETY: The old value must have been stored by either this function or
> +            // `alloc_limits_opt`, both of which ensure non-NULL entries are valid
> +            // ForeignOwnable pointers.
> +            Ok(Some(unsafe { T::from_foreign(old) }))
> +        }
> +    }
> +
> +    /// Replaces an entry with a new value, dropping the old value (if any).
> +    pub fn set(self: Pin<&Self>, index: usize, value: T) -> Result {
> +        self.replace(index, value)?;
> +        Ok(())
> +    }
> +
> +    /// Looks up and returns a reference to an entry in the array, returning a `Guard` if it
> +    /// exists.
> +    ///
> +    /// This guard blocks all other actions on the `XArray`. Callers are expected to drop the
> +    /// `Guard` eagerly to avoid blocking other users, such as by taking a clone of the value.
> +    pub fn get(self: Pin<&Self>, index: usize) -> Option<Guard<'_, T>> {
> +        // SAFETY: `self.xa` is always valid by the type invariant.
> +        unsafe { bindings::xa_lock(self.xa.get()) };
> +
> +        // SAFETY: `self.xa` is always valid by the type invariant.
> +        let guard = ScopeGuard::new(|| unsafe { bindings::xa_unlock(self.xa.get()) });
> +
> +        // SAFETY: `self.xa` is always valid by the type invariant.
> +        let p = unsafe { bindings::xa_load(self.xa.get(), index.try_into().ok()?) };
> +
> +        NonNull::new(p as *mut T).map(|p| {
> +            guard.dismiss();
> +            Guard(p, self)
> +        })
> +    }
> +
> +    /// Removes and returns an entry, returning it if it existed.
> +    pub fn remove(self: Pin<&Self>, index: usize) -> Option<T> {
> +        let p = unsafe { bindings::xa_erase(self.xa.get(), index.try_into().ok()?) };
> +        if p.is_null() {
> +            None
> +        } else {
> +            Some(unsafe { T::from_foreign(p) })
> +        }
> +    }
> +
> +    /// Allocates a new index in the array, optionally storing a new value into it, with
> +    /// configurable bounds for the index range to allocate from.
> +    ///
> +    /// If `value` is `None`, then the index is reserved from further allocation but remains
> +    /// free for storing a value into it.
> +    fn alloc_limits_opt(self: Pin<&Self>, value: Option<T>, min: u32, max: u32) -> Result<usize> {
> +        let new = value.map_or(core::ptr::null(), |a| a.into_foreign());
> +        let mut id: u32 = 0;
> +
> +        // SAFETY: `self.xa` is always valid by the type invariant. If this succeeds, it
> +        // takes ownership of the passed `T` (if any). If it fails, we must drop the
> +        // `T` again.
> +        let ret = unsafe {
> +            bindings::xa_alloc(
> +                self.xa.get(),
> +                &mut id,
> +                new as *mut _,
> +                bindings::xa_limit { min, max },
> +                bindings::GFP_KERNEL,
> +            )
> +        };
> +
> +        if ret < 0 {
> +            // Make sure to drop the value we failed to store
> +            if !new.is_null() {
> +                // SAFETY: If `new` is not NULL, it came from the `ForeignOwnable` we got
> +                // from the caller.
> +                unsafe { T::from_foreign(new) };
> +            }
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(id as usize)
> +        }
> +    }
> +
> +    /// Allocates a new index in the array, storing a new value into it, with configurable
> +    /// bounds for the index range to allocate from.
> +    pub fn alloc_limits(self: Pin<&Self>, value: T, min: u32, max: u32) -> Result<usize> {
> +        self.alloc_limits_opt(Some(value), min, max)
> +    }
> +
> +    /// Allocates a new index in the array, storing a new value into it.
> +    pub fn alloc(self: Pin<&Self>, value: T) -> Result<usize> {
> +        self.alloc_limits(value, 0, u32::MAX)
> +    }
> +
> +    /// Reserves a new index in the array within configurable bounds for the index.
> +    ///
> +    /// Returns a `Reservation` object, which can then be used to store a value at this index or
> +    /// otherwise free it for reuse.
> +    pub fn reserve_limits(self: Pin<&Self>, min: u32, max: u32) -> Result<Reservation<'_, T>> {
> +        Ok(Reservation(
> +            self,
> +            self.alloc_limits_opt(None, min, max)?,
> +            PhantomData,
> +        ))
> +    }
> +
> +    /// Reserves a new index in the array.
> +    ///
> +    /// Returns a `Reservation` object, which can then be used to store a value at this index or
> +    /// otherwise free it for reuse.
> +    pub fn reserve(self: Pin<&Self>) -> Result<Reservation<'_, T>> {
> +        Ok(Reservation(
> +            self,
> +            self.alloc_limits_opt(None, 0, u32::MAX)?,
> +            PhantomData,
> +        ))
> +    }
> +}
> +
> +impl<T: ForeignOwnable> Drop for XArray<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.xa` is valid by the type invariant, and as we have the only reference to
> +        // the `XArray` we can safely iterate its contents and drop everything.
> +        unsafe {
> +            let mut index: core::ffi::c_ulong = 0;
> +            let mut entry = bindings::xa_find(
> +                self.xa.get(),
> +                &mut index,
> +                core::ffi::c_ulong::MAX,
> +                bindings::BINDINGS_XA_PRESENT,
> +            );
> +            while !entry.is_null() {
> +                T::from_foreign(entry);
> +                entry = bindings::xa_find_after(
> +                    self.xa.get(),
> +                    &mut index,
> +                    core::ffi::c_ulong::MAX,
> +                    bindings::BINDINGS_XA_PRESENT,
> +                );
> +            }
> +
> +            // Locked locks are not safe to drop. Normally we would want to try_lock()/unlock() here
> +            // for safety or something similar, but in this case xa_destroy() is guaranteed to
> +            // acquire the lock anyway. This will deadlock if a lock guard was improperly dropped,
> +            // but that is not UB, so it's sufficient for soundness purposes.
> +            bindings::xa_destroy(self.xa.get());
> +        }
> +    }
> +}
> +
> +// SAFETY: XArray is thread-safe and all mutation operations are internally locked.
> +unsafe impl<T: Send + ForeignOwnable> Send for XArray<T> {}
> +unsafe impl<T: Sync + ForeignOwnable> Sync for XArray<T> {}
> 
> ---
> base-commit: 34abc9dde6a9083d2dc0a7791f5100d2eeb95bb3
> change-id: 20230224-rust-xarray-f503f9e5455e
> 
> Thank you,
> ~~ Lina
> 

