Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F88568FDBE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjBIDKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjBIDJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:09:27 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55495AD1D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675912017; x=1707448017;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=APZ1pyjV777N0prKsgb07Ae1N0DUSX/Z+f2dRnhqYn4=;
  b=WFjZsfbd4RLVrK8BpsANyHN84to0haBIAvy9JuJD7BWpjn/MhEBWbAtN
   qqYGyE3AIyFmuc105pL5thKQok/fnngnvnfdpgtYLviMhyZk4BLbfSixB
   SklIY1MSNkTmcdtjKeT9JH9Y5o/CEWl2W9pqJhTePHqj0iZ6k4+UaWLCi
   slcoYF8Zoxc6tza5IAweqrktEaPU6NsDzeNurBnHyHTV+pEe068kXgIDQ
   q8AhwyJ93rg96ENBKEAV5wiGBTOmtDCKWP9sl5VBGUetqEBKyMa8U8aiA
   Rg4W2uzg5b/HMpjv4jJFr1YJ5iJzopcqSVIhtmfVIxSQ5G7/p5tpPEdIh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="318000165"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="318000165"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 19:06:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="996378060"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="996378060"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 08 Feb 2023 19:06:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 19:06:54 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 19:06:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 19:06:54 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 19:06:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VN9q634JomZi+jasDh96f9o5V4MIHkXb+0oobi4WPowISYJ2uiEFioH1IJcFgEpIXGCOuY2cbqBi4t4O+F9Z+EXgdFuaGWjsNQc2tDQr93QzRsE9ZSKsX1rYPMpITMaWBBJ9Pv/DQkPkw0/+KgjRd/1TLGlLbyJf4gyAiB66w6CLJueH/PYewzOtPiTcQcHfDPIfY8+Fo0J9MveEhii+Lf13DRIv+NrRki4mCcszW7RUqxySdOUcrR9VhZQPAAzS7o3Ej3bBoeM/9k1z9a5aezF6uLQVPPVyxkPvKdeV4AGIxoffXPmPEOMAnheLiqg6GUs1dDTlJUbNlEK8RPKbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ht28iCxsaWIn732URfeBrZVrlH33Pm6HpXyXEGtG64=;
 b=i0v7WJPUUz/v16iB86RQ1V/Bow6Ah2rIGLedRNtzzLAyorNd1bk2ehnSy+JnNzUdvR6kKENf9RLOOk5jw/B1Y0fR4rXP8CYgNXqairpw2x4qZtsJkt0c72RKSrM4Z/JyTN/ZplEZEwXF/TR/7SBpNr8qb3sy4N5yxQ1DDYL0C9hCX2NLvG44By51KTcNgGRvmSvP7vWPxHvdZTjvbicGmx1aB/LnDHGXRWDg8H9kdeh9+U/CRTD0acgfpwYo/zq9XtyPEwQuC9lZw1Kmxfa/AelxIqDaQHUfObwtv9Xp56LgHeUZcqEAYufEc8PgZVoxOs/2necHunW2JQ9f5BkjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SN7PR11MB6678.namprd11.prod.outlook.com (2603:10b6:806:26a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Thu, 9 Feb
 2023 03:06:49 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::66b1:16ec:b971:890c]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::66b1:16ec:b971:890c%4]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 03:06:49 +0000
Date:   Thu, 9 Feb 2023 11:06:34 +0800
From:   Philip Li <philip.li@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     kernel test robot <lkp@intel.com>, Babu Moger <babu.moger@amd.com>,
        <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [tip:x86/cache 9/13]
 arch/x86/kernel/cpu/resctrl/rdtgroup.c:1456:6: warning: variable 'h' set but
 not used
Message-ID: <Y+RjOpXP1Bbv268n@rli9-mobl>
References: <202301242015.kbzkVteJ-lkp@intel.com>
 <Y8/XoT23HVXHSY73@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y8/XoT23HVXHSY73@zn.tnic>
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SN7PR11MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f69c5c2-0dd8-4592-4ff6-08db0a4aaf77
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q94oli6GNYoIzAT9yq8xA7bpRSlhX13Q5pCYLicbblxk9/S8AVxM0jnSDcCSWwjclqpIR31VncTOZ1L2VZpY4paJCNZrRUmSUPBZwtt7VfX8R78t9GP7Y4FyDTlFCxtKNOI7fEFJOT94X1ML9iQKCC/tRkQ246okB8ps8MFO60Ud/ZwvghWPJ9BbLA5AWX40cmnvY6Tm0ZJoP0t2j2DflhGJgUuIyA9f5miA3FhdJwM0FoR0ZlZt6t2UIOzQGA6aS3YI2/G5qIJ3VdkYOUDPB/S8I1OD9+chMr88PIkDyFvpNpEEsW920lsmlNfAN62bfd7FmGubQx95J6RPk8AjfHrq+GtBuGU5P9vImDFAoPMT5J9PUFROmb7ivvS97Ye5dn0ivXvK9dTMlsCQFwLhqxNEDkzZIhqgS5++EMO6RQHIq1PAzhWDZa/3hoS7d6P2pt0q3TE5i4hg7IURihbPbXztZiksKeiFJQDVWKL9Rh5KiqdkYoIwIxrERxGepkO1mcJ+XRRbAA+IW6GOncQ/UXhu3lYy3D4vQZFbHi3myeoxTPq+CfMV8u0/SNxy5Y9pr4WBlvQcBVF2VhtVL+iIqF/cpxrCu3GcNOI8XMq0HATPYhdszLtz3MJsjS4S002LBvXuqojWUrFeAmptfut9GScZcVeDfd+0PQge/p1X+4vTMskFS3Edc/lyMT4h7OjS2vnDi/TRI2ewqXGwIAzs4ohkzzHY9Y12mPMmMRFvDs3hcfvfyi6A7yc4GEsqUpSAiaTwSaQ1KeonAFnmJ7uh1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199018)(316002)(83380400001)(54906003)(2906002)(44832011)(8936002)(41300700001)(5660300002)(33716001)(86362001)(38100700002)(6916009)(66946007)(8676002)(66556008)(66476007)(82960400001)(4326008)(26005)(478600001)(186003)(9686003)(6512007)(6486002)(966005)(6506007)(107886003)(6666004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s3OQm+M5spWHWexVpl7KiUmwpcugEYjzB+vybc29c32J6mS+v6z5/d2pVPkX?=
 =?us-ascii?Q?3GGYC27jA2KQNhjqwhmTmB2UPzyc4gITw9+xd0Wo63SA6xn7lK+/2CGh5eWi?=
 =?us-ascii?Q?rzsJDTF3OADwgvrrWUYvU6vaodQulEHtTFSXV/E/FqMn54qGfi5LrJfJQ5nS?=
 =?us-ascii?Q?PJeLMj0UVK4BoVIeAPVug6vTagh1uvODOCHDCT/JKfzzlAJRQCT/BZlqQ7sF?=
 =?us-ascii?Q?vC/HxSkqr4y+IbL0hkcNK2+Zp673/updD8f1OJ+JMxoNvlnyjN7IlyGmhdqR?=
 =?us-ascii?Q?KgqFG3Uu7MK4Ps1Cq2P3/dshfCKMq5YjbSbjVXmM2u2E54sl9AO1kXCtaaQk?=
 =?us-ascii?Q?sDOwY4ShXTPazE9Yaqu8BfQXWAJiWILZKQQw5f3U4XmF9O3seXchFcy3emE0?=
 =?us-ascii?Q?p2e+6r8N36ndG4EKZjAwl7pLKTAPOfm6VdmYv8Vjif1UPBcxbgrUsST9uWBG?=
 =?us-ascii?Q?7AGeH+B8fuLvzVnrUjMxLoTfB3RI0lDNNX/mfWrq917s0nPxMGpIYX5DZgbP?=
 =?us-ascii?Q?MlHPZl8wHt646ikD+kyjllQ1aneOVoW+5hnh7DF3lnQU/1OGmA1mOn055yFV?=
 =?us-ascii?Q?VZKXhf6lAu8BqFOi8cbpX2FfjX7uAjtFs4LqZgWHndZTSFVIac1tPifawIM0?=
 =?us-ascii?Q?YW0ZtLNVJv0Q5JO4XeEr1mH4ujQqCKaxUe/ffou0SaazjGo6wY2FoxX7PIBN?=
 =?us-ascii?Q?WZE58Mv78qsrVH2T9jzzaLJY7bheXGXi1jqeErub8nNqd//T36wi6rnVRuGl?=
 =?us-ascii?Q?Vbm52PsRKOjVsxA9vwG2fllideVPzvvhIKQrvrC2AvtS5fTWLB3Frv85K2YE?=
 =?us-ascii?Q?gmt2c7lwPVA3tSqIfi3sruG4tiCDPEUvl87BYyCBYW1kIvlB2Np6sjVwic8o?=
 =?us-ascii?Q?QGuoIpbI5mHhZKrUevJNsR3fv5vmGYiuMdBIWVdZcR6GAREwSgVrbm/BFcEb?=
 =?us-ascii?Q?6bOJR2bd4bXy6rsWZTtn119o7LAf042ITf68iwtfWcRyeYGsuhadaj7kze4E?=
 =?us-ascii?Q?Rzue3a1G6jEMEBgjfbW/G4vTscJUWocw4VyWMLNDnQj4guzaMWpxmirqPQvV?=
 =?us-ascii?Q?jv5QpqDUaDjC7YAQB/aoYwGJkDP5SIdNtJo0w45ksi6vvCoxZIC9px5aC26J?=
 =?us-ascii?Q?CIvAP53RAuyuLXh2ArRMVI5yB3xopsAbCOE6zhoyhDX90T3x4TvBisdHAWz9?=
 =?us-ascii?Q?cA4T+ihmpSxPQG8ownuhBMj+tnk3vFEehn+7zgdYbgkEH3Hg1byW50yH+28c?=
 =?us-ascii?Q?pbpAHMwL9v/M/BSf4CSFeDke6wec3earVz7pqDpd3sbapIxx6Ib8HnPhNc8+?=
 =?us-ascii?Q?30o9miH4TGpmG2xpkv9Zm9Sb3FF18IsxkP6Fv5TTWXr3YI59tO1FMBMd/B/u?=
 =?us-ascii?Q?tkfcyyVgBDBfTuTdUsE0NFHgtHY6xhkwJa5jFNXicGB6LUsEQh4OGE2kipKA?=
 =?us-ascii?Q?HuoE2QdWynfzsxu113RytAHi6zuAkwgtjJsw8WB9KTqJSTtCNMTqXLiw8NvE?=
 =?us-ascii?Q?wAVayDTZSL5lRixl4OjY73o8t4LortwbaJMci1Agnd5amicezlRQYWNWIov7?=
 =?us-ascii?Q?IJNjUcMuel4Vs2N39+ThdCv7Gue7yIYqizmEQ8rIT7c5M3ECYABDfrxceL1r?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f69c5c2-0dd8-4592-4ff6-08db0a4aaf77
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 03:06:49.4965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sAN9ELsIBTVT7xm6ds0/NcPFb1hQxTw4RBAUt0x4mpcNRbGgxnbe6kupx6jcyMulVL271k8Ztaig8itVj+uIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6678
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:05:37PM +0100, Borislav Petkov wrote:
> On Tue, Jan 24, 2023 at 08:37:14PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
> > head:   0a363fb23ee2f7beb08437ad7db86d195878d79f
> > commit: dc2a3e857981f859889933cf66ded117d74edff1 [9/13] x86/resctrl: Add interface to read mbm_total_bytes_config
> 
> These patches have been around for a long while now. How come you test them just
> now, after I take them?

Sorry Boris for the late reply. We will look into this to understand what happened
for the patches that why we didn't report it out earlier before they landed on tip.

> 
> > >> arch/x86/kernel/cpu/resctrl/rdtgroup.c:1456:6: warning: variable 'h' set but not used [-Wunused-but-set-variable]
> >            u32 h;
> >                ^
> 
> The fix is simple - use rsmsrl(), see below.
> 
> If it weren't that simple I'd simply ignore this warning altogether. Yes, it is
> unused because the damn high MSR value needs to go somewhere, for chrissakes.
> And if it didn't need that masking with MAX_EVT_CONFIG_BITS but the low 32-bit
> MSR value would fit right into mon_info->mon_config, then I would've ignored
> this one even faster.
> 
> And besides, I'm wondering if you're spending your 0day resources properly if
> you're testing patches one-by-one for W=1 warnings?!
> 
> If it were me, I'd prefer if you build-test patches on lkml for build *errors*,
> *before* they get picked up in some tree instead of testing the applied branches
> already for some questionable warnings...

Thanks a lot for the suggestions, we will think of this to continuously optimize the
service. Right now, we try to build-test the patches that we can find a suitable base
to apply the patches successfully, some of effort could fail. Then we only test them
when they appears on repo. We will keep monitoring the patch testing status to see
anything we can fix as well.

> 
> Thx.
> 
> ---
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index cd4e668e5019..9bd0eb050e7a 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1453,17 +1453,17 @@ static void mon_event_config_read(void *info)
>  {
>  	struct mon_config_info *mon_info = info;
>  	unsigned int index;
> -	u32 h;
> +	u64 msrval;
>  
>  	index = mon_event_config_index_get(mon_info->evtid);
>  	if (index == INVALID_CONFIG_INDEX) {
>  		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
>  		return;
>  	}
> -	rdmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, h);
> +	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
>  
>  	/* Report only the valid event configuration bits */
> -	mon_info->mon_config &= MAX_EVT_CONFIG_BITS;
> +	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
>  }
>  
>  static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
