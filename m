Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3B26E54EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 01:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjDQXBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 19:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjDQXBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 19:01:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEA1B8;
        Mon, 17 Apr 2023 16:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681772466; x=1713308466;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q+Q/lktizb0DsVekScToQ4fJ5gK1leNFrALQoWzvoRs=;
  b=gGgBKzZ2/3RdEBUhMNwvohSVleyKxCZQmB9nrOeCzZT32ru96kVqBLng
   6hfDroUjYTc3/lpjYxXVi3OBb6KBn3TQwyh4HUPORsot+s4WlcStNsL9a
   /brDoxhChzOvX2DYUWB9qLSVnCKLBPFpD30ldeIQ8S+X0qPzqVtmT3fk4
   rk3zoo8GdzT0lrq3p8L8bcYA/jqvAIAiiFOhGK4kx393BYl+pUufkaa/X
   Vo5x+0JgBzA/IRlzwSzGJe0T4Wy3orJ0ACxzyHYNRbicArfWGvtyPpQJQ
   hsGpuPVA8jq+gnZJiqUUNjyuehf35Z7sqjwd0GUl5Km2r47MQTTvNWmjo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="325365884"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="325365884"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 16:01:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="937028273"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="937028273"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 17 Apr 2023 16:00:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 16:00:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 16:00:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 17 Apr 2023 16:00:53 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 17 Apr 2023 16:00:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lw4ht2yuAQHJplxZYYu62pvSa3hW7uY9CNVDRypspUxTJZAVSK2xpBSHn3nUdD2eHe9GBtPXCLYRTRPw1HAJt2t7+7osVrifQIsa7Gh7JRFkIGskISDZbIxfQYLC+e0J5rrOnLOzn9wT/oQy2tV0ykq/i7kV7H0xBKF8NKkVbtxceoYp/QAGh2XCmFsbbpe3vDNnTLXj3/1YSddDwAFEp2X3dZk6r66ce8ewIL55qWcPdPXy8rSgxuK1vGzUcBbytRmupPD3VPyH9n7otT3khcKkOVqQ1sAtQCD9W9rRhtC8U9JyyTA84Qd9Kts6HDN7raDaqB6j8gqgnGYxsgcmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLyVd/8D4PsaYT/X9nJPzxdq9nRzsjiy6sW50RGB4J0=;
 b=COZinIgHZyunKDwfILYk/B80OnUsU720xEenMbwo+AXtEIBVQnAAvcCEnHxW0vMdlT+kT/H53n09m91F8nghFbKZYanO9BUqSFgdUz5tuONFAjwhRuDOZhoEx1DyuTLcQZDu8byLqm5ZURggD84JMQ9PD0VKm4QRWKSmZTjH6UizlDLDFLStxR6QQGqq9wHwxeJmM+6uLX/CpR3vMes2NrgEbSUxIIlelVUeb+Ot14w/KEEu53TVzWYh7xRe7FdKwlX3Tnw+HxFGAWUYOx8CW9XrDkuNWrVjWqW0mxJ2XPBFf9wM6u8x5iRJe7yCqQAQkuwANDqG0Ebj0WaHcvLyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7899.namprd11.prod.outlook.com (2603:10b6:930:7e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 23:00:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 23:00:49 +0000
Date:   Mon, 17 Apr 2023 16:00:47 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v3 1/6] cxl/pci: Add RCH downstream port AER and RAS
 register discovery
Message-ID: <643dcf9eed443_1b66294b5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230411180302.2678736-1-terry.bowman@amd.com>
 <20230411180302.2678736-2-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230411180302.2678736-2-terry.bowman@amd.com>
X-ClientProxiedBy: BY5PR17CA0065.namprd17.prod.outlook.com
 (2603:10b6:a03:167::42) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e787c4-dc46-4e96-639e-08db3f9795d3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmHIdrgFdbhu6nKicJ9UpbJSp6rM5min0oXG7HMXNHqYJfnXl/Dx30rUBIHAyJpwkU+ZCXn3zk5vqWQSC4C5RcIHaC4hBPLD6vBKTbBP8IINpEuh35UBQjI4GSiKFvZkImLuzQQD5pvJtyCJCCHRXb2evwP/ivjtVV+lw42IgyTCcZndNm+xHaw86JlsOzLR8lWjDzrnZ4fFUi0QeWGt90plOOJR78G28WENLBsMom8J/byibpCyqtLjWYKTw78kgRrfdTdofBfB95r+JoJxSzuWRILgcX245fBiBUGxSajn5obSJ8WW0n0vIt7VW85Yrlr2frt1VKeq1au2v7cYqYlN/gBptoGCNaIxuGQRARnSRqYPglYS2RJOaO9h28/pFQI+pRgPAukvO2GNKKzcjCENJHo/zBAwCoiGyLn3/OoEgdZ0NXy10p0cafLnL9jmPEddjMYBwQG0NjDmXV16jVADrPT3cQJ6zJmzYFA4xItt6J2qHbqgaL/E5/CQaIN7b7yQycNY0of1bEzGa2/VZTbNKdOLs+hJvrm8HVHS7lmoqc5y5qoklsTCuVRbCGkI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199021)(8676002)(5660300002)(186003)(8936002)(41300700001)(38100700002)(30864003)(2906002)(83380400001)(82960400001)(478600001)(6506007)(53546011)(26005)(6512007)(9686003)(6486002)(316002)(86362001)(66556008)(4326008)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wY8/+fsTgrINPV3SxvBvMAo/U7DMu8gvDOwXbLMW217d3902nvpsUBQSDXrT?=
 =?us-ascii?Q?Bf0SjBqZ0ndMPC+qQk0zA/hwIsH1pGXzKktZY6Ozk1+RDRLFrUhqXBUf7Lvi?=
 =?us-ascii?Q?G1o741GlD374MWAdBV3HI18130ATQD7UMRFQ1RV4TFlHZcazvzn/F+EqONPJ?=
 =?us-ascii?Q?DvQlaNR65hhXxq33d7cMwE0qi40xmTOUn24vh92YhSZB/Uzc1Vftuth5E5aA?=
 =?us-ascii?Q?aDXScM8cneiGbK10vWJGiiSFYkDLItE0Qm7GI4oi9CGtSre8zeVXLd8AN3EU?=
 =?us-ascii?Q?wp/RB2sjPCJSdzqY88zLANOjSyLzYVefPrqL9J7EPO/3AaMEkndeRkZjRIBz?=
 =?us-ascii?Q?F2p1MMaNmiFefmWtLCQxAfH9vFSGdzG7LvAaX53rwzsXYqkWLK3k6pfMoMh7?=
 =?us-ascii?Q?C/WZmJejrLkF5m6+2/Py5GiYioZLwz21FqGcjNVGsk7fxAaDgF3TB07Hgt+Q?=
 =?us-ascii?Q?Y/p4hpngMgkHt6rEx5kwg7rjtEQJhcH6TzJOp1O+iTnQgPcoIs+vsuFvO7Iu?=
 =?us-ascii?Q?i9/7G5+wllpiTjuIALrbsOAyk5D4Us6HqdhXs6p4cHmGpo3Cze/h42GQTrPE?=
 =?us-ascii?Q?fbKsPHbUlKPJ4lOwwhWrzgfBZkEKr9ji+huhz50imDoBCvy0azWsrsmzCLm6?=
 =?us-ascii?Q?LOUfaWqJmVLfCsnO+eZDZaaYI1N5kmoE5bW4wv+wDMP/yfyiBYVHCYhXDLIR?=
 =?us-ascii?Q?vI9fEIjhBrcEe3iGbObvPEfCXke8Z/PxX9j5+sTVHaSeA2FbMbotPYdN6QH8?=
 =?us-ascii?Q?s7BOmN18kCKhX9wntAekmnMe0Gt1JWy7G5rR9JpJ/x+LC0Tt/NoM2wFxAOJO?=
 =?us-ascii?Q?+lGLWHux2UKnSM+hJfcMDXu9YYWJ6zGhiyEVXfg0td/Ac8uFBfgp+B1c6q2t?=
 =?us-ascii?Q?W/uKdgJFSo6wXj2relC/7ifUQEsFNcpPSRMZJYxXqF9cFPMIAxl892ua1/1L?=
 =?us-ascii?Q?7p/ZQIjFUjT0GcAhRK/l6iQ4bRqy/4+fq+3vdx5xgLi3kXB/Y340ZrxiwtqW?=
 =?us-ascii?Q?fYfEBh0WXGpjKpHwx9wjvK0wN4mRbhC0CO/bgmwjhAJc+lxE1yXMD6Gg58kY?=
 =?us-ascii?Q?pfXSAV1g4CAv2aiLV/WYco/B1x3OsCcGwWdN7MjKST5928CdAP8iSm648rXS?=
 =?us-ascii?Q?iKm+Z/roALqsdfAWlbhYMbZ/T07/iOyS6q6/hM3wA4TamZMW62T+KibsOcvn?=
 =?us-ascii?Q?4clKLCERsnRt/8MkcTQmmedHFN1Xk5+cNu8ZD412sg+VwdZgC8rrKWUlCjXg?=
 =?us-ascii?Q?3DjhWTJhc7E0/Ly531uOP50p83aWkdJl7bgq8ygU86pcPWuSVDuJpWhTluPy?=
 =?us-ascii?Q?odU9yqzPNMfDsEhpLSaBBLm8/WRa+UIIem8ugiDa0Qq2EjkuQMN1Vz7Y1VX3?=
 =?us-ascii?Q?XUDkSOi8dtrnoJ+uIFhc+E2zakO6TB4cMQxC8ZOIDFzXubpWvz9JQ6qudfrI?=
 =?us-ascii?Q?fkQHVdL9EKcVATgv5fq0vgcML/nbVw9LcL2U9nH5ZSIyLTZU7TR9B+qbU/b2?=
 =?us-ascii?Q?Xgj9I4kELEnYyD4MmhbtO0//4HeAAICOU6IFWTQ3rdajY+yxfIpbaxUqD3oa?=
 =?us-ascii?Q?lJjmErUbv7ijvmqqBqPU99iQvhezHWTowDfKtd/MN7mq+m7RuWrwT2k9O9tY?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e787c4-dc46-4e96-639e-08db3f9795d3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 23:00:49.2332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHrH8guAoKvVgcS1Yn7McN/QsJD1kOKWKlwDM0l5SkW32VpLf9ChmowI1Z1R8km65OkvPTTb0kEMaEeGzF84UYU3yVp+hSoIfTLtnHUoCng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7899
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> Restricted CXL host (RCH) downstream port AER information is not currently
> logged while in the error state. One problem preventing existing PCIe AER
> functions from logging errors is the AER registers are not accessible. The
> CXL driver requires changes to find RCH downstream port AER registers for
> purpose of error logging.
> 
> RCH downstream ports are not enumerated during a PCI bus scan and are
> instead discovered using system firmware, ACPI in this case.[1] The
> downstream port is implemented as a Root Complex Register Block (RCRB).
> The RCRB is a 4k memory block containing PCIe registers based on the PCIe
> root port.[2] The RCRB includes AER extended capability registers used for
> reporting errors. Note, the RCH's AER Capability is located in the RCRB
> memory space instead of PCI configuration space, thus its register access
> is different. Existing kernel PCIe AER functions can not be used to manage
> the downstream port AER capabilities because the port was not enumerated
> during PCI scan and the registers are not PCI config accessible.
> 
> Discover RCH downstream port AER extended capability registers. This
> requires using MMIO accesses to search for extended AER capability in
> RCRB register space.
> 
> [1] CXL 3.0 Spec, 9.11.2 - System Firmware View of CXL 1.1 Hierarchy
> [2] CXL 3.0 Spec, 8.2.1.1 - RCH Downstream Port RCRB
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/regs.c | 93 +++++++++++++++++++++++++++++++++++------
>  drivers/cxl/cxl.h       |  5 +++
>  drivers/cxl/mem.c       | 39 +++++++++++------
>  3 files changed, 113 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 1476a0299c9b..bde1fffab09e 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -332,10 +332,36 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
>  
> +static void __iomem *cxl_map_reg(struct device *dev, struct cxl_register_map *map,
> +				 char *name)
> +{
> +
> +	if (!request_mem_region(map->resource, map->max_size, name))
> +		return NULL;
> +
> +	map->base = ioremap(map->resource, map->max_size);
> +	if (!map->base) {
> +		release_mem_region(map->resource, map->max_size);
> +		return NULL;
> +	}
> +
> +	return map->base;
> +}
> +
> +static void cxl_unmap_reg(struct device *dev, struct cxl_register_map *map)
> +{
> +	iounmap(map->base);
> +	release_mem_region(map->resource, map->max_size);
> +}

Not clear why these new functions are needed vs cxl_map_regblock() /
cxl_unmap_regblock(), and this refactoring looks unrelated to the
claimed changes in the patch changelog.

...oh, I think I see why you went this way, a potential counter-proposal
below.

> +
>  resource_size_t cxl_rcrb_to_component(struct device *dev,
>  				      resource_size_t rcrb,
>  				      enum cxl_rcrb which)
>  {
> +	struct cxl_register_map map = {
> +		.resource = rcrb,
> +		.max_size = SZ_4K
> +	};
>  	resource_size_t component_reg_phys;
>  	void __iomem *addr;
>  	u32 bar0, bar1;
> @@ -343,7 +369,10 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>  	u32 id;
>  
>  	if (which == CXL_RCRB_UPSTREAM)
> -		rcrb += SZ_4K;
> +		map.resource += SZ_4K;
> +
> +	if (!cxl_map_reg(dev, &map, "CXL RCRB"))
> +		return CXL_RESOURCE_NONE;
>  
>  	/*
>  	 * RCRB's BAR[0..1] point to component block containing CXL
> @@ -351,21 +380,12 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>  	 * the PCI Base spec here, esp. 64 bit extraction and memory
>  	 * ranges alignment (6.0, 7.5.1.2.1).
>  	 */
> -	if (!request_mem_region(rcrb, SZ_4K, "CXL RCRB"))
> -		return CXL_RESOURCE_NONE;
> -	addr = ioremap(rcrb, SZ_4K);
> -	if (!addr) {
> -		dev_err(dev, "Failed to map region %pr\n", addr);
> -		release_mem_region(rcrb, SZ_4K);
> -		return CXL_RESOURCE_NONE;
> -	}
> -
> +	addr = map.base;
>  	id = readl(addr + PCI_VENDOR_ID);
>  	cmd = readw(addr + PCI_COMMAND);
>  	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
>  	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
> -	iounmap(addr);
> -	release_mem_region(rcrb, SZ_4K);
> +	cxl_unmap_reg(dev, &map);
>  
>  	/*
>  	 * Sanity check, see CXL 3.0 Figure 9-8 CXL Device that Does Not
> @@ -396,3 +416,52 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>  	return component_reg_phys;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_component, CXL);
> +
> +u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
> +{
> +	struct cxl_register_map map = {
> +		.resource = rcrb,
> +		.max_size = SZ_4K,
> +	};
> +	u32 cap_hdr;
> +	u16 offset = 0;
> +
> +	if (!cxl_map_reg(dev, &map, "CXL RCRB"))
> +		return 0;
> +
> +	cap_hdr = readl(map.base + offset);
> +	while (PCI_EXT_CAP_ID(cap_hdr) != PCI_EXT_CAP_ID_ERR) {
> +
> +		offset = PCI_EXT_CAP_NEXT(cap_hdr);
> +		if (!offset) {
> +			cxl_unmap_reg(dev, &map);
> +			return 0;
> +		}
> +		cap_hdr = readl(map.base + offset);
> +	}
> +
> +	dev_dbg(dev, "found AER extended capability (0x%x)\n", offset);
> +	cxl_unmap_reg(dev, &map);
> +
> +	return offset;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, CXL);

> +
> +u16 cxl_component_to_ras(struct device *dev, resource_size_t component_reg_phys)
> +{
> +	struct cxl_register_map map = {
> +		.resource = component_reg_phys,
> +		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> +	};
> +
> +	if (!cxl_map_reg(dev, &map, "component"))
> +		return 0;
> +
> +	cxl_probe_component_regs(dev, map.base, &map.component_map);
> +	cxl_unmap_reg(dev, &map);
> +	if (!map.component_map.ras.valid)
> +		return 0;
> +
> +	return map.component_map.ras.offset;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_component_to_ras, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 044a92d9813e..df64c402e6e6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -270,6 +270,9 @@ enum cxl_rcrb {
>  resource_size_t cxl_rcrb_to_component(struct device *dev,
>  				      resource_size_t rcrb,
>  				      enum cxl_rcrb which);
> +u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
> +u16 cxl_component_to_ras(struct device *dev,
> +			 resource_size_t component_reg_phys);
>  
>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>  #define CXL_TARGET_STRLEN 20
> @@ -601,6 +604,8 @@ struct cxl_dport {
>  	int port_id;
>  	resource_size_t component_reg_phys;
>  	resource_size_t rcrb;
> +	u16 aer_cap;
> +	u16 ras_cap;
>  	bool rch;
>  	struct cxl_port *port;
>  };
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 39c4b54f0715..014295ab6bc6 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -45,13 +45,36 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>  	return 0;
>  }
>  
> +static void cxl_setup_rcrb(struct cxl_dev_state *cxlds,
> +			   struct cxl_dport *parent_dport)
> +{
> +	struct cxl_memdev *cxlmd  = cxlds->cxlmd;
> +
> +	if (!parent_dport->rch)
> +		return;
> +
> +	/*
> +	 * The component registers for an RCD might come from the
> +	 * host-bridge RCRB if they are not already mapped via the
> +	 * typical register locator mechanism.
> +	 */
> +	if (cxlds->component_reg_phys == CXL_RESOURCE_NONE)
> +		cxlds->component_reg_phys = cxl_rcrb_to_component(
> +			&cxlmd->dev, parent_dport->rcrb, CXL_RCRB_UPSTREAM);
> +
> +	parent_dport->aer_cap = cxl_rcrb_to_aer(parent_dport->dport,
> +						parent_dport->rcrb);

Hmm, how about just retrieve this as part of cxl_rcrb_to_component()
(renamed to cxl_probe_rcrb()), and make an rch dport its own distinct
object? Otherwise it feels odd to be retrieving downstream port
properties this late at upstream port component register detection time.
It also feels awkward to keep adding more RCH dport specific details to
the common 'struct cxl_dport'. So, I'm thinking something like the
following (compiled and cxl_test regression passed):

-- >8 --
From 18fbc72f98655d10301c7a35f614b6152f46c44b Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 17 Apr 2023 15:45:50 -0700
Subject: [PATCH] cxl/rch: Prepare for caching the MMIO mapped PCIe AER
 capability

Prepare cxl_probe_rcrb() for retrieving more than just the component
register block. The RCH AER handling code wants to get back to the AER
capability that happens to be MMIO mapped rather then configuration
cycles.

Move rcrb specific dport data, like the RCRB base and the AER capability
offset, into its own data structure ('struct cxl_rcrb_info') for
cxl_probe_rcrb() to fill.  Introduce 'struct cxl_rch_dport' to wrap a
'struct cxl_dport' with a 'struct cxl_rcrb_info' attribute.

This centralizes all RCRB scanning in one routine.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c            | 16 ++++++++--------
 drivers/cxl/core/port.c       | 33 +++++++++++++++++++++------------
 drivers/cxl/core/regs.c       | 12 ++++++++----
 drivers/cxl/cxl.h             | 21 +++++++++++++++------
 drivers/cxl/mem.c             | 15 ++++++++++-----
 tools/testing/cxl/Kbuild      |  2 +-
 tools/testing/cxl/test/cxl.c  | 10 ++++++----
 tools/testing/cxl/test/mock.c | 12 ++++++------
 tools/testing/cxl/test/mock.h |  7 ++++---
 9 files changed, 79 insertions(+), 49 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 4e66483f1fd3..2647eb04fcdb 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -375,7 +375,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 struct cxl_chbs_context {
 	struct device *dev;
 	unsigned long long uid;
-	resource_size_t rcrb;
+	struct cxl_rcrb_info rcrb;
 	resource_size_t chbcr;
 	u32 cxl_version;
 };
@@ -395,7 +395,7 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
 		return 0;
 
 	ctx->cxl_version = chbs->cxl_version;
-	ctx->rcrb = CXL_RESOURCE_NONE;
+	ctx->rcrb.base = CXL_RESOURCE_NONE;
 	ctx->chbcr = CXL_RESOURCE_NONE;
 
 	if (!chbs->base)
@@ -409,9 +409,8 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
 	if (chbs->length != CXL_RCRB_SIZE)
 		return 0;
 
-	ctx->rcrb = chbs->base;
-	ctx->chbcr = cxl_rcrb_to_component(ctx->dev, chbs->base,
-					   CXL_RCRB_DOWNSTREAM);
+	ctx->chbcr = cxl_probe_rcrb(ctx->dev, chbs->base, &ctx->rcrb,
+				    CXL_RCRB_DOWNSTREAM);
 
 	return 0;
 }
@@ -451,8 +450,9 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 		return 0;
 	}
 
-	if (ctx.rcrb != CXL_RESOURCE_NONE)
-		dev_dbg(match, "RCRB found for UID %lld: %pa\n", uid, &ctx.rcrb);
+	if (ctx.rcrb.base != CXL_RESOURCE_NONE)
+		dev_dbg(match, "RCRB found for UID %lld: %pa\n", uid,
+			&ctx.rcrb.base);
 
 	if (ctx.chbcr == CXL_RESOURCE_NONE) {
 		dev_warn(match, "CHBCR invalid for Host Bridge (UID %lld)\n",
@@ -466,7 +466,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	bridge = pci_root->bus->bridge;
 	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11)
 		dport = devm_cxl_add_rch_dport(root_port, bridge, uid,
-					       ctx.chbcr, ctx.rcrb);
+					       ctx.chbcr, &ctx.rcrb);
 	else
 		dport = devm_cxl_add_dport(root_port, bridge, uid,
 					   ctx.chbcr);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 4003f445320c..d194f48259ff 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -920,7 +920,7 @@ static void cxl_dport_unlink(void *data)
 static struct cxl_dport *
 __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		     int port_id, resource_size_t component_reg_phys,
-		     resource_size_t rcrb)
+		     struct cxl_rcrb_info *ri)
 {
 	char link_name[CXL_TARGET_STRLEN];
 	struct cxl_dport *dport;
@@ -942,17 +942,26 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	    CXL_TARGET_STRLEN)
 		return ERR_PTR(-EINVAL);
 
-	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
-	if (!dport)
-		return ERR_PTR(-ENOMEM);
+	if (ri && ri->base != CXL_RESOURCE_NONE) {
+		struct cxl_rch_dport *rdport;
+
+		rdport = devm_kzalloc(host, sizeof(*rdport), GFP_KERNEL);
+		if (!rdport)
+			return ERR_PTR(-ENOMEM);
+
+		rdport->rcrb.base = ri->base;
+		dport = &rdport->dport;
+		dport->rch = true;
+	} else {
+		dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
+		if (!dport)
+			return ERR_PTR(-ENOMEM);
+	}
 
 	dport->dport = dport_dev;
 	dport->port_id = port_id;
 	dport->component_reg_phys = component_reg_phys;
 	dport->port = port;
-	if (rcrb != CXL_RESOURCE_NONE)
-		dport->rch = true;
-	dport->rcrb = rcrb;
 
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
@@ -994,7 +1003,7 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 	struct cxl_dport *dport;
 
 	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
-				     component_reg_phys, CXL_RESOURCE_NONE);
+				     component_reg_phys, NULL);
 	if (IS_ERR(dport)) {
 		dev_dbg(dport_dev, "failed to add dport to %s: %ld\n",
 			dev_name(&port->dev), PTR_ERR(dport));
@@ -1013,24 +1022,24 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, CXL);
  * @dport_dev: firmware or PCI device representing the dport
  * @port_id: identifier for this dport in a decoder's target list
  * @component_reg_phys: optional location of CXL component registers
- * @rcrb: mandatory location of a Root Complex Register Block
+ * @ri: mandatory data about the Root Complex Register Block layout
  *
  * See CXL 3.0 9.11.8 CXL Devices Attached to an RCH
  */
 struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 struct device *dport_dev, int port_id,
 					 resource_size_t component_reg_phys,
-					 resource_size_t rcrb)
+					 struct cxl_rcrb_info *ri)
 {
 	struct cxl_dport *dport;
 
-	if (rcrb == CXL_RESOURCE_NONE) {
+	if (!ri || ri->base == CXL_RESOURCE_NONE) {
 		dev_dbg(&port->dev, "failed to add RCH dport, missing RCRB\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
-				     component_reg_phys, rcrb);
+				     component_reg_phys, ri);
 	if (IS_ERR(dport)) {
 		dev_dbg(dport_dev, "failed to add RCH dport to %s: %ld\n",
 			dev_name(&port->dev), PTR_ERR(dport));
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 52d1dbeda527..b1c0db898a50 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -332,9 +332,8 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
 
-resource_size_t cxl_rcrb_to_component(struct device *dev,
-				      resource_size_t rcrb,
-				      enum cxl_rcrb which)
+resource_size_t cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
+			       struct cxl_rcrb_info *ri, enum cxl_rcrb which)
 {
 	resource_size_t component_reg_phys;
 	void __iomem *addr;
@@ -344,6 +343,8 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
 
 	if (which == CXL_RCRB_UPSTREAM)
 		rcrb += SZ_4K;
+	else
+		ri->base = rcrb;
 
 	/*
 	 * RCRB's BAR[0..1] point to component block containing CXL
@@ -364,6 +365,9 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
 	cmd = readw(addr + PCI_COMMAND);
 	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
 	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
+
+	/* TODO: retrieve rcrb->aer_cap here */
+
 	iounmap(addr);
 	release_mem_region(rcrb, SZ_4K);
 
@@ -395,4 +399,4 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
 
 	return component_reg_phys;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_component, CXL);
+EXPORT_SYMBOL_NS_GPL(cxl_probe_rcrb, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1503ccec9a84..b0807f54e9fd 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -267,9 +267,9 @@ enum cxl_rcrb {
 	CXL_RCRB_DOWNSTREAM,
 	CXL_RCRB_UPSTREAM,
 };
-resource_size_t cxl_rcrb_to_component(struct device *dev,
-				      resource_size_t rcrb,
-				      enum cxl_rcrb which);
+struct cxl_rcrb_info;
+resource_size_t cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
+			       struct cxl_rcrb_info *ri, enum cxl_rcrb which);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
@@ -589,12 +589,12 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
 	return xa_load(&port->dports, (unsigned long)dport_dev);
 }
 
+
 /**
  * struct cxl_dport - CXL downstream port
  * @dport: PCI bridge or firmware device representing the downstream link
  * @port_id: unique hardware identifier for dport in decoder target list
  * @component_reg_phys: downstream port component registers
- * @rcrb: base address for the Root Complex Register Block
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
  */
@@ -602,11 +602,20 @@ struct cxl_dport {
 	struct device *dport;
 	int port_id;
 	resource_size_t component_reg_phys;
-	resource_size_t rcrb;
 	bool rch;
 	struct cxl_port *port;
 };
 
+struct cxl_rcrb_info {
+	resource_size_t base;
+	u16 aer_cap;
+};
+
+struct cxl_rch_dport {
+	struct cxl_dport dport;
+	struct cxl_rcrb_info rcrb;
+};
+
 /**
  * struct cxl_ep - track an endpoint's interest in a port
  * @ep: device that hosts a generic CXL endpoint (expander or accelerator)
@@ -674,7 +683,7 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 struct device *dport_dev, int port_id,
 					 resource_size_t component_reg_phys,
-					 resource_size_t rcrb);
+					 struct cxl_rcrb_info *ri);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 097d86dd2a8e..7da6135e0b17 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -71,10 +71,15 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	 * host-bridge RCRB if they are not already mapped via the
 	 * typical register locator mechanism.
 	 */
-	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
-		component_reg_phys = cxl_rcrb_to_component(
-			&cxlmd->dev, parent_dport->rcrb, CXL_RCRB_UPSTREAM);
-	else
+	if (parent_dport->rch &&
+	    cxlds->component_reg_phys == CXL_RESOURCE_NONE) {
+		struct cxl_rch_dport *rdport =
+			container_of(parent_dport, typeof(*rdport), dport);
+
+		component_reg_phys =
+			cxl_probe_rcrb(&cxlmd->dev, rdport->rcrb.base,
+				       &rdport->rcrb, CXL_RCRB_UPSTREAM);
+	} else
 		component_reg_phys = cxlds->component_reg_phys;
 	endpoint = devm_cxl_add_port(host, &cxlmd->dev, component_reg_phys,
 				     parent_dport);
@@ -92,7 +97,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	}
 
 	return 0;
-}
+	}
 
 static int cxl_mem_probe(struct device *dev)
 {
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index fba7bec96acd..bef1bc3bd912 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -11,7 +11,7 @@ ldflags-y += --wrap=devm_cxl_enumerate_decoders
 ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=cxl_hdm_decode_init
 ldflags-y += --wrap=cxl_dvsec_rr_decode
-ldflags-y += --wrap=cxl_rcrb_to_component
+ldflags-y += --wrap=cxl_probe_rcrb
 
 DRIVERS := ../../../drivers
 CXL_SRC := $(DRIVERS)/cxl
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 385cdeeab22c..805c79491485 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -983,12 +983,14 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
 	return 0;
 }
 
-resource_size_t mock_cxl_rcrb_to_component(struct device *dev,
-					   resource_size_t rcrb,
-					   enum cxl_rcrb which)
+resource_size_t mock_cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
+				    struct cxl_rcrb_info *ri, enum cxl_rcrb which)
 {
 	dev_dbg(dev, "rcrb: %pa which: %d\n", &rcrb, which);
 
+	if (which == CXL_RCRB_DOWNSTREAM)
+		ri->base = rcrb;
+
 	return (resource_size_t) which + 1;
 }
 
@@ -1000,7 +1002,7 @@ static struct cxl_mock_ops cxl_mock_ops = {
 	.is_mock_dev = is_mock_dev,
 	.acpi_table_parse_cedt = mock_acpi_table_parse_cedt,
 	.acpi_evaluate_integer = mock_acpi_evaluate_integer,
-	.cxl_rcrb_to_component = mock_cxl_rcrb_to_component,
+	.cxl_probe_rcrb = mock_cxl_probe_rcrb,
 	.acpi_pci_find_root = mock_acpi_pci_find_root,
 	.devm_cxl_port_enumerate_dports = mock_cxl_port_enumerate_dports,
 	.devm_cxl_setup_hdm = mock_cxl_setup_hdm,
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index c4e53f22e421..148bd4f184f5 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -244,9 +244,9 @@ int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dvsec_rr_decode, CXL);
 
-resource_size_t __wrap_cxl_rcrb_to_component(struct device *dev,
-					     resource_size_t rcrb,
-					     enum cxl_rcrb which)
+resource_size_t __wrap_cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
+				      struct cxl_rcrb_info *ri,
+				      enum cxl_rcrb which)
 {
 	int index;
 	resource_size_t component_reg_phys;
@@ -254,14 +254,14 @@ resource_size_t __wrap_cxl_rcrb_to_component(struct device *dev,
 
 	if (ops && ops->is_mock_port(dev))
 		component_reg_phys =
-			ops->cxl_rcrb_to_component(dev, rcrb, which);
+			ops->cxl_probe_rcrb(dev, rcrb, ri, which);
 	else
-		component_reg_phys = cxl_rcrb_to_component(dev, rcrb, which);
+		component_reg_phys = cxl_probe_rcrb(dev, rcrb, ri, which);
 	put_cxl_mock_ops(index);
 
 	return component_reg_phys;
 }
-EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcrb_to_component, CXL);
+EXPORT_SYMBOL_NS_GPL(__wrap_cxl_probe_rcrb, CXL);
 
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(ACPI);
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index bef8817b01f2..7ef21356d052 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -15,9 +15,10 @@ struct cxl_mock_ops {
 					     acpi_string pathname,
 					     struct acpi_object_list *arguments,
 					     unsigned long long *data);
-	resource_size_t (*cxl_rcrb_to_component)(struct device *dev,
-						 resource_size_t rcrb,
-						 enum cxl_rcrb which);
+	resource_size_t (*cxl_probe_rcrb)(struct device *dev,
+					  resource_size_t rcrb,
+					  struct cxl_rcrb_info *ri,
+					  enum cxl_rcrb which);
 	struct acpi_pci_root *(*acpi_pci_find_root)(acpi_handle handle);
 	bool (*is_mock_bus)(struct pci_bus *bus);
 	bool (*is_mock_port)(struct device *dev);
-- 
2.39.2
-- >8 --


> +
> +	parent_dport->ras_cap = cxl_component_to_ras(parent_dport->dport,
> +						     parent_dport->component_reg_phys);

Since this is component register offset based can it not be shared with
the VH case? I have been expecting that RCH RAS capability and VH RAS
capability scanning would need to be unified in the cxl_port driver.
