Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0402468E746
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 05:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjBHE5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 23:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBHE5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 23:57:49 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2127.outbound.protection.outlook.com [40.107.20.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EBF42BD6;
        Tue,  7 Feb 2023 20:57:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTs9oPFp99IN+2uEyjSzLDivxbhcwGoUnROu2dJa/LMuIReYwr/er5IRMC2hSk1iEuKIspi0BGIRZO3Ge4WmLNX92OwX6Y0e+oEReUedziLH+et9pRsAYXqiCslc97LEGoluKmlShbY6vthQvjA29M97BZ+enk/TS3Sj30jw89N+5iQCtkM5IgB4x+1t9RtdBnozaXexs/A8iETg5RnkUAVa9g/D40bIcq/o+dhC5ftjE9GTdqrvEYBsSeTVSYxSFvLbqlP40d9B8mh+NyzWSrqd1q4f3DgVQcKZtq9DYPLKSoLLFy8fzFnSksVTNH2UbBU9R+PmeTDjRiMB7/+IwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTh7MloyGcfEnbmAA90TWRBbqgZuCia56dY3jhiFq+A=;
 b=m9DdToIzzf3AEjEfH+y23KiFC6/f8/4XLpjT+5I8WljQgI+M4V+g8mLd6jNrKvByAqZq6ASbyZOalXQBTRpi1BhWp/8IICQVXxO47nZti8bc8WZLoQw9HUKUqZh7N1e+97P7JyDkxWzVzvfnK8kqSynW5vybMvSQafx/mGLotCN/iHujKx8nQou9qZJHUpvRNrNs85GVUA2XukSMx6T54qrtQ+KqiWSeaWRof9YBYl4bNXpfMtT5JDXOGTiGuK9tRHZzjySKNNRJOrMfvI1D+IQ4xFKkmyptIyKJlBGwPFfUcvUaaqRo/OE2BbQiewDy05aJPebVp98afvHtx/NJJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTh7MloyGcfEnbmAA90TWRBbqgZuCia56dY3jhiFq+A=;
 b=dxjvyXXn7Q4SapLDi4nC/wDawT+3LYYFRroJQ9jET8V1lK86NzJloZs3MfHWitlsebQz6yfV9ptXtOYYnoT6AoR+d2KdynNvzIIhI46I9eCphbaMnw0uNjig2IPhEnSRUE2jRGcglMzodB1j2Cqs/7xZ4J4JT1LvhKR4A2boZmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB7287.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:30d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 04:57:45 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145%9]) with mapi id 15.20.6064.036; Wed, 8 Feb 2023
 04:57:45 +0000
Date:   Wed, 8 Feb 2023 04:57:42 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergio =?UTF-8?B?R29uesOhbGV6?= Collado 
        <sergio.collado@gmail.com>, Finn Behrens <fin@nyantec.com>
Subject: Re: [PATCH v2 1/2] rust: sync: impl {Debug,Display} for
 {Unique,}Arc
Message-ID: <20230208045742.6b07ea09.gary@garyguo.net>
In-Reply-To: <20230207185216.1314638-2-boqun.feng@gmail.com>
References: <20230207185216.1314638-1-boqun.feng@gmail.com>
        <20230207185216.1314638-2-boqun.feng@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0002.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 80247381-e4a5-40d8-e2b0-08db09910477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJXHF9X2rWG2WyOWvA5+L2KV31fPYf/7/ym/0SiKGdRGtrPbff6MiHqMJ+O8Y4CizBvKLNF7nIQgCLjvnTGAizMiQAMjiwJu7xET1tzegBvzbCJcvZl9PGQIdtr6+D944A74247No9fKIMueBE4d8/z9phTk9lEURE5H+OEyKXQQwPZdEHSGdApj7DOYY2IPW9pUVz55wvzCQB8cKDqdGOgpChMN1BwVuSX282cr1QlFvBL2SWX5A6DcwSubnAnUfq+pg+J0pyb/Yxtady0oWub0vk9/Six/uF+zOyFIH7FL6upR4Gp0QajUZsO2oNML3vMrUHxRuxRq1Fo3bwGqNg44W+Ee8H49IiE1/CdEbiNLfEsp5cinUokN1SAjfDLRyrb1PRWPJt0zzNlXj6d3Ye5SPv5Blij5ZGV2s0OxCmLg2BYptivkUzom3aoZHmnGvTM3QFX53ebnx9Rv1cwRKFlQGIdCMZsz7KtwCwiSFCJ01evNUOsT2ya39iAB3Ejap0/t4eyCxkZxTa/BfXLct0LAXeeUaOfqTjd15IbE4GN+547wRl4rYJCRDWMydaaDDpZqYtRt4Ifbo3t4Dhj4lsI9UUPKt9Wx47XNAMsxyXk75Luln/71BF+F9stZTJwTqt+Fz0oFDCVG16/KeAEkAQdMCKvj0hhL2Tvz3hZGod9HdUM/prynfR5gJ9xJXv09
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(39830400003)(396003)(136003)(346002)(451199018)(7416002)(8936002)(5660300002)(2616005)(66556008)(6486002)(66476007)(66946007)(6916009)(8676002)(4326008)(38100700002)(478600001)(86362001)(41300700001)(54906003)(2906002)(316002)(36756003)(6512007)(26005)(186003)(1076003)(6506007)(6666004)(222643001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7oWXbnItb66jt5STqe7yprAcvj/tz2jfh8LMyVOuqTz2uh8TgnNLsqsrSw9F?=
 =?us-ascii?Q?nsDnj4SLVMWhw4U69B3b/HqOGVf7NIfghp3/WWxkmhvkq/8tOGGvF2eBTTVi?=
 =?us-ascii?Q?TnpAuG3CdhGAQ6DeNyfTqjjHeiWd6bMYqRP+d3lFgTrltFSpH5CDMdSjR9VF?=
 =?us-ascii?Q?RERj0Qfy41WQcF5EZM0hREdd9CzTSgF2BnZ+3fec8kH1QKsWAg8uj2uZgQGY?=
 =?us-ascii?Q?2Lt4zJq3gFkt/We+rZpbgpMNKX8o+X2SAFqUj67M7F0PuBF5OUJYsrNS3V/p?=
 =?us-ascii?Q?tlQmqRTAq8scgPLiUoN4HCkMo//NsNRwEFKVKdarWAX41vHDHr/y5dZMgDXQ?=
 =?us-ascii?Q?z/ZgiJ1fRrKGCkPDphDsN4nj/G6fFuKIBLWvXu4bK4MOE0a9yHpIRvG2X4sM?=
 =?us-ascii?Q?u3QgKscafu1cdrA9Oxh2ZfSpqm9uJ2TIbQ1shYDD0mfgOQFClBL63nq17s12?=
 =?us-ascii?Q?p20H8vcDiqty+HGZZuDy5LXJsamogMXHQC/KYKRpGS14ndeFa9YaIC7pBoje?=
 =?us-ascii?Q?2QhlRt6L7/1Am15Zi1wuULmTIUYjsgXy/VyfpiuBxGZESanG6rJSJ8RRrFYM?=
 =?us-ascii?Q?lyMeNwttj8DLIhc3Z5Hr0pu7B6rN3kZXmcAA0G03wpifdt8Sw3aSODAfPz8M?=
 =?us-ascii?Q?wiaKw77V4lKdNvP5JVBpFgK2//IvryPhiX1v7aQLW/Pj4FM4ooXv7ygA+3gC?=
 =?us-ascii?Q?TvIWheWs5lJ+itejK75aG2qjjF+hkqNhcX0d/EQMI7+ar0s8LMLfkPekZiLz?=
 =?us-ascii?Q?Qdu2Wh7lZpFxDeH0BiRYWUz7oyVtbmPlQ/EFGzhiPnptrDBpg8191eWJ/1vq?=
 =?us-ascii?Q?0fsjXha5VjWdMJ2nB9tJFBVIFSmxPhPirtzUadMniiBJSyGgHkr61rusR9k0?=
 =?us-ascii?Q?QT7nI9oJYybD5idrVuwZbrO3MBSrW5bWFxjZB20Cov7GYHlYtVnvXUHJYoy5?=
 =?us-ascii?Q?18DfOXxwP48qakL+pyJVDJ+zuFl7W2y6Nxdr8/cJnh8XZaFuRP2RDqWb+Ohh?=
 =?us-ascii?Q?nCzAKozw0XG9zyQnF1zSsysrlkrUe4oIWgz16t1AqQ2A5QTMX4p0qgA+MpXI?=
 =?us-ascii?Q?qjV0esvLHn6hnrE59MxjmS8E2z6SyrdKQB8QKt7pXm/N9hXv+6iF+uGvLZA+?=
 =?us-ascii?Q?220c+ItxDssceW9T6sqgS48My/cI2AnXQ2vd4OL5bUxziHGqvN7PvNUSlrcY?=
 =?us-ascii?Q?gayCPFaIgP6fryCYpOKQ3/F4QWXoLMCQEAD5cgy/XiKU4WHfQfA11yRz7TuZ?=
 =?us-ascii?Q?bwHj8Tx8PMv4/HvwK7Ow8ubuF7BbjEfLPJZasPnO+mAtNJHVkXzVu+Mt62t1?=
 =?us-ascii?Q?8MBpvxJ2OUUjiPeLvq0L0OoVNbFbulZVhOON8xWZt1YEKUa8TE0B+be+S/9j?=
 =?us-ascii?Q?QXhS8/U4h9jB3ccA1WuGhwp/CR25pzWB4w3AxInYfeShqXL9VAlOeTbvR9ld?=
 =?us-ascii?Q?GTajDZPuOyJ4k7Kc6JT2KZg2/OzZ3kxft/9iHg3eiCEvmdhqp1NCu5ZZIMYl?=
 =?us-ascii?Q?/EMCx3qjCjUpwcSuaM2yqkwX2cjbIHz5bP1c48GnX1lWvmI2xbTjHLVMJRpW?=
 =?us-ascii?Q?mrROdp8l7tYcg64QRfM1m+bcGV9TTzifqD/QLj67?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 80247381-e4a5-40d8-e2b0-08db09910477
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 04:57:45.4492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apE2vGPOg3eWjjD0T0QK3MIpApVKfhdjfroG44EbjuE1HyGTXpbij+OIJB0w+fvFccizU1LWzFIRU2Fq1OIQ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7287
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Feb 2023 10:52:15 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> This allows printing the inner data of `Arc` and its friends if the
> inner data implements `Display` or `Debug`. It's useful for logging and
> debugging purpose.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Reviwed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/arc.rs | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 519a6ec43644..e6176d9b5b29 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -22,6 +22,7 @@ use crate::{
>  };
>  use alloc::boxed::Box;
>  use core::{
> +    fmt,
>      marker::{PhantomData, Unsize},
>      mem::{ManuallyDrop, MaybeUninit},
>      ops::{Deref, DerefMut},
> @@ -522,3 +523,27 @@ impl<T: ?Sized> DerefMut for UniqueArc<T> {
>          unsafe { &mut self.inner.ptr.as_mut().data }
>      }
>  }
> +
> +impl<T: fmt::Display + ?Sized> fmt::Display for UniqueArc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Display::fmt(self.deref(), f)
> +    }
> +}
> +
> +impl<T: fmt::Display + ?Sized> fmt::Display for Arc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Display::fmt(self.deref(), f)
> +    }
> +}
> +
> +impl<T: fmt::Debug + ?Sized> fmt::Debug for UniqueArc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Debug::fmt(self.deref(), f)
> +    }
> +}
> +
> +impl<T: fmt::Debug + ?Sized> fmt::Debug for Arc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Debug::fmt(self.deref(), f)
> +    }
> +}

