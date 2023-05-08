Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26D66FAE3D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbjEHLmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbjEHLm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:42:27 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on0705.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe14::705])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CDE423B0;
        Mon,  8 May 2023 04:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdXzbmXgXYIcXa6i8vd9t5ldBrgDvUyYJxQFDUsX1jcB3og9V35PN6BlW7lDJ2G0VvTLqpNSgMqhInHibQ5ltu/Tm9KWcwJdtuY1d7Ry34xwm1YGOppyurMUtk7W2qmbk9zBL4IAOzB48Yo5+Tybi17lR5YTqrto+szXMn7fWcHFgydappC2uDLP1nkCgLlOnr0vHyPI/m2rW67tumuPazyScyyTyB7ArjsHLSHo/D8eX5GzpqpVu9bTBuX2pXh8jXiiheRCwBTGTqAEcU5/NSDcpFtfHVev2AHdFmWIohnBpCDn6YaTqkvIPCfGzMLllUqV1F5DK63xFnyTz687cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+a2xSRtgTt/BUBnFViuF9Gwr6iyfiwiFr4vZ2GGl8Jk=;
 b=DzqD5I2oMr3TI19Jjk4ecA1ucVaUM3Mzdyv1mqeRrHnsq0ePCHG4HACFL5WXI67VNvh+t1Pk+D6YXk4dYZvYIevxZtmf6ulsgh32paSwPBMDHweanbeDg337iTSBTViAgdzCQ0cPSl7SX3XIwdway+6zFD1/ZbebHbgyJDVVsTCRIZy/AkK9mXczRhz1RxqhQJClx1cF9Rx/EyakumKKTxTpdcUrzHD4G9jF3iT2FiYMYZLgDNRtva6Fa/6ODN7dOYs/Dl3E6FKKCORWfNZZB94yZ3QJPv8/LkISVz2JWrKldvGPEn9Zlg4nLA2PDSMGsbxwQYvAtwSZIiDcdoYJcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+a2xSRtgTt/BUBnFViuF9Gwr6iyfiwiFr4vZ2GGl8Jk=;
 b=mkrw3/yiH8V4s0b+umBvmEj7iFpt/rdKpfAENTEfCEMGZAa6kAWBNQUNM9euiEFBtZ+y7+yNNNkIMa+90vCNBkb1+sMWjmbvOE0TQ8XN0eqP3Q1IyWz6xiIWEx083YbSWe9N8mWREZvElfCt2BY1xXSuyJ7SzdUw7YtoS/R+cbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO3P265MB1946.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:10b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.17; Mon, 8 May
 2023 11:41:29 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf%4]) with mapi id 15.20.6387.017; Mon, 8 May 2023
 11:41:29 +0000
Date:   Mon, 8 May 2023 12:41:27 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "=?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v2] rust: str: add conversion from `CStr` to `CString`
Message-ID: <20230508124127.77a97c54.gary@garyguo.net>
In-Reply-To: <20230503141016.683634-1-aliceryhl@google.com>
References: <20230503141016.683634-1-aliceryhl@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0338.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO3P265MB1946:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f39b23-9d8e-4520-038f-08db4fb929a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQYeF+901nNbFEA+4QpgDiKfxicrqy5xkMPqys+YWNkrtcZDrBveUcZwLKPsTiT1c3YKQdUG2rLRYpBhCp5jG3xHQmBmBY4GixAsjQUpapl/91a9FvoTLj/CMBSzSojnKGwHNbzudPr4nQZgE25R9LTjlyvN9bqJtGjhTmSySUB/jdbT4TZrD/uVqQYp6eq3IUrpEKAWod5Rp/1WAetul8oyUIVJcDsF1P89bMbxxjDLbYt4Zcges8eRROC+upeMPoMeBBu6+P+HJxMlLQKnIY/OvNvyCUKeEewuJj8afNrYmfIM7RK+os+a7ir95bSJYMPkeLJiH76URhQoTEOBikusJpi7ZtPbmmabYkoQnBL+5t/AMKqvc0x+208seVmdn4vv0isoMM68J4viTKTK32T5XbG0ANSXcIZk/jURRDnwkwQ24KN2ZixbmTPt5E2cnbm7/aKdRFBNEz1KzA+41qLMnGFiWQxzfVfjor4A/qokBJvcGfveM6HVI0ioqefvQh5EiqfmnShGRg0YoZ0NZ5Eki+R2fnyemy3EZgs+lB7dV9TW745f0PxMLscRN4LFxqxSl2qQpjC7pmU7gXMQqjFgNe+AEqml2Ck13yzxlyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39830400003)(396003)(346002)(136003)(451199021)(26005)(6506007)(1076003)(6512007)(6486002)(83380400001)(36756003)(2616005)(38100700002)(86362001)(186003)(54906003)(2906002)(8936002)(8676002)(316002)(41300700001)(478600001)(7416002)(6916009)(4326008)(66476007)(66946007)(5660300002)(66556008)(66899021)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XRmzCCYAPJzsamQOzfCAoRCyarx8RxzdHMtCdGfFQDLGgBWDIPg2gzf2UIu8?=
 =?us-ascii?Q?b9JKM4MIRgpcojLR+ljGQGX989igkpMa1Fi3VNkb2pIfsXx8Far9VkF1qkrz?=
 =?us-ascii?Q?psg6H72RYLnZiQVkwcfukPGdT+nP76jXBV6ulSoOt1egHmtM8Qvim/ynBh0o?=
 =?us-ascii?Q?ESQ9CWaagIoRhPMPExfp8EBXbKHsSJNI5BinQYsz/XwXNo18GdOWB7VHGZ6L?=
 =?us-ascii?Q?zjk5w3BP1BroSRaMvaxGCpSJEgbamN+iI0SfoC9x7qA5Zh47OQH+NqSOeSgK?=
 =?us-ascii?Q?ckVILY/tjgobwedCghJfach7KJ2Y+SJV8iDsbbdyuFNvkRlJ8hHLQh/60jjR?=
 =?us-ascii?Q?cWCUgWBffc/s/VqacRU94MJXlU1SdZwOz7HrnnjnaZVmJTd4QbKSRszIL9O/?=
 =?us-ascii?Q?r/xDKVbJnwoBGBABtcBIU0ejjZyRJzkO5BfrRMCgEWthO5mmQaG7Aql0d7+c?=
 =?us-ascii?Q?UVFRHCiVOhTkhlZ850ztHrIZw8HwpWxndMP9fvE5huiT0j2aJ8MA6/LNxk6t?=
 =?us-ascii?Q?NEyqC+r9KY2ng2tItpA2ytYS/oUX5dfoaoyuqHorIXUeUjgCZdki7F/WDOOf?=
 =?us-ascii?Q?kKuSL6VDvMQgu6JMR5urQomSz6aW1NbVP7LdpIKSEnuyivwqqILQdqO4zmw0?=
 =?us-ascii?Q?G9LIwxxKUa9PNWQJigLJYOgPGeTUJeAmU2u5tqB+ZTiMVRBVVbis4lOmexyb?=
 =?us-ascii?Q?9uThfQlJflaQO1aeOmOipEQbffxTTIIC/CuzsQ0t2sN7kJ2JYLPiDMN3CuHV?=
 =?us-ascii?Q?CLWsSAOL63kWFqeNkFCv4vEAr7Sec7aIQ4xIQI8cc8SJC1iCWaIF4dUuYGUT?=
 =?us-ascii?Q?gQp385AmrAf8OECh/srGJ4O7JFqyfAFd3cxEqGv/44MK0HpUHvTWT397hevM?=
 =?us-ascii?Q?dfqdDx2BYlvmtIpg8ldcOYuB/nQ1caScnijBDFxxFbTrzgKTKxHL6bLf5JVW?=
 =?us-ascii?Q?ANxe5dD/P4Nbv/X+fxqNzsVDE4u/2iVaTPh0F8jdCzZgnoYGChPWDl2qxm/z?=
 =?us-ascii?Q?5rgVDUuN7Yr5lvE0CQ5pDMMqQNJG/7PGzsnu7lzA39vyBG4lpBC/gHybo3BQ?=
 =?us-ascii?Q?a+khlFJ+gJ0KEjM2Zxz3cxbQjARyzyiecrrTMgjStlDMv+wSmXM2ouJbW12L?=
 =?us-ascii?Q?p4tvDJJlTAuX0Lc2kcJpK7iOms3KYhJNkAUFnIq9tiFP3cu5I8MRtFFLxkeV?=
 =?us-ascii?Q?8wzRG6NKDyJygXcACKruUwDdjbkqY6rv164/nNrfRsYaca2FEeWFDR2Y8w5o?=
 =?us-ascii?Q?MQ9wiy2PxmhtKwltiZ6QUn84kiFWK++IVrRLb+XxBFNZGPedcCMyMRCPj/Az?=
 =?us-ascii?Q?BaVFFreDKsjxHIbMdz3TsCcDd3uZqp+VJUai6oVBWVqV7oC0HY0wYXLG3Mrd?=
 =?us-ascii?Q?btOrg9/MChL1VnRLwxuImIt4qzL5GDwse0cwfM41h9XvZejD6VPXWCUlTWd4?=
 =?us-ascii?Q?ut2xyHY4FdNwq452U1Zxtw6os5wn1O1YRuuy1f9hMnTGEEiyiYL1C+dNjEHv?=
 =?us-ascii?Q?1zNJj1OB6Vp6PnhRol9wLb1I53WkAGl4SdNSE1DUhrMybQmnrdbiisVsgIN1?=
 =?us-ascii?Q?x6zoDFoJVajy8smvAcuAMb9gi0WKNimTaiISxGoq?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f39b23-9d8e-4520-038f-08db4fb929a1
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 11:41:29.0435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WUozB95g+2dptlnGx+6IiLZzJgVmMXn24xhb2BxM4TGO2nzUlyChPFbk3xr6VxZ3ok1VPs2oN5L+/j6tS+aIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 May 2023 14:10:16 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> These methods can be used to copy the data in a temporary c string into
> a separate allocation, so that it can be accessed later even if the
> original is deallocated.
> 
> The API in this change mirrors the standard library API for the `&str`
> and `String` types. The `ToOwned` trait is not implemented because it
> assumes that allocations are infallible.

How about add a `TryToOwned` trait to the kernel crate and implement
that trait for `CStr` instead?

Best,
Gary

> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/str.rs | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index b771310fa4a4..f3dc5b24ea55 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -2,6 +2,7 @@
>  
>  //! String representations.
>  
> +use alloc::alloc::AllocError;
>  use alloc::vec::Vec;
>  use core::fmt::{self, Write};
>  use core::ops::{self, Deref, Index};
> @@ -199,6 +200,12 @@ impl CStr {
>      pub unsafe fn as_str_unchecked(&self) -> &str {
>          unsafe { core::str::from_utf8_unchecked(self.as_bytes()) }
>      }
> +
> +    /// Convert this [`CStr`] into a [`CString`] by allocating memory and
> +    /// copying over the string data.
> +    pub fn to_cstring(&self) -> Result<CString, AllocError> {
> +        CString::try_from(self)
> +    }
>  }
>  
>  impl fmt::Display for CStr {
> @@ -584,6 +591,21 @@ impl Deref for CString {
>      }
>  }
>  
> +impl<'a> TryFrom<&'a CStr> for CString {
> +    type Error = AllocError;
> +
> +    fn try_from(cstr: &'a CStr) -> Result<CString, AllocError> {
> +        let mut buf = Vec::new();
> +
> +        buf.try_extend_from_slice(cstr.as_bytes_with_nul())
> +            .map_err(|_| AllocError)?;
> +
> +        // INVARIANT: The `CStr` and `CString` types have the same invariants for
> +        // the string data, and we copied it over without changes.
> +        Ok(CString { buf })
> +    }
> +}
> +
>  /// A convenience alias for [`core::format_args`].
>  #[macro_export]
>  macro_rules! fmt {
> 
> base-commit: ea76e08f4d901a450619831a255e9e0a4c0ed162

