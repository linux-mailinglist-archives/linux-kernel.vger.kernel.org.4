Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D0A67E7B2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjA0OFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbjA0OEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:04:51 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2108.outbound.protection.outlook.com [40.107.8.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB2F4EED;
        Fri, 27 Jan 2023 06:04:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPtFyMEjcRy2bT5Bvsqi7InIWfRuFBVcxyIcyw6HYIj4N3as+C8WtdNJVdTrUWOIHcsojOAxeZcpfk68HXUWAoBuljZpwGbQNJ5UdCI1ViAvBbF2BKwNZNhDWOzdepwCs5t1jxKiVjvAHx0lDbBGG36ypoahqPr1hda8Od6kmdPgz0j7VWfL0qaoFYLaBUWWqXtTgFcdS+d10c/HExOOcdjIkLgPFQ9CDv05F+ZzniiN31bst8rLlSdXlqxND/4SVPPvTCUgFwxqp5EF2oOl+tJJDWogPuj2G2aXk/VzrvTotnUmnVSb2dLeDvuyf16Xb8r3CgosFiUxcOhgdD3RKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ENtR8ZaedJh3l4YcMOVn3AQHgW5ppkF6yrr7c7fF9M=;
 b=deAHW9Rtm9QrQ2SIILZcjnTD/Q+oy+/bEG11L9EH1lms8wjpcW9LmI9DqEXQemcCbFvVHe79kxNpri8iqzupl6BV+f++O9tgFh1XcSElOqpYAykDM/NKZ7jthGdmXk67b+gNwdqBM8sdISshQS789Vp1wNAr1vynZ3VYrH1Gzk0TWppmzy0ta/OvEprkBIQ575jzWpHyUbjU31g41q/g7FBSu4wjeBOYp5aod+Ji6s4Wz02FXwmWhZ1K0tV1tlLy/i1+6u5i6otaTTyzGjEub8oBf1p3eYxgwixYTM2bL89gbGH0eAOyf9Y8QtnxZzAQ9lLk0KBYe8FTAh/YYADPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ENtR8ZaedJh3l4YcMOVn3AQHgW5ppkF6yrr7c7fF9M=;
 b=fxmuuHNe1Kh1fPhyp/JIDHhaJx1CE618Dn4sWn7pEJ17WOWASLQp83ja3jcMP4Xzm9HptOURfD8Iq0KvJMFCDqguuQUmuzBOJbRI5UHw5NHbgu1nwX9B+Y12ZINGsMPoKtd6jV6C0nof2CzJUSjbcwvVXSxruktEJJqDhOHWipQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6754.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 14:03:21 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145%9]) with mapi id 15.20.6043.023; Fri, 27 Jan 2023
 14:03:21 +0000
Date:   Fri, 27 Jan 2023 14:03:19 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] rust: types: implement `ForeignOwnable` for the
 unit type
Message-ID: <20230127140319.22af6060.gary@garyguo.net>
In-Reply-To: <20230119174036.64046-4-wedsonaf@gmail.com>
References: <20230119174036.64046-1-wedsonaf@gmail.com>
        <20230119174036.64046-4-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0555.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e947415-bcd5-4971-3a3d-08db006f3fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7U/nLU1AJRFVwDJMH0hDmmpEGw1To6lVT/R7tlZb+xKkYDG26HG8LAtCM5OoQ7vXu+cfgeRwM6AYu54CQmEU826livAcDF/VKxcdkaDDTC4BjRona0vmScezGpc72g4OD+GG43A5t2hbHg2rnG9nE5Aq+codimRusjHF8kBlSMsCEUNVoEXUPvkF9ZO/NQF5E2bRwZCZp6J9MQyNx2ukeHXwomLxhcVH5JZ2rMBuCCX6CcjWuAkVoukPwTqQENQueTXoc7bIHUTDUlGYduFz54P8Fh7RdkOIy/uFYTn51ZWVszTaCekdAKkre8XRX3t2CZ7sLAvtIVUKW/HTHpRkdpI6MlytK+OsUc1FrPb5C6EVtdK+EYhTznEi0YKDdIOi61cGH4j97MJ+SpPYNcODsvMiXuC3RL1SHhhdc7FfbFah8NYhsGfr/Jjo+6p83zm6TFd8rbuP6FM7m5UgvGJxrnrxVdlLGxjlExNNX3g+qIl7HX2Enegl0Z4Xh8Gx52FjO/kB1MxFyf++e/tRwRQYc3iCT7xiJE4G4XE9w+E4G/UusfGqHbTFG53sL28022+mLXNaHRr7fOTHVwC/3lszvmgZ3qgxDh7XGX157jSKmP9GuP8GnNs3NC4KRRzGO1Aj97MwYWEC+TSSvKbNOz3MZGbwTxHczl7MttcLFIPzvxg8N53oBc/IXns0bK99yGpp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(39830400003)(376002)(346002)(396003)(136003)(366004)(451199018)(1076003)(316002)(54906003)(38100700002)(41300700001)(8676002)(66476007)(36756003)(6916009)(8936002)(5660300002)(66946007)(66556008)(86362001)(4326008)(2906002)(6506007)(26005)(478600001)(6512007)(186003)(6486002)(83380400001)(2616005)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TEM1jL9zMgx7WRFzCG30Jmy69oXKHgXHRcsDKj4DMty2Wo/KJD0s3edCTlMi?=
 =?us-ascii?Q?xXEGn/dPuYyYm/PP4gddp6bhdP0c6yuE+GJRCEJgmyzCz49GtD9pA7gcNSL+?=
 =?us-ascii?Q?3g8cGnyhGF0nPNnaRmXDBPsUx4E7PHu13P1NOGUU+iB3wQHCwkmIYgc1v/tk?=
 =?us-ascii?Q?IZ0wPqDmRXpZmKjDid45F6qSudIhmjRw528Hyarg6PnJWTK7/1m7ujn/r9S8?=
 =?us-ascii?Q?VSwz70LL0sMrOui3oiRDNlQYElttNrpgTdij72qcmwI7zFPhiqZkA9bi3+5M?=
 =?us-ascii?Q?Ti5pxeuXnM9TtCsm0h5f0ITZF+Q+QZ8BZ3XxcxPUMyIZzdE7fBUWt9uBhbm3?=
 =?us-ascii?Q?dUKzyP4CmvucjCooeudKOc6tbZZs2c+1r3utEaR0Xo8Vwu0BXfgdplCTd+mE?=
 =?us-ascii?Q?sI81vXCwLZbtnytXhS1g+VOUoe+nDDrAewQFQb0zJqc+XBMUtiu9KFO2Iktr?=
 =?us-ascii?Q?jQX/pl/b39qwJIAWZiBEtsT6j+q7oe5JRmS5hQwtf7bhpVnz1YcKQ8RA+P2q?=
 =?us-ascii?Q?o6Je9TSlioEeF+09uKixT7IBWN800FPdfooy3H09kxuGdkAhCWSItjxO7OVk?=
 =?us-ascii?Q?JO3awYuA4umWVJQTfCepchs8oOJ7e+Z/HNLVSX9nnEs7ubfP3P1/B5p06OZG?=
 =?us-ascii?Q?wF1pqcCqoLeMe7YPLWzwbMs+bPOOUzOvawhT4uA0iCcJH03CxSthX1spdWAx?=
 =?us-ascii?Q?bPNmX6Far5ZMKa2icA3f6jYuOOM75+HSroqF7/knflTerB2XHKJflKbeKTk+?=
 =?us-ascii?Q?jiOOtgRgSSfKLrmaNUjsAIs0J5Te8p5+vFtTXHKLVAEATRDYXTBzpIIyvyMn?=
 =?us-ascii?Q?UnWk1dKj+8yyCjySnCRY2U3p6sCzZxWkypQi8JCjslV6lVHZd0wDwWCZUI7w?=
 =?us-ascii?Q?hfB8pG6z8EuRNrL1ywFwjwUmQV8VeNLMII7CSKEVTcIiZ2dZXvBkOxsHV1hu?=
 =?us-ascii?Q?YV1ke/Y+7Ry8eqiXLGKPKIJAswuD9AM4pF+dDAvH0IJL1hHAU/odMFsbteAY?=
 =?us-ascii?Q?kAPO3RvYe0DDSF1J+6SNymcrKGPh4pwIhgGbv8trBIdfZSdRDBJgQC8LX2Z9?=
 =?us-ascii?Q?fPwPHTB5O+houZOTcNS/FOHgUiw23Z7a8fx/4D4oRs5t1OvcBYY0VmLMwN0r?=
 =?us-ascii?Q?bsCI1tacDkWXcNTUt7nPLlBwdL/iyz7COfJ69XpUUrudOfDqMXGFyNAuCrBi?=
 =?us-ascii?Q?l2lat7zkUmNi3Z4UuBSBDU1WG8scqywMnyIkaBmAI2abUpoMGc06CSaStucr?=
 =?us-ascii?Q?Lx6JmsAeSEvbQdHxvjV+5rrnVL25CObO0LrovauBYChA2GzyQ9MSvIT8A2M8?=
 =?us-ascii?Q?2JFiFCQrrJulqfo65sTxIdoW7Cy0L4HpNEKnd96LZ5keMbWIjuKfA2bWrvvA?=
 =?us-ascii?Q?NKnfJtHVO+GbV2U/rTOUArYdQfC7Y/6T7TOmIxIa9M/nPt0VIKIsSoRfz2Hq?=
 =?us-ascii?Q?FepKVsBTNzl3huWYb1f4FbDy6hokyu1HdzixS44cHmVuUUTbDaTxflawRzWS?=
 =?us-ascii?Q?egQ29ZoYhn1R2Sm+IizJhK4rk8PVHj3ExYKc9Gh1B0eE/W1APvzOomgKUked?=
 =?us-ascii?Q?6XaUcCy86e/1GB2ei8CXWqIFZMRQW8Fr6/urklix?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e947415-bcd5-4971-3a3d-08db006f3fd5
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 14:03:21.6459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7yw4TjD7Gx1kavNTSoWRlJJOg5v8SXdT4zZ+kAdox/Sbjlioramk0zi/3H7sVrz3Nye0F3CpgV1c9WcRFGhWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6754
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023 14:40:35 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> This allows us to use the unit type `()` when we have no object whose
> ownership must be managed but one implementing the `ForeignOwnable`
> trait is needed.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
>  rust/kernel/types.rs | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index e037c262f23e..8f80cffbff59 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -85,6 +85,19 @@ impl<T: 'static> ForeignOwnable for Box<T> {
>      }
>  }
>  
> +impl ForeignOwnable for () {
> +    type Borrowed<'a> = ();
> +
> +    fn into_foreign(self) -> *const core::ffi::c_void {
> +        // We use 1 to be different from a null pointer.
> +        1usize as _

this should really be `core::ptr::invalid(1)`. That's currently
unstable, but can be equivalently written as
`NonNull::<()>::dangling().as_ptr()`.

This has a different semantic meaning from `as` since it explicitly
suggests an invalid provenance and thus will not alias with other
pointers. (Although I don't think compiler currently can take advantage
of this fact yet)

> +    }
> +
> +    unsafe fn borrow<'a>(_: *const core::ffi::c_void) -> Self::Borrowed<'a> {}
> +
> +    unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
> +}
> +
>  /// Runs a cleanup function/closure when dropped.
>  ///
>  /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.

