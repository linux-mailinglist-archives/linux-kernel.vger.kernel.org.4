Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36D56B7FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjCMRwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCMRwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:52:39 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2090.outbound.protection.outlook.com [40.107.11.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EB479B30;
        Mon, 13 Mar 2023 10:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1FckNuPpBTQPVS+xxs9MadsqL9BWUqQC0efdUj3s8pfXuxzWyr3rzFCXA1u1q9BWbJ3fnDGVGpTrssSHn7o9G0M4WjNQ+8t+9/wg5S0Fnqeootq9P4QarQydjNiDggbJ/FryAHkir7f5omG1LmqvF5WuKLUh1wHs3G2uOg54iU8RbCfcaZCa3OZrvECFQIgS7Y9XNiJ0u3cBTL/y2prGuh3j8W+XDeH2PbZ8+N9ZYbUS3bzgyfUtEPQ2uDhSCxJ7xq9TLmG0GhbUX73wmTBfQOOYzPXg1Xsdkma/977rYpTOP8VEk9u4yprJVIDnT5A4+kzHFz1mPxvg75dAV687Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+24+30jX1Y1+A4rGZPmWbeb0UxP4fsoqj2vGiJvQZg=;
 b=Zj0D6Oya6S/N8mDCFC8EQiXRNL/1h1y+HHNsKGJJnmTpRerDeQGFLyIXStg9m0Exm2TAC3toOOdUFF9yW1ZMmEw/lkM23/pjmJZEPQNR0U3PCeM6XNWKhPNafn5pSKE0auxkl2RxRdxiRYOhzAC9kk1h3x/XyfubE1VSqyOu18qx2CAqgnCn47MAyTAkI0kxsLXVflIPlcU4MbQ1NB3nRvVKB8b+YWgy2sxT6OhH9Den/YqKenSdHgIStouDuNoh7iJ2NnQvmwemcPuasn/1SgtZjKSwKeVXDLiR91JXl6IC2l5FSXiLbg/weS+gnRKdqUDYwy62ZHOqEKQ47YesnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+24+30jX1Y1+A4rGZPmWbeb0UxP4fsoqj2vGiJvQZg=;
 b=EoRZvU+hYpChJcMNHqoZt/PNAXsZ+0T2EI2ndUM9WDu9yKXGrU35MtUCtpDbGLCH3MeU640V3OS2OCy1p770mFb4yBXLlNHNRguPt3A9Rx34IlL0cRhz778lFtvIMpjHLzh1MuzXc9Y7vqDedluSSt42cwwchch+K7ITAQ3p9hE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB1765.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:37::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 17:52:04 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%3]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 17:52:04 +0000
Date:   Mon, 13 Mar 2023 17:52:02 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH 5/5] rust: device: Add a stub abstraction for devices
Message-ID: <20230313175202.300bb1f4.gary@garyguo.net>
In-Reply-To: <20230224-rust-iopt-rtkit-v1-5-49ced3391295@asahilina.net>
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
        <20230224-rust-iopt-rtkit-v1-5-49ced3391295@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0274.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::9) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB1765:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc8fc8f-e05b-4064-f376-08db23eba7f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UuBy/CJCG8/wGcFF8s1lz09sdPoDEyggAGwEV4u1lgTpYDjQ68quUCsZ0XPGYfH0tJLij7FDE2nKn55ndklZ0GGJWmZmHbu/Lb9bCEA2iB4lGZTFlA6xn+yC4/KTBPvMLyjcnVHmg4Weog4ZYNT1Naz8WysLEZBPDcBPCD3JaVa1zhQuR5Olkqfl7WPDZOJk74akO9nShTayESd26XFMiwW3KNlIqkM5nzgf9Gz8B69NZrtw1itDg2Ug3GmrZlUZ+fyH52SPC3Pbj2Dj+sxDeSZXQL+OdAsh4oSpk0k8rGaw3AYRRNgqKyjPVWl9G44Oo8Qnd1ikMYRJJagv8GLzLOYsXvvPw/2iavMQjLzGLf1kCAicCYbDDzQxD2jLGqk44/NqW4G9STD2Vk2Qibd6nxyhs3liEVWIOeWP3JfkUXOs1npmxzatywPXVz+RsV6b0hdxU9l8nouT1An8VfFLIgNcwEJwTZBWcZa79l7tHzV2lT8eu1/eEN9ZbASGR+gKKvUTVk+4+3dIYBn2dh2OOk+yq9FKMBigbbygYeC1TC64+CNm0TBhYkWigcKDezHZHIxcyz1sFu7LCIKJE/ul4PWPFVSVZx4WQ4M5iFoaTjzVWyDzA8eTiY+tClZYJ0QW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(376002)(396003)(136003)(39830400003)(451199018)(5660300002)(7416002)(38100700002)(36756003)(86362001)(2906002)(2616005)(26005)(6512007)(186003)(1076003)(6506007)(478600001)(6486002)(66946007)(316002)(41300700001)(54906003)(66476007)(83380400001)(66556008)(6916009)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TTCGIreqo/hdI/YuhFdOQFc/ISu3vyETPQTF/c4FvsXBVKMUXuXKoZu4MFg6?=
 =?us-ascii?Q?uxnFUrzX+W1zWgbB1/iyF9pGCHrYZzJn1OkSDLqslclCHQ8spV++LMSkzsli?=
 =?us-ascii?Q?7ydMWSOUZH1Uml7X8T3dJcvFQmh0b5efK3kncviLybjSdJ4HyADbHvGvdiye?=
 =?us-ascii?Q?EM2kLpKOgUEFnD8n207wKRKHNfyTjgRMa34R3NATtMPm6FNW7eSD8w7GdUBb?=
 =?us-ascii?Q?XFfIAKfbk5x80+2/M5c5pRtlbUufySFx7wwjs7BKTJ6xz1I8thHV1oSE1ZQZ?=
 =?us-ascii?Q?6jElIFu4qxfCMFJxCVW+Rziw8uARE2vBarPlr9L5NF9cjT85QY+zGrks11i3?=
 =?us-ascii?Q?APmvKMEyQvJw3H/SPrez7JJ+o0M4i0c2WdKPBsx2YNnMMVLiAjQjfom+H+pF?=
 =?us-ascii?Q?KL6thRgLeyYaEnVhABxZvfssNlm4QMkc33V7E6ERlcF20xinmlZySRNL9UcX?=
 =?us-ascii?Q?5kBBsFULheOK2SLx3PP1O+eYce3fuBpPcMiofKYLmVT/2oT0V89jLHLnMGW6?=
 =?us-ascii?Q?dWJ4ylb8+6PIqx2K8coBVMvoMqhDwVLaOhFJJlSCH4theTZnm6ukIKFYpbBg?=
 =?us-ascii?Q?NHbeRh24J1zZ0Jmm1Lj30H6/PVfFIcNf0wW9GFdOzCUPHeCY4cIZjvbSNuBa?=
 =?us-ascii?Q?kicPLiUAIQi9FFrn3lv9rIGLNGi4vuie9GvqM/EiEsnc58tVBM3RHb4zXXLd?=
 =?us-ascii?Q?HUTMkqlnl1f84k7vQPG/hCU++NBqckvaXXD1M7ZUq/Vgdg1kyKJ00HQQfiWa?=
 =?us-ascii?Q?SuZwSnnF1iVVK+E2F3xwT3gJRmEHJTsVFkVD9MmkZ+rcR8adhvWaxK5Bcmw2?=
 =?us-ascii?Q?B/9GzFwFTbBPXmh2USCtgG1RoGNQ/tQ7UMBoj7/WrbEJWg4iopWzl5P8Jp3C?=
 =?us-ascii?Q?g5ZkZUBfxG+gOeCbCYRK61wCCRSOZ8TSRZq7yujGmOctJvV6gNFRCHZtuqMx?=
 =?us-ascii?Q?R247YYGcFBNg91Gpj6mCe1dk+Dcx1mYn/f4ydBbxxicCTHCM5hDqtkU7i513?=
 =?us-ascii?Q?kWyTKSyHjxkGqNGjfatYgj2Pm2H/2mBlpOWdrQtPEq57ta/gMpnayAe7jQsU?=
 =?us-ascii?Q?mnPRLF7SjrG5HL3Y/ccD9l1bKyIrepeJbuJ3cKglOnTaCmiycrwhTYu7foZF?=
 =?us-ascii?Q?GpwHf9vOM0heLMq97aSS3m254PyUmNfY639LxX8wlP9T1bfRtZNJ2GhGkKh7?=
 =?us-ascii?Q?L0FtxFTXsQsbOmgS/Sez9M5fjF4HCz3cBaRqJ874vUc7Jt22P6q5+lbUJp8k?=
 =?us-ascii?Q?398i9fY4QfpeVZUEIASS+seyJtsDOmMqmFx0Rth6Xomo7VMGvUJA2Pt52dv/?=
 =?us-ascii?Q?A9EgRnPBwijn4F2J5575QXOShVTaBJesyWwU4xmoU5+UDOZWDdw7jnunRDS1?=
 =?us-ascii?Q?jFmC4AEv9OzFTs2777JAGBEH+5QXCjtxCJpZNcECDL/1ndV2lyNDqeuA3OWY?=
 =?us-ascii?Q?9rNSM+bO0ZdH5auUG2TBts4cXUkxJHVfOHvupbhA1U0grMlo7lO9HeXz59yW?=
 =?us-ascii?Q?fWm0RcLOUJGopqZc3Ax8tFC8w+QHgcfWGoAjiAb58FSovZenPZi8kEUUMtAG?=
 =?us-ascii?Q?3F2yXLExtlHEbeXg4uJxxqfEUW0EYep0jiVTzNpr?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc8fc8f-e05b-4064-f376-08db23eba7f8
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 17:52:04.6860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8XxvIYZZ6vlw3xCR2SvSfkDJhMVRo1X0CDJ8KVfAPFc4b9LxVuiYKNJZ9WRoCvS8Iwl+QSAu7CRKdvE3mDLWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1765
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 19:53:17 +0900
Asahi Lina <lina@asahilina.net> wrote:

> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Add a Device type which represents an owned reference to a generic
> struct device. This minimal implementation just handles reference
> counting and allows the user to get the device name.
> 
> Lina: Rewrote commit message, dropped the Amba bits, and squashed in
> simple changes to the core Device code from latter commits in
> rust-for-linux/rust. Also include the rust_helper_dev_get_drvdata
> helper which will be needed by consumers later on anyway.
> 
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/helpers.c        | 13 +++++++++
>  rust/kernel/device.rs | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 04b9be46e887..54954fd80c77 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -20,6 +20,7 @@
>  
>  #include <linux/bug.h>
>  #include <linux/build_bug.h>
> +#include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/refcount.h>
>  
> @@ -65,6 +66,18 @@ long rust_helper_PTR_ERR(__force const void *ptr)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_PTR_ERR);
>  
> +void *rust_helper_dev_get_drvdata(struct device *dev)
> +{
> +	return dev_get_drvdata(dev);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_dev_get_drvdata);
> +
> +const char *rust_helper_dev_name(const struct device *dev)
> +{
> +	return dev_name(dev);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_dev_name);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 9be021e393ca..e57da622d817 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -4,7 +4,7 @@
>  //!
>  //! C header: [`include/linux/device.h`](../../../../include/linux/device.h)
>  
> -use crate::bindings;
> +use crate::{bindings, str::CStr};
>  
>  /// A raw device.
>  ///
> @@ -20,4 +20,78 @@ use crate::bindings;
>  pub unsafe trait RawDevice {
>      /// Returns the raw `struct device` related to `self`.
>      fn raw_device(&self) -> *mut bindings::device;
> +
> +    /// Returns the name of the device.
> +    fn name(&self) -> &CStr {
> +        let ptr = self.raw_device();
> +
> +        // SAFETY: `ptr` is valid because `self` keeps it alive.
> +        let name = unsafe { bindings::dev_name(ptr) };
> +
> +        // SAFETY: The name of the device remains valid while it is alive (because the device is
> +        // never renamed, per the safety requirement of this trait). This is guaranteed to be the
> +        // case because the reference to `self` outlives the one of the returned `CStr` (enforced
> +        // by the compiler because of their lifetimes).
> +        unsafe { CStr::from_char_ptr(name) }
> +    }
> +}
> +
> +/// A ref-counted device.
> +///
> +/// # Invariants
> +///
> +/// `ptr` is valid, non-null, and has a non-zero reference count. One of the references is owned by
> +/// `self`, and will be decremented when `self` is dropped.
> +pub struct Device {
> +    pub(crate) ptr: *mut bindings::device,
> +}
> +

Shouldn't this be

#[repr(transparent)]
pub struct Device(Opaque<bindings::device>);

?

Best,
Gary
