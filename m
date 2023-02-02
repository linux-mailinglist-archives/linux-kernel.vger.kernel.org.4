Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642E7687FB1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjBBOPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjBBOPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:15:05 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2120.outbound.protection.outlook.com [40.107.20.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BD9B44C;
        Thu,  2 Feb 2023 06:15:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTwmeNVxcRuyeWBzkOWEkPP1uFqMiRUEYX//PBYal7EA7nSXk4JKGHMEzrXHVLQj8vcdOLAeHREjm2gqmZkyn9hSJgvYh/kcZPsdzEsu47rDVfU/t8c4nPPetrqVUhfhtsE87mFd68LIZlY+iPMr3YnRIzticXytGhQ6wsyo4mrmLVQr+zMq6CmpH2PljHnaeves3MByh1wUiDfChLmQ8OgW0TFqoky7Twcy72RH92FVAjW9bH70mLO1qZ6Wd1nIgp/sUwHoAFyYx/vZxy/Z8P7nuxisAi7Y2SxhBJcZ0vGyPPz2X7D0obyAcbMIpgJav+0R2hmJ77qy1Shq8WPNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sb3vdebMKlL2rEKAWJo5b/vC6lPphiHcUz80zkSbBrQ=;
 b=XDNUZj6XRn2lRoJ4eoK40wi/wWnq/BvA7dup2tzvXp8KIPEQHwyWdzibRj9/DPFKtgZYu42K3mwNq9/Moqhy6Ob71lsl1l0kOZijX+CxbhaAo+rn7U5/EQ8r9TvL3YgoLNiwdHV6gMfSmqF/eVJHi9XAXYTZPRVY9/qEXuDWaKh0EklM3H8yidPFZ+r9+MMm8jjM0ZMaw7LQzUTQXnmdYmB9l07jz8sSfwzf6yoaVKy3ea+4x0WzpOUG5XYAnaqEwK5b4tp0+ipocmchxxWLQtTSXSEZq437W+PYHFa+8ElPHX0AT8vN9C2XlLo880wDs6vbqIU66PdGJwBEUaoJkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sb3vdebMKlL2rEKAWJo5b/vC6lPphiHcUz80zkSbBrQ=;
 b=FhmHi4TjIk+A8NNX4NWTZmkP7gQApx8jT6+4ss54gCwPCHLfFGLmetQWWoXYsEkDjoWX3dGtLfhi62xtcwpY+tIJ+o9TdOV9MNXxiaUSDFVhhk7Bp/S0LOECz2LBVj1nK+q7/9WW/l4uyCql/YITSjjMf/GQBkIrUA3ozjCbp/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5881.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Thu, 2 Feb
 2023 14:15:02 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145%9]) with mapi id 15.20.6064.024; Thu, 2 Feb 2023
 14:15:02 +0000
Date:   Thu, 2 Feb 2023 14:15:00 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [RFC 1/5] rust: sync: impl Display for {Unique,}Arc
Message-ID: <20230202141500.2b7d348f.gary@garyguo.net>
In-Reply-To: <20230201232244.212908-2-boqun.feng@gmail.com>
References: <20230201232244.212908-1-boqun.feng@gmail.com>
        <20230201232244.212908-2-boqun.feng@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0268.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::20) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: c3765c62-6ea4-4626-6623-08db0527dfc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dh2dQeNrFMCu9PsMp3/z0qWqVACKCoMjXTJ/SY5MUmLmLlMVKq4z7WocJUGScZ3dN3hJgpauJ6D9QC27inWgbUXkz0X6bRw3guYoXMKsgJcWsL1HWOp6kgyft3/xePD01j6Q+yiH9meuFm42KpzLdfoOMJ8fu3tUUMDuvh0j22ZJ2K/AQQnX5setnalJMwTonAFQ4XsQIIAlxsoZii8ArZKe2AxKuJzLu6nK56a2cQRh02u19MdwC++fv65A0hSPCWzGwBqMOf4KwqiD4oceCKB86o1lQyFcwFnSPzmY8A4GL2Myrf7uGPXWkHvVgDe0JgAQELzA+8f2rhcqL+6to8o5GLANnPZsMIg2Sahcf3lf4fXbWylA+MbUBK4Xig6xDuDMnuyUJVzumbxkF2lcsSEwX0dLYlxt+Wd0Ob4L9pR3SthxxsKeBwDTXPcmYMJ0nNq/H/o483iCnpSc0lGwEJIjwC5FlOYDnPbc39uE6yUanzfJFuZOK/Y9aZAI4DfSGXmREdVxFUSiIkgVE5qCZJ0aLOLhfV2SpYgHaxw54gDCn6s4QnXqS836lU2ZIwMfkaptFUo66AO7bOBkKH89NO9C2xIMQsjEP9fn5VB017hw6TsZ8xSIERcqtxjRyDkS5T7vJVOTq63czsYvI2BQhpazl0v8xne4t11OsTBEGV72rmUaShP1BPV9VX6amwsE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39830400003)(396003)(376002)(346002)(451199018)(66946007)(66476007)(6916009)(66556008)(4326008)(41300700001)(8676002)(8936002)(6506007)(2616005)(54906003)(316002)(38100700002)(5660300002)(6486002)(6512007)(36756003)(1076003)(26005)(186003)(7416002)(478600001)(86362001)(2906002)(222643001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1T0uP8oYL81OJRZoGJ1hQoJdcZEr83owFW4401W3VDa57MAO2dMtemX2tmdt?=
 =?us-ascii?Q?o0j6nLHxtB0e2f8BexS7VlNkgwwQ0xFZHYbJmJxOn52SlLS/CSMIAhRplEtl?=
 =?us-ascii?Q?HxtDCh+F4LpAUIkfbEDn3zHSSOrcG++b3JF8ZNriW9J1JiQlrD/zIzWf+k/q?=
 =?us-ascii?Q?Jpq4sY1FMyAkuAKn6FbpZ+pO2C6JPTeiTz6SRa9fYgEB+fLk/EJ2kwbpeSZW?=
 =?us-ascii?Q?EavRXHqtiMJWvdIGiIg7ErqxvzcWVGKwefmsCRILFvBgqgjrsBonMhx8nSoH?=
 =?us-ascii?Q?5EdVnd+fFVtgASR3L55G9RhRXz/WN7Wl6NvWxt7tuEHhgiTHo3a7sE2Vw0QG?=
 =?us-ascii?Q?8Ocpic5kEP6NRQeExczvTgzcBrr2y/3LoNJJelrOlDlxlsO4EJLyXsm6ka/h?=
 =?us-ascii?Q?ci5v4IZozkWQSI83sKIiLdvyljSeekqnMfIRfkgRihSqQoInr3UQWR9HRn2/?=
 =?us-ascii?Q?D0s6GZjvVYYMk6FjudCqYXv+uskVDRwz7wrLHCDMXY/ypr7Ev4jgvZJJEcio?=
 =?us-ascii?Q?ZRsLdjV/8+J4CbslIEEIPaAy6ZoC5S9bPkuW39EZi745PwVEj6MRKVy62mZK?=
 =?us-ascii?Q?ti3oLFdjf55IFTtRkQ9z0SCflDnLiG3sRi5DeXQtBTGj/1/zZc3V8YFTYXbm?=
 =?us-ascii?Q?AFC9mzH0gUa77h+KqIGXa8rQs5CUQ/4+hcP0Eh3ZYYnsmr2/YJ43HeqoYOvk?=
 =?us-ascii?Q?X+3e5KIc0QLD2P5g7L+j8zT6Do5VPPLu/L7UNK5k4cq9xDds6tYR0Sz/tber?=
 =?us-ascii?Q?wCs9jT/92ruK5ArGoSyZEpRCk4EEA0orZF6AGVx8ISg8TriON9iJK0Dg8EQ7?=
 =?us-ascii?Q?eqD+V1Xs8Gd9F0dOauAuqH35QS7oxrKjagGVbnYwsGMiN9UNFag25buP8CWi?=
 =?us-ascii?Q?uGO5MsTNptOoaWEfayxGgvF/ERkAHaMKZgpWpmD39AzZwRgi5/n77G2G4nLU?=
 =?us-ascii?Q?0W4V1k7GX480UDM2VjLNTyLbZsT9wsOKmaRAzn2b5FsnsmZ0YAjyMTfuM42T?=
 =?us-ascii?Q?5l5hxW30Ogz3U/C+8K/2igXMKgi0951mn//Wfcsi5PpmalrNKCJIwRJr33GR?=
 =?us-ascii?Q?oTDhYN7KKu6uAOGMhjhH8aMXLku/ey+pu6voVz6Ws+SPINOOVUpX5G3sLt2O?=
 =?us-ascii?Q?iekWTgW/LSBkcVwfw8UhzRAtGA7D5zKFBzQpnwItbQZpL//HGOQTtGFreOeo?=
 =?us-ascii?Q?Rqs+k2PpY36OArxZlO5o95f1try71zvTKsWCtOTNo/2D+qKdmj37dj/RMB3M?=
 =?us-ascii?Q?fJpISMLS4A+rEo0qGe845oGEKaU0O8OFd99WmO+Pdi2WsXR86nkFwIIcClbR?=
 =?us-ascii?Q?tib+K9Pm/9mKBskzRz+YHOi/bqehbN33G/GO4pKeAzaYUISklFEcz04snmex?=
 =?us-ascii?Q?zLm93YMbompyrxtIXZ+WgKBwCmJr73M+4RLuNegv9nh/LcatkH5julEJu/7t?=
 =?us-ascii?Q?wN6MGNobmi1asDMg6sQGYRVw3pVEytpj6964V978nMI62JVp7qxWCVEfP5g0?=
 =?us-ascii?Q?CykuFY9TrVb5jsAxLSEcW1pJQZkej2mPvC4kosT9qDr3zLWjhG8W+lkEXgtT?=
 =?us-ascii?Q?tUQOFzoGvTfXh5WEZulvA49xRhx7vWWSjKStBOdZ?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c3765c62-6ea4-4626-6623-08db0527dfc4
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 14:15:02.0842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWEb/5SSXZUZEE4HriBVaQezzJlKYNKnNzLauZ5tyPwBWwOyo4Do6OrRNOyNqQWsOY1zGwGXXYuNGk9ekB3Olg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5881
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Feb 2023 15:22:40 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> This allows printing the inner data of `Arc` and its friends if the
> inner data implements `Display`. It's useful for logging and debugging
> purpose.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/arc.rs | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 519a6ec43644..fc680a4a795c 100644
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
> @@ -522,3 +523,15 @@ impl<T: ?Sized> DerefMut for UniqueArc<T> {
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

