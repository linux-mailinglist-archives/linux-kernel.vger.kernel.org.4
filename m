Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E05473C316
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjFWVnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjFWVno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:43:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3072CEA;
        Fri, 23 Jun 2023 14:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687556621; x=1719092621;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FDcIfeltNVxguts9bYEvGGKgkSVWbosLV3riu0/l00A=;
  b=Sh4YEvvYT08CU8ks+KQdPPBs1g5mNqdreaTkSjefTARVfYfi6QZwabi4
   AISL3D3wmryBtJBlxzDD2Zoe5tmMRN4my3lt1ruwgthOVoBzxrJbYADxB
   583OE/mZ+FeBAvPnZFs0qWdOwkpLhS/khlJvbmP2XBUFJ7xUJTTVvYNsg
   5I+PukIhjWuThmmfh+pg26bGzyMU/7zoTNlBMcaw1Vpe9LR/ZWFJ8DrNi
   pYcldzMBL0p5dUM+7/zC5D3oWj21cjTIzDmoXvUl90RMRjbbmmxLyA72K
   FUkZB456ADwOmPHMyhQInJP0rw8PyDDH4tDd3c3KFuiZ3peD+YnDMxC7u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="359734355"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="359734355"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 14:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="785482750"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="785482750"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jun 2023 14:43:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 14:43:40 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 14:43:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 23 Jun 2023 14:43:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 14:43:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0LRQuW1W+5X5bt1FKx6yVr4Qp7orGuXiAJmTyQgs4MaeS+O2zPvJ6q063sgwjrso1bW8xe/ZN8YBjM/Z9uzz39bdGCgf0u36P0CuVCfO1ZOH1dNvpXmZwzGCX5jh+tRvLXl63kh3hb82O41Ferz3DPtVYcIo/LyGxBtXYvRZ4woXvxHYYxJ3lVbahTsypzrJlNgUwftslBkd+eashlNQrTudk+hYr567KMIvZtRgE+7UeUzhbzDP8fQnUH3TpKzl2LPVWbCOqvHksLTAS/YpD3AHH8sTC1dax8EJh+IcryqX3W1JfwPTnan04xBdezk2GFuWQnbvC8LgLl3FWholg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3jqY6OelhBCC1ZHVmTmWUr7OzDnh9+i6tkpDy+0LYI=;
 b=HnB7gply3j2435kHzxiJ+/qUKU+8QUbC/UZ5Rx+oV0XQz58GXiAkUzBmGcGfR7qC0BysHLAm651zlDQhKpXnmtZ22SqZx7W8Cw/sl6F0SYpGWIZk4cyuFSQNBkkFycpXuLtVHPJhTHiP4UlruNP3PnMDk7Fw5JvnybUB8Uaq35rjyoV5sp/VhxmODHh8HMQpvsQaWyRuhzzIqK96X5sVFYAFVxvw4bzjN+zAOn/gucXAzJOezqc1w1FDvPBliyS6/0gLF1u1zULSXLtBgJp0ENK+udG09MiHOL9xFPuNtMNb4GM142cIqQQVnE/dQRc0nIQAKUjlEQNzwjpT3ldEww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CO1PR11MB4980.namprd11.prod.outlook.com (2603:10b6:303:98::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 21:43:35 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 21:43:35 +0000
Message-ID: <c6e238ed-e60b-86f7-0c41-26318d4d63c3@intel.com>
Date:   Fri, 23 Jun 2023 14:43:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v7 21/27] cxl/pci: Update CXL error logging to use RAS
 register address
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622205523.85375-1-terry.bowman@amd.com>
 <20230622205523.85375-22-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622205523.85375-22-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0061.namprd17.prod.outlook.com
 (2603:10b6:a03:167::38) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CO1PR11MB4980:EE_
X-MS-Office365-Filtering-Correlation-Id: 14644eb4-0ab0-41aa-3aa6-08db7432e531
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rK2sGUYuhBGwM0kmjazMjs5PUw1/BGfyRCRa9aFSEhenTEfWQ+Qfkz+jM2S6R/ydmJCpoPY5ivpLXmrqSU1eudJEwzvspe+y6a6EpfUhlz6g2n2UJNcF7Q3O56HaOj+Xv61ppALTjHL//wtEJ4Vork5figfY5g/OXFbzTXA538ywuNNOaIiL0s5Q2bGOH4BIaai5dnCxex+Dj+8O8up13qf08nbfNOK2eN42x3+PzFf6xC9CcF8An2t/nHCp7nXWDbJNnn7WLSlSwy9ecPuwD7WNYvR6l0WAwC/8/khUfhCqTsnZMgxYHub19umYJo4t3p7pj16NaMJYIOjlyL/23VGOqBOGvSVgD2kYMMBQeTuzpUp4oH5oa8pMe21roniw/VO1LsDvIji5LAE8+YSVR7y8qbSkbF1U/Jmm9fmAnh3wr4Gw5lH6MaC8pXTatjElJxZJldiOWfdLtEpW0abhN8tmPgmB+5UpLuf+gRGkFCrnbJ66L/8yUudzZqIE7Oup43cEuocLn4b87dz4NZlNWi2ACuF5JV2MKCvVuB640N3GDoVvJLaH+Zck3tTd07NbKAU+ZT2pq/MCKMqznTtZdXawcBiGvOzPU0sV/J2EytRSr5TcBuMbtgeei2zlK3FKN9+JRV4uniNVvmRhDW41Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(31696002)(86362001)(2616005)(6506007)(38100700002)(8676002)(478600001)(316002)(66476007)(8936002)(66556008)(66946007)(44832011)(15650500001)(41300700001)(83380400001)(6486002)(5660300002)(53546011)(6666004)(6512007)(4326008)(26005)(82960400001)(186003)(2906002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enpoNDQwSzlONVovY1Y1R3VaV2tDaEpSOFRtYnc5WHNMVmpia0UxY0FubXNW?=
 =?utf-8?B?NUtibXlpZGlvMXdna2c3azVnQXlXVDNINEl3UUxjUHdhLzZBT2tIb2htMWFm?=
 =?utf-8?B?MmYxdDJFOTF5ckcxN21EVGRCNDVjNzcwR2xiVkJOdWkrc1JjRzk4bmhEbTRT?=
 =?utf-8?B?ZjJzbmllWk9ZU3Bkc2lRdlhXQ04wWnVKU0pBZW0wbWJlWjhxK3p6cU0vVSt1?=
 =?utf-8?B?SHJ0L3ZNbFlRT016UUFBZmMyU1p3TnF4bEhxMmtaMkppMWpkNmhoU3NRdE1l?=
 =?utf-8?B?d2VIektGNll6b2NQbWZqbEhiL3A2S015dUFrNjIrajBqZlppMVNHZmJxM0FY?=
 =?utf-8?B?MUY4cXRMYjdrMFdzUDdmNGFKZHZpUlRFakVoa0d2VnZsdW5TTytESjBxQVpO?=
 =?utf-8?B?VHZFMU1MdjJpMXUveHk1cU0vdDNGZURacUoyUnFsN3NtUHBDdXBGbXo0VExi?=
 =?utf-8?B?Yk9IYml3c3BBTDd6WllPN3ZES0dzS1lRMEtQaDNGRHVnQWJhOFJpcW1qMDV3?=
 =?utf-8?B?aGIyQ1cyYmFmeGJ5QTRkZVZMNnZKVnNWVWVkQWF6VGFoL0NyT205OUtPQXBn?=
 =?utf-8?B?Q3Z4YWJjc3lEdWVaVEVCOFFDV3F6NzVEbHVCK1QwK1p6ZG0zK1djb2ZSWC8r?=
 =?utf-8?B?ZEgyczJFemhmTnd4TFF4YkdiVnpWeDJnR2lPSjgrSjBJVUVGcWZtQUVWSjQ5?=
 =?utf-8?B?UW1WVjBmaWNRdmZuUW5pUDJhQlA3TVRneXVWanpOcnVqSEZZYnZLM3NDSzg0?=
 =?utf-8?B?bUh0YThwelZRT3Y0R1ZjR2tLTlBWTlplQkFMNkxWZFh3NlhPcEZZdmcydTRK?=
 =?utf-8?B?MDE0RFgwNDd6c0hyYW5yZzJ5YW56cEU4ZHFQa2F0V2RHUEVXVWZPTitadXZv?=
 =?utf-8?B?amRVU2VXcGdIaVhhL3dzMExpbkxPTVh1dlZWRkxzdkJ1U3NxQUs5dXhWd2JD?=
 =?utf-8?B?RmI5YjBSN2wyN1p3WHoybVZwdGN1ZUQzZW9Ed1o2bU8vUGNhdFpVMS9OVWVX?=
 =?utf-8?B?ektpTmFLQzRFcUo3YXU2RWs0eW43ZjNlVTVTMkhMUmU4ZVF0eFJsV09UVFBx?=
 =?utf-8?B?dWlERkc1YXJBb0RLUlZvN3RmOWxDb013NFN1Mm1rcG5HbnRjTlNacFE2ZXpY?=
 =?utf-8?B?VEVKZ2pURm1lb0VvVzg5VzVrRC9hZ2l6bW1YcndsWU5YVktKZE9wSHJ2aEVs?=
 =?utf-8?B?QTgrZFNWSFVLTERQSENNbzdUSGVDUE81M0N6REhvWG9yeUVPcFdCejJLbUZ3?=
 =?utf-8?B?K2w4eDdhV2ZYMEpOQ29Za2tER2RPS1B1ZEFicEdNNm5BNjJPY2lnRFNQNWcy?=
 =?utf-8?B?VGpYRmk3UnRPQnV6OXRzcXgxejVWSUQ3bTd2anAxVHQzREZVd28wcVY2NUpn?=
 =?utf-8?B?SmEwNXFYNWlrRkUxUndKN1BoUlkxSGppSTZGYzlUVFM1OHNJQWNKbUdhd2pH?=
 =?utf-8?B?T1dVU2tFOUdVMENLaFV0bGVEc0dWSHNRS2JjeDc3NndJdzlDL0FxRXhsN2NH?=
 =?utf-8?B?L2F6a3BVazdRVGJ0cFV4ZUVURU5MeHlBdUQzWlR1Z3B4dlNON3I0TWNQZHhB?=
 =?utf-8?B?K2xnNk9LcUNGcCtCTDl0OENMTXJ0N1pYWDFvZUY2NWdWWVlCYU5FTnNSN3p1?=
 =?utf-8?B?ai9iYWE1NTVzUWRmLzhiYTU1M1llTXlBdDJRZWZlOTVDL2JKU293cXNMM1Vi?=
 =?utf-8?B?YXJWZ2V3dFFjV2FyYUpDT0ZHRXJiVjdhL01RZERTbXptdG91cXM2a1NUVVVE?=
 =?utf-8?B?QUZXenFuT2lGUXBMYk9zeGFPSDZRa2JTWnRadElZekJiWTB3c0FpOEtLYzM1?=
 =?utf-8?B?SEFOSlYzcHM0MTlVbCtwd3FwMkxHOW5Gd3FjRVZ6OGZyRGlFeVRIMHRGTG56?=
 =?utf-8?B?YlZLZ0FhREd3bVNER0M3alV6VGtsU1NMcVFubEFUVEo2VEhJN1BoODhkRUJU?=
 =?utf-8?B?NkdJRFkrVmhKVXl1QkZnZjNQS05ac3VvVlZhaUhFZlRCSzR5T0ZkUitUR0p4?=
 =?utf-8?B?NjZKUW40Wmx1WFptemlNY01wSVgrT0ZXZUZyWEttTks0V3JjYW9EVUxvUjgy?=
 =?utf-8?B?N1hWMW90U0FwaFpBVllKNk5iQk5WaXpTdzRXcWVyUDdzd2lUSktVUFkvalRQ?=
 =?utf-8?B?ZmVXNWgrSURyL21oU0VVQy9kMHZvd3JGdkRFaTFSYTdNY0U3Qnp6dXBRT2xo?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14644eb4-0ab0-41aa-3aa6-08db7432e531
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 21:43:34.8838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAhb/vWjXYAxSa2/qO4s33EfMlhS1OO9gavhxPHK02sS25k4w8iQm08WCjBIqii2Adta8F+KtUSTH0fxprhhPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4980
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/23 13:55, Terry Bowman wrote:
> The CXL error handler currently only logs endpoint RAS status. The CXL
> topology includes several components providing RAS details to be logged
> during error handling.[1] Update the current handler's RAS logging to use a
> RAS register address. Also, update the error handler function names to be
> consistent with correctable and uncorrecable RAS. This will allow for

s/uncorrecable/uncorrectable/

> adding support to log other CXL component's RAS details in the future.
> 
> [1] CXL3.0 Table 8-22 CXL_Capability_ID Assignment
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/pci.c | 44 +++++++++++++++++++++++++++++-------------
>   1 file changed, 31 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 375f01c6cad6..9cb39835e154 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -665,32 +665,36 @@ void read_cdat_data(struct cxl_port *port)
>   }
>   EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>   
> -void cxl_cor_error_detected(struct pci_dev *pdev)
> +static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
> +				 void __iomem *ras_base)
>   {
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>   	void __iomem *addr;
>   	u32 status;
>   
> -	if (!cxlds->regs.ras)
> +	if (!ras_base)
>   		return;
>   
> -	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
> +	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>   	status = readl(addr);
>   	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>   		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>   		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
>   	}
>   }
> -EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
> +
> +static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
> +{
> +	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
> +}
>   
>   /* CXL spec rev3.0 8.2.4.16.1 */
> -static void header_log_copy(struct cxl_dev_state *cxlds, u32 *log)
> +static void header_log_copy(void __iomem *ras_base, u32 *log)
>   {
>   	void __iomem *addr;
>   	u32 *log_addr;
>   	int i, log_u32_size = CXL_HEADERLOG_SIZE / sizeof(u32);
>   
> -	addr = cxlds->regs.ras + CXL_RAS_HEADER_LOG_OFFSET;
> +	addr = ras_base + CXL_RAS_HEADER_LOG_OFFSET;
>   	log_addr = log;
>   
>   	for (i = 0; i < log_u32_size; i++) {
> @@ -704,17 +708,18 @@ static void header_log_copy(struct cxl_dev_state *cxlds, u32 *log)
>    * Log the state of the RAS status registers and prepare them to log the
>    * next error status. Return 1 if reset needed.
>    */
> -static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
> +static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
> +				  void __iomem *ras_base)
>   {
>   	u32 hl[CXL_HEADERLOG_SIZE_U32];
>   	void __iomem *addr;
>   	u32 status;
>   	u32 fe;
>   
> -	if (!cxlds->regs.ras)
> +	if (!ras_base)
>   		return false;
>   
> -	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
> +	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>   	status = readl(addr);
>   	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
>   		return false;
> @@ -722,7 +727,7 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>   	/* If multiple errors, log header points to first error from ctrl reg */
>   	if (hweight32(status) > 1) {
>   		void __iomem *rcc_addr =
> -			cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
> +			ras_base + CXL_RAS_CAP_CONTROL_OFFSET;
>   
>   		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
>   				   readl(rcc_addr)));
> @@ -730,13 +735,26 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>   		fe = status;
>   	}
>   
> -	header_log_copy(cxlds, hl);
> +	header_log_copy(ras_base, hl);
>   	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
>   	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>   
>   	return true;
>   }
>   
> +static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
> +{
> +	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
> +}
> +
> +void cxl_cor_error_detected(struct pci_dev *pdev)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +
> +	cxl_handle_endpoint_cor_ras(cxlds);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
> +
>   pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>   				    pci_channel_state_t state)
>   {
> @@ -751,7 +769,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>   	 * chance the situation is recoverable dump the status of the RAS
>   	 * capability registers and bounce the active state of the memdev.
>   	 */
> -	ue = cxl_report_and_clear(cxlds);
> +	ue = cxl_handle_endpoint_ras(cxlds);
>   
>   	switch (state) {
>   	case pci_channel_io_normal:
