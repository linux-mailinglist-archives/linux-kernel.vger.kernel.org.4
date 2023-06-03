Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2E37212CB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 22:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjFCUyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 16:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjFCUyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 16:54:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488ECA6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 13:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685825670; x=1717361670;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xQNNKZSZj8kOZ1HvTKIvKugYjmD+glNRHzfgoZsyTBI=;
  b=oJu9BSfxPTGvFcLeyd41rDhngjFufsxh+o5+dRWE0TemgMVUSIbl+blo
   RQgadimEu/v3hP89cPZPjrmYcbRQNtXq+4U0yzbVysHl9/OoOe9N4AI7C
   8stpeDDb6OK8kxGfNNVWwKNASyMQ3ZUGKcFKf188orbP+2IThrg1hf/N6
   8ffBwbghiZY9h8PMumWFF7pep8uPr4VySFXUdAE9ctjai+iwucclAVAm5
   w4FHhVSvPiZbh+MUKTLzlxXKGj2pdkwSI1Kt5Iy/IqPUabjIj3wKp6rKI
   +T9fGWF9P7VF+6ubxVOqKrJcac7cJUtwoCDMHPWHOAMFM8QHvbAvugIBi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="358555069"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="358555069"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 13:54:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="658633029"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="658633029"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2023 13:54:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 3 Jun 2023 13:54:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 3 Jun 2023 13:54:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 3 Jun 2023 13:54:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 3 Jun 2023 13:54:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbb139wem9wFvVaHqqUPd+dCmtB1juzvaXFciwMdpknNfEhice/uKktbuUBhZ6ThTUm9UxicHrPihAOMN7m9ZsrTEn3WZ2TUGnWazGj5X2tVfO8i/V34lBHqtD0uc3fSN6jff7CdHsrgmxkuor0ccYrDbXFoh0BtA4ZQYkHiK+kr8wbTHAoJQaqyJVVEq1SB737N6miH2QiwnmsuSLTcJr3l53Cka7fRKHKj0UChso8ZJKZJuy6t/csKAe20tqHt/85x/aumaH6PyVVrYqv5KjEog/+O1EEBKNPYyrCeZxPoyuZp4N5E7PBU6UrBRs6M6gGfSLFygXsP9Oj+6tVC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tKVeSLb8Dxb5e+ejL/RuSrkorBibVI4xmMY0ydNuBU=;
 b=Mz4rr+xaxoy3LyylcMOcrPfwevmlGVjYs+OOcJGkNfHXQrrD6+ktmsZ75JjaG80jTYy8lfYSSZWc9Q/M6Ca2G3ATX6B5KIKnLZ9qBAulyDQUoe7FrE1cl8U3pyBYlZcKL57z1ZvhIU5ayRs8IqbxdymPclx0xWhI0PQHb02RxwzyWvr9FNQ6VHsRXaI3Z1McEhIsOlrZxU7JuwXqQyusPuQJwuWPz6v9Gp5p7cipb4UYESAdK2MTa784cNI6HmctJ77yGP5OBWanFKpfiTiR9yz9N4R58uV45GPBhCN7KLUHec1t9wnUgrxxmHInFT21osR3CWuMWAicOkPuSSN8dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SJ2PR11MB8404.namprd11.prod.outlook.com (2603:10b6:a03:53f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sat, 3 Jun
 2023 20:54:23 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::ba9:70d4:f203:ff75]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::ba9:70d4:f203:ff75%4]) with mapi id 15.20.6455.027; Sat, 3 Jun 2023
 20:54:23 +0000
Date:   Sat, 3 Jun 2023 13:54:19 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 4/6] x86/smp: Cure kexec() vs. mwait_play_dead() breakage
Message-ID: <ZHuoewLHjeyjW9vL@a4bf019067fa.jf.intel.com>
References: <20230603193439.502645149@linutronix.de>
 <20230603200459.832650526@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230603200459.832650526@linutronix.de>
X-ClientProxiedBy: SJ0PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::28) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SJ2PR11MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c34bb1-9e35-4766-23cb-08db6474b57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xs0vC7NVzLOX7sByzceCn/uEbh04XjZpeA4zpjVz2nv3AWL9pI4oLGCMPkufdszuvDrd2fWuiQoabYa9yMj1Vve9+YBxE7Qfy731/dtyqGmJ7odqlPWVgvnGRLJS+2ZzVXYce5uhLAAJiN2a8Av/7AMwC7Vr6yf+zaXBhzmeej14rj4EVb4c+1+PeRepX6/w2vE/GxLc6RJ5PReKagC9O3xmxc6ypqzxEbcTka2xrTnGgLcrZ6Aa49uG6qtgAJFUhxva+Yyy48xG50/x86N6hxxBuZXiOVRrsltlTjX7qhD5upF/QXinvdVbFXJGmrES1AEsMoMO/kTHgcxq1nxxxbra9VqqKR0sn4RWwiIL5R+BYgjSHTrhMGrnloMxIgJJOnnHSGEcPJBTOaSRt1PHTDSREFI1EPmGn22M5zwwIX+S9/tWwL++YIXl/FMM9MlkGjw3HlRuodnaY9Oas+ofxNsygXZqPZFEEa0eS+trAM6c41ePAQwHAVTvyizeT/QS05XpxcvSq+fDVcFUj8lzzamtKUEQ3oZUB7en5P4MXIkmXQQ2L3NQKI/8g9+Lw9r3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(5660300002)(82960400001)(86362001)(38100700002)(8676002)(316002)(8936002)(2906002)(44832011)(41300700001)(4326008)(66946007)(6916009)(66476007)(66556008)(54906003)(186003)(478600001)(6506007)(6512007)(26005)(6486002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ezg4SwG8VbU19fcjcuUQvSKExb4HWPQCcY7bb/9BvDM7z4YrtgoRaJCpyrd8?=
 =?us-ascii?Q?JJi/FnplNGbZmMzKdvIgr3mZPQj2XOjRg8q545ikhC0v2rTaDcXfePeDJtgZ?=
 =?us-ascii?Q?JI14t1XnAKeKGEZnGHIpaKSpQbAYJBQaEdzZpINwegvve7M8tmo1y4uMbvV4?=
 =?us-ascii?Q?PnZ51vYHk8X41rTBzmqVkRM+ATj9/n/07RgE+qmk6Sz2lj9DltlAH6pbQkHJ?=
 =?us-ascii?Q?SRI1145Q27c8k5/p0HG4nPgMIm2kGxYlXRYlRSnRv2pQgbyeirpg9PnAWnL0?=
 =?us-ascii?Q?UcfcU7iCW/JyvnO08b1lmc0SBTpYpKVmU2DaGYPE0BLKZueLUBso9FMUrUVu?=
 =?us-ascii?Q?/wkFqHDG9meM2uXZms/izmpUnfombf3k5PwZW6byHGUDuYsukZQnyHW0dPec?=
 =?us-ascii?Q?ga6/pBFeAE/foL+akeUUzDG6WygBMv+HtKGbSzUQcEsmMBZ/qglmp6c8YJBk?=
 =?us-ascii?Q?ldfhEiEufb+i8PV6nqtSdHpNeDolghFYlIRnhwCBrJK07HRgcqaW7+dwa3TF?=
 =?us-ascii?Q?cVsjdNdDYbeg4YMaASHnDruuQiAtdFvAXLQu7q5DSh89kJ9gC3CyHzQoZT/e?=
 =?us-ascii?Q?OkwC0r4h/rz3HPV5sslg7+goNorkXzTHrpeV1aSqJOWQoEVsiWVb8wLr4uvM?=
 =?us-ascii?Q?I8Jvu+DEkDK3uW5ZsUBEapgOqLKZkgCkkjUnwgRUXYvhtzP+I/sfVeErjsLj?=
 =?us-ascii?Q?UVAgx84e9zv3LW+Q7CQry6sXbM5ur2TYBXMSM7AVbqBp1UFYg2uIWEiSWwPm?=
 =?us-ascii?Q?fps/g9/CpyuMx4okLvyTeTS9ypXIdUR+bz+uk8yAg1oLJFBeR374+BUDCPK0?=
 =?us-ascii?Q?fbE3y3uJ4OfEFNy4+VrmymosiSe2HiatrHmxLdYXj6EHOamINYZ6j2cp4eCc?=
 =?us-ascii?Q?l32uYXH0h+OlixwwLyfE/IvJbZR56K0yrvohe0IPOSzrNH1yv2S4HplLOFnW?=
 =?us-ascii?Q?ZohbjcOD+Bv+a7T8Ii1k/QoDbGyeSWl7yOQJbRf5OmGmjPN/j7bDm33iP1HB?=
 =?us-ascii?Q?5+hPu2kjm2HmIycX5mJokKdsP5CEcdWKiwP/FjZGpnZTmZo5/vuIUFdPr9hW?=
 =?us-ascii?Q?p5gIGVc5PQm68iEldepb75H51dJdYF+O78MfPQBfwSNByKXF27SAvmWwArsL?=
 =?us-ascii?Q?7xpJ5Mg4XPCCaGEIB+w5iwxJhzsZffYFsLukqneYK5en2HYf/3Ns3jD7RZGX?=
 =?us-ascii?Q?Ng1k2oY44HJzHcqCpNcuasFcZW1E0PHFuZn+tgpst+dNAoZGDXYmyc6F91GE?=
 =?us-ascii?Q?Y0YbohnxBQTu4sfg3w26NztPnnNbUl6XsQs1VYQVO71OExNzmhkqyFVpfhZF?=
 =?us-ascii?Q?m7lGmPU3Zj+MjpDDdVQ0R47QDYUMaL4Zm7WFrxbI9iH71lzXgBhO0jg+PK7c?=
 =?us-ascii?Q?GXbho2XmuqDVmutn10TuRbMxyrxoS72Wg3EUSR/ABvFUGnBKtUUJyezSpBmD?=
 =?us-ascii?Q?3FfL1j8PkTvkEgaBD2Rqu4wxar895cn2qPYKAa64/MytIVNVzbBW8SmEUChC?=
 =?us-ascii?Q?PB/2n8H+czqwr1+QUoyGac9HJPaDxzA90bimRCnemeZsYiScveZI1UhytITV?=
 =?us-ascii?Q?XFr7G9Z2bm4CS/37fNV+4RnluD86AxIhWh7vyEfT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c34bb1-9e35-4766-23cb-08db6474b57e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 20:54:22.8785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/+Leo/Kbo71nDXZRq1G+ekCGesOjBoVhg0VkSRvJN+sl86yanM+GvBPH/YQnCT6+h8+oqF1fl10iQmNt+u80Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8404
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2023 at 10:07:01PM +0200, Thomas Gleixner wrote:
> TLDR: It's a mess.
> 
> When kexec() is executed on a system with "offline" CPUs, which are parked
> in mwait_play_dead() it can end up in a triple fault during the bootup of
> the kexec kernel or cause hard to diagnose data corruption.
> 
> The reason is that kexec() eventually overwrites the previous kernels text,
> page tables, data and stack, If it writes to the cache line which is
> monitored by an previously offlined CPU, MWAIT resumes execution and ends
> up executing the wrong text, dereferencing overwritten page tables or
> corrupting the kexec kernels data.
> 
> Cure this by bringing the offline CPUs out of MWAIT into HLT.
> 
> Write to the monitored cache line of each offline CPU, which makes MWAIT
> resume execution. The written control word tells the offline CPUs to issue
> HLT, which does not have the MWAIT problem.
> 
> That does not help, if a stray NMI, MCE or SMI hits the offline CPUs as
> those make it come out of HLT.
> 
> A follow up change will put them into INIT, which protects at least against
> NMI and SMI.
> 
> Fixes: ea53069231f9 ("x86, hotplug: Use mwait to offline a processor, fix the legacy case")
> Reported-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Does this need a stable tag?

Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>


