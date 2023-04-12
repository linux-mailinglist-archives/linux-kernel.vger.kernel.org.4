Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F37D6DF508
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjDLMX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjDLMXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:23:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E50119
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681302201; x=1712838201;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1EJex8x8ciCNp6uon3in+03iC1ntdxjeD1v/t4PwYFs=;
  b=LZaTwIrwY4NSTj/HXzo9ST6AuisSSQD7mXKOGlMd7lboEfT/G8PODKB0
   EaXT2noeE0tlLFD4pCmZXXWgWXqytqYoSGbS9lghyJgaatltmxKkuDiez
   xhRtLa3fbZPAxz3qH6KYjDKnlmFG7vdjfgXdPp5DA/smPTJgGistfW73l
   9+hzCOAZH7GeAhBof1y71kwyPHQYMfXcbtdyqaUfLL3YgpOMaV/kWw3/B
   LEnQ9oBRP1VvXc0dVXV8Xdyx8CkxPpJkMfYc0l27RyeBV5MtI4R2lZSqw
   445W2M9R80eXJW01JQ6MoYzgo3vWX70iQN4us4R0IUXZc9RwkzNOsVhuP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="343881921"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="343881921"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 05:23:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="666327763"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="666327763"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 12 Apr 2023 05:23:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 05:23:19 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 05:23:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 05:23:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 05:23:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sc544GK9iwjBPn0RtRcywvMEXQCOcoKapr2qIx3V73kA2ypP+qxRqpgTtQO1UBeZXydAiJcX4Ri7QZQy1VxIpj155ZwM1zVPTo9a4t4FOZ1ml3s4tk30mS1z03hxU9KIXtIS1drP5BJ3odtjcocPmMxOGuLH4BJNa0/enGA+cNvqZUjLuJnxJ4G3hGBG95c934FFrStcRE7rS4F6T0pKVVxluVtMMvWxi4DV8Vc9XvvfMs7ejhDOVveJUar57rS03AJuAfTgPhHZKC+G1NiuvBl3aQWKM4BIUAEuxzE8W4R5h/5mqx8p3JeBW6JC79sZqOXRJ3X1PePfIiX10TslHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmwAMKJI189SwBwavBjreB7HEQzxmfRpCTPAsLjix1o=;
 b=K+X7txivV2SLBvrz/TaLDuUG3nnX5cezF0T3w9o3+om/eY3/pEM4j1AfyAAQ740UZ3Q6iV4X3z0DlVel/iJNtWISOfWvrEOKEW14b/v0lBQES3KMinBW8FwsDms9TV/iL+OOzrM9xbVWPHF/qRI/tzBAEotzpQVB1mx0XAbooap/VhIDY2sk8CiQdgyjK/3l2jNZaI4zg/L8HviiSkT4YIZOPWTbOFN9aqRGrnWWXEDEG/ntqPNSJChOWyxkBVHpSwwHxiGcGVuDWN23YhThgnkUJ6+qvPgdKpiuL1bxbnie27+49cdgNRCaSaiMURbRUVAHkpRnP2TNBB1/pZOOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SN7PR11MB6850.namprd11.prod.outlook.com (2603:10b6:806:2a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Wed, 12 Apr
 2023 12:23:16 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::b4ed:b620:b6f7:f1a7]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::b4ed:b620:b6f7:f1a7%6]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 12:23:16 +0000
Date:   Wed, 12 Apr 2023 20:23:05 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:locking/rcuref 2/2]
 arch/sparc/include/asm/cmpxchg_64.h:161:55: sparse: sparse: cast truncates
 bits from constant value (ffffffffe0000000 becomes 0)
Message-ID: <ZDaiqQ/6cFIr3Rnt@rli9-mobl>
References: <202304121909.hsRwqwP8-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202304121909.hsRwqwP8-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0166.apcprd04.prod.outlook.com (2603:1096:4::28)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SN7PR11MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7ac49e-f32b-4d58-d44b-08db3b50b0c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: flY7kRAXpg3H7caCr3+TpBdEDgU+MI+q3MWH6mAZ21vIh3jhhMZgZ+026yAyS5B+cA1hYRVyMqw28wna2gr3eynzPrlUcVJb6u0nhVjApyh2O/vgMI6UxWqlc59IHrqMFNK8VuuX6iUtYfk+bDtbhlcTaWF9nsy2R1u8C3jO9GBOT3FHpLsh1ajTBnfW5uMznUj45OLdIJfk7fl/9bldP/mb/oDiXeEwZvuNfVtfTw6usRwwqetw5irYV7CAdiIUK+SsQvuGgXRrkbbeZ+QroDFBtxZCTWW8XqITOG9sCVW8MB3HhuhXsb6HSm6+KtKLupyDghDPsBhLHV7VMRbvaljaMV2fenOdGXUvFDrQ0li7An2GtRxdNc7JvHtKNGsI22EeSRMebSn32j2UqcjhyvzG08xZ5E0oC1Ditnrmn6yYA5pMWy4xIcTwANUKHfsIBm0tH6sNs5oeLqXBn9WH7qAnojoSgZauz9IoR2J0yZ26oEElfHdZgEnWTMvlo8SdowlprDx4t+kgVreTY7Yw+guI4nZ85p9pVM6aw/u0rs5Hg57aHjNvtp0cr1iH6xBZAXj2XyM64pqeZN2yVrOrzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(6486002)(478600001)(6666004)(6636002)(4326008)(66476007)(966005)(54906003)(66556008)(66946007)(41300700001)(316002)(86362001)(6512007)(26005)(6506007)(9686003)(6862004)(44832011)(8936002)(8676002)(33716001)(5660300002)(38100700002)(2906002)(186003)(82960400001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KJO4SfK4c+1dWu39KBSBIBAjwycF5M7sDXUO2WAs1CnLdGtwoQpXuOPBtekb?=
 =?us-ascii?Q?mD4A5ZzyGQpHVsfXRWgg7gc3EK1io0Lj3NBhypJTMhU7cX4LuBL9jxd94Dr6?=
 =?us-ascii?Q?JBlmlPDxhNAuaoQfaqw2loYKLCzNQw45CH/mbV+jgZXJ4NLcT9aF4OC9gglc?=
 =?us-ascii?Q?CSSs4NbYkQ4YDJOBdC1CXTa+g0PvIllrUm+S+R0Wp2nfLv4b4Tlt6cbAdQT+?=
 =?us-ascii?Q?MdpwrpE5y/L+pWb2GJRS87R/acO6PEohOA7wenodJiVTgdS7ST21orur2FFi?=
 =?us-ascii?Q?x38ctFNQxZmtnD5dmW1IZ7T22t9Ie4BUyw6gGEeFLMlFoOW1jTOy90opOYrz?=
 =?us-ascii?Q?lc8Cwor4RVbJG/sc0eHAAHnPPEqraz29AZTtoIihph5PXA2Y261GB0wKqlEv?=
 =?us-ascii?Q?T4BVqwcWQtcJspdXT5r7HqQ/nsBZxfp5/0Qv9sP7sBWObl0IijEDPeemGYta?=
 =?us-ascii?Q?FX+EfplvOhXPlppv65wgH4YIvdmyNTEj8ES2HzIA7jEozuDLvZuVzULouMZh?=
 =?us-ascii?Q?1MyG1F5uNF9TBOGj1b0wkmCGbH6MSaSiKb49Uhm6hARgIkJvWXaw0XzYdCOl?=
 =?us-ascii?Q?bpT6ZePQKGiohOWD1uEbzC/VmKd8RVfI5d2T+OEHHdORe3wg+IVmcGHIy5lK?=
 =?us-ascii?Q?LgdEdpNtDUcDd8XRkJwsjmavtPJNtsErLLmytJViX4yPcZ/UkTzpZ5IC1zJJ?=
 =?us-ascii?Q?LukxsrU6nER8zF2EUnfIL2A4upfcmyYXZDEhvD19ptqoPmeRJtP0HWAOc3S3?=
 =?us-ascii?Q?uU9JSeThYQQUlcu1KGRiIJfFTilnnrWso/crW6pxF6Tmh5KTjsBkdSUvOZ+v?=
 =?us-ascii?Q?G4b+KjlMNiSm1NBg+dZI+k2Yr3mMOWyaRuxurQDrP67Pkll57z5UIjostRT5?=
 =?us-ascii?Q?ULL2bxQEcjiXPlUaI4l2XogFe9lxlPhcWb7wnqlktwOXxLl8JYW4vSb92Akb?=
 =?us-ascii?Q?owLfRdidwWsfp210XTyQGVFVW3Fqq2zEYoUuQfosDvY6hVibIcj33wWkj3Et?=
 =?us-ascii?Q?kCPBxiBxhgjtsdkM2PnTfJAf2ILLKrGd0x0R1ZLou4kjjsoxQyIAJkBnzKuy?=
 =?us-ascii?Q?TsnniVUB2qY9fGNpzca0dTFhtCRt+jZCcImYwMd+x1lqYNcXipWXbDXfNEor?=
 =?us-ascii?Q?dE7Ew44WqeqFe5OLkZ7+qCgX4n0PHMvzQfzvk+sa/jwioVmfBtQeRrQSPcRx?=
 =?us-ascii?Q?xhKOhn1SrS0mtgalQoXZ6MeW3SY9oukbl+9YhC0YMXMPIXubfOa2x59+DrbB?=
 =?us-ascii?Q?HtjeH6h8Ly7le2i/menCmI9Rko7XTQln4V+iGWXePNmey2G8uxgabqMfPD3N?=
 =?us-ascii?Q?Qm6rRZ6r0vPR+5ocwVRx+lzbXRpTEO31HbK+leELmSJZHMfec9yIxoz0itI4?=
 =?us-ascii?Q?lYK6WkK4hiE+8vc5gTsX5B3SQU4lAonpyQR5hyEspIIIS9ggEPXEGgzWb9ev?=
 =?us-ascii?Q?I6QzHf4PlS5cfcks/quxJBE0tLQrfNRHUpVzX7JqsE51bZyl6MFIxm8IItFG?=
 =?us-ascii?Q?HN39kJhmx7utl3YQYvdTNjHk/uWnIu9b1/INUvIOzW5rnP3jeY858JHJmCH3?=
 =?us-ascii?Q?FsWMZhhIBr7wnMxGQ073wh8eSn1clurorX8XDL6b?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7ac49e-f32b-4d58-d44b-08db3b50b0c9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 12:23:15.6241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73PVbntsGxKG+36W8zm/qIXXIi7HTQQSepnSRp06+xf850ZTdaRCxiGRygPpG1XiLr604p5MJ1fVQLf/LApNIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6850
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

On Wed, Apr 12, 2023 at 07:54:59PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/rcuref
> head:   ee1ee6db07795d9637bc5e8993a8ddcf886541ef
> commit: ee1ee6db07795d9637bc5e8993a8ddcf886541ef [2/2] atomics: Provide rcuref - scalable reference counting
> config: sparc-randconfig-s053-20230409 (https://download.01.org/0day-ci/archive/20230412/202304121909.hsRwqwP8-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 12.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-39-gce1a6720-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=ee1ee6db07795d9637bc5e8993a8ddcf886541ef
>         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>         git fetch --no-tags tip locking/rcuref
>         git checkout ee1ee6db07795d9637bc5e8993a8ddcf886541ef
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202304121909.hsRwqwP8-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>    lib/rcuref.c: note: in included file (through arch/sparc/include/asm/cmpxchg.h, arch/sparc/include/asm/atomic_64.h, arch/sparc/include/asm/atomic.h, ...):
> >> arch/sparc/include/asm/cmpxchg_64.h:161:55: sparse: sparse: cast truncates bits from constant value (ffffffffe0000000 becomes 0)

Kindly ignore this, which is a duplication to the input at https://lore.kernel.org/oe-kbuild-all/87k000kuca.ffs@tglx/.

We will update the robot to avoid sending the report against this change.

Thanks

> 
> vim +161 arch/sparc/include/asm/cmpxchg_64.h
> 
> d550bbd40c0e10 David Howells 2012-03-28  155  
> d550bbd40c0e10 David Howells 2012-03-28  156  static inline unsigned long
> d550bbd40c0e10 David Howells 2012-03-28  157  __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
> d550bbd40c0e10 David Howells 2012-03-28  158  {
> d550bbd40c0e10 David Howells 2012-03-28  159  	switch (size) {
> a12ee2349312d7 Babu Moger    2017-05-24  160  		case 1:
> a12ee2349312d7 Babu Moger    2017-05-24 @161  			return __cmpxchg_u8(ptr, old, new);
> d550bbd40c0e10 David Howells 2012-03-28  162  		case 4:
> d550bbd40c0e10 David Howells 2012-03-28  163  			return __cmpxchg_u32(ptr, old, new);
> d550bbd40c0e10 David Howells 2012-03-28  164  		case 8:
> d550bbd40c0e10 David Howells 2012-03-28  165  			return __cmpxchg_u64(ptr, old, new);
> d550bbd40c0e10 David Howells 2012-03-28  166  	}
> d550bbd40c0e10 David Howells 2012-03-28  167  	__cmpxchg_called_with_bad_pointer();
> d550bbd40c0e10 David Howells 2012-03-28  168  	return old;
> d550bbd40c0e10 David Howells 2012-03-28  169  }
> d550bbd40c0e10 David Howells 2012-03-28  170  
> 
> :::::: The code at line 161 was first introduced by commit
> :::::: a12ee2349312d7112b9b7c6ac2e70c5ec2ca334e arch/sparc: Introduce cmpxchg_u8 SPARC
> 
> :::::: TO: Babu Moger <babu.moger@oracle.com>
> :::::: CC: David S. Miller <davem@davemloft.net>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
> 
