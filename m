Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7603E64E0C4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiLOS2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiLOS2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:28:10 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3FF49B5C;
        Thu, 15 Dec 2022 10:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671128890; x=1702664890;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=znQiGulr/HlttWpBhEEq08cYht7NHTyuiO4mjh148G8=;
  b=XmHxad/VnANumJWOkU1rTAUuRrGzqqjl2L66wnkGGiW5z5GYAuh/+5L6
   VyBwrkBIdPFRfFhy9hNSH+OgG6toOSliUWzGw1Qswvaf9h8NDKyq3DPGE
   WffbTNXhLuiicmp8hbXTPRJRO6SXNGGFwDdUn9i+uknn+sbmisaxr+fci
   SG/jiaeoYzzntcuczm8/TrIMWvLu8nlyFFEioj1W1w4tTfxJIM3k7ktZj
   ZXeE/LGapkWpVyM7B9A03kuGYF+F08dJopXWA2+OcwO4S978m7TrA5owx
   4vIuPdiFK9f8dPSmgyuK3ct02WV0LkCLodQ9JBH+mX/vqK2yrs/QLjvy7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="320649406"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="320649406"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 10:27:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="718103087"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="718103087"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 15 Dec 2022 10:27:02 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 10:27:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 10:26:57 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 10:26:57 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 10:26:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isJ/Laqg9DMti6/7eXsPtPJQ8M1HbWracC5rw2FDXmcFI00/XMt6GM3r/Ykz3gSKR3ZG0f8lqT5XGda4NQoOuAyCaWyL09FAhRG26MExCAFgljZoOqhLc3lgLaZyRvAc4iFOQF9teMa5oZ6aJuQN3fY92sDpy9ukuiOfl+KtkaEuvjEMjoTSfRGjHxyDURn26xgq19/Bj7WzU5Zd7p04jvoBH4VC1aMLFL2r+4MvzNqEYrGmtat3YUP6QSbM7NThbmezu2TYkkuNCz0PLb+xg8wujAFwJqSHz3Pul/X2lVcM1ZDDAAhQPQ61pr51rpxZPvlTOP5YeAUTBnzRdBO0ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JI2jkpnmn7CDmJbq4Tbiwy5X6TRsBoa6I+W1SretV2c=;
 b=hhtfLnZ58ypxZjVhLoWDdysZbfOhIj+ddWpwI7tz+R09SS/Oi0KoiN0tqqCc4Txd4jlJOxuDSS0jCEdn5gIUWCv12DCPHsvbQ5jIuzN7GBXA+pBsRQYczAZmlFjgFn3rouaFs4Eoew7RKajz74P1EcK39QI8lV+djrg7AOIzrPsUoPaUmrkziEQ0/cgAu+QAjCyEkAFNwbnwJG/zXSVbOCXQ3S+D+UjD+wiUwi7SFPX7IxtbYoOvQpqdxlinGghXKtEH8PNduh8YeR3jQw4qq4R/AvSJP3kysy4Yi+CsxHfSaTpozlC4KgqNtaxucARcuCN26SFFPZV/l3DP9Nh79Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY8PR11MB7799.namprd11.prod.outlook.com (2603:10b6:930:78::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 18:26:42 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 18:26:42 +0000
Message-ID: <27680a78-d9c1-b86b-8aa4-38245d0547d7@intel.com>
Date:   Thu, 15 Dec 2022 10:26:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v9 12/13] x86/resctrl: Replace smp_call_function_many()
 with on_each_cpu_mask()
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990904972.17806.4220672882391241296.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166990904972.17806.4220672882391241296.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0060.namprd07.prod.outlook.com
 (2603:10b6:a03:60::37) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY8PR11MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ff815e-f1a7-4352-3da0-08dadec9e9bd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KgyBnVjdsRECuXC4gDyROp0ryOLcgpbXQ2fvjURiLQUzPTiQ+G/EuTtJcNJ1dPdKmQk0VQPdb+OjwUt98dmnvb4bg3UHNzAJIL+x6PYaQN+ExL12a8ri8o8fPb7IJGyJEVHqwSDgHtwKV075Bu4/1zxffhS5jXIV1nWTQY9m8OVie2TnqiPCPqIBtGGwqPgve/BH3XRvVoBFfxKB/SSjv10M9M9o40oNdqPlS7nlCBxuZQa/CocA7XNcqCzPuENn719YQ9Vid+i8cDkhzdlK5+i6anRA6wOVEmise5gh5FeFCAfdprEbOwNmMy9GX2yiqNbGt+ocC+xOpb4PDLSa7fUeMOUL8hXHmCdmKByKVrxoripUk3fu1L1od21Ypa/WXmPFzJfVisE2aXemkax1RSqeG1ybdrVIg+5UevJlUVxglu/BQg5hivT5Z9t5fMAZDMX+1ELHIO6uYrE42midxY8T55u6kCuRwYY5f4m6kCf0632BNg2mXExPl4W6tIygIQ0pcGWs11SNBUpJtChxB8ZTaGwtdBfqlagQXDElJvLDdLZzmBIAJ23ql1f35OVQ1pzlPM6izHY8S91/hEyOx2DXaZprFkrPojLVLRT4YNbaWuFCRqMKpkBMq0v+lzA0CxNv2YyPINHzt342TSePsFkGflXT3hHyk4M2fv1QNTA0QE4pAKVG8DzaWZpdd8bkSgmtwuSUmLVx0LG3Cy+GxCZF4lIE3ldRNr6pNwc2vOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(86362001)(31696002)(31686004)(478600001)(6666004)(6506007)(6486002)(53546011)(6512007)(26005)(186003)(82960400001)(38100700002)(8936002)(41300700001)(83380400001)(44832011)(316002)(36756003)(2906002)(7416002)(7406005)(66476007)(8676002)(4326008)(2616005)(66556008)(66946007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkNHbWFIZHJsbmozQ0xTYWc4UUlQeUR1TzhUczU0Qnc0bVFkNUcweXdFVDRM?=
 =?utf-8?B?WjViZ2doZWVkbHlSMjFBbWNXNTZmcjk3Q205ZWVEemI2a0lPOGZLajNKeW9z?=
 =?utf-8?B?MWtzUHZUc0NYQTRnaFRPYnh5aGxnOUwrT0pERkNEWkh2emlGUHVvVzZnT1JS?=
 =?utf-8?B?OFUzUVZyTGJzVTdvWHJTazlrZkZZbUhtRDNkNnRYQ09uR2NZdVNsL3lIUzB0?=
 =?utf-8?B?eEJVS1NkckNVVFA2YUM4dTVYRno0a1VsdVQ3VkdMQTdJZWtVZ3kwQ0QzSjkw?=
 =?utf-8?B?a2c4QTN5VHdzY21VT0VhM2JLanc3Y3dJSUhhZ0dCY3JyVlM5Q3djMzRNM2V0?=
 =?utf-8?B?Z0hna1BOQ0c1c0NxdnBuZzVNUHBmcTk3L2tiREE3dzFPb0Iyd1FkUURLU2ZP?=
 =?utf-8?B?cmVrTGZMeFdYYXp0T210RHVRajJ3Y1paV21NWHZuRXRsQ3o2WS95YWxhV2or?=
 =?utf-8?B?eWdTcHdtTXhFNm9md0hRRE5wTmtzaDNBa0VBcTd2TmZyaitGa0pucGg3TnpG?=
 =?utf-8?B?cW8rRVBnWnZmc0h0Wkwzc0VyeTdxS0ViRnM4bTRXQ3FjY3Y3MmorVGhBZlUw?=
 =?utf-8?B?V05lVmxNVTFpMHhyM29pR3kyZm9PQTN5ZjZsUmEvNTBwMWZ4amdnOERpY0NR?=
 =?utf-8?B?UHVwQnFyc2NnZGtaT08yWGRONjlwNEZkR1hNUkRiQWt6TWNGellCTjJoeDF6?=
 =?utf-8?B?NEYyNVpxbEhJRTBock13S3FhMWNtbUNxUEV3MFFtWEpNMW1aaFBuV3RIMFRl?=
 =?utf-8?B?Vnl6Wmh2b0hhTXRDcS9WQUZQU0d1NjdGM2IrOUF0Y0xreWIraXNDT2ozN3lh?=
 =?utf-8?B?YVJWV1AwWkRvNXhpQm1GWnhjbkt3UTlrOEN0WlhibVVQb3FOY1JPakpqRENN?=
 =?utf-8?B?SmlxWUZRUnNrR01ReENpRCtGZkx3V3hCOUM4OFgrMjUrSW00QW42M21sdkJH?=
 =?utf-8?B?bXRNWi9UY3NMcXg1dXZqVWovcENtWmZKc2IxeENsZ2t2NG83TThRb2E4S3NB?=
 =?utf-8?B?V3gvMnV3OGV1RWszQUVxK1ZCK3pqSmlXOU1LQjdYVkQ2VytOUW9rQ1RldUxq?=
 =?utf-8?B?U3BnTG54Q0pQTVpiZnR4Uk1iZ29uU1owTTVtbVlrZ0ExeFhmcGY5dGhmUk1L?=
 =?utf-8?B?ZVBodWl2WXN5MHlZL0svdHNvZFg5UXQyZmdkbU5yNHhjdFlTajhwRkNjYTQr?=
 =?utf-8?B?bkNvaDVqRzNxS0lXN2s3bko2SkJRaVpaWlpLcjhsbW54d2poSXphSnFON0Yw?=
 =?utf-8?B?RTZhQjVEWkkyNzJZOVRld0hhdTZFa0pPTjNjOFFpYlhiU3pjWVpJNkFMNHg1?=
 =?utf-8?B?WjkvaVRJblBQYmNuZEl6YlBmNnJGQ1NIazNoVU5adFMycTJCaTdqMnNST1Zx?=
 =?utf-8?B?WWgvUkJXbUora2M4UGJUbjl5OCt0ejIydEE3UWx4eUVodUJUMFVDUXRPU0hY?=
 =?utf-8?B?TjBLNkl1eUhMVGJQbTNBVHYwbVhkZkN2SFpPY3N2VVZJbFRSU1FucGx0bHVL?=
 =?utf-8?B?cjRFajlqelNqTjREOHJNK3FGbzFNMWdiM2hSc0hVeEFHOFhUeGNyTFJtd2ZK?=
 =?utf-8?B?alBKQWxiRmVkV3RBc2JDL1I1U21xaHpDRzBRbTllM3hseTI2a2x4OVBscW8y?=
 =?utf-8?B?UmJXM0Z6cDBxY0hiRW80aGJxRGhla25VNDUraGVVZHI0MmRXWkZFc3lWR0t5?=
 =?utf-8?B?dGZKTXlBRmVCeW1MbzBBQ2lCdWJBZVJrZE9iLzd5NXljcnJSQ3JMQ2tqaEJJ?=
 =?utf-8?B?bkxCUGNQemE2UFB5bEpYOVFOeGpFYlA5MDhTb0JKVEdKbi9uQ0xzSllKWk1G?=
 =?utf-8?B?aEVOOHlMZndaOHBrYkFKWmNMWVlZZlo4QjM4SHhuTmdLYnAxTW9CeVBBemZJ?=
 =?utf-8?B?dmVEUzUzOVZya1pFNWNQWjUzWFJJMG1OamljenMxVGRNRUZ2S1NXN0M5QlZr?=
 =?utf-8?B?UFkrRnUyZ0lkK05KdjFQVFZyOGhLc0U3KzFScTNYdHBDNjg2a3IxM0ZETWtq?=
 =?utf-8?B?RFBjMDBlZ0c2czA4U0pIT1VMZUxrSHJQZDR0Uk9MQkN1ajF6OGtIY01XM0ZJ?=
 =?utf-8?B?YTVMQlZ3VFlneXNhblhWWE5BZDVsdVgxWTQ4TjFIVHdCSTlUb0FpbU5PMVhj?=
 =?utf-8?B?RjF5d1gzcGV6eTVsUVk5OFl6K0Y4NjJoUStpN0VSY3BSdStkdlJ6RVo5WUpm?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ff815e-f1a7-4352-3da0-08dadec9e9bd
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 18:26:41.9507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNZ2SOIx+n359VnEHUCCWIKjPTILfJNklnGCd0cUg06oZJoo3ddz1KhoOGP108KUahf9/ob2eYqts0EsWszYFoX04m+0KLfu7nv7YI9OniM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7799
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 12/1/2022 7:37 AM, Babu Moger wrote:
> The call on_each_cpu_mask() runs the function on each CPU specified
> by cpumask, which may include the local processor. So, replace the call
> smp_call_function_many() with on_each_cpu_mask() to simplify the code.

Please move the solution to a new paragraph and drop the "So,". The two
instances of "the call" can be dropped also.

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Could you please move this patch to the beginning of this series?
Fixes and cleanups should go before new features.

>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 6897c480ae55..68e14831a638 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -325,12 +325,7 @@ static void update_cpu_closid_rmid(void *info)
>  static void
>  update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)
>  {
> -	int cpu = get_cpu();
> -
> -	if (cpumask_test_cpu(cpu, cpu_mask))
> -		update_cpu_closid_rmid(r);
> -	smp_call_function_many(cpu_mask, update_cpu_closid_rmid, r, 1);
> -	put_cpu();
> +	on_each_cpu_mask(cpu_mask, update_cpu_closid_rmid, r, 1);
>  }
>  
>  static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
> @@ -2135,13 +2130,9 @@ static int set_cache_qos_cfg(int level, bool enable)
>  			/* Pick one CPU from each domain instance to update MSR */
>  			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
>  	}
> -	cpu = get_cpu();
> -	/* Update QOS_CFG MSR on this cpu if it's in cpu_mask. */
> -	if (cpumask_test_cpu(cpu, cpu_mask))
> -		update(&enable);
> -	/* Update QOS_CFG MSR on all other cpus in cpu_mask. */
> -	smp_call_function_many(cpu_mask, update, &enable, 1);
> -	put_cpu();
> +
> +	/* Update QOS_CFG MSR on all the CPUs in cpu_mask */
> +	on_each_cpu_mask(cpu_mask, update, &enable, 1);
>  
>  	free_cpumask_var(cpu_mask);
>  
> @@ -2618,7 +2609,7 @@ static int reset_all_ctrls(struct rdt_resource *r)
>  	struct msr_param msr_param;
>  	cpumask_var_t cpu_mask;
>  	struct rdt_domain *d;
> -	int i, cpu;
> +	int i;
>  
>  	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
>  		return -ENOMEM;
> @@ -2639,13 +2630,9 @@ static int reset_all_ctrls(struct rdt_resource *r)
>  		for (i = 0; i < hw_res->num_closid; i++)
>  			hw_dom->ctrl_val[i] = r->default_ctrl;
>  	}
> -	cpu = get_cpu();
> -	/* Update CBM on this cpu if it's in cpu_mask. */
> -	if (cpumask_test_cpu(cpu, cpu_mask))
> -		rdt_ctrl_update(&msr_param);
> -	/* Update CBM on all other cpus in cpu_mask. */
> -	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);
> -	put_cpu();
> +
> +	/* Update CBM on all the CPUs in cpu_mask */
> +	on_each_cpu_mask(cpu_mask, rdt_ctrl_update, &msr_param, 1);
>  
>  	free_cpumask_var(cpu_mask);
>  
> 
> 

Should the snippet in resctrl_arch_update_domains() also be updated?

Reinette
