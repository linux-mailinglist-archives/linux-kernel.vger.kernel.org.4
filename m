Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4352D67E728
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjA0N4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjA0N4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:56:30 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2090.outbound.protection.outlook.com [40.107.7.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98F5C155;
        Fri, 27 Jan 2023 05:56:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7BBM9nn44vosZEFOuhR7hlkz03ijLR5LY/CH/zkDsyrHMqDq8tEPNpmALUWbMFAGjdMqyqBDmNFYh8ngyGBOuSqf6Py1PDJTsxVRDYmTrYtUeicmSebMW5blWv30Z8QqQpJKTk/iYpvQiGptcHh4lVLhjbZy1xkDcLJsRynjKekLYoFz58Q0DuKXvM9y7o51FB/jeC+hjMonlXtwTt4+/lfUTmPauYe+MK82Xu9/mv+OwusluUjolcMWip6hauQ1TLcLn+Q9IIt7qyhNt9zXBccTRdioQ3GFg86Y5leFSpUfzr9UXbtJtmUfg4yLZXYhX2cdrOSpeH2JsrzHXZIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJe+Pi16a6CKTZiXmpKVmRTtaURUm8/8y9xbx0soVE0=;
 b=JKyAulCUo/QtsYohe3DQ/XSMyK5an0LfkkzRnuwyase/uEdBFuGd6txjv3jvkRAU4OHBL2XJtAdp5QjEsR7lA1Eoj7r3+BBHIuO1nWC3d+zjR8tLyCdROjQ28YuxtN2oBjX6+1uAE5wIkisNf449h94oSRUpeAbIsJiv2urZmorZfTDk5nYRM4EjRffMjg7G8mb/AKpcsBvhkhOjlKe9D74ZvB6AC0MGAedX/VaH7bgO1MWqv2whfaZeB+kcqTsSl6u3BpYlKpGtt7Gz05MEIYYv0IoB/+VMu136+DifYtc451iR2TUTZBJVtz46QBQLuBmhFelJFshypfVCmIE9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJe+Pi16a6CKTZiXmpKVmRTtaURUm8/8y9xbx0soVE0=;
 b=ikYyo4fANoNeG1mTJkdIb2SGR91mXxFAj+HcF1m7FRTNTOtC+dGljQnMKFQRxd0J+Amhlh2Zz8g7+Q/qSECBAn6IryFscDtK5BYfYA1VvSOhbfUmBEJNePdAU9+8X0pEgPn0+Dawro8w+2cRyCRWWCmczoBqbvar55fAcNrfM/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB2340.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:67::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 13:56:26 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145%9]) with mapi id 15.20.6043.023; Fri, 27 Jan 2023
 13:56:26 +0000
Date:   Fri, 27 Jan 2023 13:56:25 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] rust: types: implement `ForeignOwnable` for
 `Box<T>`
Message-ID: <20230127135625.6630332a.gary@garyguo.net>
In-Reply-To: <20230119174036.64046-3-wedsonaf@gmail.com>
References: <20230119174036.64046-1-wedsonaf@gmail.com>
        <20230119174036.64046-3-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0474.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB2340:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4d3793-0a8f-4800-e933-08db006e488d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZml7GVAkB75xH0XNDg4PSOuXpeRaM08KZk2Z+gpa7Us95qj4zOiga1m2FfjHTgXQHZzbTcm8W8Dd13W9CIBTjA3nuoExi9YmGQiekhu9ddgBa/TY3d9uRNuoMGNrpz9ooCbozi2utp5k+IxjaA2Y+71kzX2a/LHqJaDyYKahx9Wruuw9iLR9cwnDqfkoD9LV3+tab1kOY4djavo92UTFRZ5+TPq6NKF85gevy6O4XBzz72k4ow3LMgRznV0t8tngLp/Vlrn7JpAMRctbNsvBrRHHYmrHgpiLLGlh4IPZH981Zl38NcUwS0HtrnyuR63IHy0TXElEJQzIpSBt+FBTl0sKhgkClcROMHVf5RV8VD0IWZhGmxE99GqdmqpCWbW9vHjz/CtGvt3Ngzefc/FlISJXghn/gWH8AYIZOsyS9znig9G8kvxoVzAelW/o/n4hWlLAg6TZF65jIOIScKEyRRi7XKtNK/r+Sc2gYeOoNXetJDRSLhZTfZh0FCqLy0HCnPeHeM1UUjXts1XB6WoEZGROJhTjkjLl8pl3+F1aKUJ7If78RaLQpPpZQXNrx1ujA7GiDnNhXHvtux32s4m4dbI4rh/lGn3IgoHPwoAVgBBOWnFC+zg4+Iiofvr3PntnFkTjRp5wVITk+BW9NkuSvzyATtpaUDjx5SAEK4dvgmuR1k/PGJQR16e0QvX2dm9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(39830400003)(346002)(366004)(451199018)(41300700001)(66476007)(66556008)(83380400001)(86362001)(316002)(38100700002)(2616005)(36756003)(54906003)(8676002)(1076003)(4326008)(66946007)(6506007)(6916009)(6512007)(26005)(6486002)(478600001)(186003)(2906002)(8936002)(5660300002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EsgDVCzzF2drKXhedRWH5AQ8XjieXDarxvZbciUQj29jfmIfISBlMJSz6ayR?=
 =?us-ascii?Q?8vYPOuZyEx4gpsyBUIA2oC9m8pQ9DY2evFVNY87nwvEwBC4UhxLqXuSX00LE?=
 =?us-ascii?Q?3GtKLt1+j64fLTevbCfFY2hkFWks5FJ2ODifdnbYkjMjCGY3/4xjPqB219aR?=
 =?us-ascii?Q?dnkNXaeP6a1hFoUfZ/BNmZwjyUybl2zWd1A6QZDo+ywIuZE2w4SdaL1ytI6W?=
 =?us-ascii?Q?qaGHRMS9nu6jI0USbQKkjyTxwemh0R+ewSbCmDUwglnbX3hdSqcahuOqEunr?=
 =?us-ascii?Q?DCSrxaM/mhdFa9BeBmz7h4RNS/62M2iqtKPVJuwoYmG2nelFS3MnpceObSRX?=
 =?us-ascii?Q?0wJ6Yav/Eo/krhky2QGOmpsvhERySO4dQ96rPaSP2VGyJDZClpgf+cx5miDc?=
 =?us-ascii?Q?4i5u3ghu9N3zBRl+IdIAWRDs4D5AatSukGeP8Lefm04U8696oEGYeCvoq33e?=
 =?us-ascii?Q?KWGg7Jl0Dpu66Wh6H2WRHCdYue5KTlbZDaWDvWKRPv0zT3QWKmTnH7U1Ovmo?=
 =?us-ascii?Q?DaCuxlF581t1qAOG5fV5PEpsJjcZpmu7PTLoRHkZNwGLl2X0YOI52OWgVvL6?=
 =?us-ascii?Q?7qxDTlDzkACKMzDdx65aiN6ZomIB/20VEoTz9/hd5YbKjXocpMkAEH4zfX0V?=
 =?us-ascii?Q?XovRmXd/97efbPS6kV5LAOBN2cpJSp4c2iumNqTha6lZhg74k1Um5nyJVgMR?=
 =?us-ascii?Q?ykOctTgj0+E5nkbXIsrqb1qPqwjdbL/C5CxmGf6KiAIwwVcINZrxgYr2hefQ?=
 =?us-ascii?Q?sDHsmXNBjDDGA0almGvMrBNBvXUgRW6Ng3up0GLvBMRrkvCvK+xBaPjOUhqn?=
 =?us-ascii?Q?u0XzohLKCfpNrJ8aOepfAwKATlrN6/mnHoE4g6sYskbVlXGNkW0du/clvR5B?=
 =?us-ascii?Q?8tcpcYmd4zl6dTYglrvBMBrEPAypExMU3FHMGTLQCOV7m8p7O9LUZhphD/mY?=
 =?us-ascii?Q?RLhesX+/a2Oqw2ttVlwrkdts1/MG4YDoj49huTMAJuDkrw3UpGhSXCdqKyRz?=
 =?us-ascii?Q?66ivCW74ASWsYYZdbS/xk7GdZlxzfBptYLIzJEQQfkqQbAYouD1G/cAjlIDz?=
 =?us-ascii?Q?949g4gwOyvkJ6duzVymZV88ck65ksIUYB2qbNHtLtffHRQ+IZ7is0ZD1oNnF?=
 =?us-ascii?Q?lPRQZ+PaiPmavepTdSuopsonBfRDiSgroEhEsTnlYLVGJqk04itP82DAS5jp?=
 =?us-ascii?Q?dtY7+UndV7kH8H4l/ggXvbCIfEbkhzTkBELRySh2Sr9t/Hs5Td6Xcl+hK6Vt?=
 =?us-ascii?Q?aD5LjMUKUKzH24hgg3N2cd19Tn39yEv6eSLwj4ZFJxZJqa1L8403bMm1xjtK?=
 =?us-ascii?Q?jaGqEidMSPlhYqGnDO43c3vAxKbr77SBiBK61R8kSRKrxCS0x7t+9KIXAKN7?=
 =?us-ascii?Q?zgUSgij7V5u4UeFHjfBmTYVyeVPjLiPlUxloOy1fyCu3NOUl9Mmc1sfH1gPQ?=
 =?us-ascii?Q?Spa0ejcPgX9XA4s3tI97cs501MCIap48oGvWNII0WmKjN+NDhg///k0vafrH?=
 =?us-ascii?Q?Agv2bqyxecLqzJrMxZwTDyYoGJHkORKqFCHhUXDCf5t7qrn3swgI3p+Y6Iy7?=
 =?us-ascii?Q?df0fxFlUw2+krUsTa39+Pg1I5N4YZYWA0X/0mAJW?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4d3793-0a8f-4800-e933-08db006e488d
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 13:56:26.8125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHHRnTCznR6x2ZS1S3VXzWlvlHDrWgcfYeFy5+Tjnzf1wCE5u0ZRoorZB2W1naMHaGxEY7M/anZ5NdxUbPO+wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2340
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023 14:40:34 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> This allows us to hand ownership of Rust dynamically allocated
> objects to the C side of the kernel.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/types.rs | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 5475f6163002..e037c262f23e 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -63,6 +63,28 @@ pub trait ForeignOwnable {
>      unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
>  }
>  
> +impl<T: 'static> ForeignOwnable for Box<T> {
> +    type Borrowed<'a> = &'a T;
> +
> +    fn into_foreign(self) -> *const core::ffi::c_void {
> +        Box::into_raw(self) as _
> +    }
> +
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
> +        // SAFETY: The safety requirements for this function ensure that the object is still alive,
> +        // so it is safe to dereference the raw pointer.
> +        // The safety requirements of `from_foreign` also ensure that the object remains alive for
> +        // the lifetime of the returned value.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> +        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
> +        // call to `Self::into_foreign`.
> +        unsafe { Box::from_raw(ptr as _) }
> +    }
> +}
> +
>  /// Runs a cleanup function/closure when dropped.
>  ///
>  /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.

