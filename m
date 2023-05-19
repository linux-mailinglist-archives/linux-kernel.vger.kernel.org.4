Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381CA70949F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjESKSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjESKSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:18:13 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB2E10D9;
        Fri, 19 May 2023 03:18:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=By0nfyJ8p0te9ki3ADJnfVwfxNGogRmFBw61TYxMH1vyEfYICPQA0gb4qTEfLw4QBkV5Pmoo3yAclNBlfr0squlNgigX1FG9vyWPaTBIQBBMtHruMU92Xhr+JokGHn8igZ9O5sz/j9hRLa6FBPjWziBdfCtAhS3Rhxax+otcm8FyDX/8jbmyaRtoiz03O40OFwyOXblQmRdw0B95Qs34BLBvjaPYiee7zH2dCLuSBaA1vpgRMsiDIc9mfrKtJDjEYgsIVaXhH9UHhsrQz3aNaTIlMytuKjKGjXWA6/r10N9k7c3Xu4m1OLzTcQziAPDjbsrSYvo5+XUt8H7h5QOGAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/e6DRdutkkY4CSrsUNLadYprbTm8bkkKGNwMRQy2ABY=;
 b=V9RNIX0JQ2dB+q0hF2H53nsGlXiXXVLMXrcicbYXDUzPbpJyXm8pqWaaNf0RdfMjLfKdTnvvV+tpDreZ2JcvvQP+T+FQ2pkXUnSZ4QV87ShZtZPF4qwNjYeIUphZker1bfNUgozbmCM4COmHmNsddNG85KAd66YGodcC033DdjGkllBqSvwrXyowhRsYuPdC1VnyGze+61TeTmQW5mVsjHoT896CxakIb6QpNf9Oa5C9Gd5ZxIk6xz0eQHTqtFxO6ZyqPilFv4DmnuMT8bzYi7fkZmJD7GCKMygVz0zYz00akZk0RNmmctS0IuKaN5saarpD0WEQ0IpaRjr/wPHwBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/e6DRdutkkY4CSrsUNLadYprbTm8bkkKGNwMRQy2ABY=;
 b=JFp6WgL+iio0KqHei31XLi6At04Hj+VNZ5G5gmx6UtvFx26sAsgxPMwTSUGV1LUJviM43bdqd9ljDSROrV+ZnEJnrmMd3M2NT2azhbo/c80MFwUONgKBtVfYsp3vhh1APYMlG4T0SG/XD24lBACr+qPmgEVD6yYs/1Jyuxyb5hs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by AS4PR03MB8697.eurprd03.prod.outlook.com (2603:10a6:20b:58c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 10:18:07 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979%6]) with mapi id 15.20.6387.030; Fri, 19 May 2023
 10:18:07 +0000
Date:   Fri, 19 May 2023 12:18:04 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/5] sched/deadline: Fix reclaim inaccuracy with SMP
Message-ID: <20230519121804.6c85a3ed@luca64>
In-Reply-To: <20230519115621.2b3f75e2@luca64>
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
        <20230515025716.316888-3-vineeth@bitbyteword.org>
        <20230515100616.33ba5dd9@luca64>
        <CAO7JXPgq8V5yHM6F2+iXf4XJ9cyT30Hn4ot5b2k7srjsaPc3JQ@mail.gmail.com>
        <20230516093729.0771938c@luca64>
        <CAO7JXPh5uLV4QjAEi6bJXfAGSsZ=XsnCyzrvKS8m35BGbRPYJw@mail.gmail.com>
        <20230519115621.2b3f75e2@luca64>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0082.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::11) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|AS4PR03MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: d8258d4d-b7b1-4e0d-7afb-08db58525704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CCOlh6ug0G5VlQ8u6oBMT5di7k/sVKQVKO7hRkA6wxgwSFOw5MnD7liXatJ/4F5MjRnncgQx3H8vL/oN7JaJnlieNhR/x1WCbTwPNi+ep7cc0lDbqsDfTgfj1MW4KSrHAjGszI8M8CGyBtHP6GusSBPFWZdbCrl/jDHOR8zX0UOsLYQI2oaLjm7oJC4WsbGTnUlRAJNhh8Pk9IJUXiD7hWlrVwYxmczwid9AHnKl2gxYbqbsTWsK7wv4xwpDv8ixDHGmaKuYflOC7iWCczbjekeAeGMf5GVD+93q6g07uxaMi6IJ9jme7rq0e4VI2/hnCKhm/8O9pasLF5Aqg71jOFgdFLJoviYdzL+fNAu9NgfSipiVnDFfnGtFORIFwlHrZI540XmQ6TTtt4hFBUbArR1TxebpYheEG7HbpviGbNYhHmWsGD6sejhInkMh8pQ9GzPVB2r/fe9599PbPBb9nCO0B8FjUXAU++FEu3hznh2ZJVGlTsXDypP3QuWmUdyNH+huJaaCWC3IDlAJKUq/kHrvx7wTWoL1wPQaSVvOz7TnUzlhrvpzX2RzLXZ5Ffi+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(8676002)(8936002)(5660300002)(7416002)(41300700001)(66476007)(66556008)(6916009)(38100700002)(4326008)(786003)(86362001)(66946007)(316002)(83380400001)(6506007)(26005)(9686003)(41320700001)(6512007)(1076003)(186003)(33716001)(2906002)(6486002)(36916002)(6666004)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QJypVBtA/5CpZCgiKyPMYR25Ii0ROZL7wYxclYUX8ZVfmhkGpE6TRiK2579A?=
 =?us-ascii?Q?U8Kc2KjQ9F/q8UZWHOzSQtYJNLxmxx4EsCrh7cX4jZeQvPMZPXcvT8ItqyTb?=
 =?us-ascii?Q?uHnqHVtvmYXuWROM8Oy6UQ4557M5xBsD6JaDGxLAA6gm42GPY03l0UGRcSdD?=
 =?us-ascii?Q?wIBex7ovHwD54O/5Gx1rqEwdg66efq1oAJ3jVqR9ifcBODt7c7LT8lzDx4aA?=
 =?us-ascii?Q?9MtfXoVzyVBzf1PZf7UiibhqxRvzlAuDf4SNsQzMwYSAxNEhG6y6SAfVg22R?=
 =?us-ascii?Q?20DVQv2J9CeFiVbQo+HyaTiuVwFKfsZMOkrAYgxQ9L237iUYqULvBcZFYKcf?=
 =?us-ascii?Q?rSOhRpeCWwlL8KHSEoygsGHAPVAzt58o0ji4zaF1eZawXIlBuE067ssRidh5?=
 =?us-ascii?Q?/Z7UTYSQJpmySpiSZ6QAcS59ghFo6CBFcp9EskSdKWGDLMsfbm6Rlz0r/PQM?=
 =?us-ascii?Q?0dRqyz7DZQu8s8N6Rzfba+pl5+T4Z1o3L17mdom57Mgvtz/wll5P5dogEJuz?=
 =?us-ascii?Q?jQ5RvIsUqs6mSk2441AqOmYiXuUFikDdlcMzUKcgofOdZkUcyaHZT5luzqYa?=
 =?us-ascii?Q?uG6DWCfIR/mQ9ehEOQwcAOa4SaeZ1/BS8CNqcw4E5MyDUFjSPIiUhHAPE6Ts?=
 =?us-ascii?Q?X4oWSUPpAWInuCqnpDOjRS+Yy4APj6r17KIkk9EWsej0ha5brP0iGu9s00x2?=
 =?us-ascii?Q?CqdsnGRmPGRn8gSogX1dCK5Dxvt+qUQA1rVz0h753ry/d6YQ8YgrQWrCH1iy?=
 =?us-ascii?Q?kFK5lc+5hbjXnP3HsV/NP0ObnsdTe3e3vsqet4i0uB3kbtm2ekOv2+nvd3p4?=
 =?us-ascii?Q?yi9HG0+xxEXeU2xfcpkG5wbz/JMhQlR94l110ybXu2SpYfhFkZ6cJ8ujTkVj?=
 =?us-ascii?Q?RCJZ/AgxsYx51pC0o8X5mkjrcSNb44KKMRz65LLP3CBMYGkBB9n5tihNIQFS?=
 =?us-ascii?Q?WIQ55pRBpTy3/pCLLyob215he6xN68uzXZKCKCX6JO9ibL5J68m1g1yWoMhj?=
 =?us-ascii?Q?wCeNnOmF22BKAtFK6y/UcFcVAATL54yo8zC9UU0IJS5eFlNmNucKj7VoWxcQ?=
 =?us-ascii?Q?o2F4tx2yTXgwnp6vozx4IIFBOjQr7fUF7iR24rHEBSeGH4FWIIPWbkhtiWNN?=
 =?us-ascii?Q?w1LefFodk2S9FVYKiM57zgCsbT9vz45el5sXCImVwUQ/occeKRTdQt9p/JS5?=
 =?us-ascii?Q?lCl72pmUhoZwZ5E7c10vhQGOV0BrmgKqHDn/IbkLcRE2J7z6yFJW0Mq/OFpl?=
 =?us-ascii?Q?b6ht2BOA4nraKyt8a6ZB3SwsVQDHw6eHqnhlpVScXFqsn79oEsTcRLusivCg?=
 =?us-ascii?Q?NDuedjYQKMYUJTK4ChFT44NWktZJRR3iAMY/xWgEek1MxZ0aBqOTuyggudaX?=
 =?us-ascii?Q?WDSZqyIJ392J+QOccHKfstTQUFVpVJaxoozmwtTkHbkQDdSKQmoCUkyve7zE?=
 =?us-ascii?Q?G3lSfgcDRE0rBbLq1kSO909vBQM3wekm2Moi3LQRuK89bY4ChzL/THmgHFCN?=
 =?us-ascii?Q?ZMyd5L9wzFivpdlsxD9R1gPRbeztC0o6xf1gMO8mc+lQjB3Bdhf2nNdtYK3E?=
 =?us-ascii?Q?XCghh94ZYXXrZ2UN5ylY+kPXWXMG5r4oT7hC/CYgXkbm+xA/ZLAsUJ8DX6qc?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: d8258d4d-b7b1-4e0d-7afb-08db58525704
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 10:18:07.5035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+TmyVDzdJEznWobY89nOY6iMRmLZn6euTQ+CzcUOyX8GLy0YH2HQfUzos5ZRu5SZ8mnv87C7ToHkr76pSgvnurZkcVH3z4Iq73Elicded4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8697
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 11:56:21 +0200
luca abeni <luca.abeni@santannapisa.it> wrote:

> Hi,
> 
> sorry for returning on this discussion, but there is something I still
> do not understand:
> 
> On Tue, 16 May 2023 11:08:18 -0400
> Vineeth Remanan Pillai <vineeth@bitbyteword.org> wrote:
> [...]  
> > I had tested this and it was reclaiming much less compared to the
> > first one. I had 3 tasks with reservation (3,100) and 3 cpus.  
> 
> So, just to confirm: here you have only 3 SCHED_DEADLINE tasks,
> scheduled on a root domain containing only 3 CPUs (dl_bw_cpus() return
> 3)... Right?
> So, the utilization of each task is 3/100 = 0.03 and Uextra is
> 1 - (0.03 * 3) / 3 = 0.97.

OK, sorry again... I found my error immediately after sending the email.
Uextra is computed as "Umax - ...", not "1 - ...".
So, I now understand where the 35% comes from.

I now _suspect_ the correct equation should be
	dq = -(max{u_i / Umax, (Umax - Uinact - Uextra)}) * dt
but I want to test it before wasting your time again; I'll write more
after performing some more tests.


			Luca

> And since all the tasks are always active, Uinact = 0...
> Is this understanding right?
> 
> If so:
> > With dq = -(max{u_i, (Umax - Uinact - Uextra)} / Umax) * dt (1)
> > TID[636]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 95.08
> > TID[635]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 95.07
> > TID[637]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 95.06
> > 
> > With dq = -(max{u_i, (1 - Uinact - Uextra)} / Umax) * dt (2)
> > TID[601]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 35.65
> > TID[600]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 35.65
> > TID[602]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 35.65  
> 
> Here, we should have
> 	dq = -(max{0.03, (1 - 0 - 0.97)} / Umax) * dt
> 	   = -(0.03 / Umax) * dt
> which reclaims up to Umax... So, the utilization should be 95%
> Since you measured 35.65%, it means that (1-Uextra) is much larger
> than 0.97... So, maybe you found some bug in the Uextra computation?
> 
> Can you try printing the extra_bw value, to check what happened?
> 
> 
> 
> 			Thanks,
> 				Luca
> 
> > 
> > As the task bandwidth goes higher, equation (2) reclaims more, but
> > equation (2) is a constant of 95% as long as number of tasks less
> > than cpus. If the number of tasks is more than cpus, eq (2) fares
> > better in reclaiming than eq (1)
> > 
> > eq (1) with 5 tasks (3,100)
> > TID[627]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 28.64
> > TID[626]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 28.64
> > TID[629]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 28.62
> > TID[628]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 29.00
> > TID[630]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 28.99
> > 
> > Here top shows 3 cpus in the range ~45 to 50% util
> > 
> > eq (2) with 5 tasks (3,100)
> > TID[667]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 57.20
> > TID[670]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 57.79
> > TID[668]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 57.11
> > TID[666]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 56.34
> > TID[669]: RECLAIM=1, (r=3ms, d=100ms, p=100ms), Util: 55.82
> > 
> > And here top shows all 3 cpus with 95% util
> >   
> > > I'll write more about this later... And thanks for coping with all
> > > my comments!
> > >    
> > Thanks :-)
> > 
> > Vineeth  
> 

