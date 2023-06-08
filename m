Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE15E728881
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjFHTaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbjFHT3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:29:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A622D51;
        Thu,  8 Jun 2023 12:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686252579; x=1717788579;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TJZQ+UglLZdVsL5mSby2mqnwowZbLKlshat8WRMHj14=;
  b=hVdxF4odI+tZM/Kl2gu2DuabwwNKPV0hhN2RnSDrrikHGWJlR8GdzDJb
   ZBiXkL9mnhvT02B9stBQMrkj8UCuaS8F7z2RguUOVMHMsv05avryyJXM4
   zmVVTpcFF38ne1vewhGBJKAI5Me6qcJeb/QndyfFUKOdvE82K5XTXq4jv
   GiPnybKIH28OuGclcY9Y4MGQvtkF8gnL07DBRlzWcMZfoF+G2DTytoqAt
   +L/JAaGd3e317Cs5FIIY5asBhZmHfjtEdCkST8o4kRNmA1a2r70aOrgwA
   V1WnYBvB0wT9wjwaFZrFnh9cZyH6sLwP7t35fl7XiaQw0ACS05QQ4irj0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="354903241"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="354903241"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 12:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="834320752"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="834320752"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 08 Jun 2023 12:29:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 12:29:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 12:29:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 12:29:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 12:29:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwxIvhhCmKXutKqiDN85AQIUVMioq8VZ7DFa5H4noN6TBOuOlWABMwfDupU+5NxzyUbR/hELdf4yhUyXBkwAR/ngsTO4Tk83QmjQgPVOSJli4E0gHnM3ejQHVN4t2HAfgOj7IlQFXI1vjsWtBwboYsP5r574Hp5XdhcJju2VuZhdk0uBXtDrMRM/EQXTo5ox6r9hwQW/GC41YPsx3ikP/4NrRdxVD/RzW2IWldHkYfulsagn/nvEgO17e+F0Z6yFZ1UhvGKreuUa3cAszsIHeVDheUT2fVSwDD4twaF3YDPHuPsBEmTVQZLO7YQf01GsYmf37JvMD03iz9LlRfGNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWBmIlKPK5soJ9LPchlNxolC3ytHI32sLTQ2Ey8PjE4=;
 b=NhK9KsrqQ3zhWLaZjOmmt83U7+pVFB3k4+gfs0riOjFeIJfWPIGubw9sdVRTIU0IR9HYoVWSJF26dtNhmbWYFwCAMUmsr/Eh41MVch11DwuA0dOc0GVmoDo5ZFRZblYYpIx7HF3nF64VDmhKzf6wZBBig6jXeJ4XaE1WuhacOQx/4stuRbAN7i156FozpokDusmIKw1+k5aAWOqSu1wiY/+7AdQ1aqvPXJPzIR6tbof8OvSF2szP6TKrxat/jGJ+U/vpGCuwz4lKivof16uGzwWDQj2i6t/7temWYp3Rch73FQeVETvs2WvPm7DEju9Zre6Uy5BRZUV4H0rg8RJEVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8210.namprd11.prod.outlook.com (2603:10b6:610:163::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Thu, 8 Jun
 2023 19:29:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 19:29:36 +0000
Date:   Thu, 8 Jun 2023 12:29:32 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 05/26] cxl/core/regs: Add @dev to cxl_register_map
Message-ID: <64822c1c56568_1433ac294db@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-6-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-6-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:334::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bdfb478-c172-4db1-e876-08db6856b195
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6WrJWgBPIm5fisHb+dDltONBvMZxMugWkH02c3Nw6i7GtDadantpqTx1EcVdlZ5xsqiz1e2LAi11sZkuP6w3BRb6efcD1P+3+2rIhEYas0r1v7Fn2+bfRsKIaRdZImADqz9vmqovOQjFj3vbNqF2T/y805ztLBjwc6f/jOMkD9QM5XUkFDk/MbViptqfuFjE5JGbo5zG9OIxexdvW6F8xbR3dXB2Zuxy883Sc4ajYMI1unf0GacBpvKoFzKZbj9mquDhkN+82LHI5JCYuA8uOh2CvWjpObZGBVk5WAemwtxvnctTDF4yNIkeWkYquz9W4Vj4oXttdPhCb/gRBNhecS+5RHYzDPQg/Zs1+Q5uvEW1GNPhtUKuZiH/n2X8iSM6mU/7C47TFu9WGOa6GfSXSrQmUUwcAZG9K+eGr4j3oHTWJ/h+c1yGqy6UAkC1k/QsXvL0/Q5WcAWJulcE2PlcmbIbL++6HX88e/9YzlxpnA7yIKwSWhizGPYZzfpRhomAPbD0/o/+heE4OXbzyPJH43BH4YJllkuw63AKPydX4h1ZqQ+j0d0+WkwG7L23Hv/2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(26005)(38100700002)(41300700001)(6486002)(6512007)(83380400001)(6666004)(9686003)(6506007)(186003)(478600001)(5660300002)(4326008)(66476007)(66946007)(66556008)(82960400001)(316002)(8676002)(2906002)(8936002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9GCgFIoarypGEG6C74qkGpgHL4nMWppKUqKeGnxj+aVpqV4mQlMm5PyrGQ87?=
 =?us-ascii?Q?kumN78qSff7eSU0YdwF9Wo0l9HFcUz/+MnRWNXLvXfYJz2Unta4vFP0kvyUR?=
 =?us-ascii?Q?E0A0dHdtEpQ6Zot81gGanbuJZmDqt/tdvlPFWfYPpTEYZINLqF2YL49abhU3?=
 =?us-ascii?Q?OLaKj5kBpLO+Jz6zlftLQL5A5KLp6+dn/yWfw1chIbqXqKi/Q/5VluqFR/Mk?=
 =?us-ascii?Q?EVEGM3YC3USoBYeGnrIUku3SaWbM4Ff1uskWFGckylh43j9LiUdyl/mvnTCw?=
 =?us-ascii?Q?YU7th86AWRbQXJ/0YyIilq35m1dPRW7xxjGx3u+4UmmYPAce33VI9M5X57Af?=
 =?us-ascii?Q?ltByx27WL8v4lfR0f8619Vmep4t97TvcM/H7ha66OQNh/eAwqgAFEyEoLijs?=
 =?us-ascii?Q?1HCNkE4r1hxSTi1KZ/CFZwKXg/b5hnvLNRAI0WI0Iofl9TUSxYMbiNBMPMZM?=
 =?us-ascii?Q?LIa+AS3ocBYGiWRxOZo+dv5VyAjUcT3b6+o41J+W2c4D6N/XV7kOkOjx8Jb6?=
 =?us-ascii?Q?BqZXa8Qxq5omxmULSFtbYXY6DENZ9nkyuLS5kBM6N7NGVSwBH86Udu0nDL0T?=
 =?us-ascii?Q?Fz7oBQHsLgCjEYxEEe604ETk5TyCQt1p5K40DlOUt2pBOluLShWyu5M0ZKBC?=
 =?us-ascii?Q?BPyvpOrrFy9EG+Z89AxlF0HQ/jtwCOO161DFdNhIo3GGGQhdukUSV8IXGRsp?=
 =?us-ascii?Q?vtvP9OjaHsXc/N9eNmbCj31ss/Ay4mpZtcHx8eaJgQhNkXyjwrSt24Nr1cia?=
 =?us-ascii?Q?beBiLAZ31CasD6oVV9C/+H6jxof+eaQ6yJHMLMnWMzGP625AwVJxuBTTxxQv?=
 =?us-ascii?Q?ONCHmb6KbHIzhV4Ye0NynHtqLhnwO75uYrqky8wrL6lM8g46mafbzYUFd3iN?=
 =?us-ascii?Q?gB66PAXLJmSDpKlOHgcw8X0IUsUZebtefo/Nm13e7/Xwj/0IwO+oiJB57510?=
 =?us-ascii?Q?FZo58xkfXQSheU1WEyYUqEyKSYnd9WGP74DgAXDvPhtg9EhtFFf+9ZhY3QTT?=
 =?us-ascii?Q?/TSwOz4Ayot+K26di8h8YmCtZDN2mjdR9z9OzXcqnQP03gKJWfRymOAJJ02E?=
 =?us-ascii?Q?VDxwjiihfO5mkoEv2JP5t8W+9CD0x5yxOq4ocmNMIkuWxdP1UfRnLLdyq+hE?=
 =?us-ascii?Q?77WfHZ7a/1jtFJd4LzFXGuTRgioDXRe5Xff83AmRBULDaOcXMhLqzp9EHESn?=
 =?us-ascii?Q?kra40+L1EMt1C0k1nklBrznUdWecpw4GsAhM2anfdmikj3I3jzTjT0vuixXG?=
 =?us-ascii?Q?7MB+q9oQ+K6yuMB7Kyn41dWY+vp1Wrke6+ldvft1D9m/f3+Nu/fLAhxXtDQR?=
 =?us-ascii?Q?E523NbfM0q+RvSkYKOdBQF4ulE8l+pvwX1r9hkg5cfHowYaURtXrnXxo1qr7?=
 =?us-ascii?Q?rYdtUXlDCw4NJH/ebJRtX6I08T79GfFnVHvVdkRpIUxWAJ90N/jveUn7XafR?=
 =?us-ascii?Q?eTiPAqnlHMGsu3gSxfkR9kfGSEgQGElrlvSEowS+KY6/PlYmOP3mLe72ndmJ?=
 =?us-ascii?Q?xwIvlQKeT4VR3TYzfmwdiZsaws+U1Gb0Zciszo1X2XUuoIaU3ICSd7jgVhI7?=
 =?us-ascii?Q?kK0Cy9rzD2mGEMovcm6/sGloTIB5Lb6s/1Qp2Vhj2FVwUjdTycnWEYtuqRvw?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdfb478-c172-4db1-e876-08db6856b195
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 19:29:36.1749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: allGK4ITnI5Yg1xBVJJ9N29wUGfwz9DIQXI+GthA2+2v1AgSBTDBLHVig/42UL19SKBFg8jxBFEOrPQomumm/Es/mcxLYvaznImsfX556Cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8210
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
> From: Robert Richter <rrichter@amd.com>
> 
> The corresponding device of a register mapping is used for devm
> operations and logging. For operations with struct cxl_register_map
> the device needs to be kept track separately. To simpify the involved
> function interfaces, add @dev to cxl_register_map.
> 
> While at it also reorder function arguments of cxl_map_device_regs()
> and cxl_map_component_regs() to have the object @cxl_register_map
> first.
> 
> In a result a bunch of functions are available to be used with a
> @cxl_register_map object.
> 
> This patch is in preparation of reworking the component register setup
> code.

Looks good to me some small formatting requests below:

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/hdm.c  |  4 ++--
>  drivers/cxl/core/regs.c | 16 +++++++++++-----
>  drivers/cxl/cxl.h       | 10 ++++++----
>  drivers/cxl/pci.c       | 24 ++++++++++++------------
>  4 files changed, 31 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7889ff203a34..5abfa9276dac 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -85,6 +85,7 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
>  				struct cxl_component_regs *regs)
>  {
>  	struct cxl_register_map map = {
> +		.dev = &port->dev,
>  		.resource = port->component_reg_phys,
>  		.base = crb,
>  		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> @@ -97,8 +98,7 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
>  		return -ENODEV;
>  	}
>  
> -	return cxl_map_component_regs(&port->dev, regs, &map,
> -				      BIT(CXL_CM_CAP_CAP_ID_HDM));
> +	return cxl_map_component_regs(&map, regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
>  }
>  
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index c2e6ec6e716d..3b4e56fb36a8 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -199,9 +199,11 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  	return ret_val;
>  }
>  
> -int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
> -			   struct cxl_register_map *map, unsigned long map_mask)
> +int cxl_map_component_regs(struct cxl_register_map *map,
> +			   struct cxl_component_regs *regs,
> +			   unsigned long map_mask)
>  {
> +	struct device *dev = map->dev;
>  	struct mapinfo {
>  		struct cxl_reg_map *rmap;
>  		void __iomem **addr;
> @@ -231,10 +233,10 @@ int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, CXL);
>  
> -int cxl_map_device_regs(struct device *dev,
> -			struct cxl_device_regs *regs,
> -			struct cxl_register_map *map)
> +int cxl_map_device_regs(struct cxl_register_map *map,
> +			struct cxl_device_regs *regs)
>  {
> +	struct device *dev = map->dev;
>  	resource_size_t phys_addr = map->resource;
>  	struct mapinfo {
>  		struct cxl_reg_map *rmap;
> @@ -302,7 +304,10 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	u32 regloc_size, regblocks;
>  	int regloc, i;
>  
> +	memset(map, 0, sizeof(*map));
> +	map->dev = &pdev->dev;
>  	map->resource = CXL_RESOURCE_NONE;

Use a designated initializer here like other locations:

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 9230b419988e..bd955fae65cd 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -304,9 +304,10 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
        u32 regloc_size, regblocks;
        int regloc, i;
 
-       memset(map, 0, sizeof(*map));
-       map->dev = &pdev->dev;
-       map->resource = CXL_RESOURCE_NONE;
+       *map = (struct cxl_register_map) {
+               .dev = &pdev->dev,
+               .resource = CXL_RESOURCE_NONE,
+       };
 
        regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
                                           CXL_DVSEC_REG_LOCATOR);

> +

Remove this unrelated whitespace change.

>  	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
>  					   CXL_DVSEC_REG_LOCATOR);
>  	if (!regloc)
> @@ -328,6 +333,7 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	}
>  
>  	map->resource = CXL_RESOURCE_NONE;
> +

...and this one too, before Jonathan notices.

>  	return -ENODEV;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a8bda2c74a85..095b767c21e9 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -231,6 +231,7 @@ struct cxl_device_reg_map {
>  
>  /**
>   * struct cxl_register_map - DVSEC harvested register block mapping parameters
> + * @dev: device for devm operations and logging
>   * @base: virtual base of the register-block-BAR + @block_offset
>   * @resource: physical resource base of the register block
>   * @max_size: maximum mapping size to perform register search
> @@ -239,6 +240,7 @@ struct cxl_device_reg_map {
>   * @device_map: cxl_reg_maps for device registers
>   */
>  struct cxl_register_map {
> +	struct device *dev;
>  	void __iomem *base;
>  	resource_size_t resource;
>  	resource_size_t max_size;
> @@ -253,11 +255,11 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			      struct cxl_component_reg_map *map);
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  			   struct cxl_device_reg_map *map);
> -int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
> -			   struct cxl_register_map *map,
> +int cxl_map_component_regs(struct cxl_register_map *map,
> +			   struct cxl_component_regs *regs,
>  			   unsigned long map_mask);
> -int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
> -			struct cxl_register_map *map);
> +int cxl_map_device_regs(struct cxl_register_map *map,
> +			struct cxl_device_regs *regs);
>  
>  enum cxl_regloc_type;
>  int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0872f2233ed0..9c1b44f42e49 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -274,9 +274,9 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  	return 0;
>  }
>  
> -static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
> +static int cxl_map_regblock(struct cxl_register_map *map)
>  {
> -	struct device *dev = &pdev->dev;
> +	struct device *dev = map->dev;
>  
>  	map->base = ioremap(map->resource, map->max_size);
>  	if (!map->base) {
> @@ -285,21 +285,21 @@ static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
>  	}
>  
>  	dev_dbg(dev, "Mapped CXL Memory Device resource %pa\n", &map->resource);
> +

Ditto.

>  	return 0;
>  }
>  
> -static void cxl_unmap_regblock(struct pci_dev *pdev,
> -			       struct cxl_register_map *map)
> +static void cxl_unmap_regblock(struct cxl_register_map *map)
>  {
>  	iounmap(map->base);
>  	map->base = NULL;
>  }
>  
> -static int cxl_probe_regs(struct pci_dev *pdev, struct cxl_register_map *map)
> +static int cxl_probe_regs(struct cxl_register_map *map)
>  {
>  	struct cxl_component_reg_map *comp_map;
>  	struct cxl_device_reg_map *dev_map;
> -	struct device *dev = &pdev->dev;
> +	struct device *dev = map->dev;
>  	void __iomem *base = map->base;
>  
>  	switch (map->reg_type) {
> @@ -346,12 +346,12 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_map_regblock(pdev, map);
> +	rc = cxl_map_regblock(map);
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_probe_regs(pdev, map);
> -	cxl_unmap_regblock(pdev, map);
> +	rc = cxl_probe_regs(map);
> +	cxl_unmap_regblock(map);
>  
>  	return rc;
>  }
> @@ -688,7 +688,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_map_device_regs(&pdev->dev, &cxlds->regs.device_regs, &map);
> +	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
>  	if (rc)
>  		return rc;
>  
> @@ -703,8 +703,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	cxlds->component_reg_phys = map.resource;
>  
> -	rc = cxl_map_component_regs(&pdev->dev, &cxlds->regs.component,
> -				    &map, BIT(CXL_CM_CAP_CAP_ID_RAS));
> +	rc = cxl_map_component_regs(&map, &cxlds->regs.component,
> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
>  	if (rc)
>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>  
> -- 
> 2.34.1
> 



