Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A44676AFA
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 04:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjAVDgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 22:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAVDgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 22:36:49 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DE523C52
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 19:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674358608; x=1705894608;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xgbxjCNRq0Omec6zZwVUMCZABiMPwCULB1RJ+KkKh3Y=;
  b=c3c9F3p3Hynx48pLi90y4LIIz1kwVTEt8jxkqEMVi0eCkBUFwsDVR2wF
   EajPJZ0hjSwQyzg+k+iX/F3nNPWcg/ezu/vHT1wtetrByTelxkKX8tqhS
   k56NgsGGt09RN+bqyBhyhzY5hI3FAlpggsp5UuZh0NHXM2zlV7eG1zAjl
   F40wFmsz5uuf+jlGYWk8bOrTGRu0bYE53WkOOysqC+um7mjFtLat2npga
   Jol7haZu8K8pprCn9pCgfcE3WDD75v7ndVRWg65NZnK1GYfEx9WKZAa/I
   1H9Zu58RnLsG7XG/sa90POvo89oRp6PojE3I8HHPsYc1HXm697rUiaA01
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="353121125"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="353121125"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 19:36:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="785000326"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="785000326"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 21 Jan 2023 19:36:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 21 Jan 2023 19:36:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 21 Jan 2023 19:36:46 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 21 Jan 2023 19:36:46 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 21 Jan 2023 19:36:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPLM4EsiGEZnMMZ8RlOfxiCd/zhBgm0pXKuydnT+dA7591XCa7VPLWCWfhChU6btBWfloWABB2UUILdXIRvER/s5tXA6rWXMiZw262b5Ml9UPp4QvByCJSggIYSb7XzAAJ6mJ2yU0UyAhAY+pK4EEWn4BqzVHVN6kJ6ytBK0YnEYDWRNBzh99xYS1Mw0kHC3YSPn6JQJ3260X7wD2BCOjzEFANwaBZ0G+OxkO4AHFIkzcMM4e2BSmDMXefnmsOI6hNd9Oldj0v8dNGjAolXx/l50UQ1XEKE/AsubnIUvV0GWEFN55UF6Ia4y/RTM5IOFSKrookTUeHJohDq5gQn0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dRbzZUT/TmKYO/nivnvE45DvF43wOyogsdR2j8hTqA=;
 b=Gg+zW3V0r3/pUGojsxG5P1FmZyQ44EmBVw+hlABmQ1UjJIT8gStt+59VchX1PrFp91xxHP1gtIbT4xJnxgo7iqSvhtvApb2+3CC30QocayLpyqlK4JJBQzOOX+Y10NKLVWMH9whc4YaM7ZFZX1he9YZ2mQUG75j31PXyEGjRUpOmnYH8kgEZ06m0Hia5vG/gFyfwT5JKxGZNQTNOkjpqt0YgHwozfB5n9Avamkb2pIAzl6Lhvv+eM7IcqY4M30yYWxlxR6aytTTkOMv0aPNwktNeaZvA1uXVODRpWPAi800jilnMxzA4hfYLiE9YKct8hxdqJcasDfN4KTMDIwoOHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Sun, 22 Jan
 2023 03:36:41 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%9]) with mapi id 15.20.6002.028; Sun, 22 Jan 2023
 03:36:41 +0000
Date:   Sat, 21 Jan 2023 19:36:37 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
CC:     LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Part 2 v2[cleanup] 4/4] x86/microcode: Do not call
 apply_microde() on sibling threads
Message-ID: <Y8yvRb3Af+2V1+r0@a4bf019067fa.jf.intel.com>
References: <87y1pygiyf.ffs@tglx>
 <20230121213512.251578-1-ashok.raj@intel.com>
 <20230121213512.251578-5-ashok.raj@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230121213512.251578-5-ashok.raj@intel.com>
X-ClientProxiedBy: MW2PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:907:1::31) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SJ0PR11MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c465eda-bf9c-438f-880f-08dafc29e01b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iw1iZcgv7+piiEKCI0C69W28xemTSfJ+kBEdRz+uig8QVgBWec5yDbjBZpgvYNnGjdCQ9FPBOHAs0GJ+5e3Iyzr/wGkjsS1T7V8PcgPoTLhgwHW/txUbXOumFUKwhkyC0DQnb6X2NOfmCRkDqIiQUu5Bhk6rgEAgrewJJL7pTQtXrGInop2z5OyQRk0Bz7ixW1rjdzW0jtlctrWTg8TVVbs/8dNtNBWN86SqNBNBtRB8t/w8KYSeJcOLF3DFy15+z5kn9KE9wFTZ5VPEGmUwsySuDzt++eDUbqQ7+iTGt29gDGmrOZMyoDgTsTAOjzBeE7s27IoCCYRg6Z0hVIShNK5axJ6DvI3Q1J3JbV5UlBwkCxFnRvfICXDi9mjtkmuUWpkgv+vQu+FRucjRvCmJ5bALoHJ7R3bj08UFFByv7CSMTihnSHaVbZkaCNmcndX7DfVOrB+ZIWokqcMq4gr3vbBDkbxVnCDCQNlaKEKaiKy2ypbwJhzqZJ3ZgDXhv/atRMyeAISscMcNe3rqZ5bmBPKbFfeny6NM/fjMEfCVofZj3fQMPyavkOi1WinRCgJ70alixDmVssZHhR88x2PMzxXhHqAcFRZJyjHbUQDGKeJTNZXhWmLeuOUrLkZUkA4kmKQj9xySLdawlQXeCgRtUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199015)(86362001)(66556008)(66476007)(8676002)(4326008)(44832011)(66946007)(7416002)(5660300002)(2906002)(8936002)(38100700002)(82960400001)(316002)(478600001)(107886003)(6666004)(110136005)(54906003)(6486002)(41300700001)(6512007)(186003)(83380400001)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PRCXjnJx47kpUiTY0Wi+eGOJd09Ayk9/LHjx+w3ZzNom0HmeQbnr4UF58KaG?=
 =?us-ascii?Q?MJF48pcyKZ3/RG+eBksxhcllszpiKV+9smJhqj/pRwecvCQh3JTscA5EFYAo?=
 =?us-ascii?Q?i8ecPpsmtTMSAW9CgIeDgmK8vOJf5pIu3vNOYiBqoyBchbT3I4VnfWa2O1te?=
 =?us-ascii?Q?DJrN7aHzyxv+hy9wLd/ixfFkjT1dTcm5VIWEB0czP/ES2Lqxu3FEm8ycpTQX?=
 =?us-ascii?Q?teVT9061iuiq6MhGlFimgeSCWGfUL7/NQ73/GCXNQtHBpobVo+vgoAgJc2++?=
 =?us-ascii?Q?h/gELiue33gSHiA8bijTGSV+kzTNjTRpYASr7G79tW3ocBFV+B9HWOWDgxkK?=
 =?us-ascii?Q?J0MpUyazUIqZbWk+6JLJHxf/6kPAmzssd0VsDpy6jSgU+S3SOY6K8mXxeo2g?=
 =?us-ascii?Q?bgiiaRrC1lXmY/Zu6h9sv8M1gr5U/MEvk8TjHlK98Pq9gDHmD+Yw9d+wiUY6?=
 =?us-ascii?Q?NKihUQlBAymobI140Z+1aDQQWEllYVmOIU5sgeafglWPk4NYWzAWtQTvFXT3?=
 =?us-ascii?Q?cIw+mwe3/vMtXPw00kkC7DdzveK0pnnRVlwtT3qUTufVtDUAOjFOKNg9M1y8?=
 =?us-ascii?Q?z6Klcbz3B7KRvPMUVL4+WcD8QKZ1sF+OcN+J1UQkGc0TVwzezgCChDoHW9qe?=
 =?us-ascii?Q?Xu5gdwmCDnQni6lWXHY8Qb0Me+npViGvRCGIZDrPsio2PaZdFARAn2hnYvb2?=
 =?us-ascii?Q?T6YePNj3YzAPMLqIkLYFdLgbH0UelE5m9wwU0LpdgbdLXV2iBQvwW1cTvzK/?=
 =?us-ascii?Q?yzhy8OCbuBwN4NnOgJFq7XE7I/AJ+O21cm/flDQzOVNxqk5EJiysNi9ya2PC?=
 =?us-ascii?Q?4Ih2MlC1/BoNzSm9HJTtRUOjESl4BdjF7kfnTXOUjBKweC7tOE4MFIgmLqER?=
 =?us-ascii?Q?WAWe9RQ5mTdiDCYroGUq8O1N2LoMzxNcKmHQ9JADTmfjUv1cSusESLXoIzxs?=
 =?us-ascii?Q?MNxp4PFMDl+yigSAH2ZtBHv0CWT2I1znwek7+sXgpYQwVH0VyACgO8Orkkel?=
 =?us-ascii?Q?LDWk2b+FKMeQtZJbQWGqk2J815W7l8rC2JbSn616EI7qnoHmpcpD9yvADM96?=
 =?us-ascii?Q?6NB2VJxAirUmTPn85dg1BB9oQtNdnoFaoGXyjScDomkLcevgyQug1MmyUIt3?=
 =?us-ascii?Q?orGpaTaepFj3jFGmGt7e5aJDDRdGWD6WgXOjOhK11v1LaCg8ZvH9gkaFtvws?=
 =?us-ascii?Q?Y3jq11E3ICO5gKt4eRwCXBGGuDkng0NXi9rh1x5Q+/sPacz4Ydt4kgZrJ7RZ?=
 =?us-ascii?Q?YAWxA7GUTMWLxac7M0BGhHz4nnHzTkWVdPka2Iz7jWpIxXjDV3QjHMfj7dps?=
 =?us-ascii?Q?pIVIw3YnnSQ3zzCJLjJzYoBgfEarjWa64V9Lx5+d7det4cFxnxX4KNoYAQzz?=
 =?us-ascii?Q?y681p/yHb52EUwbA2YxzLKdkePKT+am1aiSXchYhFcUw24k9LR8qHQEPxi3N?=
 =?us-ascii?Q?C5DLlvfRmER9PxKyNfwQDV7pRNS3EkJRQPc+1jmipUOK3Od7oxvAQnh9xGyG?=
 =?us-ascii?Q?vEztRgr+bHE1Gnu5KoFktfLVZa/CgnP2zKyAvrbY6kRUNsqOQDjg2z6QMHsJ?=
 =?us-ascii?Q?OeEDnSddDpPnSxPU89xmtTHvOFF1c9bA00A9IoEouHIH28kCarzurKdap2jD?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c465eda-bf9c-438f-880f-08dafc29e01b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2023 03:36:41.3086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sw8nncjzIIPH2ibxX15lqdj6+IzNitmLSJbHPa1vYTiptlu6wMSHcC0tysj+RUXoY+0ubktDDnzT0ZTQn0AWOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5772
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 01:35:12PM -0800, Ashok Raj wrote:

[snip]

> ---
>  arch/x86/kernel/cpu/microcode/core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 6ade3d59c404..089636b1643f 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -386,6 +386,7 @@ static int __wait_for_cpus(atomic_t *t, long long timeout)
>   */
>  static int __reload_late(void *info)
>  {
> +	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;

In a quest to keep the christmas tree effect, screwed up the ordering. 
I fixed it before i resent the next time. Modified diff below.

>  	int cpu = smp_processor_id();
>  	enum ucode_state err;
>  	int ret = 0;
> @@ -422,12 +423,11 @@ static int __reload_late(void *info)
>  
>  	/*
>  	 * At least one thread has completed update on each core.
> -	 * For others, simply call the update to make sure the
> -	 * per-cpu cpuinfo can be updated with right microcode
> -	 * revision.
> +	 * For siblings, collect the cpuinfo and update the
> +	 * per-cpu cpuinfo with the current microcode revision.
>  	 */
>  	if (cpumask_first(topology_sibling_cpumask(cpu)) != cpu)
> -		err = microcode_ops->apply_microcode(cpu);
> +		microcode_ops->collect_cpu_info(cpu, &uci->cpu_sig);
>  
>  	return ret;
>  }
> -- 
> 2.34.1
> 

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 6ade3d59c404..07764c1a2dd3 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -387,6 +387,7 @@ static int __wait_for_cpus(atomic_t *t, long long timeout)
 static int __reload_late(void *info)
 {
        int cpu = smp_processor_id();
+       struct ucode_cpu_info *uci;
        enum ucode_state err;
        int ret = 0;

@@ -422,12 +423,13 @@ static int __reload_late(void *info)

        /*
         * At least one thread has completed update on each core.
-        * For others, simply call the update to make sure the
-        * per-cpu cpuinfo can be updated with right microcode
-        * revision.
+        * For siblings, collect the cpuinfo and update the
+        * per-cpu cpuinfo with the current microcode revision.
         */
-       if (cpumask_first(topology_sibling_cpumask(cpu)) != cpu)
-               err = microcode_ops->apply_microcode(cpu);
+       if (cpumask_first(topology_sibling_cpumask(cpu)) != cpu) {
+               uci = ucode_cpu_info + cpu;
+               microcode_ops->collect_cpu_info(cpu, &uci->cpu_sig);
+       }

        return ret;
 }
