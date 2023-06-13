Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C73372EB24
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjFMSl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFMSlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:41:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21221BD7;
        Tue, 13 Jun 2023 11:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686681682; x=1718217682;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C/Ua8+4m9rk1mBp1BjxPCIcNgOHTpB1d+UNQ6aiDKH0=;
  b=AdJBtxw3EFIO4W4ycmf24Fz2FI6X5ja7v2tkqRHgkFDysKUrm/JpisC+
   Ho5BJdqHO8eCpOC+qqJ7qnfj2IvlVQTCcWKlX4HVPCg+VndMzJKjL2kVL
   WcBZp5qtk0D6uvTdEF7IRhVIw29WxZDlFqvGSpdjRk+kurSJvNITRuNMB
   DYYmeU0qHBPFdY+Ln7RrGla+PkZIltrVxeSp/U+iaDeYfL6z5Z2pBiYxy
   ARrb+N4ye4wtq1xi3Tr1j0mwbX76rYWbAwkj7O/VM5ac/l7MIj1YzuuUq
   jlAUC5l//SR4OpiHj6nNoy4pEhTuyN74cMgmEyT14hK3O0KLCrSm2Xy9m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="360907650"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="360907650"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 11:41:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711759973"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="711759973"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2023 11:41:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 11:41:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 11:41:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 11:41:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 11:41:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cY0T3XyaCgGm/5T7b+FrxxDhf/1QUmW+pu8XjGDb6bJqIVMMwnQ8DsAAF5HspA7t5zjS056rxyn9sstzy3PIXEtVyEKPq/fQNOlWEhzj/7uXoESREvFYVTaKe9UjYoFhAEF8Ydbc8FNesfB8rJ6af7l+e/tCIB8sCBLJ8feUfm7r+Hu6wl7NE0C4nqV5JrklFhLVBhZhQsN4i31PMw/mKcCCNFNJ0g80VBNrjNutcLvf+K/crwtiLkqgNWFClrLbG3Yp6aLprjlLVcFKrXp7bBLpj2VvxXad2EtSryjzWN1r1NnT+j3Z2CJQeHObLiPWniJhOJC8d8YFY8n5gZcdGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0F/zqi80BHc1CmkML0Bk88Prqb/Jqlx2o9ru4hFq9U=;
 b=KTVOArU6HTl3Wr8Evyy4Y0f2GV296hBRgUm16ZB/QrLdzeLhyV7EIGKLVWP5+6WIus4asC3iPoAyz4+KWiQWwpZK0IV/cPgqgHBFy652deXyrrB4Md7XWXzlkvkbHvjLg4FNJPKSWXkINpa234/Sm1JaicU0JwFUh/eTBDHqpkez3MArfsky8M9onOB9x/xp8e1LjFx4Tcxc7NvLHrlYnHftC+VeVqOwdbk9+1XU9q88jVZ5QvCEC+mqRURwePc+TTJ+y/MM6ltEmdnnf6T3v/c04GhlNKKhQJmVDwlcIBiA/IOufk9doL02vq1Ncvmg/mXz0Kk8fc4hqcmnnJ1BaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CH0PR11MB5538.namprd11.prod.outlook.com (2603:10b6:610:d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 18:41:17 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 18:41:17 +0000
Message-ID: <3093d78c-6edc-4b87-f5f4-cddb84999f2e@intel.com>
Date:   Tue, 13 Jun 2023 11:41:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v3 4/4] tools/testing/cxl: add firmware update emulation
 to CXL memdevs
To:     Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Russ Weight <russell.h.weight@intel.com>
References: <20230602-vv-fw_update-v3-0-869f82069c95@intel.com>
 <20230602-vv-fw_update-v3-4-869f82069c95@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230602-vv-fw_update-v3-4-869f82069c95@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0130.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::15) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CH0PR11MB5538:EE_
X-MS-Office365-Filtering-Correlation-Id: f7285cd2-d509-436c-35b2-08db6c3dc609
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkKyUYbWtbSlcVUz5MF8/Yf6jtxCnoNcwCt9KUHadcd8qI+ID5mCuFyGRpvl5xEY8T0XmCosT4U5ugnsWlxAWZeJRsl8bl5/AhjqPimzz4QC+2dRFlLApyrRKiqqw+UpF60lfBCX/DkZtg9OPoW+zMxOkhyhoro3iMdZXoYZkyoLloEqSODc6EtnVssLfh3muZWhMT+suq4u5qak6wrK0TUHKZgezjX0M92y6ZZAFy2CH0kRfIYv25GMq5IGdE7GbKjiusoZOwfqC5KUKMq3/4xvpQoiBwJkNjNGeqBduhpf2xl23AVfFvJPr8fyGPYeZHl4Za3JwxZTL9ZQwnym86DbJe5/85VupC/xYWIUyIB49G0kWlfi7dDrg06Y+2iRyKCuwsmGpfC8XraGdmTKjGX22gyVyquVfQ2RGLSRDmpgd+Ce5glFF6Ytd1gLm1H34F5QZ82C6QjgZSz3eAINCXtTqpNqRb50VbzXO7nTO2BMC4W5H2drlDZxIEjYat9AEg90w4xxHzI1dnWVdhlWHcpYGK2IYiQtH1FL5tsssAky1qquXFlFD+b2TAN7+JcpzbK5+mb2GNmbyHaXxzqcVvKblRooEFcMH20v4xy76ydbumtDr+EhZVylgojJnTukBmAbhRFrlgYA06PRFzie6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199021)(66556008)(66946007)(66476007)(8676002)(8936002)(5660300002)(31686004)(478600001)(6636002)(4326008)(54906003)(110136005)(6666004)(36756003)(316002)(2616005)(6486002)(41300700001)(38100700002)(82960400001)(44832011)(186003)(6512007)(26005)(53546011)(6506007)(107886003)(86362001)(83380400001)(31696002)(2906002)(15650500001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWJZa0F5QXd1bWxlQkorSExEbG50eTZZV1RrT25YSE9LWmN4ajdLRlJOb0g4?=
 =?utf-8?B?bVB6QW9NTU9GSjlDdXd0dFN3MURUSTg2SnRaQ2xqZnhXcXBYUEd6T3A2UW1p?=
 =?utf-8?B?VS9jeER6c25rNjF0REdtbURtK21vQVpJUGxaeUdEbTB3Y2FMWGcrOUpVK0o2?=
 =?utf-8?B?ajVsdGp1NHRySC9zNmdsV3VWK0Q3S1V4U05IVVRiZW44TGxXRVR4aHFEOW9s?=
 =?utf-8?B?dlhpeFIzWVB3eUtTWTUvVGw5Z1BMalhQakZjM1RWTzNSaVczL3NCMHhJNTdQ?=
 =?utf-8?B?akpNNUZIS0lLeUE2dVFHTnJYT1pKSElKeXJVTnJMRU5IaVArT2ZnTW1SSXU2?=
 =?utf-8?B?UGQ2R2ZEMmZWTGVsNHVKVzlnY3NnSUxiWlk4bmdVWVh1N1psK3BoS2xsWU9t?=
 =?utf-8?B?SUhvTHh2aVVYbExrOFNYeEgyaXFUNVhFU0trRWxiV1NsZEkxeTU5L0Q3NFMx?=
 =?utf-8?B?bnRwWjdEOFdPWmk0aW1pZjBwNGVaZ0pRTURvOFRocWo0cnc3K1RBQXFaY3Zh?=
 =?utf-8?B?WGVnNEtFbllxWGw4UDVTaDg2ZlQwWGZSYzlkZkc1VDYvWXZVK0NBa0dHd01v?=
 =?utf-8?B?Z0Z1ZUs0MUVFZlp5bVNpTGRMaldZU05lMFZYbUdDMWEzTnZuUVFCdkVxWitM?=
 =?utf-8?B?QXdWWFl2OVpPeVhKUFRuaFIzK2JVaE1PdEpwTWZ3V1JRRnZtQXlvSWdrN3hw?=
 =?utf-8?B?NForTk1tTnplSTliaGhoVEJNbDh6Q0lqV09lYWxSRVcvd09HK3pLYlVaWEZG?=
 =?utf-8?B?a0pmN2doTEJTdTYrb0pJZy9OOEtiWVRyeitsaVV2UEUzNFRuWjR6WE5pS08v?=
 =?utf-8?B?ekdOUnZuSEJPUG9mRkVLbU1sa3hHMU5aMjhST3BVenF2SEVlSVhFM2V3cnh2?=
 =?utf-8?B?TW1nRG5WUDVYL2ovTjV2R2kvWTlzeDNQZXNWcXZFeDloN0s3Y2M5Q1FFU0Yr?=
 =?utf-8?B?UUpmdlZVeGhLR1FxOGtDR1FieE1uT1R4RnFQVk44M3dCZnNqd05pTTlHN3lV?=
 =?utf-8?B?Q0pXMk9HVXlNUzlIK3hnb1lvd0lIYXNUZnRQS2NjYldJZk1wODJZWURTdnpD?=
 =?utf-8?B?dndlWVZhTFUrMy9wZFJuMGRJRHJjYm10aG5NRUFGVzFsQlN2cFNBVkR1UEtt?=
 =?utf-8?B?MjZqUGl2OFNveFZ6R1hYaktVcVNYdzNJTTRXWTdISHJpWEY2WjJxOEhDRkU3?=
 =?utf-8?B?LzlpVnB3V2phZzlsZFJwQXgvWE42UXNwWlZYeWtEbFVITWZVVEVvT3pyaGhG?=
 =?utf-8?B?Uy9iclVWOVI3bHNSbTlkRHN5M1FnS01CL3JnNDFJR1U4TUxXZWw1dGdxSW1x?=
 =?utf-8?B?RXlxdVNUa2NPVW1PT21KOVJyOWtzalJYMkdhd1dGNnQxc1ZHaVUzMWRYbzNH?=
 =?utf-8?B?V2czZGpBdVUrektkSXFmd2ZOZjEvcHVRRERlaXpyeFJhRmk0NWp6WHhuRmpm?=
 =?utf-8?B?NTNXdlk5dHpOVkhaRFhnbE1ReFhDT2tpYld3LzljQU9ndkx2MkhXQzM2NmYv?=
 =?utf-8?B?QTMzNnRrZkQycVlMVFR3RkN2RXozQnFrZncwbHFhMXFCVk9qRFFPNTlqNE0w?=
 =?utf-8?B?eTNiQ0tQYkZCUkdYbFBWaEJNRmpNWkZ5a0ZVeXRqQlE4bVc2N2hkeVR4dHFL?=
 =?utf-8?B?VTJRbVVoKzN6dENVWm43dkFwaVRsTWlyaWI3UjZrekF4UC93UHBOZVp0bnI0?=
 =?utf-8?B?dFVEblV2OXBiaGh3UCtCUjg4QnFQRDFWVEZKdWcza3BxaW1zbUdGcG9Udzkr?=
 =?utf-8?B?R0t6U3hNU1h6aEtOUjg5TEMzSDdHR2YrdUFERlVnOEl3bmQzU1J1clJDZmJo?=
 =?utf-8?B?YTRIU2graWR3d01SNlB5Qzd5UmRYT1M2cExiSC9PSkR0RXRZYVlsZVU5Y2Nj?=
 =?utf-8?B?Zlc1L1RKWEFpNzFtR25PeW9MZ1gwN3dtTFhDenlHb1FpeWVwWFVYaUNqcjJo?=
 =?utf-8?B?eFVkVTFyL0ZaV2xSZVpIeHQyWEtVMWFJVjVYMmFjKzFidFBOaE5UYytLa24z?=
 =?utf-8?B?V2FQTU1SOWZ3YjRPRk93T2RXajlrLzA0VjREbU1JamdwWVNSQ0UwOEw5MHlv?=
 =?utf-8?B?YkRwTkQwUzFKUFNIU3dGSndpS2o1eFlHWVphZGhNVTJGRTR1MGlHNlZtNEdV?=
 =?utf-8?Q?QC4uETd5E+OQYZp7svNbVD+2W?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7285cd2-d509-436c-35b2-08db6c3dc609
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 18:41:17.7559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rF844ap50GH1WzRS6ie92Gskkjb/2xCStGbpvLPmj776POnm6cHonjJHs9zdA++S43DYZV/uICVkw4Pr5/7ipA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5538
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


On 6/11/23 23:55, Vishal Verma wrote:
> Add emulation for the 'Get FW Info', 'Transfer FW', and 'Activate FW'
> CXL mailbox commands to the cxl_test emulated memdevs to enable
> end-to-end unit testing of a firmware update flow. For now, only
> advertise an 'offline activation' capability as that is all the CXL
> memdev driver currently implements.
>
> Add some canned values for the serial number fields, and create a
> platform device sysfs knob to calculate the sha256sum of the firmware
> image that was received, so a unit test can compare it with the original
> file that was uploaded.
>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: Russ Weight <russell.h.weight@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   tools/testing/cxl/test/mem.c | 160 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 160 insertions(+)
>
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 68668d8df1cd..1166f470e0c7 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -8,11 +8,14 @@
>   #include <linux/sizes.h>
>   #include <linux/bits.h>
>   #include <asm/unaligned.h>
> +#include <crypto/sha2.h>
>   #include <cxlmem.h>
>   
>   #include "trace.h"
>   
>   #define LSA_SIZE SZ_128K
> +#define FW_SIZE SZ_64M
> +#define FW_SLOTS 3
>   #define DEV_SIZE SZ_2G
>   #define EFFECT(x) (1U << x)
>   
> @@ -72,6 +75,20 @@ static struct cxl_cel_entry mock_cel[] = {
>   		.opcode = cpu_to_le16(CXL_MBOX_OP_CLEAR_POISON),
>   		.effect = cpu_to_le16(EFFECT(DATA_CHANGE_IMMEDIATE)),
>   	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_FW_INFO),
> +		.effect = CXL_CMD_EFFECT_NONE,
> +	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_TRANSFER_FW),
> +		.effect = cpu_to_le16(EFFECT(CONF_CHANGE_COLD_RESET) |
> +				      EFFECT(BACKGROUND_OP)),
> +	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_ACTIVATE_FW),
> +		.effect = cpu_to_le16(EFFECT(CONF_CHANGE_COLD_RESET) |
> +				      EFFECT(CONF_CHANGE_IMMEDIATE)),
> +	},
>   };
>   
>   /* See CXL 2.0 Table 181 Get Health Info Output Payload */
> @@ -123,6 +140,10 @@ struct mock_event_store {
>   
>   struct cxl_mockmem_data {
>   	void *lsa;
> +	void *fw;
> +	int fw_slot;
> +	int fw_staged;
> +	size_t fw_size;
>   	u32 security_state;
>   	u8 user_pass[NVDIMM_PASSPHRASE_LEN];
>   	u8 master_pass[NVDIMM_PASSPHRASE_LEN];
> @@ -1128,6 +1149,87 @@ static struct attribute *cxl_mock_mem_core_attrs[] = {
>   };
>   ATTRIBUTE_GROUPS(cxl_mock_mem_core);
>   
> +static int mock_fw_info(struct cxl_dev_state *cxlds,
> +			    struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
> +	struct cxl_mbox_get_fw_info fw_info = {
> +		.num_slots = FW_SLOTS,
> +		.slot_info = (mdata->fw_slot & 0x7) |
> +			     ((mdata->fw_staged & 0x7) << 3),
> +		.activation_cap = 0,
> +	};
> +
> +	strcpy(fw_info.slot_1_revision, "cxl_test_fw_001");
> +	strcpy(fw_info.slot_2_revision, "cxl_test_fw_002");
> +	strcpy(fw_info.slot_3_revision, "cxl_test_fw_003");
> +	strcpy(fw_info.slot_4_revision, "");
> +
> +	if (cmd->size_out < sizeof(fw_info))
> +		return -EINVAL;
> +
> +	memcpy(cmd->payload_out, &fw_info, sizeof(fw_info));
> +	return 0;
> +}
> +
> +static int mock_transfer_fw(struct cxl_dev_state *cxlds,
> +			    struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_transfer_fw *transfer = cmd->payload_in;
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
> +	void *fw = mdata->fw;
> +	size_t offset, length;
> +
> +	offset = le32_to_cpu(transfer->offset) * CXL_FW_TRANSFER_ALIGNMENT;
> +	length = cmd->size_in - sizeof(*transfer);
> +	if (offset + length > FW_SIZE)
> +		return -EINVAL;
> +
> +	switch (transfer->action) {
> +	case CXL_FW_TRANSFER_ACTION_FULL:
> +		if (offset != 0)
> +			return -EINVAL;
> +		fallthrough;
> +	case CXL_FW_TRANSFER_ACTION_END:
> +		if (transfer->slot == 0 || transfer->slot > FW_SLOTS)
> +			return -EINVAL;
> +		mdata->fw_size = offset + length;
> +		break;
> +	case CXL_FW_TRANSFER_ACTION_INITIATE:
> +	case CXL_FW_TRANSFER_ACTION_CONTINUE:
> +		break;
> +	case CXL_FW_TRANSFER_ACTION_ABORT:
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	memcpy(fw + offset, transfer->data, length);
> +	return 0;
> +}
> +
> +static int mock_activate_fw(struct cxl_dev_state *cxlds,
> +			    struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_activate_fw *activate = cmd->payload_in;
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
> +
> +	if (activate->slot == 0 || activate->slot > FW_SLOTS)
> +		return -EINVAL;
> +
> +	switch (activate->action) {
> +	case CXL_FW_ACTIVATE_ONLINE:
> +		mdata->fw_slot = activate->slot;
> +		mdata->fw_staged = 0;
> +		return 0;
> +	case CXL_FW_ACTIVATE_OFFLINE:
> +		mdata->fw_staged = activate->slot;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>   static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>   {
>   	struct device *dev = cxlds->dev;
> @@ -1194,6 +1296,15 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
>   	case CXL_MBOX_OP_CLEAR_POISON:
>   		rc = mock_clear_poison(cxlds, cmd);
>   		break;
> +	case CXL_MBOX_OP_GET_FW_INFO:
> +		rc = mock_fw_info(cxlds, cmd);
> +		break;
> +	case CXL_MBOX_OP_TRANSFER_FW:
> +		rc = mock_transfer_fw(cxlds, cmd);
> +		break;
> +	case CXL_MBOX_OP_ACTIVATE_FW:
> +		rc = mock_activate_fw(cxlds, cmd);
> +		break;
>   	default:
>   		break;
>   	}
> @@ -1209,6 +1320,11 @@ static void label_area_release(void *lsa)
>   	vfree(lsa);
>   }
>   
> +static void fw_buf_release(void *buf)
> +{
> +	vfree(buf);
> +}
> +
>   static bool is_rcd(struct platform_device *pdev)
>   {
>   	const struct platform_device_id *id = platform_get_device_id(pdev);
> @@ -1241,10 +1357,19 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>   	mdata->lsa = vmalloc(LSA_SIZE);
>   	if (!mdata->lsa)
>   		return -ENOMEM;
> +	mdata->fw = vmalloc(FW_SIZE);
> +	if (!mdata->fw)
> +		return -ENOMEM;
> +	mdata->fw_slot = 2;
> +
>   	rc = devm_add_action_or_reset(dev, label_area_release, mdata->lsa);
>   	if (rc)
>   		return rc;
>   
> +	rc = devm_add_action_or_reset(dev, fw_buf_release, mdata->fw);
> +	if (rc)
> +		return rc;
> +
>   	cxlds = cxl_dev_state_create(dev);
>   	if (IS_ERR(cxlds))
>   		return PTR_ERR(cxlds);
> @@ -1286,6 +1411,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
>   
> +	rc = cxl_memdev_setup_fw_upload(cxlds);
> +	if (rc)
> +		return rc;
> +
>   	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
>   
>   	return 0;
> @@ -1324,9 +1453,40 @@ static ssize_t security_lock_store(struct device *dev, struct device_attribute *
>   
>   static DEVICE_ATTR_RW(security_lock);
>   
> +static ssize_t fw_buf_checksum_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> +	u8 hash[SHA256_DIGEST_SIZE];
> +	unsigned char *hstr, *hptr;
> +	struct sha256_state sctx;
> +	ssize_t written = 0;
> +	int i;
> +
> +	sha256_init(&sctx);
> +	sha256_update(&sctx, mdata->fw, mdata->fw_size);
> +	sha256_final(&sctx, hash);
> +
> +	hstr = kzalloc((SHA256_DIGEST_SIZE * 2) + 1, GFP_KERNEL);
> +	if (!hstr)
> +		return -ENOMEM;
> +
> +	hptr = hstr;
> +	for (i = 0; i < SHA256_DIGEST_SIZE; i++)
> +		hptr += sprintf(hptr, "%02x", hash[i]);
> +
> +	written = sysfs_emit(buf, "%s\n", hstr);
> +
> +	kfree(hstr);
> +	return written;
> +}
> +
> +static DEVICE_ATTR_RO(fw_buf_checksum);
> +
>   static struct attribute *cxl_mock_mem_attrs[] = {
>   	&dev_attr_security_lock.attr,
>   	&dev_attr_event_trigger.attr,
> +	&dev_attr_fw_buf_checksum.attr,
>   	NULL
>   };
>   ATTRIBUTE_GROUPS(cxl_mock_mem);
>
