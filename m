Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899C65F1C0C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 14:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiJAMBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 08:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJAMBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 08:01:17 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC9862D2
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 05:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664625676; x=1696161676;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NI+1UycFhVWQR0vvbeHTYbtrvlga4RBpVJV+8xzGj8I=;
  b=PMx3RxnVCusl6bQvq93yqDXfeTdRDAE0AE2XwtzJFdBs1pt5eFmWKtcz
   tQrZpeQ5ZTXhSclljTI0X9tA2RZnIUlDdWestwtT8cAOPuSS8GMhnCUyw
   89EfTtnEXC8mY7LZYk3rin5/Fem6E0X4etvS89F1J2XciBOQNhfKOvWv3
   py+OFaYGkRfS5ShadnspfBvf7f2unYIGLicztRL5wAbXOJapo74FE59/b
   X31nJnz5+BjIgEheRbP01Q308YPxMEJfWinNG+wbtLOh5mjsvKZGDu+ir
   /LKr4KnCjEoYEpurAVXZ0hAf7anUoaSQWgC0AxLSUjXvxLF2Kfdk5hL1H
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="301092731"
X-IronPort-AV: E=Sophos;i="5.93,360,1654585200"; 
   d="scan'208";a="301092731"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 05:01:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="798243457"
X-IronPort-AV: E=Sophos;i="5.93,360,1654585200"; 
   d="scan'208";a="798243457"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 01 Oct 2022 05:01:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 1 Oct 2022 05:01:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 1 Oct 2022 05:01:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 1 Oct 2022 05:01:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 1 Oct 2022 05:01:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikqVRHfIUka7UHeRsyi2mHrxG9VLE0G+aLl/CrQx4xQGKDEsVDr8skLspvaDs3Akj/pRH+/PRvCfb6rQT/sU73I29auKDfmUJOxgWecTkX2tR3Zme5LUsp4D35zun8W3XLf+FE7SMSkm60ojiFbpDP7AqorkoTVU5HSvYwi+F/H9qTJP0qRe71OAgalYuWivDAaQZQdLyCFtCaZd0c2Z6PX9uOSggRbGqN5wJagsuhD0vonoTFNLegBug+EKTqs1gz/ENqKfT27+p5aLYzNd6gUKLBFnby8o2UPOZR08spVl2wZUwKYMCryoU/71We2RnrNyKEwHSfTIAl+Pc7lh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQ5rX6oU8UeRtITT2Do3c6KYzULyruZsAORt3Oh3Vzg=;
 b=ew4wFwOMqcjCdsBBmPdJOnvZizX+HNNHLuOkzxW1Ay5XgaEyseGHw5UhWH9tsxClutXfyeQ4OlM4mIGEscBhw4sAW4fJBVmIDven8OK+X0pHjVTx6Umb+b8HUdsgMeHWUZPrw3tVfTxtp0ZwSbG66MEVW+/cks/wSEELUVtXr3AnbJBMFgoJXXVhJlPF8ggnLjvAodeo+6rDjaWCl5b3YqwUFgaTPNFXuyFmOG/a1SX7Ypu6sd3Fl6Gd3K+tDqOzbg6UmKCrC8fJsvh0xqLDRGZhM0jVAv77s0/zleyFLsrTof8lQIGiBbSnQzWykwwKjud4+6Tu7PlsQDSKPU9vAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MN0PR11MB6112.namprd11.prod.outlook.com (2603:10b6:208:3cc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sat, 1 Oct
 2022 12:01:12 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::ccec:43dc:464f:4100]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::ccec:43dc:464f:4100%6]) with mapi id 15.20.5676.017; Sat, 1 Oct 2022
 12:01:11 +0000
Date:   Sat, 1 Oct 2022 20:00:48 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Zhang Rui <rui.zhang@intel.com>
CC:     Yu Liao <liaoyu15@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        <len.brown@intel.com>, Xie XiuQi <xiexiuqi@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] x86/PCI: Convert force_disable_hpet() to standard quirk
Message-ID: <Yzgr8CedVK60orIG@feng-clx>
References: <20201127061131.GB105524@shbuild999.sh.intel.com>
 <87eekairc0.fsf@nanos.tec.linutronix.de>
 <bd5b97f89ab2887543fc262348d1c7cafcaae536.camel@intel.com>
 <9d3bf570-3108-0336-9c52-9bee15767d29@huawei.com>
 <YzY6e0UwDAyU1GrX@feng-clx>
 <44206484-620d-abaf-4fb9-fc4ef1c9184f@huawei.com>
 <YzZDLBKbDTbNr45b@feng-clx>
 <119b669e-aafb-4d73-e94e-ef119f909cfa@huawei.com>
 <YzbBOuX37XpUiP4y@feng-clx>
 <6491ee0f8d29d1498c79a91d712920ee96879b15.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6491ee0f8d29d1498c79a91d712920ee96879b15.camel@intel.com>
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|MN0PR11MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd5a931-29b3-4edf-496c-08daa3a4a1c3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hxmrpEdRGXq96TPX3KEIE81OKMwuF3GIusucwtPnsa9RaG18Gdr0Z353DsAwDvfhi+3h2LNS+VDidKaDMUEz2uByuhHTMJpo5vlziIwSy6DaRnk/6RQuq9vjtfyTGRjmuorr5T9v7bCMRd5b098fjWJs29+m3gbZDOsEW9oDHaxjLuW0pEfTRSVr6Hnr3PRTXXDPVV6WTBCM1/J7udO1HzRjMH55fyfK7GE7CnRUDOSI3Y8n1PttCkx8gJcIekaPuSf55W1ihmztVt8OITGrsl18fO2wtjptGqPobW2m46P8jEhoERL0Ev2dO4A/JW7rjX+DXnKKe5tnkvrXis6BL7qJ5Hjg8gIylqlWLk6jzd/W/Jh/g8BN8uoWQMB7eWQUzCkGPkeWJs7sMwmlVbJ+HLcRmtfZV8gUW0MaSQs89YPa7KrhwlikkWaev45k704m1XLQBOhSjy9FZnIz6DsFnRo3/ga9u+vrz68GaueEHUwi9SSROLqFymQ1ESJ0seAg7VrQ/Y3AargkpJWotkLO+ZbTzulgTN6ElCzYYGYEE74ywBSMQMZFxPYvlXF2g8z9cO83qnW1UAOSVxLDo2iUhNZmL03NQxvOHbir7HbZrQ8d0fjqacSoDTbpxdpaTbZHsCn4IDSzdWqp/4yoN0fnwjcBnBZCdLK2KfV5HNyFMa4IiuaPVtA0QCWfTov0c6uwpZmPVJXuSJoNI6nzuq4yOPndEh2BToSQi0kL0n+prN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199015)(33716001)(6486002)(966005)(38100700002)(86362001)(316002)(186003)(5660300002)(6506007)(44832011)(6636002)(478600001)(54906003)(6512007)(9686003)(2906002)(41300700001)(7416002)(6666004)(26005)(82960400001)(83380400001)(8936002)(6862004)(66946007)(66556008)(8676002)(4326008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YBN6PGB5QQy60YyTuB/HHBQ/8ZbjkOjmbqEWacdkartOPCPhvixHOG431UOC?=
 =?us-ascii?Q?Sfkj+jMdWtPVzWTto57XUUbtY8ne2c1DvCdmhIhCQAWccEIFde0g0hB3vJ54?=
 =?us-ascii?Q?jzJOS4yxKWmr7fn65wdNISVeU8M+JGikZKUv0C9NHy2LO1p8Kb9bswx7LbTZ?=
 =?us-ascii?Q?hPAEEC2XAF6iw0h0SZA9CV3fnyud6dkanDal7ZZRV38I6vdj5qpws0PgSd3h?=
 =?us-ascii?Q?dp4C67BaKTxytJit3ycjjin6fteaJVvEnzIIzfao1gVE+IrUHREcIHsoyB19?=
 =?us-ascii?Q?7FRYHYGVNlYhSuIGsxjfrCZZsVyOHG2X/XSbqQdqt5vqpGE4oBG0gsZs6eWj?=
 =?us-ascii?Q?MiC6DScspBbuljZ1lbBKXXwGHLuGgyCDFxR3KCsW21sSCHV/nj3fWRIE7zMl?=
 =?us-ascii?Q?uh4lF7Z6thCiO4YlWaC3Y8TdHDJAsITOcL4OncRPWNbiF7JLqWqIm05QCQB1?=
 =?us-ascii?Q?4oC13EPA1NPix9G1bWiQfDt5BRfY5f8/Dcw/F4CEaTrlhLAzdJCXXOUU1Kgz?=
 =?us-ascii?Q?U8zzMHn1ELoN9s3vrikmKJq4ch0D6UT0vvj76ffWcpPKEgob798d1neL6oua?=
 =?us-ascii?Q?iZxPcjrbQs1tIFruhBQjMXjG9T3rTM+Axu/oTvXhS499Su1upl1Q8ZOIrBAf?=
 =?us-ascii?Q?gX6EOZRQNZA+SyLNzZI17bZddjnE6Tf2b51JVD4xLA5Ap4BulOgwVESouH/c?=
 =?us-ascii?Q?buvyigdWQoVMtUcDJUnQfV6202UtGuKPbLnzZKqAH8X6k/bxf7YD5wHVYjU6?=
 =?us-ascii?Q?g4ugpdFQdNgMnJc03BosqDI1iNUmKw+HuYfYC/5vtLfqQ5QEWWW0CzpJIGmG?=
 =?us-ascii?Q?D5Cu7BzB/r+YEwgvPFPZYMUUx52f3pImJYWjv3dXvgJnH/cNmRauqQABt5zO?=
 =?us-ascii?Q?3sUAv7Z9gqtMEin7cZpAfsX/Lz15/p7IbtxbDC0Apu2nav4/R6i7O1O80d7w?=
 =?us-ascii?Q?A28KsC+ob1GzZ/7T4VBOVZXzqAwVjGrIdcs7txVd+sQe56uTlVT8Xb6PlTKF?=
 =?us-ascii?Q?eEpJRWGmS4JjWcKODAHAw/KwMcyKDMIBlTImDazJt3UMK9DGxh064goySh4z?=
 =?us-ascii?Q?yPFrCkOziK+5WGJmUOwMErTw2gG+ylIKv/Xo7BnnMJa1678aBuf2dAiAVg7d?=
 =?us-ascii?Q?rdf3pq1rQvW3Sr0EmVOPXkSy62/LAL5TU1fCqH0WNDNNo4N0H9NHoVr1yUfX?=
 =?us-ascii?Q?dX6B81vN3FL/vVdKpYznlgDJbNZHOSzhxHYBwLXBsCwbh/jRQLGBppd0JjF1?=
 =?us-ascii?Q?bYZKT90CqAwZUYt7lfDmzWpe3zXOtvvgSn1/UmXfZjnbN8tI2/mCaTzyOkLE?=
 =?us-ascii?Q?xwAYEg9QsrhaNy/Jfnj53T0p+ANqIxzSRSrpVuRfetPqnnmjw++jVL5zyGTn?=
 =?us-ascii?Q?rDEHsV5AoURcQRM3n0CmdjA8UYHlRLNo2BF34WmvjAwZ24gUvVvpmCNJRcJT?=
 =?us-ascii?Q?H/P9RR4umxOdtDkBcCOirBYnyOPpWJlTBH0nZGS5DLgs4qcaMekPqqMQvxxq?=
 =?us-ascii?Q?wpmdUXcGh/3gFnFBGzep0mUEUkQyFPwvCCAF3bDIuGmvTyu/2BgOKqNuK7WN?=
 =?us-ascii?Q?DV5s0WuL/FyJGJiYx6qCzmSaypFQlyo+RlRqN1MU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd5a931-29b3-4edf-496c-08daa3a4a1c3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2022 12:01:11.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xnjp9onnnbYSV+BCEkZLtiyDoO9Ox63sKhIG60bmM8tpppDwm+GVrtRP0KZgtWvh9vcxqnJ4ubSiDaDOzDSvJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6112
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 01:18:05PM +0800, Zhang Rui wrote:
[...]
> > > > Thanks Xiaofeng for the info.
> > > > 
> > > > Could you try the below patch? It is kinda extension of 
> > > > 
> > > > b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC on
> > > > qualified platorms") 
> > > > 
> > > > which I have run limited test on some 4 sockets Haswell and
> > > > Cascadelake
> > > > AP x86 servers.
> > > > 
> > > > 
> > > > Thanks,
> > > > Feng
> > > > ---
> > > > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > > > index cafacb2e58cc..b4ea79cb1d1a 100644
> > > > --- a/arch/x86/kernel/tsc.c
> > > > +++ b/arch/x86/kernel/tsc.c
> > > > @@ -1217,7 +1217,7 @@ static void __init
> > > > check_system_tsc_reliable(void)
> > > >  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> > > >  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> > > >  	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> > > > -	    nr_online_nodes <= 2)
> > > > +	    nr_online_nodes <= 8)
> > > >  		tsc_disable_clocksource_watchdog();
> > > >  }
> > > >  
> > > > 
> > > Hi Feng,
> > > 
> > > I tested this patch on a previous server and it fixes the issue.
> >  
> > Thanks for the testing, please do let us know if there is any TSC
> > problem after long time or stress running.
> > 
> > Plan to send the patch for merging.
> > 
> 
> Good to know.
> 
> This patch fixes the TSC issue for IA.
> while the patch at 
> https://lore.kernel.org/lkml/YzZDLBKbDTbNr45b@feng-clx/T/#m34094630193e8320c6d75e9c8aeabe7633e051d2
> impacts more Arches but I'm not sure if similar problem is observed on
> other Arches as well. So I will hold it for now.

I think your patch is more general and architecture independent. We've
seen quite some cases in boot phase on IA platforms, but I guess this
is also possible for other ARCHs.

Thanks,
Feng

> thanks,
> rui
> 
