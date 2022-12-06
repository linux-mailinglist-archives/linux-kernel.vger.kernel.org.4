Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1188644EC5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 23:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLFWxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 17:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiLFWxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 17:53:35 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7845449089
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 14:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670367213; x=1701903213;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JfM4Fd9cQ0YljZvWLt6gBhz3Ly9Y7XeVTCHRxqpqxdE=;
  b=WHe2s6XKm1ASF3bk4GoQwoOnSskOsAHe/L7aVKyIrnozkt+/OV3GE2Je
   UskvMUszHGsdb75XVqhOkWVWidjVk6xlLw6sPxd0CM+a1UXEd26K/cxkr
   zX/90UGYpeX6buF2iRW/ocyZ1rZLpePDL48FA+5hNcIgMtz9R6IDmJ6u5
   iFfkIfJDcZFYL6cv5gzwJLGmrFrqGxO2bbPcJDa7kTTTSc6TGVfcqTy62
   f/VQMspODqSlKsi1SSfkJ4rRkxYEnhsDfJfXjR/j6yLJk2O5OLDs5FfSQ
   4vndvJNWkpAhp6JF6IERSVFmudAIq9UJkq8KrXOeQzFZciaOv5rjflmVR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="343778846"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="343778846"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 14:53:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="788660839"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="788660839"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 06 Dec 2022 14:53:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 14:53:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 14:53:32 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 6 Dec 2022 14:53:32 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 6 Dec 2022 14:53:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cqf2Iuq7Usd5LzHr68wB3SwvdvQlBTyLmd/b8kx2AcAsICBUOEgn9+9xoNPY9GAZIYl2HC9qHlFyZn17OfJC83MjxFL+P9B5k16gP9J5wN0YK4lBNKnuq9DZuTJ38lHyS5sn87AqLfKk0xc8aYbmbhvzDdgiyRI9C6P8FNXEJIt0R7RfV0Eb11xeiCduWcp7D72V3ZCT7k0QQUyOzWD8U3MYy7Lq+hLzW0YSnu71NZB3XobxR+Whq6geOtoi8Dk+hH+EqVplojlbxDeOXFUkhgy599FX/7yejOYxHKj5J2gA7Xht8KirozDg226HxcXEW7lYwnmnoUyiKsoESm3kkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4l+U97nHsKiNW21quWiXMsOvSbRRE6AXRr3Y8IZPJY=;
 b=YWuvIGNmiyKMhgDYOcm2Zszxg2tedXaUnoXPOxAMWst1skw4QhbZeJtOXeGynvdxtdocGim5ahu7fhdco6fCEoRWs8avE1wd1woEW21KLtk3ZwnzuyvCXLAZxtVO/zMX5+Sm0srErXnryhaxkNYtAIwrPPWznfjuJAuHhBC5OQNI0d0JgHTB2X/sGgWp8q4oMZ6K0+H6+2mUWh2UNR7eyczppBWvfgF5k1allCjAWaKyXTlvSr8sIK6VVgiq7QW0KgOXltkcLuHlFaTsoJKdYbPToxReQOfHQ5qgY8YLsRJm+Y27f8skQioU9Honk69sbPH0HLewJoQLfYgIL/EC9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CH0PR11MB5348.namprd11.prod.outlook.com (2603:10b6:610:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Tue, 6 Dec
 2022 22:53:30 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 22:53:30 +0000
Message-ID: <6be15060-1668-4678-2060-4e3d2738d35c@intel.com>
Date:   Tue, 6 Dec 2022 14:53:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v3] x86/resctrl: Clear staged_config[] before and after it
 is used
Content-Language: en-US
To:     Shawn Wang <shawnwang@linux.alibaba.com>, <fenghua.yu@intel.com>
CC:     <bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <james.morse@arm.com>, <jamie@nuviainc.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <x86@kernel.org>
References: <20221124124237.65480-1-shawnwang@linux.alibaba.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221124124237.65480-1-shawnwang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:a03:80::44) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CH0PR11MB5348:EE_
X-MS-Office365-Filtering-Correlation-Id: e198a6f1-c2ec-407f-6558-08dad7dcb197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJDLoitY1Yup5uQNAZo3ABbYCCPbF+IW9Yb6BJGyU4YK6fVGqIHhscChZsK7CPHq6+iKLzX0XR4KifnZz44dUopvV49EoCrotTeewtHBJUeVi2fR7FnAYMNn5GzkjvFGgG1kVTVScq17lo9Lc42AKB6zeszzd+BN7BqqSaTx9Mr0H5C2DbP+4z9FtTH2NkbBdgtpZkscUa2ECjZwceP6ou2ZGKuVnj5DG/ZLMgB1MFp76m/TTCqk40TBv1grESMWpUd9i6p7QIj8KqlOJzxooRigl91IYpGIBUtsJpTjbbmGOdx8Hkwf/ia1qisrrig2HzYbS27wEPohnEzW4Q8be7YomxjbljmCyMlYtB432WDs1tEvWyYe14FUJoSq+ataXD4Zd1kDo1sKCeHz7s5bdCzhChunnPYEpR4ZM7ih74N9Qbqk6pempyVvoq3tNfwdUcdx5qbEb/7e8zUflIxFHkOrOSQi5hhBAaPkvIxY9YtPqNgxwgRtnDmPjglu2wPyvH4HfrT+n7g4zzjgKs9M1P3uXt444xK3JCwgNQ77GDf4b+9EKbW/Yb0H1LFm3LL5EkndrMX2d8o1leocC1f3OH7ZAakkyDDcSpfAWEnDKSqRk745W4KKSHSrimvkApV3/1OmpQ7m+aHxttqT2QNtSXspW/XenBftcxyo0mgb+PMzwA5y3yoF//jy21jMhikGE9uiYmFy6lFgZfet+7rqkMU079qsuDwl/zdEWZmF5Ow=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199015)(36756003)(31696002)(478600001)(6486002)(186003)(53546011)(6512007)(4326008)(44832011)(8676002)(6506007)(5660300002)(7416002)(41300700001)(2906002)(8936002)(316002)(66556008)(6636002)(66476007)(66946007)(26005)(38100700002)(2616005)(6666004)(82960400001)(86362001)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHlHT1lGSWhkZkVOaW1yYURKZ3lSM3IxQ09uS0FPNEJzODgwc3FpbnI5ODJu?=
 =?utf-8?B?MnkrOTVZMklxemhmVnl6MG1LTmpWYlNsZElES3h3d3A1RFFWYjVYMXdHdHdt?=
 =?utf-8?B?RnQ2RTQrMmdhYmQrVktuYXdKb0w3a0ltcFV2eW5VaXVNVjM2OGszWThXT1RF?=
 =?utf-8?B?c0VBV3U1WldtLzZacFlxUGE5REdQU2VsYW9EZllXYk5lMURxMit5UEx0VjE2?=
 =?utf-8?B?WStEbFRzZUk5T0xNbFVyZERIZnhXdE1MZTRjUXhlQlMvU0hSNjc4YkNPa1g2?=
 =?utf-8?B?Tko1a0dXTklTTnRxS3RCVC9EUFcvZ3d3eUsyNS95NHBjSXNFekk0ZGlGTU5M?=
 =?utf-8?B?VkVkMFNudE96QThZUlpHYkQvZHQ1TWlZc3JyMmtQYkF0c2I2TlBvSFFJakRL?=
 =?utf-8?B?cnhGYWxrVG5MUFpRbDRLZUpqSUtIeG5rWDZ6UUx1SFhUbTVKSGl4Z1RPaGNr?=
 =?utf-8?B?TjJHeXlnMEdzalAwMzRQQ2I5SzZ0WmVFb0gxSDRTdGFwSThlTEU2dlg5b016?=
 =?utf-8?B?aXdIcnNSRmJXR09odUNWK2gwWTN3RXYrcVQ2TW5MMDNCRm9tS2FzWXlRdGM0?=
 =?utf-8?B?dWhEZEJnb0VqblAxRjhjZnBSL0RxdGY5L2hGdmdWOWZTa0E1ZUk4TC96ZTcw?=
 =?utf-8?B?WWlDN2NiaDV0aEkvNVRSS0w3UnZMODBqMnUrMzVmaFJpRjBjWmxmVXBqUUlT?=
 =?utf-8?B?Sk1aZEF1d2k2TWVRTFRpNXc5b1RSYWw5SFdOTWhkejU2NUl4NFJQVDFJQ092?=
 =?utf-8?B?VzlFWWhSYXNWbU85ZUJkRTBVcHUzVkhWVFZMdGhpNExnN1krWHIxcTVrL2FB?=
 =?utf-8?B?dGFMeEh6VVl2dWFuVVJ1RlFoRks0WjNLM21oSC9KbGsrdlJ4d3dFejdSVzRY?=
 =?utf-8?B?aXBSWDl6ZUg4b3VCN1J4UktqUzJzNUQ2N3N3WFJIZUR3SFIwNkVoNklWVDF2?=
 =?utf-8?B?ejdxdUNCZnBveFExT3JxSzV4eXV6dXVEd09tbDFRbUZtblF0bnIzY29PL0M0?=
 =?utf-8?B?WG5FNG02WXpEekNXekJqTDNmekZNMnRYRjgwbS9FUEtMOFBKRjNpNTZHRGFI?=
 =?utf-8?B?Uk1tQ0t3YVhqWVdGODg1WGJmNWRuVGRRNFgvbFlOb05KL1FsUnA0aUV3RXNi?=
 =?utf-8?B?dVIzS1FldWdkWExRczZiR0k1Z1Z0aXl4VjA2QXB2MlByWTNiNUFYZVRreFdv?=
 =?utf-8?B?T202b1BBS2IzSFpSTXlSajdCOUhVZGhPNGtHNXN2V1ZRaHdoRUhob21MYU9O?=
 =?utf-8?B?eUxLVE5WQ1dzYXh5TzZ4YllLLzRuTnhWdVZta0RFb1dIbS9mVDVDaVB5eXJB?=
 =?utf-8?B?dVljMnRBRVg5L2t3S1ZNNzBsV3pnZVk5ZHNDc3ZRbzNNbzhSNWRkKy9yMFFZ?=
 =?utf-8?B?V05uaFNKTjR1YlJtdDhQU0UvSmtNZU5RQVo4UklQMllBdXM5SU11c2xwQTlT?=
 =?utf-8?B?K0NqZFNheHhWMHBlK0FWaEpsKy9tT0wyanBDS1oyKzJ6WjBhTndBRHFxWFBL?=
 =?utf-8?B?ZkRqaXNXaDNWaU1KamsvK3Q1dXZFOTZNWlN6Y2hESEp2dU1tNDRaelZnSSto?=
 =?utf-8?B?U0RhZHlwdGpGaFBXNGJrMWIwUzl1Yy9xeDBXeGpCa1N0NFdzQlpSRkR5T2ZO?=
 =?utf-8?B?TEZLZG1RT1JkcDBhZGtYMm5RTndJc1k5Z1BaL2U3Ni80aE4yL0Z0YUJiYWs4?=
 =?utf-8?B?NURYcEl2UGNGU2lyenA4QzhCQlRLQjNYNnhZYWdveDVnbGN2emN3OHpSMzN3?=
 =?utf-8?B?SENTdWZJV1A0RHE0d29JU1hnYm5Qc2NpUTQvM3Q0SzBvVnhpNko0cVg1amt1?=
 =?utf-8?B?RUFXYUpDTlhLTWlVUExkNTNNalpCV2VDTEpJWXdLazI0Z1lNald4bjhmYVh5?=
 =?utf-8?B?cldPZHR5Wjd3dHVwb2tIK014SGZDdkpXb21uS1lpWmlQYmJYcm5pK0pDbGdw?=
 =?utf-8?B?cU9PWVFsMkJ0SHJTSGhHS0c5azFPUUVXY0dCd1hiRjZSOXZzVi9mQm1ERGR5?=
 =?utf-8?B?VnZIVENSQzNIVWhWTEMySEY2WFBXa3p4Y0RoUlozWE9La0lpa09JaVBSUnVi?=
 =?utf-8?B?a0Q4YXVuZ1ExNVVoTndieldIc1dGSVFIWGI1RGFKTVcrYW9lVnJoaUpmdlZ1?=
 =?utf-8?B?THNBOVRCNU1aKzRBSjJ4NVFkYU8zYmtBRjhyUEc5N0xyVUxkeklpZ0J4bS9V?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e198a6f1-c2ec-407f-6558-08dad7dcb197
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 22:53:30.1112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1uZImnBpLAEZK001RdHpVxS3qQI+E3lHUJ75gw3KMwh4xQKwMQxCFpM+2gX8FdmLFVSfgfgzoi9FDS/gMfZyD15qmwlVR+SZpYiwLeivkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5348
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On 11/24/2022 4:42 AM, Shawn Wang wrote:
> As a temporary storage, staged_config[] in rdt_domain should be cleared
> before and after it is used. The stale value in staged_config[] could
> cause an MSR access error.
> 
> Here is a reproducer on a system with 16 usable CLOSIDs for a 15-way L3
> Cache (MBA should be disabled if the number of CLOSIDs for MB is less than
> 16.) :
> 	mount -t resctrl resctrl -o cdp /sys/fs/resctrl
> 	mkdir /sys/fs/resctrl/p{1..7}
> 	umount /sys/fs/resctrl/
> 	mount -t resctrl resctrl /sys/fs/resctrl
> 	mkdir /sys/fs/resctrl/p{1..8}
> 
> An error occurs when creating resource group named p8:
>     [ 6180.939345] unchecked MSR access error: WRMSR to 0xca0 (tried to write
>     0x00000000000007ff) at rIP: 0xffffffff82249142 (cat_wrmsr+0x32/0x60)
>     [ 6180.951983] Call Trace:
>     [ 6180.954516]  <IRQ>
>     [ 6180.956619]  __flush_smp_call_function_queue+0x11d/0x170
>     [ 6180.962028]  __sysvec_call_function+0x24/0xd0
>     [ 6180.966485]  sysvec_call_function+0x89/0xc0
>     [ 6180.970760]  </IRQ>
>     [ 6180.972947]  <TASK>
>     [ 6180.975131]  asm_sysvec_call_function+0x16/0x20
> 

Please snip the timestamps from this trace.

> When creating a new resource control group, hardware will be configured
> by resctrl_arch_update_domains():
> rdtgroup_mkdir()->rdtgroup_mkdir_ctrl_mon()->rdtgroup_init_alloc()->resctrl_arch_update_domains()
> 
> resctrl_arch_update_domains() iterates and updates all resctrl_conf_type
> whose have_new_ctrl is true. Since staged_config[] holds the same values as
> when CDP was enabled, it will continue to update the CDP_CODE and CDP_DATA
> configurations. When group p8 is created, get_config_index() called in
> resctrl_arch_update_domains() will return 16 and 17 as the CLOSIDs for
> CDP_CODE and CDP_DATA, which will be translated to an invalid register -
> 0xca0 in this scenario.
> 
> Fix it by clearing staged_config[] before and after it is used.
> 
> Fixes: 75408e43509ed ("x86/resctrl: Allow different CODE/DATA configurations to be staged")

Please fixup the Fixes: to only have 12 chars of the sha to avoid a checkpatch.pl
complaint.

> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
> Suggested-by: Xin Hao <xhao@linux.alibaba.com>
> ---
> Changes since v2:
> - Update the commit message suggested by Reiniette Chatre.
> - Make the clearing work more robust.
> 
> Changes since v1:
> - Move the clearing from schemata_list_destroy() to resctrl_arch_update_domains().
> - Update the commit message suggested by Reiniette Chatre.
> - Add stable tag suggested by James Morse.
> ---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  7 ++-----
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 23 +++++++++++++++++++----
>  include/linux/resctrl.h                   |  2 ++
>  3 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 1dafbdc5ac31..93d1f11a1f19 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -374,7 +374,6 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>  {
>  	struct resctrl_schema *s;
>  	struct rdtgroup *rdtgrp;
> -	struct rdt_domain *dom;
>  	struct rdt_resource *r;
>  	char *tok, *resname;
>  	int ret = 0;
> @@ -403,10 +402,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>  		goto out;
>  	}
>  
> -	list_for_each_entry(s, &resctrl_schema_all, list) {
> -		list_for_each_entry(dom, &s->res->domains, list)
> -			memset(dom->staged_config, 0, sizeof(dom->staged_config));
> -	}
> +	resctrl_staged_configs_clear();
>  
>  	while ((tok = strsep(&buf, "\n")) != NULL) {
>  		resname = strim(strsep(&tok, ":"));
> @@ -451,6 +447,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>  	}
>  
>  out:
> +	resctrl_staged_configs_clear();
>  	rdtgroup_kn_unlock(of->kn);
>  	cpus_read_unlock();
>  	return ret ?: nbytes;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e5a48f05e787..fa00eafd3cd8 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2841,7 +2841,9 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>  {
>  	struct resctrl_schema *s;
>  	struct rdt_resource *r;
> -	int ret;
> +	int ret = 0;
> +
> +	resctrl_staged_configs_clear();
>  
>  	list_for_each_entry(s, &resctrl_schema_all, list) {
>  		r = s->res;
> @@ -2852,20 +2854,22 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>  		} else {
>  			ret = rdtgroup_init_cat(s, rdtgrp->closid);
>  			if (ret < 0)
> -				return ret;
> +				goto out;
>  		}
>  
>  		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
>  		if (ret < 0) {
>  			rdt_last_cmd_puts("Failed to initialize allocations\n");
> -			return ret;
> +			goto out;
>  		}
>  
>  	}
>  
>  	rdtgrp->mode = RDT_MODE_SHAREABLE;
>  
> -	return 0;
> +out:
> +	resctrl_staged_configs_clear();
> +	return ret;
>  }
>  
>  static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
> @@ -3380,6 +3384,17 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>  	return 0;
>  }
>  
> +void resctrl_staged_configs_clear(void)
> +{
> +	struct rdt_resource *r;
> +	struct rdt_domain *dom;
> +
> +	for_each_alloc_capable_rdt_resource(r) {
> +		list_for_each_entry(dom, &r->domains, list)
> +			memset(dom->staged_config, 0, sizeof(dom->staged_config));
> +	}
> +}
> +
>  /*
>   * rdtgroup_init - rdtgroup initialization
>   *
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 0cf5b20c6ddf..2f7af447eaf2 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -250,6 +250,8 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
>  			     u32 rmid, enum resctrl_event_id eventid);
>  
> +void resctrl_staged_configs_clear(void);
> +
>  extern unsigned int resctrl_rmid_realloc_threshold;
>  extern unsigned int resctrl_rmid_realloc_limit;
>  

Could this be moved to arch/x86/kernel/cpu/resctrl/internal.h instead?
include/linux/resctrl.h is a new evolution to support the upcoming
architecture and filesystem split. It is not clear to me that this
cleanup utility belongs there because I do not see that different
architectures would need to call it. Could we keep it internally for
now and if the architecture split needs it then it can move at that time.

The rest looks good to me. Thanks for providing this fix.

Reinette

