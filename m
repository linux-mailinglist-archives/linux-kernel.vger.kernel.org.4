Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334EC73AD94
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjFWADD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjFWADA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:03:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E431BC6;
        Thu, 22 Jun 2023 17:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687478568; x=1719014568;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yf79PBdG1LBQHyv+lqig00hyqzuqxL269Pjl8kuxTQ8=;
  b=SOGU6IKnPeMinn3p+JFdWAt7q900nSDuVI8dLmvLbrpPGNuhY0R8j1oO
   KAOFsfcXiMikqbyYk+IJXTFPHLgDzeyQdg0BSaCb7sk7Em//JxWGB9FoX
   zS8VnNKG4wynkJ0JnFhh9c0DT1ksRg139akNZUBLM7JUo3JTlvJfSq4Kp
   zwwVBWJCfmx1Z5+EGJULt1kOnu26UL9bedIctbUaAZcIc7KzvmxAlxyyP
   NDmgyEVreknHiKq8ETIJchu6VJV78Jn8ppr5J0G/WdSJ6AM7huM537VeO
   DWj2XrH8suHoP6ZbCPKZz/UVPJaBK1CJo09M3Y16ytlUU+h51EsIOt4Mn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="426625381"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="426625381"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 17:02:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="780430807"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="780430807"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2023 17:02:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 17:02:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 17:02:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 17:02:46 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 17:02:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bE/cusDdkgnumYBwI0gty1q6DkpWoJO0EYLRrMw66riRWFrbHxulRMga2UQvUOPPN2e07AhdqCgN1S77x34ZGeYNiUGMKtjIrYYhRaIJBGg2O+88AJvgQpY/XH3YGJMxvwSu7SQTxq1zL7ac3l9SFbJe70xfGjwcYPN0kqcHJMWIMilhpI/TWHFGWX7Op8xbkZYGJ9UTylOcT/duhYU1xqaPxCGX+3qvy89+21ZDBnFVn4SyXWnRL6u26mvAgt7wbS6daBDAAwcUWfZ2q6IyrzXAy8N6jiPs6TdK17cxvC01mUrbxRBvnwRgRInGusRWTGntpkhLvHHLqL4Imge1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EffoaPNAe3vvoDQr6oM8s7QcUBa4F2iOQLSwzidW+c=;
 b=lbJEBK+t3Lz4hulRbtl99uR7GoI5ciFgEAe7A/8EfyEdCEn9a7TnSwFcaAUE346lbcNrEBKsSZbiQirzt6bZ/ON92Br06QGR3gTI4nnEiNCYArDvVuDRvJ3E8o+ibon6NVnsayHrZB339l+qvIX9wqI5zRj0LfUOMFpWO1ZmGzpkIGgXHjbQs3UzM4D/eEH/XqdBsRcR5XGpt15XisBr4VV2ZOFvIaamvd4kCl5TOaFB9Rguf/NI/RLWQwxvq4sDiVQpLtiFd2fIbGO0ZEUt6SH4OtOhQQ71NiSDzWzlYB/H3SMJ/+Q5qFFZtt3+FALaNjMlgM6Vl7xWEl6UYLW09w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB6654.namprd11.prod.outlook.com (2603:10b6:806:262::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 00:02:37 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 00:02:37 +0000
Message-ID: <99d05188-3c5e-231f-a002-c9ed72dace83@intel.com>
Date:   Thu, 22 Jun 2023 17:02:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v6 17/27] cxl/pci: Store the endpoint's Component Register
 mappings in struct cxl_dev_state
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-18-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622035126.4130151-18-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:a03:334::11) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d26bca-802c-47d6-2911-08db737d275e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qDQK9nAmGlx0BhDOvr+ejhmllOWiKdtGpEkiENrM8q5vdA0xqW1JC9F+8frs7gkrrMbKJhA5CdRIV57+MItUtooHg/IWQde0vabCwi78V9/Th8SToOSomvgOyR+OTL4Rl0NIaO2276OhaXT9a6RuLm2U963J038iUiYnv10sjIdXGE4boKiWsYBvmBsYGXQ7DHN3rYewXJhC6tQmmphLre0PhrO5q7K1vnz59cp35gVpCAHetBWc2fWgu1kiaDBDNt+lE5eLmzqocZ7jNetiJKwGIU7JyLxJygvNQXqmAf5j6UfzUAliibUK+dwxWZiwKZmY8UNd5jJMLhDXyH63UUNPIgCA6rkf+bsbXlZQjaB4sIbnzpMgqL74ORQbgwHyFNYw0bN5nIf9FMWsR0Ko7KfCmsaZwxUbFfDaaaEsVyIF2Q5qm2EBtR6lz6zG0oJPtZ9CSw2+xxcO2xracgbe6+tfdvXrVevFy7xk8yO/3Yuxnp/E2O8sU/3KvJ0zzZ6HVkPNEi6WhSmIFOHjrQ+JN+s5RLuPqvVTbYpote03QqBK9GL/HAL5xv/uqMOqMp2/TijlMbwo6h7DJMw1Edd5Xt/KQ7qIS+N6a33AsbwYp86fJc3Zz/XxxV3/S7Li5wLpdLN9xPnr+6VZ+CFjjcShw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199021)(38100700002)(53546011)(82960400001)(5660300002)(26005)(6506007)(83380400001)(6512007)(186003)(2616005)(44832011)(41300700001)(8936002)(2906002)(6666004)(36756003)(6486002)(4326008)(478600001)(66476007)(66556008)(66946007)(31696002)(86362001)(316002)(31686004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0c0Mi9QSkZmSXM5SGVhSWxtY1FZK1NhL3NPTmtpajltVlM4b2lrMTBrSFFS?=
 =?utf-8?B?aTlDTnVFVHFzNkVwVjlRdkZMRUV6VGg1SHVqWis2ZlZKWkJ6YjlueGRRYnFl?=
 =?utf-8?B?MlZNaEVsVjlaSEIzWlRCSHFtUXpQUXlmM2dNbmdKK1lxQ29FNjlsV3BkV3p0?=
 =?utf-8?B?WjBYV2NBbVB6aXMySU5lQUUyL2tMc2taR1F6S0E5MXBVRk9XSWR5ME92M2Jr?=
 =?utf-8?B?ZVhQRFNNMmFZdTJ3dVZIeVF2VVIxRmszQmJkTVAyc1pJR3V5QTJUY1JkZnNE?=
 =?utf-8?B?c3JSSFd0bldBNEI2WlZUWTFNeVRmbnA3aFczTGhhcVpNbWo3QktRM3pEMjFP?=
 =?utf-8?B?SjRhbzhPQUZGN1cvUjFSMVdLRWErOTBXMkR1ZHM0QWRPNTdxWXgrM1l0Qm51?=
 =?utf-8?B?QU9wajJ4ZUxXcEd6OHhuUExHRU03dThQWm9HbDR6MHo1VnZjZXphUVhCQnBV?=
 =?utf-8?B?djBZcDIzK3FRNTJrT3l2aFJGNWhhc0JFcngxSkFCeUR5UU8rbmZ1Z2lDWEpQ?=
 =?utf-8?B?QnBTMlZLeXZoTy9saFc2NVdTakplM28rRmV0eXZqSDZtQVVhWU90TFhhRE1r?=
 =?utf-8?B?Vks3bnV6K2wwZG1OV1laaGg2UzhVY2FYK09rTlpiNWw1UGZkRkIzODRyWUNW?=
 =?utf-8?B?OG1MRTh5UHFBVG0rOE9QdnZzakJHVVJQaXVQVlg5Y1ZSRmxoaXY4cWRRM0hW?=
 =?utf-8?B?R0JncU1rN0RlYjUvajQ5V0NZRjFKL2liQmd2dENmT01jSm9NczFEc2NiWThX?=
 =?utf-8?B?VU5mUzBGS1VvUDhZdEhzY1ZqSEpiR2JPME5rcVg0QmhpM29Pd0IxNEZERHdQ?=
 =?utf-8?B?QWIrZWswTW5GMVE5TmI1ekFlRE40MXVqMXZaNCsrOFRWUVBsbzBNaFZxMTFH?=
 =?utf-8?B?amFtVzRZQVBEdGI1cC9JWW4vRndqcmJOWnI4QVV0cUo2UGNIYmxDdmdnWDdD?=
 =?utf-8?B?VUZXSVdmQ0tFMnNwWHdNMFREMHFlbEM5a2VzbElBYXZVeXB6OWhycXlZUWNJ?=
 =?utf-8?B?alltQ2tGdGVPTXVrSk5IVXJXRzVyS3l1NDN0My9BMWtIbVVmWENMTS81Vm9n?=
 =?utf-8?B?NEhlWklJK3ZPcmx4MkUwU0tFSmpTRmNzeTIwZllyVitHNEJkWitCS0tNLzBL?=
 =?utf-8?B?YUhGRHJ1bTBVNGsySTJxeUJaV1BJRUNmcERWMTFoS01ITENOS01vcThqQ0F5?=
 =?utf-8?B?elpobUVFTWQ1amVyZUFMbEZLZ3lPSUtPYytIZi9ycGdkUkZOV1F6d2dQbzlG?=
 =?utf-8?B?UmNtRkNDUGVOR2lic1g1WDhqaVVEUG1FaVF5VkZFK1hSNXZpcGxKb1VoNkZR?=
 =?utf-8?B?OC9JMnowS1ZMYnNXQmVjSk5IZ2haeWhBZThOcEZTMS8xUEhjd1Eza0NML0t3?=
 =?utf-8?B?cjBpbHo2akxrMURrRUFWbkJEVk1vNDVCb2JsbGFQcUNJVFFkcTRjclNWNkpi?=
 =?utf-8?B?Mk5GZjB5K1NoMVF2VG9EdmRPc1JlQkd5ejRkcEhoVTNlNCtFVktMbC9HcjZM?=
 =?utf-8?B?NFQwMUZzSFVFQjVMMDE0NUdSUkQxNC9sMy9WY0tzM0JQcWtCU0JmZU1DUE1z?=
 =?utf-8?B?cEFWUklTUWlhVHJTZ3RhZmhpMTVwdDdCUFhPZVl0QXMwS1cxQWpQOWY1VHIy?=
 =?utf-8?B?ZVFZVWs1TGY0NXlsQmRvUGtlMVVWYU9KWGNyTUduNjFNNm8zbk1KRm9KbFdL?=
 =?utf-8?B?ZDVIL1F4MXFQVnJuUEVUOGFQbUJyWHVNdWdINmVQN2ZVcm9jd25vTEdZeVNa?=
 =?utf-8?B?bTFLdTNpYWVQTXJ1ak85MmpadXphd1JtYWZZU3BDOFVUS09uNEJKeXNwZlBN?=
 =?utf-8?B?OTNVVTdrcXVNK0IzRHgrd2hiRGpzM2dxVFNaWUZ6YVhTZDV5UVd2K1dyYWph?=
 =?utf-8?B?OXh5TVJ6T0t3WTRldUlLbFNleFppaUQyYUczSGtRMlg2YmZLTloxV2Z3ZVFW?=
 =?utf-8?B?Vm5MdnJ2KzV2alM3NU8vMFFSYlVhbUEyZVpYOWlQRUdzK0pnYWorNFkzallz?=
 =?utf-8?B?Tnl6Vk5XaEJSSkpSNXEza28reUwyODQ2Y2dDQXdMejk4WXVnZFQzNFg3eHVz?=
 =?utf-8?B?c2lKMGtBZUZaRS9sZ3F3Wm5oZENpV0Z3a0RTN0toQWwxMFhMdXYyK2NKQmpX?=
 =?utf-8?Q?mtjHWUP8n3BD4o6WErtIu2NYC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d26bca-802c-47d6-2911-08db737d275e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 00:02:37.2895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfETDTGyUQ/8IHy/WUH9Hyo6g8DkD0o4m7iqaO12BoiwN6R8g9l1KEB1HlKvleFI2CcaBGBdS9DGi3vLnPfmEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6654
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



On 6/21/23 20:51, Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> Same as for ports and dports, also store the endpoint's Component
> Register mappings, use struct cxl_dev_state for that.
> 
> The Component Register base address @component_reg_phys is no longer
> used after the rework of the Component Register setup which now uses
> struct member @comp_map instead. Remove the base address.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/cxlmem.h         |  5 ++---
>   drivers/cxl/mem.c            |  4 ++--
>   drivers/cxl/pci.c            | 10 ++++------
>   tools/testing/cxl/test/mem.c |  1 -
>   4 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 76743016b64c..8aee1a42d9af 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -263,6 +263,7 @@ struct cxl_poison_state {
>    *
>    * @dev: The device associated with this CXL state
>    * @cxlmd: The device representing the CXL.mem capabilities of @dev
> + * @comp_map: component register capability mappings
>    * @regs: Parsed register blocks
>    * @cxl_dvsec: Offset to the PCIe device DVSEC
>    * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> @@ -286,7 +287,6 @@ struct cxl_poison_state {
>    * @active_persistent_bytes: sum of hard + soft persistent
>    * @next_volatile_bytes: volatile capacity change pending device reset
>    * @next_persistent_bytes: persistent capacity change pending device reset
> - * @component_reg_phys: register base of component registers
>    * @info: Cached DVSEC information about the device.
>    * @serial: PCIe Device Serial Number
>    * @event: event log driver state
> @@ -299,7 +299,7 @@ struct cxl_poison_state {
>   struct cxl_dev_state {
>   	struct device *dev;
>   	struct cxl_memdev *cxlmd;
> -
> +	struct cxl_register_map comp_map;
>   	struct cxl_regs regs;
>   	int cxl_dvsec;
>   
> @@ -325,7 +325,6 @@ struct cxl_dev_state {
>   	u64 next_volatile_bytes;
>   	u64 next_persistent_bytes;
>   
> -	resource_size_t component_reg_phys;
>   	u64 serial;
>   
>   	struct cxl_event_state event;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 205e2e280aed..92c6151b7206 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -49,7 +49,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>   				 struct cxl_dport *parent_dport)
>   {
>   	struct cxl_port *parent_port = parent_dport->port;
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct cxl_port *endpoint, *iter, *down;
>   	int rc;
>   
> @@ -65,8 +64,9 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>   		ep->next = down;
>   	}
>   
> +	/* The Endpoint's component regs are located in cxlds. */
>   	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
> -				     cxlds->component_reg_phys,
> +				     CXL_RESOURCE_NONE,
>   				     parent_dport);
>   	if (IS_ERR(endpoint))
>   		return PTR_ERR(endpoint);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 99a75c54ee39..ad4cfcd95e17 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -665,16 +665,14 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	 * If the component registers can't be found, the cxl_pci driver may
>   	 * still be useful for management functions so don't return an error.
>   	 */
> -	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
> -	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> +				&cxlds->comp_map);
>   	if (rc)
>   		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> -	else if (!map.component_map.ras.valid)
> +	else if (!cxlds->comp_map.component_map.ras.valid)
>   		dev_dbg(&pdev->dev, "RAS registers not found\n");
>   
> -	cxlds->component_reg_phys = map.resource;
> -
> -	rc = cxl_map_component_regs(&map, &cxlds->regs.component,
> +	rc = cxl_map_component_regs(&cxlds->comp_map, &cxlds->regs.component,
>   				    BIT(CXL_CM_CAP_CAP_ID_RAS));
>   	if (rc)
>   		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 34b48027b3de..fd562a5fa06f 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1241,7 +1241,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>   	cxlds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
>   	if (is_rcd(pdev)) {
>   		cxlds->rcd = true;
> -		cxlds->component_reg_phys = CXL_RESOURCE_NONE;
>   	}
>   
>   	rc = cxl_enumerate_cmds(cxlds);
