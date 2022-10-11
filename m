Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBF25FADD1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJKHwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJKHwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:52:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200FBA450
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 00:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665474749; x=1697010749;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rnuWP8AcgWadC2kX42Je1qKRkbIZofVkRKI9tNOV0XQ=;
  b=WbnfzZh2C90tmNWUFC8+IJyOSCs+jLV+D+rzfwvjuVyEFQ7SnlcQ2GLi
   Xx9Ir+ixo6bvABx/t+TFMe1zXQQdaai/cyBR8BX/gR/PwzyKhT3zqKX+9
   XkRDBLsQ2f7obBYtbslJfMHDtoQGWeXbeizs3YALAWn1gjcY/+Fp2Y4Hh
   JEIn6H6dbhiJhbkOLsQ2NEpccsuB1NGMb3uhL48cjRGMnBoVkskPsE2w7
   +DZO6/BcnB+9upEQNo/WFVE5bqo67P7yO6gNGJtKsATs3rkrmqWLgLpuT
   5rLrmj6xBIHVy5M5HV6kWDxwY9/Dd5HLgyh1xtEE1+oXPAdfb0CrWjd9W
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="368601544"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="368601544"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 00:51:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="689131198"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="689131198"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 11 Oct 2022 00:51:45 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 00:51:45 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 00:51:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 11 Oct 2022 00:51:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 11 Oct 2022 00:51:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dW8O2Nn3K3UxFo+CdKJ59LH4Velf8p2otmkRA+rMw1f1IROjcGc6VSDPwG77Wn+YxTHVLuv8mz8nXcN0bLdjlLT8ycMDo7qXYYNSlU2Iq/R3toeniwF2lEB58uE/YWSugDuMobpWvQmaYDYebA3uUVPORI+So7/GmGw8fv5xMThtgQE5ILYhhdd9EoZ3O3Olnvg8Xo2XGN5CyXHcZOlcx50O9P4ysrhk7kbB6poT/LI1ozwikTu3dsnt4y4BsQMx/ogLU3Xm+cOIvQBebewE1esWAvO9peB8w3It4Rz9chnUHcBIU1I/eu4X+3mfMo837P5TGQ6uImzBIRXDcj32zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgPMV1qej+xqPercLFyRQk5/0+BRmhHbRHnqYRa/byo=;
 b=Wq9IV9c+8tZxri/qHIj4Cux+opY+Gb1pdprGdj/MWVyc+MVTQS2CJxKK6FvnYYrIydAWrJzF5Aiukxb48yD5wryeWUelM4y+vFymc8zvzPlUtWjNG2kCAWnJp7DAiD6ILEs17P8voLXWPeDCHFOnMRrlLqbyS3KiA/75ufIMN37LMMNEqiI5Fy2jKJ+P3F2Ud+kal7CGLZ0N1x3QpUlh/KQJQIOlnl6XnjLeAUVTao8hO2R4bQmIXWgWxDzAWIB2kGeHTJzx9KdTcgF9kYz4Kw9brYZ/w19d+COi/lL/G1aMapi8waw0xKBd9ebJ5sb/BFkMAciQ7mnCrrSlWp9GrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SA0PR11MB4542.namprd11.prod.outlook.com (2603:10b6:806:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 07:51:42 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 07:51:42 +0000
Date:   Tue, 11 Oct 2022 15:51:21 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <rui.zhang@intel.com>,
        <tim.c.chen@intel.com>, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>
Subject: Re: [PATCH] x86/tsc: Extend the watchdog check exemption to 4S/8S
 machine
Message-ID: <Y0UgeUIJSFNR4mQB@feng-clx>
References: <20221009051209.393377-1-feng.tang@intel.com>
 <Y0LGLGW7RSlklKyl@hirez.programming.kicks-ass.net>
 <Y0N0ENurfliW315D@feng-clx>
 <aff10f33-b379-6872-f180-b38f6a0a669a@intel.com>
 <Y0TCOKc7n38341eJ@feng-clx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y0TCOKc7n38341eJ@feng-clx>
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SA0PR11MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: 70fd3f19-53a7-4790-e340-08daab5d6f90
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0h86fvHvKNe8fsTV4Bn2GU7TgS0N+AX5sl+EQ4vNVFtDYZ/AGHWN+ywmCtLscDBSiMdrtd5etJjtQmtCgT6k0rVDlHF59VHxGz2FLtFADP5G6kwXpG9itXqxLM0O1IJA7Tcd2KU9z8sFitWq4OShaMo6rfrQKkzL3upF26yaMpiWnopxize0/i42uxOg3jciiFQBZxhKfwd6GjJx762CnE4iv/N2lEnUgxSFLj1sNgv1osFlt3KtgGAWgh9xklJN7euG0vvmPzvyTs3aQtr6VwjBN6jYE9Xv8KepNi8xUu0a4NivuhJaLf4+mqa2r0HBp5wut1/L7eEkiSbBLGZjPnu+1lV0FjtYmetWQGk3nvB1xOVzvZALgTBhrREwYg3lRVvZqiaTQ76udSOXvUDUvvxZH+ua+dtvvc5sRdpGSPdy4M189eVsNYDH6VMNhRLzCcMP9e9r/luuxvisfRUgXEM7v8GiacQfuLz7XPsAiW5hQxlLadHcU9Hfn7Po8PGPh94akGSWWC2eLRVA8S4AUGzvUhD8wAnWQGaZWG+lNRa4ZVWgiQIJiDUYD7y+h0rqJyhozAARfKidg9vTKVjGDKtMq6j+3UbjAbmZprvXttOpwpGNtW7kSrQHULAm5TS8ds2WXRv1urvcxz8ZYzCyHUerEIxFAnJ17VoHGxia8vQv3avwXmP94LQqw1qXCseUzSqff6Mt9aNsQyk2AMGJyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199015)(6862004)(38100700002)(86362001)(82960400001)(8676002)(66476007)(66556008)(6636002)(54906003)(66946007)(44832011)(83380400001)(41300700001)(2906002)(186003)(8936002)(33716001)(6506007)(53546011)(9686003)(26005)(6512007)(478600001)(5660300002)(6486002)(4326008)(6666004)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MS25G3HnUPNwcFr/8BRulK+Ewc+J7QptA1rBxUP7qrEPWxm7DjZUGi6e+gAB?=
 =?us-ascii?Q?G/S9dhTpkiEbANv+XeDi3Nq45ZiqLObvO8cMMNqSm/OkL6pzJDEZQKYCHQs4?=
 =?us-ascii?Q?Dm95mNk57u7Lfc70OUturdF1pBjVk7FamHjigCyjjJR4V7raQPdnIQL00rSL?=
 =?us-ascii?Q?475iAFLtfMhZAyg7v31G/gWfK5mWl2ii8FT0wW5Jms2K+fKoxFCB8d3BCp9X?=
 =?us-ascii?Q?WQ5R+qfmqx7B7fX/EQZsBEV07X0Zy7oPcL/SHbO5jIo9Vf3uW//tjyVLB+9S?=
 =?us-ascii?Q?UO5rfLg1Z2QkrnTR7y/mnz6jpt66UuUQ+wSLhCRSvOMqkELkG7VtkIA6q32q?=
 =?us-ascii?Q?fXgCHzJR4JTiyggkMktgwvB7ee8VjarXd9gH7NImrMFsDjYB55NRl/q+4sBD?=
 =?us-ascii?Q?A/8prim8oB8q1xtT+cnPsP6bgmXAfsylswsldB9PVnnmcxMGodGA5t3PU6LX?=
 =?us-ascii?Q?j+/TaurYfAEYCqBLolxpmX9g/EN2PZ/QCyn3OYNAukrPqvvj4lr/BvftLrNC?=
 =?us-ascii?Q?qL+SLNoQLOcBu/TrruhlWF4xoTx8727nPDASw4t+KSglJCR1+4C8i7Bmjg2z?=
 =?us-ascii?Q?3LTSGPVoGipfE4/1mLfTeh2jeFn0X1doSPdPo/lAq0ZDc+MT/mBkFSE66UIh?=
 =?us-ascii?Q?BiemqupZ+j+PDgoUzkSOWjpikK+K92+QdLWfpHr9HUMc2oq1hk3861HBoZpk?=
 =?us-ascii?Q?6nSI/sDn5EZCtEefUI8tgOyw//lGL5ehH4vqj2FgWyWvx9xSgVKdhx2IeBRy?=
 =?us-ascii?Q?OePAfIN76P0pdj8rE2lCJ8Y0TFU9pw2vuIoJyYuZR80co8CUvTYgREdW6Gcu?=
 =?us-ascii?Q?+Z2qhIg0D0rwqs1Pj69B0Y6Lt5ZqxUwXXQSkZY4vz/zIXAJ2HMV7CQpcoJpc?=
 =?us-ascii?Q?O/q5D1eOqWWQLfoE2gbLy1JG6K3AUhYjNcNZZJItb/8xqqWTozIt1SPuxmmr?=
 =?us-ascii?Q?BVm5VyLXQfWPnrip1yqJ+Go1qxcKqq5/uKBgGHMDdkrY2LKCnDG3CPCLr3Jg?=
 =?us-ascii?Q?wOFef0hGaFymbRzUsplQVLzeWnA5OVNWD7ZVtlA5UsBGL49qxJP3381PLv+2?=
 =?us-ascii?Q?ukZCcak3UOs5D2AsA0CPd0nTYOwwbrpXyrd3X+NoKVq1k2SENMKE3IUWF9zO?=
 =?us-ascii?Q?g99AuxPKvcEs8CODu3FOWxGRVjrDZxCVQeQh9474/WgsiTQf5Ks2EPoMegJm?=
 =?us-ascii?Q?3DeH6iffcQQ5EoGsXFOGBFYcn5xuclh9P/qbC88v5T4PeuwmWNrupN4P2hUh?=
 =?us-ascii?Q?wBHlRTwNunXaTD2iNJBXVYsnlGn4PER8wFjYfMEA8lyPCZ/elrjvI+j1PbTX?=
 =?us-ascii?Q?MzRpiqeAC4w0V0NvMm7N0Vs2/YE984Ki/ZaaN+8tKEPZolM6sy3GdezZQYvz?=
 =?us-ascii?Q?b/P3NSe8JAVHX9nqOf/I+3WtZxACfog8z3VH52WG1ymj4KfD9bIwKbNlQtKi?=
 =?us-ascii?Q?LUg8GsqEzHAV55QMNyrZ2/x76Cnwtq6k/l/3AKTTiRtdNi21q+RsPAxOu7Tm?=
 =?us-ascii?Q?h8XaeGBeEpSYCGIbi0dg3qg5BtdeeMu6AAotlhmx91egSEuF0fXcKXUoeDsn?=
 =?us-ascii?Q?XvV+08v41SzoJN7nLhA3tJUPNawum73/JULA18ot?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fd3f19-53a7-4790-e340-08daab5d6f90
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 07:51:42.2482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Y0t6H3bnQl97OkbgXyX9ssWEjA9easNT9T5nB27/Z+QChinP81qdWCD0i2YfNajbHpuANpWsZfeYtlmsrjFwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4542
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 09:09:12AM +0800, Feng Tang wrote:
> On Mon, Oct 10, 2022 at 07:23:10AM -0700, Dave Hansen wrote:
> > On 10/9/22 18:23, Feng Tang wrote:
> > >>> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > >>> index cafacb2e58cc..b4ea79cb1d1a 100644
> > >>> --- a/arch/x86/kernel/tsc.c
> > >>> +++ b/arch/x86/kernel/tsc.c
> > >>> @@ -1217,7 +1217,7 @@ static void __init check_system_tsc_reliable(void)
> > >>>  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> > >>>  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> > >>>  	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> > >>> -	    nr_online_nodes <= 2)
> > >>> +	    nr_online_nodes <= 8)
> > >> So you're saying all 8 socket systems since Broadwell (?) are TSC
> > >> sync'ed ?
> > > No, I didn't mean that. I haven't got chance to any 8 sockets
> > > machine, and I got a report last month that on one 8S machine,
> > > the TSC was judged 'unstable' by HPET as watchdog.
> > 
> > That's not a great check.  Think about numa=fake=4U, for instance.  Or a
> > single-socket system with persistent memory and high bandwidth memory.
> > 
> > Basically 'nr_online_nodes' is a software construct.  It's going to be
> > really hard to infer anything from it about what the _hardware_ is.
> 
> You are right! How to get the socket number was indeed a trouble when
> I worked on commit b50db7095fe0, the problem is related to the
> initialization order. This tsc check needs to be done in tsc_init(),
> while the node_stats[] get initialized in later's call of smp_init().
> 
> For the case you mentioned above, I dug out some old logs which showed
> its init order:
> 
>   numa=fake=4 on a SKL desktop
>   ================
>   [    0.000066] [tsc_early_init()]: nr_online_nodes = 1
>   [    0.000068] [tsc_early_init()]: nr_cpu_nodes = 0
>   [    0.000070] [tsc_early_init()]: nr_mem_nodes = 0
>   [    0.104015] [tsc_init()]: nr_online_nodes = 4
>   [    0.104019] [tsc_init()]: nr_cpu_nodes = 0
>   [    0.104022] [tsc_init()]: nr_mem_nodes = 4
>   [    0.124778] smp: Brought up 4 nodes, 4 CPUs
>   [    0.760915] [init_tsc_clocksource()]: nr_online_nodes = 4
>   [    0.760919] [init_tsc_clocksource()]: nr_cpu_nodes = 4
>   [    0.760922] [init_tsc_clocksource()]: nr_mem_nodes = 4
>   
>   QEMU with 2 CPU-DRAM nodes + 2 Persistent memory nodes 
>   ========================================================
>   [    0.066651] [tsc_early_init()]: nr_online_nodes = 1
>   [    0.067494] [tsc_early_init()]: nr_cpu_nodes = 0
>   [    0.068288] [tsc_early_init()]: nr_mem_nodes = 0
>   [    0.677694] [tsc_init()]: nr_online_nodes = 4
>   [    0.678862] [tsc_init()]: nr_cpu_nodes = 0
>   [    0.679962] [tsc_init()]: nr_mem_nodes = 4
>   [    1.139240] [init_tsc_clocksource()]: nr_online_nodes = 4
>   [    1.140576] [init_tsc_clocksource()]: nr_cpu_nodes = 2
>   [    1.141823] [init_tsc_clocksource()]: nr_mem_nodes = 4
>   [    1.660100] [kernel_init()]: nr_online_nodes = 4
>   [    1.661234] [kernel_init()]: nr_cpu_nodes = 2
>   [    1.662300] [kernel_init()]: nr_mem_nodes = 4
> 
> The 'nr_online_nodes' was chosed in the hope of that, in worse case
> the patch is just a nop and won't wrongly lift the check.
> 
> One possible solution for this problem is to leverage the SRAT table
> early init which is called before tsc_init(), and can provide CPU
> nodes info. Will try this way.

Th simple patch below is to have a dedicate CPU nodemask and set it in
early SRAT CPU parsing, still it has problem when sub-numa is enabled
in BIOS where there are more NUMA nodes in SRAT table. (also I'm
not sure the change to amdtopology.c is right)

Thanks,
Feng

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index e3bae2b60a0d..e745053a5f9a 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -31,6 +31,7 @@ extern int numa_off;
  */
 extern s16 __apicid_to_node[MAX_LOCAL_APIC];
 extern nodemask_t numa_nodes_parsed __initdata;
+extern nodemask_t numa_cpu_nodes __initdata;
 
 extern int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 extern void __init numa_set_distance(int from, int to, int distance);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 179e0b1ba5cc..a2a7fc5aa15c 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -29,6 +29,7 @@
 #include <asm/intel-family.h>
 #include <asm/i8259.h>
 #include <asm/uv/uv.h>
+#include <asm/numa.h>
 
 unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
@@ -1218,7 +1219,7 @@ first_dump();
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
 	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
-	    nr_online_nodes <= 2)
+	    nodes_weight(numa_cpu_nodes) <= 2)
 		tsc_disable_clocksource_watchdog();
 }
 
diff --git a/arch/x86/mm/amdtopology.c b/arch/x86/mm/amdtopology.c
index b3ca7d23e4b0..6b982a16cc38 100644
--- a/arch/x86/mm/amdtopology.c
+++ b/arch/x86/mm/amdtopology.c
@@ -152,6 +152,7 @@ int __init amd_numa_init(void)
 		prevbase = base;
 		numa_add_memblk(nodeid, base, limit);
 		node_set(nodeid, numa_nodes_parsed);
+		node_set(nodeid, numa_cpu_nodes);
 	}
 
 	if (nodes_empty(numa_nodes_parsed))
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 090125b3ee1f..82798fee97a2 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -21,6 +21,7 @@
 
 int numa_off;
 nodemask_t numa_nodes_parsed __initdata;
+nodemask_t numa_cpu_nodes __initdata;
 
 struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
 EXPORT_SYMBOL(node_data);
diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index 7688117ac2f4..11b08b317306 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -59,6 +59,7 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 	}
 	set_apicid_to_node(apic_id, node);
 	node_set(node, numa_nodes_parsed);
+	node_set(node, numa_cpu_nodes);
 
 	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%04x -> Node %u\n",
@@ -106,6 +107,7 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 
 	set_apicid_to_node(apic_id, node);
 	node_set(node, numa_nodes_parsed);
+	node_set(node, numa_cpu_nodes);
 
 	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%02x -> Node %u\n",
