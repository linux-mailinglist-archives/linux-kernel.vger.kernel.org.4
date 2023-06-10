Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C081572A7BB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 03:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjFJBov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 21:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFJBos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 21:44:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985BD26B9;
        Fri,  9 Jun 2023 18:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686361487; x=1717897487;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m7i8rkhaIwdf8urLmZc8aELVTZKaOe258mWPYWOJCjA=;
  b=cAbr/lMuOJlAgi8mn2+WqDyhFAPLO7d1K2ArPE7T014m16M+F1YNY7W+
   Iabv3bLLMgcjDA35EYHjr0BlK7WSdPrndJPNgP0BInUCdzoCHPisw3zBV
   R4owxmj6QZgsMPgHuwIP83rNy+AGmegFN+cWp0CYjz4/i/dOeN0YZLS5G
   IKLrG8j3QpfiwzcLgbudf+hA2jX4aPIPEmbxJ5/RHcDt0ufn1VhzqJ1I7
   lhLzYK4/7qV9rlPuoeTPlIqQ7x9BsoORH1at46mxkU1LRPFxmTKn7R+GQ
   baaqSj131yU5P/huu2qGm7MFLJVJR6slEDEdeOVpCFP5H0Elbo0VX1asd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="338080224"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="338080224"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 18:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="823257895"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="823257895"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2023 18:44:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 18:44:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 18:44:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 18:44:45 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 18:44:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SI4RKmZ/rT/PUE/hxKaezb2TUMyRYdj6Zg5YkP7FdGeLzNRWwbdETPyVwqO9vN0w+0NlDgQTba0+ATZ1pkWBa3rSgp2juJAVlY/b/QuZEqxPn2qCOTAenSF+lPdfawLpNDpTIUJylYaaM4RjlFciwQEuLni/8NiI2QRbacu/vV7JVCa2uQkLCsNE608k2CcaTeLsBSnwf8CCE2L7vIvOFimwQPWYRJ+pAHssq9SjRNM39bJCueZ42w0ATq25y6vqhGdgqrLt6+Az45Oa484sNZwnZxj1Oah+xVfa6liTtkyvKJQynstUZGlC0vzdcX6wm26Ozu781Ct/OXHL1gdvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ospbpuspNRXkwYRUZIXJvNb27/f7JniHEV8SrzeU3po=;
 b=Eg8/Bnaim7nbmiMZTRpF6ONj55cke6e5UHw/qRsvtz/jWiuqdc3e2zdTXP//n8LZ+1vUXL0fOY8I+qgPWXKmNTgHJnWVLl0K/lSne4oWSC9/nQhTo5CoMXzVXWZvRmWgalWacWZKP+VYaUng2q1d2Q9Sr6HlnyhRhLEfk1iWL5L0a0pFWfTGNJzyg1FNRPNg1P6D4Tg1rnt4h3FOjBr56AJjBV6Frwsv9Kw/8V0+5icCwY7AVqVXqwc6zMu+45WnN6bq+tOjKIB9rPFDOf3j319WDKU3d6v+vky8QIQDkIzV3YQWJO685IRd017k+p6VvwPNIM8LCEJu3XWGoiAcyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6963.namprd11.prod.outlook.com (2603:10b6:930:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Sat, 10 Jun
 2023 01:44:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 01:44:45 +0000
Date:   Fri, 9 Jun 2023 18:44:41 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 11/26] cxl/pci: Early setup RCH dport component
 registers from RCRB
Message-ID: <6483d589153b0_e067a2943e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-12-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-12-terry.bowman@amd.com>
X-ClientProxiedBy: BYAPR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: a7808c56-1926-4555-4208-08db6954449b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GbZtQl2FtMOXsv6BESvgPLthCjc4Um7lzgXhJ/gcFtlTqBSdu2Ddj1StqVM1sqIB5yOvU6C/bkljYiDZz+z3cF1nBqXOGdxSdp3ndy3zWt/rvGHu1G7O2OiK/7vDWR1x6698EZ3wNj9YC0wdZi4lpAZbuoHgGQbhwgSTP1oCc0XrfAGo2yVIcuIAUryVgdBQI4Y5cGl1Tto/RivlpF6sXTLVgEs4GL+GEpFIkEsAKdCe492OO4GwZZxj0nGHYH4pSLq3UBKNlDGkFrdWOzOOS0g7VwdcN4KGsOnuTTpusnUmEVvX+6E8AB4BfA7p8jybZLRUay27Fba6n9JatZh+V5QGLLY5mulKtKTDQ28yORRDaGoG3dFwhHQPk+kq6R/lr/8aglPFeQBal9264bB0GG2G7uwabEEN5G8FNyQCu87fcSicNLlaUF4kMrXyXP9zp02mKWBjJfVMqwY+vGykpJV5stN2tUqXbgpMhaJ+ank74fnHoze5pZQV5q4y+aUaJjARJa7HsSz/lmFrQJvcT3D6YB1nD2bHL1KyFuIAaf+Cl6hcSxI2kauxAFp/vb/6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199021)(6666004)(6486002)(86362001)(83380400001)(82960400001)(26005)(6512007)(6506007)(9686003)(38100700002)(186003)(8936002)(41300700001)(5660300002)(316002)(8676002)(2906002)(478600001)(66946007)(66476007)(66556008)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?09eDR0JtePB+l/f5+QqiECe6AYczZvXOTD7dgCH7p6sZqYew1dL2TDCSuWyW?=
 =?us-ascii?Q?9l141oTRNCRRtB5aIoXqpZMwgixxLVkNVdoiVeev/ZUXCPcUgMcHxXmeEa8l?=
 =?us-ascii?Q?Hi6BTV14gf3vFNJI7GZfmZuiCzO6FP2aA9p27dhn2jMeJkvDBVZdx1S9sOzE?=
 =?us-ascii?Q?mNiO6zFIPKtbw/1Vj3ggiF4jE8Wt0xJ4LdxFSuCHUFFUqZyOJopVMSYNxa22?=
 =?us-ascii?Q?muUDU059OL/IHaVy+k2qA8S0CQn31ErqJw5RXNyhRSuOPdX1VoQXrkc12pkX?=
 =?us-ascii?Q?vZN0CbQQ3bFEkF4tvpmBJ4rFhY/iLaGiN3UPV3PZuzHDQs6KQyVk2QYT6ZxD?=
 =?us-ascii?Q?UhqUF1urmbEu23p8N9oPxcmpwYzWKWV+5MTKVzolB0Ri7tTkF0tPXDW4n+tp?=
 =?us-ascii?Q?CpCPqruTBHZsW6rrLsVEQJLlf6cyUavWd2T0FT98oIJQqVJTXA5DFrzDof/H?=
 =?us-ascii?Q?itUS26VKBRhuouGgGSCXfqzlQX99PV1heg9aU6B3UmeH7E+9zlaKfG3iLep8?=
 =?us-ascii?Q?IkAk6OgtofQR8a/AdlKLeSKiwl5xx98ebrhNtMstaItK6ZSkZdN+uHlZewD9?=
 =?us-ascii?Q?Tk0IaaJTtoTc17gBRdK66O3YaeDKqCcUpf4xmUQ7/491SlauEE6IwgJJh8Wp?=
 =?us-ascii?Q?06CQXPp3GebGLvIPWZVLqeIkWjVpCxgKulAjvvQNx8qPZ5HVV1KW78rR7b0y?=
 =?us-ascii?Q?l07EbkZ2WRLW4yoCoO41DdqXgHaOBVBtItGagSdhui+vmhJMcMx1yPBO8lMj?=
 =?us-ascii?Q?gOYqvtgk4D3rqDurFifoJlQRVJ2RxVAT8aUKfwjwQDH/P/1HwD8RiGN5ACX3?=
 =?us-ascii?Q?cXIp4mBkAmQ8Hq1RriXiKfaVRb50apV8XgtTo2i65g+7fIpAyfCm4KDdTGa1?=
 =?us-ascii?Q?Aeb3YUpCIcPZnuctl/zJKue8PVX38KGYc7NTNavhGAscO9CC1CuhLvzSeWgn?=
 =?us-ascii?Q?egrffYaIztkxy5dA7BIuapCQxE5usNRcdl3ClPq2fsbY6orwuZ/4d9xxakMW?=
 =?us-ascii?Q?Xs9YHpG2Tgu2CLhak734o3mZiRsabYqFF1Mv8wAv+QJYSNEz5+oKDZnGBcah?=
 =?us-ascii?Q?CiW11ATuYbaV/6pENRg1mObnJZTij+vqIn2/dRE5WcWN+aBdWnA/bwiOWwdQ?=
 =?us-ascii?Q?5U7g80rmPKykJ2M9HI2lfmyWd56MGirgGf70GBzlJ6CPvPs5NXeuFyhtQ3yh?=
 =?us-ascii?Q?qmFeaNn2F5yU/Wo2kHpCGdqbVHDFZ4CZFDhwq7pcaqxnaSE+NiIB33HZwnYo?=
 =?us-ascii?Q?pjmR5yK15Y524Blx73zTe+4SiYuEZwT9nmzH3QXUOOdxcsiRUo+6mayjyEKc?=
 =?us-ascii?Q?3lEIzYqB4C1ZQ/GiIqEscvdsEM5pdnXaGRXaihdKLHgUgrILwRlStQ4M+jo6?=
 =?us-ascii?Q?cn2ydE0Fe3F2TEVzYzue2nWVK0pv8YNCgdVHUY+I2i9LYtJDiBpvqHR0gD6b?=
 =?us-ascii?Q?y+sOiiwl6ECt0IgBVO8HGMYs+IsPwWpw0wfP3ILM3DdFj8TxS28HPdacWCsR?=
 =?us-ascii?Q?BcVkYryWqT4uXKqS+GFy/zmPsHJbXVrr4l1Yn7nlM5sj0Y15dsrwZi7ppu76?=
 =?us-ascii?Q?3VaXpaU+c1ZyV2m0U4INaa7+IyVhNFG3nAoWrAAKYryLst3Jlas9gYd9jBQ6?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7808c56-1926-4555-4208-08db6954449b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 01:44:45.5024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GsruUwuLs6Cls96eguTjiSIWMUzxYq32sPjhfr+hSdrmkEv9HSVZJ86cWQqGQg0gpdQbT4bcnE/BUJByWM7wiZiALn620K9VpqUmcjaujo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6963
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> CXL RAS capabilities must be enabled and accessible as soon as the CXL
> endpoint is detected in the PCI hierarchy and bound to the cxl_pci
> driver. This needs to be independent of other modules such as cxl_port
> or cxl_mem.
> 
> CXL RAS capabilities reside in the Component Registers. For an RCH
> this is determined by probing RCRB which is implemented very late once
> the CXL Memory Device is created.
> 
> Change this by moving the RCRB probe to the cxl_pci driver. Do this by
> using a new introduced function cxl_pci_find_port() similar to
> cxl_mem_find_port() to determine the involved dport by the endpoint's
> PCI handle. Plug this into the existing cxl_pci_setup_regs() function
> to setup Component Registers. Probe the RCRB in case the Component
> Registers cannot be located through the CXL Register Locator
> capability.
> 
> This unifies code and early sets up the Component Registers at the
> same time for both, VH and RCH mode. Only the cxl_pci driver is
> involved for this. This allows an early mapping of the CXL RAS
> capability registers.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/port.c |  7 +++++++
>  drivers/cxl/cxl.h       |  2 ++
>  drivers/cxl/mem.c       | 10 ----------
>  drivers/cxl/pci.c       | 37 ++++++++++++++++++++++++++++++++++++-
>  4 files changed, 45 insertions(+), 11 deletions(-)
> 
[..]
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 945ca0304d68..2975b232fcd1 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -274,13 +274,48 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  	return 0;
>  }
>  
> +/* Extract RCRB, use same function interface as cxl_find_regblock(). */
> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> +				  enum cxl_regloc_type type,
> +				  struct cxl_register_map *map)
> +{
> +	struct cxl_dport *dport;
> +	resource_size_t component_reg_phys;
> +
> +	memset(map, 0, sizeof(*map));
> +	map->dev = &pdev->dev;
> +	map->resource = CXL_RESOURCE_NONE;
> +
> +	if (type != CXL_REGLOC_RBI_COMPONENT)
> +		return -ENODEV;
> +
> +	if (!cxl_pci_find_port(pdev, &dport) || !dport->rch)
> +		return -ENXIO;
> +
> +	component_reg_phys = cxl_probe_rcrb(&pdev->dev, dport->rcrb.base,
> +					    NULL, CXL_RCRB_UPSTREAM);
> +	if (component_reg_phys == CXL_RESOURCE_NONE)
> +		return -ENXIO;
> +
> +	map->resource = component_reg_phys;
> +	map->reg_type = type;
> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;

One more note, I would prefer a designated initializer for this.
