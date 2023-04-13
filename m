Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CD96E03E8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 03:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjDMB55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 21:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDMB54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 21:57:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B3D5599;
        Wed, 12 Apr 2023 18:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681351074; x=1712887074;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MUCI6BLrEyRJSU7ofwiAQyDVIoFZyGzbKfGgkBpAG18=;
  b=Prkv4PoQ2/Lbs08mfg+kwcsWUMo1L/FuOkdytqbjp1bIhRxAnyK2rdfZ
   KLAXFUkAswpKqQnD2RhBeXDCxXBfT8WGY1DjZ4ijIjXvIilBqCnEGWBvD
   DDU3Pp0zGsp9S0P8uPIiD8cu3fJjHS2uhCU5msjpMJpYEjaZRDP3ooalF
   hQTjyKkSY6GFHH+HevKcQIsjdWM2wYTqjb1i+1GnDX5MidqfAWIVQQPCa
   7LXowYmTP5l2HhBn3U6D3nxz6mwtt6+Ijudf1icfWkViPifQZqMaW17HN
   vb/hQPkcxNTe93MKtsf/xSrHBqWKhDtsQOnqdvuCwFTuLmcLVHB9ZrM0b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="324423217"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="324423217"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 18:57:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="1018953996"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="1018953996"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2023 18:57:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 18:57:40 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 18:57:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 18:57:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 18:57:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKWy8tGMKnObCcHlwm+5U0TKIDaQGH1hWATR2Xf46Ujg59v7hkOg8/m5rBvkRCpDuhefih4c1vLolN/5X3vYzZMAIniUlClJn1370vb+Au9hcWvx68dhK7iDbKPYBYLmfTogEo/4AmXS84dztfzrhplvbAZVlonHA2stgaqSVgHqhKsYW8k5DNCv5L1jw82nISf9RAwVxwWRs85v8XHnaHDt9jMUJuD0+svcQUslq7tkrQKtzy6wUnt3fcWLd9dKyU5zSGtLqO4F1qstHtqQL31tgLNitu3wa5AP+AJQP2cRxptGfRLyYC/j0kU2qomrwGLTcFEE9DWXNxHHvlXTpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzvvDMEwPSaaDTgNDxpR4EgEu/XqZwpn0QJqRKpz07k=;
 b=iPqL2qSs9hsJ2FE6+0TR25QgaRH0Uqai3wZkBpuZTc9cW4Hv+jnKNLLKxnTLuh04JyuC+yDf81BCv40pnRr6OhqHMzFcQaZAVNTy1yptQkeY+qci/ny3SOu3jhexxE8aLVqlgicCKRh4gjIVq2+a7rOnyFKraQ2wpD8zU6xJ4LQkkXkTQZnurYFv+9Y4eGPYwZH9Hg4wkwda5AHNgNoQJreotEBhLB7kQoQOZX4GO54JM4ihldAYs8J1YIAp6raRA7cLNvaDr90yynD0zRJ7GUsEENDGEvT9wdRXOsmPOywHSME65yTmNWeyAt27wMZ53NQ47WhZo0UuKgnhtNv+Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH7PR11MB6523.namprd11.prod.outlook.com (2603:10b6:510:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Thu, 13 Apr
 2023 01:57:36 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5ac7:aae0:92aa:74f0]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5ac7:aae0:92aa:74f0%8]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 01:57:36 +0000
Date:   Thu, 13 Apr 2023 09:54:26 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     kernel test robot <lkp@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: drivers/acpi/acpica/tbfind.c:60:9: error: 'strncpy' specified
 bound 6 equals destination size
Message-ID: <ZDdg0hfJQeQh/2SZ@yujie-X299>
References: <202304071552.CeeIBr5P-lkp@intel.com>
 <ZDVA8ykiKaXSzJdM@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZDVA8ykiKaXSzJdM@arm.com>
X-ClientProxiedBy: SG2PR06CA0229.apcprd06.prod.outlook.com
 (2603:1096:4:ac::13) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH7PR11MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: e57d00f5-2b70-4fc7-77b6-08db3bc273ec
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfAELE3dnolJaBmOHsOgNB06B6tvmvyxsHzwzEZYHcPGRVg0pDuy64OAALneI+IIgikffbtlFg7zJAIpQEQf1pEIOQDDZuhmnjO/zPc3pdqZYP6YtQgh/BKzrFBmk6pwT8GTmHAgvXyIQxm6HCT4RGH/mdKlL6u3sooN9llFjeV8rpFxIU5XEPZVgPUvPNiUjn4E8HbUk4Jo7pBpeD5OXvZQ1YR8a+0hjaECGMt0R4dz+idpMnjnpD3VdrT+Zv5CKIp4rbLstyMHydym6kwcGojAL8lRESG/2jgwAnUgWVz8/Q1gNzwirlAASrsCPpZKG8XeCdzEH/rKQfj1epkXssLLDXfC7sf8RrnwXaFokLoZRuHkUi29OuFa2i++NGIxMzChCnDMCqAgOqZWYlzZKr20X74E7ci+HVDbs6KLMJtcmYD6l6XAPXT3L26/T3mBTVBpvKaYFbWP+0UhqmFtUjrtDMdFtkh1WGlYakbroNVSEjHFiqakqyjDLkC68jo9+P9N0dcHbKDJrOzbFJ9b/6GlicvqKZpqaya9KCL3kh0p5ssA8ypb90XrE6/SSy70fd7TBGPNmhPjKb/hvVcYWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(41300700001)(66476007)(54906003)(66946007)(966005)(478600001)(8676002)(6486002)(4326008)(6916009)(66556008)(316002)(86362001)(6506007)(6512007)(9686003)(83380400001)(6666004)(26005)(44832011)(2906002)(5660300002)(82960400001)(33716001)(8936002)(38100700002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WbPtfiL8l2klLncz/pXPi6k+OnSMA9qRen6OO3yfZTb/bJvFg9wvxpTJiela?=
 =?us-ascii?Q?esUlBOnoS9ZtjY2dO4OnGlNtkRKf6XOTxbHPWHxNXCmcKL1E5ZfOfP02i3wH?=
 =?us-ascii?Q?ngYhyPMzojE/sQJiXYJg5tFJYV7khROoRh269gCv8747D2wczCWiJj2GWihQ?=
 =?us-ascii?Q?n0glyprLN43TtAdH3ZNqz6ZgZzI/nZSRTEvoBkZw5uoPTJqhzoe8byvm595a?=
 =?us-ascii?Q?jhe3AXoOL9OOPBcVqHPFt9vboqATVkETzO60hMuZD5Rtjlcd/q1g4d/nWFe0?=
 =?us-ascii?Q?3NUkPwSct6Nlpzs8oDfFAGCxRknRHMOVETTNTPYAP17taetS7nrBITkqF5D2?=
 =?us-ascii?Q?QYbOBv+gm2YJEhWdZ/jyQnTlRuSG9ZWT3Z0ObVdYI5E0aZUVrNt07gxcAR0t?=
 =?us-ascii?Q?juWuGX4ZoyJNkUMmKy6jGoekGxCirQmhpzdDI5l8xYJvs7A3iosCWx+JH2IH?=
 =?us-ascii?Q?/UpstlO8YPL0NdjWwo4DKxeNyYL+1TbywUjbizUcMGjYKsGsi6RH79b7M6LL?=
 =?us-ascii?Q?ziZO5n2fk3Bgr08ZLFrZGDAxsJBksGhqbtPWzevGNdUsFMig3MZSq6nqh0Fd?=
 =?us-ascii?Q?6eBE0ZUdOnu0efChsiW1JwFpYqlBNC0j6UC9LfXHeaFUVNNpE+vuEkZpNlpU?=
 =?us-ascii?Q?9cS5jZxer0G0kpi4jsObM8/+ss6oSLdyiQUPIibNRW6KSmA89Q69teOjfI6x?=
 =?us-ascii?Q?e4xm/5BxSC90kQ2uR8izwrw97XSMGsRmmk/Tqjp10ZhJUuSZBFOIIsEy/QZx?=
 =?us-ascii?Q?Z39tvbIBAfwxE42GM7rSVVzBNaejKo/6TKyZJkzjPao4fJXKw+f/YteSSinT?=
 =?us-ascii?Q?RRJ2SwSmq+zoTFaYrw7f30iLe6PvtQ8sqcs0tgiXp1I8XjcqlqeR+fM4LnHY?=
 =?us-ascii?Q?bkzJ4INsxf0ZFi8hwEr/UMnJWs14kxyeHjgo0eKtxAuLfnj83SZZ0/7iZ308?=
 =?us-ascii?Q?coIPKvcjHdExz76jOEs1ABNsK/QGZl5dQ7v06+lbmte/mZCIWAogJNtbx18m?=
 =?us-ascii?Q?adUl/5AVh+PkFBh7EJZ/L9R754oyHfjMcHHBKGwfblQI+2KQDbPvy8kyqfml?=
 =?us-ascii?Q?MfBCfQlci/7sFjqkceZGqtkhxlRxo/O4uAZP+shyWs+xWKipPGMyhJscQlsx?=
 =?us-ascii?Q?drGOZD2U8vNeXuND58Hz17WAobfPNqe6vPtoLPRREXAY9VvDLQ9iH+Kby3DI?=
 =?us-ascii?Q?LT4Uze67EzRuHd1l8ub9vHEsFrY2//jFcPYoVWfoiRPWnVxBbMJyb9Ky7Zzn?=
 =?us-ascii?Q?hNwhkD6NJN3Gg7gJ3M0rtVRjcRxEU1Zk8TQCTJ1dFRc1f0MpehR2DPgF/6uh?=
 =?us-ascii?Q?d6vBtnRaTVAWZ/IHhBlAlBn3z8muPir7XU8n9teCbo7ljXUMwVUata6rYx0O?=
 =?us-ascii?Q?MLRTewL9Eorpc8xzcZSIcMKKR1vSO93lytxDMjJevpRPGJBeBtDk/od//yFr?=
 =?us-ascii?Q?qxiO4oLsF4qSsW6XlIbr2RFYcYeSGO4N/wgrBZZzuON5Ek4ko96a1qX24qkr?=
 =?us-ascii?Q?YpntiGaYhp20Spq0o2AZBqvDw4EhcJCd/a/PgT/H9YH/Z7O6x56TANS36gvA?=
 =?us-ascii?Q?hXH+UCZdcl6Q5Qkuh7YcsK6akyWonnMbntgN+l7l?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e57d00f5-2b70-4fc7-77b6-08db3bc273ec
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 01:57:35.9649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVEwKab5BwHrGJxza0atTcHhZF7OdcYVSg1glIQFYRlrWWfnlhYVUbimlUwZZd+NGrVHY5Skys5uj9+0nbHSIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6523
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 12:13:55PM +0100, Catalin Marinas wrote:
> On Fri, Apr 07, 2023 at 03:02:15PM +0800, kernel test robot wrote:
> > FYI, the error/warning still remains.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   f2afccfefe7be1f7346564fe619277110d341f9b
> > commit: 8f9e0a52810dd83406c768972d022c37e7a18f1f ACPI: Don't build ACPICA with '-Os'
> > date:   2 months ago
> > config: x86_64-sof-customedconfig-fuzz-defconfig (https://download.01.org/0day-ci/archive/20230407/202304071552.CeeIBr5P-lkp@intel.com/config)
> > compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> > reproduce (this is a W=1 build):
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8f9e0a52810dd83406c768972d022c37e7a18f1f
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 8f9e0a52810dd83406c768972d022c37e7a18f1f
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         make W=1 O=build_dir ARCH=x86_64 olddefconfig
> >         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Link: https://lore.kernel.org/oe-kbuild-all/202304071552.CeeIBr5P-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/acpi/acpica/tbfind.c: In function 'acpi_tb_find_table':
> > >> drivers/acpi/acpica/tbfind.c:60:9: error: 'strncpy' specified bound 6 equals destination size [-Werror=stringop-truncation]
> >       60 |         strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    drivers/acpi/acpica/tbfind.c:61:9: error: 'strncpy' specified bound 8 equals destination size [-Werror=stringop-truncation]
> >       61 |         strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    cc1: all warnings being treated as errors
> 
> I think the kernel test robot should filter out any reports related to
> this commit. The warning has nothing to do with the -O2 vs -Os change.
> It's simply that the compiler now warns if strncpy() has the destination
> size equal to the bound parameter (for some reason it doesn't do this
> with -Os). I mentioned it on a different report here:
> 
> https://lore.kernel.org/all/Y%2FdM77YdzDKRDdj1@arm.com/
> 
> A potential solution to silence the compiler is to go through the ACPI
> code and change those strncpy() instances to memcpy(). I don't think
> those strings are even null-terminated in the APCI spec, so using
> strncpy() doesn't make sense.

Sorry for making this noise. We've configured the robot to filter out
the reports related to this commit.

--
Best Regards,
Yujie
