Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AD673AD95
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjFWAEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjFWAE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:04:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B86EE2;
        Thu, 22 Jun 2023 17:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687478668; x=1719014668;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9SJd2159QVn7mxt0Y1f6EELMEslJKjN2IxkG8tr04m4=;
  b=Nf5fCjMcKUyl9PSofBjueo2sf5oBRDJCRahDhhbrR9zvBnYvq68uacZD
   tkgtYKmocuDgDPtAqxrjq/V/+MkooX/brkTKInbqaM4v95eitq16RI2Z5
   PfGZxpHDSpn/Ws54a7tRY9Jh6h+ahp92nGkyyiAgjyMvUvDfjzNiiiHvI
   i3hF3YNLDktDktFrPYnfkG24UTPgaMAEodsvU1A0GV2mnqB7VXXkx0hyl
   suCrTVSJh6Hl2WH3aNBTTNfXuLVCL5f1AozMP6p6wVvbpRaUquq+JKBhx
   oR4rSXavCZiWmsEqVKutM1fH7RRMhMCktm6geNBaF/peXhxVprDqTIZOS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="350409105"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="350409105"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 17:04:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="1045444275"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="1045444275"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2023 17:04:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 17:04:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 17:04:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 17:04:08 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 17:04:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bo3e8lNglFu1mbVswUEoYOktCW9xdGK1OBECeTNjyapZ/518Kpy9/s+HOA4jacXa3oIvt5fTycErkZ3HOaTtcQfmJ/2M7J7SomUkJIybU02JO7HfwpvcsjdXlG7zhloCWlBUIUVGzv7TmalZ6J9Eq5x6R8E5LYUTSJ/fOBH1tov1O8aSSzTWPLUrEtPyi29qkzIBod36ez/5pFq3u7fgI3Nn7Z1NcG+jwmYHIOEJ/K2YuPsGJ7P8ZUjJiDfX+PmU8Vj3YHHqFz/E/S0/NQ4JuOnlBN8mAS6hkxzDgcKaWy9dXFbEKj+etMh/y1uafGgV2aca8OHXlm3lclc287bjsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6yXWXr+srqwd3Syr5HseZ/heGpKXlTYXTT3TShpBkg=;
 b=hunkheoTO+9rjUvLs9OC/POLSECYRS4AfG/Ly7KZ+27Q1FQ9Bm5gUAMCG/Tl2SSVqdLF4dUFQfGIriNppe+2sAHRlo8+lWf7ye2F4M37IMZYNfxVwGzBv6cePux+oYGBCyFcH+/kCrj1+2YWMxadZekVL+5+SbZ0iaX6i2pGB3JoFBZMoSORe4ueP8DdHRPcPmXOLOKFNOmjmk+O4cHiBnGmu7jADf6n6JuL5GRBD7wjwVaIcvPlSeiBJ6VmmmXizMTU2s3B/hDp7D1rz36BgS9xVsmXBCrAzCkXsHqcfCzqQG1XXaWhGzvqXp+kshtLMO71apfZpm87oNWnsnDfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB6654.namprd11.prod.outlook.com (2603:10b6:806:262::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 00:03:58 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 00:03:58 +0000
Message-ID: <11d4ef87-9724-dd61-e1b1-aef73afcef9f@intel.com>
Date:   Thu, 22 Jun 2023 17:03:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v6 18/27] cxl/hdm: Use stored Component Register mappings
 to map HDM decoder capability
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-19-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622035126.4130151-19-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0097.namprd05.prod.outlook.com
 (2603:10b6:a03:334::12) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 725a71ac-233b-4677-2e8d-08db737d57e6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2uGaRoILjlqDoG/jGaYcz75nDaufe7Jm/wRKkc1NJ8hrgDPn/RSgcRiYkE9ya4oW/yeii/Vi/1LX4RMzKV0RQZcV/X2Pb7LF7CbJ/IzaSkOK8B2Sc6dkP2oRwrWR9gvo5kRag6FwOX5XIhJAIEZ/nHXxKeILed3gDiBVzID3GTQyjX/Y5r8Rsf9whd6Z17AC3n0FWtsgwpkY4ltAa6DYGjnW0l/aJJweZ7engMtClcJw9iOtace8+uuAkimQs9OjrZ77UZIh4RzIIiG6im5zTB860FFgHJl5tVCfC4o9Z/7LypovLpiiuXK6hzzd3981Hdp31POVzp8PSOVoB8jD4cSMneRlDXdtGQ/xQ4gt018lRGm4BhQVB3m5k3O8SjUmWJc059qsQvvv6MDD8fZ5fNoVJdsvhySOUZ3jV39JZ1grbYXBIdQd4WNR8GuW9KcInd1oSmc8h0IWVQMgGtnm/AkkmYHUPf6aIESEDoUeu4H68Oe1HBlSLSbX8+kx6P5Vq5auWHHBMbIfO9A3JtSStcOPPZwQA5w1KnlHM7h4WWXNgcO7hTWL7jCBn7Dl1JRbd8fI9ycE9whUqLKeMgdWPB4QOzMBPmV9EVldHmxLRnXkFa4WUYjT2Bw0e8BFl+jI+tHmQb9ZjIMaJy+WVr/GwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199021)(38100700002)(53546011)(82960400001)(5660300002)(26005)(6506007)(83380400001)(6512007)(186003)(2616005)(44832011)(41300700001)(8936002)(2906002)(6666004)(36756003)(6486002)(4326008)(478600001)(66476007)(66556008)(66946007)(31696002)(86362001)(316002)(31686004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3hIQ2hjV3VXaWhXY1dMaGhBSWh0djdDNDRUd1YxN2xycUNGdWgyYkJUb1BC?=
 =?utf-8?B?QTZZZVpQeXJDVXlUK3laV2ptZlh2Wk1xNExFNWpmSjlVd051VVBBSUozejRZ?=
 =?utf-8?B?TTV4VGFDRENRY3BnaVJoZm1iWm9oSDk0eFBBbW9mbThKaUZ2WW9ERm12dS9C?=
 =?utf-8?B?NGQ3VHNndTVYcjA3N0ZvNGpjRVFsbmY1aHZnNWRTZFkySGZZclB4MXZPWktJ?=
 =?utf-8?B?SW9reHdNbENyMXl3cVg3aVlKekdrUzlXYXFld2thMDJZWnJFa1FDaU5tRFdS?=
 =?utf-8?B?eXAyVVdNR3RNSzBieUkxKy85VlNuaDZaUW5Pbm5Rby9LRjZyaDhocEx0UVhV?=
 =?utf-8?B?eXowMEc5bVFlYkpnZjdrMVFCOEdPT0NRTEVaTmZTMmFhSzUvNmREc2E0ZEhD?=
 =?utf-8?B?S1Q2R0Z0R1I4QXphOExYaDJsMUt6NkFjaTZnSDlUL1NCRi9tYytoblhUWXBz?=
 =?utf-8?B?Z2hLWXRrcjVxdmIxSkpXODNQMUhLVXIrU0gzRUZGei93dnV3VkxwekFISWhv?=
 =?utf-8?B?emdyZ2hMZUpVcGJIZjVteThaS2E1MHNyTDVtalBuTi9uSm02bjloaVhnN0Jq?=
 =?utf-8?B?c0pKTEpCeXdSdW1RVHFPMGt6VmYrY05RekNldnBvQkZUMEpmaCtYUklPZGFl?=
 =?utf-8?B?c0d5N3RMdUtIa1RRMmZ0N0ZkM0N1R1NUSWhEQnQvOVdVSWFsZk55eU5UTWtL?=
 =?utf-8?B?S3pMOXZtb2gxZ3RiK0dONjBQTm1ML2ViV1ZQaFJkaHU0RTZra1JKSll5T2h2?=
 =?utf-8?B?NFZyM2xOZC9ocnZJT3R0QUFJd0lLSEI3QTNVNmErek1KQW9pVTR3VnQrbzhV?=
 =?utf-8?B?V1hNVlhON3cwcWFJMTVick1IeXhsZWpXb014MUh6U096RGR3dzRpenpNaGor?=
 =?utf-8?B?M3RSdTI5VmZTYS80a2R0Zm9MRnBScDNaR2FTR3NybmhnZGQzTFNWK2t3MjMy?=
 =?utf-8?B?UWgrR082S1owd24wL0pzb0FNRmR4QzRxT1pYSnlxL282bHIvSFA5TlV1ZkxX?=
 =?utf-8?B?TURYWHRBdlc4TTIzd3poaUZleVp3WGliVTFPSU5jN29OUzZmTE5aREc3c3VR?=
 =?utf-8?B?YXgvenpRTTBjd0hjYWhzVzM5aW1OWHg4R1pNSWJkT1R3Zmx5Y0xGanUvM0lR?=
 =?utf-8?B?ZjRXVE9Gd2svVkpZQ1VITTA1K1ZoZVZLY2w5Nk4zL0JWSFVtRG83clUxa2pk?=
 =?utf-8?B?YmdXd2l0ZUxBblRrM2pIeDlKT0xzclYxcUY5RTN0REVoZ0tFRkQ2aHIzYkc1?=
 =?utf-8?B?K0VqMThBaGxub1BtYVVMUU43TUtxNFFxUXhHSDdmZDFFT3NqUko1S2xVYkFj?=
 =?utf-8?B?ZnYzTWE1UHZWZUpmNW5QZ3U1YWxaVmtRWnRIc1RVUjUrS3VPT1VMbnVZUmtl?=
 =?utf-8?B?Z2lHVEpLcmtmNkUrM3NjSkVUWW9MZkRjRFZXTDdTcTBxZWRpdGlVSS9YdEtk?=
 =?utf-8?B?QWh5TmxZc1JNSDNGRUE0Ry8zNGVTTFQyUzY1K04yK25ES3F3NDFJZjd6Qlds?=
 =?utf-8?B?L2F0S1ZCaThWNHJ3bnBEZ1R1SWtUM3hQL1RkcldNZGFyZUY0aWNlNVZLTEwy?=
 =?utf-8?B?MW5YVDFNVEI0SnllU29TOHdYWWRiQk9ETC8rWDVidzFhNUVOZG9aUVI2Vjg1?=
 =?utf-8?B?NTBsU0hqT2Rnc0FzRlBWb3g3SzIvaHlkSXlueGpDc1NxdFp1bytsK0tPdzZa?=
 =?utf-8?B?K0xDUzMzZzdzWXcwa0dRL2E0S3M3aVhjSnVPTkNGWC9MOWJoSk4yNCtMcmhl?=
 =?utf-8?B?eWc2amNkM3BMZEttZm96aFd1K1R2L245cDk2WjllSXNiSFZlMzhMUDJmODVj?=
 =?utf-8?B?V1ByZkVqUHYySmFyd2JWSGhvWm4ya1oyR3dnNEVTYS9oMzl1NzAzUWpDcHNq?=
 =?utf-8?B?THp1aDlTTDZZUFB6Q2lNb2NPUzgzc2lwazZlUHpWZVp1UnhaSVRoSVFseFph?=
 =?utf-8?B?bUMzUllmY2hpSlgxZ0FtdTAvT2FrOGp6TWpob2JqMU5PWUhXZzNBdXFKMjBp?=
 =?utf-8?B?UGdaQTlLbVd2eVZIUG5oTDRhdzdFbnNwNVczWFAycVk4YTI1WWxxMmZwQ2wr?=
 =?utf-8?B?RkY2TDhIT0V3VGNhU202QS9VYWxmODg2R1RqV3Z2M1ZFdW9yTjJhb1R0b2pT?=
 =?utf-8?Q?4o0jqT7q1S+PPXqRF5umN4dda?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 725a71ac-233b-4677-2e8d-08db737d57e6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 00:03:58.7066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpY8nbucsh4gnuhI2VtrH8y3Pz2AJyWhB812Rqv447Y/rn6UDa/1mZ/Ktla3iY/QJ3Sc+mqYHwFQ/BvOAdgV+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6654
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/23 20:51, Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> Now, that the Component Register mappings are stored, use them to
> enable and map the HDM decoder capabilities. The Component Registers
> do not need to be probed again for this, remove probing code.
> 
> The HDM capability applies to Endpoints, USPs and VH Host Bridges. The
> Endpoint's component register mappings are located in the cxlds and
> else in the port's structure. Provide a helper function
> cxl_port_get_comp_map() to locate the mappings depending on the
> component's type.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/hdm.c | 59 +++++++++++++++++++++---------------------
>   1 file changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 5abfa9276dac..8dcd9f0b22d8 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -81,26 +81,6 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>   		cxlhdm->interleave_mask |= GENMASK(14, 12);
>   }
>   
> -static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
> -				struct cxl_component_regs *regs)
> -{
> -	struct cxl_register_map map = {
> -		.dev = &port->dev,
> -		.resource = port->component_reg_phys,
> -		.base = crb,
> -		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> -	};
> -
> -	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
> -	if (!map.component_map.hdm_decoder.valid) {
> -		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
> -		/* unique error code to indicate no HDM decoder capability */
> -		return -ENODEV;
> -	}
> -
> -	return cxl_map_component_regs(&map, regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
> -}
> -
>   static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>   {
>   	struct cxl_hdm *cxlhdm;
> @@ -145,6 +125,22 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>   	return true;
>   }
>   
> +static struct cxl_register_map *cxl_port_get_comp_map(struct cxl_port *port)
> +{
> +	/*
> +	 * HDM capability applies to Endpoints, USPs and VH Host
> +	 * Bridges. The Endpoint's component register mappings are
> +	 * located in the cxlds.
> +	 */
> +	if (is_cxl_endpoint(port)) {
> +		struct cxl_memdev *memdev = to_cxl_memdev(port->uport_dev);
> +
> +		return &memdev->cxlds->comp_map;
> +	}
> +
> +	return &port->comp_map;
> +}
> +
>   /**
>    * devm_cxl_setup_hdm - map HDM decoder component registers
>    * @port: cxl_port to map
> @@ -155,7 +151,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>   {
>   	struct device *dev = &port->dev;
>   	struct cxl_hdm *cxlhdm;
> -	void __iomem *crb;
> +	struct cxl_register_map *comp_map;
>   	int rc;
>   
>   	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
> @@ -164,19 +160,24 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>   	cxlhdm->port = port;
>   	dev_set_drvdata(dev, cxlhdm);
>   
> -	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
> -	if (!crb && info && info->mem_enabled) {
> -		cxlhdm->decoder_count = info->ranges;
> -		return cxlhdm;
> -	} else if (!crb) {
> +	comp_map = cxl_port_get_comp_map(port);
> +
> +	if (!comp_map->component_map.hdm_decoder.valid) {
> +		dev_dbg(&port->dev, "HDM decoder registers not found\n");
> +		if (info && info->mem_enabled) {
> +			cxlhdm->decoder_count = info->ranges;
> +			return cxlhdm;
> +		}
>   		dev_err(dev, "No component registers mapped\n");
>   		return ERR_PTR(-ENXIO);
>   	}
>   
> -	rc = map_hdm_decoder_regs(port, crb, &cxlhdm->regs);
> -	iounmap(crb);
> -	if (rc)
> +	rc = cxl_map_component_regs(comp_map, &cxlhdm->regs,
> +				    BIT(CXL_CM_CAP_CAP_ID_HDM));
> +	if (rc) {
> +		dev_dbg(dev, "Failed to map HDM capability.\n");
>   		return ERR_PTR(rc);
> +	}
>   
>   	parse_hdm_decoder_caps(cxlhdm);
>   	if (cxlhdm->decoder_count == 0) {
