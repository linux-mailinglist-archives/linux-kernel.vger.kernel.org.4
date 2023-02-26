Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492F06A2FD6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjBZNgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZNgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:36:13 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2125.outbound.protection.outlook.com [40.107.11.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4431512063;
        Sun, 26 Feb 2023 05:36:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCZwN5zAtSActNejr7k0uxVuKz1Kwy1BV3AJUfIwYlY5zRzrIHjOXZ7YFBCfeZC69K/hb3RdOSfuiclElUFN2P8d6H0qKmuz9u3ZAk88D+5GqvsY2Grocgo3jbncg3uK/q4EWKMNRSclTNikwxVF/HMVjrG1+jWm/KEpxgWaQDvXFfAoN0FzBdQqrsuNiGv7SQJOZr80cEFeEw9cAT+2o+QkmkTJ99ARJn+UxbQeDYn4wq7MyWM2keNGw8J6mwMQsz8R0w01eT+Hj15kqm9NgxZk13AiW3eSy+3PjG22CRI9Ur75vxmefFOPbei4FkIY2m7qFSFHKQ9Bh9ymNhQurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8RKnpW8a3h9+ZB0YYxfis+i/bGk4BlHCH/yvSfokkg=;
 b=l09kTCAY6O1fYn+31KNc0TszW5d+4Wbi/TGo6jwJOJZiuc5b/XlieArepBkLsgCJT6YUEeJfA/CA2k0riLMjQYIpWzjnqp3yA5Jd3YEaCRrdWu9CwvIdg0iLd1TLemAhNdrYCh0EpsK+ZKvOdi6lrqSZc6OiRVVZNNdfd+w8aJt+x8EQtRmJGZKTglE19TrJ9lqC+zCdc5s7awlXvJrMShvGYpZNIKcOJOo/coW3XpQyhLjzlHEi1FGOtANRLfq17kZYOW4XbQCL9KnRAxPYVIuEAgVvW751aPYBqps56SM6ZMnrFG4q4uT4E6SkINswE0ygZwZcvcb3pl5r2XzRGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8RKnpW8a3h9+ZB0YYxfis+i/bGk4BlHCH/yvSfokkg=;
 b=eB1hJmUnomaWAuEZStCPhdZ+0opSaPs8bPcDwUv+R48aab8nYc2mVqPcpCYqsTvNkQBPbBXG5NQkPlVZDPoYj0OzS5WSYX/cBqL9BQw49HHq+nBtpKzpXbynALhy5t4oMZl1tpJ7UgVSgy9KnLEFcBII54I/PZLS3ZMmUBInnJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB2463.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:12e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Sun, 26 Feb
 2023 13:36:08 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%3]) with mapi id 15.20.6134.027; Sun, 26 Feb 2023
 13:36:08 +0000
Date:   Sun, 26 Feb 2023 13:36:06 +0000
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
Message-ID: <20230226133606.583cd1d8.gary@garyguo.net>
In-Reply-To: <Y/rCU1S+GDgIojNf@boqun-archlinux>
References: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
        <20230224-rust-error-v1-5-f8f9a9a87303@asahilina.net>
        <Y/lOlcSpc+d9ytq/@boqun-archlinux>
        <20230225222340.34d749ee.gary@garyguo.net>
        <Y/rCU1S+GDgIojNf@boqun-archlinux>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0316.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::15) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB2463:EE_
X-MS-Office365-Filtering-Correlation-Id: 087d11c6-435d-4bb0-1e18-08db17fe6ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7MIwEoRdftiuRzc/Vspq97YaEpc0CN6JvgfIaCJnOoHlC578IiC/3yVvS4bPoQIj0iA6GvZqfEKn4hii6KIm5ij8r0Hjk00yivqwkwK8DS9JPbunh0bGmidb4D8mfYdd3Yavz/pcQUrKzZXco2BIZ6Ot+MCgJYq99FgfTYtamUqYTqjeHMae69lir5K5gDUwGcKWMBEVJNFC/2+fsA1UULDkAwvZeQrIzH7UAkUhabjkLMZcW5utdzpIBSla1qmvAP6ovNuIKnEQVBr9h/0gqv2NYaHakOz6BRxtmBaSL+7azmYTnV4jmVfcQO5TrAEzNin8syYGpzMcYjWN54pnWca586s0KpEqSIgKbfMm5gFygOB/e9vArV8Mtpg1XaJCBR9t7R/P6S5qu9aegkI14IjfLstGRdgqAH8tNsjaSjk9gWqyRJDU7R9Y/roCXy8lHl2kg0O3F6ydZsMzPEQaELSCU1gM82o+uarAjmsHDaeSGSLnsKDKOviJygcw7hySC4FAkHvSESPGA0FX72P0X9CoCzCmuaS7NzDLjZ+Nf//nug+aESkCeTDujqfhQck0zq4UPvW4UjgNNqdUj1hpBW8LVmUSYHCL3BLPiJwhmoM5vBZ5z39wbV/pX4GbAAYG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(346002)(136003)(39830400003)(366004)(451199018)(4326008)(83380400001)(66476007)(66946007)(6916009)(66556008)(41300700001)(316002)(36756003)(8676002)(8936002)(54906003)(38100700002)(2616005)(5660300002)(7416002)(966005)(86362001)(478600001)(186003)(26005)(2906002)(6486002)(1076003)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tVi2SY16YZBQKl4jBc5qNMNkQA908crOv0na74XYmhjGm0DdPDyxK23u9vs+?=
 =?us-ascii?Q?1S/vrVBTwMxIH6xHI7uh4D9RwccR0bpVUUFskJ2jyfI8MNfeSLNzlIjzC7A6?=
 =?us-ascii?Q?HRW9GcS3ujvSW6PnJmUzfKr8O/B77YiWTf3vFsngMj/tETslV6mZxewMHtN3?=
 =?us-ascii?Q?aEKkfuNT4+xgcX62TVJjb0gncxGqwCvvRouzYVRd5oAVWyhpggUgNlWWEqAR?=
 =?us-ascii?Q?gAFml5zvShekMrbFZg/zGxNlhVjorddVkVooYvH6NOjmf4H6B9DdTZRR3+s9?=
 =?us-ascii?Q?b7hJMiz4lDcuhJThcHvoV3tGKA4JzOe9BRElX7wlY4Su7WF352KR0RbFBS+e?=
 =?us-ascii?Q?4zmWL3V16XyPh1sRByLTM0GXotlQjE4h1EfkHuHE8+SwSy39/f5iRlPC+9Yr?=
 =?us-ascii?Q?tKllNFLfmFblU+5y6Ii1SD1/uRA6QHs+RrGj0BYz9uu2rogevyigF1nvWVbZ?=
 =?us-ascii?Q?MxYos1E3vNiR4to0WWwU6zBaPEj65NbzpMs8QvffOnEgtvwGVA/mQXqohQha?=
 =?us-ascii?Q?P7yzk1JCDeSmFoRDCuQ/3sIG4HZjDJcmbzykAuHKHSRPiw53vkipnKeHjH/l?=
 =?us-ascii?Q?2PrMDSRqDFmK4BdOpxtWwIE/9TMAdp9XldVO8TFaiQWx/s4EzhCUiEqCQoKd?=
 =?us-ascii?Q?F+K83Rr9xIzbWmWKzM7LekxxaBCqSEuLrO9nq3HqO1NAm/FiA50B3bb1CCuT?=
 =?us-ascii?Q?mDCeLSZU+1V6Tg6fxrGAOQGU0Bb0qPYS2gxve6mWsfDHfmzX5dkwsks0yu5I?=
 =?us-ascii?Q?brFfuXb4+mx8YrMM/2LcjhcSZoDT4s7MjwlQPRFRvfsixMs3HjHydKflOBl/?=
 =?us-ascii?Q?N9Z81XZ97xlwEUkSyzlDdSatQh2lylI1AScz3iXONxJs5RK5ky0r9JJZ6Iyc?=
 =?us-ascii?Q?uoCTEWVbxjCYF/ld18yZjtYiLRh4gnvbTrFAvsMnKZKOGNNJuP8Wj8I3Wkiw?=
 =?us-ascii?Q?0ZiWRFkNGLDxv9EH87jqdcvSyzoFZyCheU5lefmE8/SrMT1t2TR+Rgn0iPvu?=
 =?us-ascii?Q?7aifGCSF9Mst//INY0Pzc6xrpGGlp/LReR15dtyb+zhXl5Kd0i/jzm0fLHwW?=
 =?us-ascii?Q?VrRhYIlBHsDsiJP8Kt4ZjHtS3RPLIptX77tloLZMt2joX1am1WdKx+NF5fBG?=
 =?us-ascii?Q?6o1UV1phLSge8EMq+vm01iq6ITxtmtez21aNKjaydc9oM/5bnL6Ntc3AS3hU?=
 =?us-ascii?Q?PM38+Zjej1v356cVogDk147b4mMzL18NkDlufYbH8Z30UJyYN8NCc9+/1jH2?=
 =?us-ascii?Q?ccX7uefx5WHT3spGWaW5EQ9w8XFHLs1n8/vh34z3M1nZzhTbJ+HWXwFrEDWW?=
 =?us-ascii?Q?OIJBIpDaELgNLkUmLh3AoSgffDJ80r3gcmOl3Q5OYpJzQbLIs5jnnRdQ761k?=
 =?us-ascii?Q?l5SOXVEpIrq598GzDsSDomQzX3Rs0JK0re0eIrSsgnWo+nDHkSs1EUtQcE4a?=
 =?us-ascii?Q?u0wldQF7UrkaPrbD8yh5cUOLmOcaritg7wBYnDMt7l8Xav5DqRaC3IevChaA?=
 =?us-ascii?Q?8rE06QrPeURXeDzi5GLhG/OSlibA1tCJ0/G1B7YTPI+EM3CFtDWHnKOp/zra?=
 =?us-ascii?Q?xMOBZD6wm8n3fG/VoOBf94b62XD9P7lbG20HZIhF?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 087d11c6-435d-4bb0-1e18-08db17fe6ace
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 13:36:08.5488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihjHhSflVkcFJUeL+zMYnV3I2XhPceX/KL8XnT/i18eIXAgCQrJ8rhhTWHoibulnR3vxs4yPR86fjok7OabMrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2023 18:22:11 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Sat, Feb 25, 2023 at 10:23:40PM +0000, Gary Guo wrote:
> > On Fri, 24 Feb 2023 15:56:05 -0800
> > Boqun Feng <boqun.feng@gmail.com> wrote:
> >   
> > > On Fri, Feb 24, 2023 at 05:50:23PM +0900, Asahi Lina wrote:  
> > > > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > > 
> > > > Add a helper macro to easily return C result codes from a Rust function
> > > > that calls functions which return a Result<T>.
> > > > 
> > > > Lina: Imported from rust-for-linux/rust, originally developed by Wedson
> > > > as part of file_operations.rs. Added the allow() flags since there is no
> > > > user in the kernel crate yet and fixed a typo in a comment.
> > > > 
> > > > Co-developed-by: Fox Chen <foxhlchen@gmail.com>
> > > > Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> > > > Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> > > > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > > > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > > > ---
> > > >  rust/kernel/error.rs | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 52 insertions(+)
> > > > 
> > > > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > > > index cf3d089477d2..8a9222595cd1 100644
> > > > --- a/rust/kernel/error.rs
> > > > +++ b/rust/kernel/error.rs
> > > > @@ -226,3 +226,55 @@ pub(crate) fn from_kernel_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
> > > >      }
> > > >      Ok(ptr)
> > > >  }
> > > > +
> > > > +// TODO: Remove `dead_code` marker once an in-kernel client is available.
> > > > +#[allow(dead_code)]
> > > > +pub(crate) fn from_kernel_result_helper<T>(r: Result<T>) -> T
> > > > +where
> > > > +    T: From<i16>,
> > > > +{
> > > > +    match r {
> > > > +        Ok(v) => v,
> > > > +        // NO-OVERFLOW: negative `errno`s are no smaller than `-bindings::MAX_ERRNO`,
> > > > +        // `-bindings::MAX_ERRNO` fits in an `i16` as per invariant above,
> > > > +        // therefore a negative `errno` always fits in an `i16` and will not overflow.
> > > > +        Err(e) => T::from(e.to_kernel_errno() as i16),
> > > > +    }
> > > > +}
> > > > +
> > > > +/// Transforms a [`crate::error::Result<T>`] to a kernel C integer result.
> > > > +///
> > > > +/// This is useful when calling Rust functions that return [`crate::error::Result<T>`]
> > > > +/// from inside `extern "C"` functions that need to return an integer
> > > > +/// error result.
> > > > +///
> > > > +/// `T` should be convertible from an `i16` via `From<i16>`.
> > > > +///
> > > > +/// # Examples
> > > > +///
> > > > +/// ```ignore
> > > > +/// # use kernel::from_kernel_result;
> > > > +/// # use kernel::bindings;
> > > > +/// unsafe extern "C" fn probe_callback(
> > > > +///     pdev: *mut bindings::platform_device,
> > > > +/// ) -> core::ffi::c_int {
> > > > +///     from_kernel_result! {
> > > > +///         let ptr = devm_alloc(pdev)?;
> > > > +///         bindings::platform_set_drvdata(pdev, ptr);
> > > > +///         Ok(0)
> > > > +///     }
> > > > +/// }
> > > > +/// ```
> > > > +// TODO: Remove `unused_macros` marker once an in-kernel client is available.
> > > > +#[allow(unused_macros)]
> > > > +macro_rules! from_kernel_result {    
> > > 
> > > This actually doesn't need to be a macro, right? The following function
> > > version:
> > > 
> > > 	pub fn from_kernel_result<T, F>(f: F) -> T
> > > 	where
> > > 	    T: From<i16>,
> > > 	    F: FnOnce() -> Result<T>;
> > > 
> > > is not bad, the above case then can be written as:
> > > 
> > > 	unsafe extern "C" fn probe_callback(
> > > 	    pdev: *mut bindings::platform_device,
> > > 	) -> core::ffi::c_int {
> > > 	    from_kernel_result(|| {
> > > 		let ptr = devm_alloc(pdev)?;
> > > 		bindings::platform_set_drvdata(pdev, ptr);
> > > 		Ok(0)
> > > 	    })
> > > 	}
> > > 
> > > less magical, but the control flow is more clear.
> > > 
> > > Thoughts?  
> > 
> > I don't think even the closure is necessary? Why not just
> > 
> >  	pub fn from_kernel_result<T: From<i16>>(r: Result<T>) -> T
> > 
> > and
> > 
> >  	unsafe extern "C" fn probe_callback(
> >  	    pdev: *mut bindings::platform_device,
> >  	) -> core::ffi::c_int {
> >  	    from_kernel_result({
> >  		let ptr = devm_alloc(pdev)?;  
> 
> Hmm.. looks like the `?` only "propagating them (the errors) to the
> calling *function*":
> 
> 	https://doc.rust-lang.org/reference/expressions/operator-expr.html#the-question-mark-operator
> 
> , so this doesn't work as we expect:
> 
> 	https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=64c9039e1da2c436f9f4f5ea46e97e90

Oh, you're absolutely right, I guess I shouldn't be doing code review
in the middle of the night...

However, if we have the try blocks then we should be able to just
rewrite it as

	from_kernel_result(try {
	    ...
	})

I guess in this sense it might worth keeping this as a macro so we can
tweak the implementation from closure to try blocks without having to
edit all use sites?

Best,
Gary
