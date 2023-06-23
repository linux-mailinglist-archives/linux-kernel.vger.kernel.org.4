Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3772B73C3C4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjFWWHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFWWHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:07:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891C31739;
        Fri, 23 Jun 2023 15:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687558034; x=1719094034;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VzboMPv7/A6lpwb71kUTFUyfMsaQBVkJDRM191T611Y=;
  b=D3qeZmjlXckiZZpX8CrmTFFD7QYRTEmKgs3RElLehGpJwrHWCTfmi7Rr
   F3mmPxRUgyaFpqhveUGQuqLtEg3kexF7mYVMTk0xRIka9LT3L9UOvOC1m
   Iv/lZHYysNK1RgfGXC9Cfag94pZRLTqQg0mL11eVNbmBG1cC6VUNckGXG
   HDL2yBE/hbdvCiIxHCW2CCxLMlXYSs8cjIdHIRs9uBsrNhHTchl6o+rGq
   weqxkIFiIgjIlwyeCskY3FhLsZxph0kwCJvObVACQWqzEu/2xh7IVGXjR
   CZOalFbIvi9DVjIE96Cd2+atCZq8ViOVG0E/ICFFIfkkENXryfMsxKxIx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="363424532"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="363424532"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 15:07:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="665637573"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="665637573"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 23 Jun 2023 15:07:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 15:07:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 15:07:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 15:07:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 15:07:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Esmkf8gkexIfmb14/TC4dn1QQpgabT61PJvDeAZXMlzd3uO0G3F8VRql9MCI0hQJzJJCNriEX3nXUnUy4VZHT77U4jR4TFdhu5kdaP2W2PCpAGr+R5nq1j/eqTpbi9hnjdRIuP1s9oX41iwG26WbZrrOhXM8jGvdxNNoOl1jLxC2Xd2SAsdr47tYlxCKDLu68/ynQMhdjJ7dMYBckEYs+FfkRI7tKcUHHOUCpuM8RwFAWsJLNeOf9lItccYaOjKIOnsYUAZrOHdwMqDGWIzz905pmv3T8+rA6PhotG7Czvps6UNa4f9s7rIZr9MoPsZ74fhTzLoc7aXf5inE1YIcsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4Z7WfRp+YXSTi1cNZbkJD9z0pULO/mAb6LvUWM5FsA=;
 b=hHF37aI5og8Zhfj+DTApuADYnOyLZKhhmDediKHKTj8VdaqBXVl+MuOd3efR0dDABPd7U5o8AW/8BRns+p2Um7GcgCJgHxVdcTvltbCRoe4Qtfw3bT/3HXBgBYiLT4hHi8jDS3bOKzroG9dFRjd5nuCS8xeI1cP+vslM/N32FCflsUyrzr+9gJxGg0uG0tFJYeULA30t2krB8tuT1XA3QxIuxHRMvmWtxwOaJcRuODYM3DLTZRuGAnVNIPg+dCdRO5Q+pfFuaa65nWZoe4Z+PvLluULl0IpB9kSj/v4cM7NCWam5meN18DgmSq5W8avLxIcJsp3ndYphEmETD1MjHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by MW3PR11MB4714.namprd11.prod.outlook.com (2603:10b6:303:5d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 22:07:05 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 22:07:05 +0000
Message-ID: <9c54d736-1f4f-3c5b-d013-3812f5a0263d@intel.com>
Date:   Fri, 23 Jun 2023 15:07:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v7 23/27] cxl/pci: Add RCH downstream port error logging
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622205523.85375-1-terry.bowman@amd.com>
 <20230622205523.85375-24-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622205523.85375-24-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::24) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|MW3PR11MB4714:EE_
X-MS-Office365-Filtering-Correlation-Id: b46bb980-3d63-4f7d-3470-08db74362df1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AIJyAalwxdiWy7x1pF7VC968JetnU6ZIenbK38vfpSDUI59eED4eabVWAlm4WVw8bAqUnBUkl1ifgrxGWpxir/KRtLcyqqlknXds4ytVzIMwWr8quB0ElO1/g4kk/vnMz7BJ1+N23zWehFdbqpGREaxmh8BJG2iQsOiopAkgxTnIAUkLvYfokNTKAQcuXoFdEodhXDRfM1nz24lU7xB5poalY3Ey5lby6KlITvRID6CZVtKURdXgYdVUGlM6p1G0DjwbSGLWXdN28vxdE5ZwFelz/Yqn/gWWIheFWnIBxTgr5bJEVovMMDp+bPNpWbuL9a4HtKmd92HrEIc0HpkK27VjH+cARaFBhXynQr5ZGBJ3MopcOUylfBZCvdMMvPFQdY6LTb639xjzr1T8oZME3O6uLC2g7uSjSSMhmgMVKQwzSLHKYX04dNqIaTq9Edh6+hEFW7jPMG8NbmXgmmbnYNKKZe7DTA9r01sjptBx4oBLA23eR6LneOkoWsro31edPJXNy6m81Ajz6Evn79PYO/zBh8AA5A3+vBCqyDFOCaYJSaGSSGyzzQeLXe3Xhl476x941pxy5gFtmvLukY9FN4KfOQ8D46LTzLR5xWp8ZAk0wkgoV7C8+2r2aYeLn32qNDpOU7rAOP4U66GMmivq1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199021)(53546011)(4326008)(186003)(26005)(6512007)(6506007)(31686004)(478600001)(2906002)(44832011)(8936002)(8676002)(31696002)(86362001)(82960400001)(41300700001)(2616005)(36756003)(38100700002)(316002)(6486002)(6666004)(5660300002)(83380400001)(66476007)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1MydnFjUElvNFFuZEdDQWpFcGJSYnJMN0VGWHp0S1gxVWdsQ0lGRW42d0RV?=
 =?utf-8?B?WWx0L2hQeGEzdTN3eWRoR2J1NmdpRUthYWhrVVcrYTVsY2ZSdDM4WHQ1T09N?=
 =?utf-8?B?d3JWM1FiQStya2JVTjhIZlNkaUZWeWVMb2lWRW9oOXU5b1AvUlY4bTJPUk5r?=
 =?utf-8?B?TitFM3NhcWFQak15Nkl2NG4vcU1xV1c1blFlaHBRdE1jbTIyMGZOTDNYaVBT?=
 =?utf-8?B?TXRZRE02eHMzaFRqekFmTno3c3VCNHhmY1g4UllmSi9xMlZ4UlI2QnQwZlV4?=
 =?utf-8?B?MFNhT0xJYk1zY1JkYUE3M1RVR0U5RlVvaVJvekdOS2ZWcTYvZGRDN0F6TWZS?=
 =?utf-8?B?RkprZG53N2Z2RzVzdEU1bmFnRE9uQVlKR0dkVlVCL2hXYzVoWjlYQUVoK2Vz?=
 =?utf-8?B?bzVadllBOXNtUzRqTngwQWV3RFdEVW1XZnBlcU9LdFRxTWtqS25iZGNLcE4r?=
 =?utf-8?B?NGtuTFZkVXZaL2RQZE15OUxTZ0dSN1pocWVXM3dtZSt1TDR3ejFFd09ueDF4?=
 =?utf-8?B?c1pkWGsrQm9XempSaXdUcE91d0R0VE9UOGFvUHZvV3NYMHVZallyWnh3N1dT?=
 =?utf-8?B?bEZpSVZWcGkxTWRpNXJaZ3VsVUx5Q1NTeDNqZ2Qzb2hRVW51THdSWGtlbG4v?=
 =?utf-8?B?VGtUNE90eXJyTEtCMm43WGVoenJqWE96NytsdUh6VXJ3RHNObXFvYUFHaURk?=
 =?utf-8?B?WEJTODJZTHBNVDBndnBZcG1PRXJRVnllanBSTE1RSEVocUxuUER1ZVNIWDRQ?=
 =?utf-8?B?aUlmd2pDQ0RlcGNYN0ZTcVdnTEhoYW11ZDdDUlc5aHB0SHVJZS9PcWVGeWR3?=
 =?utf-8?B?Yy95eUFxOExPR2VkNjBGbFJmTWR0aVl0T0MzQStWTzI5eDdzOWhsYzJIclR6?=
 =?utf-8?B?WHY5MmVCczBZOElmY0lmbGhmWmRLUGxHZkNTNGdqSXc0d3pOeUowNEV2S0ov?=
 =?utf-8?B?V2hjSVFnWkpQYmxOMlZjYlZnV0JzajR3alNIamFnT1Z6bXgyeHF3SlpFdEdh?=
 =?utf-8?B?WDNlZWUxcjFsdmVuem1zaGRJa0l2bDVNWE5iU3VDSFFST2ZPbXFZNjE3VUlC?=
 =?utf-8?B?R3NhMUZYTWFoVnRuYXZBZzkwYk55enJiTlhWaHlKS3RyNkxUaTNTVzNkdkZK?=
 =?utf-8?B?WXowZXYzRjYyNk5ORHZucWdzc2doNmc2LzlxdU0weURPRGx4aEdycXVpQ2R0?=
 =?utf-8?B?VkJYa040c0RjWjFZeE9IaVB6ay9DV24vMUhLWWhxNTJ1RGVpQXZUSlVvOXF3?=
 =?utf-8?B?c0dXNVg0TzFyZ01NNFZWNndWQkRTeGh0dG1tSitpMVJLR2llRDdUMHdSRXhu?=
 =?utf-8?B?anRVYStFeDV4NWxoSDhqR2xuSGl2OTlWOHAvL2FsU2ptVllESVI3SXkzY29N?=
 =?utf-8?B?b3VQMHhjZmZTSmxRTUNVMFFMcnRxK1NTdWJxWUFrVFdveGY0Z29YQmRZSFF0?=
 =?utf-8?B?M0RLd25JZzBEek5Wdm9vWjZKcllzMXI2UTRSOFltdmRoK25nS2lZRWhnUDlZ?=
 =?utf-8?B?RGs1ZXR5andrQk83WEEwbnpYRnFLTWh2Q2FLemtzL3BtU3NhdnpLSUVHaFl4?=
 =?utf-8?B?VDF4OVZLa1cxOXkweXd2QnB1MDl1ancrai80K2Y5ak1uSEZxMFk4Z1Qwc1dT?=
 =?utf-8?B?SG9JVHZJQ2FUL2M1TmFZM3AvOFVTemRMdStFczlGOHBJNFdDdDFpeXNuU3dK?=
 =?utf-8?B?c0VtZFFHMGNPbDB2VFdROXlLRlI1Q2tkZUUxVFhJTjhiV1F0Y1J6anJLakJr?=
 =?utf-8?B?dytvcXZKMVdxemIzbXAxQ3pxckZKOGk3eG5lNVlUOGxSQ0I5ME9OTFZreXQ2?=
 =?utf-8?B?ZjBFV0lxZnphQm9QSFlMTGc5UXBFWC9pU1RZZHVHYkxYQy93QVBDcFd5U0wy?=
 =?utf-8?B?bXlIeHYvVDJhQ2ZUc0dLd0hrYVlvUXhhSE8wZWtkbDc2K0VySVZ2b0dGWUpL?=
 =?utf-8?B?UG9DaHlRNTIwY1dNVWVKOGNuWjN4T0xiRjVXMXd2M0haaTduOFpUeTNyb0FL?=
 =?utf-8?B?YS9iMHBiVVlNMFVCcFI2dHFzREQyaGlvR1FQYTdrSnZtNGJ3SXRwZlZscWxN?=
 =?utf-8?B?OURZdkxOS3RFbXJjOGR4eVhGa2djdXpxUVdBOEdPRmRCQngyWG1yYUZqRzJP?=
 =?utf-8?B?ejloOVRjZG1UTVA2Q3BIQ0xscmFGWHJCVnc1dGNFRG1nNUNzcEpIei92eUd1?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b46bb980-3d63-4f7d-3470-08db74362df1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 22:07:05.2512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOV4Oazs+1h5mK9f1aZhTLb1ZrU6CQGK0tsmw6ApbwstxlD13bJPn4lfByzIGOLOjUrbI0PfVx+YAIOgVOGbTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4714
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



On 6/22/23 13:55, Terry Bowman wrote:
> RCH downstream port error logging is missing in the current CXL driver. The
> missing AER and RAS error logging is needed for communicating driver error
> details to userspace. Update the driver to include PCIe AER and CXL RAS
> error logging.
> 
> Add RCH downstream port error handling into the existing RCiEP handler.
> The downstream port error handler is added to the RCiEP error handler
> because the downstream port is implemented in a RCRB, is not PCI
> enumerable, and as a result is not directly accessible to the PCI AER
> root port driver. The AER root port driver calls the RCiEP handler for
> handling RCD errors and RCH downstream port protocol errors.
> 
> Update existing RCiEP correctable and uncorrectable handlers to also call
> the RCH handler. The RCH handler will read the RCH AER registers, check for
> error severity, and if an error exists will log using an existing kernel
> AER trace routine. The RCH handler will also log downstream port RAS errors
> if they exist.
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/pci.c | 101 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 101 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9cb39835e154..9e0eba5ccfc4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -5,6 +5,7 @@
>   #include <linux/delay.h>
>   #include <linux/pci.h>
>   #include <linux/pci-doe.h>
> +#include <linux/aer.h>
>   #include <cxlpci.h>
>   #include <cxlmem.h>
>   #include <cxl.h>
> @@ -747,10 +748,107 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>   	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
>   }
>   
> +#ifdef CONFIG_PCIEAER_CXL
> +
> +static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
> +					  struct cxl_dport *dport)
> +{
> +	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
> +}
> +
> +static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
> +				       struct cxl_dport *dport)
> +{
> +	return __cxl_handle_ras(cxlds, dport->regs.ras);
> +}
> +
> +/*
> + * Copy the AER capability registers using 32 bit read accesses.
> + * This is necessary because RCRB AER capability is MMIO mapped. Clear the
> + * status after copying.
> + *
> + * @aer_base: base address of AER capability block in RCRB
> + * @aer_regs: destination for copying AER capability
> + */
> +static bool cxl_rch_get_aer_info(void __iomem *aer_base,
> +				 struct aer_capability_regs *aer_regs)
> +{
> +	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
> +	u32 *aer_regs_buf = (u32 *)aer_regs;
> +	int n;
> +
> +	if (!aer_base)
> +		return false;
> +
> +	/* Use readl() to guarantee 32-bit accesses */
> +	for (n = 0; n < read_cnt; n++)
> +		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
> +
> +	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
> +	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
> +
> +	return true;
> +}
> +
> +/* Get AER severity. Return false if there is no error. */
> +static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
> +				     int *severity)
> +{
> +	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
> +		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
> +			*severity = AER_FATAL;
> +		else
> +			*severity = AER_NONFATAL;
> +		return true;
> +	}
> +
> +	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
> +		*severity = AER_CORRECTABLE;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct aer_capability_regs aer_regs;
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
> +	int severity;
> +
> +	port = cxl_pci_find_port(pdev, &dport);
> +	if (!port)
> +		return;
> +
> +	put_device(&port->dev);
> +
> +	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
> +		return;
> +
> +	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
> +		return;
> +
> +	pci_print_aer(pdev, severity, &aer_regs);
> +
> +	if (severity == AER_CORRECTABLE)
> +		cxl_handle_rdport_cor_ras(cxlds, dport);
> +	else
> +		cxl_handle_rdport_ras(cxlds, dport);
> +}
> +
> +#else
> +static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
> +#endif
> +
>   void cxl_cor_error_detected(struct pci_dev *pdev)
>   {
>   	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>   
> +	if (cxlds->rcd)
> +		cxl_handle_rdport_errors(cxlds);
> +
>   	cxl_handle_endpoint_cor_ras(cxlds);
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
> @@ -763,6 +861,9 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>   	struct device *dev = &cxlmd->dev;
>   	bool ue;
>   
> +	if (cxlds->rcd)
> +		cxl_handle_rdport_errors(cxlds);
> +
>   	/*
>   	 * A frozen channel indicates an impending reset which is fatal to
>   	 * CXL.mem operation, and will likely crash the system. On the off
