Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C632734CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjFSH6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFSH6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:58:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDC2FA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687161499; x=1718697499;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0heWvTz1AEKHpJjn9PgqfZWDCJsU7K0KxGqLCH5Gbeg=;
  b=fmS+yXkqyoqID+rRbwHhgjTzbeXlmlR+aM2HDxKJLzqzhCIIr3rw3XRN
   q1hW7YQeNojZuMn11NH8mqXLGXzaFlxZwBb0Cvj6z39YBrK/hJA4KCDhf
   UMD+hk2sNYjWL6HpBOv8OPhKf6nAR2mx4xod6MIGtgTskkspTamOExWhv
   bDTt/qygVRd6JIj9NbYR6zHkOFeQ3wiL/m0EZ1GcQkNzdRHV0Ix4lBtVb
   TdV/oUYRmFrgeluEhzpQfXakhI7jtGyScKGFwcuII8B5/7y+eQqef82s8
   iJknT8bTN7Wg27o79sQJGWfsLjINF8Gn9saFnrI/llFVfrsTBPT3R7fB7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="388582377"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="388582377"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 00:58:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="743348065"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="743348065"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 19 Jun 2023 00:57:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 00:57:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 00:57:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 19 Jun 2023 00:57:47 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 19 Jun 2023 00:57:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFNXfeCWX5HrgQXY7GXqEo6MwI/wZacj8dTqNH9306mIw7Sh0PdPvLSRTb+XSIhXePBi+W6qHKL7rlyAJqnFehfZ+t7NOI0OQGYJ81FsY49TGDWzDTMo997mAsTLkxv7ltmN6uC4EYI8R+g+bwPh8K6HUJtFGlZKjmmCsjz9sgwtyB380s9kZa15ksd5VlTJJaqjJjbcOM94u/bPIYg/pmxjEqEvvXKUqJIXvz4CpeyFN/Ce1GQjwpvXsyXMAvAKNBozMqWN+algTLkyTYFwODdeTIs5wFUEbc2Re2342fb9fEPzrMFlPLTOrtORQ7eWFIPlgQuFRfDpzw/dvAO4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eXMfpIzHFcyAyBEoEkySSM5msx7ePjPbQREW7z2iBk=;
 b=Ywum5sV3S29N/I6O1mhCWbGQ1qula4ZhrBqzf1B0HnigGsxPVtAYwINFm9VhcAWQLwUvTS1nv5+hCUMnZa+AK6geYiGFfG1Kkh2kxGoPzxyv+QX6i4/UvgS166OkcYmrKjA9pjNzVUeNaqJzLrJMuOSLgfOlGY0W4vEVJHxwqJjhmIbrs2NwFozhU4kwNv5HFXH5PkLW6kadxIRZrEc+KqTYR1qP6lzgfX99nHD5VJFGBd1nIsE9Jyfam7nKsiMYDKvNMLyTeZdQ5tXdqka2N8eY92aY4vT37Cgw0YP7bZHquo0N2aRPx1MTbtixdlLLVd+l2wes7iy26v9268MV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MW3PR11MB4762.namprd11.prod.outlook.com (2603:10b6:303:5d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 07:57:45 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5486:41e6:7c9e:740e]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5486:41e6:7c9e:740e%7]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 07:57:44 +0000
Date:   Mon, 19 Jun 2023 15:54:39 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
CC:     <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Richard Weinberger <richard@nod.at>
Subject: arch/um/drivers/virt-pci.c:537:21: warning: no previous prototype
 for function 'pcibios_get_phb_of_node'
Message-ID: <202306190737.Z3uYTGpX-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MW3PR11MB4762:EE_
X-MS-Office365-Filtering-Correlation-Id: 54330a1f-887f-48fa-18d3-08db709add47
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NpHn9qzAYBA0RBk/O3NAnrvwH+U0pjUov5rtGF9FeuwTaAwqoGrxSruGA63f++T+lBXcJwHzPz5TVvwcykhTggOq5aJwcbuhcG0icuqW5i7EgWlqO0zJR/2Y2kmldB5KMKbDYT+6nG5gv9NHx+k1HBaH+tokGjdf9M6PRM90VkFqIV6KnwcSpvlpQ0QXdgFrttho9Y9wjQg1j+hfBNSZicXF1sRc68ffhjezxOTsCtsbcFRL7jTwjtIYLqC/AOD+TzTjsl45ROJ3g1S1mcg8s9z5g/Eu5RX6mz/WsX89lusOMK2xDQxtQi2wPr+F6yuY2f6vVZ0BDZfsjIacYEv69G9EbJ5FGHg07hOtT1QqGX4W5qTBaEanK/hkBg6IUPoFewtmmf9DOQM08jA6EPFhtWp0gHT/11Z43fAQqq6eSY83I7+MRzHE9lbDZZ8ehEgcxb7WxLXz9QKssvWnYi7PDBg2sOAk0ZoOgJ3m2d4XnmJ4JqJRwCDnAGMgR7F9UNvHsVYx9Ui/N3l/UnOzNz5xLlDSUpYs5dWvfBBfkWYkOMVgK8zIgDGrfqBt86z5hMCrmXztLTAbpZtXQ8DRza/ENw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(66946007)(8936002)(8676002)(66556008)(66476007)(1076003)(26005)(186003)(6506007)(6512007)(36756003)(82960400001)(83380400001)(41300700001)(38100700002)(5660300002)(4326008)(6916009)(316002)(966005)(2616005)(6666004)(6486002)(478600001)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+MuAEstyu78eUZUkrSiiGEQ2E1qlbvdZ99/k+KStRGyGjwSnoa78Y5wo1w+b?=
 =?us-ascii?Q?5wgtNCfLu242pRbN8lhUcfceWTL4nFeWXOIhfkfwU5eJl+jRK3sUEQCR/nu3?=
 =?us-ascii?Q?yRkIlplohB2lwY8APf9mHsvKxI3heU5fFF1G8EX3WlL3LBIDsLK5Sw0v6osa?=
 =?us-ascii?Q?re+93pPu6CVR2QWfx+dLNCdqQrodDTj3Wc0UuUVWjZVT9JHgDhYeO307n/h9?=
 =?us-ascii?Q?BMjsGpnzVnIHp914BAk9qokKSGpztjMwEe5FvRVtClXhcAEDo5xr6XC3KUCS?=
 =?us-ascii?Q?7hkiXB+FCJbpcSn9UpDq7Ro0pw7+AnGOjKEw+n85UpdoKSKkXgoTf8O5l17Y?=
 =?us-ascii?Q?iwJ17LtuFPaTOdWttkrzJhMrIwvdj3WrkrXbMWDRgFSl9uS8rfI6l2EtxBb5?=
 =?us-ascii?Q?FdRQuciKvJ4sdUhEo9GXQqjNoenVDa04xkOepmHvDAm0APDNmf+CflUHUHCt?=
 =?us-ascii?Q?gROCHlRL1nGUbh2EV02nTKeTM3gYELP2Z0M0ZJURztNLRaWm40Vqq+C66UEq?=
 =?us-ascii?Q?zpMFEjCS/ypfS797/BnpJqo/eX/UHVSkDVztyhWicrie2Rs2z3RTEzDBrlwX?=
 =?us-ascii?Q?Kt2x30dqD+wQuGdbBCItbqH64WrnMiYXl1qNjY4/EFdd+BEzxyMn5vfs4apE?=
 =?us-ascii?Q?wC81tNzmuVGAIBa79C0vdxDz94cigAt53Amg2oKMM5hSBLZ5Drb7lEo4OrrQ?=
 =?us-ascii?Q?FuQkRbPL2PhDaRCH+WO6TRfBai6KP36O9WGUdk7yxqj/h4kZh4mKSaOoWQwo?=
 =?us-ascii?Q?+e9WtjWe+7ptxqvT6pxazkNcPSfkdBmDrRM/1LyKFLtnteNpLJhYE5BmNGhe?=
 =?us-ascii?Q?S0qqUevC1ttwr/PcIsq9bGHBjMLUcMBqPY0o3tLxMRVqCogNHmr/QS+wlwa+?=
 =?us-ascii?Q?3mbKSUHk3u2hEXu7f4HMfi0Vx/h0R9arOCc6jBI7SJ6E9agDb61h+TlZwLig?=
 =?us-ascii?Q?Q7mDB46bCoF3LUmYB48PrFoXYzlrDx7pi2WIJcAbWtcUVS1MP8xO2w2KYo8l?=
 =?us-ascii?Q?Xuz3p+r5C1HBASbxXKboqgE9HG8IxBMuYnVKbYCbjPXD/WvmIPVRswUMGYlw?=
 =?us-ascii?Q?UDVm7hkWJy8RTXBkK/ZpaafbbkB7w0CE+SATCWgUl0Qpmcv7mK9/Wt0TcHQh?=
 =?us-ascii?Q?mDJr5ISVVhXVwef5EGqQWr7udO4Ddy6vzX5iyK3fgzEw2KprgfypTSwF5qXy?=
 =?us-ascii?Q?Gtyql44no35Yuy74jHMnI0Y4JMOmgAXhdJPScLVzmPGZa1jw0NxIGkwRhZpl?=
 =?us-ascii?Q?m8ROpzqkyW4J6OYz19+v96dmG/0ZJLn9xJ6J1nKb9yAsGsYFQi+UUmtj6mBl?=
 =?us-ascii?Q?+JfQ7vb909MIWyfSYqaT7/GwCckApuMowFXAlm+MUky2cGcJIbiARTHXJNCK?=
 =?us-ascii?Q?UzjLcULbdoFWxz3KR17NvoEbKnWUYden7pBHs6PmxCO0f0TepEC0zyH8IQLb?=
 =?us-ascii?Q?cIg1/6QOXUZjyRtibsFegiPzY7qEbSTirOom2TPKPZGbojXWm7TSwXeXHWkj?=
 =?us-ascii?Q?KglDT1A6HrxzM7yrvansiHhKdh5kCnS6CtWCCSjrbPmk4h1fE/7fDqjtIFmb?=
 =?us-ascii?Q?gX/8/puURMpR3TftugHb4lyc3BlljjC8mqEJIs1R?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54330a1f-887f-48fa-18d3-08db709add47
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 07:57:44.3886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kppymTFEhGnRHFKxxPZtZQnmENwmcYn6AaMKp901GDOIr4bI0kkyGc0Vv/L+Qw2gkKHF4hkkJf32Vyd6F2mcHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4762
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   45a3e24f65e90a047bef86f927ebdc4c710edaa1
commit: 314a1408b79a844dafdcde867d90de5d509409b7 um: virt-pci: implement pcibios_get_phb_of_node()
date:   4 months ago
config: um-randconfig-r002-20230619 (https://download.01.org/0day-ci/archive/20230619/202306190737.Z3uYTGpX-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230619/202306190737.Z3uYTGpX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202306190737.Z3uYTGpX-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/um/drivers/virt-pci.c:537:21: warning: no previous prototype for function 'pcibios_get_phb_of_node' [-Wmissing-prototypes]
   struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
                       ^
   arch/um/drivers/virt-pci.c:537:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
   ^
   static 


vim +/pcibios_get_phb_of_node +537 arch/um/drivers/virt-pci.c

68f5d3f3b65432 Johannes Berg      2021-03-05  535  
314a1408b79a84 Vincent Whitchurch 2023-01-20  536  /* Copied from arch/x86/kernel/devicetree.c */
314a1408b79a84 Vincent Whitchurch 2023-01-20 @537  struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
314a1408b79a84 Vincent Whitchurch 2023-01-20  538  {
314a1408b79a84 Vincent Whitchurch 2023-01-20  539  	struct device_node *np;
314a1408b79a84 Vincent Whitchurch 2023-01-20  540  
314a1408b79a84 Vincent Whitchurch 2023-01-20  541  	for_each_node_by_type(np, "pci") {
314a1408b79a84 Vincent Whitchurch 2023-01-20  542  		const void *prop;
314a1408b79a84 Vincent Whitchurch 2023-01-20  543  		unsigned int bus_min;
314a1408b79a84 Vincent Whitchurch 2023-01-20  544  
314a1408b79a84 Vincent Whitchurch 2023-01-20  545  		prop = of_get_property(np, "bus-range", NULL);
314a1408b79a84 Vincent Whitchurch 2023-01-20  546  		if (!prop)
314a1408b79a84 Vincent Whitchurch 2023-01-20  547  			continue;
314a1408b79a84 Vincent Whitchurch 2023-01-20  548  		bus_min = be32_to_cpup(prop);
314a1408b79a84 Vincent Whitchurch 2023-01-20  549  		if (bus->number == bus_min)
314a1408b79a84 Vincent Whitchurch 2023-01-20  550  			return np;
314a1408b79a84 Vincent Whitchurch 2023-01-20  551  	}
314a1408b79a84 Vincent Whitchurch 2023-01-20  552  	return NULL;
314a1408b79a84 Vincent Whitchurch 2023-01-20  553  }
314a1408b79a84 Vincent Whitchurch 2023-01-20  554  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

