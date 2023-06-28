Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0E074170A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjF1ROc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:14:32 -0400
Received: from mail-cwlgbr01on2120.outbound.protection.outlook.com ([40.107.11.120]:46310
        "EHLO GBR01-CWL-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230340AbjF1ROa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:14:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nq2OqYspdPEIc7LdxsYXW+/u0BoIkENRwI62faUKoUv+LwCQXKSf/Z+e5EXeruW9zpSmTIZguWgdt3/q4UxZntWrhGknK2TDdWBdwSDpnU+rvnR0lmcPfNqxM5szToOkYrPU0v1eyp+hGD4YNyUC5wMHYc3gFb8Da3UnovHwXr1EUWe0ZY7sbQF0u+e9T+TBL4kRruXQ/drywq9xfUm3hRB2Ppz/2uY7RS+oAA3ZtJdvgw+owK0Bdzz71qR6Nn43pm2cGWv/1pvdsKT67d2qbKI0NLJQD6PNjcq3QQ76A8zfexGoK4pVpP1lz/RxkhL61zJJUda2X280Zv6sIpIqfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Eqi7cd4EwBWV5Pv8H9B//G6mwsUHuFe/6DIgI2HL/o=;
 b=MhUFa7g/sXTVyClum6yEg1UACcIIJI0J7xeKzI0s7POsp49BZP6e+cjPMtZB4V4bHHPuvJycXsfi1xQSD/5veIxkoBwoTF3B0rBW6uUL11YDWY0QVF3awfiLhwDOV3s+Ye4xfJjciKM6Z4MV34CqOsj9NcjpquDvy8W62zqwTMms/QZVZ4l8FcWU82RYjAWu59GOE52/u82BJ46913Blw6+AN70c67fks/nknyvBWylKY89qH8/GhxkINA6C4fe+/FOsZh8KepDtu9UDHNPbxxZpfNSlvR/ZQQAUVyLAaQcs6fxLwaTOT7onOHuuOSqif564VqodT/T6QsX6W/lBSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Eqi7cd4EwBWV5Pv8H9B//G6mwsUHuFe/6DIgI2HL/o=;
 b=q955zbQ8V36BRY06OcqCzL7F379wYp7xz3JcXra0Y8urOKX6doR2zuJ3zkyu9fSerHWq6XRbjtSRttmvG/n+fB5yi7DoOP0edbf6PWjmU1ay79Ux0ljFiH8N+RUCNWGSU6V3qfU3FTWHZvLJUWIwMbwaBHR5zb+Xw+DWHuJtA+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6130.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:247::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 17:14:28 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 17:14:28 +0000
Date:   Wed, 28 Jun 2023 18:13:59 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 7/7] rust: init: add support for arbitrary paths in init
 macros
Message-ID: <20230628181359.54fa03d7.gary@garyguo.net>
In-Reply-To: <u8Hy97tvl2TFqYO2rZch21iVBAAH7Cqe_ONBp7B35wE6QnevIyABIWgaGrZcA1NZ3rcr0m_K-RzVfiiycccX0UACcTx-pMF94CiGxT-auYM=@proton.me>
References: <20230624092330.157338-1-benno.lossin@proton.me>
        <20230624092330.157338-7-benno.lossin@proton.me>
        <20230625220117.667db9ea.gary@garyguo.net>
        <u8Hy97tvl2TFqYO2rZch21iVBAAH7Cqe_ONBp7B35wE6QnevIyABIWgaGrZcA1NZ3rcr0m_K-RzVfiiycccX0UACcTx-pMF94CiGxT-auYM=@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0483.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1acd43-789b-4db1-8f87-08db77fb214a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZnSZTps2+9quRVAmAuOUMZhY+Hq0K2c1K2mZl+R+7YPw8sJEwqYTV+SctPE8/6nXQ5FBKTa+n0I+BLKvt9IDfPHVWGT2XBuHKavVeXI4WQGv2n4gc/+TOKrzFrt89pfCweoGjS5tl1uigBB62LQv0ulEVpPu7MtjbT2k5XMpWksvJj8eq4wlaMikOZPkYqj+WUNlF4o+wyJrYuiKJTt9UthFdkNP6EvWrh1ryZlVtcb+wP/hWNn8ROg2NDQLMQpBNmPX5xfrYc+MDWYghPzhlRaGwC6KZy9tz5zcDUkEte9lypuR/Xbp8wRmZa5l7zCTFGcTEJV6zM5mBZtECNKSbrxQ/KoQyaSzEV9o9AUXvbSgJrUGyqDofJU+xcbqMNYCNF3fjUgX/cBxi40GNsw1nePno91GNkp3dr/E33625YOQnsO47zMaRaX+uhxFaPmZc+SXsbvcCn4kz/fxLU+czboFpW9HCyzjqdp1slT1EsY0Iknl5ccOqrnSUoarO26us8mFXkOdt1mZnpmrw7H6JbQVeL3ITFs4Bmsg7vXI7/A33KZYzfanLGPejS/GnCW/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39830400003)(366004)(346002)(396003)(451199021)(1076003)(7416002)(4326008)(66556008)(316002)(6916009)(66476007)(36756003)(66946007)(8936002)(8676002)(5660300002)(478600001)(2906002)(6506007)(26005)(54906003)(86362001)(41300700001)(53546011)(6486002)(6666004)(186003)(38100700002)(6512007)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PQ8gEop6a8fC3Jm6q8kKJCK5aD452tdbaibUDHcKFSvvGcAJOYLZO+8lBEmf?=
 =?us-ascii?Q?/I5nT4rDSv/7bMlnSpJ3YSlG9whLGeEz2vpGX/0W6KZA0mEGqyfUaMRMJRkd?=
 =?us-ascii?Q?rwkd8sH5JGB4wfBajdVbsjFLyHXvx7V7o7l//v/Xqtk7bd3jKOtbo4BimxEg?=
 =?us-ascii?Q?ouYEwVZu07gBUmUZzmAh8ZraDg4D/XqB0xqZ/OyIdJBa8KTiuW/jrY0N4UUh?=
 =?us-ascii?Q?JbN07aDje7braJi4djIlcKFdIYy9qxjzBIWPuj1aI7tyFwmR/jvgQAkq/CJa?=
 =?us-ascii?Q?zxbgD+oXHiAZ19ELyKn7IGoBqQdm9/UEb0Sbvr2Lgie6znRrF5VCKaB0ERI2?=
 =?us-ascii?Q?oSOVL57u+aoFzbCbbkKn5++pcPAVZHH5kCFX8zaSuLQpI5kGfr64oql3zc62?=
 =?us-ascii?Q?Ajply+Zz4jGnoTSY52A2qWPl8OyXT6H4s8iKnUY+6OpD5OiiVI+3rXTO0r83?=
 =?us-ascii?Q?4o+Bc27hBZUB9cwMh7csnHnFSegn2/rEgWJNc/iEKdHVGUmYRmoF0pG/R9VY?=
 =?us-ascii?Q?iqe5C6rYyzwymZ5T+Q+TM3eIW7Ho1XB9ECwGizzIO5nQpnmwDwEuDJbvdSh6?=
 =?us-ascii?Q?VzD23thU3Qb185KZdu7Ezi97OZRvGeXWc8fkVBLdfDvzReBDlXzU+G3xJkWD?=
 =?us-ascii?Q?MnO9dzB2oPyHOyLc6tB30bZ1Ls2LZDwwthYv+wPLkXzXTgIYm94MzUVTMn9e?=
 =?us-ascii?Q?wmECSdGpd8o9Fcna9rowKJXjCMtEkg+BF/8idxAulwhg/6oqZFHkwkav2GPC?=
 =?us-ascii?Q?0yEDBaRBPIyaIyvqlYXKupT8wVf9+sb2TB1ig9l/uLvU16KS4zvdMRb16Omt?=
 =?us-ascii?Q?Ii0yZSMmdNVdSXNlmfwLW/fkb3IqiZRzJc0647f3QHLCXQb0PJHnfH/F012o?=
 =?us-ascii?Q?RyAJBhF+IGL465BOjz79O0MrJ031gosesqNMyhcD68C4kwZ1y/Gw+Gveu/9z?=
 =?us-ascii?Q?81ERfPOZGLFdWD+giVQHn9LUZWgjVH+3e5XA3rerXhCUWLjvVxYYWkg89vOv?=
 =?us-ascii?Q?sdgWc9ZnKBVrbHKCfIEEQM8M9mQRx7LF3CfttKXoYxQg3z7ADySCGKXVFNGi?=
 =?us-ascii?Q?WJb5BOouFVWTiMbOT1sAr5jepIh1NpiiNtdKqvHnj7zPI8HcRmhtO62fOZ0F?=
 =?us-ascii?Q?fCJ9uLcb6PBEmKTobSoBTXpa14t5zstu0ru2NrttAz6K+eM8i/X40RScznaz?=
 =?us-ascii?Q?CgrrI1pHQOIB8+7cTAUXpw3Ww9FWNn+a7UwqLAsb0mTZE8aWSoml9CFGXquk?=
 =?us-ascii?Q?v044Bh9xmXq/pURZxi4gApM+vCsbAzx6FcWvgIp4WTuQjMMMpfeUNFmNRTtR?=
 =?us-ascii?Q?/MdzRe5t7U1OsmPuLCIFvbz/7P4KGtwRbcL5I8eX+q28qT3SZ1wwtXtu7fXu?=
 =?us-ascii?Q?AeLZ4QTQ1uHQMRLDmNz3c/mzyb/QpYC0vHbC+QnSmMPhEvaNOukEJE17Zsu9?=
 =?us-ascii?Q?ygDmrZ2rQJVcE2UzVvpoaQei6ld5K1sByjwb7Vs8WlDUXEmcjyyHQNzsldIz?=
 =?us-ascii?Q?rxZmv7mA8FMMTTpTZTR+BcpdaylQItskwpGkZGK8Kz9hjeS7vidgGLp3KzaN?=
 =?us-ascii?Q?XicK717z+Ac1OKA4NA82vNjQtd2K5exnerx8HTiU?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1acd43-789b-4db1-8f87-08db77fb214a
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 17:14:28.3702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81HPpCzp47Q20/QosJXeSuM6xYSiAgHfvY3PLdwsP5tYejSowqqiEoZ9nPyC/P51byItfSlAFsn8E7eTTDGtqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 11:26:54 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 25.06.23 23:01, Gary Guo wrote:
> > On Sat, 24 Jun 2023 09:25:39 +0000
> > Benno Lossin <benno.lossin@proton.me> wrote:
> >   
> >> Previously only `ident` and generic types were supported in the
> >> `{try_}{pin_}init!` macros. This patch allows arbitrary path fragments,
> >> so for example `Foo::Bar` but also very complex paths such as
> >> `<Foo as Baz>::Bar::<0, i32>`.
> >>
> >> Internally this is accomplished by using `path` fragments. Due to some
> >> peculiar declarative macro limitations, we have to "forget" certain
> >> additional parsing information in the token trees. This is achieved by
> >> the new `retokenize` proc macro. It does not modify the input, but just
> >> strips this information. For example, if a declarative macro takes
> >> `$t:path` as its input, it cannot sensibly propagate this to a macro that
> >> takes `$($p:tt)*` as its input, since the `$t` token will only be
> >> considered one `tt` token for the second macro. If we first pipe the
> >> tokens through `retokenize`, then it parses as expected.  
> > 
> > I think this "retokenize" macro could also be functionally replaced by
> > `paste`. Would you mind to apply my paste patch (referenced in a
> > previous email) and see if it works?  
> 
> I tried your patch and it seems to work. I also executed all of the test
> in the userspace library and they passed.
> The `paste!` code also looks good to me. One thing that I thought was this:
> do we want to accept `paste!( [<= foo bar>])`? Because the `<` token has
> spacing `Joint`, maybe add a check for that? No idea if that would be a problem.
> 

I don't think checking that is necessary, since that wouldn't be
valid Rust anyway?

Best,
Gary

