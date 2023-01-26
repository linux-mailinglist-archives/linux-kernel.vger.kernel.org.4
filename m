Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8861E67D389
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjAZRwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjAZRwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:52:37 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57156FD2F;
        Thu, 26 Jan 2023 09:52:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1t7lNTulZNe5i+6pmd+DdcfAkgNCW8/HE4VPvDJHLvS2lw5qyAka8I/bw8qJg+qdOoBxhM6TDfItWHAgUWA/z0QEG89rEwAdH3/cxqelGOomPiw3iIcxxbO7x35uEt8nXOp4JLtIRz9XLKvIA2g3qqyXyJPniuXinm5MC12JPK7HS1WPGWtOOqGX/Q+33sas8scA7/EOJfiSWNT9C5DmAvnPqdhoyRQFSRqm5ntsqjsZIJ4kH2+6t+GR7HwM/Nn9x+EAUqDSyiRmw/y7QyBSQx7hqLO4jEpA7eLzFJlvdp2aKDXcKCRvVwMznOws157BzYtGkxwllsa0Rk9yCyBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9uHBphguz8ImFJ4n1uKIH3isTf0nTKc4MaYsM9fgzg=;
 b=PL5k/bZuAcK0RwZO2pTDRF32dWH4qVWLUGZHGM9BwhP1g5l4zfTFR1208bLF26MAumwZiXVa36XC8pc2Y5ke82iy7naCLeooKgueJ4ZPyFvYtbLX2MJx3r5vcUziAip75A+T+mhp/HTXde/QWvXok7TQotMM0745L3cieEzYWf59YijYXRzLNB8/Noi3nzONWTTHype8uOUBbeZT+UpLJHwMF9JmEm7HQXfwjId1wECqcM3Ik2/xF0zwCCpZVYe+zTOIdsn6Ntmo8TIbdk1iUeREHV5IqFvYxCVsmd9hibMyuJs5HSNqGLf+JxaIcdvfuhdE5BmN1sxxQV+iRETqWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9uHBphguz8ImFJ4n1uKIH3isTf0nTKc4MaYsM9fgzg=;
 b=FNBlxQdZlZetfYpNfZSFEJlT24OPVE/vbQICkJvAverbYnJDfuOg3NY3AbqWBv9FqQw+S6YWW6oaw2Vqqtx7MYxQIRUsPOgvVwCdhH7hUk7+96TUCgwx3yXCJNlf4nbotYEEmcpF/JErPczgCFSPunFAZdJTd3q6k/a6JFHMDWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by DM4PR17MB6086.namprd17.prod.outlook.com (2603:10b6:8:bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.34; Thu, 26 Jan
 2023 17:52:31 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6002.033; Thu, 26 Jan 2023
 17:52:31 +0000
Date:   Thu, 26 Jan 2023 12:52:25 -0500
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
Message-ID: <Y9K92SQnrXhd0qjC@memverge.com>
References: <20230125025126.787431-1-gregory.price@memverge.com>
 <20230125025126.787431-2-gregory.price@memverge.com>
 <20230126003008.GA31684@redhat.com>
 <CANaxB-xn0wW5xA_CT7bA5=jig+td__EDKPBWSpZdfgMgVOezCg@mail.gmail.com>
 <20230126150725.GB4069@redhat.com>
 <CANaxB-woave9F479O75P9PC+nFO3DVmbeFA1rXf2c=bhRmWoiQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaxB-woave9F479O75P9PC+nFO3DVmbeFA1rXf2c=bhRmWoiQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0267.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::32) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|DM4PR17MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 440b110f-0548-49a1-68d4-08daffc618e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kezGPDTiAvezcogdz+58Saz9pU2SAf3x49W8PI7mzzjS3LEC3AvBtJMaJWyOvoG/BNjCRE76HgUvMZMO4/d8qvumBM5HU6lecafNZFYexh+k/j4BunOBMjH1nK7LrhvrU6S7Wn1my4kUofYmgRojCrvq9wu0LgmB7fb0pQ7p14je9Vyptf0V4maO4+gItM9qYAg+sjiZWomgS2yZXxybO8dKP0tyzjLA1CROOmcsmwkIKNYAc/Ki6NVOGuKlXFlZH25dbcbJmIob6EKYmAOW8IjScZ08j+urmSxQ64AmlFw5G89SXLbIbtxNo6Ff2MOgzh5TdR8g8MMDceVgQ/8tPTEJpUDuJZtCIHi9PS3g5/zB2xFxk5SncKB0REUhXAuhDSr4oCyyBVxbAavlaXEQGJH2OTToVAL4jp0hvfjC9Wc/tLk7g4G5WqTcVaFTSofhE7xfFbM1KZz8KcuzLnAf3VfP2EpeIqg1+IjfWTlDyg2/5Jf+t8zWJMBOW7lrwfsAs/eadmqqMRUf7lqyB4dTUbegM7MfFMcrqhKF7NByxTRWMlnke8KsZrdIChBfsaipPIjXL/6yHb0y5Ar9cN+E+difc+i6iQwFduTZPt+ElK2C1x23VYcHBqXxV9onE3ND9uIODSEA+iA1XqNbwM3QsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39840400004)(346002)(366004)(136003)(376002)(451199018)(316002)(8676002)(38100700002)(66476007)(66946007)(36756003)(41300700001)(66556008)(8936002)(86362001)(4326008)(6916009)(6666004)(6506007)(6512007)(186003)(26005)(53546011)(2906002)(478600001)(5660300002)(6486002)(7416002)(2616005)(44832011)(83380400001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3WQM/dJsnAS3WnYxSy28l+uCHx2xP3JvT0FmiVMum2vq/AZSfTub/Lt9DcHJ?=
 =?us-ascii?Q?AAUWneAxJV8lAqO/VGNUAiTBK3bOQmJkqc2Q6UmL9gtGCKW4DwrPe7G18tVC?=
 =?us-ascii?Q?wQ4Eabo6GXQbyzJvDCT4mqt0CUsLKP0I2Ao9CuSAE9NtoylGvoOWF8hIp9Dj?=
 =?us-ascii?Q?5gtB7RAKQjLoFcV2zd88x3UPaEkiHmFkj6LN7FsIEKuTSUO5Ol26mrM+F8/N?=
 =?us-ascii?Q?m2RbeV8i/z96aO74We+GUd2VGJjVsA2eF2hfN3rusQ99ZKi/VDj2OWT4JSXy?=
 =?us-ascii?Q?WRgFyLmqsrxIrAQeRHdg9UEK+swcOp6cSmCVdikQcp6Ookv6BxEh4VNVbuQj?=
 =?us-ascii?Q?Q7dgYXrzmQvymrW7jRHR9lLf11BkJgE9VJGrFQviE3KFbvdtOUsUah1gMg/+?=
 =?us-ascii?Q?2imxV10h2uOn9mwohxkJ6rmLWWroQwHFGQisdJEhf5yhdQFR6QxrQwO/8EIt?=
 =?us-ascii?Q?RowEIM908hFD7dS6Cm8VwCuCbciLOjLfoqcpGdn+1lDYAeXzAIQOyqF76j0a?=
 =?us-ascii?Q?+P+bK2P8FIgBVFm1fBTki/tbsVVUopuBTc+RS+jhUDe/V2SgQvDL1pCiwgFy?=
 =?us-ascii?Q?wneXzzEHRU+ORK8R0sssiZVb4VyTAKyPIMsWcsyEz3dMuEmSuQyZNUaMSrJE?=
 =?us-ascii?Q?mScTK5w9A8N0nMhqoWt2uySNe0F8T+hxBxSvCMzOIe8EolPYXkrEV2FaVBEf?=
 =?us-ascii?Q?Wm+7M2nzfk8Ieva0OcbiryKIfR95tfxoKIy6WsABIRlf/CQcXfiS7H+2bovn?=
 =?us-ascii?Q?SxtFKvsrkc3Vad7V6fFnkOi0celrMGzZg/MD2fmH31c2iOWpAryMOBayWgcX?=
 =?us-ascii?Q?2TOxbFs61sPghPXeFcoQyEBspbVUZYv7qdSvTuf7ujDxsiUduAKRZTVb3fC4?=
 =?us-ascii?Q?BBO4nEBo9sSbQVe7ey9u6mz6ZdrzOERkHq50BMh3JQdV3WPJXpq6teWlBFSu?=
 =?us-ascii?Q?i3jUUMz5lshLaGkVyUghRP8TRIvMoQhgrjTkTFEGm7DV1BzZFxKruAplxAbj?=
 =?us-ascii?Q?8PzlsDMTwUdg8C04SyYLMZLlWnzdnkaRG29uCpHNTYnaCBXcFCCaIBjaqwq2?=
 =?us-ascii?Q?dSnD/hGIrmIlHDDenUqJWybuwL1Am/x4Z1af58D4YQZ2pNXhoDMJZNSiEfFt?=
 =?us-ascii?Q?Z7ohnwbl4UVsq6I1VW4CAUZHD5z9aOunMi950B5WYU5H042PZD2y45LmYSF0?=
 =?us-ascii?Q?QAyV6a6KNhBAPHmz+kfQQDNuPI2IkHumyWpmF+7JZKF3JTgvBusjBC+4d/zb?=
 =?us-ascii?Q?irpnhsm7EWh9z4M/qU+0Gr0gLhsWqNFq4I8ai8yshgBVFQDV4I+yp1ItZBdI?=
 =?us-ascii?Q?Ef34dCsKHPwGAD6gFEAZNTGCOA+wFcaESnNS97lZ7kTTm45LbT2QX6FJnOCm?=
 =?us-ascii?Q?mwL/3b6ejHJLHd3JZOsv34M22JK9nr/aHUmF83RLYjO24WdFQJFvz1K7F/i9?=
 =?us-ascii?Q?21LXn3w2UkU11L05Y9TquBTFI6CFSzBNPmt8xeR7BNvNwVibrQX+ysnhNuJL?=
 =?us-ascii?Q?3crlOTm+kYuh96/96FVQ66y2R/kIUGuSBDR+cqIw1KsM6k4XwxaGGQtNsa9p?=
 =?us-ascii?Q?IZddUFEjjC2lWvd/lbAYkSKSfjbf4To5+6My6ZHwfRKmZUZ7GRmjGKnsUeCL?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440b110f-0548-49a1-68d4-08daffc618e7
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 17:52:31.5428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XT3+ZM3z5HqTvpbbcPJ/66jKrVDCfqxFLW0R9mBOeUTRheYAiyFFe03JxNQwpD4qP93WYoUaAyLUs4WU5Vp/CPPRNg4esRFynptNmrsK+o4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB6086
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 09:45:39AM -0800, Andrei Vagin wrote:
> On Thu, Jan 26, 2023 at 7:07 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 01/25, Andrei Vagin wrote:
> > >
> > > On Wed, Jan 25, 2023 at 4:30 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > > >
> > > > On 01/24, Gregory Price wrote:
> > > > >
> > > > > Adds PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH to ptrace options, and
> > > > > modify Syscall User Dispatch to suspend interception when enabled.
> > > > >
> > > > > This is modeled after the SUSPEND_SECCOMP feature, which suspends
> > > > > SECCOMP interposition.  Without doing this, software like CRIU will
> > > > > inject system calls into a process and be intercepted by Syscall
> > > > > User Dispatch, either causing a crash (due to blocked signals) or
> > > > > the delivery of those signals to a ptracer (not the intended behavior).
> > > >
> > > > Cough... Gregory, I am sorry ;)
> > > >
> > > > but can't we drop this patch to ?
> > > >
> > > > CRIU needs to do PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG and check
> > > > config->mode anyway as we discussed.
> > > >
> > > > Then it can simply set *config->selector = SYSCALL_DISPATCH_FILTER_ALLOW
> > > > with the same effect, no?
> > >
> > > Oleg,
> > >
> > > PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH is automatically cleared when
> > > a tracer detaches. It is critical when tracers detach due to unexpected
> > > reasons
> >
> > IIUC, PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH is needed to run the injected
> > code, and this also needs to change the state of the traced process. If
> > the tracer (CRIU) dies while the tracee runs this code, I guess the tracee
> > will have other problems?
> 
> Our injected code can reheal itself if something goes wrong. The hack
> here is that we inject
> the code with a signal frame and it calls rt_segreturn to resume the process.
> 
> We want to have this functionality for most cases. I don't expect that
> the syscall user dispatch
> is used by many applications, so I don't strongly insist on
> PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH. In addition, if we know a user dispatch
> memory region, it can be enough to inject our code out of this region
> without disabling SUD.
> 
> Thanks,
> Andrei

The region is exclusive, so syscalls *outside* [offset, offset+len]
produce a dispatch. That means you would have to inject into that region.

That's what's problematic for injection.  Even rt_sigreturn itself
may/will be intercepted.
