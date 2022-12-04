Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC84641C54
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 11:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiLDKcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 05:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiLDKcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 05:32:00 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2100.outbound.protection.outlook.com [40.107.11.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44850D126;
        Sun,  4 Dec 2022 02:31:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cpmtb5+Itnjbt+oE8GwH12DgkO8pOma4GiCHWllT4t9y+RdgIqWaJaimYwT1m5tuhEpeR86uU85j9gb7VobXx7HwX4A1UW/+efxexHf/tCe7gW7wjW2tn3XIOl8x2hE9mB77bSyW+si7Rfj1+zuHQOjOkZvvgeaiDOA02IIi/7ttuTVMLk3m4pIbA5D3yW2rMNWQDOc51PlzVjY+KMzNc0ys+m4/leut0L4jJlaREwomFLLoQOK/DuPYqWSa+7Zce9Z28IiuuTaCKsiPKXppPTexI9baIjO/nRWBHfrlIiAHNh0VQXl4rvGAMR/ZvwkxOCCGBInj/gYOaXPuAA0uLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKfyXSpybqdZuWkp28uPFYT3NLDK6DSBWnbVRosxKcg=;
 b=Eq5xVQ4UHjqqDPsWF+qZU/muqNUVNJ68dkVaCcfGGYGOFcycr4QxWYSA7MR39dIveE7S2X+daDxFnoVJlVdVBQ955hL1+GtW5YQm50bOQim13K2/Q/pmysYSe78HQ5HXJUKehlsSE9yQqtXmKpL4w6NEQ7jUDkHZJ2uzEEGUQT+q6uDCP4wG2jW8Sl/xYmN3PDJbRQ1u+ntqNSTbLhKiXvfmvSf9VY87C+vaeAiDHxNaZFFehsaLP/ARhFBmcCd5gia8V3SLrn/irJEL6Wg+WYzF0h97xHlr27txAkUaAXtjTif09paC5Y1GhvLGt3V3u0Axllii6FErzOt2Ud1/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKfyXSpybqdZuWkp28uPFYT3NLDK6DSBWnbVRosxKcg=;
 b=eBfaT0S5eSEzt/Ly9iw9dLm5FU4RX8dbcjhnzmJQYpwQ1tNFW2GzkJh2QpBgbrJ7L1m4yaehtVFxixpvc2PXKNH1YLlAAwHMO3MYUsH8zhCPypkYE8dgZgYk1S77J10eL0j6fZnMyAmkN+YNxZtJrMAu/lFfniCbNHs+HcjoljA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5676.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Sun, 4 Dec
 2022 10:31:57 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7%5]) with mapi id 15.20.5880.013; Sun, 4 Dec 2022
 10:31:57 +0000
Date:   Sun, 4 Dec 2022 10:31:53 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     ojeda@kernel.org, Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2 27/28] rust: types: add `Either` type
Message-ID: <20221204103153.117675b1@GaryWorkstation>
In-Reply-To: <Y4qNR+Nn9utDftHq@localhost>
References: <20221202161502.385525-1-ojeda@kernel.org>
        <20221202161502.385525-28-ojeda@kernel.org>
        <Y4qNR+Nn9utDftHq@localhost>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0330.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::30) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 86198265-7bc3-4a02-afe8-08dad5e2c3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eO9NDYMN37HRYcjUSFmeTcIi14wpEY4UAyOA62pwby+bhdPAeDTsb6/oGqAg5apX90PphHX6XBr27FxOYNlaQRN1wtMzjeMTxxg0sCwVhss/oBB4DDYd5npMECCrofmBXMQ61L1Z9cTjoGVsM9oP/xvPpDcbzzX9pyBgG2CWJs2mzgZPJZ9vciZTj8VHFQlcIHgTALlFGFwJuSeYHPWaxfXDxVbgQX/a9cjIZO3TQE2O+jXn/lGggFX1+9/4LLkxZOq5FBKGbRWE/qEGY+4LiHoegqfiyQ4idSuSOM8EHBsmwMEkHiLoM/++9Ucg8aQ2y0h0XaapjZNfGL1EDtjAl8YjbaGA+W7y9mfRyB3V9PSc9k4/e+cbJG6n68CGQG+8T46HmnWtMIYi0YBAvycDUcLU6mSO4jtLOSKeE6P6xc29LNOW40kibBHAPsbjxCTa/Hm6B1bxQivD7/TDbfStDzN3QslWHSWrDv4Vmpf/BPC2ztlW3DURiNs8k/2w5e8zZ8oIxJ++n7EzN+B1WTeFUjMBtpqqC4Fb2tyf1CN/Upfa+iiosf+Rbqg1DaE/qVq2fFU6rY/NU6Gezjvvapjnfik0NXaGgUYHzKTY9Ur74mys/kicUbaQZwpurg+G/lYqgtFxCK8/8j1G9VuX+pRJxEi+xKB5d+flTBycYzWLmzPZ+6KJSKGMLSTbf0ijk1ZV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(376002)(39830400003)(136003)(346002)(396003)(451199015)(86362001)(6506007)(6486002)(478600001)(9686003)(33716001)(1076003)(186003)(38100700002)(8676002)(4326008)(5660300002)(7416002)(41300700001)(4744005)(6512007)(6666004)(66946007)(66556008)(316002)(54906003)(8936002)(66476007)(6916009)(2906002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JIlusyEbQQCFlpMsIl+rLIy/et+uQBlXI045JuYgW9LwiK1rQ4wG2LSPoWVO?=
 =?us-ascii?Q?E6btrKWcQY1E4Ya8/R0YpM+EabWJorLrduJoffnv5oRj0z1C0CGK1c2ZlIJt?=
 =?us-ascii?Q?xP3/Hu6Tm2ERTuTwtD6YILDeznblc6F+JUDCbKWHVcCC0elmbF2fOhW7oLnu?=
 =?us-ascii?Q?WQPv5Yg4zvJPROuCZzv+i96OI7sq3sFIHQUSlqptVLs+aWFI9+mUS1OlBEdL?=
 =?us-ascii?Q?dYhEDshwF/lAJ0LQcJPwpHLngfsu7LJWlHkZnJSUgkSwKqPNVpu6GauQ/Tyo?=
 =?us-ascii?Q?MLIkrHOLN9JoQAFiTPGw/oUg2h29yY7+gF8NrCV8QRZOHy7y5T1evt0SvCkW?=
 =?us-ascii?Q?i6gOtynIgkqrwyYZD1g79rn9guCuaYvGdSnmsaNllZiudxTynh9cttv09n4Y?=
 =?us-ascii?Q?0sj8a22zYXK6JIV29adyocZh6NdQYjyWkk2dw22xjkXftOcj1bkILpGvU4sW?=
 =?us-ascii?Q?JMubcfl8VWd3KSwbZeJcfLY2vh561OWUUYGn+jaBrqHheyiCx3affujQCMyl?=
 =?us-ascii?Q?V0RhnsCnnaFqhnLYjVYOG7EHE9qkiztmKTZdYMECwoXlSt7XqvFuW7EMwtwh?=
 =?us-ascii?Q?zV9SUOl54kNvnc/NQJgQ11g+Q0paSBUMya0e7S0gbg/tI6JD468EASmQmlFP?=
 =?us-ascii?Q?eBZOPe40IUl220tsFEJnbpDjOw2V9p7bwibf/OencT5PuMoy+7s2gxxN6u9m?=
 =?us-ascii?Q?1V5osXgCpVj4cxjiuqOwcbP9uEqIXqs5KTPO77SmJZz7WWbjZcs93tp6BZ/P?=
 =?us-ascii?Q?srlxXZSUKQ/8ldfc9UgKAAU/oquTp7bNghGd7vWNBOuhlnD3QO8Qm1KvfCa9?=
 =?us-ascii?Q?jXrlk6a2BsAZegWv6zrF0pfddHIMZXckhv7fFze5iRO+g7AqKWeun202JJDC?=
 =?us-ascii?Q?7BsY3B3C6gmbtPUlO+P7z9YP5nRK8NPJ7seeP0YTGFZlSnuUwspFjJ4b2aDO?=
 =?us-ascii?Q?abuH069LVUznUW/YtMYTb0y/31Pg7oGGkbrnqqwSom6V0p9WTHXAdtd2ispe?=
 =?us-ascii?Q?k/g2SaNa+Wi+lo1BPAQxYUO/syrLlmitANVV3d9NJBNhwerp39v1a/FCYKTd?=
 =?us-ascii?Q?V1D3fa4mg4MJWLNVZswIzDUAxGWN64gE6Ty5eRqO4qwErKFFiABPWAogDQ9P?=
 =?us-ascii?Q?tdpUq/S7t8yr4/7NMYjcvj1qlN6jQa+Fn6Ce5ElHIddKpG4qbJWtIpNQ+kbx?=
 =?us-ascii?Q?n7ugPeM/lXPyTJPQnrTvFQ7OeDXisVnQdcFKGrMVN60oKZkxHjEUBifwxHtj?=
 =?us-ascii?Q?cqJW2ZoqWeddDqcLBuK8HnmxjO7VLLMRbxqShecx3oMHN2FWAUtJSh+ASTA5?=
 =?us-ascii?Q?5x4V/T/+m7rPznQBkycgqme9E/D5eVjHv16L51WoxOYhkd8DaQSVrPGwIuZn?=
 =?us-ascii?Q?R8u0k8RJVk+bsu9Pb2J/jXKgW57Yyr+5cm/QXpcr3rQnSb83pml7vblbVGFl?=
 =?us-ascii?Q?V8BeDxZJADyBO+6ZF7NJ1GG9cw8mdn4Catp5KoVGfeLnsLGf9ehYR4P1MalT?=
 =?us-ascii?Q?ft6Uju2EvLhwXeuRvYmpDr/szKQRammxjhioxSL1ZyKNFG+chnpDwtFquugG?=
 =?us-ascii?Q?qcikxx5fZKspwwr3QDsY7DUNbDGLtPn4cw112n0aLIDvEnf5Knhs8pp6mJUn?=
 =?us-ascii?Q?QiuqRP22HY1Nz5zSet6An5g3ISzA8BJubBqKRBfPpaOG?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 86198265-7bc3-4a02-afe8-08dad5e2c3f3
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2022 10:31:57.1790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQVB6LL7rVtFvzeVJbcXnNvEIcoAK9PmmGyXH8QuEpybx48zqufA2Bnpj4v6qC3fNO5NWCFSCwRTK7HtvDhYbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5676
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022 15:41:59 -0800
Josh Triplett <josh@joshtriplett.org> wrote:

> On Fri, Dec 02, 2022 at 05:14:58PM +0100, ojeda@kernel.org wrote:
> > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> > 
> > Introduce the new `types` module of the `kernel` crate with
> > `Either` as its first type.
> > 
> > `Either<L, R>` is a sum type that always holds either a value
> > of type `L` (`Left` variant) or `R` (`Right` variant).
> > 
> > For instance:
> > 
> >     struct Executor {
> >         queue: Either<BoxedQueue, &'static Queue>,
> >     }  
> 
> This specific example seems like it would be better served by the
> existing `Cow` type.

We use `no_global_oom_handling`, which gates most `ToOwned`
implementations (e.g. `str` cannot implement `to_owned()` because it
cannot guarantee allocation success).

So the Rust `Cow` is pretty much useless in the kernel.

Best,
Gary
