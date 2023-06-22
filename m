Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0B073AC99
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjFVWgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 18:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjFVWgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:36:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436FE19AF;
        Thu, 22 Jun 2023 15:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687473378; x=1719009378;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ACvKFe2hNqs3qSMM7WATPlWsgc+6Lx2Rlae0FNNrQoE=;
  b=R7FvbsiSQwaGE68Ui1xMPfHBmAUkKnO1Oc0wDOYubOisTptdfTSyjydx
   7nF8FE/aRHs+4PDp9jCKT0nGfFautZO/WVucMKGcLmCYkSSKq0V8W6K0q
   jZ/kjAIlbLnCaxWsKaOnD+JQUkayMJXcQtRYl1JXwxa6jIoJ5uVw5JfpY
   FMlskd+mK+23yDn3w5CD2WM4lZjZLjfJEEfMI/Z0Tezm9Ef1y6pNjvX2b
   YHfD/VTZVdzCTyoXrBT0JmOX1gLMwJcUQPAnK/4q0SFUr5wt+tMcxgf0a
   oyeUnnWOQ59VOhcfYPg/9CoF/wtUH2DKDLwZQNPLjqwwRyA14E3RiXOyu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="426610316"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="426610316"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 15:36:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="859630983"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="859630983"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jun 2023 15:36:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 15:36:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 15:36:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 15:36:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 15:36:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4oy3vqj2fxn9+2V2jNTl7lr3T60hj3S1lPNdCmg4EDL9pX2f7rruQzMUbIVa6DWUHwVixQ3aoreHwUSTAn4sq4zg4zl3ZsWXCexc7bANMCv9ys6uSaaAL4PBh9kCOyRmxst1fXBabu1LWFvDT4JyjBuVZKoHzFt8S6keww98T2ocPP3EP5NbmiPYjHuhcMTX6heaqJOLOQm18maZwNWETpOY7cDHc7e/qP/dKHzctssiEb13om+CocsLd3lpPL8aZsaXEPFVBqADomyu+2heQY0v8IYWFNfOtY/wwa1K1JjR9GJb00RNLWE30hkOXRcKPqy3tfaJmgHY3Gh2Wuuzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7tVB/3iXJI6xUyJdM1a369SEOsAWbc+l1S8P247lsc=;
 b=Oc1somw83jTxlPyDgRPZueYy6QIp364RKSQEAYGx6eGcRkSNU5LyelVP1hkA16dAkh+WhCP6nQ52YPO5XralxUGb9M/iMPMqOhBzLAtfSvl+peqxkdNPfiIrDXZlEloGUmCkC5sBWRj79US7m8/42gyW9NBDh0OtzYt/FdmmZq0qdFo2Es+y7y0Ea2PAHXzu0BN42bxbBc6csXfFtXYTK86ddWhle+nnR0nMK7K7M67AXXwx1qvIU29VYDYXEBzZCy5zplc4s8yT3NmFhrD7F+Qgi1xQyJ5U5gcxbAOVU57EDyMM6tgysyBrS3U+BmfrkQ2cFxw1U1YAD7aBr5U9VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 22:36:14 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 22:36:14 +0000
Message-ID: <8f6b4669-78ae-3244-a15a-c893c617fde0@intel.com>
Date:   Thu, 22 Jun 2023 15:36:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v6 02/27] cxl/acpi: Probe RCRB later during RCH downstream
 port creation
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-3-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622035126.4130151-3-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CO6PR11MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c2b614-9eae-430c-33f6-08db737115b1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tIDxamNL3ndQ76qCnBsVJXKSNbJWfbZcRZi3JYsIEFI45jkJIsxOtobC2EJEYDtBuGPpJDFEYRlb0XF6iZqcLhIHST97AGHR2YBB/OPVu4582+cwlOimemjOUSIVVZkCjdL2BRvUTKYiPr3i1LVEtEnjTBYeeWFCltfyNsT8gIiWvHTy7xritxx7n8bakwABFyB0UrGmRZACB67H7fWM6FLG8smO453/6WB0tPhGAgr/CAxEUVk2G7mbc1XMkUxS3OlXSKLeFTzIbGEK7QlySMxW4oFEMZqdOZIZR3kOcRei8yNFMIh+pRFRe7rjaYpE6nxVZ1iozPoJPlb/iDblTSOowvTTh1eXzsvL8r4dZoB7rzq7LtCQ77FWXrKMMktVTz+dIqBeOwRnh8dhWACa8RtuSA4d1vkr9syjN+LF4V1qepCqRj73y0/71hmVb9beaGW0g6OnVwU8yaCH209yXhdmi/zEHahA9O11EXa6f0EKfxcysICYZ/vQSrM2OvjL9rOH07+eWhT8fQ3kcY4zzxtqpk6fNpnK5LQ0dICRbfgWycGQt3VjyFoDD843W11azMpUQceUss/R7QPEYb3CcgWaiHq4i+oA+cazpf4tpRooSXGFcpjdVDRxnneFnvP27xYCZcvg+WdUvDDiybC/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(86362001)(31696002)(38100700002)(8676002)(41300700001)(8936002)(66946007)(66476007)(66556008)(2616005)(316002)(44832011)(83380400001)(5660300002)(6486002)(53546011)(478600001)(6506007)(6666004)(6512007)(4326008)(186003)(26005)(82960400001)(36756003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkM0ZjZtd3kvbXZ1eFNVOUNiVUFhQjBJMkNFdFhwUm05UEY5VGJoZlZLVnF4?=
 =?utf-8?B?RmREK2YxaEdaRzhtWU8wQ0xIUUdWVXBuUi84K3hsL2RUY0lqUXVwcEowam03?=
 =?utf-8?B?TktFbDI3eDk1bG5CMllSSCtJZDhaZGhvdjR0WVhvZTdNSFN5MGhzSzc0TC9Q?=
 =?utf-8?B?OVpMQUUvVlByVUdBdk1LV3EvVE5UNkxwdmlydDFGUldvd1NwMkNvTHpyK3h6?=
 =?utf-8?B?U0hiOGpOU3lrVEZoMExzSmhPWlpzTGtIaVFJQUhZKzFiUEpnOWYvQ3NzWGJX?=
 =?utf-8?B?Nm5SMDJYZ2hwZ0FwNmpMYW9UZVU1Z1I4NitCREdjcUhhVVgzNktQNG8wWDhm?=
 =?utf-8?B?Y3EzenBXZnpVUVozSTdaalNMSWZJUExjNWQveHk3cWlNNCtIejByRDMrK1lT?=
 =?utf-8?B?L2ZNRFkzMGQvajliMDI3Snh4VTl5MHFJYzdZUGk3MUd5SDdyOE5pR0o5WjA2?=
 =?utf-8?B?VlhrcGVtNlEramcrTzRCR0tlYUo3TGtoYWgvek5kTXNQR0dKdnIzVUdZUHdp?=
 =?utf-8?B?Ynd5SFFWOXRGNTU4SlZjVEhJSVhIR2pRbkFHbTdMWEhXN0NnaElTWnlRcmo5?=
 =?utf-8?B?UHY5eGdVcTVqUWlNVzdJeXV0WDl4L1VzTVFoZm5vMVM1d25wK3JGUlVJMEFa?=
 =?utf-8?B?YjZSSjFRVFkrL2tuNnJDN1FiRTFlNDVoUmpsSVpwVE9LSlR3Tyt0Ymt2WWVm?=
 =?utf-8?B?eFg2S2V1WnI4RllVYmZqOEc2ajVkM1NVTXVHQkZHWkxNdm9STTc5WUd5RWJa?=
 =?utf-8?B?ejNzQlJva0NzNGIvUjdJSFhYUGl6LzN4ck1kYVJ0Q3ZRdnJQY0VuM29YeXRv?=
 =?utf-8?B?aWhHd3VBQUN2VmdXVzZsSzlUTTF4VVNZL2doQVIxb0J4Y2d4RnQ1VUo5aDdF?=
 =?utf-8?B?SnlBWVJlZGh3MlFIR0JsRVBNclJrblBnSEZqejRXdzBYeE1kME4rNlJ4NUJO?=
 =?utf-8?B?V2ZRSlVLQWVDRWFqYytBWHFjMjdGTTZjdFFZTk9XbitZNDlwN2RPWlhpZjFS?=
 =?utf-8?B?V1BKZ1ZRcEo3TFFab1Mzd2Nhdk53aDFVeFd0c3FFUE5FK2lsaVlVTjlhaTdy?=
 =?utf-8?B?S25GQXJSMEpQMEM4N3dWZjVzNldvdlFqakw4TVA3SUtyVlpJRGdZNUJPUVRJ?=
 =?utf-8?B?RVZyeW9sY0p4ZnlmN0l4WHY1STdqVGhJU3B4SFhLdGNad1pUOHBsTUVwUlky?=
 =?utf-8?B?elBlYjhpRWE1VGR3VTA5bzRkL1JSVEdhMURpMndoRWJiN0piZmE2Z1c0RFkz?=
 =?utf-8?B?bDJtWjh6Qmc1Ly90enFQeXJ4KzNHTWUyanZCamJGV0NJNFFGQW5lZjErZDVK?=
 =?utf-8?B?VkRMUGhrUk1YQWpzMkluWHNQNVBwaytic0tpMEQwV3kraDVQTWZTd3MrWWQx?=
 =?utf-8?B?S2xPOWY2UnN1TTZrM0N4em1BKzlaa29IM0RTSCtOcGx1SzZsUko3MDlmSlJS?=
 =?utf-8?B?bE9Mc0hIWGFSdTBuOHk0dG5KZW1jUWlDTjFHZ1l0aStQRlN0UXFLNTNycHNW?=
 =?utf-8?B?L1NKRmV0dDBZMmMyYmgzRGhTeXdvdGY5QUUweUM3c28wcEM3bDZBVkJQbjNj?=
 =?utf-8?B?R0s4NmxoQlhoZ2p0d0VwY28xV214L3BteUdDUWZxMHZQQ3FxRllCRjY4azVN?=
 =?utf-8?B?RStwTXJSNG5tOXFQVGpXT05oWk5kK1lFR29iaEcrWUk1UWxtb0dkWEZmM01w?=
 =?utf-8?B?R1gzU0w1NXAvazZKRVl5TGVzUndvbExIYTc5WHlQd2daUUZsZnJXYy9tVjZB?=
 =?utf-8?B?K09RYUp0Q3AwSkhwSjc4aXJNcU5CZm1TNDRQc1d4eGZZV1VVaGZxQXlhMS9F?=
 =?utf-8?B?SlhSZGtlZWdrWkllZ3I1bUluR3o2aDlmSnM1VDllUExNQyswVGpLdVJJZlNy?=
 =?utf-8?B?OGlYc1dhV3dSMk15RzVsMGlUMnI3bHBOTDR5T3pHY0dDdFp1djBHOHRtUTBu?=
 =?utf-8?B?UkhDd1I5Wnh3bnN2WnRlNHo5QmxJQWRKSGJ3bE9BeEZuS2ZlUGoxM2FqaSs2?=
 =?utf-8?B?dS9HL0RxWnNZQTVxVkRUUnN6VWFMNkEvczNnK3NJSE9ZTUFhc3JUZWl4YUF1?=
 =?utf-8?B?eEVXdTJwc3hTclFlSHhlRmZWa1ZMSzZ4akZWU2hpTjI0MGlWcW90aWtFazVu?=
 =?utf-8?Q?IGJ+JmRy0YrJGWVmEJYD6sb6F?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c2b614-9eae-430c-33f6-08db737115b1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 22:36:13.7590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vT/jlVFQuadZpQ6JCCGTYjToLF5PZhfGEX6oJ2Oag2TUNc/NHm6Ir/BAxZUBvhosGENEsnzckboTFSk6Ou1ovA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5636
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
> The RCRB is extracted already during ACPI CEDT table parsing while the
> data of this is needed not earlier than dport creation. This
> implementation comes with drawbacks: During ACPI table scan there is
> already MMIO access including mapping and unmapping, but only ACPI
> data should be collected here. The collected data must be transferred
> through a couple of interfaces until it is finally consumed when
> creating the dport. This causes complex data structures and function
> interfaces. Additionally, RCRB parsing will be extended to also
> extract AER data, it would be much easier do this at a later point
> during port and dport creation when the data structures are available
> to hold that data.
> 
> To simplify all that, probe the RCRB at a later point during RCH
> downstream port creation. Change ACPI table parser to only extract the
> base address of either the component registers or the RCRB. Parse and
> extract the RCRB in devm_cxl_add_rch_dport().
> 
> This is in preparation to centralize all RCRB scanning.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/acpi.c      | 51 +++++++++++++++++------------------------
>   drivers/cxl/core/port.c | 21 +++++++++++++----
>   drivers/cxl/cxl.h       |  1 -
>   3 files changed, 37 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 7e1765b09e04..70cd9ac73a8b 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -372,21 +372,21 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>   	return 0;
>   }
>   
> +/* Note, @dev is used by mock_acpi_table_parse_cedt() */
>   struct cxl_chbs_context {
>   	struct device *dev;
>   	unsigned long long uid;
> -	resource_size_t rcrb;
> -	resource_size_t chbcr;
> +	resource_size_t base;
>   	u32 cxl_version;
>   };
>   
> -static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
> +static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
>   			 const unsigned long end)
>   {
>   	struct cxl_chbs_context *ctx = arg;
>   	struct acpi_cedt_chbs *chbs;
>   
> -	if (ctx->chbcr)
> +	if (ctx->base)
>   		return 0;
>   
>   	chbs = (struct acpi_cedt_chbs *) header;
> @@ -395,23 +395,16 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
>   		return 0;
>   
>   	ctx->cxl_version = chbs->cxl_version;
> -	ctx->rcrb = CXL_RESOURCE_NONE;
> -	ctx->chbcr = CXL_RESOURCE_NONE;
> +	ctx->base = CXL_RESOURCE_NONE;
>   
>   	if (!chbs->base)
>   		return 0;
>   
> -	if (chbs->cxl_version != ACPI_CEDT_CHBS_VERSION_CXL11) {
> -		ctx->chbcr = chbs->base;
> -		return 0;
> -	}
> -
> -	if (chbs->length != CXL_RCRB_SIZE)
> +	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
> +	    chbs->length != CXL_RCRB_SIZE)
>   		return 0;
>   
> -	ctx->rcrb = chbs->base;
> -	ctx->chbcr = cxl_rcrb_to_component(ctx->dev, chbs->base,
> -					   CXL_RCRB_DOWNSTREAM);
> +	ctx->base = chbs->base;
>   
>   	return 0;
>   }
> @@ -443,33 +436,31 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>   		.dev = match,
>   		.uid = uid,
>   	};
> -	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbcr, &ctx);
> +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs, &ctx);
>   
> -	if (!ctx.chbcr) {
> +	if (!ctx.base) {
>   		dev_warn(match, "No CHBS found for Host Bridge (UID %lld)\n",
>   			 uid);
>   		return 0;
>   	}
>   
> -	if (ctx.rcrb != CXL_RESOURCE_NONE)
> -		dev_dbg(match, "RCRB found for UID %lld: %pa\n", uid, &ctx.rcrb);
> -
> -	if (ctx.chbcr == CXL_RESOURCE_NONE) {
> -		dev_warn(match, "CHBCR invalid for Host Bridge (UID %lld)\n",
> +	if (ctx.base == CXL_RESOURCE_NONE) {
> +		dev_warn(match, "CHBS invalid for Host Bridge (UID %lld)\n",
>   			 uid);
>   		return 0;
>   	}
>   
> -	dev_dbg(match, "CHBCR found: %pa\n", &ctx.chbcr);
> -
>   	pci_root = acpi_pci_find_root(hb->handle);
>   	bridge = pci_root->bus->bridge;
> -	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11)
> -		dport = devm_cxl_add_rch_dport(root_port, bridge, uid,
> -					       ctx.chbcr, ctx.rcrb);
> -	else
> -		dport = devm_cxl_add_dport(root_port, bridge, uid,
> -					   ctx.chbcr);
> +
> +	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
> +		dev_dbg(match, "RCRB found for UID %lld: %pa\n", uid, &ctx.base);
> +		dport = devm_cxl_add_rch_dport(root_port, bridge, uid, ctx.base);
> +	} else {
> +		dev_dbg(match, "CHBCR found for UID %lld: %pa\n", uid, &ctx.base);
> +		dport = devm_cxl_add_dport(root_port, bridge, uid, ctx.base);
> +	}
> +
>   	if (IS_ERR(dport))
>   		return PTR_ERR(dport);
>   
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e7c284c890bc..1a3f8729a616 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -938,12 +938,25 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>   	if (!dport)
>   		return ERR_PTR(-ENOMEM);
>   
> +	if (rcrb != CXL_RESOURCE_NONE) {
> +		component_reg_phys = cxl_rcrb_to_component(dport_dev,
> +						rcrb, CXL_RCRB_DOWNSTREAM);
> +		if (component_reg_phys == CXL_RESOURCE_NONE) {
> +			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
> +			return ERR_PTR(-ENXIO);
> +		}
> +
> +		dport->rch = true;
> +	}
> +
> +	if (component_reg_phys != CXL_RESOURCE_NONE)
> +		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
> +			&component_reg_phys);
> +
>   	dport->dport = dport_dev;
>   	dport->port_id = port_id;
>   	dport->component_reg_phys = component_reg_phys;
>   	dport->port = port;
> -	if (rcrb != CXL_RESOURCE_NONE)
> -		dport->rch = true;
>   	dport->rcrb = rcrb;
>   
>   	cond_cxl_root_lock(port);
> @@ -1004,14 +1017,12 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, CXL);
>    * @port: the cxl_port that references this dport
>    * @dport_dev: firmware or PCI device representing the dport
>    * @port_id: identifier for this dport in a decoder's target list
> - * @component_reg_phys: optional location of CXL component registers
>    * @rcrb: mandatory location of a Root Complex Register Block
>    *
>    * See CXL 3.0 9.11.8 CXL Devices Attached to an RCH
>    */
>   struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>   					 struct device *dport_dev, int port_id,
> -					 resource_size_t component_reg_phys,
>   					 resource_size_t rcrb)
>   {
>   	struct cxl_dport *dport;
> @@ -1022,7 +1033,7 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>   	}
>   
>   	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
> -				     component_reg_phys, rcrb);
> +				     CXL_RESOURCE_NONE, rcrb);
>   	if (IS_ERR(dport)) {
>   		dev_dbg(dport_dev, "failed to add RCH dport to %s: %ld\n",
>   			dev_name(&port->dev), PTR_ERR(dport));
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f93a28538962..a5cd661face2 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -671,7 +671,6 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>   				     resource_size_t component_reg_phys);
>   struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>   					 struct device *dport_dev, int port_id,
> -					 resource_size_t component_reg_phys,
>   					 resource_size_t rcrb);
>   
>   struct cxl_decoder *to_cxl_decoder(struct device *dev);
