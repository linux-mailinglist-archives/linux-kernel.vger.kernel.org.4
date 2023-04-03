Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F1D6D4BC9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjDCPZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCPZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:25:34 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2138.outbound.protection.outlook.com [40.107.11.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDD618C;
        Mon,  3 Apr 2023 08:25:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BecrfdrLKlzmzYygCw3hvJ5g8LtPWg/v/76c6zHLGdzHjSNmQBSmgPfgeaDP6cY+JGm+ocd07TnozEeNaDb7c/9X6D0+MCDSqk6+kZcyKZ8ZtfX0JXoMgXSkxo5D5ZTl1ReKlnpXPJMo2QMpmecWMKC4FXGqA5k3TzTeyofPdDGX+zKnD30VuQV+2Lsc3Wk3NYQ1xf75Xb6PBGJstCog1cnvppsxhlzYQw0iLWM741BI2j8ZPb5EjbIWKK/ZBroOxePGK42yelbDC0ND+PY1BshTxn0RUnzB7oGs/vwTlDPj6x9Sfxs9Yhl+p6TyKqxlAr6FaKzXmQBovnqRrX7owQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEpR9DdwSdywvOnOKyGeB1ujg21la3wgt1NUXUhhDac=;
 b=fbiKZt7lep90H8o2dVM/mdwcoLgwiYD/Y1mvT5ZIDUcGfseCP6TivyQC6dtWhbxM4+uguZYYxrMfEshnPn0l7FVu6aKpwQrs/Or8kUCX9Nf7e7c1Hab+6z3KYo0ZW2fTaqfOPOD1JjzS58S+0vKqSg4QOQCQcbmU/K05QZM62khXzw7sjJ375Q0+ebj51LTPOAosjHu11YCdIT1jtzAfHQuvhjUrb9N7TDHuj8F+G9f11Ozant5lynxRvlARe7RAhrCL+2eltjerqJ1xb9enBgPnp8TfhT70CMmQGW2AsZac6vw9dglGc9BsGAOiV17ocsTM2B5Ve5kkFkmhTIYeQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEpR9DdwSdywvOnOKyGeB1ujg21la3wgt1NUXUhhDac=;
 b=lwhu7Av5vNPV0OW5IZqGKF6SHo5F/A93m987f/KxdziQg0uo+JK91oUsius9clbyHo0HhwN8PI+ivQs6YYnyK78x9MbVQ6f0gglKDtQUHlxyG6rfTJghyLqae37GjS0Y8EPV4C+BSYLbux64finfgO1A03Z0TyOfeDmBIsFUHyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB5783.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 15:25:30 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%5]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 15:25:30 +0000
Date:   Mon, 3 Apr 2023 16:25:29 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?B?Qmo=?= =?UTF-8?B?w7Zybg==?= Roy Baron 
        <bjorn3_gh@protonmail.com>, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 03/13] rust: lock: introduce `Mutex`
Message-ID: <20230403162529.7bef76e6.gary@garyguo.net>
In-Reply-To: <ZCrZkUaoslXHpige@wedsonaf-dev>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
        <20230330043954.562237-3-wedsonaf@gmail.com>
        <20230330130108.GE124812@hirez.programming.kicks-ass.net>
        <ZCXZMNj7aOKbC7Ev@boqun-archlinux>
        <20230403082052.GR4253@hirez.programming.kicks-ass.net>
        <ZCrZkUaoslXHpige@wedsonaf-dev>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0658.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::7) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2814d3-2647-43a7-c073-08db3457a912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: plRABDkVsjCoJpayC4OcoWw1uZQDRefoG1p+CYYIzhXjPx3jYfVbcOUrHSBt6mW5JR4kaHmW8RGEJMV2J/chODY6bQmUXrG+ixCYvPwNyFlXn6JQENBUNDIldL0p6skNzX1MpExf8MYgqNTrh1qE/lm//GMUScCzdN4vOB1CVC+g0nTNrQYRNldysY8LlN8yde2Kj+SNogH6mdVofvYWuOkpeLJ6XvJs3NEFsrg74OzkTytbAGcxc5PG5nMYRnnsz/WG91hNib0iqI27u3orxkF3yMrRQN6ceI/erTPkV0nuDIfxzsvrdKGbbSXGmXi0QvlT7FACLhFAd9aldzDwONkKQOydSLwbRrfYHK4US/SeUmu18tmb1sWE4GVqjauOjNiP6oHmqbzIzqsSC7tiiYJsa2MtJTBFRG3UHMhi1iZuYYlaQKHmAsBchfkY4bOgSsXNa4BrFUtInnJAaL10QKzvhxiuQ3yKnXUmkwLyDXtr3FlRoMG7BOExPWbKbIn8S768YkkWIaTh1Y6U+2QK/w5wSPixm3q6pUkPTogMd6PBbwZKKvUOTTU7O6oIRlZx/Bm5fME/GE4mct29rrokW7Dvy7MMrEVeNiY0OxF2j7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(39830400003)(346002)(451199021)(8676002)(6916009)(66556008)(66946007)(66476007)(54906003)(316002)(478600001)(4326008)(8936002)(7416002)(41300700001)(5660300002)(38100700002)(45080400002)(6486002)(186003)(83380400001)(2616005)(6506007)(26005)(1076003)(6512007)(86362001)(36756003)(2906002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nPdNvG++FbyRZ9q/ESRkbZ/682/NoyHeBlcWVxfZugxhwpOw1EHpdlTjJCan?=
 =?us-ascii?Q?zU4oHSvVz91DHYAB1hi75fACoxNs3HPBzEXGu18uqGUPb7HxXfBeuKHXNUei?=
 =?us-ascii?Q?/FviPxrMf7VZiynyk9PhGfiBh4MEQnB8y+xgJRE99aRdRgG24h633qbMBvwV?=
 =?us-ascii?Q?IlpQC6XhJe3/C34nNTl8+L2I14wDxCnA6zVHGK+5EcBFKycQeselL3VsvlTZ?=
 =?us-ascii?Q?VEGdI2TRPRIIgsaHOLAAN8ayeMroC0NS9k6zAACndJ01t9K1Dp772/hsvTdu?=
 =?us-ascii?Q?4EyWZS2AqgGYWSAvv986m1MKeVRsz74pGOWapUUPsiV51YdNOHP95dqXlL0M?=
 =?us-ascii?Q?wapEiMdp1axPH0dUr6q82i6x9pbSbChCHmQ9+FIUIJO8UUg8gFfgYMeLMhJH?=
 =?us-ascii?Q?KNUBzoqq5UYehz6rq+VluWQi5fc+fIFA63qWE+q5k+ZmZqUjB1DXKNmUsXI9?=
 =?us-ascii?Q?UK3eLSI1EFOXDMh4vBT2PDeN9WWABtZ/OyJGPq96bKpqTgm4vSUdwmhXHtp7?=
 =?us-ascii?Q?Qgvzhjsni0mUcsbgGnUKNBENjmoPHBprF1QBAOfIk4SoxYJxQi1QbeXSEfqw?=
 =?us-ascii?Q?iuvcqf1OLKiCl7EQ1B54fnpr3Al6NfgpOYrhPbDhcgUAG3ubRf7OsaO76nJy?=
 =?us-ascii?Q?q1u44ndKbOVQaxmEtnLft8VjCiRQ6ZzkiyWHj7Ti4Kymq7dj/GyeWHAtJRFG?=
 =?us-ascii?Q?X4ne/Y/7DaHt7+HzGB3dzhcrcKzdMyDZ7U/9RscFvlD89QNyRUdEQUPBjD75?=
 =?us-ascii?Q?khLviWar2uN/g6Oaq4qa8iz+blgVvXnHSdqd/oIEwHCsx3945UgXquLbBTU2?=
 =?us-ascii?Q?QJTir3cVEg/Uj29kcN+TnAFN0sAoPCGaj9oAg1rdQ9pqiS83YqsaHjyGuWC2?=
 =?us-ascii?Q?NzJR6kzZeAxVmP8xjspCLRBm/QznFY0K1h7MhHpn4YkyAA9DYkRWX9RSolon?=
 =?us-ascii?Q?ceEDMF9Mim/Kjd0KmQmR2r9/X5rltUk9w7A3LHewyIu6LYqxOziQmgiOc4rF?=
 =?us-ascii?Q?xj9w7HH38KSb+BOM5i8df9FlJH7awqHJr0KqpT/qfD+1A/5C1sulYdrjfWj/?=
 =?us-ascii?Q?+/X3WiPj2tntSl8DlB/T11jx4BoTmgUc4WEw3qXlJ2ITIOfsiKB2bbzALDmU?=
 =?us-ascii?Q?/V+gT/IP5ctVugd7dQg/dix+OMDChr7FgClsIdV5YNjBTXjFia07NVoiCh9Q?=
 =?us-ascii?Q?GtSbeT+o8narAboFAZocBLqYp5/satsmyGt+BMUQGsop+8TNax6hPgyKTgTz?=
 =?us-ascii?Q?wKXAwV12t/02U8YITLNd59YvI0m28Kmrb67qkStqHTknMRricVu9KmeLQk3W?=
 =?us-ascii?Q?icOF2hLz9AQlw/F71PMLpe2vzM9KdlOBCLQTn1W9GEuYnCrMfDaJzqNW5F1n?=
 =?us-ascii?Q?cbdYLUIUqxnHFytSHXwSsMAKjYk44rwg2sLizXSm26zs9Brez/0OYfSIvDpQ?=
 =?us-ascii?Q?SIEQyADNFymFCOysJGXbIkLqcjsfknAKHy3Db1c2+2AFh2MEoCOZhgl8Aqqd?=
 =?us-ascii?Q?q3QU7vhCVEUyWU/FbIVhXSM5y0cGDZqODXncAEa2Fh4FYtgCz0B8aNtsOY59?=
 =?us-ascii?Q?3Fq2QMRQgOXNkYpu6U8Yflhez+O461IPyiGuSl29?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2814d3-2647-43a7-c073-08db3457a912
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 15:25:30.8146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EsOGrnybq0+aCmEGZzYpiF1CDkyi6pgYsZqNS99LCCrSN91TYAlv5X0CrqERWrbPc+S7QOLkd3dpg8z4hK43Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5783
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 10:50:09 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> On Mon, Apr 03, 2023 at 10:20:52AM +0200, Peter Zijlstra wrote:
> > On Thu, Mar 30, 2023 at 11:47:12AM -0700, Boqun Feng wrote:  
> > > On Thu, Mar 30, 2023 at 03:01:08PM +0200, Peter Zijlstra wrote:  
> > > > On Thu, Mar 30, 2023 at 01:39:44AM -0300, Wedson Almeida Filho wrote:  
> > > > > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > > > > 
> > > > > This is the `struct mutex` lock backend and allows Rust code to use the
> > > > > kernel mutex idiomatically.  
> > > > 
> > > > What, if anything, are the plans to support the various lockdep
> > > > annotations? Idem for the spinlock thing in the other patch I suppose.  
> > > 
> > > FWIW:
> > > 
> > > *	At the init stage, SpinLock and Mutex in Rust use initializers
> > > 	that are aware of the lockdep, so everything (lockdep_map and
> > > 	lock_class) is all set up.
> > > 
> > > *	At acquire or release time, Rust locks just use ffi to call C
> > > 	functions that have lockdep annotations in them, so lockdep
> > > 	should just work.
> > >   
> > 
> > ffi is what the C++ world calls RAII ?  
> 
> No, ffi is 'foreign function interface', it just means that the caller will use
> the same ABI as the callee.
> 
> > But yes, I got that far, but I wondered about things like
> > spin_lock_nested(&foo, SINGLE_DEPTH_NESTING) and other such 'advanced'
> > annotations.
> > 
> > Surely we're going to be needing them at some point. I suppose you can
> > do the single depth nesting one with a special guard type (or whatever
> > you call that in the rust world) ?  
> 
> I haven't looked at all the advanced annotations, but something like
> spin_lock_nested/mutex_lock_nested can be exposed as a lock_nested() associated
> function of the `Lock` type, so one would do:
> 
>   let guard = my_mutex.lock_nested(SINGLE_DEPTH_NESTING);
>   // Do something with data protected by my_mutex.

I don't think an additional function would work. It's not okay to
perform both nested locking and non-nested locking on the same lock
because non-nested locking will give you a mutable reference, and
getting another reference from nested lock guard would violate aliasing
rules.

A new lock type would be needed for nested locking, and guard of it can
only hand out immutable reference.

Best,
Gary
