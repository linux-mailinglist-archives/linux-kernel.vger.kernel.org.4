Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B86672D074
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbjFLU3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFLU3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:29:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EB4E41;
        Mon, 12 Jun 2023 13:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686601759; x=1718137759;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i/KAepM1Cr5x0yvhK37x1Ok0Sf3VbNZfTRUmAhqIo0E=;
  b=bTveiLpMwRA6hhXFzAeekfk1mRq/NKivTDNCQm7yG7qLU3o1dRHOzVHv
   q9/Nlkve7I0N9nItN3jkDAUdKEN91AmMsbYd7g4EJhLU6CxYaIvgVqtDL
   ISfWtEdEWolY4aRp/TXjYFZACykkA2uPQiBkbjEU6NOAtvyFLCQXeyfSR
   rFO5VxZ6hXuQAovqbnsqLXcVXz2ZBsGb3IsRRlDMt7xM4SDEWmwAPYdPZ
   tgzvxlMk2B7Ui0odcdi6/rof+aZoSdzUG/QJq0fhsr4qKai3+FWfSEHWj
   dQI7AvMeimcX/UKE8LmD62cVYZryw8AVYQF1FbA6N0i04eNAdjHevTnve
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358152191"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="358152191"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 13:29:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="705528071"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="705528071"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 12 Jun 2023 13:29:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 13:29:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 13:29:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 13:29:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 13:29:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRnmKxHLxVfpGpJ0kC1Wd2xY7Nt/2ackcNMJou3ceQbF2X93egw693lt8xOScYHQkYScNI1TQXYdoOABM5kupuY9ov5wjdappdOR6RhNhuMyI2h6F1uVV7Fo+c3t8D54/2wf93ZgMabzlC7WpLZwALvZJdT/J6x7PbyggSPxcEc4/Lv2Hd6n43suBBH2RL51Q2iY/qPbyBkyzhTtFTo1Vc0S0UB9uhdRKW/2BjcBrHRkbu7zV9ipIZrU2SKvE9ttHFvNZJqAK4KVqAiHhH2zXqEAkUXCL+3XEROmSHL07+yvjwGPi6lYm28cWcu0femhNBWaBylPwLzznqS/mT2cew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61ge2IoDFBHUIiRRHBzzQ8KlLTv1fnbZCDgFv9viM/M=;
 b=nRvSEqEpz0CwerVMXfdvXlYQ8JTweAtELQniUqiiGA6X9TQVtt11gdxDhda9miSdkeoXmsF1E6MjbVkndcshffq8YqagoMHyADqjRCrWQKRsAe+GNk+UVwVLpvcviKy02hGArZHKVm75hVIWmSc1jQRrlAxqWC1+pPtFrS6J4mJKKHrPjQ4uFryTdCCPc8/oJbo5xWtwa9OJpVIgqBN5Uq+m3rJwIFwdzgLB257rQnt/lSvUEmn6bXt/JKMbGuwthgiYk1Q5DMRSzFzx6srZVoczANlgYbKFob4ff6P+RytIM2HrpyVfdl67uw+5hHEmyZe8wIbBu2pySdsCzHdrJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 20:29:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 20:29:14 +0000
Date:   Mon, 12 Jun 2023 13:29:10 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 23/26] cxl/pci: Disable root port interrupts in RCH
 mode
Message-ID: <64878016974b0_1433ac29473@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-24-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-24-terry.bowman@amd.com>
X-ClientProxiedBy: MW4P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5271:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e5911a-d49c-44a4-a390-08db6b83afc0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rp+5BkFLjGNKsCfgi/FIqX8GgnugLDYrB7HsLoIa4jngER3th+YYdT6s7wcVUhea8qx6PwTZb4ZbjXIkQ+ebJTfiUg5ww0T6zUHKBmrxezWM0Tke6FV1IdnlSoGwOZU4qQYr5IGcMclkp8hflPbizvPC8u75IO0tregE4WD7nJSLh7xXzu6nWoLdCoC2Zi4JME+XVKKdrXgBtpihCxeNL8PDeMCVoGhAcmLM+8uEWYVAyBD98jF8+ep75vSezULkBsVPJnr7xkpKfebZjrIm2iSjbaxS4FxVxsUkzOY2w7bA8XgHSyL05EQXpGE9nTGGGcVoVX2Qf63of0HLtkKhImX7aeyklDgxME3HLIxPl17WNcR21BTXv8KtW/HDDogvqT/DL/+GPh08WVgyZVlSRFQUeEygL22vIxX3UJFXRFkHk7E8Z7F2Iz7upzJ4qNhmTjBsCiq90Etm0e74Kchy7+xnA0UYq0IIpuoHW/rifCO1H3nLOkl1Eix36YIWEHen+ZLTwHTv4erSxbuKwOv+bCblO9z+eN3BGCt9sgFUcfUrOoB8+m6W4eRls0E5nGqj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199021)(83380400001)(82960400001)(86362001)(38100700002)(478600001)(4326008)(6486002)(6666004)(8936002)(2906002)(8676002)(5660300002)(66946007)(66476007)(66556008)(41300700001)(316002)(186003)(6512007)(6506007)(9686003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s56q4pHKZOUMl4aG3hbkHfVr8r2y+5q8o9QG7iPAJ0W5DTbodRmjlogoZgxm?=
 =?us-ascii?Q?Jcab6HG+f6nuPkhDapR4jNKySL0pQOUzBMwRSCc1e3Lan0iRlQGNNdwQ9gl3?=
 =?us-ascii?Q?pJWMp5mo7jP9mZLX0IzBEtotY69jyQHxt97fxix/54d+Qo3VcoxReVJTWUmh?=
 =?us-ascii?Q?efWeL3UPyyAiu6NpJpnPQH1MZE4yFjNMg2Nh1Bnqf+HpkQiGgLNzhQFWQg0d?=
 =?us-ascii?Q?lLGBYdeO+E1gnY14t39YyHvIMf535CjZgiyMFt6VUqxEmfjrnY8wB0x7lIfT?=
 =?us-ascii?Q?7ulZDvaadSP7JcIThk29IiEzR6GIrymoa4tVftAqc5T/NYcUEM6cIeC90UoP?=
 =?us-ascii?Q?VgXn9IdYc5NM0RmAzRRKqOrhg9Gz5pqOQOcq0ZtTrq3w2uUhOjm6JrefrjG+?=
 =?us-ascii?Q?xYEmCMHyLQXseYcWOLVT8RQVyg0b6brftJdOdaSQRNMZgZec6tTC8Fue0iF2?=
 =?us-ascii?Q?gJ1J1sfnWmhjsPAw4vRNQvWlz7XCouipoKPtY3JaZw+XE2emv62CRkL4bShr?=
 =?us-ascii?Q?93ssha+qjIXJkkdXQuBUhxYRMcB+jiqUrMEuZHMGJbqgJauuxgObBbUP+dmU?=
 =?us-ascii?Q?Pq7Dz0HqspXV2LCPEUQX8h3/V7AnFyrVzb5gZgfwdjTmRMVSApn+BoQ48+yQ?=
 =?us-ascii?Q?3rXP5BdkTaSVP439gF85c+r1ugoCXiJRyqTcKkbReDvT6NKTM9eAbd0esOh+?=
 =?us-ascii?Q?CYxbWva1sVZj5nbAHaLsM27bWDGs18Ql/2rUDgDyIraAos9pwOXh7CWxKd0/?=
 =?us-ascii?Q?DohEcI1nFS9obpFjLQqZJ3O5+14zediFb4k4uX2UBVSsNuRcrB9/tYQiEFzS?=
 =?us-ascii?Q?CWn6RSBCc8msU2b+dqic96zMTvzkycptauzMf7qIqaUV8kqnUiQx+BHAXHU8?=
 =?us-ascii?Q?6PWz5YvntmGM7EkNTUzNDOMHb5HOpDylk1Rq1XzKMXLsQHarHzFJ2C2k6Yot?=
 =?us-ascii?Q?PRacG1hJ4uNhTVC9xDEEKWdunP7c+KBHhevyM419kMjxLHFe83Ss3J6f1e35?=
 =?us-ascii?Q?e9PinljJU2SbiTFx2abFTAcAD4BulS5A7XkLrM77hHdha9V6Pep5ym6DRHN3?=
 =?us-ascii?Q?ZejQgVD0uteEuxJyvZRn+AmSopwJLMhBLWH3vMydIW7d0PW8lyjoQEoI2uDK?=
 =?us-ascii?Q?jhrzzePnM+o+TN8EPMIinMsg3K19kNaf6EWHMRvLCEJZ25Thj1HUUy8DcWaN?=
 =?us-ascii?Q?YwlOogACziwV0+ASAw57M1x7hC99XjmIEo+Y62SDxlo2zHzhVP65sp1UF/4U?=
 =?us-ascii?Q?7kyZZaVYhcR02FEDC/2LZMCjmp0wadV7+RVEcac2BYROoX4UpRAmHJ+YZgI6?=
 =?us-ascii?Q?xQorvgQoVFEEdjVdtRX+KYvLIWzgUfwbw26gP4eYgMwpmDJQOjotPnt41WgG?=
 =?us-ascii?Q?lDvyUguKD2f1NRhWiBPIHqxJa92i/ANQ2dTH8nJRw/MtunJzdb4kR0afrAb9?=
 =?us-ascii?Q?TjBNj5PeGAfgu5BfgrR2vWkonLFHGGf13Ftbfuc+rqkMIVk6iubOSQWRZ6y3?=
 =?us-ascii?Q?o3XJBTGCjE8SSJCTCwnn4jaqzr7TYj9aVaTalwEzQE3XOBzBXDcFN+mTJmIp?=
 =?us-ascii?Q?GSuTIiXa5WUl/p7ICvymOLSqXoNA4/ip1ePooc+kwJEK6AOjC7LyGJjjXq6D?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e5911a-d49c-44a4-a390-08db6b83afc0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:29:13.8296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+qxSoIMly1smb/bHwjzW64JLf0qDmOYH2IbSMlFHQzMaYdRXTGstGUdkSlpp7BO/Ogv/dRn8gbkzv1e8vcR4NsYnnSLRMZ7e3ZfjwO3HBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5271
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
> The RCH root port contains root command AER registers that should not be
> enabled.[1] Disable these to prevent root port interrupts.
> 
> [1] CXL 3.0 - 12.2.1.1 RCH Downstream Port-detected Errors
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/port.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index bc5d0ee9da54..828ae69086c4 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -981,6 +981,30 @@ static int cxl_dport_map_regs(struct cxl_dport *dport)
>  	return cxl_dport_map_rch_aer(dport);
>  }
>  
> +static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
> +{
> +	void __iomem *aer_base = dport->regs.dport_aer;
> +	u32 aer_cmd_mask, aer_cmd;
> +
> +	if (!dport->rch || !aer_base)
> +		return;

Does this need to check ->rch? There is no path that sets
->regs.dport_aer in the VH case, right?

> +
> +	/*
> +	 * Disable RCH root port command interrupts.
> +	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
> +	 *
> +	 * This sequnce may not be necessary. CXL spec states disabling
> +	 * the root cmd register's interrupts is required. But, PCI spec
> +	 * shows these are disabled by default on reset.
> +	 */
> +	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
> +			PCI_ERR_ROOT_CMD_NONFATAL_EN |
> +			PCI_ERR_ROOT_CMD_FATAL_EN);
> +	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
> +	aer_cmd &= ~aer_cmd_mask;
> +	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);

What about the scenario where @host_bridge->native_cxl_error is false?
Should the driver unconditionally touch AER registers?

> +}
> +
>  static struct cxl_dport *
>  __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  		     int port_id, resource_size_t component_reg_phys,
> @@ -1038,6 +1062,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	if (rc && rc != -ENODEV)
>  		return ERR_PTR(rc);
>  
> +	cxl_disable_rch_root_ints(dport);
> +

It feels odd to modify hardware state within an object setup helper. Is
there a reason this needs to be settled before __devm_cxl_add_dport()
returns? If not this feels like a helper that cxl_acpi should call to
change the state of the @dport instance it allocated.
