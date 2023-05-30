Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF1A716A87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjE3RMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjE3RMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:12:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A8F138;
        Tue, 30 May 2023 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685466716; x=1717002716;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s8/r13r1r/ex5JQXe8BQ6VpuJpsaA2ZaBcMbtVqUvEU=;
  b=Dx/NOi3dzYNZkLgxvQozl77qVGcRvaN6AFlu4s6g44rC2vFvySAWj/tu
   3YTddT5N+B8AWKDf/szxyomtuvJeqB/Ya+uX3jVxK0JKoCIbkFT7uAu5r
   W7RRC5gWeJgc8cuevU4A52hNSTYO35icki+nUAEwv7XRSNABdoxoPJS8u
   W16bOxdari3NaMYxfB3bWfRPSc3Cxp1HFzWTWgF0q1UqZIS1YS1awzFwt
   C394M2IzT5C9gc0BRmSntwdY83k0tW9KR/m2VbPB7Dn/GZk+s6ngRErWM
   anLLMqoli7n5HRzanaqYBdrcf0F+VklX+TxSxR8DyXSiQyGjQnRQi4Cyd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="339577858"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="339577858"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 10:10:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="850867027"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="850867027"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 30 May 2023 10:10:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 10:10:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 10:10:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 10:10:31 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 10:10:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egFVtKfaEtq+AMwp97vWCBYt4NvzQks8mclMtRI/uVO8udNfR9TzRuw08wZFw+0GFoOwOtek7jFPX5cgqdrrJ/WMcrv1ikl4lM/LCgv3+v9B6J5QRf+mwcezG4LR9tdhdQUv1WcZAqkshMFTBIKcN9XwffdWwCVEoXqbZBHJ+w9JvWK8p8mYfVlqTSSzW+A5zHvS3ZwsP0MBc52N+Gq5YLKMZhgZCEp/oFm8AzD9JoqAbt2x7qRW//DtW0I6aN6HoT2KHx3D/MjKVZaoJGJQ1x9ISE1LUF4MaBbWa3HHeL4cdNKPtIyKw18Syd1umsJ14blHzI96q+RIJA1wcVLz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gu9q08E7S9FIlgXfMgICmUoWuuCucRLAR7KwE8HWbXU=;
 b=Qd7kJQlUQci66nOT++YzKhxHbzXfaVLruVUmpsYlJrUenJcV3gwas0a0h/PB6zmafv3hD8/thtB/6Lfv5w7VmVfaM4Z8Fhe66l3QURaQflcIG5cWNp5P6yRZfrTDNpaSn7+QJyAbUF2NEK26taOZKbPA9+fYLjobO8yU0bx+z9R9goa6YD643FiTHSo4IvSC6nTOX6sp6JRTr+Jfw6TTsZoRVMv/hXcIyvu3rne2xSAaPyN2RHY1tVOG1i7Tjkxu1Q8ZX4FC1U9qQG+wVk7hUP7vRnBDBN5+D86YNWWKx3YoZj0Z/0uY7oeAoWOXZ0UR7H4oL480z/hIHK5ZD2VpWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CH3PR11MB7894.namprd11.prod.outlook.com (2603:10b6:610:12c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 17:10:23 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2%4]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 17:10:23 +0000
Message-ID: <670f8541-fbf2-8992-da88-78c3af925495@intel.com>
Date:   Tue, 30 May 2023 10:10:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v7 2/5] cxl: Add functions to get an instance of / count
 regblocks of a given type
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Liang Kan <kan.liang@linux.intel.com>,
        <linux-cxl@vger.kernel.org>, <peterz@infradead.org>,
        <mark.rutland@arm.com>, <will@kernel.org>,
        <dan.j.williams@intel.com>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <linuxarm@huawei.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Namhyung Kim <namhyung@gmail.com>,
        Stephane Eranian <eranian@google.com>
References: <20230526095824.16336-1-Jonathan.Cameron@huawei.com>
 <20230526095824.16336-3-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230526095824.16336-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:a03:180::42) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CH3PR11MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c4c53c-10b4-45f0-6553-08db6130c127
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EI7YUksaMqNU2lGjnRkNRjjfWtXyoqypR4/qDs9SthgC+bVcG9XuPGA7GuDrmnY7R5qnhHpjl1InPtI6UVt3tEbPtawSpKHHE/VAfn9cPZ8BvprPdQdwmgiFSdpDt4R36xPUWUqeN5L3OJFrFyBo7fjQ+hGZLtDqWI4TZ+zVYKO7he0g2NBbvD9Ue7vmv8gl6jKtAD/SWx7h9MZPobUD2DD9xPI4qiPHsfHImJBekaa/TZ6BfO1ej5avLuOeC4vX7BtYtpynQAhGbK1u100Atwd3SQS3+LVmrMC5sAHCQIoyBMgqFxmJqdLiySdq7FNTrSwDsN5T6wQppayaV1JcsdWbkRDddeyr3U6uf9FOyXA7S+VUf5F5xmIv8wti357bUjrf81UGnn27E6tR2hHWH7IcEPpMZUnZwzms89n731t7sUHX3X+x+dZ2u/GyTOstKC/dxj59aSgkPsgg8eNONR30Hp1EBAJwG1Uvg37kuh7an8GiXzBl/lsVdj7UPbFJMlGrHlMQVJpDcvdlAvvGY29UBThSM04DDu/oFuzdd1tBdE6Z/qmq/XInb48sTlzDN0Nb4zzhG02qnspAkH2jmb58KVj50r847KGOZgScyj3UVrhdrf9D8+3tLGyr6TOgvctNqYRR9r4LgQL3fISyAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199021)(186003)(2616005)(38100700002)(41300700001)(31686004)(83380400001)(6512007)(6506007)(53546011)(26005)(6486002)(6666004)(478600001)(110136005)(54906003)(4326008)(82960400001)(66556008)(66946007)(66476007)(6636002)(316002)(5660300002)(8676002)(8936002)(44832011)(7416002)(2906002)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTljVEVTU0tYYUJ5QVU5ZnRMY0F0QXFMV2xhWk1uQTE3NndPNlp3Q0xXdWZD?=
 =?utf-8?B?a081ZWZHblVMbnJSSnZQcWJ2aEhXV3lHVjRyUjFGcjdwNVFNNU0yODZYWUNs?=
 =?utf-8?B?bmxzRnM0LytKdEJmTzZKSUw0eHJtK0tsVTFHeVh3REtLSWRWajFiNVc0eGVa?=
 =?utf-8?B?azY4REpxL0llSE5SNjNXUSsxQ3pOQlMwcXBiZlVyNVBHL3NIeWdpcStON05s?=
 =?utf-8?B?eGxrY3VieWpJOU1jb2g5QlZZNzNlNXlobGxkc1NRVTd5ODczVnNMWWpTaHBF?=
 =?utf-8?B?YjZvLytudnFlZnoyQXB1ZGxaVmRURWM2Ny8wNTZhYWZxRHkwRUVaWGQ1Rk9X?=
 =?utf-8?B?Z0EycEJtOUxOTkF3a1JmbGJ2TWtXdktyWDhUOUxwQktSNGU2TnlxNHo2YU9s?=
 =?utf-8?B?YTlhSnhzZFo3K3J5bGdrZkJWRWpwM0NPbWo4SjA3a2NhcDVpM0R2dStIS1Vh?=
 =?utf-8?B?YkU3U3VZeDc2cE9lQjIrcEhwdXNWaEtnbFBkaVdIcVpPYXFPS3pPSkpKOEFC?=
 =?utf-8?B?ZWwyZnhyeE8vNnk4T3lmSWJkMk1tTlJVN0VkcXFhbk9KTEh6eHVBMTV5blFC?=
 =?utf-8?B?MloxdUVmUWM0WFVibUtiSVh4ZzUyNFdkMy9JZktmc1NBYVNKY1JuWUxRd1pL?=
 =?utf-8?B?U3NtdllnK01kK21RYnpOOTMzN1BQRW4yTlcvU3k0eFRTYms0dXNYMWJaUWw0?=
 =?utf-8?B?dWpBREQ0YTRuZ1czak1KUEwwQnY4K0NwVlBYMC9HUEpub3AyOVZPTVBITlV0?=
 =?utf-8?B?T3RaNGdaK0hIUEZyOXhkaE43ZTdXSTd2Qk1ZOWFyQzR1cHc4ZnBWcWhCLzVK?=
 =?utf-8?B?NjQxbmpOSWM2VFAxK3RvL2I0MmJRR0Jjay9IdmN1dDFkVXVZYnBudlhsRWhC?=
 =?utf-8?B?bG9vbDMyc1dMQzdKZE9IN2JReUd1RVNmK2Q2MjNTeFF0SmFqdkJ3S2hON093?=
 =?utf-8?B?aGNYUnllZkg5bG5mS1BIYVliMFpQK0FaUTcyRGxnSjRFa2hjMnRoOGVKWDZN?=
 =?utf-8?B?eTMrUCtzUDhxTFhTdExmYStwZmNyN3UrNFp6SmRzeit1eWJjYlJkdlZNa25M?=
 =?utf-8?B?OGZjQjI3b3ZReVRKTnBMbi9aMnh4c3d4Mk9DR2VHNUJVVW1WRzhISUw3dnFN?=
 =?utf-8?B?Yi9MUGdBWTBySGJ5U09ESU1Yc0VNSEZWYXMrZUF6UWZxSFhSMDRab0tXQ0Fs?=
 =?utf-8?B?c3JjelE0azNTMC9JU1k5RzZ0RWg5dGYwdDQ1S2pkbnhJVmUwWWVZaUltSzZZ?=
 =?utf-8?B?alBZc2lWamd5ZnoyT3JVeUJoWG1nM1ExT0JiaCtidy9ETmI2VGdrOWthc1Mz?=
 =?utf-8?B?L2U0MHFkRFdyT1o5OTViaG56TUpCTWdSNFBhRlM3RzFlRm1VNWJwWjNlVVdV?=
 =?utf-8?B?dTg2Qk5jK3lYU052MFlMMG1HNnhGL2I1b1JIQ1RkamFYdGVFRlJOVTk1MWw0?=
 =?utf-8?B?cVNZV3pGaTByV2lGUUdZTjBWQzRrcXBxUHJtc0VaZmdHaXhYcDNsVGpWc2RH?=
 =?utf-8?B?Wk5xT3cvdFdJRHA2UjZJVW03bGhWRzA5TnpNVXF3NWt3akdlZkxMZmZpT1hk?=
 =?utf-8?B?RXdMeng3NDRsQzNjL2x0QVE4ZVVzNDZlN3pTNmU5aEtkYkt2b0pVaURlTGlh?=
 =?utf-8?B?OFovU1NLQUd0V25Ia1ZZd1lvS2ErdG9mVnhkRmFJYmgwcTVSb2c0QVFtOHRQ?=
 =?utf-8?B?RnJCejV3NkJhNERpZG5mUzE0U24wSGdjSy8yYjZpQU02cGJtelFMeCt4WE84?=
 =?utf-8?B?N1haS1JBZlkrT0s2ZHViaUxNYiswNk9nUTBkay93NWVBREFTMnFhRk43enNx?=
 =?utf-8?B?NHlwWEpXY0dQbjRxMkNEY2ZSQ09WSk8wNzZxYmpPR2JETWJZbGJ3UC9Lb1lM?=
 =?utf-8?B?cGFsQnBlZEFMZ1o5ZkZCRFRlTEZsZ290cnZDMEJIa2p0MXV1SSswYVQ5V2ZC?=
 =?utf-8?B?eUcrbllabnF1ZkhUMUQ3ZkhxQTIzTkhINk84bnpnQ0x0Nk90VDNaL1F5Qml0?=
 =?utf-8?B?TXFJOE5zZFQwZVA2Zm1XbWdaTTNzYktKSkhaNzcxR2xkSFZ4bTdWKzVkMVBj?=
 =?utf-8?B?K1lGcmloVlRzU0dkWGVabXl1Rm1MRG1Dd3pZbzRUb1E3d3lvK1hPcWV4bmpv?=
 =?utf-8?Q?MUwLIF36BWxl/bgHd5MDRRoMS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c4c53c-10b4-45f0-6553-08db6130c127
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 17:10:23.2120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeUH64nMCZcBumF3WOIXJb4v8Nk4l9aQjSUHK+YhhCe3Xfq0jU8TPVkS/UMUUh8e29Lv3b6FKjXZyxRHGgrvPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7894
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/26/23 02:58, Jonathan Cameron wrote:
> Until the recently release CXL 3.0 specification, there
> was only ever one instance of any given register block pointed
> to by the Register Block Locator DVSEC. Now, the specification allows
> for multiple CXL PMU instances, each with their own register block.
>
> To enable this add cxl_find_regblock_instance() that takes an index
> parameter and use that to implement cxl_count_regblock() and
> cxl_find_regblock().
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   drivers/cxl/core/regs.c | 59 ++++++++++++++++++++++++++++++++++++-----
>   drivers/cxl/cxl.h       |  3 +++
>   2 files changed, 56 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 1476a0299c9b..4b9672db867d 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -286,20 +286,23 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
>   }
>   
>   /**
> - * cxl_find_regblock() - Locate register blocks by type
> + * cxl_find_regblock_instance() - Locate a register block by type / index
>    * @pdev: The CXL PCI device to enumerate.
>    * @type: Register Block Indicator id
>    * @map: Enumeration output, clobbered on error
> + * @index: Index into which particular instance of a regblock wanted in the
> + *	   order found in register locator DVSEC.
>    *
>    * Return: 0 if register block enumerated, negative error code otherwise
>    *
>    * A CXL DVSEC may point to one or more register blocks, search for them
> - * by @type.
> + * by @type and @index.
>    */
> -int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> -		      struct cxl_register_map *map)
> +int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
> +			       struct cxl_register_map *map, int index)
>   {
>   	u32 regloc_size, regblocks;
> +	int instance = 0;
>   	int regloc, i;
>   
>   	map->resource = CXL_RESOURCE_NONE;
> @@ -323,15 +326,59 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>   		if (!cxl_decode_regblock(pdev, reg_lo, reg_hi, map))
>   			continue;
>   
> -		if (map->reg_type == type)
> -			return 0;
> +		if (map->reg_type == type) {
> +			if (index == instance)
> +				return 0;
> +			instance++;
> +		}
>   	}
>   
>   	map->resource = CXL_RESOURCE_NONE;
>   	return -ENODEV;
>   }
> +EXPORT_SYMBOL_NS_GPL(cxl_find_regblock_instance, CXL);
> +
> +/**
> + * cxl_find_regblock() - Locate register blocks by type
> + * @pdev: The CXL PCI device to enumerate.
> + * @type: Register Block Indicator id
> + * @map: Enumeration output, clobbered on error
> + *
> + * Return: 0 if register block enumerated, negative error code otherwise
> + *
> + * A CXL DVSEC may point to one or more register blocks, search for them
> + * by @type.
> + */
> +int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		      struct cxl_register_map *map)
> +{
> +	return cxl_find_regblock_instance(pdev, type, map, 0);
> +}
>   EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
>   
> +/**
> + * cxl_count_regblock() - Count instances of a given regblock type.
> + * @pdev: The CXL PCI device to enumerate.
> + * @type: Register Block Indicator id
> + *
> + * Some regblocks may be repeated. Count how many instances.
> + *
> + * Return: count of matching regblocks.
> + */
> +int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type)
> +{
> +	struct cxl_register_map map;
> +	int rc, count = 0;
> +
> +	while (1) {
> +		rc = cxl_find_regblock_instance(pdev, type, &map, count);
> +		if (rc)
> +			return count;
> +		count++;
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_count_regblock, CXL);
> +
>   resource_size_t cxl_rcrb_to_component(struct device *dev,
>   				      resource_size_t rcrb,
>   				      enum cxl_rcrb which)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 044a92d9813e..f6e2a9ea5f41 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -260,6 +260,9 @@ int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
>   			struct cxl_register_map *map);
>   
>   enum cxl_regloc_type;
> +int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
> +int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
> +			       struct cxl_register_map *map, int index);
>   int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>   		      struct cxl_register_map *map);
>   
