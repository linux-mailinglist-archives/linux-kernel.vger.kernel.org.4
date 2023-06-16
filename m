Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346A67324EE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 03:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbjFPB6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 21:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFPB6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 21:58:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21AC1AA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 18:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686880723; x=1718416723;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tOioH8NVfxmNesagDR2vAk0hbHNuv3/B9QGamvMxYpU=;
  b=Cdata6j6pkihYS2adHnQWWCXJbv/k8gd1JP30QwHLLcbtAeHLZB3zwuK
   8x5xuKHgjBc6fOHtyckpyKBVJyiojKKhGeYQlzcwfMmLSYNIccp//IltJ
   isqVEO7wvvWUS6mpRn68CL78wHxXpPdqxjc629+4/hw+d+aSWabzEwQ+9
   6bn2XXkBo4jXYrjVaduBdxvnmHcSbiJCqf1uTBdXeTz8qp6qBzJ09ig9C
   m7/yGbOarFn68QAsnoVWftPpFgf/NePDM/vlQ3rjurT95SwCdLbHMaEsp
   68SjjfeX4wCu9/zxECrY+QZpYlDD0uPQ6fuWfTkMTPTC2S8bF/qaoFKRQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="387715471"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="387715471"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 18:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="777962218"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="777962218"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jun 2023 18:58:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 18:58:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 18:58:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 18:58:41 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 18:58:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kck2d7dTKJ2WXT27HvQIUZyCJJcBBgRj51xl3MhaWJN4f8Jlr1IIL3Gq4Wx7NoB34l/o/EusnTs4y0ZUPsP7EDluN38p0+X5bs8pa4CwwULhRNtI6CzW55PUmHCW+T3wZCwHnUKvnSt/cCEV5niBZVsDuTlQhfFXgFs+qOSxK4NtTXTvRn7k8Fxnpm1Wd83bfjG718AwUQMFQqF+CR3mTamnop4HLYG/+HBYBvsSeLhP5sdx9fKO1RTTVmKNcsjIDRjL01hCD2fOzDZgDl31KJk4DQBXX8EPNjnR0yLZb+AU3an/B2t/glloD8DRPFGXcsjAkiFMCmXZrJHGqpd0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lu2ZOnFv8cNEPE5pvn0Q3kb6Kx6QVsH4fY6hHwfe/GA=;
 b=dn68rrGgEXTwLrcLsPke/KskdyFizFjzbFYpYnpg1pCV0HWhvfNySsfgbrvw1RKcLo7wkFzIUi/biQVKONpKoHgcg5SoXCOWKtmABfSPi3srUWKS7oSv4kn+KQXM/Nftgx0JbS+ByyQDcUcnJtCPdtvH2KU/RQWDWE/e+a0uXnmjdf21YXMUCGyen1RfqXB0c35AQ/+3Ad5vq7poDBy1XxaO8DWpwfu+0ofN6pWHXzXxRQKr635SWNJT71API7ZNR5Qs+TM5tDb4xU1fEyoV/PVnXJHwFYRtqHHWlfYHhCW2o/CEP+093lpvybSaf/SUjpGsp5x0/wlg2uZUBigjJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CY8PR11MB7034.namprd11.prod.outlook.com (2603:10b6:930:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 01:58:39 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f%3]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 01:58:39 +0000
Date:   Thu, 15 Jun 2023 18:58:32 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Tony Battersby" <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch v3 1/7] x86/smp: Make stop_other_cpus() more robust
Message-ID: <ZIvByEFqiJZOyau2@a4bf019067fa.jf.intel.com>
References: <20230615190036.898273129@linutronix.de>
 <20230615193330.263684884@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230615193330.263684884@linutronix.de>
X-ClientProxiedBy: BY5PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::30) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|CY8PR11MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b559c8e-ed03-4889-3117-08db6e0d3401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6CNkqgWh4yzBsrxoOSKBlZbWH9OVWy/O9ChdS6Fhq1SS29L1VPoNubZa8RNF+diAJphuF83VCc/x3if8b92/e9oEAldCS/ZqNqkSlpkUyHQeAJX1fxFtqOpQgST94xGrou9fmryuFmDiNSuLlf2Wf+RbtrujUg/7TppgxxjjZFkfIeDujvyPOT35rpa/pzrDHYf/bZbmXtpg9q1AVK8omeVJi4a4zr7s2TbIQ5swj0+1kranvTIa74O//IdxGZTjSVA8m3Y/EhWYqhMmJ3ICbvYMrAhWstNIVao9Nd3jLLiONVp3R48eDEnyC5fWoLXZZcqDDo4PkdZvuCH3UMvvNVVSjCBgTeY8F8NBDWTrVBjweGgY1wmxZjTZADZ3pWDX4QlpunB4x0JOYW53J/A50e6u90fN2D1Nv80gpo7JJ/O8zOW2F53AjVrI94nrRc0kGeZ664eMp0itDnYzzUwWBwn+gHrnIhuNtq/N48YWPm64kzJJ63/IIwZHZHqMutHW6CaMY6aewqLWkGQFqJzCBbaZz+FkKcFR8aXTdCkqwzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199021)(83380400001)(2906002)(86362001)(38100700002)(82960400001)(54906003)(8936002)(8676002)(6486002)(316002)(41300700001)(966005)(5660300002)(478600001)(66556008)(66476007)(6666004)(66946007)(4326008)(6916009)(26005)(6512007)(6506007)(186003)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EqtWuP2tfk2aWGCFn6QodSa20atZpg7fXby2Ikzw+V4zjRQG6YQNk87TamVv?=
 =?us-ascii?Q?3TrSAed6Af5/CHdP4N9LHb1iB3Q+kT0yCQm+h9x0/3zvDs079txlpJSkGHT3?=
 =?us-ascii?Q?yfrPGhowf756qWtilgjRsvq7eVw5tEkTk+3a6eWL3V3vHDKW/qUuFm/MaRya?=
 =?us-ascii?Q?Nc/xgv59QzG/IVsRM6PgJNOUN+a2ZhixDmuAl7zgpi00XLvI//+7m2waf/ul?=
 =?us-ascii?Q?SFZKlifbl4Dt59kwfLyZJ3s+peIcnTl/WTncxjifIm9fQbJPmuIqrBULhohx?=
 =?us-ascii?Q?rc7H9SNd0ZXOyoCIGZxgKe4vwS8UscM1/kdPljK2Y77GH1zD73+29JGVHYuQ?=
 =?us-ascii?Q?0f9F31XsKk9lcg4xHneaWdYFku5tz8k5xc2nIXOUR5Odk/9xZEqTAc3QpjFq?=
 =?us-ascii?Q?pzREvOxzhp4DYEzuLugAAc8UHEla+YRbjPasRjdbxcPbek64c9JeiZT84gUm?=
 =?us-ascii?Q?W/WIhglaP/r47bh0JbyBAsIuFmHPeEIIWPs2Yy6JmUGPR+DU3Ozr2Pfmv4x3?=
 =?us-ascii?Q?Hmdr+/5EEOhxAt42ekbNBDWFDA1bilAVfcQrL2XN6DyLuqTcSICaghiKIH8K?=
 =?us-ascii?Q?1GHVjcXHNGJTcYoBH5AHtZynGrljTiqMm47R+wJs9encHx8tWtdSv2E4RThM?=
 =?us-ascii?Q?FRMw53KYhXRu9wW7ShM80xZMBDYKpS/B0mFZoUnJq5LhPsQITkuaUAO7E8W3?=
 =?us-ascii?Q?/8XLTOlpCpFMZDP/FzSsPoQltAtaRGgkayr7ilkmlF91mNkO9PzOf4fOEdMn?=
 =?us-ascii?Q?x19i8xtC6TsR4EGDWT9dov0dzx6+agzo6MXVJgiJV6rutRHR7lCKkF1DHsfF?=
 =?us-ascii?Q?78mipBhkOpyZSHeanQdroEoQuMGOium5MnR2oIDlhMS2Opt0VrZSNhiZHgHs?=
 =?us-ascii?Q?gPqWJ+WaF69JWfxNJOBVJWCnf98EeBnsJT48nTO69faXXL+5WAq0OVT5c8bk?=
 =?us-ascii?Q?A1UhxB5XOdlfTquX86eBi2mx9a7oIU2sckYE6bgoblaHMyplj8F2rAbMmj2J?=
 =?us-ascii?Q?RAaAj9PaGaxMJPqUv1d5zK/xOuUAel5hdBjBif1QKGzM/vDdeXb5ximbVaBr?=
 =?us-ascii?Q?DS6gXhTaBzghrJKkFUe34LTGbUPhC8jdeCmQh5w3FuMB4bLsABjm3KKoE4xm?=
 =?us-ascii?Q?BVTbOEibFqbID1RNboGSTaLqSgapHEiE7AKEWz7EYfkgE942nA4mS6KijEcI?=
 =?us-ascii?Q?98x7mUEdo7LunAX41Q8/1lgjbKBh6aGcVaNab9bcN4izb2BG6uX2tklmw6+g?=
 =?us-ascii?Q?CDBgn3Tlx4w2NTMevRMZ9U/928EGXT7vktg6nz77eTbat6j5ScJTkO9jfZMZ?=
 =?us-ascii?Q?4WIxiD0OpDoT+xT+7EoyZdRlK+Fv84PsUddZuk3yDwxd1Q5SgyEebVdPI9JO?=
 =?us-ascii?Q?vDwVy2IfRcFS9yuvwNgrntFXlq0heOINxhMxU31XCyY9GWHKIaIIOfhFrCvi?=
 =?us-ascii?Q?keTk/NepZkICJ2NOLpdcR79P9JmTHpkWv1kC25R/gh9sx8Z0tBa1vNL2dXhe?=
 =?us-ascii?Q?1mzHhZyRzZqw5LPl6lbSOa8KC/ALKyoLzu4L4gFwF4JKnnjNIim8T8bLVE7p?=
 =?us-ascii?Q?hl5hNu32nJ/Ekd/u9qhxnBiMtjZDG2AZMa9I748t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b559c8e-ed03-4889-3117-08db6e0d3401
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 01:58:39.5809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzEbDKs1Ir60X6UK4RkeLuTpUazaQV1xMbklvdEs43ACuKDwe1GAdQF9k6I3Oe5JKdzp50keH0mYmwwyOhdw5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7034
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Jun 15, 2023 at 10:33:50PM +0200, Thomas Gleixner wrote:
> Tony reported intermittent lockups on poweroff. His analysis identified the
> wbinvd() in stop_this_cpu() as the culprit. This was added to ensure that
> on SME enabled machines a kexec() does not leave any stale data in the
> caches when switching from encrypted to non-encrypted mode or vice versa.
> 
> That wbindv() is conditional on the SME feature bit which is read directly
> from CPUID. But that readout does not check whether the CPUID leaf is
> available or not. If it's not available the CPU will return the value of
> the highest supported leaf instead. Depending on the content the "SME" bit
> might be set or not.
> 
> That's incorrect but harmless. Making the CPUID readout conditional makes
> the observed hangs go away, but it does not fix the underlying problem:
> 
> CPU0					CPU1
> 
>  stop_other_cpus()
>    send_IPIs(REBOOT);			stop_this_cpu()
>    while (num_online_cpus() > 1);         set_online(false);
>    proceed... -> hang
> 				          wbinvd()
> 
> WBINVD is an expensive operation and if multiple CPUs issue it at the same
> time the resulting delays are even larger.
> 
> But CPU0 already observed num_online_cpus() going down to 1 and proceeds
> which causes the system to hang.
> 
> This issue exists independent of WBINVD, but the delays caused by WBINVD
> make it more prominent.
> 
> Make this more robust by adding a cpumask which is initialized to the
> online CPU mask before sending the IPIs and CPUs clear their bit in
> stop_this_cpu() after the WBINVD completed. Check for that cpumask to
> become empty in stop_other_cpus() instead of watching num_online_cpus().
> 
> The cpumask cannot plug all holes either, but it's better than a raw
> counter and allows to restrict the NMI fallback IPI to be sent only to
> the CPUs which have not reported within the timeout window.
> 
> Fixes: 08f253ec3767 ("x86/cpu: Clear SME feature flag when not in use")
> Reported-by: Tony Battersby <tonyb@cybernetics.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/all/3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com
> ---
> V3: Use a cpumask to make the NMI case slightly safer - Ashok
> ---
>  arch/x86/include/asm/cpu.h |    2 +
>  arch/x86/kernel/process.c  |   23 +++++++++++++-
>  arch/x86/kernel/smp.c      |   71 +++++++++++++++++++++++++++++++--------------
>  3 files changed, 73 insertions(+), 23 deletions(-)

I tested them and seems to work fine on my system.

Maybe Tony can check in his setup would be great.

One thought on sending NMI below.

[snip]

>  
>  	/* if the REBOOT_VECTOR didn't work, try with the NMI */
> -	if (num_online_cpus() > 1) {
> +	if (!cpumask_empty(&cpus_stop_mask)) {
>  		/*
>  		 * If NMI IPI is enabled, try to register the stop handler
>  		 * and send the IPI. In any case try to wait for the other
>  		 * CPUs to stop.
>  		 */
>  		if (!smp_no_nmi_ipi && !register_stop_handler()) {
> +			u32 dm;
> +
>  			/* Sync above data before sending IRQ */
>  			wmb();
>  
>  			pr_emerg("Shutting down cpus with NMI\n");
>  
> -			apic_send_IPI_allbutself(NMI_VECTOR);
> +			dm = apic->dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
> +			dm |= APIC_DM_NMI;
> +
> +			for_each_cpu(cpu, &cpus_stop_mask) {
> +				u32 apicid = apic->cpu_present_to_apicid(cpu);
> +
> +				apic_icr_write(dm, apicid);
> +				apic_wait_icr_idle();

can we simplify this by just apic->send_IPI(cpu, NMI_VECTOR); ??

