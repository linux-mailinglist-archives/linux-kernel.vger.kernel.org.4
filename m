Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C417D73AD16
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjFVXT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjFVXTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:19:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA86526B2;
        Thu, 22 Jun 2023 16:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687475932; x=1719011932;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8s5Ztn7oCSL9BKR4sb048CB1vGd0v2yR7xyj3fHtc5k=;
  b=Hss92RMW8ICrlkDfawS5f1hzGBE5huYIQiw66tg5X/glwSKXnSfYAYbS
   Ei+ONTAJqPNSr+5N8baZcLWmzGHHVlZrmqo+mShr0nqTbr29f7HRwm/pe
   ayw8UUt1y9YWxe4FUkYoB2m32pusoMwngg1fCexHC/Im4IW+FH27E29nz
   4qQMjQ0utaz+IzHV6V/BFH0Vm8cgX2KXikXKRN8BhTwn/VWIUM9NDoa1z
   DHYJqjNweQ67BTXEkgKOZB2dzKLotIQ+j+3Q2PWYTKzQQ4byxJOA9Sbd5
   +1cE3AtuJXFCPMrPKT5VObG3tSsDuyZp4IE7sn1iTl0CsARhx/a1zI3Hn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="424325557"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="424325557"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 16:18:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="804995084"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="804995084"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2023 16:18:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 16:18:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 16:18:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 16:18:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 16:18:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHPqVPaLYDGTAHAaQMV70SGl8yTEtKVVy8LRBqVkzDkSaQcJf1xLjxAc2nTZJ+ZxxFR4RuznGFMG4oENmMgqjIz+zX6HdlZnsAnF2IDo8tSDnEHPaoha8NND3lKHMrBFY+JsoM0zJ2immNVyGBxfpekrjD3xpqvY8PcEAfxjs8NuBbqIq9qGLjI9XYlEHM1VrkR37t+hCUCq1J3j7V6/oXkObiuy+7FfSIYBbCHgwuO9heSSW1tUIWMgBSL7o+EsHABs6DgU1agnvNEv16V0MYqZS5RwIAp34dNsd4D6ZfFOsM6YBYe679G63s+eAsYHXcvzcW1xt75lp6IXeO6XoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64gnW+1cMolOd1+O4nCP8ufDXNaGeEsfmAHzdE7jA68=;
 b=J7SS2IFi02cSJNMT+DTA90uDxNhN3bX68F7L1OF2T5V1x3M0hoRZx2TvTPpS3o/im5K1q39F0JVtIYN/5N1JaYLKOlPvxGpQwLyt80l+IFMeHtt1pEp3N+RFjQqaSaAQD8n2LRpEmVHeORw/2/EtRPQQ/VxxfzQKH5Pg2gsu7M0Zr4dNlnnuitAz7oCVhox+oSeIAuZdiCNuAL5EEC01VrvTz/vGGUKIPgtA9z13uZVtzEAqobwJAA+indQgb3N8sgO86eCd+7PiT/TVfSLtELp8voPduADpdJ7qLDq2K/hj0HRWRTdawZcgsN6ZQwOlezxpsk6GCkDizmcJMD05Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH7PR11MB8057.namprd11.prod.outlook.com (2603:10b6:510:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Thu, 22 Jun
 2023 23:17:59 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 23:17:59 +0000
Message-ID: <ac1d0543-9bab-a05d-30cf-2bbbb579162f@intel.com>
Date:   Thu, 22 Jun 2023 16:17:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v6 09/27] cxl/acpi: Move add_host_bridge_uport() after
 cxl_get_chbs()
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-10-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622035126.4130151-10-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::13) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH7PR11MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: c93f3d65-0098-4509-51d6-08db7376eb13
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IkBVv9f1DZ+vqwa24+CIW5ZYwAU/6/Zm1FDG0HR8b2+iWNNxXznwgAsU1ttsLyK0LZluc+WLpyukEyAmkQ5XGg36aZuCSFZTcP/Jk47rErTnu7/xDNDnDRV42QkOD9M7nHckXqyz69yjp8fBDu4HVezEEzfN8GbnHn3Wfm/mSTjjzn+zHSpOyEtu//HNTayJwyvmqsLttLCz/5Lr1ihgGXG5nFa6XVCl24TvPrs/LeByCBN+Lvm6iqVzeeFkA42ZVJyNXWQ2Rh9d9juY6T45mCulqLIpeNtMcVwSugwFGHr4C5uIXfXnqxK9SKFfblPzT17JCeNsIjA+z3XD9kT2UnpIdfDCQnaFsQdNeGDkUkLXRjbxrpVzBG062TJ/Gp/cuR0zGbXG/pyZbfo2o8pHiBO+6XYMhTzWEg9mrJEGdqDo71fEVPVtLql6OX9ts0zALqRHuC0XJwQYF+jzVjkuMHegayuzVkwfqZ7lp8DmAhP8cUJJq6OSMVNMPY+hU6TgUROQdzIMW1jgR+/0AAT2977LcBSHcemQhcXPvf6jag/PPlRAVXntPxYLzJHypvQke/nRXOqnth6e5Yod379/A7eUuV1N5LCtlD2oWhKAt02YFKbw9qXDHkfh2q5usnHUlnYTIsrDJmRI5rxiz+S4Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(5660300002)(2906002)(44832011)(8936002)(83380400001)(36756003)(86362001)(38100700002)(31686004)(82960400001)(66556008)(66476007)(6666004)(66946007)(6486002)(478600001)(31696002)(8676002)(2616005)(26005)(41300700001)(6512007)(186003)(4326008)(53546011)(316002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2NhdFBaVlYzZnY0VnpTMkMxTVo1R1ZhVnNqNUd0ZDFsMTZ3QkdIOGI1OExi?=
 =?utf-8?B?Y2xqK1pYdDByYkdJK0krZjFwVjhudW1tMVdUbW1yS0hpWEcwTUhLNVJoN1dM?=
 =?utf-8?B?Q25PK3pqOWtlaGxUbDBiVFIrVktvT252aUNQV3paajl1MmlPeVpka2VtRVkr?=
 =?utf-8?B?NGxtVy81dmpqM2g4aXZDN0VTQjZFcHV1NGpOTDNYSlFSb3hrekh1eU4xZ0sv?=
 =?utf-8?B?MmNtdDBYa3ord21RUVRLcHJlS055VFJueEpCM3dublgzSEgweWZFWEZEVDdD?=
 =?utf-8?B?WWVwNnNHL1FLbkpyUTQ1VW1lbUFaOFBsRjN0VFRINXJnVHhNM28wT1p2R3hm?=
 =?utf-8?B?MHpEbDFDV1h6Y08ydjBQOG4wZlErRTlzZkt3WjVQU2xIQllHRmZ4a21tc1RO?=
 =?utf-8?B?RWtvR3h6d1BtQnhzWEg3cG9TdFRmNHB5VkZzam9venBzSGRDREJ0aTUrVVg0?=
 =?utf-8?B?QS9ybVlVMkJHbjRoV0VqUS9rOERWQXc4YVQ4WkZ4UHhiOUROOUxxT2hlY1Nr?=
 =?utf-8?B?a1dYakUrL05pekZ1dFNWNEpQd1J6N0xhQlJVUzM2Sml5NjVBODR4VjlVeWRq?=
 =?utf-8?B?U1lLbzYwRFMrcVVBNHdxaFErQzBpM3RCSUVpUUN2WmpyWkpYc2p2ai80WTFO?=
 =?utf-8?B?SXgrcFFQdmovWDBjQm41Y3BmRG10OG1uK2RkeTJHN1BjUE9ObVdZUGJiL05z?=
 =?utf-8?B?dUx6OE5tMEdzZzFBRTVwSnhFN0ltalpNS0NhME1vRWR5NUd4bWJmbGd2S3Bx?=
 =?utf-8?B?Q2Z4WDhZcXpTNGNDRVk3bDduWWdWUUhVQzAzeGRNTnh6R1FUMWZERnh3UUdw?=
 =?utf-8?B?K05IR2UxWW0wZU1IMWZyWERQVTRLcVFlRTA1VXdjdENaR0Yxa2FLZEZDdnV6?=
 =?utf-8?B?Z3puclIwTmdGMHRvYXNUdllxenhSVXhuU0hFMlZNZHRPOTVSRjRKYnJ6d1Uw?=
 =?utf-8?B?ZFZLbUZvYmdpQklZaFQxcStrd296V0hJS1M3VUtXQkJvWUlVbXgrMStmbG55?=
 =?utf-8?B?aWt3L0wrcGxlZUk1L1FWSUFsZ0RnUEhHdkRsZkpSM240MWwyTFlJdHVGQzFh?=
 =?utf-8?B?azRyOGQ1NFZtSm82ci9KWFJGcEpoVVZjdlJ2dDR5VkpTWXlBQkpLcHczdWZQ?=
 =?utf-8?B?OCtZNmxzYjJiTkZPbm9sSyt2K1ZKRGRKaDhNUHgwTVRMWTFBS1FQaXJQRk1q?=
 =?utf-8?B?aUVlYUZnR0FWRWt0TE9nbUlRVWk4MklQQXpjam9KSW1DWWxMTmdXcEpXNTRa?=
 =?utf-8?B?QkR3UzVzZTlhUEwzUzEyZG1qQWJMZnB3QzJsTDlmTUh3eGdrTmYzNWJmMTJ1?=
 =?utf-8?B?U0hpbkIyQmU3U2FvNDVYbTlVVUxjNFMvWVlkTDBlU0J4aStib1dEKzVuWWQv?=
 =?utf-8?B?S3p1R2hTeHZaNDFSUU91RjJRelEzSFJaenBLSUZFdE4zUStZcXd4ODE3ZTA2?=
 =?utf-8?B?VHNGYlF3MWcyb0ZGcG1Ec1BKTlJ2bGNyZTNkTG5yaHBQa1lhcVY5ZlU0YSs1?=
 =?utf-8?B?SElLQUJBU2xETUx2dTJXQjc1RzZGemNYZW04cTlEK211eGNFc2hSbEdTbzhS?=
 =?utf-8?B?ejlFS3paNDB0aFhTS0F6VFU1YWYvUlgrcXgrVTA0MGxnTlBiMDRzR2pRaSs1?=
 =?utf-8?B?OUpLUU9xSDZJMWRWUVR0MmFYaEd0QlpJLzZCNzFqZ2g3dU45amFzRkNFTG1i?=
 =?utf-8?B?VUlnek4rSlhCSWtPcUgzZmJCSFk1eHUzbzBZazVKYUR6TTl3VHlDOVVCU0FQ?=
 =?utf-8?B?SkRGUzE5RFpKVGYrYkRSWE5rcTlPNXRRa204c0RQYkFCVmd5NW5CUTkwRDVw?=
 =?utf-8?B?eEtjd0ZySjlORzVZWHNGeHFSZDl3RkxaWm1EYWVLRHhxb25tS1ZoT1lZUDFH?=
 =?utf-8?B?OUhBTGtsSlQyTVdXVXV5MzlKaXdsekY5bUl5N1hmaXo5N1QrczlkdUtWUXNB?=
 =?utf-8?B?OHI2L2RRTU85eHZ3UzFVd3NyNVZ3OU9RdnBUOVRnMkpYVXN1bG8yOUhYVDJW?=
 =?utf-8?B?QzRtUElVRGg0a0pZTldOT1d1S25KTkNibVFNNHJBWWh2c3RBMEZvYWQ5aU1F?=
 =?utf-8?B?N0hScStxdlYwSm1ObWhDa0lQNmd0bEhtV2p3aVpjUlJ5YU1PNEhwMWhkTnZD?=
 =?utf-8?Q?WHOb3XnazG8vEuxohr8Sqk6Ia?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c93f3d65-0098-4509-51d6-08db7376eb13
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 23:17:59.2871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqWosAZrYmB/0aCVKX26d7aiT5Cx35hLbJLKTVW1ZBGEZW5d7Cm14em0cZNFUBjIwZJLfayVHCNhOOXb9IA5GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8057
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/23 20:51, Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> Just moving code to reorder functions to later share cxl_get_chbs()
> with add_host_bridge_uport().
> 
> This makes changes in the next patch visible. No other changes at all.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/acpi.c | 90 +++++++++++++++++++++++-----------------------
>   1 file changed, 45 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 70cd9ac73a8b..0c975ee684b0 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -327,51 +327,6 @@ __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
>   	return NULL;
>   }
>   
> -/*
> - * A host bridge is a dport to a CFMWS decode and it is a uport to the
> - * dport (PCIe Root Ports) in the host bridge.
> - */
> -static int add_host_bridge_uport(struct device *match, void *arg)
> -{
> -	struct cxl_port *root_port = arg;
> -	struct device *host = root_port->dev.parent;
> -	struct acpi_device *hb = to_cxl_host_bridge(host, match);
> -	struct acpi_pci_root *pci_root;
> -	struct cxl_dport *dport;
> -	struct cxl_port *port;
> -	struct device *bridge;
> -	int rc;
> -
> -	if (!hb)
> -		return 0;
> -
> -	pci_root = acpi_pci_find_root(hb->handle);
> -	bridge = pci_root->bus->bridge;
> -	dport = cxl_find_dport_by_dev(root_port, bridge);
> -	if (!dport) {
> -		dev_dbg(host, "host bridge expected and not found\n");
> -		return 0;
> -	}
> -
> -	if (dport->rch) {
> -		dev_info(bridge, "host supports CXL (restricted)\n");
> -		return 0;
> -	}
> -
> -	rc = devm_cxl_register_pci_bus(host, bridge, pci_root->bus);
> -	if (rc)
> -		return rc;
> -
> -	port = devm_cxl_add_port(host, bridge, dport->component_reg_phys,
> -				 dport);
> -	if (IS_ERR(port))
> -		return PTR_ERR(port);
> -
> -	dev_info(bridge, "host supports CXL\n");
> -
> -	return 0;
> -}
> -
>   /* Note, @dev is used by mock_acpi_table_parse_cedt() */
>   struct cxl_chbs_context {
>   	struct device *dev;
> @@ -467,6 +422,51 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>   	return 0;
>   }
>   
> +/*
> + * A host bridge is a dport to a CFMWS decode and it is a uport to the
> + * dport (PCIe Root Ports) in the host bridge.
> + */
> +static int add_host_bridge_uport(struct device *match, void *arg)
> +{
> +	struct cxl_port *root_port = arg;
> +	struct device *host = root_port->dev.parent;
> +	struct acpi_device *hb = to_cxl_host_bridge(host, match);
> +	struct acpi_pci_root *pci_root;
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
> +	struct device *bridge;
> +	int rc;
> +
> +	if (!hb)
> +		return 0;
> +
> +	pci_root = acpi_pci_find_root(hb->handle);
> +	bridge = pci_root->bus->bridge;
> +	dport = cxl_find_dport_by_dev(root_port, bridge);
> +	if (!dport) {
> +		dev_dbg(host, "host bridge expected and not found\n");
> +		return 0;
> +	}
> +
> +	if (dport->rch) {
> +		dev_info(bridge, "host supports CXL (restricted)\n");
> +		return 0;
> +	}
> +
> +	rc = devm_cxl_register_pci_bus(host, bridge, pci_root->bus);
> +	if (rc)
> +		return rc;
> +
> +	port = devm_cxl_add_port(host, bridge, dport->component_reg_phys,
> +				 dport);
> +	if (IS_ERR(port))
> +		return PTR_ERR(port);
> +
> +	dev_info(bridge, "host supports CXL\n");
> +
> +	return 0;
> +}
> +
>   static int add_root_nvdimm_bridge(struct device *match, void *data)
>   {
>   	struct cxl_decoder *cxld;
