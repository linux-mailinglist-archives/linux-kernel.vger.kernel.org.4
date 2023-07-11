Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E32774E39B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjGKBky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGKBkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:40:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220EBA4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 18:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689039651; x=1720575651;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KZQulfuwCjF+mqU09uX7OGZsLpgCRuNce0PC/EZGst8=;
  b=lotIdMmhIg9nbbsXgssLz7H2SeKRXSrM0pybloCcSwLDHgYD4clEbgSn
   ac5uu0tG8b67mQKFxL6ik8ZjQYbJ+JE5D0i4bXR4pHoaEtSeIgNssWQGT
   PxobH8ZnQAof4lESJ4SBj+BbBbUlvSEZGFEcj78k/u+KTVb73MW2byX/U
   E7AhPVpCGT0IID6s7jACQkb6rgu0dS7diKiYZ8aTORcel0E3Vvqzms5rE
   nAONaXplyMrsrqtcKtsAERq8LELpDyuXbzXfmclfEqMcVoJrALQ8XGLOL
   mbjAGNlrKVQMcezq6I25zq55CFZyRbRXJ+o6rthEu9C6Fs/7z/ifFQaOa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="367079258"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="367079258"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 18:40:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="720895037"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="720895037"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2023 18:40:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 18:40:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 18:40:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 18:40:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 18:40:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIy7+XhXSgtPMkTWu9nP2Nox5viekEn4UEYOOqTkNMf4eIcGOZsz1J9Gw39pIHxBA/0kqWSM7G8MzSjHpMt0CJUWhjADBO+1EuN/LVTqd52h6ty3XEz/p9J0+aqbhFUZqpWL4VK+b9r95s+0Bclj29kDAMGpKgUhns1CA2x19MJJBcDXiWLxC+sXFDoF1GAEYM1IsPTE6rsG3HCTX7GGLf/GHs7vYUGCXjqJlUT2PnH0EKq+g+l7c8RQe8BXJqP6esDK8OHn2CV+EUui0kHZCsly6JpzZTObRmkaGnb5Gipi0qJXiR8rHNyHY4fssurOMuMVtm35gBleS9dqwaBDUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJu52a9aVIS5OKM/PsCU27gZdQzP3gtJiqEQw93F9Y0=;
 b=L6V93X8aWqdPNQBK+wMgaA2ChVJV5YxORto6O0zEKoSLYIAnhSxuInytcmsTw/K3pAwq1JwK1USKzQ65dGSO1BzYJFEzXgvaag5G68HKC3DLT1EgFc5hFCqmsIjC5d2i/PxzN2NSFSuumZ9xTswF70Clm8nReRImPQTRyuomVDIiOf57ViQAuI6cLnB+c8vZRqRHECbWUtzSIk2uktvr9+usD9FhvlW7MRuxEkYOphxmZEtnw6NXOl+uOdv79Luv+jEAyCX2dkJjhIaMrum55LZ5rxygHEmIoOoS5+6uZWsAmb7lmE0K7tT4riJn8z/n4rrcicnvolAX4DJ61LPDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
 by CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 01:40:47 +0000
Received: from DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::5f33:c1d4:5990:e2f4]) by DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::5f33:c1d4:5990:e2f4%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 01:40:47 +0000
Message-ID: <f2f23ca1-0881-4601-7ea5-c5e42ab83f62@intel.com>
Date:   Tue, 11 Jul 2023 09:40:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/5] iommu/vt-d: debugfs: Enhancements to IOMMU debugfs
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230625150442.42197-1-Jingqi.liu@intel.com>
 <BN9PR11MB5276885D6A142BC94D80C2618C29A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4f18a7ca-3a57-0097-51f0-490f876831dc@intel.com>
 <BN9PR11MB5276ECF766C4F89F5083992F8C2EA@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   "Liu, Jingqi" <jingqi.liu@intel.com>
In-Reply-To: <BN9PR11MB5276ECF766C4F89F5083992F8C2EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To DM4PR11MB5469.namprd11.prod.outlook.com
 (2603:10b6:5:399::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5469:EE_|CY5PR11MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa889a8-202c-4d7a-0998-08db81afd984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GB5+kXqZOODICNcbrESE5OE+MQrvdKOvArwWzxnX4TIyex3FWd5XRFsiGAAoSGEUwm1UrLc9WyghZKBYEyTm8jMo79psEOrq3ug362tP05VVHKZe4KygzgjH3jlwvlNVdlN99ZcvrbwHd6Ky+wmN38IHZkRm2g+Jofib0vCKb1ldkaWl8egI8G5ya3jAAtsHW4D8B8aTmhxq8hOmMeeew7zbeb2Far7rnQ9qlRx1du9Div0yDCVoRiQQ20jmzNnEK8v/0fDGmEJwI3zxt5E6CMUAUZpIx2pyMBkGwD9LxIj+BFmVwFsJ3BR7GtJnp2BUaU0Cpvx9b7RQuyzu5zKUOZmW24CyCV0KivF+lzr6lhJmonnFh7qeMkw6a2HAMy7A6wQjHsiwHmNWC9Fk7uyK8h5HywqGlPsbBZFfDrHLVjoyct8J90ZFerYNFoTqReuIGfPLACbmgBCh9tPOxcfbJWmWm4gSI/ZPxxqX0AVBuyaEG/4xEdF6IivkX8k5878Pqj/UluWNOmtiLYS9s4xGqT/pvjtLg6o9fRO+m7O0dQVgGC20m804hixh5jQlXhCU/u8+VnmybKKfbT1/vLa1QD5/+YAzwWcmqTeRk9QTPvDj+kMlWvFpRzZCND/JfpPGLzpYX8Z5vGTPrTtV2obpUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199021)(31686004)(82960400001)(8676002)(41300700001)(5660300002)(8936002)(26005)(2616005)(316002)(4326008)(53546011)(66556008)(186003)(6506007)(66946007)(66476007)(31696002)(478600001)(110136005)(86362001)(2906002)(36756003)(6486002)(6666004)(6512007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0lpU001R3kwckU2V3RyRGZ6dUlBeWp5WlhRNUdrUmNpNHh6TzBNL1RtSEpy?=
 =?utf-8?B?b3pZRlc0R0g5Z1QydS91dDNDZzBHcm1WemtiSVZqZmJXK1c2emxuMzZ0MWlt?=
 =?utf-8?B?MWYrNk5kc2dJMVdKTW4wZWowa0c2QkIwRnF6SVVkVldaM293ZFNYZGVZK1kv?=
 =?utf-8?B?YUg0cW0vV2FWOTlObkhneWZDUDg2ZHJoSXVqeWNzd1VDYUN4Yys1OVEzdzNq?=
 =?utf-8?B?YWFBWHVGYVVNVkswRUtCUVRuRkxCc0lSc2VjOXFDRjFva3ZoNlY1Y0xBNzk0?=
 =?utf-8?B?WndlYmJKMERLSTZKQ3VORmNJOGtyWDlyOEdCNTQvNE9KR3N4ZmFkanM0SXFM?=
 =?utf-8?B?Tktua1pWMUFtMEdYamdSNC9LNnZrRWlwMnFWdDhEM2RVYUN3TW4rbXlTSG94?=
 =?utf-8?B?aTJyLzk4b1pRcDFDVzlSRnZraTVOOTIycWVTVEVpT2RDVXk4RlpTSWs3alF1?=
 =?utf-8?B?aVJoZE93OCtNQUhZaHErNW1aZWV6TnAyNDVCMXlJbzQ5dHR1M2JXbnZ0UTc3?=
 =?utf-8?B?MzdqL3NOSVpFN29TeDd4Z3JlSTFUQlMyYnRxMVorVGRIOWVPVkhCRVZEL0tu?=
 =?utf-8?B?MTRWR05VUmpNQUFGU2hwcEVXSHkrOGxabHVMMXQ5Qk5RUmxmVGFXOTZZSklj?=
 =?utf-8?B?UFZGZWRjSVRmdU90c0NsR2FSNVRlNGJGK1VKQ3RvUEdpODRXVWVTbWVobFcr?=
 =?utf-8?B?cENaejh4VUFXYktTTWp4dGJNVFo1VW9zeS94eDB1SmRNa2wyODRGOHJxTkpO?=
 =?utf-8?B?bVNvRnZqVXBKMDFWcWI5OVFDRytqalRzWjdVNzNvVnR5dGh6UjFKaEw2Y3V3?=
 =?utf-8?B?clhDK090eEgwMlVmSTZPQkM2RER6WGtzd0RMTjZHRXJRRjRyK0dLWnZJdlp2?=
 =?utf-8?B?UkxQYUNVYXZpYnErTktJaDBtdVF4RW03WVAzRnRZZkp0N212SzJVTXNieXFj?=
 =?utf-8?B?ekV3Uzhra01WanNUOU5HT1gwMmMvcTBjM1VYejUwVUpCMjNDM29vTTcvcmJ0?=
 =?utf-8?B?MEY0S2dEUnNuaTJVb0JMQ0RSV2tqTlRLSmw3S1YrWE5hWUY3aVBCUm95aGh1?=
 =?utf-8?B?U0ZXMFJ4WkhmbVhPcXcxSzRjNWZrSmttMENiTHJXUTl6U3E3ZC9OMDJ2VUpJ?=
 =?utf-8?B?bnhJd2dmcEVPWU94Rlh5aWpOYW1icnFyWFZWWFo2NDBnL2xNZmNRWnFnK1h1?=
 =?utf-8?B?RHpDOHVCU0I4Z2JEcC9iUm9vVzE4SVQ2OWM5SlUrc0dzdkxNQXJha1JEQSsr?=
 =?utf-8?B?R1BBWXdDcjBmNEVsWU1lVFVxaytBZTV6YmwrdWR6d3l5Wml2ZThLQjJoTHFy?=
 =?utf-8?B?OXBFTWh5RU1Ybm1KUXV3UWw5RnJCbnIwNWZUNEZDbnFDSkFQT29mRWlWL3F5?=
 =?utf-8?B?TkYrWHo0VVlGWlhqMVo1QzlpdGx4cExYdnZJWTJoWi94Q3g3WVlZWHdDQU5i?=
 =?utf-8?B?aXlEaW5QZlZLSGV6UFdKTVZiNVU0SGRTdEtqOCswemdBMnR4eXdQZ2VhejRX?=
 =?utf-8?B?Z3RlNTlSYno5T1BUeDY3V1k0UDloMW9aNWdXVUFXRUZQdG1weThrZE14ZGht?=
 =?utf-8?B?S3BUZVRKSGJWM1RSMEdCWkdHZXBBL0lFUHBHYW1HRFczeTQ5RWpqZFJ4N2NK?=
 =?utf-8?B?bWZyS3FaVjVCUXdMWmRaV0lxTlFwb3Rjd1JZQkhZbmNDc1ovWTExM1JXMWh2?=
 =?utf-8?B?S2w2SlVSQVF4dk8wLzVGMW1SdkdJOFNqN0dsb0RKOVlXMm1CN0x4R0FoSUFk?=
 =?utf-8?B?S1Y0VTUyTVIxMjlhWDM4Nll3UmdoejRzS2YrOSswSXFmVkU3aitFaFpyenFh?=
 =?utf-8?B?dWhVbkxsU3lhTm9RRHFEelFjQWREK0Z5Q2JLTnVnbllxTVhpL3ptUkhiV3lL?=
 =?utf-8?B?dGgvMkVGZWNvYlY1cHVNc1pjN2hZd0VjMnhMT2FtWCthNU5EWjRzRElRb3hU?=
 =?utf-8?B?eFlZRUwrTnlaYkpFOFNoYVlLRDJEYzY2d3p5QjdaYkpRbVJYRXpMcVZSU2xv?=
 =?utf-8?B?bFB1bXpSbzFMcG1uSGlBd2ZzdG1lc2cxZU03TDdrckZLcGZvQmlOaXQ0RmU0?=
 =?utf-8?B?U0xCcW9qSnVlNkxISHNEUng4bVhtd3RvWkxlMXFQaU1oSllKZFZlTGI5RVFT?=
 =?utf-8?Q?tFeoIqSwbuFN0xAnvR3KzUUYV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa889a8-202c-4d7a-0998-08db81afd984
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 01:40:47.5036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XkLDNzYbFVnzHh8SIdRebvTYh0Xmg/9PIrT591AtHCxmcB5p8E17Mfx8yc3CYOfs/tzk4iuhV03SXYHIfgTqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6257
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

On 7/4/2023 3:54 PM, Tian, Kevin wrote:
>> From: Liu, Jingqi <jingqi.liu@intel.com>
>> Sent: Monday, July 3, 2023 10:37 PM
>>
>> On 7/3/2023 3:15 PM, Tian, Kevin wrote:
>>>> From: Liu, Jingqi <jingqi.liu@intel.com>
>>>> Sent: Sunday, June 25, 2023 11:05 PM
>>>>
>>>> The original debugfs only dumps all IOMMU page tables without pasid
>>>> supported. It traverses all devices on the pci bus, then dumps all page
>>>> tables based on device domains. This traversal is from software
>>>> perspective.
>>>>
>>>> This series dumps page tables by traversing root tables, context tables,
>>>> pasid directories and pasid tables from hardware perspective. By
>>>> specifying source identifier and PASID, it supports dumping specified
>>>> page table or all page tables in legacy mode or scalable mode.
>>>>
>>>> For a device that only supports legacy mode, specify the source
>>>> identifier, and search the root table and context table to dump its
>>>> page table. It does not support to specify PASID.
>>>>
>>>> For a device that supports scalable mode, specify a
>>>> {source identifier, PASID} pair and search the root table, context table
>>>> and pasid table to dump its page table.  If the pasid is not specified,
>>>> it is set to RID_PASID.
>>>>
>>>> Switch to dump all page tables by specifying "auto".
>>>>
>>>> Examples are as follows:
>>>> 1) Dump the page table of device "00:1f.0" that only supports legacy
>>>> mode.
>>>>
>>>> $ sudo echo 00:1f.0 >
>>>> /sys/kernel/debug/iommu/intel/domain_translation_struct
>>>> $ sudo cat /sys/kernel/debug/iommu/intel/domain_translation_struct
>>>> Device 0000:00:1f.0 @0x105407000
>>>> IOVA_PFN                PML5E                   PML4E
>>>> 0x0000000000000 |       0x0000000000000000      0x0000000105408003
>>>> 0x0000000000001 |       0x0000000000000000      0x0000000105408003
>>>> 0x0000000000002 |       0x0000000000000000      0x0000000105408003
>>>> 0x0000000000003 |       0x0000000000000000      0x0000000105408003
>>>>
>>>> PDPE                    PDE                     PTE
>>>> 0x0000000105409003      0x000000010540a003      0x0000000000000003
>>>> 0x0000000105409003      0x000000010540a003      0x0000000000001003
>>>> 0x0000000105409003      0x000000010540a003      0x0000000000002003
>>>> 0x0000000105409003      0x000000010540a003      0x0000000000003003
>>>>
>>>> [...]
>>>>
>>>> 2) Dump the page table of device "00:0a.0" with pasid "2".
>>>>
>>>> $ sudo echo 00:0a.0,2 >
>>>> /sys/kernel/debug/iommu/intel/domain_translation_struct
>>>> $ sudo cat /sys/kernel/debug/iommu/intel/domain_translation_struct
>>> What about creating a directory layout per {dev, pasid} so the user can
>>> easily figure out and dump?
>>>
>>> e.g.
>>>
>>> /sys/kernel/debug/iommu/intel/00:0a.0/0/domain_translation_struct
>>> /sys/kernel/debug/iommu/intel/00:0a.0/2/domain_translation_struct
>> Thanks.
>>
>> Do you mean create a directory for each device, whether it supports
>> PASID or not ?
> every device has PASID#0 valid, i.e. RID2PASID.
Sorry for the late response.
Got it. Thanks.
>> Seems the PASID can be assigned at runtime.
>> So it needs to support creating debugfs file at runtime in IOMMU driver.
>> Looks like this requires modifying IOMMU driver.
>>
> Isn't this patch trying to modify the driver?
I just tried not to modify the driver except debugfs.
I'll try this implementation.

Thanks,
Jingqi

