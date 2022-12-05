Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C466436FE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbiLEVlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiLEVlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:41:00 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2110.outbound.protection.outlook.com [40.107.11.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA18427CF0;
        Mon,  5 Dec 2022 13:40:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+U4Wd6rqmOxcVaN/7/7MmedKL3+mD6gq2mKdLyGTJUYaLQ4dtjTeceA6ika5hKthF7yaku2nlbjeRXZzuxssGs5nxlmUSeYYdpqJvBUqjkk0VSw1xrQOYgoHM8KDM/yWfwd9ZF6SMmCTeIq/v8MnFzR/HGB0QhH1BzYFuJbiHh5qXZKr5w1AAh+H8zLGdeEV8c4H5fluliJaUEcGSxiXeWGodWRktEhl9Mw2hJ9NE77auc2/TI5guiwkWZtSNVMhX11X1qBquEp7fZDBqv0BdQOOJQ9SF6crg4kB9CFybbwhZJTWpL6f/LklNcf7soRC18fOK9U3zvd075BzobZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CjGArSU0e+WBDgbLCunC+OVVGPygmVQcBeYPUHZnwI=;
 b=J5p5rwM9bnhk2IYzCypTrkIaJ5/iB0QmfAk1WONh/izmYXgg8jXs+FuiEm9omtMXZYUdgnfUpsiDVYcYrpYq1+cqYYax99/3a0PzJSW1sesuppKUnGmnrp4RDiPDWsvSbyohyuvLB/j6GF6waaQkcunL7ZWYSyi88KCUqT+vxwmzdeyame4JQe0Pi8fom7w2gR0vIDnkpJn6h+nO4WHWb7yXodCANjkBB9HTEwoLsn1KAGbshi6z4COONuVNaW/BHAlCf9E3juUsCaDqenKW1rPKidbh/vmfqK1hWnFWpSbJAJzJzlBrFjsPsKMR3Ww3nO8+vrfXFG6JzuIZykTWWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CjGArSU0e+WBDgbLCunC+OVVGPygmVQcBeYPUHZnwI=;
 b=UvDnD73RrMYYhdAulpiLldaQIBeZ5wmU25ktzoD1I1WFUNonXTUnha/iaDDrjl5SN9JVIOJBZGvMEEMmdhbku11IyU0+cqr12SvwuDMLN+QTEGynCAHCXQ6a7ZhoS4plpKt4JmosNvUxl6mU7TR846Tfp7W9kQcFfnNWRadzXwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB5179.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:194::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 21:40:56 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7%6]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 21:40:56 +0000
Date:   Mon, 5 Dec 2022 21:40:54 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: make compiler-builtin stubs non-global
Message-ID: <20221205214054.6b9e6a7e@GaryWorkstation>
In-Reply-To: <CANiq72mXQed42DARuOjEipUffNxx97LRL+byZ0G2kjuRup6ZYQ@mail.gmail.com>
References: <20221204231650.2604587-1-gary@garyguo.net>
        <CANiq72mXQed42DARuOjEipUffNxx97LRL+byZ0G2kjuRup6ZYQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0050.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::14) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a1074e-fc91-42c1-0ddc-08dad7096447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZKbGOo6tuX7bA7tNXoDdxLyh1y5Ay9k2MP6nacMrQVM9TuE9/EuABOFosh5WbIgWKKHQ+PAvTfI9J/R3zWxjuLg1WlxIEK6ciHlBT+YOxIH+DWijTsnt/RCPblSLhN0Tpx/1HWTW4a5hBsMErLeIQqC1gdL71Gc5ELMZB3tmRVIqqKC3q4jYlXndbFmduI2xvSJbGraaxwav69AMHy4N5v1YDWcFQtBv2HV2XGT2v6y6HrbLTvxgLgKrUbBXjhJ83g1kWr1lOAj0Zf+10fQavN3+sD20hZLCw0Y9xWcYA38jIx6dgf83A4Ue5rj0Y8jaPdGbXo2upsyCaTBIzGgl5XOp9VbBgb2yUmV9YiAxQqwyvHpNmnFiK3qBCnfpeLmPy8tRyJrLKaOOrnSwrPYGaBYsFSSyFGczhzw9wb+zOrzSgFkbd3uyQjwDFWRpgMX4GMUebT13hWf3ZQkohk3not8l0xauZN8lBAeub4neGc0yeHQHw0VlnlL/0Wkl3EkVmNvQ1IYLi0Ay+bTgJXTmmqH/6wFiUHQryV3/uXpWGMPBLKtCIVUP52Igizq74MM0CpTTjmlEigYSKMF9Nbgda9hn+AoS/cX8CaRSUZBOCKIOd8PxkMQIzsv0eEcYoA/cwdukmH8hPd+hoayARo4w2bcZ9gab5OZLKkr12dnYEjb/87V2XeICWxZqIv+8tIhb6iwpBevhknUBbg8SFJ36A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(346002)(366004)(39830400003)(136003)(451199015)(86362001)(4326008)(2906002)(66476007)(66946007)(8936002)(8676002)(41300700001)(66556008)(38100700002)(83380400001)(478600001)(54906003)(1076003)(316002)(6916009)(966005)(6486002)(5660300002)(33716001)(186003)(53546011)(6512007)(9686003)(6506007)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t2t0SHLTvsACUsJ+NcK58FeqrGOu2fTCeRHZepN9VGSfX0JkdpNotyPo3N3x?=
 =?us-ascii?Q?SnyJBLUE/aI3Q+rLhI0bR91pOV8kdtsTCWNV5LqNzsZKm/q1iL8qIp2AW+sc?=
 =?us-ascii?Q?aLVTclQgy4GEscr6TJ/jF0zhak9NSPgx2XTWvi+53C+5UrRTf59BwqqtY0fj?=
 =?us-ascii?Q?H8TI5MRRAt3FyyxfMB0RC6BoVrcsgbLQzEFRNTX7o8Y/dRqToISAsUXuraLP?=
 =?us-ascii?Q?kod4ZXd1/J3a5lpq+VbhigmxlwiVhD/lfwoud/iUZBm1ilzWCIQhfQyUSohX?=
 =?us-ascii?Q?JCw47RMNKgYw+uDaBx0XAwDLqyhI/PR0t83Pfjj+1a1FYzxFcYN/KBO0qq2L?=
 =?us-ascii?Q?UZwAqMlKtaddpTKjhRMIoIQ9QHRSvzAjU1H+mvlWEAAYymbx3cJKIlRAmlzw?=
 =?us-ascii?Q?htnUDrnk8g+Va9GqMBAQM8RyNu0i48eB27nOL2cB212waEBugTlRPtepf2WS?=
 =?us-ascii?Q?71xeiG5v14EpOrtgenA2KBFZkS7BXIXRiEg05rCGeyEsVhHB1xm9pPsYWojw?=
 =?us-ascii?Q?PqnB+L0YtF8XdnXsaXc1n9/KXQdB/A02dyy+Oz+7dCvwA6cFJwxNxb67nkEb?=
 =?us-ascii?Q?ZULRKzxBNVjhB3+UnaEZu0t1tpR7soQf7k/4i4MVz9TJNzvKIBJb2TFvHYu7?=
 =?us-ascii?Q?R5OD6kG17CtukzMWsLmAL7PTJR0HrXDBzRenxDY6ZdOkVrwdSfmoU50qyB2k?=
 =?us-ascii?Q?FtkpjP+qNi+xSwSU/u4vFJx6E/2jAhAndOBDIEUUWC9QAQVdZaYlpk6e6q8o?=
 =?us-ascii?Q?ekU80pbs05RNWCzTiv3udQWlDv+4os7X+DTlSlqqnq1xCQzaMDxZQZ9QVOMv?=
 =?us-ascii?Q?dfKg3o2QldxkSC6mYMTXVaLjN95P9a6GwJNbuc0c5uneQHhHvblG/tOL5xxV?=
 =?us-ascii?Q?j8M7hmACBhqe2/tTdAsyFqqKjK3ZdOaLfSVbqnmSYOqKgI8d4jtl5VK/3NkI?=
 =?us-ascii?Q?lHaWnYojdrCIm+NL+E63DrugmqqjcPSSiV/IhIEdDQ09Fnxn5rc5UGBxi8MA?=
 =?us-ascii?Q?vd3cccpvpe5xLtRpj1HW9m6fMfBu3k5IhResFoxxQsh/B0+Z1EHR6LO1ebpw?=
 =?us-ascii?Q?DfRqDzwFDEA4QVW+aNXDbyRijyS9GtzyZRV4waCWzdFNmNvy1kUhgYx83ZzH?=
 =?us-ascii?Q?cQ6JFlH33ozOiZNFpZR1/F36D4bzfE+NpIDk2nw9eGLuLvWxhMXMe1c1j+Ce?=
 =?us-ascii?Q?ftZj/JvQM2dwt1mJ91vff4uxYR6+lykpVELAkxgFwbHjeQmOCHe7/nrWZcHH?=
 =?us-ascii?Q?RHGDZQ5YrmS8MqpXBAWEd+OUKUaWsLnE4CgwIeR65eHuD+7S/TXheF+4X36l?=
 =?us-ascii?Q?ksT6RPPd7UufAos+Xqw3OFBWPTDIusb8UP7sTFP/AJV6PqWJO1lex5gT+h2f?=
 =?us-ascii?Q?aam/wyIcnYEpCV3ikEZxlZeqcsecuca09DPy+uG87UDFbPWVFxbVpKzSVnjd?=
 =?us-ascii?Q?yY/blDwuKfUOK3a76SsCMWjrZ+nsNZd1KCSFxRGfmdg3C9CHunWV8NVcY8HQ?=
 =?us-ascii?Q?x5RM6U/4r1c7sK3Fgtjlv1tNz7+SZBy401xWCpVL4rSyFFAFkF5Ks/Z9wh4x?=
 =?us-ascii?Q?m8Z3xy4zLeBEcOE3NkL8RgFsD+m4lJFTw30p4iMmCLE6sy729z+ZiC6/+FKb?=
 =?us-ascii?Q?sR0n4ncS9SnDC5geYJ5oVweJIMHzeQtzCMk7G7B7odB6?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a1074e-fc91-42c1-0ddc-08dad7096447
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 21:40:56.4808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXPQnrKset6SMBGpEWs6Ff7F2sP3l4i7v3oDnS1OoKBvjKvEaOCoFMtELYQW8EvJ0Rr+QKTHg+655s5yrrsNFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5179
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 21:26:27 +0100
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Mon, Dec 5, 2022 at 12:17 AM Gary Guo <gary@garyguo.net> wrote:
> >
> > This patch was previous discussed on GitHub.  
> 
> previous -> previously
> 
> > Link: https://github.com/Rust-for-Linux/linux/pull/779
> >
> > Signed-off-by: Gary Guo <gary@garyguo.net>  
> 
> Hmm... Something happened to the patch (compared to v1): the triple
> dashes, the diffstat, the base-commit etc. are not there. It can still
> be applied, so no worries, but it feels a bit strange.

Checked my bash history, and realised that there is a mistakenly added
`p` in my argument to `git format-patch` :)

> 
> The newline between the tags should not be there. Instead, please put
> it on top of `Link:` to keep tags separated (if you wanted to keep it
> close to the sentence to refer to it, you can use "[1]" instead and
> then "Link: https... [1]" in the tag).
> 
> > +// NOTE: if you are adding a new intrinsic is added here, you should also add it to
> > +// `redirect-intrinsics` in `rust/Makefile`.  
> 
> "is added" -> "". Also, what about putting the message at the top
> instead (below the docs or perhaps after the macro but before the
> calls to it)?

People usually add new things to the bottom, and that's my rationale
for adding the note there.

> 
> For the title of the patch, in the end I went with "rust: xxx: ..."
> (where xxx is typically the name of the crate or the `kernel` crate
> module), so perhaps "rust: compiler_builtins: make stubs non-global"
> or similar?

Will address, along with other suggestions, in v3.

Best,
Gary

