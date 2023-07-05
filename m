Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620DB748AF1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjGERso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGERsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:48:42 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2129.outbound.protection.outlook.com [40.107.11.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D413F7;
        Wed,  5 Jul 2023 10:48:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLJxfmz3NeVV+l+Kpzimr65jYWFfRp5voLtWr8Ze0dD+6X44EwVa+F+3eHaowLmnf5SNox3847ZKPz59eTHmdCuIJ7rQ91G7z41tKePARPL0zu6R+DckjqXx+mNruDzR0zXQZVf6PJha+Ad8kE4qbwSNQpQ3aasibZYGko+UjWqDBEThCnHUwHkWPSQszZ7JYBlSuKBzXSkNH/9+tTr1SIwbQ8JZZ4Q34s9CA9KCM1g2oje/52fbHlzlhrJKHabx5LrdUwX5TmmAgK2Q2Glvd3IQaE2FoyiOy1TmG+gX0EffgOy9KVgBL9rF84tXufFTHROJUFygutKDY9VxMOPsqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5a2kR98bvOzcx26LDqjULVofdHTS5osDgAMTPS2DV4=;
 b=FAZr+0Ec63fqbpmlJVDj3N38XECilBfiXxEUpCc9XrT+OL8bJIjFLMrQ41Ww8RwJQuotbHUDhWfQZUXaHi91YWdYBTh05rrtP6jHrSoCzvdFyKHsLmdgH/4pLKp6LYaQWN7fkyohQX0GNhWLkFy0PFYyfNUYXN4RmUz1ca1PuB1uvf15uzBNCTzXs4F1OnWGU0CNTAINcaiMnV2uqsu5Mu42ambflQW6pq6QlblwN+/iSOoKI8B3otVEuq8LyBGz+zNwhVPaELgIsoknFrSyJVf46gCwlLyCqLASeXACyzCzowfUHk4MDPjMH8Zd6q23Ndc7W1VX3Fog9NX74x+ojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5a2kR98bvOzcx26LDqjULVofdHTS5osDgAMTPS2DV4=;
 b=b50WarrPnbHoY2epRsy6s9dU9CNpxUGYo+17BVeTKUHiw5HEKerprweHMMkZxiR8SvoDWhosxcO64i6eRVagpfR7LkWtHxE9xh2Fj9UMsSBksqzTHLuiRIJoj1L+5Ck81ah7rfjWS9UZ8lcpZ/QiStC/mpeeFchfanuyyD8OyXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6333.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 17:48:38 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 17:48:38 +0000
Date:   Wed, 5 Jul 2023 18:48:36 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 5/7] rust: init: add `..Zeroable::zeroed()` syntax for
 zeroing all missing fields
Message-ID: <20230705184836.363c8c8b.gary@garyguo.net>
In-Reply-To: <ZKMQW4UGPQZ8yF39@boqun-archlinux>
References: <20230624092330.157338-1-benno.lossin@proton.me>
        <20230624092330.157338-5-benno.lossin@proton.me>
        <ZKMQW4UGPQZ8yF39@boqun-archlinux>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0354.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b1d0610-6c92-44a9-05cf-08db7d800fef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qmC0cQnvUhH6n0XdHYhoigM7mQOmQ7yfLJ3oEeflVckHxmFghOySjyn4qIcs/TYYp9qYKg65YMwBNcaH2B29JzhgetIzNtdx8X6JSsnADlWUSklDVXfcfDa3UFpQXK39DXcrJZk1r2uWuvFqZjdGAlPhJUOgT6PeL0vcNMzMvSlcPZ0v0LgYfQBMpQPtdkDtlEG1LNBwPBf4p2G2U5P3ScMcxxYl/A9CCJV65OApwYFI22628aHdpglNAnM74KdlIadg0ep2M2th4KBV/5e1FFsGOQnbEIBV6uDSvPiGUvOQBnQBwhzJW2yUTr9PRxwwOriLB/UxkXoULOSGuCrS5Zt8BJJPilRGG8ZWI1Xn6A6OzV0Sxn+RSzfREWBs6wxMfzlCDf9QOPsr4YnnHAe3yNnUPXHTNEZdEwDDtYMUm2Z8UpPcF53QA8A1tMifmBKh4kH7m7yTykZY9pvooHDmHjh927kp2slEplAL45rJJ/teEagxoxn54pAySDsjbaU4fx3rHuNbJZySZhpMM8KrLlDQtgQXfNNduEHLCgkFLNIbYmWBrkSogND2XD/a0fUe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39830400003)(366004)(376002)(346002)(451199021)(2616005)(6506007)(4326008)(38100700002)(66476007)(66946007)(66556008)(6916009)(186003)(86362001)(6512007)(36756003)(6486002)(478600001)(26005)(54906003)(1076003)(8936002)(8676002)(5660300002)(7416002)(2906002)(316002)(41300700001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hRh38Vc+EpDAMnx5cIuhYvvJLzxgUJNE1nsjWGPZWAvfuMjgcyEJTONr9h2X?=
 =?us-ascii?Q?KWMMn+d+pD4llNvVxuKd3gAJGiky8j8YVjuDTsPh63l+Ka9jNEevOQlf+Mom?=
 =?us-ascii?Q?dLMP35iHSv4zeafGq4gV+0gdIo8h74ZIZ73gOp3i4MK4IfgMoEvfAinsRk5L?=
 =?us-ascii?Q?TwapNrebnRJkGXD85FaEF48xvrqEJYd4XwESxGsJruviGdlYIm+0zGBdiVi3?=
 =?us-ascii?Q?eRitLuibI8ebGB7P/frRLn0DYhWaitnPYFO/k6rto6yhKDRTTiBZ1TKiKId8?=
 =?us-ascii?Q?pmu0YkE4NafgMzHvPIpbY8ajw1ClXLGtz7A+6azFBub3jf1kaWs5MF0QMmcB?=
 =?us-ascii?Q?DzrPMVyyJa2eOyK95zKejFrRT1pUWoC/y8+P3zYjBZSKou1Zb/1SkDo7tExX?=
 =?us-ascii?Q?Rzr3m8AVyuOiLRwqyQrqMW7ooJ9rTMSYqqdGirhnAxDliCytgYSA601vFkYN?=
 =?us-ascii?Q?UqfG3GTsAgMUAmTRCcs9BqkpaKSmEjp+jE6RdBBZ0uGg6eexUwjmNxcZ0JlD?=
 =?us-ascii?Q?QfEzkr0lqprsz/VC5WXntPfLRPNvyLpnqtHlt26Hh1Szlw7pIM74pYJGKbb9?=
 =?us-ascii?Q?kdvYQWTfC1fxPycStZ0m9Ie9aqwdBJFNlBNTXCjpJJKydGeM14OI3lFT3Kb3?=
 =?us-ascii?Q?QmpVM2Q7oPn4S2D5G7c467xtfAXXU9+o5W+UG81RccSLwHY9rbkp6GiOz5x2?=
 =?us-ascii?Q?LjyI2gD2NtA5wVkmaiARswuhHSjxhtylWErCojG8SovUjZHvzd7+0RgLxl9v?=
 =?us-ascii?Q?S0KLAZITXs8etSYWn3046fiVTeEi2lQhmbT7f0uykpOP0kQPcVa+krQDZjHC?=
 =?us-ascii?Q?Vf+UhpaGneU3P5iBUdGqfbxiX7kv/ZiYC9I9ci9tIALuns6NJOGQbG2pLEB7?=
 =?us-ascii?Q?MADf+oh7gRkm5V0nAohriL8UhtwBCDGYBFKVQyjdNnyZReciFJwiKeT5/nKU?=
 =?us-ascii?Q?I3FepOafPzt/d9F5XK6HCJNRCWErqRA/npRZsLIIrLZUe05gEcO5+qya8+kl?=
 =?us-ascii?Q?HGKQ1UTjAnAraXU+nSudHKRK8L2649x7zj2+HczlppUZWDceDzya6NF+fyxd?=
 =?us-ascii?Q?zrQu9SJUUKNactPCs/vjl3IhQBVjzJFG6mx0oK27D8RkC3tehiQ10u5wB3rn?=
 =?us-ascii?Q?XYDQIBfCi7XcuUmi+ulltWTVKdDcR64nX2Uw2oWd/9IszaBXEcq97XX2U6+A?=
 =?us-ascii?Q?kDq4osy8mXvSVC1AMq0NV1yzZk75BRfFjcjd0s0ijLNxxuxfMSzoqEe50aQ0?=
 =?us-ascii?Q?Bz4Rs3yA43rK4Q5d/Z3544wvtTsrWTh2jzVDi0XxmsXGOa5JDlNRE96vok6m?=
 =?us-ascii?Q?FNASyKlQ3zT+SeHhCtLYHQRwIFJHJ7YeN5HK/JOuomaZgf6906YQru6EhR2Q?=
 =?us-ascii?Q?NdsxdnHE1ueyWxJ1oMRqFh06Jf4VWjMTtbL042t36zQW8rKrzNhhHjPK9FVQ?=
 =?us-ascii?Q?vVcod8l66mkNxgSk3Ojif8nPiPbxPWo5f7JV65QEbqZXeufPTQ21/Tyt67Ic?=
 =?us-ascii?Q?lZROoJq6rmAr3pl1uNukeS+liOUJDVsHnV1IKf73dXMgZIAoXvjV89TdO3u0?=
 =?us-ascii?Q?hGNLnTwBRB2iUhFVxJhFRbP3DRQ61gWpNc/1n3Zr?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1d0610-6c92-44a9-05cf-08db7d800fef
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 17:48:38.1570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zq9sb/kvYmwoMb9VOFNooQL7G2HiDetdFijPpRD3HpRzjgTla0N0jFap16wXyhZnzUK4LYV+jzwRcY6GrqD+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6333
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2023 11:15:55 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Sat, Jun 24, 2023 at 09:25:19AM +0000, Benno Lossin wrote:
> [...]
> (this is `init_slot`)
> > @@ -1064,7 +1152,7 @@ macro_rules! __init_internal {
> >          @data($data:ident),
> >          @slot($slot:ident),
> >          @guards($($guards:ident,)*),
> > -        @munch_fields($(,)?),
> > +        @munch_fields($(..Zeroable::zeroed())? $(,)?),  
> 
> since you append an unconditional comma ',' to init_slot and
> make_initializer when "calling" them in with_update_parsed, shouldn't
> this be:
> 
> +        @munch_fields($(..Zeroable::zeroed(),)? $(,)?),
> 
> , and..
> 
> >      ) => {
> >          // Endpoint of munching, no fields are left. If execution reaches this point, all fields
> >          // have been initialized. Therefore we can now dismiss the guards by forgetting them.
> > @@ -1157,6 +1245,30 @@ macro_rules! __init_internal {
> >              @munch_fields($($rest)*),
> >          );
> >      };
> > +    (make_initializer:
> > +        @slot($slot:ident),
> > +        @type_name($t:ident),
> > +        @munch_fields(..Zeroable::zeroed() $(,)?),  
> 
> this should be:
> 
> +        @munch_fields(..Zeroable::zeroed() , $(,)?),
> 
> Otherwise the example before `pin_init!()` wouldn't compile:
> 
> 	/// pin_init!(Buf {
> 	///     buf: [1; 64],
> 	///     ..Zeroable::zeroed(),
> 	/// });

Comma is not allowed after base struct.

> 
> Regards,
> Boqun
> 
> > +        @acc($($acc:tt)*),
> > +    ) => {
> > +        // Endpoint, nothing more to munch, create the initializer. Since the users specified
> > +        // `..Zeroable::zeroed()`, the slot will already have been zeroed and all field that have
> > +        // not been overwritten are thus zero and initialized. We still check that all fields are
> > +        // actually accessible by using the struct update syntax ourselves.
> > +        // Since we are in the `if false` branch, this will never get executed. We abuse `slot` to
> > +        // get the correct type inference here:
> > +        unsafe {
> > +            let mut zeroed = ::core::mem::zeroed();
> > +            // We have to use type inference her to make zeroed have the correct type. This does
> > +            // not get executed, so it has no effect.
> > +            ::core::ptr::write($slot, zeroed);
> > +            zeroed = ::core::mem::zeroed();
> > +            ::core::ptr::write($slot, $t {
> > +                $($acc)*
> > +                ..zeroed
> > +            });
> > +        }
> > +    };
> >      (make_initializer:
> >          @slot($slot:ident),
> >          @type_name($t:ident),
> > --
> > 2.41.0
> > 
> >   

