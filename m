Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C496CF492
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjC2Uea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjC2Ue2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:34:28 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2114.outbound.protection.outlook.com [40.107.10.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520505FC4;
        Wed, 29 Mar 2023 13:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSUqvIMT2OW1MnR0TuhYs9yW774B2K9snII9MeAYIjasgwWgNaVM46Rt4GzvINkthnrPQrFA3igN6a3dnhSUWMuPEdLnoR20AjfXt7wPupg4aV95v7LOQX54h4K7nCL6SgV5Erv/9lZIr5WXHlAoyDdWOQHUOOpKHHqN1LYdohyRAhcLsVDVScCgxSiogO44N5qeGEkD7DMdDN2xcMvbzAcN8WuZF2wkT3xFwsaB+GXamDmFjwVFED8qFCD5h7tOLUKtvXo/AnNGUk8m/XTLskTdvvTq+S1wdAHsfPbUkgzWN8z32egp7rfwR5LbybqaU924spMnZ6N4HITarWnR7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBjhxCBy9NzOtfjP6pUvHkdxuU16C/2eLKC2EcUiMPk=;
 b=CCnYrjGhWCVuRj7OsrkEAcT6MjynveoI46zNvXVvjfaCumKHPXpLDZZUIts6yGa6OlzKhsNJZ3t9rvF7Q/2Q8AdUsW1/ICX5TpI4zaQVFLxuZ15tKKM2j9UAFOzk1ZmM8eXVBqZBsICAAgMaCDGLGYFqoHLXgYmxdPNBuOtPDOUaMNrHM4lTzI3aG0nZ7XGxbl7hWCHSXOcBCPxFeULX9eHbbQTMhBFRNFH9jWVfD5RBEpmCKvs5U3kjCa0oPa+/D2cFXk4rVc5tryKfnKfadgjGHS+FNgyInC9NFO0LjvaXMWvrmqAv7jZfgA8fZbOLqCwavx28nMrsattWAITvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBjhxCBy9NzOtfjP6pUvHkdxuU16C/2eLKC2EcUiMPk=;
 b=oB20h/5ddS0pm2vSG6nnMB7zDZxg2zka8L8t1x1iUqaWDxL4/hEc3PZpq0EanHjLGH/ck/fVhIlK+EgjLJGjopmceLUONIRRoejLA4yTQIMIAVoXPuU5UGMLk9hOWVrPQpMF8AIQD4k5QhNYmwHtR7dAvFBBIQdfFTauCxhJoN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB5984.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:34:23 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 20:34:23 +0000
Date:   Wed, 29 Mar 2023 21:34:21 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH v2 2/6] rust: error: Add Error::to_ptr()
Message-ID: <20230329213421.7d132f78.gary@garyguo.net>
In-Reply-To: <20230224-rust-error-v2-2-3900319812da@asahilina.net>
References: <20230224-rust-error-v2-0-3900319812da@asahilina.net>
        <20230224-rust-error-v2-2-3900319812da@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0421.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::12) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cc1ce1-7d90-486a-131b-08db3094fb59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQzlJGQT0PI+oiyYFqJdGfFg0iMpEa7n1Rq3a1M5og8jZGpk+bPzYZatEntxOOzkc9Ac4mCy9/8J3SpqQk5WOb/G1qheh30w0Hin4djwVR1tjIeeHKkchFeRtJWxyYXoybPIXXn5iC4ZSMpO8aZdLKAXm2+oOiJhAG6qxTfRUXBlUvUOoliTQvyl/1zOSFGoVz3COlJQmHBmFraZ+8/EKcrlL5yqhJpAOlLuNu/gZhsO3A+SfytaXWGUE0ctmid+jWkrxwWL4NAePILNZaMhZoiJRsvs8IEdgrHDY2AvCrpVAG2/ET+N9Rz4NT+kzTG9fgeKlDacz3EvFUrMq+9CLvT/oVJCs/fNRElfKqj6tlnutv+1zLyJGW48IdOvNS1VWtOfUKpcnK0rdlBxnqfYRiiU8qmsE01xtlVFdjrKbS7+QMGKr74jYwWpNN4UgPIp82Q4grPsgjX5PGsVKwhZ7dpH8ggvdSa4cqfK4zM4qTyqY/5/pV0G/ek1mtq2LEucWMPwg+QDnF3dPlzRmJkBUHePK0rEbNr4kPeEB28fuFf8By6Kh3yNEmr7SKuRRm6j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39830400003)(396003)(451199021)(6486002)(478600001)(6506007)(6512007)(54906003)(186003)(4326008)(5660300002)(41300700001)(2616005)(8936002)(7416002)(2906002)(1076003)(26005)(316002)(38100700002)(66946007)(66556008)(36756003)(8676002)(66476007)(6916009)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1heTLHwggZmMnlQcoOvMSszX6JN8MvzL6UEIl+1aJGLrouTivgu1y7y+Bm6S?=
 =?us-ascii?Q?B3q8Yo5jSgc0MfRIf2iri/+n5tA1jKZtX62L3s28iaFOUwYALFzOF1cdMHbW?=
 =?us-ascii?Q?c/vFa9uno6iZyjny96TK6BUS5GFBMpeoBfbvWKAXgYptsearMasN2yUb3ogJ?=
 =?us-ascii?Q?oN9C4v7cG8YJEbT7AfLMDR+GGQ+52gbpiQFXNfMTwDHHxAyUUoKFXpUnt53N?=
 =?us-ascii?Q?wL3hutcz9ioTdAiUop7D+RddCzzIfia9+FJtVlo3BeOZpSRxvP50HbkCOU7w?=
 =?us-ascii?Q?hAqIbbdHo2LIZIjOP6Enkp7580RVP71yownYluMJ7zkZQWiCuNiC874cKe09?=
 =?us-ascii?Q?rsfjR8TpgLZV5JoBosQumvA20eeAyFAVr6C/Yzz9fWZQ85Cc+UCV796AoV2o?=
 =?us-ascii?Q?ky73EpY+AyzlhGqm9V0+/LABWK730TXFwiM/zDNrLCOOJ+CXnkwEyxhYXXxZ?=
 =?us-ascii?Q?f6VhJvmv9HA7TyeWMCLr+M1WP+Ewuq4p0+M8rshvQtmj8e603qKg/V3U1Hv5?=
 =?us-ascii?Q?vbI+WQaYWvI/4M9JG7ahJs8+HUtCIAo9DRaVOjJrM2Yb2ztnrSVKBZ6kkFrP?=
 =?us-ascii?Q?Joi/SeKnuv36hpOv4BDjBKjus6f3k1iwzXO6FiTQZ1n5I/ailYCymWkkrpaw?=
 =?us-ascii?Q?PYpr12I5Aq0tiJqext0t+rKqfs6sgA3VhxKJKAUNErO23Quc2YCsKQogdKr4?=
 =?us-ascii?Q?Vd74JsWqLlZz84Cn0QJda+bcCPihec2glkcdf4crmeqU95phLPJVYJC8c3Qr?=
 =?us-ascii?Q?K2BQIRqLrGiWDEGXGBAuIL3Gjw7O8IAWdGPF+EXhhY1A20YrRkud66EY5oi1?=
 =?us-ascii?Q?SDQM2seATiKwA0Bw6qdKLR5lhy4JCrGrFDMRJwacl+Sj6E67alquQEopTjJR?=
 =?us-ascii?Q?Y9stLdc6DoFVl+6BkQeQwIumdCYDsY2qqqVtL8ESNUR9P14GTQgwktXtpe4v?=
 =?us-ascii?Q?DUvw2DzZD342DRIWEhJEClYwdwU6ALpdhMbv6lsKsOCkQpBswIPoBEImKUDX?=
 =?us-ascii?Q?DT4BvwFW44UPNCYee/aVKcUQfZqLBWHKuh/FlYnX1d9qcxzxkTxGcWy+CfYl?=
 =?us-ascii?Q?XYfIQPLDSavIfzrf9qXB8nMUeIUHifROs2iNtBf9wJMu+EQPDF1G+zkIWySb?=
 =?us-ascii?Q?vqbCBHiHup8WfsUUx/5hIOrpfGVudGKfekI6QhygExKphF55lPnCLq4ffKED?=
 =?us-ascii?Q?QxtE58z4+E7ZdFx1/oqhWmtVuvQJfLLYWBelXbgTCi5XczDmAn/ro0tpRjiW?=
 =?us-ascii?Q?4RxCuYCuoMJGSk1rzj5rAxdKzcUZQ7NpHWYNTx1BXaRA8CsPRImjRfGEBCMt?=
 =?us-ascii?Q?+1d5ZSSP8nR7cswd/UvQkq3Ar9sGap4G2z9Mlo75RrI3gihclbx000q3eiMu?=
 =?us-ascii?Q?9qvPkDxIbF1FEeCM+nbIxBFJbKrFV/tRsUVr27VrGe7UDbpwBbWtQLwVsAZG?=
 =?us-ascii?Q?DGwbiu9+wJloVjrOTKn15gUq+qOCIZEfnts2GeoVDgfZRpUXujY6xPuuwYos?=
 =?us-ascii?Q?TPJz4J7KK5oiL7ayMjVXxe33MXTDf7H6nogDkLe2TVSfn4nEL8BNQF3c/jBm?=
 =?us-ascii?Q?5ywWUsKnK5lWlp++iNIbP05Xl9mebRz7ONbC7dkI?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cc1ce1-7d90-486a-131b-08db3094fb59
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:34:23.4550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQseP2is8zidKQMNllE5Ibrc5Wjt4JixI4GxDoLQLDFiZcDe6/jA5PK6JquQCJ/BTipPk5UUBSuqottc1TXZ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB5984
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 21:04:34 +0900
Asahi Lina <lina@asahilina.net> wrote:

> This is the Rust equivalent to ERR_PTR(), for use in C callbacks.
> Marked as #[allow(dead_code)] for now, since it does not have any
> consumers yet.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/helpers.c       | 7 +++++++
>  rust/kernel/error.rs | 7 +++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 09a4d93f9d62..89f4cd1e0df3 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -20,6 +20,7 @@
>  
>  #include <linux/bug.h>
>  #include <linux/build_bug.h>
> +#include <linux/err.h>
>  #include <linux/refcount.h>
>  
>  __noreturn void rust_helper_BUG(void)
> @@ -46,6 +47,12 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
>  
> +__force void *rust_helper_ERR_PTR(long err)
> +{
> +	return ERR_PTR(err);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_ERR_PTR);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 35894fa35efe..e97e652a1aec 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -76,6 +76,13 @@ impl Error {
>      pub fn to_errno(self) -> core::ffi::c_int {
>          self.0
>      }
> +
> +    /// Returns the error encoded as a pointer.
> +    #[allow(dead_code)]
> +    pub(crate) fn to_ptr<T>(self) -> *mut T {
> +        // SAFETY: Valid as long as self.0 is a valid error

This should be something like "SAFETY: self.0 is a valid error due to
its invariant."?

Best,
Gary

> +        unsafe { bindings::ERR_PTR(self.0.into()) as *mut _ }
> +    }
>  }
>  
>  impl From<AllocError> for Error {
> 

