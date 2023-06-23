Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B822773AD8E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjFWABW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjFWABS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:01:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA70A1BC6;
        Thu, 22 Jun 2023 17:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687478477; x=1719014477;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kJJTWyOL2y00nduXcUgKoNkgCg0hm2eDMDGMZgahTAY=;
  b=AW2DCi7L30UTx6IfwssOojS079avwTCRR+OsyDzEGYTY7S9mQ7EkxHkz
   P4CRn0jhQkUO7e19EDAT7D1NthHkHZRtT0PUr4nhwQCWIE5079VsbCims
   PGpaFpK/2BZT3mmJVPYwr6Z60dofe8bAd56D22sN3LUolRAVO3sv++Qpy
   w6Kh2eOsrkFfxinTVuY+mXfgsVVvHXvmO4mU/rx0nca8ht48Tbe4n8kV1
   Ibd5KawRZoV1zyfiCP6GK91P8Yk07TyAET4FCzoeuZmj5uI6hbXIGIVvK
   BaN/yO6d6xEtiNb92Wx4h1VartqO5tnoAteqbv4dtqrRzC474fk1AWWpi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="390521313"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="390521313"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 17:01:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="715127594"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="715127594"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2023 17:01:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 17:01:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 17:01:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 17:01:02 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 17:01:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NF9A+uLbqIBjhZ5nbNzK4DaD8gB1nrMCHI/s3JVbeB4BTAQjHAFUPPNJ/FhFebe+EBFDfZ/y0oXSZo1gs94PA6EOcqEqWFVlQ2Je3I8HDhIaLa3S+brvtPRiQ4t+rr1PST6t3ujT6ahGg4U4rQTmq85DXyfl+NBaE06v/ecjKdSYTg4r6/kzOsSrPasy6TST9rYHelidpWGKLH3C3kmXctkiOtv3BVwGJA9gYJ1Fy60zt2lHe3B/sB2/VmzEbO0+V9SLU5k9lRUlVVBv691md7G0QXipkm/2a3TgoZhQG+QrJeI8Rx0iLif3lt22K+1s5VTvM1TZMenPM5ljLXwPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXej4YDi8txsYl8gqhY6zfgIMJSD7Ty20HgrHQt/xHY=;
 b=oL0p1d3neRzpfmgYFs3grXI0g4SYsZo0oyudVocXoXIyfC/3X1Ffpy3l+4/mu0B1N1DOYV3hw50IQ0BBTT7d5RWkXUNaCHbB5FUOdH9zD/f10wmFcgSYm0aOt+warLx0hDlvBfW6mLi3fK3SbjUnCc65j55+U2hctfS5jLfpgYSPBue99oy2wD+Ny4V+bO6nQOMHcqF9gpgwM6IvFsA9qFj0H9uwP42kJ8puvBj8VQQJmIoXgeuvceqfhUtZcWNSjQrPKHhwXdJImf7MdojMdvfqFGOFrZInSYDWlBIhKArHKpQV/V7og/spkicTNTeExPg35/xZfbBJs0VyAPvLsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB6654.namprd11.prod.outlook.com (2603:10b6:806:262::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 00:00:59 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 00:00:59 +0000
Message-ID: <67068bf5-c96c-6de1-d6cb-9ad4dd524701@intel.com>
Date:   Thu, 22 Jun 2023 17:00:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v6 15/27] cxl/port: Store the port's Component Register
 mappings in struct cxl_port
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-16-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622035126.4130151-16-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0118.namprd05.prod.outlook.com
 (2603:10b6:a03:334::33) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: a63b581a-af03-4dc1-348f-08db737cecbe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VahXcLi4SlNjn1NVQ1PHKaOmzuyz++2agiLfyxAd4V9X3ZdVar9bkCXj1q3vf/sl6vyHubRNTfW3nZcHv6s8N5OaAijW6bEtWZo5LMYrzSAbdagmemzcCvKZpZ9w8GuYOCLyptHrok3/wBXNYixyzxDBVDl2Wd17Wg9hE8D62gGXZHFFmQWJ73gCKHyMcqLFEQFkD4M9KyEnT22AOOC51FIJ2isZCsFY0hISQEuuOjYEjQwE4LOq/huRLSdoWtE0gL8nPRwRaEF8U3rB/QWwWoQ9alySbTCcCc+c450nTwiOV5oN+JrkfcRcjYBIhRuTlWen0k+VwmnyoJLxdqhfr3Oi+eO2rOY6wqFJ4oMtp8LstbLAf7wUOPjHXKLbAkiBV5GF7BNKhYCzKWpQWOZ95Rn5p1Ws4R6NFhpXE13wKS7senKYbjC/PwOyvdGytK0NXudxoMyGNdjbDTTN0XIVD7k94/R+wySmkwS4JSaeHiMu076Kmdtso1WmmLzbS2cCwYS57jm3Ofnb36jpJ6xbYHj5BSV4NR8pxR6/xRBLdfMiOXz1aWW6sT5+3ND6jcRFPJRjkfDPU9ua6WKbqW27cOc29pgIwazaWWxyM9mxteCnqHZmNs2lDdG0MPNu2JJWeeGbkXKG5kwl91Jq2p8qnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199021)(38100700002)(53546011)(82960400001)(5660300002)(26005)(6506007)(83380400001)(6512007)(186003)(2616005)(44832011)(41300700001)(8936002)(2906002)(6666004)(36756003)(6486002)(4326008)(478600001)(66476007)(66556008)(66946007)(31696002)(86362001)(316002)(31686004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b25JRHZqZGF5Um9DL25CT1VRUzJiTC9wY1hDVWZkV2dzVVVGWTA0U3JLR0pv?=
 =?utf-8?B?b21ZL1BmaUxKd3lucDVpekJ3UWl5T2NVcnZFMWd3blFPZTFQd0RFNWROc0lx?=
 =?utf-8?B?ODdWQ0ZETEw0bDJsMUc2VFkzWnlBSEVlZ1lVbmxiUHNRamlNV2cxQkg1UXJk?=
 =?utf-8?B?K2Vjejd6bkVHNmQ5ZXFWdXNhclF5Rm9VOFhBY2Q4U3owcklXTzZ0Tkh2V1di?=
 =?utf-8?B?NGE1Z2VDWTFYcHFlcmZVTXIrcktFdGlBTU92cE5PMlFMay9uY3pXejg3Q0NW?=
 =?utf-8?B?c0ZBWEN1YmszQW9yOXNxWEd3WVBJanVWc1lXeS9UbEMxZVRpTGxpM0lNNmRD?=
 =?utf-8?B?L1BteWZ2NFdJYXdFdUJLVmdQbEp6NDBrM2c4MS9jdHRPWFdvQ29qa0RWZjFp?=
 =?utf-8?B?VllpOEg1YjFTblhmY25KWVQwcE13bDNBazlDOUl4VVhRNDRYUGlSdkhpZS9I?=
 =?utf-8?B?MG1RVWFRaUVKOHZ5MUJUN3VkSjhGNVRhNkZ1ZnlhcmdBKzNsZkZwQUlOWVRE?=
 =?utf-8?B?bUloby92akhOTE1KeWt1NWdON24wc0g3dkQ2UHpqUUwyUEI5TGFBSzJSYzNC?=
 =?utf-8?B?KzhIRkRqZUFhOGE3dHFZcS9sSXozV3JsQ29Ma0hrTmptVWtwbC9kZlVpeEJR?=
 =?utf-8?B?NmtpOHU0UFdLNnZrNXZqQ1BBZ0d3YWhKSlF2RTcxQnk1bTZEUVdyUVBoOGlx?=
 =?utf-8?B?ZlFPVGJBbkRwOWQxVUtKenRpTGw1NGkvOXhRNlFkekorQklZN1pjRGN3RXVn?=
 =?utf-8?B?WDdsd1pQVysrQVlTNUp4MHRxbVZISTBySGNrVDV0UUFtV2EvSXRIVFAvT1J6?=
 =?utf-8?B?Mnc0MExyT0RCUEZ2a2U5Ym5NTnNCV1hpcGpiUnNkU3J5S0R2U3dwOG9YSk1o?=
 =?utf-8?B?WDh4clM3VE1SdDdrelpreVc3T1RUTFIxVEMxdXBvbDJScjZlb3NUUExrRGJy?=
 =?utf-8?B?Z3Z1N3NBaHJGS04xNTRNTmRvSzVuRzF6YUt3ODJaMTRydEg5dnl5RzI0YUJE?=
 =?utf-8?B?ZEJsWVl4TG1Rd3BlRmJML2dabitRMWRYRDlIRzF5d3l6UVA3NnBIdXdyL2VF?=
 =?utf-8?B?K28vazlsTVdVOVl0azk4K082OE1VbXl1bHlTaGJacmdVNUlxMTBNZEc0QU9k?=
 =?utf-8?B?My9SYmkzQzFtb2FGMm9vRitDOW9ZWHdhczJBR0V0dmZuY1lLZE1HbmJ5aVFk?=
 =?utf-8?B?VzdNNXI5dndjUDZUeENWSVY3SE1RMlhIdW1KK0srRkxmV1pBQVpNRytpQ1hE?=
 =?utf-8?B?cG4xbkhNdWtvMEdRQ0haU3ZoZkU3dUZjNXZVb3pvWjF0MXVZYVBhZE0yYWkz?=
 =?utf-8?B?enFpYXV4c1JIaVB6WVo0b25JeDFPRGE1REVrUU50Q0FQSWo4eHJuMzJkNVI0?=
 =?utf-8?B?YTBzTm9iWXA5MndqUmRTYkNBbmdFallBNWtmbDc4R0huc20yUld5RnlxZXR0?=
 =?utf-8?B?Y1lNdWlqenJnRjgxNmlWWGtidmlpQUZlVFZ5QVJjcUJFSVhvZWZ4VUVwMjJS?=
 =?utf-8?B?NUVPY2tHQ3NoMWljbk1MQkY5eDJCOFlodk5RaFI1UjF3My9lc1dseHdWQ1My?=
 =?utf-8?B?OGJpWEI2MjlQcXpTT2d4SWdndmhPNko1WGdYZkp4cTgyL2E4QjNQNXBOWkt4?=
 =?utf-8?B?S21qbTZESk5KdGw0YWczWVhyNXFOazdjVTFTVGFHWlcrUzd6U3BmQnR4WWE4?=
 =?utf-8?B?aktZWk53RjhCbFRsQS9mRkRzRlZVZXV0MGFwNjI2YWJvdTZpbEMyUWJpYXhv?=
 =?utf-8?B?bTFGaFRobmVkUDh3dTA3T3QwMWhqUXZranV0RjI5VXFzVnQ2YXZGa05nczFk?=
 =?utf-8?B?SFVYZmVuZXJuZDd0TDhzWXdZVG9jQUtQeFVEWUEzSTRYMG9lUG1Sak5ZcnVz?=
 =?utf-8?B?eVFBeC93NEFwclBPYy9zdTdRVWFIbTJ5eVdnZmJhNUVvWitNalJsTW1UNnhG?=
 =?utf-8?B?R21pUFhYK0k1ZDRXU1l3Y2FRUGhKeGRmZmcvOGpzQnFzdnBkaHkrK0hYbkZB?=
 =?utf-8?B?Wk8zK1pSOHdxMktwRHM3ZXg4SUlLYkFtWU9Cbk45d0hwRUdEaWNxdGZrZk9P?=
 =?utf-8?B?YTY3N0MrbGNXVVNqVGF0YlI0Qmc1NGF6UTc2cTBYd2trNHV6K3UwMEE1T0Nq?=
 =?utf-8?B?M1huL014ek8vMmFaakFKVG9HcU5KV1NVZUxFY0lVU0l0dEtsUVREMFkxVlRS?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a63b581a-af03-4dc1-348f-08db737cecbe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 00:00:58.9888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HKFCv6ohsU4EE95lH3ZNTqJywxShKwS54sGVhSuYeHlMTVagtHJDfqF/ZPSTAecwwngPtebOedLe2o7180ayw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6654
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/23 20:51, Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> CXL capabilities are stored in the Component Registers. To use them,
> the specific I/O ranges of the capabilities must be determined by
> probing the registers. For this, the whole Component Register range
> needs to be mapped temporarily to detect the offset and length of a
> capability range.
> 
> In order to use more than one capability of a component (e.g. RAS and
> HDM) the Component Register are probed and its mappings created
> multiple times. This also causes overlapping I/O ranges as the whole
> Component Register range must be mapped again while a capability's I/O
> range is already mapped.
> 
> Different capabilities cannot be setup at the same time. E.g. the RAS
> capability must be made available as soon as the PCI driver is bound,
> the HDM decoder is setup later during port enumeration. Moreover,
> during early setup it is still unknown if a certain capability is
> needed. A central capability setup is therefore not possible,
> capabilities must be individually enabled once needed during
> initialization.
> 
> To avoid a duplicate register probe and overlapping I/O mappings, only
> probe the Component Registers one time and store the Component
> Register mapping in struct port. The stored mappings can be used later
> to iomap the capability register range when enabling the capability,
> which will be implemented in a follow-on patch.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/port.c | 26 ++++++++++++++++++++++++++
>   drivers/cxl/cxl.h       |  2 ++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 679226023f0c..2e239fd33df9 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -688,6 +688,28 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>   	return ERR_PTR(rc);
>   }
>   
> +static int cxl_setup_comp_regs(struct device *dev, struct cxl_register_map *map,
> +			       resource_size_t component_reg_phys)
> +{
> +	if (component_reg_phys == CXL_RESOURCE_NONE)
> +		return 0;
> +
> +	memset(map, 0, sizeof(*map));
> +	map->dev = dev;
> +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> +	map->resource = component_reg_phys;
> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> +
> +	return cxl_setup_regs(map);
> +}
> +
> +static inline int cxl_port_setup_regs(struct cxl_port *port,
> +				      resource_size_t component_reg_phys)
> +{
> +	return cxl_setup_comp_regs(&port->dev, &port->comp_map,
> +				   component_reg_phys);
> +}
> +
>   static struct cxl_port *__devm_cxl_add_port(struct device *host,
>   					    struct device *uport_dev,
>   					    resource_size_t component_reg_phys,
> @@ -711,6 +733,10 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
>   	if (rc)
>   		goto err;
>   
> +	rc = cxl_port_setup_regs(port, component_reg_phys);
> +	if (rc)
> +		goto err;
> +
>   	rc = device_add(dev);
>   	if (rc)
>   		goto err;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index fe95f08acb69..37fa5b565362 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -547,6 +547,7 @@ struct cxl_dax_region {
>    * @regions: cxl_region_ref instances, regions mapped by this port
>    * @parent_dport: dport that points to this port in the parent
>    * @decoder_ida: allocator for decoder ids
> + * @comp_map: component register capability mappings
>    * @nr_dports: number of entries in @dports
>    * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>    * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -566,6 +567,7 @@ struct cxl_port {
>   	struct xarray regions;
>   	struct cxl_dport *parent_dport;
>   	struct ida decoder_ida;
> +	struct cxl_register_map comp_map;
>   	int nr_dports;
>   	int hdm_end;
>   	int commit_end;
