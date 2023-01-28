Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BE667F432
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 04:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjA1DGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 22:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjA1DGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 22:06:17 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134CB7264D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 19:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674875173; x=1706411173;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+YBanM0q4kBNgVzNYFsKiIceQnTmf+Th/Kp+y+9rNPM=;
  b=hWvHxIK+TWshgSUYZWHfo99igRoNAzjmOKgueWg7VLfHFIuCVFqPOAm6
   wwwc9g/KOFeJP4tjdlrpMFziMYSIXY+p9RpPAR/YIpZQSt4QM8HkM8t6C
   z9rCqJCS9pWumWy87Sm6FcwKeglh03XfTIfv7GdB4/kbDPy+EF5ZkYR4X
   Ym5h4noa1dG1frWEb5DS2Y3E9z1c1syvTii3aNoghjKZAlodFyGbFu+P+
   YW+7DwGqQNukHRjwt4+zeL2bhxo5O3dcXPEoCR7sjfKOggo+vo98b94w5
   Mz4CC3yCkLDrLUv4lTmqgZgzS7UyEmT6HN6rcJRKk+vNNnynL0aCXz784
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="306905171"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="306905171"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 19:06:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="726900679"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="726900679"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jan 2023 19:06:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 19:06:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 19:06:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 19:06:11 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 19:06:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCpOpTGDX15Ha8ivpEGmg2fqOmpc5pnUdaYmNaTv8nvSZ97BgdwNngW7FHK9YtGQwdVSELDlEhpMiNcGNjgmonlTGcKzR3ldHXHDC9G5L4sW6gWICpS/4aAEuSxGX9BxyJfYBXqR0TBtR2nPzy5CQT0qxC6oor3lX2U8JfTm/3nws3KAq8KqlMl0/K4o4R3nqU6Nmoo9Z/rSn6CdjI/GzPF76m/hAl9c+TZgae5HE9F79gWv2mcGEUVKRtb2r144RgLgUGTRHmFuMjVLhjzuS5lBaod59CQEnl/R0unieGR6a5XmaKeGFICNPTjLs5okN3YM1ygzarpi8xB3RUEMcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FhKFJUVTkeNiRunWab0a7nF+XFMzxJwTOz3FjWPEf8=;
 b=Zv083wlqep+uSm/DxG3wn3t/XgRP7SbvHk+Ew8fMuuUAc8j5kUWRm8LNvBsP2Ehbv1Ugf1dX8Nf4TJhJ/VaLZKNITGrsV5Z4MwlLDAcYqCl30g7Nq3yF7YcxyXf7kC6G4zfKADQexNYvjP90CPAhHvgs7LU2iDE+MVzMGZOzvGLMjr6ex4/nxw841Tx5Q8pUzA3gDRSF/1zkDQiQrK5HckjzwLrai45UT8SLHlt/sqr2G/IiYvgHnvhhZMEhE0JDM7ZqITJzWRcyhwntfc4xZqTk/dIJyuL3ZZgCWV6kGNsOnVBivtPJ/adbPamoXp0HDvIXu47mFe+dXWvp/NX8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA1PR11MB6710.namprd11.prod.outlook.com (2603:10b6:806:25a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.28; Sat, 28 Jan
 2023 03:06:03 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4%3]) with mapi id 15.20.6043.025; Sat, 28 Jan 2023
 03:06:02 +0000
Message-ID: <9e4d012f-6ff6-aef4-a70d-cc9f1478921a@intel.com>
Date:   Sat, 28 Jan 2023 11:05:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [linus:master] [apparmor] 1ad22fcc4d: stress-ng.kill.ops_per_sec
 -42.5% regression
Content-Language: en-US
To:     John Johansen <john.johansen@canonical.com>,
        kernel test robot <oliver.sang@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <apparmor@lists.ubuntu.com>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@linux.intel.com>
References: <202212311546.755a3ed7-oliver.sang@intel.com>
 <42194ba4-cc3b-c8b3-06e6-e2938df3a87c@intel.com>
 <4fa85b15-1c55-9050-9cd0-fe66c3b957eb@canonical.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <4fa85b15-1c55-9050-9cd0-fe66c3b957eb@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::20)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA1PR11MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0b123b-9178-4a3e-ddab-08db00dc96bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1e0N3LBESrWB5FGSxJIOPBCkOKM7+s6f9syqOR4nherjd1kMskw+tBM2IjPXAVIkWIhSkRJqt0hNl7zurjzowxEqO7QOHWsqvJtR9mnXc10qpKfXG7JaVOc29UdQBgP9YZWMrnREiEeajnl9dkVapOlM2LXb6+qd2ZzgHtwdcQ5Mj9Vx26WTxBm2AghwJ9Mftfxsldg2MPkiOgoPjdPnXVQOQPB4xyrFFkfNz7KLvBUuQ92nzjxV4qJZv/yNF/iWR8yu+MJN+zTA1HwaVfT/F7hW6LkZgzBuNhA4DuTuqVhBkYEAz+MHfY57YDTqhvnoRcF4wxFKUnucxdlpRMTfFz5WPKp/Ai8Rrs3bR67oJo0soVRQptUcg0gPZ+f00pAqudPAE/q0Mqju7VtEq3eakNmYQR7z+zuhTuWzVdg0XaBSU/oKfBsKTokGINZdybHMn1Sza802iv5fyTvygikwhWlL4QDFW1+aM6UP//xpdeHssbI8nISqxe0mHNE65XbDxgCOXQFig7t7LUTykzeGr75PMEG4TBuwRbkI3ikkshQ4UOu80hxC/N+ebwc6tI1xT/Pj42Kt/OkUlVKzAQkK2yutLSaMzzm7C4+2moom89F0dKhNZJvKLFdPNIsRtCu7UNyatkZJuj9/5K1Fl7bqBXW7bBc19eE15u1eJwqN/BFW0rHrCjKJcL+gHrt2cbLpuy+X5Sb62uZ6sEFBIgSDJLnQmKpgGXZEKAsVCA5hkQiycZ66yjUQhxTz0dRtoknKTwyJF94ZUraBLFRPGz+ODw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199018)(8936002)(316002)(6506007)(6666004)(478600001)(86362001)(966005)(6486002)(31696002)(53546011)(38100700002)(2616005)(82960400001)(26005)(186003)(6512007)(36756003)(6636002)(110136005)(5660300002)(2906002)(83380400001)(66946007)(66556008)(8676002)(41300700001)(66476007)(4326008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWZWUXpMMENxMnlwMFRaYnZKK2VsMlhSWkljMkhQOGs2dFBydTFCWmQranl5?=
 =?utf-8?B?Z3lNM0VsMVY0d3FUaE5VY1ArODNjS205eVpuNWQzaGs4bXd0RmRrRUxMNTVh?=
 =?utf-8?B?N1FHZmFMNzErT1R2QjdQYTJ2L1lTNzNNNTJYUitkYjdhQUdYYit2NDhYRVU5?=
 =?utf-8?B?WUR6b3NBREJoL3FJalFmRGo4cEZ4OWNGeVFxYjBRdGF3NkprSzJuZXUwWEdm?=
 =?utf-8?B?b2dGTXpkODJ2Mk5NdG9GeEV0RmdzVlhPUkxxQUt4SWQ4ODcyc2xJQjZyc01N?=
 =?utf-8?B?OXJXeTBSMnNSeHRuUkRaM3VqUzZSbmFmWStRdFIyZkRHSDNwdmJVbXVvR1Mv?=
 =?utf-8?B?VmJUbTM3V1J3a05KbmxDdWQvV0d2dkNrNHJzNjNEamhhYVhlTmVsR0J1SE5i?=
 =?utf-8?B?NnlLZUloNkJrT0tjMlliWHNjRmZZVTY5ZHNJWC9FSjhrbUNKY2lSNzhUQUdp?=
 =?utf-8?B?OWlpUWtWM1dGWGtUKzZEVzYvbnJBdHZXdTNxYzNaRDdFQTJDSmZZZHhydVpk?=
 =?utf-8?B?QTlkbER2amNFdTJPN2paUnhPaWZ3N0FGWU14emI0WkdQRHk1TTYvc2gvV0ha?=
 =?utf-8?B?Wm1Pa2p0cXhaTW8vc3l1dkxRODQ3WDRvSDhtRmJUUU1QaEhoRDJjZUU4SGR3?=
 =?utf-8?B?TVJZeUZsbGF1dS9uK2ZHQ25KUkRiNlAycDEvR1lpMWl2L05ZMFk3blVIOTdj?=
 =?utf-8?B?RHJud2g3TjBGdFcwZ045NzNnUXRjTm8yeUtVNFE0dTk1dkF3QlZkMHBjd2pV?=
 =?utf-8?B?MmpzMW81TUh0N1hCZmxvNmJvWmpDd25UV2l0anBuYTNKM3NJNWhPakdiWlVv?=
 =?utf-8?B?bHNCUlczakFiaFZaSUYwVXJKaGZiZmtkdkNFempwbW1xVGI5MTVGR2dsaXB5?=
 =?utf-8?B?Tm9Pa2MxM05KeklXYTJDQTUyZzQzWXYvYmlwS3VoRHhGZlo5N2Izd0dtSnM0?=
 =?utf-8?B?RmZORjF5K3hQQzJFWXd5Z1BKam9pYzNWUDhDdFEyckgrWFBuZCszdU1oNkpR?=
 =?utf-8?B?clNLbHdpdS9yb29xTUVmZVVUOElJSVFoZUV6eGt0N2NHK2NoZDM1QzBVV3I3?=
 =?utf-8?B?WENUMUpYSk5ud2JwRHRHaExka2xvRUJWU3BvL2htRDNaT1dPb3IzenFyRFRs?=
 =?utf-8?B?MW1pV3VCM3Z4TzVOWDlDYzRLaHk5aE4xalVyTjdRaG5rNC8xTUdQTlBxR0Nr?=
 =?utf-8?B?QTdBRzl5djJYamdHcDVGRWZPYnFjVytaU2hJZmtCbXdRR0xGTEx3MktMdkF5?=
 =?utf-8?B?NENBbk5ZaElxbEJ3d0FMWkk2eUVUalpWUHc4MExMRmgzUnBSbWtVYlVabkd3?=
 =?utf-8?B?N3poOG96UWpDSjJ3bEJYaG4rUHF5RnM5VDd0QmZsL1RncmJiRUoyN0FQQ3FJ?=
 =?utf-8?B?cjlRamU1Ni9CRklPSlJ6ZVJpRDVwczNRWFBCdWgwZUMvelE5UVdmRkRPVU5r?=
 =?utf-8?B?eDJiRUtFZWF3aWpHem9rRTBHN1ByNENkTWd0YkE1bHdLRVl0QUZsUmx4Yzlu?=
 =?utf-8?B?YTVPSkg1TDA4SnY0a2FtN3FkUzlYWXp5K2xJWXVNNGdyRFNDaDZDM3dZOVB1?=
 =?utf-8?B?N0JxQy94dnIvZVZUeVV6ay90WnBWYmlST2VCOHdGL0xJUkVjNjZkcnhZU0kz?=
 =?utf-8?B?cVBRdVBEMXo1MEpGamhhbmdzejBoNENlWW1DTEgveFMxUWFjSFNDVWhhbTl6?=
 =?utf-8?B?WXFoaHhoMlkzUDExclJoN2JIbzF0MElsYUlBSmhjbnlOY2ljdEtMRlFKZlRo?=
 =?utf-8?B?TGludk9rd2hrRWl3N2x1YnlKZms4cG1XNEFWZUNSQUFQOXRVSkJmMlNyaWFy?=
 =?utf-8?B?NjZldDIzWUMrK00zTmhDYzNvU01jdWhGTkNUM01mNzV0cDZsOGgwRUhySCtv?=
 =?utf-8?B?MVVRaVcvcnhNTHd1WmxEZkVDWmpFb0RYSTRDbGJRNjRibzdtV2dHYnpFSFFp?=
 =?utf-8?B?UUJYNUN3UG9jblhuaEVTS0t3VzRGakplYTVqZUF0aDlUVFhDMDdaY1VxL0Vw?=
 =?utf-8?B?ZFV1OXR1MjkvMCtJTUxKamd5aTF0TndWN3o5ZmdJMmkzVzlrdklwZ0J0WWgz?=
 =?utf-8?B?TDVBR2Fvc2Jqay80dE9mSEhtQVFwMDJRdy8yRWxCVnNicFM4THdQL1M1WDdv?=
 =?utf-8?Q?TUzghcS1JBLw3gzCaSiJZ6eLM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0b123b-9178-4a3e-ddab-08db00dc96bf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 03:06:02.7830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hif2pDj6UAPQGyOl3ddFYodv0hFTz5bY6D1FTgvIz3TrgsC14BJtTGly6zwQ1pd0PqqJhk8SuxYcam/FBPoN9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6710
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/28/2023 10:34 AM, John Johansen wrote:
> On 1/27/23 17:37, Yin, Fengwei wrote:
>> Hi John,
>>
>> On 12/31/2022 3:18 PM, kernel test robot wrote:
>>>
>>> Greeting,
>>>
>>> FYI, we noticed a -42.5% regression of stress-ng.kill.ops_per_sec due to commit:
>>>
>>>
>>> commit: 1ad22fcc4d0d2fb2e0f35aed555a86d016d5e590 ("apparmor: rework profile->rules to be a list")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>
>>> in testcase: stress-ng
>>> on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
>>> with following parameters:
>>>
>>>     nr_threads: 10%
>>>     disk: 1HDD
>>>     testtime: 60s
>>>     fs: ext4
>>>     class: os
>>>     test: kill
>>>     cpufreq_governor: performance
>> Do you think any other information need be collected for this regression
>> report? Thanks.
>>
> 
> no, I know what is causing it, I just haven't had time to fix it yet.
Great. Let us know if you want us to try something out. Thanks.

Regards
Yin, Fengwei

> 
