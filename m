Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F2464DF90
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiLORTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiLORTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:19:32 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0B643871;
        Thu, 15 Dec 2022 09:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671124764; x=1702660764;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hxfhKQAt/NvXHHSbx4PV/0LUEDx5tJ+p5GBCih7/YM0=;
  b=H+mtu44xBz53Rf317pNkoqJ2FFSn2heIAa0OHJeGXNQQP4yelp+gZL14
   PQ6jwOJ34ZvQP/VAhsVC2x9artOhb/qnCKEFYB3L8deAfUjnmuaoZWw/h
   7brCSNgfHMGamihVbBrlWV9CaUf8w/cKbkvM3wi0Qsbz8j8nA/ToyG3jJ
   /FEzI3nJMXoQ7QlyllOF3KMcvlquyq8pZeMg5+5/bfU9MTgVUci0/Y0g8
   /iRO/kC+QpF+MbPR//bq0aJhUTPpYcOGDFFtKeCu3eJR2m5JKRmpK+6x4
   1r2BDGXXxtRmb6q4LB3S5+H6FGGg+1QHkH4dtGj5WgTj6TtJVXJqHYyMP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="298413166"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="298413166"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 09:19:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="599648858"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="599648858"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 15 Dec 2022 09:19:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 09:19:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 09:19:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 09:19:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 09:19:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WORn5aTlzo1/HZEa1/vl3txYPK3j49E0QXuqKeDfu0eJKdTSJ2ylQRhj4sLDYbBhPTCWsr2D3gpZXnT3fTHltvW2hDCr+5Yn+Zmo1ylTScexj97WQWOLUHiKfqyTdl2UZs3io/DWdT4Nbkc/aQLVyOYh/EXAmfYtR8TpWiJrHUtZz4SPfA+DBVW/1zkug7+D7ZbUKjqCU5f9O4OME0ulHtOvCc4AHMNNFQ2n1RAWKVUmcYWwsF83max94kEfZbb2CB7Kp8tGKelIyqTx70EIJDb87/E77zKMfQJhilG1p4BaEbK5YB7HRmpf1Gm1t7+52xyzs7orgRvvfGkdgS63ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yf5M3lo0VK4oFI4PriwwQR3KFHC7mhXKvx2qislemYc=;
 b=I8/7zgoZEf5IRLXOOy0VEN5lhtYHwZeRqd8GN/DueeYX7lX9vf+rgjmQIhsfmifwvsns1jR5Y7SQC5YPmwNZMiozMpsPxAG2Aw5Od8K0t0Rk605iR2quCXEekW/a47Y+zW41PFMskb5n6o8zVB3Jb6DGx+cJi02ASxQ1XE1sJ7iZ3qNxlq26K8mmLENjybG2w1EMSrb8l8jPPtK/GUWLbOM+8sb+a0Igas4ZlDEW6yUWobVDad9Hn3HKpNTwGkENhJizWt+5TsHiJY7fKVjylwR4GrvRpsBmwUH30t9+tgE8fGQf3/qzBYT+0c0BLiLsvSw5LuK3op239NH2RxnXFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5560.namprd11.prod.outlook.com (2603:10b6:408:105::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 17:19:13 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 17:19:13 +0000
Message-ID: <20ea6828-8ca9-3106-7eac-00fd9cec5fed@intel.com>
Date:   Thu, 15 Dec 2022 09:19:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v9 07/13] x86/resctrl: Introduce data structure to support
 monitor configuration
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
 <166990900849.17806.5346239458898437535.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166990900849.17806.5346239458898437535.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0035.namprd08.prod.outlook.com
 (2603:10b6:a03:100::48) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN9PR11MB5560:EE_
X-MS-Office365-Filtering-Correlation-Id: f90ee113-fb61-4921-f30f-08dadec07c4a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x7IYIuJ+U0YYNRUxdDLFDVXsDNy9d4oowRvTfBR4nhdTORQzyZ8H8Wekz9m3+l8IUTuNt16JkufUGImln10Mrs68S44tYLvPDNNLvyIqXPRO+V7M1mIC1t3oESgegQHkbpMaHG27ue5Y9rPdDq5iEvJ6+GACuXfCersXEamiXlfMaxrCbwZh/43X486b1qKfCeYBzCpynpUc7XqrVXtwmOjK1Klcu0efbmbD6Vn2VolLEVXgZmQ2b6VPJguNUr9nrWP7Y24fwfMfN5Gnr0Dt+z4oB0GPYWShT9FCssG90buUAOwnbPC9Aripl3WzVXWeoL18Vk+KqUVBA/XgRJ4iukp8iXn8eQ7+h3S7/eSBADC9VodQYUMUJE0gZTmlJ3UW24WJpj12f+LMYbLfFvEwThXm0VYzY6yxlZA3twO398GJVZEsZ5K8Gm7Dfi+PXnl2QkbJ8tI11NLsrBPpzqZChfAAB7yqYnHbqcvmVLBs80UtsWvbCluoGKHHk+asDZHnwo1IjUOoFbusj+mllddKzdcZfb+MZRm5iN0vWuEymMwqWI+P446qwDR3EDp6pN6kozZdSpZREB7ZC5eLB9BVfs08vzjm8w6n1jQeL8RDSwtV3c5BVB041QPxvbhb7YkK4OrQV5oMEzfVKNjBnr6EL5NNHBBmezEgclPRl98cR3p+urC338PoKc0L/ON9M0tmEMcQJYLLgAWBr3TH8fR5K0rLDX+H+Spm3FfGPIC1YCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(31686004)(86362001)(6666004)(478600001)(31696002)(6486002)(38100700002)(53546011)(6506007)(6512007)(26005)(186003)(82960400001)(8936002)(2906002)(41300700001)(83380400001)(36756003)(44832011)(316002)(4326008)(7406005)(7416002)(2616005)(8676002)(66556008)(66946007)(66476007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDhyKzdXTk4vZmVTQVVZSUF3SEx0dkd5bXN6WHNZVmtJNmI1cmtXTDdqMGxh?=
 =?utf-8?B?bHZZZHN6TU1UZ2Z2UWVMZlpMNm44ejhxNUVYaXhzN1FCUjEzWGpSQUtCS3gz?=
 =?utf-8?B?MUcvSWFiZDhUR1BjTnJmejF6Ny82aUg0OTM0K1pmMUIwQW41ZVhxRHJXcHZs?=
 =?utf-8?B?ZkwyRitrWVJwY055S0xLczBVWUlCTWV4NHNITitSdzRVWENxNkc0ZGlCMXNz?=
 =?utf-8?B?cFBZR1VXbjZZS3ltS3hxYXFFY0xhZFEySis3U2duTmRCdXY2NHVDd3kzbkhp?=
 =?utf-8?B?RnJ6OTlMbElTS3F2d1NRK0ZQdlhhVjM4Zkp2Qks0U3lHaG0yNldFZ3h4WE4y?=
 =?utf-8?B?SHM4OWJ2TTQyTVJseUNaTlVZUmxuU3JjN1lVSmR1QnZ2Z285VGlhdmh1Q1Fo?=
 =?utf-8?B?Y1hlQkFVWDdFVzdRNWQwWlFQaUJhWURpQ1kxMW04QnFMTVZZdWxvRGJ3VmpP?=
 =?utf-8?B?VDVIdTl5d2l3RHlGU2c1aVIwOE0yM3VlbXRZVmt3R0cvOVh5TjRCaGV3WkNF?=
 =?utf-8?B?b2JQNEVyYWljNUd2RHZzek5jSDA3UmllWVdFQmhFS3BjMFBHaWdjMzIwL0FE?=
 =?utf-8?B?MHhnSUVYemp6ZWdnU09EMEpBbWoxcUFJTGFDeFYxd2tSU0xtMzVLSjFldU4z?=
 =?utf-8?B?QnVpNHNQOWg0UEpkUHpsR0lpQkNkcHJIcUlnOEQweHNBSkNBQUNyVUxEQVZU?=
 =?utf-8?B?SEUwSy9tZ3JTT2VFbDN0UmJDVlIwSmRqYThyTnE4WUVvdFRWUFIwT29OQ1Ft?=
 =?utf-8?B?V0I3S0ZsWXRUSGxNMXlSS1NndENQcURqcFRhU0EzUlZmeDRYVlRScVFaV09i?=
 =?utf-8?B?akRxb1lkeVo4QnJQRU5vdGRWbWgyL0lQZllhd2txL1BFZ3JYdkhYanpRdU1k?=
 =?utf-8?B?SGxmOHRkdllHUjVuZ0hjWWxMZnhKM2pMR2hzUEtSKzVuUENBY3VWVXJzNVI1?=
 =?utf-8?B?RGxCNkhVK3lQT1A1eVdoMk9LYU1udUd4NkNPQ0NsUldMOGU1QkFDQy9CRUUr?=
 =?utf-8?B?OE9ZczNreFR2bkFZaWdvNUNEcXdPS0p3U2tQdUppdFRLOEFIY2lwbHRPU0I2?=
 =?utf-8?B?ZStvY3QxYzJzTnppY0hoK09VaFEyM2pyZW85RE45ZWd5bm5EVzZ1UTc4K2Vu?=
 =?utf-8?B?cTZyTU5kMm56MjZiSHFzRXlNR1duczRvQnJRQTJNU0FWcmRPRzN6SmNLS1hX?=
 =?utf-8?B?S2RibmNzd0UwSnBZY21UM3g5K2E3Q0pvaS9kYzhYd1VhZG5zR2pibzB4bEI0?=
 =?utf-8?B?bjFndWtTS29GZi9EQkNnd3oxdVpScXlyclp0NTcxbktqbUxaWTNCTzA0bWw2?=
 =?utf-8?B?N2EyTVplSDVKeG90ZTQvWGNZclhkaXRHaldlcy9nTmVnQXM1TEtBZ0g0bERl?=
 =?utf-8?B?T0ZZcW0xNVFsZW0rVTR0a0tTUnY2YUhKcEJzQjBSWVNXVVBBOHFjdHl1QmNy?=
 =?utf-8?B?N2ZTbndnQnZXdVBENTI4YkxIYUlHMW1ESTJySmdQdkY2R3VBczBuUml0VDdZ?=
 =?utf-8?B?ZHZwOXZQZlpLVFc2b1NreVlMV2V0dUcxOXNtYTl5S0lIMm1BNEpOamthRzNJ?=
 =?utf-8?B?ODY0clNCUFJlMWFVN1RVN3RXNm1XY1BMR0EwSGtRUVNlci94c2FnbHRNVUtn?=
 =?utf-8?B?RjQrWjh4a09aa21yUW9IMFNRbUM1NndQNDVyaFFaNDdCY1hZVzgvMG9OR01K?=
 =?utf-8?B?YlE3aFQxVGI2Z1Z2bzkrTml4SkhKSVFUclB0cDJzYW05Y0VKblRNR1F4OE5X?=
 =?utf-8?B?QVFlVDBOcHZmdEZWRlN6Y2YyVk0vUmg0dzErUWVjMzJXckpBK2pGbS9qczd1?=
 =?utf-8?B?MS9Jc0owSi9NdG5KcEhyZzhJM0w2WXFrSjBVa2lFRmwyWG84ak1PYzNuaW9R?=
 =?utf-8?B?UGVpUXVkQlB2RHh0ZGdwR3BEVlJadmtUV2o5aWdQTXRZZXBYWlhuWjFwSFpY?=
 =?utf-8?B?UmRNOExaVjRsWjFJNGxjZEFQbWl2OElNemlnUDFyeXhrTlZRdWRBMStEbEVQ?=
 =?utf-8?B?dnZzV2o4MEd6a1p0NFl1b1pWYW9yNHN5aWo1ZTRWMEVLWGtoNVUzdFJzZmtS?=
 =?utf-8?B?c1lkdDlETGhiRjRJbUk0dkZXWGU5UHI3dlBtSFU4UG5sajZuUnNaVzdDUTJK?=
 =?utf-8?B?M0x4Z1VwckhjNlROaG8rT2ViUllqQ3JXVzEyU28vaHNicXBxdXpQRWxkTEw4?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f90ee113-fb61-4921-f30f-08dadec07c4a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 17:19:12.8907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3rh13+dS0aA0/9ouCOzb/FI2Xw0r4ROwz7kzsGY5+ajMDj/yWrTfnMpfAQYeHR9hpZTF28+r3eQZjB3XgBhLdKCpLeoJKEcDJDob7swsD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5560
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

I do not see a new data structure introduced. Perhaps subject
could just be:
x86/resctrl: Support monitor configuration

On 12/1/2022 7:36 AM, Babu Moger wrote:
> Add a new field in mon_evt to support Bandwidth Monitoring Event

"mon_evt" -> "struct mon_evt"

> Configuration(BMEC) and also update the "mon_features" display.
> 
> The resctrl file "mon_features" will display the supported events
> and files that can be used to configure those events if monitor
> configuration is supported.
> 
> Before the change.
> 	$cat /sys/fs/resctrl/info/L3_MON/mon_features
> 	llc_occupancy
> 	mbm_total_bytes
> 	mbm_local_bytes
> 
> After the change when BMEC is supported.
> 	$cat /sys/fs/resctrl/info/L3_MON/mon_features
> 	llc_occupancy
> 	mbm_total_bytes
> 	mbm_total_bytes_config
> 	mbm_local_bytes
> 	mbm_local_bytes_config
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |    2 ++
>  arch/x86/kernel/cpu/resctrl/monitor.c  |    7 +++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |    5 ++++-
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 7bbfc10094b6..b36750334deb 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -52,11 +52,13 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>   * struct mon_evt - Entry in the event list of a resource
>   * @evtid:		event id
>   * @name:		name of the event
> + * @configurable:	true if the event is configurable
>   * @list:		entry in &rdt_resource->evt_list
>   */
>  struct mon_evt {
>  	enum resctrl_event_id	evtid;
>  	char			*name;
> +	bool			configurable;
>  	struct list_head	list;
>  };
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index e33e8d8bd796..b39e0eca1879 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -783,6 +783,13 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  	if (ret)
>  		return ret;
>  
> +	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
> +		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL))
> +			mbm_total_event.configurable = true;
> +		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL))
> +			mbm_local_event.configurable = true;
> +	}
> +
>  	l3_mon_evt_init(r);
>  
>  	r->mon_capable = true;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 8a3dafc0dbf7..8342feb54a7f 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1001,8 +1001,11 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
>  	struct rdt_resource *r = of->kn->parent->priv;
>  	struct mon_evt *mevt;
>  
> -	list_for_each_entry(mevt, &r->evt_list, list)
> +	list_for_each_entry(mevt, &r->evt_list, list) {
>  		seq_printf(seq, "%s\n", mevt->name);
> +		if (mevt->configurable)
> +			seq_printf(seq, "%s_config\n", mevt->name);
> +	}
>  
>  	return 0;
>  }
> 
> 

With subject and changelog changes:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
