Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CD0736D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjFTNnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjFTNnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:43:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9DFFC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687268622; x=1718804622;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wJFT45mXHu2VYSBTid4Fx2G7pBq4rpZdnv2B9GIjYAw=;
  b=oAseMAdAW8x4RmlF/NH2y831zUbzY5drQl57ZJtoz72M5iUkdxyzDDnx
   p2FBT/ALmKB9UO78Ly6lweqlWBaDRKg+F2d3LpMNsW28+X1z6z+f9AAY7
   j+8geXd2JYVg+UiY0z01otNRuWsHMklS7RdJVL+Cxwm64jHhJcIPxsPCS
   20uYzL0XFfJMPo5BiT9xgEeG52M0E9T6F/RSCwE/VEnEo2i4weIN7sC86
   MX9wndeKEhYV5PzhEelzGe3fO2WrFs1GCYIKgCFuM9GfPaSgEdxl7UMJ+
   +ZPRbzwCoMfoexRY/ItAMx/nhxK/v/CWTjYsM7q6YKb40Vio5Dj8fw6WP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446235004"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="446235004"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 06:43:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="743788080"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="743788080"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 20 Jun 2023 06:43:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 06:43:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 06:43:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 06:43:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 06:43:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rw4PwNL60/fljLpEXNz1Po+O5raul9IsvbQR3BLvK7+CztHSI5CLXVGSKwuwthg1Wmd+RVazbUqwhLvUAQL3DqLpMfauktvij6fFmB3jHCKZAUG6WLsVY0cTaoqhm4KAjzydNT61F6xFitANuZ4MQSYy7Gt/cwDCq2bltBLvPZeKe2dc8IAs53czNZGsEQZAwV+4Yq1YUfMWcTnDO8UfiGDTb7xYN8J1MX+C+jJT0zu1qDyPf6lXDimoLdkk8UXcK6Tp9yMM3zDx6qZIQE5ggzo7FCcxNddksWWcQUFGEFTvT3A4V1BU/oOldhyHkfEZ9WP1vNLpPPb+r2DmHYGoLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suEmMTw4eS6QBQuN60SUo9m6DdYo6YkiUJInAX+Ys5M=;
 b=hRA+7DWyjVeavpfOk+Bc7i3LzEgh3Br2GuCqkmuOEG+91aOHt07y08sYx5d0RnKLjOgOjq/L4NjMBZ29Ww0AodC0FM7ioDyRNbBncCMRek6ip4ka1a8+skj/OKEFKsWGCpdmvIqbNrl8YdL7n2osrPNQQb25+08xIxZoRBDQFRftsK6TZKtV16VLavwye6fIfPcxC7ZxcVNXTWgdRxeFvBiIR+LLDGm84x96zAjEePdJkDHAqDVxCkrKyEmUHG63PFR0gHSwz2SNo9SVrZ5ssGn3sMobrSx8eVFj0NyESyb6TjvELVEXgcVroodcrNdIyeeq5v53MqnIrO1akzQsyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN9PR11MB5452.namprd11.prod.outlook.com (2603:10b6:408:101::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 13:43:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 13:43:38 +0000
Date:   Tue, 20 Jun 2023 06:43:31 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <oohall@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] libnvdimm/of_pmem: Add check and kfree for kstrdup
Message-ID: <6491ad03658ff_28e7294a5@iweiny-mobl.notmuch>
References: <20230619033623.11044-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230619033623.11044-1-jiasheng@iscas.ac.cn>
X-ClientProxiedBy: BY5PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BN9PR11MB5452:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f25aee-440c-47ff-20dc-08db719459d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUtP9SOHT2iFXkQ9COQuPwMNPXUPasHBfJ/uG+hlptWIrIbaWzPt9DDVNSUdefSHZuQpnS0tZkBjtkYua4QtjQgo9Hi9hdaaPjKWkUacjUr6RfEPlu0uwL+p3mHREiMDe2o7aSZx0IhYcmnJRUoYsQRma1AIgP6yeD/aV9yaTIwJjOJktoBMmh3w/FW2Xy8BbXKA7rvXQEcdx4IwBNMv3UrSk0TQ4skNwSFUFn/ADngaKPw38RD1kRwyNn+w7ysgsv4xWPedd8KGdqj3crVMwuUxqxkgyWHL7+Aw36V/fL3519c7S+zWutXdDGaZkJQsjTFns77t6F0X96wgyOOnN1pS9nwwgQ2BS3J4akalRt+OMl8Yh6/5Noemnslm8DaMH1foNQfJAVZ8buWgc11pUaclUh66xA05ZyR50u3ERNq3pjRpFsfUzAHDbXldZ66RWuCYDDR4cfttRypzKOb9X/3agtCH2FxblGbxpgiFQEX/ki7PyNxAYegFaYtN8PlR0ZDIPuwKldoymUVdRJ2AgEPXFsam+OzHc9C4cY+biG/YinYTSzv2x30IisUIvUQK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199021)(6666004)(6486002)(478600001)(83380400001)(186003)(9686003)(6512007)(6506007)(26005)(38100700002)(86362001)(82960400001)(8676002)(5660300002)(8936002)(316002)(2906002)(41300700001)(4326008)(66476007)(66556008)(66946007)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sDkd815OyUBThUPoHwn771XYtbfeufAV75MebyeA8Bg4jbQd0TinDKpt2Lk/?=
 =?us-ascii?Q?8PqxvUxWnNpF1a3/WKWXv8sfT+UJBhTTGsYTXrERdhshjDuGehr2vv6p2DnX?=
 =?us-ascii?Q?gs9t+u0+jEu2XuiIXU2EC1ETWt+S7At3d+0W5s5e+F7h6XcRWFCMRRj1V45A?=
 =?us-ascii?Q?70hUJ9pbkW/RK6+9TaddNHM2nFiKnPIm2IqY4lz9WASkYBMLvfE115CnxIL3?=
 =?us-ascii?Q?ncLlXc5Y6Vn7cDP2OmarxPfwgHeEwz1G7Nav19Sbr+rPTqu4cw3nMEhyeZ6A?=
 =?us-ascii?Q?t5CKASaabIYfvs/znJ2AdHe16c64B//kYv4p0Hu6xlkg+cTaoCAV+IK37BIK?=
 =?us-ascii?Q?OrIwTi5W5Kw5YMe0do+SRgHfkJ1DYdNIIcGvlYYPpln9fqlFQvlvDQ4d5sFg?=
 =?us-ascii?Q?8xa8B7vMEAw+JC5wxYaRcTF5yJUd4540/SQg12y+ZHoIHlQBBwzQmoLzWgSs?=
 =?us-ascii?Q?2otYjLtZckMCSzNaRSVsIeBg07RbWiAJewIKh17Oz7yMhEfOcXvbvf1QToaq?=
 =?us-ascii?Q?u2eT/n/PrTpOSx9WfDdlWpSEGdy37rrv0u6SFTsa7jIcLJaco8aQg/QhS4sV?=
 =?us-ascii?Q?A9K11f1MTnXZeRG/rNbDALyL5EM/2i+705Oqed5FLkA6S9FBbFEOHq8s26ls?=
 =?us-ascii?Q?UWFOQ9w0FRl9gr7jaLuduVhPtJnmiHrr5KB+Xr8EbWJqyXHscqrcW0ArG3v8?=
 =?us-ascii?Q?AzJ1zI98XjzrNXHncXPqo26HLvTeEWwc16q5DQHRg1ALFw4Erzb/TFo5LA6s?=
 =?us-ascii?Q?KszyYJkAIhXEm/1dPgfBKEXy7Ri6D/RScU5t9O24nsLykxAmWj+B/t23tR41?=
 =?us-ascii?Q?At3/FZRuLanAfiGxs7oJ/OxMqkmUiYe7Ue7JF+ODFO2NjacG8t72NxbbnEd8?=
 =?us-ascii?Q?Te0O+nC75NgRvN/9ZgGgUndN0UOjutzJ9/XTpTm3P2YEGd+3Oa5/DOhXgji4?=
 =?us-ascii?Q?yrjvGhWr8bykCWXAXOkP3P0KiGjcs0k/bs2kYVwUgsH9EQ4QgpuY+4LnrkUu?=
 =?us-ascii?Q?smWhlHyke5ZVuYrzRnUgzIMOkJO8cf8ZPzisD46hm4Hmkf3CmIff1IKSfQ94?=
 =?us-ascii?Q?FudVjA1GW3wrDgPTrwFZF9S9gJi1rV7n2z/bHiHMAYMo0PYd82N9mrxHndAb?=
 =?us-ascii?Q?ht1YV+PW1zpisqZt15cV4MjB8T5aBRD3+xMY3W4M/d3Q6ewS7++JzLp6GQH+?=
 =?us-ascii?Q?zFiZRTTf9RHrunsIAOb6iRLBMnCuWxwfTM0p2PU/eN4Vv5oDjKIB8ht1aDI+?=
 =?us-ascii?Q?Y+b+XOXWd1rijDorUJie80o5pb8uyaEZcbvNeqwl4WlNCEeHofr8wmMx0G3j?=
 =?us-ascii?Q?xLTb4aOjVg2lRcN54C0pt+/XP3sXwFWA48PSThikZ0cwtCtoPKhQYi68DWZ+?=
 =?us-ascii?Q?ix304T1bQSW42BRKD/9IGHG5DHRqzlucFyOiNf4YcARbSp6GCFwXU50omn0j?=
 =?us-ascii?Q?JkwkgXBG9A8itJBsfvJ880lI/4j6bmQcXOqry1VAudjYou9X/IbjWpbI5DEf?=
 =?us-ascii?Q?CLuLqeb8QUYy/+g6+qSWVZwjAAzMh0DOOuHgsWaQKnR951StxSwGyMA1tV87?=
 =?us-ascii?Q?e6/Cm/Su4dncbBR13h1Iqn9H3lEG6Y2b0kF9QMK5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f25aee-440c-47ff-20dc-08db719459d9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 13:43:38.3250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9P0vehPMRW0y2eT+TzuN9/IvKqzgVqGh+EzG+RDQFjbo9Lm4aX2VrUhf3acOFyapnHotAzu/c3JZRsAzvt5f1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5452
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

Jiasheng Jiang wrote:
> Add check for the return value of kstrdup() and return the error
> if it fails in order to avoid NULL pointer dereference.
> Moreover, use kfree() in the later error handling in order to avoid
> memory leak.
> 
> Fixes: 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique name for bus provider")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/nvdimm/of_pmem.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 10dbdcdfb9ce..fe6edb7e6631 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -31,11 +31,17 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);
> +	if (!priv->bus_desc.provider_name) {
> +		kfree(priv);
> +		return -ENOMEM;
> +	}
> +
>  	priv->bus_desc.module = THIS_MODULE;
>  	priv->bus_desc.of_node = np;
>  
>  	priv->bus = bus = nvdimm_bus_register(&pdev->dev, &priv->bus_desc);
>  	if (!bus) {
> +		kfree(priv->bus_desc.provider_name);

Nice catch!

However, this free needs to happen in of_pmem_region_remove() as well.

Ira

>  		kfree(priv);
>  		return -ENODEV;
>  	}
> -- 
> 2.25.1
> 


