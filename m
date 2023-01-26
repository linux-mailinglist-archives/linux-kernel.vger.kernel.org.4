Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D98667C262
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 02:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbjAZBat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 20:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjAZBar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 20:30:47 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392834698;
        Wed, 25 Jan 2023 17:30:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIksg/0xEFd9K2mlUFc3EXzjRXfnSFF4Bx599B4o4WAIFtbwcCLKLZVscD6JeEk3JLfaFHI9oO+KWo7rxJ2XVYqdixVRE5i6BG890ytUtQ0qu/cixCM4MnakkuAjdlKK+hYVbkV8LbfhxF9WNiursbS2sfwuHK0ILQxfyOOKej29L9xOagpJEZGmgaXD2Kgndhd/SfnK4nbUP9Hfg5c50/UyKK4oG/t6JuxRBEyvW+cuVnOQjmhYWpIrpBjp7AzqM7n92uzVz2JTisLH0hWlzV6NLWOUnahPaJ65rtd61vs4RUm12iVHj9qOVEEA7ZeN7tjaFjKTUzb2ivbNStN8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43UBva+5P//eSYik33ihCgRfakSPt/7xnhsazArjFm8=;
 b=Mw6swPQrxDv83UJAFoXy5It0wsx46FLn/aZZRq/liczM+IB5ZMmIa2Q14NPWlQK/wxfILvNS+WBBS7H5DSE/6gT/yY763ajwUa11umjxb+MnrWcIyGOg9lGtJ9f2t6ziD20EBjuVbg/to1+2pJCQEjpD4qN4XrfjLitQTR8fiEgUaVFMk5VvvhuARiXerrMLDUG859UbbaA/KBjMZ98WLRmDWejYw9B/Y9BRYKUAkvC3h0C4vBrJ62onLUm6NzslTQGGvQbQxjrbQGHzUdBJ/ibc/qhuwcg/4++ppz/bxSrN+m8kI1b6SLqY98R3pm94kiLKpawVEQ0QINqJ51Fp1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43UBva+5P//eSYik33ihCgRfakSPt/7xnhsazArjFm8=;
 b=Bk/6Y/tYc1Za/B9e29K2yEZsjU2za4nItYEYDQbsmekIGWG76pCMwl2lIL+P43BUWbaZsA5/OhGbFlM1KSSoG+FRxjs6r7E1N35T+54N87ykJEihtQe0PrMx1VExwmZKOpOUEWMlZLEUaD2fVTBSR22C+o49lUyYLDgioZ+i1+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by PH0PR17MB4542.namprd17.prod.outlook.com (2603:10b6:510:9b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Thu, 26 Jan
 2023 01:30:43 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6002.033; Thu, 26 Jan 2023
 01:30:43 +0000
Date:   Wed, 25 Jan 2023 20:30:32 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        avagin@gmail.com, peterz@infradead.org, luto@kernel.org,
        krisman@collabora.com, tglx@linutronix.de, corbet@lwn.net,
        shuah@kernel.org
Subject: Re: [PATCH v6 1/2] ptrace,syscall_user_dispatch: Implement Syscall
 User Dispatch Suspension
Message-ID: <Y9HXuF95LeqSWTB9@memverge.com>
References: <20230125025126.787431-1-gregory.price@memverge.com>
 <20230125025126.787431-2-gregory.price@memverge.com>
 <20230126003008.GA31684@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126003008.GA31684@redhat.com>
X-ClientProxiedBy: BYAPR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:40::28) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|PH0PR17MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0d2673-10a1-4e51-b7f9-08daff3cf0ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9N+4Qcw+K/I9ANd23LeoRH5NYFXFvtzgTUm+Z7mYSEER1v2EDmKYsVCU588am+hDIFAR+6ynsRzGRBqJBmYhDjXJGhPJol7v+fCOKXUk3MCvcNEIIq9u5PNFZJ/+ZyqL6+xy2IVIGaIDZT7fd/ftuI2yMVu+Jd6d5HiJfl+U3Q/zBjakNi+7c1fRf/e9An6BWDOYktlLn+uvFO9RuCyu9I9u4Pub8OjdzXw1BKo3Zi6JLhtFK1qCzpWl1lSeQBl4RtvnD6Hk+ij0zAo4eGWXmV/n52cZZNY87d0NI1/uH7xMkxVK2v2M/EimJARbkiEFBas3PDmr/C5Z5e3kNSfbSFUCv01A+ygimEZx6D3R4uYo3LMkAE3DgNTgrjP9rdEzuj+SGpdgMtiPOA1tyJD6NNeyeczkB9LJ98nbirChNkXVsp0zpiGAFNqrS0u805k66zvwsP/F3IDoIr0MQFJE5ECGzyjzRCLXMTDTotyE9QVhjN6/Txc+Rqr1t0vFv0hVuUlZVb4mMPLsr8ZG/DaEms96F5xvvyUkaIBUrLjJk+JPvkADeMEbnhTMRXF1E1gKeGsdIwSdhkrhwpK76J9d+rOzcA7ymm2/K8PNoxkLdZLsgA4wIwNYeWDTYvltRd/l218LHl6vo5MO1uyfELO5sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(396003)(346002)(366004)(39840400004)(451199018)(44832011)(8676002)(6916009)(4326008)(186003)(86362001)(83380400001)(66946007)(316002)(38100700002)(7416002)(36756003)(41300700001)(478600001)(2906002)(6506007)(66476007)(26005)(6512007)(5660300002)(8936002)(2616005)(66556008)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?44/xvCWfUkfGhflQaLz/SErdsXWTGqaf8tLmco+wUn8qdjjsfQIHrT/7nBo+?=
 =?us-ascii?Q?gU3iRT3yFHB2P/9w2HHqA31tZ+fIzl1Wz+37UAYx/aNKuWwoBaMPtzRm9Mpb?=
 =?us-ascii?Q?pGf6UMp5ALHbhUqoTpAdMALoq1wliiq+8p7luYcc7MseBko/IiFgT4unMxec?=
 =?us-ascii?Q?Oa2VR5s5VwRt+YxkIQcjtkaCTwL8n3drREAQM86qkLq14Kl/jRiZIcOUXBbV?=
 =?us-ascii?Q?eAadoYhVy2j9GUb9Pwnz4RIZT3tU9elFR/3L8TxvGDtuvnKSrQJnk73Hur1H?=
 =?us-ascii?Q?mxO/WyimZut41Ab8/TVj3CeMwSf1FBpGL/QMTk6+mSloRLK8clYbbaeYa3Sl?=
 =?us-ascii?Q?Bi95U64+Dz8MBUMa8xKmRWjfHeqjM3DoUXXsEkk5BAZw+UVPGDMhYdgVLoV1?=
 =?us-ascii?Q?/W21PDP3cRQBU1QqeYPdEjrt052QxQj+czBcDRgl6pxAwDw+MarLhlTDm2dp?=
 =?us-ascii?Q?/ovPoInTlMCTChWs0YDeVYEcUIIDTGo/L0oMgUOC/kTHe1hltzl98ug/4CGN?=
 =?us-ascii?Q?27My0QKV/opZPvLLsnmOUcRTyPIyHvb9v+fR8UP39wfNDHYianHKdzJ/doy9?=
 =?us-ascii?Q?6B5GO6GuZiuF23V3vVpBC0EfPJVBFIX9kGCygIPpu7FD9Igy2f10oh40G8us?=
 =?us-ascii?Q?0QsoY/avpZLrAYwlwXcZdAWR4SwS2uUvgYDu/yIRYdgDgZAVuTNtBbuuYEQl?=
 =?us-ascii?Q?FTRTBjkp+YLFqyzzxrv5evq/hIjke9zwkr9aSHiWBWK1W+9AfQkwOdnT+PNT?=
 =?us-ascii?Q?ctBSzJUyqi3Vn9Ib1Toe+X2KTmy7FyO7QVw8oRw+f1ks3G7CGu8lL6ne5TNx?=
 =?us-ascii?Q?SBN+Qo1s5TXNB8iql5VpDG62axy7bNxHNs1LZq8ipemR/FOeeLXEgFbfsd5t?=
 =?us-ascii?Q?bTbNtytFPkyjT010oYp0PgA9uQyR04A1eKbywpVnds5CXf0PRfguVaVWoOk8?=
 =?us-ascii?Q?wk7dRFG4m6wB/PY7lLl1y/gLwcecZixOSVPOVQ8uXUo55G1/9tf0wh+7/Uv4?=
 =?us-ascii?Q?VeUiE3K8s9wTXHtIhRTR9mDb6DPcIHvvd6JcBCdcxE+kc6HCEQAnv4Aupvjz?=
 =?us-ascii?Q?Tl4sS+St1t0aA/VkTQQ3IwuzJTBzSOarmmMI+vuBsZDPOxsc9f2Rk7S28kHC?=
 =?us-ascii?Q?WG2WsVmhoEV5J6Sech4pbnfzdGN5OeDPMHejc/aTsbfF0eLpkplDSmk1YZ0e?=
 =?us-ascii?Q?sT9l/oCrPCsunk0jFbzfxa3LLb/DFbUmfMMZpnvgVjV2W+IdQqUtBMVOIwEi?=
 =?us-ascii?Q?dmQREcy0Xo8pa+Rnv8YER0CDUq3ST4NaS6moNkn0XWwbKQKx8/9ohNjP2XZ+?=
 =?us-ascii?Q?ymwdsjJCVRxOLHZ9t42aYCxR8kSUyfSc/KvXWPhtvegDDPZOv4Jtqs7E+cOz?=
 =?us-ascii?Q?xMbdY0tRtPteMg085RkRDRfJZ/t1/A2RURNfjdo/UU6owpljIEskd096wdr4?=
 =?us-ascii?Q?9Ik0ct0TpVzj5944rJSUikwAKpWF5Qbx4AebWQvPmahW+KHU4cSmuXaif0ZU?=
 =?us-ascii?Q?RaWixLum7aGPlFTCuSHbtr4kr5gGxqtRypJfH6Nnw6neZWsFT6UZEjqfbUQj?=
 =?us-ascii?Q?A7ox0GvIKq129T5PaqFm5zi4/nzZoEt5icqSnlez2JJDjWivy6zQY3+ZuOyJ?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0d2673-10a1-4e51-b7f9-08daff3cf0ae
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 01:30:42.9636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVBEH0ORLFVa/gwpmK0srKilv3byqiMdhaKrJtSomT2LJRsXkJDOg9SsZX/JVABqofZ1X+6KRQPtbQ9YBZw4IAvocbItV9VsaS4IUt2Kt/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4542
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 01:30:08AM +0100, Oleg Nesterov wrote:
> On 01/24, Gregory Price wrote:
> >
> > Adds PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH to ptrace options, and
> > modify Syscall User Dispatch to suspend interception when enabled.
> >
> > This is modeled after the SUSPEND_SECCOMP feature, which suspends
> > SECCOMP interposition.  Without doing this, software like CRIU will
> > inject system calls into a process and be intercepted by Syscall
> > User Dispatch, either causing a crash (due to blocked signals) or
> > the delivery of those signals to a ptracer (not the intended behavior).
> 
> Cough... Gregory, I am sorry ;)
> 
> but can't we drop this patch to ?
> 
> CRIU needs to do PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG and check
> config->mode anyway as we discussed.
> 
> Then it can simply set *config->selector = SYSCALL_DISPATCH_FILTER_ALLOW
> with the same effect, no?
> 
> Oleg.
> 

The selector is optional, but the core idea seems reasonable.

Though I think this complicates the quiesce vs checkpoint phases a bit.

My best understanding of CRIU is there are (at least) two checkpoint
phases: quiesce and checkpoint. The intent of patch 1/2 is to aid the
quiesce phase, not the checkpoint phase.

In both phases the `compel` code is used to inject system calls, so
turning SUD off is required.  That can obviously be achieved via saving
with get_config, and just clearing it entirely with set_config.

I'm NOT sure whether the `compel` code can save settings that the
`cr-check` code then saves to disc, or if `compel` is standalone. I will
go check this and report back.

The only other concern is one of how it's restored, and in what order
compared to SECCOMP - for the absolute insane case of someone running a
SUD task inside a locked down cgroup? Technically possible (TM)!

We may find that the suspend flag is "just easier" but not required.

I do think more-simple-is-more-better, though, so I will investigate.

~Gregory
