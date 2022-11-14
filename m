Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6366282DE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbiKNOkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237044AbiKNOjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:39:37 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2126.outbound.protection.outlook.com [40.107.11.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5152B2B63C;
        Mon, 14 Nov 2022 06:39:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYYYMVmRtBG9HGsyp4bTEfrECqDlquSNqVj28/o3MAYIhYHy8XrKwZ7vJVzf543sUacWa93UbYR6B103qO1FPhR5S25tIi/oN0BX3REF+KnDdwf5v5iB+Rx2ghm5xRGYw2ywxt5am/W32QNFhOOBH13/RfZzvChNfJ9RPssvXeFjgmhAKeEmSbqo6g5amnWCr5Nu4DmZTgnPMQmOPwmxYzN3ujuvRRkAJtAFJXPal/A7SwC2PQnZl6GWEnWNlrMxc+g80aDaENZubqM0D2S5L5s3K+gMxnybYLNnlStrzLvdczroZ7GdA7SwYED6PFGfgwO08qQkGQ16YP97vYy76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvnUx/zZG3z5vnxcNUTbsw6RvoxUfv4/nBtbJ+hea+M=;
 b=mNoF1P2AjdtGcc+EPnI2Yo3hh1wdMoAtF/wkightb/enZq1tPJQDNEzNBOdDKSSJSfTeWB2EKUcqKOiRLmu2lh3dE8Z/DtHH0l/0e16MsTJ+1tLApxbAjXYkDCvOIBOseioHFNN6g/+6hAWNKYpC5BntFLQ4vtdwUkj5pnzNaQD9MuWTmtwrRPrWxAR791Mfoi7D4DyOPDOFmxU0nYNh2Rc/XVrQBCP3nYYbzVIdtDv/3TP7VGMCdtjbFtSYjw7GJf82f+sXZL7zEtOcjzTVgwFq5SeNmGNQfuIGYtfPMJuymkI3681WcFoO/NLOTOXrYCMEmZmZxMmnLMYXOAlf0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvnUx/zZG3z5vnxcNUTbsw6RvoxUfv4/nBtbJ+hea+M=;
 b=UJ/LSgfyxtQg1ePk7LRVLXLzJDUdxlu7MpWCZz7aojf5vShyIUzy/t6MCN9qvt42kmqc21/rS8I2pBDgre1tZZ2D9Zh2Ju8hSvkFp2CeBtKcMCO4GRaccdmwc8fQNEN8I94bG8mOslWuoV/mfL0XuKpuZRZHL6cqnn7qbI9JmcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB5826.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 14:39:32 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 14:39:32 +0000
Date:   Mon, 14 Nov 2022 14:39:28 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v1 19/28] rust: str: add `c_str!` macro
Message-ID: <20221114143928.4dde6589@GaryWorkstation>
In-Reply-To: <20221110164152.26136-20-ojeda@kernel.org>
References: <20221110164152.26136-1-ojeda@kernel.org>
        <20221110164152.26136-20-ojeda@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0508.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::15) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d322a5e-1bc8-489c-c1d3-08dac64e09e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLSwkJ/Zd0Ywe6pugkoFXE76uRDI3HAlGWE5K5LsyMMHE5RSFt7guw8rvIsRyaRb6fIcRlDklsdoCP17w0IbpxnN07x35Artt1uoZSE9LB/cLv5t2DwpgLd6qdwUb4g5lEtJg0NawPVvDqsU2iU0oitvHzMKtx/UtlDPX6sbNJKtNFiGk2+5fz1e1nVBZzkJuPCeGBU2t9dj49Ky880tRMIWa7gSK6G9ncgbI9PNQwx6GW/209mmucHd18nUqr6fSK6h/ZC2LG7mHlksZfP28TWdOUJlO72a7MxgWCw74PnOX/0/D1z29kLcOAK0CeDuLYTUwNGgSLpCoSBOpFmYVCF91QF80tYH6NPacmjWYHv+ppUg7mE/KorkHdsff2BJ7zOxZ0cNRgb54LL4XOtfOkdOmStZJkQR+p1b1PNrmvq8zCZVzTmEibySEPRLWF+cGH5zR86KI/Dpaj8fXjyJH+tBLpj8SEgoOslRXdXa0orWEFKAQGUtb/q9VihubWiQf1GBESSD/8KKe1dC4QW/IcepZ5CmrvGcyf7xBLYVamPOtWXyKUD9KLXeGvsgJ7OokfQEFnTYAuXoBlA/YTfl04s+ED4rLP3txYULXXst9RohJ/ALt0UhzPLfNVGXbbLhZ5bqgf2N85cwq3KZCJX6biPPVOTzciBdxqdijGIcGtmJ6hZMicWm7l4FlPxu3qzxJGLbX7Ph3nJvuDxZ/0MB2R8MQHZISLOs4e+PtB4wPCyLZ9hAmTwamNz5b6nZYZ4B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(396003)(39830400003)(366004)(346002)(451199015)(66946007)(8936002)(6506007)(86362001)(33716001)(38100700002)(41300700001)(2906002)(5660300002)(8676002)(9686003)(6512007)(6666004)(1076003)(186003)(6486002)(4326008)(478600001)(66556008)(54906003)(316002)(6916009)(66476007)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xXbtYbgcH1VgPQ9Run0eIPoNiiDIMrHMsVdNR/RqHenIH3cEML8QW4zm3Ab7?=
 =?us-ascii?Q?JveX8Z0RC2xQktTS9P/QjbpcGjClVLDi1JHZ9UuLQ0y9gdPASfmQq379wTL3?=
 =?us-ascii?Q?/7s5Iwwc2OGr+OAdS5rhsDXEUu3BZDI+Az67VktLDKoWPQZsgNfxsJ523u8C?=
 =?us-ascii?Q?tJ16YrgdocRX1v+0wIfTwCEiC8CE4jyMW0ZPPIXayhVocTAn7R01TVamNQB3?=
 =?us-ascii?Q?sKx2IVgOSBKsA6PV8lyoTjDQHiYmB+PYDFntPZ7O03sbByQO7cKMMoZZxI2Q?=
 =?us-ascii?Q?lVoehFc++ft+NkhB+e3WgMu0pvKEPFC7NcNYHqsX+zOGyoEfedN6Zj2whxT4?=
 =?us-ascii?Q?LyMevq6pPKHO/A268hHy1hSxsnTZ85CWB0yeVM1gWa3NNqjUCMUnfv3sP412?=
 =?us-ascii?Q?HsIXu/K42Ngqf9p9VxH4oYPfF1zYl2ZDn8mR5UX2OIx9rW5CgIyXyW13Yhsj?=
 =?us-ascii?Q?/3P8R/Ev+nGEBQ60jYNe2zyp09tH4y0OdaBxuJ7TnT9wQ4RyADUYsSovH5Qp?=
 =?us-ascii?Q?QQ3AbSybEXL6BKpZyZ+UPOUqHqXDs5U5SUfxbln/0lb/+AsIMI9qbiX7F/Lz?=
 =?us-ascii?Q?6RJy11bQE48gjZQYS3Otl3rRukx8Npf8zeeLIGPUdC9GKO2S34zHWktVrtVX?=
 =?us-ascii?Q?UGVDYxOS+LVoGOklCYXi/SfaBMfd04k6LFg5IlgoZ9dr9yGfZSF0O8vgOnon?=
 =?us-ascii?Q?O4q29DQk87WbZKqbBJN3RzN0QG7yJmOAUK4Ba3HFrp5ZiNv5eGnNdORcBWZc?=
 =?us-ascii?Q?13dvmWMvSEnroATL7Kf4QQqDJBm2gq7jT4kMRqVu2ib6V7R++isU1aClF7iJ?=
 =?us-ascii?Q?Mpf3DOENiWXmkQWbtu6ejUGJYB3WMX+hem4oPeQljSrB+hgAc5r6JdDvChL4?=
 =?us-ascii?Q?TbX1lpRvFKQiQYeNPAL6a2yw3kVZORTsNJYL/xo5dmtYjJcLqm9aIu+4rd9r?=
 =?us-ascii?Q?YDUdwZ/qdGMkGGsDKwR50eeb+mPz5F22ou3y4F8GH9ZIJMdYKavX+cX2fTfl?=
 =?us-ascii?Q?LCgp+EHxHVBJY7kIeC3kdwQgnISPPRX0lcwValrzDRGAiOy/W4S/D2c8AEOC?=
 =?us-ascii?Q?MKP9xP0XKtSZLUv5eW5U9bfO032lTQnlWT/m57VbeZLC/MenzjFklWJSp3LG?=
 =?us-ascii?Q?yEF129Kc0mUECx7xygAN4P9Wz4hPxj5qEJKUu86vVyx2/ooWPKx4Pq1iYq8z?=
 =?us-ascii?Q?ppR799MzrP4jT3K+DSf+A+soXVthiy8GDrfCWyjVAXXPNW4BdxFHyT1IFHPy?=
 =?us-ascii?Q?0feX07wT7TfQvbRjfiKh1E2dlHAXD218Rqlg+7mUxtjR+zTmj0UbpvLjYUqt?=
 =?us-ascii?Q?LNin+Aps1B/5bt7CK/89CIwgH1pz7J9nyvz3g2sZWoRfXu0PoZZj32EuGLZq?=
 =?us-ascii?Q?TZbl3K697ztWpu084yurGNaZ/DfMV8tpS4ZPLghq/ZtAER+M0S9llg1LggCl?=
 =?us-ascii?Q?3ZkD5JfMcmoZ2IFHzSN6MS0AW3oqVB65f85ZHSvGm/7yTAHqwx+X/Txc4OGn?=
 =?us-ascii?Q?TUI79+SdSD3ZdTXr8H1grFyuWQGL+w2pueCHwo3F2KxfvGLt2nIz6b7Fsag4?=
 =?us-ascii?Q?pxd+Pu1Tr8wo7jHTORT1+UWmseZ+zMSqjW+xsB+DD6RAIR69crE1E6oNLrdR?=
 =?us-ascii?Q?3UyK2RzKyj464OWGKlSHxHRze/52YdRwC438RxfrGio+?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d322a5e-1bc8-489c-c1d3-08dac64e09e8
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 14:39:32.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLG8RtSY4d8eMlO/xyf0zBQA1KO9vopVE9keD8bX7wbD00vByQ2jeOMTzofzCjJu7CJyf2iImPTqY/oSuqpAlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5826
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 17:41:31 +0100
Miguel Ojeda <ojeda@kernel.org> wrote:

> From: Gary Guo <gary@garyguo.net>
> 
> Add `c_str!`, which is a convenience macro that creates a new `CStr`
> from a string literal.
> 
> It is designed to be similar to a `str` in usage, and it is usable
> in const contexts, for instance:
> 
>     const X: &CStr = c_str!("Example");
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> [Reworded, adapted for upstream and applied latest changes]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/str.rs | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 3ed685cb5a3c..3fb73b888dce 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -128,6 +128,18 @@ impl CStr {
>          Ok(unsafe { Self::from_bytes_with_nul_unchecked(bytes) })
>      }
>  
> +    /// Creates a [`CStr`] from a `[u8]`, panic if input is not valid.
> +    ///
> +    /// This function is only meant to be used by `c_str!` macro, so
> +    /// crates using `c_str!` macro don't have to enable `const_panic` feature.

I wrote this code when `const_panic` was not yet stable. Now we have
stable const panic this function could be removed.

> +    #[doc(hidden)]
> +    pub const fn from_bytes_with_nul_unwrap(bytes: &[u8]) -> &Self {
> +        match Self::from_bytes_with_nul(bytes) {
> +            Ok(v) => v,
> +            Err(_) => panic!("string contains interior NUL"),
> +        }
> +    }
> +
>      /// Creates a [`CStr`] from a `[u8]` without performing any additional
>      /// checks.
>      ///
> @@ -321,6 +333,26 @@ where
>      }
>  }
>  
> +/// Creates a new [`CStr`] from a string literal.
> +///
> +/// The string literal should not contain any `NUL` bytes.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::c_str;
> +/// # use kernel::str::CStr;
> +/// const MY_CSTR: &CStr = c_str!("My awesome CStr!");
> +/// ```
> +#[macro_export]
> +macro_rules! c_str {
> +    ($str:expr) => {{
> +        const S: &str = concat!($str, "\0");
> +        const C: &$crate::str::CStr = $crate::str::CStr::from_bytes_with_nul_unwrap(S.as_bytes());
> +        C
> +    }};
> +}

+#[macro_export]
+macro_rules! c_str {
+    ($str:expr) => {{
+        const S: &str = concat!($str, "\0");
+        const C: &$crate::str::CStr = match $crate::str::CStr::from_bytes_with_nul(S.as_bytes()) {
+            Ok(v) => v,
+            Err(_) => panic!("string contains interior NUL"),
+        };
+        C
+    }};
+}

> +
>  #[cfg(test)]
>  mod tests {
>      use super::*;

