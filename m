Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAB973AC9F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjFVWiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 18:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjFVWiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:38:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AF310F6;
        Thu, 22 Jun 2023 15:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687473530; x=1719009530;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2p+mRwb9gt2AfRV71Mw9FJCl0xYb5DBXlk9XvUVuZ84=;
  b=lxXXavDvmFxLbEekiEKb062FNkcGAOBj3aYDyV8QS+eChT56RyKHrPVM
   U3DCvMZNYzNLed/2l8Hc6nXR2anbDQD6ucWBwVsXvzsvYvSkX8tVv61OS
   jBWsii7hlKHtVm3Dhm+1zxzUcO/2qJ0cA7m3TYXv2WRndv8QobbgR8lBv
   nZ7L7MbNk2xR5Lr+Djz2GQQQq5libHwQ0c5gfyPCBRDrwA4jlBWNUd84c
   htqBgpj+LYntQDorifajah6UEyHtYohg3YXtfhlsm/E15V7EigNBJugkb
   i0ohGHeClFnthBZ1Mv8bWz50DWE+64Yk/Y0BD892UVifs5pDAujWtPGKi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="426610799"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="426610799"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 15:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="859631981"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="859631981"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jun 2023 15:38:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 15:38:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 15:38:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 15:38:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 15:38:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXjEDnbZ+2kIH5PXpins52tAFx/dRKgWWsFtCj08taXCyx67N+uw7LKof5FJ2lPkyTqGl1NOpyFvpld2cp7sKA71MdIcD/AfD1eXcmxxXZEaG3ys/cdxZgZR/dk41RIBh0xbJKxEBj47PVygIYoMcjXw2ReM8Tu0MU8MLo16ELLQCDVZsNny/VN2SOBbzoFr1aB0RF2Rp1/NqxJqa9EQaWnuPQbCdJHJDGE1KYMSmqU50AGGOoEYIei4plqCKxTlTES7o1bC8Ac1Pg16MitKoS0ajStqe0q/AuPNPqil37joEEYP89pUnfUaZFKNMqqWXSDs1gBPDQBIfrdOG81Ktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sABVqCZKLliaXZFngLtMMxKWfekN3ZIihDvQI5dCB2o=;
 b=dVzjIOvENm0O3XiqFF6mZGkSYuxZS8hmUWXRa1V1rj6qCT5IQYNUgLGiA2CJp0ML0+XYtIr1GOXB8yUs16vTKvy9sg7WgQh+tu4WVit6601itPxqleLlu2btG8CSsMjnjaFBS0aepdW3dP/zKW3dJroU/gpcQkGwKDyMLJcf/xha8OVx8UW2mXrrdQII1YuVZhpMaSmL0SBWlxkHtnud/71G4FihNUMrS/rWQ7NybbOhoQ6hVPG74PXvaiBfbxQOUgDUB/Y8xlhckzwigTpXOb0pztGO/osL85MXScmsmQJFi6U5V00712U0nUGOQHHDN8AaRStfVc6w+7CMgRPn/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH7PR11MB8549.namprd11.prod.outlook.com (2603:10b6:510:308::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 22:38:26 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 22:38:26 +0000
Message-ID: <ea00deef-fcbb-a2d0-f806-cfe73ac0de42@intel.com>
Date:   Thu, 22 Jun 2023 15:38:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v6 03/27] cxl: Updates for CXL Test to work with RCH
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-4-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622035126.4130151-4-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0092.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::33) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH7PR11MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f137619-16c4-441b-9b6d-08db7371648a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JXMs06QagYQQWkxqNJdaxRPTDfx/mXUoTmTsNrZXNTKASkeK18gMIy8tuUORHSIF4LzAInLBe4xddTRyFtcJamIwg4Jzhuxga6/KyZkcx4WVpEzVprWg2wG1fRB17TvrvnPW7El5MayR+I9quzICCLchV3Y7NbPU+W7s1z2dYBV4NxdT1lSdfSfDJKEMzfUUiOwjytb3BuLAlBWR4vXpox5GTLF6K+Q3nOTj/K2VbdDsP706gI4bir/fI+m5R2Eg8K7TxIPZ1UvyUIsmYqkOtUypG0ytS4CnMtAIuWUM3vRKgkpUXflGm2qEAFx8EFO04Aq8bG0uwAMzZx54DsTYmzj5FQ6no70CCQAvXefkP65UFJoH+Um6n6IDKZ7kxTPd8q8aXxg60vPyGjPu1pprXa/WqRvrjjCZndPG00zb0fDUfap/RNefMNywJa/44vcuvqUMcuEyIeEdvnje1QWk3f5tOBFtAGNlKy4xyPNc/jOhs2QJCdycoc1T+XDd9XPMgIwnm0fWYwRE5Jld/m4jxmcYwcfX+ynkj9CiFqZzi78mOJWvYz3dSr38fwdWgIkSOk5W7YTF+JJAEpU8Zx+LQKN4z4CBSkYHKhHyFrEnSyyaU2zyujeUJn/wgbRwmHu+3iQlS8poKEEy62XwkTevdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(38100700002)(82960400001)(4326008)(316002)(86362001)(8936002)(2616005)(8676002)(31696002)(41300700001)(66476007)(66946007)(66556008)(83380400001)(6506007)(53546011)(6486002)(478600001)(6666004)(36756003)(6512007)(26005)(31686004)(44832011)(15650500001)(186003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REVLZGdzS1lTTHJlRlRaOXBRVVdIWmovZ2QwM2N5Q1hac2dxTGpHWTZEeUFr?=
 =?utf-8?B?MTNUUmFuYXFTVEZrdk03WjJtMUpURVJSZk4wd1NQa1dlTDlJNDcvZVpLWE9U?=
 =?utf-8?B?aFp5VktXMDZySG5od3pOTEhFZW4zZ0Q5ZW5PeFN1VnN2NlEzMWFHY05oMjZo?=
 =?utf-8?B?WUI5UWZDMGtyMTNHK3U5NDNERnlCSGxqYk9jS01HcFdjUk1UbWN2SWtZVWhu?=
 =?utf-8?B?UXFoYnJUUTQwdWFCQVdYaVAyaU1iRld1dTRuU2pmNnFKVGFtbFg2R3ZXSTc5?=
 =?utf-8?B?b2lXWUpra1hYL00wNjJ4cDNMaDFTUVJnUisyN0F0dVBNeTFGNkx6dDVFNFNB?=
 =?utf-8?B?WVJXTTZNNnNPcVYyTUFndEplUXJjSnhLeHhrQmdjQTJPZGZYU21JY0d1dmN6?=
 =?utf-8?B?WWp1VnRzRVNuRTdxUk91WWdFcVNxK2Evb2hIeHpnNkdqR0VOU21OMU9sSm03?=
 =?utf-8?B?WS9xL2YwRkRUdUZVQWN4NUIvb0ZWNHRHVmp4Q1RyMEVZVUpXaDF2RG1sNUEy?=
 =?utf-8?B?TWdiaEc5ei9Qa0lkMktpb3Jpek1KMVZCdFpldEtFZE9tTndJSEpCakpLYmtS?=
 =?utf-8?B?L0g4TW90Yk1Vb2c2RnlYZHNVdVp3bEdyNFRObTNLbGhtMXIwR0FFY2dhaWhI?=
 =?utf-8?B?RVBRLyttMXVWMjd5UDZVR3llMUdnRWxwakM1ZlFRc1V1SGFYT050TUx5NDNx?=
 =?utf-8?B?VlZ0MDRJcjk1LzNWZDAwZXd4d0g3aHB4QzNCNVZPQ24wdER4SHZzeU42cHlq?=
 =?utf-8?B?eGgvMkdoNGloaVFsWVFUcmNWSHFRUUMwMmczSDRLNVloVWhCR3l3Z0JHYVBj?=
 =?utf-8?B?K0FHTU8wRE5oK25wS1Q1TDFDM2IzV2daVE0xZGNVcGJOWmkzcmlmQ3Z0VWhp?=
 =?utf-8?B?MmlmODlWWFJHUHc4VXZ0aGZub0hCMVpuZDFTRzJJNjA5VThnRGxJSnErU0pT?=
 =?utf-8?B?YzEyT1RMbytyeUltbTgzeFMvUGs3QXZwU2dCakc3TU9EUitlZkNDZ2VjSEtO?=
 =?utf-8?B?WStNSHN6WFBJeE1LZGlxOWdKQXdZT3pKc1podHJVekhvbW9ObEdyREZpQmtp?=
 =?utf-8?B?K1dxa1lJQzJoQ2FVOUl5NDZUZUFTd1JlUmxVSmY5Mk82OUZtRFcrZk9uQmZL?=
 =?utf-8?B?QTJqWEVRWGV0UExvM3d4WXorcjRnUVFYUUJZeUlsSkJ2YytybGI2TEw0Mitj?=
 =?utf-8?B?TjJsZHdlQ2JLYTdhY2thT0lITWQvbHlSaXdQVXY3SjJLR01LdlpiSlJUL0JH?=
 =?utf-8?B?alJKZDVCMjhjT1hDSHJUN3hqbmFJVzJobFVBZCs3d3VDalMwa1hUWXU3T3N4?=
 =?utf-8?B?RXZ0SC8rNUNCNFlySW9wYUppRjc5a0s0QjRVZ21oMEZ3dGlrTkE1YnY1U3ph?=
 =?utf-8?B?Nkc1akpBbTlSMU12VVB3ckRMcDVWcDQxd0tlZXlNSlZWek5MekhudUtOY1lo?=
 =?utf-8?B?dUxBMVgyL2lJUERHdUFoR3owTGhFK3dKWDl3VjAwcTNLVlVrZGdNYUF5OS9x?=
 =?utf-8?B?NGU3VXRuQWEzRHVCY2V0RnFuMDJvWUJSVlhEVXRqb041ZUUzK0pDVFV1THVX?=
 =?utf-8?B?ZnJZQXVDanQ5UTN5b3RhQTJCQVpjdUo4VkZESEhGZnBNeHhpRE1GbXNkSXNB?=
 =?utf-8?B?NTNpd2o1MW04enprd29jQnNSN3phNGFLQlU0cFdXczdhMjl6S2t6QThWSEVu?=
 =?utf-8?B?eXBhbXpKa3lqeUd5T096dC9hWWdySllqZVZzT1dNdnN0MTM1T2hwbE9vbTdx?=
 =?utf-8?B?Q2tKMmo3dkovSER3NEhJZHErQ0ROdFR2ZUpjRXFPVU9xaTYyV01tY05aTTFw?=
 =?utf-8?B?RW16ZklzNjcyMzZBTTRvUDE3UkM0WllQamovVkxqbktQS0VqV00vT2duSno2?=
 =?utf-8?B?d1ZkZjQ0MEoyY1hZUy8rNXh4Mkhaa2xzbGpxMDkva3N2VlcyNWxTdkFKeW9B?=
 =?utf-8?B?RmVNbk9pMUpaRVJpOFFpeW9WTUFZeTZISUJZQU9MZHRoMGp2WHltVlJuVU9P?=
 =?utf-8?B?SkxQSXZYTDBwS3ZFVDFSRDFDOUVZekc2bk52bGlGSmlkVFA1YXJVSEZYNmxs?=
 =?utf-8?B?N09VTUdNbkNJb1RuRklrdWQvaUNJb25ob1k4R25seGhkMFVwM2V3YjVaYWtG?=
 =?utf-8?Q?lDObRCjkvvNsYMF7X72vSrSPC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f137619-16c4-441b-9b6d-08db7371648a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 22:38:26.1381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GjQkmhl04xq/BhyrNklcnLJ7Ke8G3KQznso24csp8Vga6Oqn36PwhF5gp+Vk1cLPKoscxQDi3MPV+OiDJsuxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8549
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
> From: Dan Williams <dan.j.williams@intel.com>
> 
> CXL test needs to be updated to work with latest RCH changes.
> Add CXL test support for devm_cxl_add_rch_dport and
> cxl_rcd_component_reg_phys functions.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/core.h       |  8 ++++++++
>   drivers/cxl/core/port.c       |  4 ++--
>   drivers/cxl/core/regs.c       | 15 +++++++++++----
>   drivers/cxl/cxl.h             | 11 +++--------
>   drivers/cxl/mem.c             |  4 ++--
>   tools/testing/cxl/Kbuild      |  3 ++-
>   tools/testing/cxl/test/cxl.c  | 10 ----------
>   tools/testing/cxl/test/mock.c | 34 +++++++++++++++++++++++++++-------
>   tools/testing/cxl/test/mock.h |  3 ---
>   9 files changed, 55 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 27f0968449de..bd0a5788c696 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -63,6 +63,14 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size);
>   int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>   resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
>   resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
> +
> +enum cxl_rcrb {
> +	CXL_RCRB_DOWNSTREAM,
> +	CXL_RCRB_UPSTREAM,
> +};
> +resource_size_t __rcrb_to_component(struct device *dev, resource_size_t rcrb,
> +				    enum cxl_rcrb which);
> +
>   extern struct rw_semaphore cxl_dpa_rwsem;
>   
>   int cxl_memdev_init(void);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1a3f8729a616..45f5299af7a6 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -939,8 +939,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>   		return ERR_PTR(-ENOMEM);
>   
>   	if (rcrb != CXL_RESOURCE_NONE) {
> -		component_reg_phys = cxl_rcrb_to_component(dport_dev,
> -						rcrb, CXL_RCRB_DOWNSTREAM);
> +		component_reg_phys = __rcrb_to_component(dport_dev, rcrb,
> +							 CXL_RCRB_DOWNSTREAM);
>   		if (component_reg_phys == CXL_RESOURCE_NONE) {
>   			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
>   			return ERR_PTR(-ENXIO);
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 1476a0299c9b..564dd430258a 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -332,9 +332,8 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
>   
> -resource_size_t cxl_rcrb_to_component(struct device *dev,
> -				      resource_size_t rcrb,
> -				      enum cxl_rcrb which)
> +resource_size_t __rcrb_to_component(struct device *dev, resource_size_t rcrb,
> +				    enum cxl_rcrb which)
>   {
>   	resource_size_t component_reg_phys;
>   	void __iomem *addr;
> @@ -395,4 +394,12 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>   
>   	return component_reg_phys;
>   }
> -EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_component, CXL);
> +
> +resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
> +					   struct cxl_dport *dport)
> +{
> +	if (!dport->rch)
> +		return CXL_RESOURCE_NONE;
> +	return __rcrb_to_component(dev, dport->rcrb, CXL_RCRB_UPSTREAM);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a5cd661face2..28888bb0c088 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -262,14 +262,9 @@ int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
>   enum cxl_regloc_type;
>   int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>   		      struct cxl_register_map *map);
> -
> -enum cxl_rcrb {
> -	CXL_RCRB_DOWNSTREAM,
> -	CXL_RCRB_UPSTREAM,
> -};
> -resource_size_t cxl_rcrb_to_component(struct device *dev,
> -				      resource_size_t rcrb,
> -				      enum cxl_rcrb which);
> +struct cxl_dport;
> +resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
> +					   struct cxl_dport *dport);
>   
>   #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>   #define CXL_TARGET_STRLEN 20
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 519edd0eb196..45d4c32d78b0 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -72,8 +72,8 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>   	 * typical register locator mechanism.
>   	 */
>   	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
> -		component_reg_phys = cxl_rcrb_to_component(
> -			&cxlmd->dev, parent_dport->rcrb, CXL_RCRB_UPSTREAM);
> +		component_reg_phys =
> +			cxl_rcd_component_reg_phys(&cxlmd->dev, parent_dport);
>   	else
>   		component_reg_phys = cxlds->component_reg_phys;
>   	endpoint = devm_cxl_add_port(host, &cxlmd->dev, component_reg_phys,
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 6f9347ade82c..8a87d7d5f7f8 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -12,7 +12,8 @@ ldflags-y += --wrap=devm_cxl_enumerate_decoders
>   ldflags-y += --wrap=cxl_await_media_ready
>   ldflags-y += --wrap=cxl_hdm_decode_init
>   ldflags-y += --wrap=cxl_dvsec_rr_decode
> -ldflags-y += --wrap=cxl_rcrb_to_component
> +ldflags-y += --wrap=devm_cxl_add_rch_dport
> +ldflags-y += --wrap=cxl_rcd_component_reg_phys
>   
>   DRIVERS := ../../../drivers
>   CXL_SRC := $(DRIVERS)/cxl
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index bf00dc52fe96..f5c04787bcc8 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -971,15 +971,6 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
>   	return 0;
>   }
>   
> -resource_size_t mock_cxl_rcrb_to_component(struct device *dev,
> -					   resource_size_t rcrb,
> -					   enum cxl_rcrb which)
> -{
> -	dev_dbg(dev, "rcrb: %pa which: %d\n", &rcrb, which);
> -
> -	return (resource_size_t) which + 1;
> -}
> -
>   static struct cxl_mock_ops cxl_mock_ops = {
>   	.is_mock_adev = is_mock_adev,
>   	.is_mock_bridge = is_mock_bridge,
> @@ -988,7 +979,6 @@ static struct cxl_mock_ops cxl_mock_ops = {
>   	.is_mock_dev = is_mock_dev,
>   	.acpi_table_parse_cedt = mock_acpi_table_parse_cedt,
>   	.acpi_evaluate_integer = mock_acpi_evaluate_integer,
> -	.cxl_rcrb_to_component = mock_cxl_rcrb_to_component,
>   	.acpi_pci_find_root = mock_acpi_pci_find_root,
>   	.devm_cxl_port_enumerate_dports = mock_cxl_port_enumerate_dports,
>   	.devm_cxl_setup_hdm = mock_cxl_setup_hdm,
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index 284416527644..30119a16ae85 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -259,24 +259,44 @@ int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
>   }
>   EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dvsec_rr_decode, CXL);
>   
> -resource_size_t __wrap_cxl_rcrb_to_component(struct device *dev,
> -					     resource_size_t rcrb,
> -					     enum cxl_rcrb which)
> +struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
> +						struct device *dport_dev,
> +						int port_id,
> +						resource_size_t rcrb)
> +{
> +	int index;
> +	struct cxl_dport *dport;
> +	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> +
> +	if (ops && ops->is_mock_port(dport_dev)) {
> +		dport = devm_cxl_add_dport(port, dport_dev, port_id,
> +					   CXL_RESOURCE_NONE);
> +		if (!IS_ERR(dport))
> +			dport->rch = true;
> +	} else
> +		dport = devm_cxl_add_rch_dport(port, dport_dev, port_id, rcrb);
> +	put_cxl_mock_ops(index);
> +
> +	return dport;
> +}
> +EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, CXL);
> +
> +resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
> +						  struct cxl_dport *dport)
>   {
>   	int index;
>   	resource_size_t component_reg_phys;
>   	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>   
>   	if (ops && ops->is_mock_port(dev))
> -		component_reg_phys =
> -			ops->cxl_rcrb_to_component(dev, rcrb, which);
> +		component_reg_phys = CXL_RESOURCE_NONE;
>   	else
> -		component_reg_phys = cxl_rcrb_to_component(dev, rcrb, which);
> +		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
>   	put_cxl_mock_ops(index);
>   
>   	return component_reg_phys;
>   }
> -EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcrb_to_component, CXL);
> +EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, CXL);
>   
>   MODULE_LICENSE("GPL v2");
>   MODULE_IMPORT_NS(ACPI);
> diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
> index bef8817b01f2..a94223750346 100644
> --- a/tools/testing/cxl/test/mock.h
> +++ b/tools/testing/cxl/test/mock.h
> @@ -15,9 +15,6 @@ struct cxl_mock_ops {
>   					     acpi_string pathname,
>   					     struct acpi_object_list *arguments,
>   					     unsigned long long *data);
> -	resource_size_t (*cxl_rcrb_to_component)(struct device *dev,
> -						 resource_size_t rcrb,
> -						 enum cxl_rcrb which);
>   	struct acpi_pci_root *(*acpi_pci_find_root)(acpi_handle handle);
>   	bool (*is_mock_bus)(struct pci_bus *bus);
>   	bool (*is_mock_port)(struct device *dev);
