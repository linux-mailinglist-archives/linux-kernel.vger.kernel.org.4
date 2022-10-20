Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71600605671
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 06:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJTEpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 00:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJTEpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 00:45:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F5FA7AA6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 21:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666241096; x=1697777096;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=g45KvcewmINfptBZBUF+3OlimHuOA9LmNZ6fj8rNr/o=;
  b=WhbivE8HM89TxPvPQ72E6bm/zkdteLict6pQIs165x0ow0wCS7Kdevm4
   1ERD2bByJO8JbqPXDV0+2IhWVIFqaj1M3+1dUeX/BV6m6X+clWW3jzjQx
   KeDibJQnNkb4ruc6UWoLvbidPd99v1VLKsUnNtJcA5KowitkyjHXtjCbL
   SogU4GefwC9OwWCrsXToEe8Z4EcLTNhFbkDfuGx2s4Zx34nbpiV4wUJWM
   LDZgN4gpsM0lwDVMv0w8EAjr4sI0yx+TVeOhXDeyOYcE2k/D72ixvKplH
   CzY3zz/ynjoG0pKztXmrPyGBuB9YBsE+C/5vupsFBcirNOnFWatY00UDh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="306592895"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="306592895"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 21:44:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="754907993"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="754907993"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 19 Oct 2022 21:44:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 21:44:48 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 21:44:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 21:44:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 21:44:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu9/eTXbKWLopVo8COpDCztbH/QJxzBb789xKx6ZZB54n5ufrD+QWQ3SKiPzY+Wvb2ThX6MjtzH5Xx5hTPKoNwmrqy1gKrprMXrzMwGP0mmGtjmoH51x4DUsJgcasnoEur1W/f2+S1ts/Eo25cuwpg2N1kpFaoAMKB9CHBTAa7jY7bc0M3nIsZF4Lc0O7vGYZ2hh0bk6Pv/kwJQ+mTJW7tW6E94r2sD048lrVVI4Hb21bTZTGMqwTCfzUKxOdfxOUJVVhPDLS8lHC3WQcKLuWBmmdjKgg9gZe7nnf0mddhbP+A4N9h7zmV4xSxSScOR3Vu1jyJuThIwiF+zfTxK8eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrRggLo46dvAT4BsydqxdppQQ7IDBy3zWShRUxL9Ex8=;
 b=CB78I5jbaNg1MC0tmVjvHBzEZ8SOgT4lkPQ1FHrcga3vvCdeZjRjh3WRFLFtfZ0WELb8IjL4HjOb2D+QkFi5/BRY/C1Ye4wEzdfMKbaUvfSGXjo5G/752vA71ddi/VUitDODHvEUAcKVFKQGjCawH0VLc9j++loEIoMW0vTQqEHBt4hD+m4Ehw9dQYlvKkiCe6bGabl4kKjZvn9AGc028BkWdZ55IrDHqWZBTZA2YzdswnaJjQFEZEFpt5zQedjidgC4nulOSWucwVHPi/5WWd1prCdvgDVbKdnE+z1dQKw7WjdMBJZFC18bTxx18WBjkbU5BGWDRGRpmWThsdGKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH7PR11MB7002.namprd11.prod.outlook.com (2603:10b6:510:209::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 04:44:44 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 04:44:43 +0000
Date:   Thu, 20 Oct 2022 12:44:30 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <rui.zhang@intel.com>,
        <tim.c.chen@intel.com>, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>
Subject: Re: [PATCH v2] x86/tsc: Extend watchdog check exemption to 4-Sockets
 platform
Message-ID: <Y1DSLnfMakCrWux/@feng-clx>
References: <20221013131200.973649-1-feng.tang@intel.com>
 <87tu40p3ws.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87tu40p3ws.ffs@tglx>
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH7PR11MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b24b7c4-e894-4207-dcf8-08dab255ceb0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MK0jz+9k56h7pi2/IyDBhBJFBCQ6F0H97JdEubpC1+fwr7Ysz5x0eFM3qEJHDmdhcvMNTYfnCqxhtGDxczgC1X48wTKgAFW4CiGULd6ye3ZE/6aXjRtXqX5V/IF9H8Y1ISjX6UsmyQy0QLkCcvwZN5SvioJKXUBmctxE/rFSXXKO8JoIbBcvNT8Ln1eBG9+Ud7qwlAkVQsgNNODTfHdt+X5lgNp7hnGIhjeGb2Uglh4DGjukkG+JdtE2pyf5MU11WapfV1BFpLmE9IImiX/EhSXyMkHDtXyx8PKM+d88vEX9Kzj6CYwh1DfzWZeJBob4H/axDhACq9j7JfVbWnSbtoAEAY8p+sNN0yyOjDfsLCFFvjshQ2vkx17nZUzBCqkTznU9IBhV9lrXpGn7g8ewZ6400yzCuDuTML5ZWRgMlbs2stODNYFRasjGvnXNMPBnjy3XNZtNyceoLF0mus+kCLNvnYmbEC0AzPDEaGPO2Ecc1ZBrjfG3TqFm/PIoPlAHBPR2/yT0EISFuemydzrE8eKh9V30CRNLNYP5w459rCBsyMJ+n0039rZRc/4NI6jRbTyPfe+UpPpnYK221AMdnwT+BWw+ZGOtqkYsQ5nalaGYlyCO0EA0NPGH7bygoncGHuzjke1akfQQZbbJkM9kg/p2/wullWqPmOy3oYVH4mms/cSpOIXo0RuLoRnEeA2JHvhZkJlvQEHfYfXHS0WXVwPeh7MT111UI8poNkfrWmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199015)(5660300002)(86362001)(26005)(33716001)(4326008)(41300700001)(6512007)(8676002)(82960400001)(6506007)(9686003)(66556008)(6486002)(8936002)(66946007)(6916009)(478600001)(54906003)(6666004)(316002)(66476007)(44832011)(966005)(38100700002)(83380400001)(186003)(66899015)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ROAUykrCr6kPrPw+3r+IYz8mnhZgXLnxbsEjPCZKaO5MfFF+zhDdBlDdk6z?=
 =?us-ascii?Q?GfLy6BCjEy17j2yw7TpNAPRYuU8tsmpNweLug5YYvLJbzHXkXGnWeVu10Nfh?=
 =?us-ascii?Q?HviyVHustRa+IO1I3Rr3r00cq30JSn151VVzsh8Rm224eGxhdlpDF25laaMn?=
 =?us-ascii?Q?WWKTG6YFRSnUj+aFh/3XgvnqWWmOcl6Uee7o0GNUpG4KhHXumPkon8/aROLv?=
 =?us-ascii?Q?Zro15LQ9n4w2JXPOp35vS7lLWNo+9kQUdlq2CVYga4UW2snVoI+ZK31JhE0U?=
 =?us-ascii?Q?8gqw8lEqi53UpsJcebYxGDk/JJu43NehV1OEYuPuJlrMZqzyfc9UXNohb1Xa?=
 =?us-ascii?Q?Bu68AZXyu1MWXT0AMY7bOTY0nLMTBUB8c0ZdP5ovY25jRKGiNqlBdwXh8R2Z?=
 =?us-ascii?Q?rT3W6CZw2B6tql6zGt+53Hkrf5i1Q8pTYUGFwsMxCPBeWvo4FCH3jeqLJj3E?=
 =?us-ascii?Q?y92D4NVcC53OMTW136R8JAcQYAcJL+25QWF+hbFRB8twKIDb0lvHh64w90fg?=
 =?us-ascii?Q?KSw0+AYOCrvLlnzUzlN+jYiU2143UhYxMChI6bUUV7dzlETifW0jL0IbKY6b?=
 =?us-ascii?Q?2U3ORFeseCD8KyZ87BrCvGo3dA4dWez67iZn5NwggJxLYwXvLiptD+2wdUAm?=
 =?us-ascii?Q?a704psG2tD9KqBkCGs1UXIEakUcNr26aw4EUMTLjmQigUXc8rs4GT0xyNvVA?=
 =?us-ascii?Q?eQ9nZOa2CCdEyoA7+vyQPLt1bTgEJckSK4aaNyWmqyG/EqAbeB46ASBcx8D9?=
 =?us-ascii?Q?hmK99uF7FxYzbpYJrSVWft4sLk6DJ3yO2rOopI7MvALUy8W1XhUxFmVPuTon?=
 =?us-ascii?Q?4mwTqZhgSOFkvp9Q2m2EkB4hgSbve7W7MIKDzOF9rJVqVDGeCZJ+u4cdma0p?=
 =?us-ascii?Q?IGa3/KVWE4XloV2tkI9M2q+Dltvo5KxvmG2SxySxmXlbH13yhYvyJ5PVYuSA?=
 =?us-ascii?Q?waX5w9fQNx8Ql/WpRTOVSWFNDa2WyVXsZfZiSesdT0VCk9p/E8wOiQpRiFHU?=
 =?us-ascii?Q?Es5M7c0OkXv6/Y0xfQ+qytKv1zE/2GKXxAI0pJloyLJQTJ0CXYYret73n9mr?=
 =?us-ascii?Q?mdkfxevqj6H0N90tBmf2AZbKPxVHcBdg/h9L0p0Bbo12vGhJDJeRNC6gVT8y?=
 =?us-ascii?Q?x9/lPqigskiMHF4Kc51haGNNXGFIoSSJSHnDB9iEMMHsNBV0gbpFu69RRxku?=
 =?us-ascii?Q?81h+CuXoyjEHeCRchTQ7RFL0kT811VpMac6AY9siDZMZ4kp0SMqctcT/1arl?=
 =?us-ascii?Q?4UKNRRI5OddsK2PoQt/oKUYPcjAqLvLRfY+xE/8H0cddf8txN5nPzJ91mhGb?=
 =?us-ascii?Q?xMzsI/bqzF0OEW/+vI++OMQPfOnVL/f4PnIzxNWl3wigucMUSa06oZuMZ8I+?=
 =?us-ascii?Q?ygyMsUuqMqkxTrNNSg+lclcbqLH5rydZcNnPeOSw2zDhcD7Nx+IliWY09EC1?=
 =?us-ascii?Q?h02f10SQQjgbEgd3GLh8VErtaYLrqGvr5Jj6cfHLd21qnUCK362TMKPHlwe5?=
 =?us-ascii?Q?b5ZUhT+KYukMrT1n1h0gJ1MgQgwrnAXAH8W39Ee4lwHLy9RE+1hC9zHY9tRV?=
 =?us-ascii?Q?lCM/fLG2H2Mv4XSi5Y2ow36lOKjvUAHBh0+LN9ux?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b24b7c4-e894-4207-dcf8-08dab255ceb0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 04:44:43.8820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIf/SZu79Y36kUAfRHDivY32LZheQLynCQjj37Aa0IimPeDRX0tzxF/5ISSESrIrnD65zfjlzvzaPWd+QW+0kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7002
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 11:18:43AM +0200, Thomas Gleixner wrote:
> On Thu, Oct 13 2022 at 21:12, Feng Tang wrote:
> > There is report again that the tsc clocksource on a 4 sockets x86
> > Skylake server was wrongly judged as 'unstable' by 'jiffies' watchdog,
> > and disabled [1].
> >
> > Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
> > on qualified platorms") was introduce to deal with these false
> > alarms of tsc unstable issues, covering qualified platforms for 2
> > sockets or smaller ones.
> >
> > Extend the exemption to 4 sockets to fix the issue.
> >
> > We also got similar reports on 8 sockets platform from internal test,
> > but as Peter pointed out, there was tsc sync issues for 8-sockets
> > platform, and it'd better be handled architecture by architecture,
> > instead of directly changing the threshold to 8 here.
> >
> > Rui also proposed another way to disable 'jiffies' as clocksource
> > watchdog [2], which can also solve this specific problem in an
> > architecture independent way, with one limitation that some tsc false
> > alarms are reported by other watchdogs like HPET in post-boot time,
> > while 'jiffies' is mostly used in boot phase before hardware
> > clocksources are initialized.
> 
> HPET is initialized early, but if HPET is disabled or not advertised
> then the only other hardware clocksource is PMTIMER which is initialized
> late via fs_initcall. PMTIMER is initialized late due to broken Pentium
> era chipsets which are sorted with PCI quirks. For anything else we can
> initialize it early. Something like the below.

Thanks for sharing the background and the code! It can reduce the
time of 'jiffies' being a watchdog on client platforms whose HPET
are disabled. And there were still false positive reports for
HPET/PMTIMER as watchdogs, so I still vote to your suggestion of
lifting the check for qualified platforms.

For that, Dave raised the accuracy issue of 'nr_online_nodes' and
we proposed new patch in https://lore.kernel.org/lkml/20221017132942.1646934-1-feng.tang@intel.com/
while the topology_max_packages() still has issue as providing socket
number, and I plan to use 'logical_packages' instead. Do you think
it's in the right direction?

> I'm sure I said this more than once, but I'm happy to repeat myself
> forever:
> 
>   Instead of proliferating lousy hacks, can the X86 vendors finaly get
>   their act together and provide some architected information whether
>   the TSC is trustworthy or not?
 
Yes it will save us a lot of trouble. Maybe better in CPUID info, as
if there is some bug in HW/BIOS, it may get fixed with microcode update.

Thanks,
Feng

> Thanks,
> 
>         tglx
> ---
> 
> --- a/arch/x86/kernel/time.c
> +++ b/arch/x86/kernel/time.c
> @@ -10,6 +10,7 @@
>   *
>   */
>  
> +#include <linux/acpi_pmtmr.h>
>  #include <linux/clocksource.h>
>  #include <linux/clockchips.h>
>  #include <linux/interrupt.h>
> @@ -75,6 +76,14 @@ static void __init setup_default_timer_i
>  void __init hpet_time_init(void)
>  {
>  	if (!hpet_enable()) {
> +		/*
> +		 * Some Pentium chipsets have broken HPETs and need
> +		 * PCI quirks to run before init.
> +		 */
> +		if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
> +		    boot_cpu_data.family != 5)
> +			init_acpi_pm_clocksource();
> +
>  		if (!pit_timer_init())
>  			return;
>  	}
> --- a/drivers/clocksource/acpi_pm.c
> +++ b/drivers/clocksource/acpi_pm.c
> @@ -30,6 +30,7 @@
>   * in arch/i386/kernel/acpi/boot.c
>   */
>  u32 pmtmr_ioport __read_mostly;
> +static bool pmtmr_initialized __init_data;
>  
>  static inline u32 read_pmtmr(void)
>  {
> @@ -142,7 +143,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SE
>   * Some boards have the PMTMR running way too fast. We check
>   * the PMTMR rate against PIT channel 2 to catch these cases.
>   */
> -static int verify_pmtmr_rate(void)
> +static int __init verify_pmtmr_rate(void)
>  {
>  	u64 value1, value2;
>  	unsigned long count, delta;
> @@ -172,14 +173,18 @@ static int verify_pmtmr_rate(void)
>  /* Number of reads we try to get two different values */
>  #define ACPI_PM_READ_CHECKS 10000
>  
> -static int __init init_acpi_pm_clocksource(void)
> +int __init init_acpi_pm_clocksource(void)
>  {
>  	u64 value1, value2;
>  	unsigned int i, j = 0;
> +	int ret;
>  
>  	if (!pmtmr_ioport)
>  		return -ENODEV;
>  
> +	if (pmtmr_initialized)
> +		return 0;
> +
>  	/* "verify" this timing source: */
>  	for (j = 0; j < ACPI_PM_MONOTONICITY_CHECKS; j++) {
>  		udelay(100 * j);
> @@ -210,10 +215,11 @@ static int __init init_acpi_pm_clocksour
>  		return -ENODEV;
>  	}
>  
> -	return clocksource_register_hz(&clocksource_acpi_pm,
> -						PMTMR_TICKS_PER_SEC);
> +	ret = clocksource_register_hz(&clocksource_acpi_pm, PMTMR_TICKS_PER_SEC);
> +	if (!ret)
> +		pmtimer_initialized = true;
> +	return ret;
>  }
> -
>  /* We use fs_initcall because we want the PCI fixups to have run
>   * but we still need to load before device_initcall
>   */
> --- a/include/linux/acpi_pmtmr.h
> +++ b/include/linux/acpi_pmtmr.h
> @@ -13,6 +13,8 @@
>  /* Overrun value */
>  #define ACPI_PM_OVRRUN	(1<<24)
>  
> +extern int __init init_acpi_pm_clocksource(void);
> +
>  #ifdef CONFIG_X86_PM_TIMER
>  
>  extern u32 acpi_pm_read_verified(void);
> 
> 
