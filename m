Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC98465A683
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 20:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbiLaTwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 14:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiLaTwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 14:52:02 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2133.outbound.protection.outlook.com [40.107.11.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004DE6243;
        Sat, 31 Dec 2022 11:51:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwSpr3hOm00Pcr7lqJDrgq39N0Z7ys9jMbFSytycUObwwhXADUsg5AVIBYxidBTfcfLzgHXrwC2+iG7j+g63GmItRo6FwOFmv1Lo1u/+xyYbGmvHMw0vLoYTs9ZOva6XChw821vhrQn8RO2wzkvXPXRJSSDEp5zYsrdkUZ5IZbnY8dEQd9L+o56LVrHJSpPrJMPMhELDSdslGSl/gvB1RP1ID4r/6XzY5H2jLY58W9HKdcQ7m4ZBgtTXT7JduLQQbKnhHZ3HqqU26dC+32DzPiki3yl51FWfDKPnaRNjN1HjAgd+hAI8tlGUTjkBZWYOqkxzwydgibe9lUiPtf+tPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThYozytz0cDFgn19z57Ox8jA1iL7SmGuCKF2SAvVJgw=;
 b=dH0eYJfndX6AxdqtQdKmDFNhqxKFM5SlLf5Bu8kmgdimqkR6E1mb8pKWVtDOs26n4g0vVpTjOITO2vjlkypH6OgK4yRrUTKP8wr2Y3Vmt4xNcDFa41VF5Fi5hcmY/yAcps2iv4Fa/icgttFwEW29IULnaUFZe06mS41kXdkvH++zWTgcVTjU6VnX1L+Wp0Of7Eh6mgLLufnw0RfgWNU2AtX55JyyUpHy4jnQyLK4RSBIJS2eFJ6jJyPpQSATR6cxIY+/wFIfBdE3jTU+3uEnBWwNXqsylPDYyOYwG6WpBMXNi7pvmWlhAseVjRz169ZW6dqEvNLqckdx0QIt5rVoiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThYozytz0cDFgn19z57Ox8jA1iL7SmGuCKF2SAvVJgw=;
 b=qw+tzR7abtvuJ30APOfabb08eNKTRpcYKeyvtP9fxZrFyFyVaYEnzMiHKTxF6AX/pTlw518K3fLIBcrNYRT+UJnuM707oHaFt99s8jhSADaUv2WwGAgnSagdU2ySxJrUI9wqOF6DWr2sc7WNgMD+rPxInSjPMwgtHZwOv3NRaHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5403.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Sat, 31 Dec
 2022 19:51:56 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8%8]) with mapi id 15.20.5944.018; Sat, 31 Dec 2022
 19:51:55 +0000
Date:   Sat, 31 Dec 2022 19:51:54 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Laine Taffin Altman <alexanderaltman@me.com>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] rust: sync: add support for dispatching on Arc and
 ArcBorrow.
Message-ID: <20221231195154.24c07869.gary@garyguo.net>
In-Reply-To: <D0EB09C0-A9F6-4AB3-B9A2-98ACDAA25DAD@me.com>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
        <20221228060346.352362-7-wedsonaf@gmail.com>
        <D0EB09C0-A9F6-4AB3-B9A2-98ACDAA25DAD@me.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0049.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::12) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f317a50-6a4c-4c1c-5770-08daeb68788b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3R3/g4uGavVd+fSI1TZiQacItJ7BOf0LjBTM2U4KBeAOI8uvrhGtU2KVikOJnVvBAHe7bCngWd86UQfV9s+2dNSEKJRPFLJew6zOHg5j/VF1AeUXsytYqzIr3qfVpVuEF6DeXuYUJ377xXzKzWRDvcojA/Jge9z1w2d/fpDsg0nL/OzZL4BAwkXL99rbq0c0CkyRrw4mGTAYcSn4jupia6MyXcUwctAxMWJWoxCJlMSYwxSLtUN53zIiKiAxuwD5vFtl+QKBv0W2FvoKR154wGfDU9b4zJao9XuwkVqL1N2x1A91Lu1tnK54OtONoSgGkVA4NXfLzenWcbl+gCf05g8gCBSfy8Iv/qmGRdIKUqT1c+nAMHHa/4h9kvX492B9aDbd03H7+s49IJg85xx9Kmk1S50k90ctIZahcdVbwWgqIJVqSJnQq8Xxs7J+s7cjzpBiJ/1PmPEcRBpK/LJ/dRQgI369T3eZO48SckDfa5UG/FyoEJtDZuxTp1il6pCmbOCIB05u6CXA70YSBJ4o30GZbsln6QegmbeuhAyjnj7zYfoIz+ASLxJ8uP1wBAVf13BnlzHs44OxBF23iZUW7hmWHgNJWWhegVJQByawtAu1yn6srqfTF/XRK3wJd+cfe4HArGroJh+jUWNFiw1YeOS8BmoTBoGdTxVEOUZBxxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(376002)(346002)(396003)(136003)(366004)(451199015)(36756003)(86362001)(186003)(6916009)(316002)(54906003)(478600001)(6486002)(5660300002)(2906002)(4326008)(8676002)(66556008)(66946007)(8936002)(66476007)(41300700001)(4744005)(38100700002)(6506007)(55236004)(6512007)(26005)(1076003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1+Pt30j/jrx0mKYdM1z+Wq/1S3dXZC7oV0q+XIllThe6a3Fvols7s+XYT+5m?=
 =?us-ascii?Q?tNhF3wD/S1r1lYFxvYIRLVgJfJwpehXXL2XPqHRFHLtZsFP9MrfHyZFO4OKL?=
 =?us-ascii?Q?Fc7TDD6oJ8ZzSyOd00KSYvyDbV9slPeYb8AHzwWNl9VEU7BxdcUO9NzEl4E1?=
 =?us-ascii?Q?j1ajr6lu4P/SiNBoTk2eBgfdQYq03lcqaceu7/Butd+6nJtK4hY4dH9fP21o?=
 =?us-ascii?Q?tQoL31+h898M20fQJYX9Y+hvfTsL1G0VpeViOj+Se+wuuSetcQhPDMKUmNbI?=
 =?us-ascii?Q?rwVlemU17vzJFjxEw8iQpVWux+cVb4il+R+In7ZoR1++4z/gLpLZeGwoHEoJ?=
 =?us-ascii?Q?z234A0PWAftw11i5JVwjFNMbQc9REM+Ah7EQjk49gz2AkFfhULA0XTb9qf57?=
 =?us-ascii?Q?8GlI6/uiMfU8MYBVV3rKSC9Yf9RvkLYF2UzoMvP+KTqvjGhBuhtS+NWKQlbi?=
 =?us-ascii?Q?Mm7QlBs6oL4AM40brcEBiD8T+4VeC6qWRjgY4LmosQKhrHqjPkybBSuiNsWf?=
 =?us-ascii?Q?knx6VrMcLiMnknFyRTc5n+Mo9XjaOMycPpuFVgLLTrOag2fxK5mI5pdCZEkr?=
 =?us-ascii?Q?0ZR0ndmFiP/dCOA1P/I2Mq/xgHVyox/HqCbx2v9eGdoBi0Jf2dEmhJocZ5dl?=
 =?us-ascii?Q?iMge8UFUXzTMaQzAPnCIY5QCjDeUfuaJRmHJgE1eR0HEKyThG4bs6HEx8lPJ?=
 =?us-ascii?Q?p3WJW1P9P8OvYIPkpAqlbMmeCLGLbZkBTs83SaOWbnoKEBcRfO5OV3asUTrI?=
 =?us-ascii?Q?MSiKcBqH38tVUFijQmW9fwAp1rIwY1N6F25VUCyCfCDLI0oy26Bv0Es/Fuv8?=
 =?us-ascii?Q?NXSbbvWgqnvgQeiF0y1sjpmwgO7y/sntZAn47WQzzsLPbDYADyfTEIHBFGri?=
 =?us-ascii?Q?p+3vo7UhDbRriv4k++05tES++QYam2hWuPtX/npi4/az4kXp2DqGI+T3HJC1?=
 =?us-ascii?Q?WBm7TuMFVpmZVtzY/XKQ8/M8qxXLdDJPooqJirvrJeW9KiBVvZ7U7P539oWJ?=
 =?us-ascii?Q?6XBDOvNJZDPqhAP25y262G7IeASmnkXwiAc4JHruWDO8PV78bkUC1BHAdMc7?=
 =?us-ascii?Q?swgFW0KPjJkBFRZcVu4lbAD/Z+5KKq1mZxe1rPiaL4dx2GQAR9/Qk+KJZU0u?=
 =?us-ascii?Q?+bPfR/XYxKr3HM50mmLlEueu3xskl9wJNkCeLlLczCr6TbkGLaz9VZU5fa9z?=
 =?us-ascii?Q?sz4dVn0TvLB7ljgA/+qRHyqBJfnh25v4C/8bbhyUm1HkytioonTXDOimEKLS?=
 =?us-ascii?Q?WhDYJmNQwQXh+plrwdSlyQ1PGeQhyHm13zljhhxio5d6A2z7pG6y7fk5NpXG?=
 =?us-ascii?Q?ogvcxA8JRyNgVrbcxDYsHtYdKBVDK6yJBB2AV6QayEvMUUpMbJhgCvhHhq/L?=
 =?us-ascii?Q?06jmDbwRGwjjMaVK7XItr4VlykpKso+HQViCElf/6kKdes7R2RetXAtGNKJt?=
 =?us-ascii?Q?OnndVWwl9fC+zbxlTvh4aS48hS+LUaJLxxYxMVLxO+ayFU9VuB7ZMhfBDyfk?=
 =?us-ascii?Q?5DZ/eXuVnRY3byfg+tCdbakyEhPALg+XdyWY5hTc/yRTalUoCEaqbcNTQOoa?=
 =?us-ascii?Q?n9VhSyMPtP51ETJ6a0k=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f317a50-6a4c-4c1c-5770-08daeb68788b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2022 19:51:55.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aik1dM82xqUvMjxD6McFYxKKlHVDlYBGLmxMVAqTgHZ7UcQxE25Dg9KrWGE66A2nCpIP+v6V8KrSUtWJbdDiPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5403
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2022 23:24:37 -0800
Laine Taffin Altman <alexanderaltman@me.com> wrote:

> > +// This is to allow `ArcBorrow<U>` to be dispatched on when `ArcBorrow<T>` can be coerced into
> > +// `ArcBorrow<U>`.
> > +impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<ArcBorrow<'_, U>>
> > +    for ArcBorrow<'_, T>  
> 
> These lifetimes need to be tied together, I think.
> `impl<'a, T: ?Sized + Unsize<U> + 'a, U: ?Sized + 'a> core::ops::DispatchFromDyn<ArcBorrow<'a, U>> for ArcBorrow<'a, T>`

I don't think this is necessary, libcore has the following code
(https://doc.rust-lang.org/stable/src/core/ops/unsize.rs.html#123):

impl<'a, T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<&'a U> for &'a T {}

which should be equivalent to Wedson's lifetime elided version.

Best,
Gary
