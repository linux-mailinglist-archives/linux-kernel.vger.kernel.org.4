Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D3F670BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjAQWjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjAQWjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:39:18 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F473EC63;
        Tue, 17 Jan 2023 14:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673993853; x=1705529853;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xeTedPMmM4I4aLv28MyvdQ/NKclheukXmgKkzQJzwAQ=;
  b=mXC39z2Mesatpri/JJmWYDyt8YFa8XQ25u0c/4uZJICr7R/dAVFQ7doT
   +zY22D3hLQfE5/RaR3bWblapYbmbXiXsUbOeKOvVySRojQQ8WV9qDantA
   K4coRdfyCSZ934NIbkevRy4Nm8nZHDlepEb7umH3m83g8XkOuhXurjM1O
   lpRbM6S9IzVjYfXzNnL4yQbuKAlybBzG4idhRUVeBj37Ayzpt3v6oqQuO
   WsiF+rlKAYdNBNSvXUlczxczOEklcMFUzaS4JZcUndUA7Qn7VUxhL8zop
   Jf3Ea61kV2OVcD3SDNktVm/Kijvf44LNBE5fjlU4dmNeDggXMAxgbzmnY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="305207587"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="305207587"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 14:17:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="801910927"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="801910927"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jan 2023 14:17:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 14:17:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 14:17:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 14:17:04 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 14:17:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju01BosqiLeD4196aQ+cEJ5oe7khNEi8+AMXiFzCvy2jRqHMrMxP5IsPcbHF0CfieATCVxFBpQRmhkCOBf0+AWgao87eA4/oJ9DMvfOgrLsbIrR+H9BQ1AewTxTuLvQB88IazBcCEQHIL56EHHNG5yDgkY9Jno2OuUtt+m+cFxW7Y3jEN6zIkSby1gFmrzGAkqtWua1sp2OTECQdn2npb+FKVF1w8y35sqnStTYraEDgG5IqxgQ25zaeP0cUqJWOOrKyAVbcNoBK4tWkHLYkov8mFXNCcwJKznB+B8PQQhD7+12OCARpC6xr8tP23pL0NzF0CRGD3FqviIvv23QhKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuDd8gDMBpGuhoY6wUsFh8116/NAXvxtkiYU5jkOQh0=;
 b=NndqyIpacIXzNP+VilPoHLQV6nsWu2hoP0fWN6kUPcrTMNWE4VFqPsOmzv54fwdTQCJi24vbfi+U2MDlfUa0KJhLbI8D+gA7Ub8Ttt3yVwyqL8+Yw/tBW838xmbxA7hsYLpdSTlbVlKxuX75l1k/GTIkQ9SJZRlnVn0Izb4IHXI0MxcLN3uhSUa2AzqjQe5TqyHI//7wuAvNXJLs67qu0BLC71oLmjhV6vr8OtsKdSeFZ90iujlt/lsu/Puo7WZ0fO7tSJ6X6U4gMEjZKJavxMow+UziXBO4W6Y+j9b1ZUNshu1RLLwlBOKgJF+UQWFeMjSOdqtNqrIiCY/Q3+X1Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA2PR11MB4889.namprd11.prod.outlook.com (2603:10b6:806:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 22:16:59 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 22:16:58 +0000
Message-ID: <9e43dd11-38b3-fe0c-0929-8b454591813a@intel.com>
Date:   Tue, 17 Jan 2023 14:16:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v12 00/13] x86/resctrl: Support for AMD QoS new features
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
References: <20230113152039.770054-1-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230113152039.770054-1-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::9) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA2PR11MB4889:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d94ce4-2029-4b8d-5fa6-08daf8d88caa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djppjzPbGEi7Le17D/feRuK17snrumouzOhsrfurfhtXyIkaPzy2YZhvv92gTNFLzeaRxo/dTYhAnAg842SUMlAKiWCqcIMrmBIEQLy6Q0vkXaLvLNiSnB1iyvDKTyEOrka8OyRomhdSkL3eW4DdDSyzs45iPnnk01TbS2zby5+X88q6hNxQCFHCKZVD9q0SdzO+5K3hMso23cFGr0xDHjYTH1jrIGF+XiiJ6Nq3kp7nqYUNvqYVWIPMn7yR4cPJ290EfAHU2K86+NTv/S1N5WRFGbTUDaiAXGSN5LtHU+bbEHCbw3tqXOpf3WbTeC+CMoggp3L/ofUKRhVzH80e+pxLRzIHSLlcklqXOdQMlWrHsY5MbwkAfLliucYQaMV4M2LjCjBKR8njmtIMlQ7XVtCHsEc/HagaE4SCgghLy/dOgoK0gVAHdCY8JYaf/0YsyIyISJL4ObUTr4orlsvNtlpA7TO1RQSPa0aJWlcQNx7KA4g3zA27fBpaWh3sT7QPirpS2yatn05Nm1QDLXnpOi7CBK5Ny5qISuvr/U7leAZ0kystsE/WaxfJUq+BKR8OoGnJyRfpFzBKZN6ODJYVgqe0v0YmDL6eNy1vm25nMVoXYER4G2ezZgufj6WM6unG76pDzsKrsI7aGJbv36ETOtCHSuOmwxsvdY9PLeLDsdTnNBq6ZWYGHFrfGLJVS1kmhozi+Kgy6fiKrwnKIfPq1nFGMx7aysuNrbhD7aHIFg2INIx4B1INwGlsYQn40i185SbPB9Wd6F6oGuAbWad28+eAfqeB04zgUGG1B3c0SH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199015)(31686004)(36756003)(86362001)(2906002)(31696002)(8676002)(8936002)(66556008)(44832011)(7416002)(66476007)(4326008)(7406005)(66946007)(82960400001)(83380400001)(5660300002)(38100700002)(6486002)(316002)(966005)(41300700001)(6666004)(2616005)(478600001)(6512007)(186003)(26005)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amxHUDFqYTluT0IyTkxCVlpoSDV5Z3hMZ2ZSb092L05SSFJmQzZtZGV4Ti9C?=
 =?utf-8?B?OTlmaVdCblBKM0lsTWJDNWNpQkd0SU5WbVNqRmEyMUp5Nm5ESk9tWkk1Ynpj?=
 =?utf-8?B?SFJkRkFSaHZpSUZKK1NURS9uUzNvZ2djNzVjTDZnTlYrdzNOZzRjLzB3bzE5?=
 =?utf-8?B?UnIzRGx1ZVlLNDBlekFzR2h4K0xIWkV2U2Y3eFVNd0Q3M3ZTd0hyY1ZsSzM3?=
 =?utf-8?B?bERzbklpV2g2dVcvRi9qbUFQV2dsNlN4WXNuTCtuOVgrQlZ6VEc5aHZ6YzYx?=
 =?utf-8?B?dWY4VTl6Rm54WHFSZUg4c2tFRURhVW1pNTVabjRkVjdITVR0RlNLZ1ErWEFD?=
 =?utf-8?B?VklpRjd1K2xsdDl0aXQ3UW44RnA3dmJpU1lmYkFnS0RFeWg1bTd3YmhaQ3hR?=
 =?utf-8?B?R3B2OGlVZXlkcVJQNm8wc3hXdWVIV0ZtemlDdlJGcUtra0JWKy9GVVBtcGhy?=
 =?utf-8?B?U05aNzlwK1ZkblEwSFp6eENMdnZEZ1J3aFM5QWlIUHE4bG5CQmRhZHZ0KzYx?=
 =?utf-8?B?U0FNc1BzUUwySnRCSVdBdVkzM2JDSTNiNGNMN0cydlFoN2U5VkwxSW9sazRJ?=
 =?utf-8?B?SSs3d1A3bHU0VkhhdXhaODFJT3pOWkJJVjh3T1NxUE1ZYm0xemo5OXRFN1Vm?=
 =?utf-8?B?YXNlNmFJNmRIdkI2eWhJdWdKNnpzTGRURDQzWkJBNVNPUm5qTzdGK2tBZXJC?=
 =?utf-8?B?MXE5OU9EcmEydWUvRyt5YkUwcXZxSXZ1ZTZ1aVhHZ1FnTFI2UUVFSGovWHNz?=
 =?utf-8?B?Wk9PWkp1Z3BGTkVkL0dydGpQVHVwZFB6cUs4Tnc1VkQvOTc3TjJ6RitvalBq?=
 =?utf-8?B?dzlrWkwrZnNXT1NOdVhUY0FmQWVkei84WFV1SG1reks5ZzhxNG0vQVpHb0pC?=
 =?utf-8?B?c1NkWFJEdHhXU1pWOHREQXdSU1RUcE9na0JTSm9CSVd3NXViUnJHMlB5WkNL?=
 =?utf-8?B?K2JDRWJkcWprNmJIeHpxVnpCUXFBYmltNlBWNXg1azNuKzRMNDlCaXBlekg0?=
 =?utf-8?B?K29YbnU5YnRqci9MZTZhdEdDYkVUMWdkalh6cWdQcnF2elFqSU5TdFRjSzRG?=
 =?utf-8?B?SGdJa2NCTnVUYzRORGZCVnRCbGZzWEp1VnMxQXBBcjZuMEdMTXZCWFduUU4r?=
 =?utf-8?B?ZmYxZ2h5VjdnRU5rRUZRWGQwaEY2SVlWdXNWTVFJN1M2b3k3UW8zN1V5a2dr?=
 =?utf-8?B?SG5CZXR1SDlRREY2cVhpZGpOOEhOeUgvSkJVZzRTZkdSUldtMkxBWE1HUVlo?=
 =?utf-8?B?K0t0cnBzMjkxVU5nZ3ZpdTdKbDdoTjlTYzJoQW1EeS9hdzY5TG5kNXExZi9y?=
 =?utf-8?B?ZGN3clBHMS9zQkxhL0NGZHdpbHRVczZla01vK3VwKzRLS21KTm5ZU2RiNmlR?=
 =?utf-8?B?cmQ2cEwvdko2aTBEVHA4eXAxSGtsWFdhZ281enc2U2xObkcvNkwyRFFCMHNU?=
 =?utf-8?B?dzJobXVYUHhmNE80Um9zMGR0ajVyZW1QWHowcndZMTgwQXdYMnc1eFdVRmQ3?=
 =?utf-8?B?L0VyRVVlb09KQlVVZUoxd2JEVy8yVmxjL21aZFpxK1NIUkphZEdkT2NrQ1pG?=
 =?utf-8?B?bHJLVUJKWmEyNVZjSE9CbWttSmlQZzgvbzFNOGxwejhLbW1mVkRCZ2hDWFJm?=
 =?utf-8?B?THRXZ3VsM3poN2RUa0lWbForajFiK2Rxa1FCdFpDdXBLTmRNK1E4d0xyZFNO?=
 =?utf-8?B?SFFFNy9vTldEM3NmLzNDdXRUdTZiWEd1Qmw2clRxQnNvc1pjMnltVWFyUVlU?=
 =?utf-8?B?ZnVCZW9HUkZqV1NzSVdvN3AzdDdrZTZIeS8zekhzdCt5WDlWbXR1cURlYWlj?=
 =?utf-8?B?S2hsWE9VblRwc2NkOHNFcEFPMG4xQ1JnWG1hK2hxMXZpL2V3NmtJam9USXdC?=
 =?utf-8?B?b3VQVjhNU0pxWjVUL0tCelJLSEVDQ3dXYUR3M3B4bWZ5N09DUzdyZ29sYkti?=
 =?utf-8?B?bzhLYXVQVisvQlBmNHZZTGFrZDZRVisrNU9hZzlISXh6d2VUMjZRQlhld2ZP?=
 =?utf-8?B?VW1WWmw5L1A5ZkUzSW5kaC92bG9Db09lOFNoVHNBWG5rWnF5NTdEQ1h3Y2Jv?=
 =?utf-8?B?QnRvUlovYkhxWkw0NkwxN1AybElvZXI2OTRUMDNRb011Ny95TWFCYTZZQXo5?=
 =?utf-8?B?U3VXQjhGUGl5V25rbmlQZmRaaFhLV1F5bG1YMERqNmdXdkVHT0VFQXRpL2Zo?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d94ce4-2029-4b8d-5fa6-08daf8d88caa
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 22:16:58.6540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WR+lW2D2+OQ2Nhgk+C1pZbUerrkb+bpzp8zCNqzlH+6m9QjQaO9XSffxVBSZAUZVQQ8npOvCenRdTM6HA5X7rhizkcy+rr5rWw1q2TQ4nnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4889
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 1/13/2023 7:20 AM, Babu Moger wrote:
> New AMD processors can now support following QoS features.
> 
> 1. Slow Memory Bandwidth Allocation (SMBA)
>    With this feature, the QOS enforcement policies can be applied
>    to the external slow memory connected to the host. QOS enforcement
>    is accomplished by assigning a Class Of Service (COS) to a processor
>    and specifying allocations or limits for that COS for each resource
>    to be allocated.
> 
>    Currently, CXL.memory is the only supported "slow" memory device. With
>    the support of SMBA feature the hardware enables bandwidth allocation
>    on the slow memory devices.
> 
> 2. Bandwidth Monitoring Event Configuration (BMEC)
>    The bandwidth monitoring events mbm_total_event and mbm_local_event 
>    are set to count all the total and local reads/writes respectively.
>    With the introduction of slow memory, the two counters are not enough
>    to count all the different types are memory events. With the feature
>    BMEC, the users have the option to configure mbm_total_event and
>    mbm_local_event to count the specific type of events.
> 
>    Following are the bitmaps of events supported.
>    Bits    Description
>      6       Dirty Victims from the QOS domain to all types of memory
>      5       Reads to slow memory in the non-local NUMA domain
>      4       Reads to slow memory in the local NUMA domain
>      3       Non-temporal writes to non-local NUMA domain
>      2       Non-temporal writes to local NUMA domain
>      1       Reads to memory in the non-local NUMA domain
>      0       Reads to memory in the local NUMA domain
> 
> This series adds support for these features. Also added a minor cleanup(PATCH 1).
> 
> Feature description is available in the specification, "AMD64 Technology Platform Quality of Service Extensions, Revision: 1.03 Publication # 56375
> Revision: 1.03 Issue Date: February 2022".
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-quality-service-extensions

This series looks good to me. I added my "Reviewed-by" tag to patch 13/13. All
the other patches in this series already have my "Reviewed-by" tag.

Thank you very much. 

Reinette
