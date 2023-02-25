Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095556A2C13
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 23:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBYWXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 17:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBYWXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 17:23:45 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2096.outbound.protection.outlook.com [40.107.11.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F316EE064;
        Sat, 25 Feb 2023 14:23:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHrnBS2c+M0M/DvB6o5NSyqayR5bYWjAU8vr9jm91OzzqVQ59xIJIciDfpFa/AG3WnqRSzqIhHIIiabyIJ3g4inSUUEuqZs/3s/uruCyqSZqeH/Fgf8Rgn3PJ9Awi6lro+YkudfYRBJbPE5cXSrgH3Mn+fb67am5PvFf81lPpGgMIaUUR8axVPxT7CbC7Y/QRtzP15sueXrAQ5MYCuaF9NDgPUqn5zuLdpn5GxdA2vaCCLb+XsCUg19sNRII9pkW5OS+Ptt8q8un8uev+aXcU2pmv2KrdDZM49ki6Tb5bG0jbjUKUvoUPrhLPAdIvBN0Fb3XnWV5TUQx/oPbLcqiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpDhUqma38I7pz7tH9YGoi1DUOESMXhc7MJH26a6ye4=;
 b=VvIQUXkUzFJo69kaVzLZBSBgTFJI4MhLsEKiCT0cwfpGKGWTc0+Z2skV3yZIVcE98tU4Sypka/ie8Fr1CFu4qCF/xwVw0/g0PHPXEIR31EGNbyr6txZ/JdHN/wWSwtHV2DmfymAQ43K3js98jZ9Uih3ZSD+bwtmmd0sqLfNPbOAUu8Xy1Q+2Rezk7+eRVrqlDSMizUz6i5t7ITQLvsTMKWa4nNBio4651Itsz+AiDWm65xltQMosGaezUkJnrbLuEcQdhAHBVYZgwWQB7WbXGP/JjAVw0epO+fXW4Uc9mB3LIZ8vPQLVwZT2XIqQgntftI4m87cDP52jihUYCgJw0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpDhUqma38I7pz7tH9YGoi1DUOESMXhc7MJH26a6ye4=;
 b=O0BAaz/e10q7qJNVDfN5HaRDcoD3OFgl/pdhQFoYITTnDwdI71jHMF4zjzl8yTNReM885WnTGjFoQ/ESbZ+OsQQQFlyPiJQbqvsHqvUcyor/auQmlWGyC52PSJ8YCfVXN56qCMrzT6obplAQeZsiMEc7wMh6RNBPj2Vu8SfBLCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5066.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Sat, 25 Feb
 2023 22:23:41 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%3]) with mapi id 15.20.6134.025; Sat, 25 Feb 2023
 22:23:41 +0000
Date:   Sat, 25 Feb 2023 22:23:40 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH 5/5] rust: error: Add from_kernel_result!() macro
Message-ID: <20230225222340.34d749ee.gary@garyguo.net>
In-Reply-To: <Y/lOlcSpc+d9ytq/@boqun-archlinux>
References: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
        <20230224-rust-error-v1-5-f8f9a9a87303@asahilina.net>
        <Y/lOlcSpc+d9ytq/@boqun-archlinux>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0334.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::15) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5066:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b133978-2715-4a33-7666-08db177ef33e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYl7UECGFdgQkAgT2jmlTQsOr40uLqxHtanUJAg+z+jU1ssts76MJs9wHnUQlehZs2KCjoLYZewmBIUZmzQVRfNSTAWGNFFuPd/7Z3kJNZOWIYUR4uXC1WCwYBIWKoF8qe9qskQPjaO4s3zxEZweg6REMVKhVnZreDdxiagYtMYpNZD0WgR9yqELZpIMZkH67wpMlsMkdh071gmbVNcnqJ7Euf25I6DitYqhyF3Di8IN1Ga/MFLR+ML0nfNTSv07uzrL/Latcu371nJ1+WfsnGPGh420CTcJrm0p9DL2zFuqWZRUoWRgrOt9A72dNcuJ1qZwXZZdpNN2ftz06d2R48sXSUCBzPLnML4JYtKGtdMYKCcICa4zqxGfEqsUOlC+fVBknc/pjATCX2LBxNUN+zALRMfHrIFzr7NSL8APz8k5hu29UpBnnFJjoQEQCmvSJ30M8sLkHUL+0TyElQODM7tY0AA1nWXNgNG5JxxuQaTIrqYLQhSbfQ7wAX4pXKnzf94DpacEjMwPGvtZvWEkG+cYivnzs5WzGvUWkeg/M8YmNSbImlDcr4sMCjciWICf4+gqXeEgP/nWA2IB6/gFV7nMmMrR1XDendfUETjdxS7OolhKaYWLN6SNIXZq2bY5xvM8uXhiFT0pNJpDeVTyIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(396003)(39830400003)(376002)(366004)(346002)(136003)(451199018)(8936002)(7416002)(5660300002)(2906002)(66946007)(66556008)(66476007)(4326008)(6916009)(8676002)(54906003)(478600001)(316002)(6486002)(41300700001)(6512007)(26005)(1076003)(6506007)(186003)(2616005)(86362001)(36756003)(83380400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T9cNKxt1oBks06Xmr0JDJIlugFnpQ72kLZ2pt+L+tM2JDaP2q25vekhLEcde?=
 =?us-ascii?Q?1r48vvEE1/ffwCWi4SEO0jIAOdCZ/ocXBOpDS/ImhaFp2/02+HhWgiJlyyk1?=
 =?us-ascii?Q?kRgncJgBR0y1DSEv79PofmYlmLErPfJ6A/Cs/KjrTSIP46PwZRqQaL09M4Dg?=
 =?us-ascii?Q?U1qFI63UtbvE6OaqKKitN3pZ6TpR/USoDGGI7EgEKezTLVFQ3ytkl/RONcff?=
 =?us-ascii?Q?u6eTLzMXL3SJMynuM8x1Hy2x4Oxg5C9QaO8B0XxNypxodO2737KMhpJTCnwj?=
 =?us-ascii?Q?t2ZGM+BwW+YGB6GpDhhc9SAVf+Wf/NKhP9W1HfnUfKKDmmt5fiyTwVLSoVeJ?=
 =?us-ascii?Q?2f8VI9hFeyPVOOEMP20wj4MqmFPSlWVs4QbSMmrwrF5Xk7MYNebiRz8xEr1C?=
 =?us-ascii?Q?JOzksAjmdYtCpLLGsfWMyhDPe98MCpz1rxA5ibyMYl44+vCRIIQhkEdaqKKF?=
 =?us-ascii?Q?RNnXI62rRm7+1uRfRFIpxZyar5qNQBjct+2ldd6Qio6sylWDwhDIL8Q2XuMx?=
 =?us-ascii?Q?Hb9kEf9hlexldw9dDKvHmWKOgQLpdm1xmGG8h8sWw/0lCkal6YeZ0fHnq3xO?=
 =?us-ascii?Q?OMf2ZRbGxkHoOIBy4xKqXcRIrPYpZvKH0D/6hLcO8fvjkD5iP4rhw7Ah0Igt?=
 =?us-ascii?Q?uBvzeDzpCtGvlLSiDhmX5WDAo5QRnm2KW374jG3gevKbf+EQG6rrhh1TFmsU?=
 =?us-ascii?Q?gbQAIzPzYxyfPGTryScnLNyIkLWGllXrNX6jw8+pvpDdF/NhLobtAfiFoe6E?=
 =?us-ascii?Q?lOF3dt6re+qC3XTQG+1VFVeEDKGvabhz2202EEnZfubHmiiKjm3n/WhOh3ra?=
 =?us-ascii?Q?axplkIKRax0EhONJYXBWzAd9GUTrJujB3NmxO1di168RqwTNlF2Q/fcZedCT?=
 =?us-ascii?Q?J5wnxIPm/tKM7VO29NPav5k8oUy4O5GTOEPqjws0v1rvcjrMLS6o45ML2WmT?=
 =?us-ascii?Q?wdqUe+Uxf6mKHIL2p/fXZh78daiICrE9pqrrYN8HzpWrVW8GTwCauwll0tE+?=
 =?us-ascii?Q?c0z+oXlqOOg/wohge4Nl0HfBMbwZ4QPYLQtW1PYxsc6pwk4zndiJj5sDRBT+?=
 =?us-ascii?Q?lXodNfUYlSvjiEhZQBdKOJWPLQbYoXUd2gkUb4tbe6RhoJ+4l1Kk2mk0fWE3?=
 =?us-ascii?Q?NQVOMXxyDqIOx58fs6AEpz2yYBZXKS2mGk51jjT0eXrcPgc8UzK5FiWrBf+O?=
 =?us-ascii?Q?0jRtMfGW8G0YRwT83n8LRwDaxJINz2dpEr7PN7VESHljs+DHdUDAdPmKivdp?=
 =?us-ascii?Q?2ncEkAznUt8NsjZsai3YNxvCfEnR+TaVDiMERRA8Y+WxRtU6IDPbn72OQsiv?=
 =?us-ascii?Q?NdDtRquLnrdFz/xZ0A+H4obSHgXrCy8fmtJI3Nseuy0+ptYiGjdmt55jn4SC?=
 =?us-ascii?Q?5Fl9oqk6+t84nvFlUAuSJ/V1srURZ+D/91RkPmPeKR1hLH7uccCTgjqEKFSB?=
 =?us-ascii?Q?heV8RpYm0QNtLw01Bwe86lFb/zwiaguxzqvc8b/bhy1X8eZE5kd86+js9nCF?=
 =?us-ascii?Q?14QxTT9svnbfZIfNiRp7H/Dm/jsmLw6EoSEUzmdKtUjrLmz90Tb/97GDY1Vp?=
 =?us-ascii?Q?xIaDy34bTytuW4GNYYqkhSMZecVDJGPC7tR1kI3n?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b133978-2715-4a33-7666-08db177ef33e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 22:23:41.8594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MIDmFtHPEC97i0NfZa84zxA4TDf8ZzxpcSWjqJcG5guJmFZMqWVDr17lLFLUk/pZKGh78IZap2id9LwE0mSCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 15:56:05 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Fri, Feb 24, 2023 at 05:50:23PM +0900, Asahi Lina wrote:
> > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> > 
> > Add a helper macro to easily return C result codes from a Rust function
> > that calls functions which return a Result<T>.
> > 
> > Lina: Imported from rust-for-linux/rust, originally developed by Wedson
> > as part of file_operations.rs. Added the allow() flags since there is no
> > user in the kernel crate yet and fixed a typo in a comment.
> > 
> > Co-developed-by: Fox Chen <foxhlchen@gmail.com>
> > Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> > Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > ---
> >  rust/kernel/error.rs | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> > 
> > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > index cf3d089477d2..8a9222595cd1 100644
> > --- a/rust/kernel/error.rs
> > +++ b/rust/kernel/error.rs
> > @@ -226,3 +226,55 @@ pub(crate) fn from_kernel_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
> >      }
> >      Ok(ptr)
> >  }
> > +
> > +// TODO: Remove `dead_code` marker once an in-kernel client is available.
> > +#[allow(dead_code)]
> > +pub(crate) fn from_kernel_result_helper<T>(r: Result<T>) -> T
> > +where
> > +    T: From<i16>,
> > +{
> > +    match r {
> > +        Ok(v) => v,
> > +        // NO-OVERFLOW: negative `errno`s are no smaller than `-bindings::MAX_ERRNO`,
> > +        // `-bindings::MAX_ERRNO` fits in an `i16` as per invariant above,
> > +        // therefore a negative `errno` always fits in an `i16` and will not overflow.
> > +        Err(e) => T::from(e.to_kernel_errno() as i16),
> > +    }
> > +}
> > +
> > +/// Transforms a [`crate::error::Result<T>`] to a kernel C integer result.
> > +///
> > +/// This is useful when calling Rust functions that return [`crate::error::Result<T>`]
> > +/// from inside `extern "C"` functions that need to return an integer
> > +/// error result.
> > +///
> > +/// `T` should be convertible from an `i16` via `From<i16>`.
> > +///
> > +/// # Examples
> > +///
> > +/// ```ignore
> > +/// # use kernel::from_kernel_result;
> > +/// # use kernel::bindings;
> > +/// unsafe extern "C" fn probe_callback(
> > +///     pdev: *mut bindings::platform_device,
> > +/// ) -> core::ffi::c_int {
> > +///     from_kernel_result! {
> > +///         let ptr = devm_alloc(pdev)?;
> > +///         bindings::platform_set_drvdata(pdev, ptr);
> > +///         Ok(0)
> > +///     }
> > +/// }
> > +/// ```
> > +// TODO: Remove `unused_macros` marker once an in-kernel client is available.
> > +#[allow(unused_macros)]
> > +macro_rules! from_kernel_result {  
> 
> This actually doesn't need to be a macro, right? The following function
> version:
> 
> 	pub fn from_kernel_result<T, F>(f: F) -> T
> 	where
> 	    T: From<i16>,
> 	    F: FnOnce() -> Result<T>;
> 
> is not bad, the above case then can be written as:
> 
> 	unsafe extern "C" fn probe_callback(
> 	    pdev: *mut bindings::platform_device,
> 	) -> core::ffi::c_int {
> 	    from_kernel_result(|| {
> 		let ptr = devm_alloc(pdev)?;
> 		bindings::platform_set_drvdata(pdev, ptr);
> 		Ok(0)
> 	    })
> 	}
> 
> less magical, but the control flow is more clear.
> 
> Thoughts?

I don't think even the closure is necessary? Why not just

 	pub fn from_kernel_result<T: From<i16>>(r: Result<T>) -> T

and

 	unsafe extern "C" fn probe_callback(
 	    pdev: *mut bindings::platform_device,
 	) -> core::ffi::c_int {
 	    from_kernel_result({
 		let ptr = devm_alloc(pdev)?;
 		bindings::platform_set_drvdata(pdev, ptr);
 		Ok(0)
 	    })
 	}

?

Best,
Gary
