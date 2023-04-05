Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BCB6D8B3C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 01:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjDEXsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 19:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDEXss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 19:48:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572EC6EA8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 16:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680738526; x=1712274526;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RKd1NLj+BYQtHKtZdAQ3chWvH60h3Be/F5ffNMSTggw=;
  b=eOb9/QrYtvJDCBHI4iq5NGTC5YzP0dAOsFYIxjOFhEK6TSCgc5w8S4rM
   SNtmsrwipGxytrg5jqDX3HKlTcaF5SVr9Q0gWmnYKe6uUDVHOQw62PZ2b
   9tRfGrgOVqFQknNiyHZ1OYYXuAbcevMDmbzxJ6nIuV7J2DNXxYAEAT4iY
   +TLDAhT4IMLlgD534QtwED7KPSRgtfIYwWF/UwIY9jlsPxZsuAXNbbi5o
   2U+dASPDYDe+BFGch4YpoZSewJQQv2mDmYSCuhf7E/bUSTfvEZ6kp8qHV
   T73W41SSwNYIEU+duA1W/KQXm7LHIkA1X8ddPS75eBYpBlsIJrDPWNgCg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="370430032"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="370430032"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 16:48:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="861172383"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="861172383"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 05 Apr 2023 16:48:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 16:48:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 16:48:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Apr 2023 16:48:43 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 5 Apr 2023 16:48:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuGOCBULuk3F4N0qG6ptv+1NhoUgWYtgeeRW/JKS7a/g9GqUcu2HduxMT491WaVhQ2pW0eHDs5aZS7mLzJEa8SR/WRAGEI8bahprBfAXb4OzrVvnUQdxojThuydTqk2OWRlNDdhutpGOhzkurpqOXMRzo5xw/EYMz23CO5ZxRy82UIwV9mRtR+KM/kt9iEHE0tYtMrfWamxwC9PCeNggj16U+gKrYZjm4Y8slq7lr15KWAFRVPgbg1wA5bol6ymiu/a4yDtoIvXJaK0LljnTOtJfr3JVd4hMUh1zTa/zbffmY4j/RIxxGn/0TT+lP+f+oNo1Pz9ljdYh3a8EAdwQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eRfzpW6wjFcgx1VyauYhMSX8MZJMV6WKckv+56zKhk=;
 b=XL9K1YtN/Y+s8CXdFlA7loI+EVrPbBn/IuVPL/15MFexksktWrRfSsRsQ9AtLOIvZzOMEHUIX9j/dzD/4DFzRVq3zfpbOAaDpbt5/+UIKhIYuOyUr1ZxuxU0FHfLQUsU0Y+5U7j0llh8+5BEM+C3VheK9QWRVZJDMOued5fu3H+Ka+IBc+Z05/cMGI5T1RPEFp6YxuwFjmPcpmy5ZNxAprIz4ZuHJiSEMOIGsaRjQZDEzj+mnZHYmJn1UrajSLCwdVy70x70LHUFHtfYjh1WNU4Y0DyEyABI1PgWelO962JQSttpPK8C4xqArRscEY2HfDi2v0Qu21N2Op8ANCaQPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ2PR11MB7646.namprd11.prod.outlook.com (2603:10b6:a03:4c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 23:48:42 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6277.030; Wed, 5 Apr 2023
 23:48:42 +0000
Message-ID: <50a87b32-282e-e4d5-8fb4-a4a99d1b0ed5@intel.com>
Date:   Wed, 5 Apr 2023 16:48:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v3 18/19] x86/resctrl: Add cpu offline callback for
 resctrl work
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>
References: <20230320172620.18254-1-james.morse@arm.com>
 <20230320172620.18254-19-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230320172620.18254-19-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0239.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::34) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ2PR11MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4f38cf-5394-4d36-e6ac-08db363048fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qV/EPBWQSqLxhrGn0N0k+THOiKX7byd3c/HAuJH79P6MdD/J4w85S+A+x0ofMP9VchtPTwgEkGkxJXA7UYoS7ZXocKrlgeGQA39Za0cg817Sgq9mzhLFio9sk3GgJn3PSb/exE6rpLgSzX9o2IAer1RFELT6oCJ3zyVzssg1PChW+8xY7RGlIoKYWFTlmly8vm2ahUsfogphtMnQx2MdOtXYfvs/pH/J3yFB2qWP1AWZE/3T1RVVHTCC/mDcdRJEwZJJKv57zYpj5tyhjOEENhcm0Bh4e3A2pI+Ly5aJAkoifaq3r6gtLw3IKuIXTp1kJpKDNEBnC3IRK/evzYPYaVbB5u6zJgUEiGPAh7r3N81H/hq3VHJFJpmS3SwndAAUe9PE3ebmmC0GerlA3su7wL5KL84VfeZX/gvEqtll4kdv4PCYShenZa6srufnNcwVQEMxitfrVgrGQCZAP1d2HoLDQNfUjI2FHXNgapXOqS0a0/dpJGCsCFLtuLweS0cCYQVPH554afp3xEJ5f47rbJQaNN6Z05DiBnnjZpzPPPi9ZtsSJA+yrfJTnp4z5Sl/Wxa4D2E4LiYXWZHem81r5nCLs9VI87XHFm/6aamUoWAmxlbI8LMZu9+OOdyE+5C/ND6HFsSNLkwl2WRjXgj/zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(31686004)(2616005)(36756003)(31696002)(82960400001)(38100700002)(66556008)(44832011)(7416002)(4744005)(4326008)(66476007)(8676002)(41300700001)(86362001)(66946007)(8936002)(5660300002)(6512007)(6486002)(83380400001)(6666004)(478600001)(26005)(186003)(54906003)(2906002)(6506007)(53546011)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1J1MmorSTAxOExrU3piWTRxTGJVdkxwWXl1QSt2WmRXckR2M1lCZG04eXFW?=
 =?utf-8?B?RERod2ZzMmZCVUhyUzVFRFAxbXo1ODJldSszYjIrenkrMWhhTlM2YnlPSmVr?=
 =?utf-8?B?ZDgwaWJ5SXFOTjljeW12azVMZVRPOEd3Z1M1VHZneG03QlIwVDBCeTZQV3ll?=
 =?utf-8?B?dnVKYndpS0ExMW1ubDFSeW8xeUw3M1BLaGlBbEVDMlpKWDhlWUI5MlduV1RB?=
 =?utf-8?B?bUhOZXo1QksrUUpYMGNob3NmVktGdFFuUTVUTzBIZStxRlM2aVJhbGhjVm9o?=
 =?utf-8?B?ek1WTmhwbkxmNC9hcVVESzFleUkrSjVDVnZiTlduSGI4dGdOQ3RCcjErWXJh?=
 =?utf-8?B?TEZRRThxb2FiWFRxK1YvZmpyVk1hdWJORFprSGlPNGhZd3o4OXEveG81Tyt4?=
 =?utf-8?B?K2JrWlZtMHJZMzBRMjFLYVJxaE54Ry93c1F4SUw1RHpqLzBuUGZhVlgzUWNr?=
 =?utf-8?B?anJuSmFKSEUya3lCa3hvN1NjejYrMkFtTnh1Q01OSWNZZ3p5T3RHdGRUT3Vi?=
 =?utf-8?B?dFppeUIrS0FZNFBTL04wbTZ1ak1tZWZzc0pvd2h1OUQ5VU5TMVNqY2xqbHpJ?=
 =?utf-8?B?SlRaai8rZi9rUkZldk5URUhyS1pDRTNzbitMM2tTN2dOQzNSbURERUNCTDhK?=
 =?utf-8?B?YnJqcG11V3Q3dnA4T2JMRFdMSm94NDhBWldjZzRFL1ZQWVcwaTRQWExYSm8r?=
 =?utf-8?B?THUxZmM3UjJuRUszK204ZmJVbE9QN05tTFgwVys5RHArV2RtOVJuSzJCaEUz?=
 =?utf-8?B?SjdnUk91ZFVDR1A3S1pFY1dnTWdoNklGamJHRTdEN3V1cXVMSHhUWnorRjgx?=
 =?utf-8?B?TzEwaEhWREUwK0RnSkordzQxcm9KanlHak1MR1VvZGQzcm5IczNzYkgvV0k4?=
 =?utf-8?B?c1lzejFscTFySWFLVnZlYVpNdndidm1sdGVvZ1JhU2lZUnNmeVZ2MkpyTWpG?=
 =?utf-8?B?KzZTN0t2bmcwOHpTZ2VoSGJiUkgzN3dIeWJrQ1Z0ekoramNCMmpGNXBITzBR?=
 =?utf-8?B?UnJjR3pFR1hkK2hCWjZWZmY1TEhXbWtkUUJ0QlkzcEpvMjA5SnZzOCtES1dw?=
 =?utf-8?B?aEdxRUhMdE0zTnhEWVFSaXNlbVp1QVRHZXl1dUkvdm5ueTJ4eXlUSDN6RStY?=
 =?utf-8?B?L1lMVGFaYWpVVnJSc3FJZmpJaWZmaUxDRXBvRm9Yc0lrL3Y2RUwyRUNCTnpo?=
 =?utf-8?B?SjQ0OVhtYU5qS0RxeDNHTit2SVlIUEZxQW1CRnFwZlhLdDB0cnVyTER0Q2pU?=
 =?utf-8?B?QkVXRFh5Q2pOWXJqRzV5eFpMU25aMmQrNHpwbC9HWjBCcEJTdTRhVnFHOGlX?=
 =?utf-8?B?SHdtTFhUeU4zM09BaGh5c010dEZGbVpkeGdqZFZXZDlJbVoyK2ZuWWRkUWtp?=
 =?utf-8?B?NGtsd3RuNk4zcWthZm5kdlZXenBKVUFUM0hsNDg0L3R3cVVMUWxBRUdGV2xu?=
 =?utf-8?B?ZC9lLy9kNFMxbmZMcEFiQy9RMStzMzYyd0dGa1hKUVlaQ25yaXFUK2FZSVpV?=
 =?utf-8?B?ME5iUHVMb2o0Qk5jQ0JObzlzRjhDb0FWWlRkYnpJanZ0bElySVovQ3NVTGlh?=
 =?utf-8?B?M0dpVUllL3lqU1o3bGxVNnprdG5qbEhiUU9PTjl4aEU3ZHpsR0hkT1AyTTFh?=
 =?utf-8?B?L0lwdGdjd3puMGFyTHRFcnZWOFNzSTRQQXM1cmpsSlU1Z09ERUNBbWZ6Y2dO?=
 =?utf-8?B?Y01VWERkKzlvQ1RsbHdUWGZyZVhONG9hR1Z5VlVWVFBpbEl3N21pTnZ3L0J0?=
 =?utf-8?B?b0o3eEgrNVIySDlWVTNuT2ZxZk5Ca09mVUY2NHRXeXp5enk5d0NzZ0Q0N0Jj?=
 =?utf-8?B?VkFLQjFaUjdFZFNKeVNGa25xMmR2QTZHeHZIblBYckxuRjl4cU9sM2NBL003?=
 =?utf-8?B?YVkwbW9BcGtER2JIZEtlck9NelJNd21tay9TcVV3T1QrV29yY0c0Y1MxeFNR?=
 =?utf-8?B?Q0NwRi80Yk1lZjZIRmtWcWcwbzVIcUgxbVJzMXJwMnU0OUZCQi9qRUdLK3Jo?=
 =?utf-8?B?b051dFFWZ3dWVW9HbTJMa0FiNlNnMjBTUzdzeEJLNEdKNm9TVVNQWnJXakky?=
 =?utf-8?B?VnR4Mzk1NUwwRDdpREF1aUI0eG5sMWVmZjNCTzE1eXZFcm4vUjZwMlZOMGhh?=
 =?utf-8?B?cEU1c0x2cUtpcHRjNTdCNFlGT3hXQ2FCRUwzT3lUSWZQNWZsbkF4ZFIvQTl1?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4f38cf-5394-4d36-e6ac-08db363048fb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:48:41.7754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbe5zcp+sRMc3Bn2tYDdN30iz+ojrBSuH8z4dZfc/iN9g/nNQXumkGicjMdNLriNHiTPF5XE+QKD+l4LZ29uDEalWxau3Jzl8xqPunF2jMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7646
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/20/2023 10:26 AM, James Morse wrote:

> -static int resctrl_offline_cpu(unsigned int cpu)
> -{
> -	struct rdtgroup *rdtgrp;
>  	struct rdt_resource *r;
>  
>  	mutex_lock(&rdtgroup_mutex);
> +	resctrl_offline_cpu(cpu);
> +
>  	for_each_capable_rdt_resource(r)
>  		domain_remove_cpu(cpu, r);
> -	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
> -		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
> -			clear_childcpus(rdtgrp, cpu);
> -			break;
> -		}
> -	}
>  	clear_closid_rmid(cpu);
>  	mutex_unlock(&rdtgroup_mutex);
>  

I find this and the previous patch to be very complicated. It is not clear
to me why resctrl_offline_cpu(cpu) is required to be before offline of domain.
Previous patch would not be needed if the existing order of operations
is maintained.

Reinette
