Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE53667D4FF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjAZTCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjAZTB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:01:56 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0501F6BBD7;
        Thu, 26 Jan 2023 11:01:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHzSBrILazPnU8eca5+CwLVrG5MB2m8JS5m7rPeDwp5IOh3Npl44J9V/G6IQ+I9y9eV16JmjxbQ98LUGGUiSQ6Rsvbbfh4ZAXv1RLM+wTVfxlzcuwXF8sQliRl1Y35p7UxQTS9+fmf7090yz7igruTUl2HQzdhRg8XnqDU5zgcPASuLo1EVbA71I7NWbAIX1iYQlgQtbGJ8AIsZ62b3exYdh551ue/J9txgROknzUvA8cqMIKVNCwMM06ic4VP480moMal7DxLWYoxQ5jb1IE6rEOoCNr8kbR1RhBGlWbEHnjjzg4u0dsPm50wztBDqnhRWUxQQQOYHmbuovg6VR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT442/GPgLHPQ27Qswy35DyQ4Xhi60JeXId6cNnafRk=;
 b=VTeJ5YyNI6Q+ozQvZ0UhDkn49U/NhSkYxpIFexpq4mS40odJsvXxuUyBFVIiT4n5I1zSaFEKWAUFzkX1jZ9hgsxLzJwmGnA1sPehQBwlZ77FNDeSZM394HCMNoI6TX3xIFgJGbiqbuWj3NpePtCt1wrRvnPto3NKhRv3ymuzCkuCMvD/fStVdm48t2f3o60FRpsnr007U+VtkIB6h0Hbyy1+8ZtsguKKjS3INWoy0xYd1h626Qc5KUJrp/ur1HPMSAQ+YqGneadmmR4esbOqVcTmbU8wuWUMsN6ndubajuTMDvvU+eqVQwniq5QFcfXLL40u2mGnDQddKtaun85BAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT442/GPgLHPQ27Qswy35DyQ4Xhi60JeXId6cNnafRk=;
 b=nZvOSvBysvS6lC7OPMMD7yFiN+fNX9LNjDZG95bvnyVdMTmsdSVuQIFaIrb4hyUjYEuQXzkWrpLoDP0G9gk/QnDXI/K3OBb6XEQ+mwbruSlnOunVmPkjsECr0UYDh43QPcBo8aRc2yD5A52HeJ1yW37GbPeh8YTZdi9UlSFi5EI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by IA1PR17MB6646.namprd17.prod.outlook.com (2603:10b6:208:3ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 19:01:39 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6002.033; Thu, 26 Jan 2023
 19:01:39 +0000
Date:   Thu, 26 Jan 2023 14:01:36 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v6 1/2] ptrace,syscall_user_dispatch: Implement Syscall
 User Dispatch Suspension
Message-ID: <Y9LOEN3u/jYqPujS@memverge.com>
References: <20230125025126.787431-1-gregory.price@memverge.com>
 <20230125025126.787431-2-gregory.price@memverge.com>
 <20230126003008.GA31684@redhat.com>
 <CANaxB-xn0wW5xA_CT7bA5=jig+td__EDKPBWSpZdfgMgVOezCg@mail.gmail.com>
 <20230126150725.GB4069@redhat.com>
 <CANaxB-woave9F479O75P9PC+nFO3DVmbeFA1rXf2c=bhRmWoiQ@mail.gmail.com>
 <20230126183019.GD4069@redhat.com>
 <CANaxB-xO1fgMGRzk1Ovs2nNx0sU8wJcdpF4jGVv6nj2ErUVEAA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaxB-xO1fgMGRzk1Ovs2nNx0sU8wJcdpF4jGVv6nj2ErUVEAA@mail.gmail.com>
X-ClientProxiedBy: MN2PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:208:160::37) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|IA1PR17MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d28071-b802-446d-17dc-08daffcfc154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQ6eUcWm8v7yf2/xkJTwuac6+2S9L4t/LDU/8TszMX0l6Zk415JnQB0DWkbe9ME5F4lNRKoxAs0HpI9T576z1dkogniJdaCIo8a1y3yFNYnkv23ufVCy/L43aF9QRGRSZ+O1VhGrqjyzXJF6KLGkxYB/flGv5LmLWvg6hhYgYJd8PU13YG6B20GEyoKOW5fb5IYlAdAHtTAMisNjP1heKVaqhEvbI58FpaQJqb2sCpO19A/v5xfcp9/srdIN2SYCRa3NkEaw7GqHLth6Ii4/Q/3khZqHS2avBIccH5jKhKvkNccBoFRnBC/EacX/ebCQDUZMCJXaPcyyRqwP4+T1Q8/y3zjlhkOAXobF5L0kDghjjPMTYdbuDj7YHb9h1afA+nD0LbYFGggUV3CmeBW5UKqiaNBwwNaMdqB3ZQslhlEaRI4ABM0ESAZQ3Xq1djHcu0bJRSyawIEb5Zyjtlg996HhDJimBLQJ8JKt5z1biXupGSdPqnCPZeihywIS+fjCU/sCc4qtT7L1rX3SIu/aiYhRDexDLEva27LhOnLG2xawxxFROsZifn2QJjCv0PiShp7Qm9blHTngIA3jhqSrWTFWVnLJX903Maj+JMtY7KQSbSZc/e1dnWpYmV+FT8cn3Y0dBPSoDMIHbr4EEerscg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39840400004)(346002)(396003)(376002)(136003)(366004)(451199018)(36756003)(6916009)(316002)(86362001)(66946007)(8676002)(2616005)(26005)(53546011)(6506007)(6666004)(186003)(6486002)(83380400001)(478600001)(66476007)(7416002)(5660300002)(54906003)(8936002)(44832011)(66556008)(4326008)(41300700001)(2906002)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I+dvYNPrbTt+rKoBOA3IdbsdywxGhTz94pNAMirkOTkFX71JO1zCp+gNPX4v?=
 =?us-ascii?Q?RHcLU56xcANvvvwVclE4JOGaD4Ys1ct01Rw11FBXrmM/YasHK8lw4Thiz8a0?=
 =?us-ascii?Q?JVJLLnIvJK13kuG7VH8v2HaANWXn4hnCR2SxMXDkAt2rcVtk2bLGO/3YpCEG?=
 =?us-ascii?Q?JpsRN5L+zF2O1CS9eB9birTfXPeU9txWzliSE91mx6zIsxpncmQeblCe8mWW?=
 =?us-ascii?Q?qm3FRdBRSB0W9dwijTHNxiliyJbX6XwRkTpKzi37OOtUhScQdCMqJx1uvybX?=
 =?us-ascii?Q?w133RvgKnQP1dn4Q60yfV+ig1tQb84GFNu4Gt5/91/5b/7h++6YWDorxm8x1?=
 =?us-ascii?Q?BY2r8hn3PDRYXDI7VzHASBSbQKuV942Yxm9OapyglwByJ9vYDk0xVRuxHeda?=
 =?us-ascii?Q?LVow+8xop533GT06MpXhrlZ7ffQ1ntA8njtzSiGzQDp5bXs6WooJDqI/hQtT?=
 =?us-ascii?Q?tDMBnu0x5/wiFy9Hty8PXYF8v0hGPxuQ2iKdY4AaTcK54NHiVCxOJuonjZeU?=
 =?us-ascii?Q?WBKqtdfLkC0ouMX4+fEq5uFgopfvnsHB+2hOYN/LRa+aaz1OnAKBzI20/Fus?=
 =?us-ascii?Q?4WYDba7FIbDnLc1Pq7IDmeczFfQoceigDwrF7+7iDJxoPH8iHfKCv0z1VcXr?=
 =?us-ascii?Q?5jr/db5EjCVaITjuZqSj2XKM9VOCVNY3HJFAtdQFtlHt/7EvzutO5USPw43k?=
 =?us-ascii?Q?rnltrA4ft7fVjccz3xy10FETD2Wbfr8XLF8Q+iDkNSY0P/QCu34zSW08FgZH?=
 =?us-ascii?Q?AjRfzsWyzichZRfZ8p3KnlkItwx4MtIXSl4gHqcpowyDGjA9BhTj7zk1Bs1s?=
 =?us-ascii?Q?NW3iIvsGG7i950ZUNujw7/kYLv91Hn6zORqXJxTQJtCf+97UkeNAgaJhUjG2?=
 =?us-ascii?Q?YUL4Q1BsCgX93PsVMG5UKlXVT3FNzIzmMGPItDAOEXReak8PHTdzz/Rlslyb?=
 =?us-ascii?Q?bY38cvWPIE5UNLvESXFXSuccqAbq3j2pohvEZZO5N8Z0RNxuVPX9z1vdZZUS?=
 =?us-ascii?Q?9USD+6dE/ppnfckSfx7ZK3qS5FfEPLcViXhuRXDI89N+5cMpCPrMz7M1YZPj?=
 =?us-ascii?Q?bfwPFC7vBtG/x4nVdYDTvqDPWAXz+M9WNsBZmjENKX8ZsZ551ngjB/YeFCw6?=
 =?us-ascii?Q?+IfLjk3175BDZnmanvcpHJ7W2MJHsTOjc8nz652gGJVkuCUfWSr4bLmlLtUF?=
 =?us-ascii?Q?E0ofCdUYuDRHb4uE+Wfqyt/5kVzXCVGGQ2mjuAYxARON3qKXog3RPIPWF0xd?=
 =?us-ascii?Q?bCAbPwjP99bp64T/ARSy4Az2r+ZeGpyR3cEom6dEO8F3x+MmHfSavKGNbCm1?=
 =?us-ascii?Q?xBcSbHQ4UOKoAeWqgXvOOAQZLNAhQy66FaK5lr+IPaFDfFPhFUyXGB00nT1M?=
 =?us-ascii?Q?xm4QmOyJKuz+mE+pCKdg9m1eG5F+khuJn6EXlxb0tEKWYIWoiq0ViMGSnxGX?=
 =?us-ascii?Q?J+ZCX/EllUVSedzSRxQHYkP7y6YnAzRIivebjv/5oXIdP0EqpEt+i42XQTuo?=
 =?us-ascii?Q?bX7EfuJUb5ESkCla+stOFPA2QmJX8rpbQtHbsGvhWoQXneiEX21iDZMX0jQ+?=
 =?us-ascii?Q?aRw9YIJOihZyUDOBtH3scufoN+HKI1MVchAkex31aA+wo9iXso9nfAda5qYh?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d28071-b802-446d-17dc-08daffcfc154
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 19:01:39.5360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfTB7YSsgtAnCHNGXiaeog28k1/eBwpYo9R9dEiHNH+tTFtlVvNKu/YCyIswoIANVESBWAwjlKrWzOmq5wksQaqhPMRd6u/ElbXLpd4/k8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6646
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 10:53:49AM -0800, Andrei Vagin wrote:
> On Thu, Jan 26, 2023 at 10:30 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 01/26, Andrei Vagin wrote:
> > >
> > > On Thu, Jan 26, 2023 at 7:07 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > > >
> > > > IIUC, PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH is needed to run the injected
> > > > code, and this also needs to change the state of the traced process. If
> > > > the tracer (CRIU) dies while the tracee runs this code, I guess the tracee
> > > > will have other problems?
> > >
> > > Our injected code can reheal itself if something goes wrong. The hack
> > > here is that we inject
> > > the code with a signal frame and it calls rt_segreturn to resume the process.
> >
> > What will happen if CRIU dies and clears ->ptrace right before
> > syscall_user_dispatch() checks PT_SUSPEND_SYSCALL_USER_DISPATCH ?
> >
> > How the tracee will react to SIGSYS with unexpected .si_syscall ?
> 
> I got it. PTRACE_O_SUSPEND_SUD doesn't help us here, because we rely
> on sigreturn
> that is called after ptrace_detach. Thanks.
> 
> >
> > > I don't expect that
> > > the syscall user dispatch
> > > is used by many applications,
> >
> > Agreed, so the case when CRIU will need to do the additional
> > PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG twice to disable and then re-enable
> > syscall_user_dispatch is unlikely.
> >
> > > so I don't strongly insist on
> > > PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH.
> >
> > I too won't argue too much. but so far I do not feel there is enough
> > justification for this feature ...
> 
> Agree
> 
> >
> > Oleg.
> >

Seems that's consensus, I will drop it.
