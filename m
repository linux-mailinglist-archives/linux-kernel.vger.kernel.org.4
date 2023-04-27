Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD7C6F0F26
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344277AbjD0Xi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344275AbjD0Xiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:38:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245353C31
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682638730; x=1714174730;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jlDkv+hXSSrOs83VBZk+vi3ua7nNpzkARxOnHereR2o=;
  b=K80+Ejr8bpnA5dZLCT0LGqrlr2kG/HsjKGGFLWdbXbPy9ZixQyTQHTw9
   mByEf6aSYm6yEnfo8YztjxZcldcx9o3RL7TF3N1WCB2TsGY+2LpdIcuvk
   EDWyq//IAUefkF581jTEVz/ubyaGwoTFlpKNo/UFimePLlFfWoKETBXXV
   4qh2uEp+Ap5wXCb/zhwym0hkUT/6BrsyE/wahSkccwUwKC3NzT/z5v856
   vOqTQKcQ/yYX9nkZT5tLer0FXEuhSINiPciV7yDrj1YWO8Ouj6BCsRl0L
   phKU9yX0q5iLHrSox+HCaVrPXK5C13ztA7gqPbQHDWzDjZqJ4tpXytsfC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="336632053"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="336632053"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 16:37:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="764048611"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="764048611"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2023 16:37:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 16:37:48 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 16:37:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 16:37:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 16:37:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJE2LCnG3lVseyVvvIDEYRH7TZOQEocRlqhfYXhsC2+/NTFzulw0xThpFP2xukCf4KJnkERFH71CCwGPvzc4DWo+lVdpUfEDoRJh+CUSAkmh+BRBEu/5V8ZuKHEmtAVc/nx3hIMv6LQZoaqlK9WCl4ZQpLEzAuDeYNS00cMSwm2V5EWI3r37u3hineVYgqfVORkWteapADZT+BAYO96/YpgfqEmLUxFDk9l6VHcTp/LUE3wJzh8+KC4xPZp9yad0HMI5wV6wuSv8BTA7H0fLbZz6MxWCtQyCAUMsm+P+BC2coMx4aC4hUl2o45ktWaMfAf7qZ63DWjIXceFdiXsvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPKzj/LD5SSN2cqMfWms10twV2cSgGd+AHa4LwxrRl4=;
 b=Nbu4RvrDjcrkH/1MfihLKhPivCcDzbkpIZQmwH/V2Jrn1hV8WxCKUM8RUDUlsAH1FvmjJWWm23RePQ9GKKbZTF4afcXCly3xH2XEHg35wsrThjeh5jFziyMw17kt2WXSXBg2AbwLvPLj3Wk215pl9MHr8Ko8wc+yrbLIVu1VtxecLMwwOGjrOMJYnVXfC9tOIozCgon3I995qMn/O1s5n/ipCMZQ4kdZ8nk/SSoVkwq6NkJCGVh6j2vxt5hLIU7Vy7axR78wjhKbH5ordmuZMK11+1gOoD5AFiqKQLDgsy6eLEe6kMQDRWUgQVHcZIllpZ0UhAAw/7lNIddXM4W56w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5460.namprd11.prod.outlook.com (2603:10b6:610:d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 23:37:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 23:37:44 +0000
Message-ID: <4b6bd7b9-4701-6344-9a3c-6c7ef25ec6b7@intel.com>
Date:   Thu, 27 Apr 2023 16:37:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v3 12/19] x86/resctrl: Make resctrl_mounted checks
 explicit
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
 <20230320172620.18254-13-james.morse@arm.com>
 <94b54f42-a70b-498b-ca05-62528a98cea8@intel.com>
 <b1b9225f-caa3-a868-6333-b7dadf17c5e7@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <b1b9225f-caa3-a868-6333-b7dadf17c5e7@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0069.namprd11.prod.outlook.com
 (2603:10b6:a03:80::46) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: 8337e1e2-2089-4445-c923-08db47786696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s3n398CD/VGzdqARp1/o/M8IZW45TCkiDhTJvxjXRrT+5W3+8T1khsBKI5DLk8JvdimqIQWwfvQg0VkhCnqfzKrjTodZfoREl5MBHoiBugcf4IfFyKI3fkmJmQbCfszlLXpYRbvl29GI46odcX5MUDQHZGJTPTvvJPGfghHeDLZAli7QnqxH8gB310A8MEzIHeLI09WTY311kGnoWlRe2tF4BzuOw6r4ZXug1LEyYsBa6PsxBxO4a9yr8ob1fUCtxsX1/7+CG6Hfy5NruYLlvLQM02/zg/Zo9e6zX6+sHBcGlkYWOqnqEucZVoda7zv3eyuweYC8OBnZ7IFXDan0P1QLZ2Veu//FMQRstird/DQsANF4KK/Yj/pOTDEM1aXTrhTN3URs+iJzkOkK7OQYixka8palE9ECH9HrNnq+Vo+Bb8G4tYCAph87msxbRJsv8XD/1TEQJeCCxlO1CvxmBi0CKio0OR5eCEuxbvWVDNJaDOpoAKpdy5M3d6awJLojcdOve6X0yZGQfJiynnxgv081J3mK53y/eeUy/09q6zmdEiCqBpMX8te0SZQxBR7eHOW74q+NSmC1UXGg6FCpNYrQTQxKqq7n2LxkLvXqIxxY6Mc3XUUTqdrKfMLMi/YicV66XIcQT2acxjWZ3EWJLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(26005)(2616005)(6506007)(316002)(66476007)(41300700001)(31686004)(4326008)(66556008)(66946007)(31696002)(82960400001)(83380400001)(6512007)(53546011)(186003)(86362001)(6486002)(36756003)(478600001)(5660300002)(2906002)(54906003)(38100700002)(8936002)(8676002)(44832011)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXBWVjgwUkZ4KytidlBLbCt4RlNyMy9LdmlqMXJZTFNvTUluR216d1J5Nkxn?=
 =?utf-8?B?M1N0MklyMU1IcnJUNkd4TTQ3UXN3UVNDbG9JTmFsTDExR1ZuMlRWejFCV0xh?=
 =?utf-8?B?Q1RtM24xZGJEOCtMSi9qdXBMMkxFS3VMV21WQTFTWmtsNmFzMlBuQ1E0VU5B?=
 =?utf-8?B?dmZreXdsd0ZlVkM1eXdmVlp1VWdEM1pDVU50Nk5NWjVjOEh3TldOVzU4d3lj?=
 =?utf-8?B?ZTIzU0FVUUc5N29SNE9ETThndmoyZHRlRTkrblZkcGswNHlxMzY3RmZYN0Fj?=
 =?utf-8?B?dUcyK0o3SlVCTGhtMWVqTUdzY093QytjTCtGUW95SGRCNzRuTndrVjVnWXBQ?=
 =?utf-8?B?QTF4b0N5VCtMcko5c0FEWkhGaHpHT3VqV0ZBQllCQmRqZTZnaHZ0dWphVHl5?=
 =?utf-8?B?aklqWFRqQ0RROEorTzFrNGJXdUl3OHcyOWEzakI4TjFsZFFmSVRSVDFoL2pW?=
 =?utf-8?B?a0tzWVB3aSsvZGxvUHQxOTAxOHhrUmlRTExRQkR3bW9oYUV4ZTNwaEFsa0s0?=
 =?utf-8?B?MlVGS3F3a2Z1OEd3cnMxaGxnL3czV0kvWldNaG5CNm00Um0rT3Q3aHhDTnlr?=
 =?utf-8?B?M0Z4dUx4R2xXaWlkd3FtNnV0K29vZk03UGRHR01QVEZ5MngzWDMzYmpOSjEy?=
 =?utf-8?B?RU5MYWdKWW04YTJOdytacVN2UFYxU3k3cExFc2Z4NXYzck9OaCtDYlFrT25Q?=
 =?utf-8?B?YkVrN3IwaS9RZE9vYUNaNzZsYXRtWDI5VW9hUTI4YWZJcXdSbjA4U0hBUS8w?=
 =?utf-8?B?U1NTTlZ1QnVUdG9zTk9YbXJBd0JTY2NRb21zM3UrWFprSWlYd0E0NjgwakQw?=
 =?utf-8?B?NXZneW00OWR2bm9wdXRyUk5aSXhVcGhZZ1hhSmdsemVyUk9KSi9obTdoWktK?=
 =?utf-8?B?SmtQRFppRit4WWgvMXZkRXdsQVVGMmg4UWlteDlwcTRZUVMzOW16QVdPTThL?=
 =?utf-8?B?amd4dGJvQ2U1ay9vZ1BuOEJaQW1nL0RGRENsNy9oZkhLdmVzWmkycEtTelB0?=
 =?utf-8?B?c3JLekxtckpTd0JpaWZzaHE1U3RCbFMwSTZsUnlBRUJQTWhQT2liKy9mUjAr?=
 =?utf-8?B?U1YvN0ZlRmxzdlhMMVNsajZIVnBqdVJkL0ZmSUtOU3Q4SmZ2Vk1Xb3UyUE5D?=
 =?utf-8?B?aU1HbGJ2dm5EV1FPQ0RlYTdaVU8zcllnQVZIY2NxZzIydW9OUThQVlBteW5R?=
 =?utf-8?B?QUYxaWRrNDFrSFZseWR3Q2JlamV3SUpwZGE0QkxWV1Q1VTg1RVBWaXhVbWph?=
 =?utf-8?B?R2xWeTB1SVZRME5kZVFIMFZRbEdMQWVFcmpSU0FNVEJIdDRsckR0QXduSW10?=
 =?utf-8?B?WWptQ2RqcmtocGFmc2s1UHJvbk90ZDNIejFtbEZPWjJDNjI4QlZETnVxYnNC?=
 =?utf-8?B?WENDd0R1ZmNtTm9kZitGaE9tNHU0bzZndjU4UTJYU0RNa0VuaXFtVEpJN0Jz?=
 =?utf-8?B?MWRiZWUzVjc1MFdqOG1WS2hGb1VJYUdlYlYwM2RIUzVtL3hOaXd3NERJcmxi?=
 =?utf-8?B?azlyb0xhaEI2cjgxQ1ppNWNOY3hLdVk3LzhVbjA5N1hyWDBHN3BVcmNQWlRI?=
 =?utf-8?B?VjJBS3BTYUloKzRkZjR4UkZ0bUNCUTNxMWE2STRObHhDcnNTY0VVS0VsMzU0?=
 =?utf-8?B?Sm8yczJGWVBNZEZ0WThqendjSWQzRFBrV0ZQUEJtQW9GRi9pT05RMU5sTnNF?=
 =?utf-8?B?MDdGVXhHMDhvS3RlUmNQT3RkMVZCQUl5SHVxNnJlK1hWMzJkSDJaMCtlbGdD?=
 =?utf-8?B?WC9hS2FGTjJ1U1JQYVF0Y2pXSUFoeUx5VWVJK043V3VxaFY5OThKYzZNSjli?=
 =?utf-8?B?ZnJ3MzJreEdMSllicnNiaC9FZ1I3L0NpYkVXRHlEay9FQjhNdFR4TmV3MUpu?=
 =?utf-8?B?LzNFMnkzUWVsb3Qxa1RaQ1BSVmZIOGhVemhUVUMwN3lRc0ZuNk5rTHpNNnBL?=
 =?utf-8?B?Rk92ZzJtL1h5RWF3WDJwQWlnenRoVi9rZHZYeXJxZWZNRTR0aEVpdGFIY3NB?=
 =?utf-8?B?NU1SbVFrbkhGdGNubk9ib3hZeFlIeCtHK0lTajFYdGpaOE1yTzkvUitKZU9H?=
 =?utf-8?B?WjdtMjhsVjkvaStMdWRNd2Y2aVFsS3ZOdmpBVGNxUDFQQlF1eVhuZXczV1lr?=
 =?utf-8?B?TlB3akQ0Q3NtMHJRcW1tSnE5NnNLb0xZQWgwY2hMcDBMcHhNY21OaEpEcDNu?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8337e1e2-2089-4445-c923-08db47786696
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 23:37:44.7417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jg/tgj2g9AoXb9Lil8AbbNiUOewotosC/3gefkHiDuAdG483FQh73GwrWcBS8XMK64h0Rk0KnjiEp6qfPMdaf9BHut1jLVtMV/X+U42dXVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5460
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 4/27/2023 7:19 AM, James Morse wrote:
> Hi Reinette,
> 
> On 01/04/2023 00:28, Reinette Chatre wrote:
>> On 3/20/2023 10:26 AM, James Morse wrote:
>>> The rdt_enable_key is switched when resctrl is mounted, and used to
>>> prevent a second mount of the filesystem. It also enables the
>>> architecture's context switch code.
>>>
>>> This requires another architecture to have the same set of static-keys,
>>> as resctrl depends on them too.
>>>
>>> Make the resctrl_mounted checks explicit: resctrl can keep track of
>>> whether it has been mounted once. This doesn't need to be combined with
>>> whether the arch code is context switching the CLOSID.
>>> Tests against the rdt_mon_enable_key become a test that resctrl is
>>> mounted and that monitoring is enabled.
>>
>> The last sentence above makes the code change hard to follow ...
>> (see below)
>>
>>> This will allow the static-key changing to be moved behind resctrl_arch_
>>> calls.
> 
>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> index f38cd2f12285..6279f5c98b39 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> @@ -834,7 +834,7 @@ void mbm_handle_overflow(struct work_struct *work)
>>>  
>>>  	mutex_lock(&rdtgroup_mutex);
>>>  
>>> -	if (!static_branch_likely(&rdt_mon_enable_key))
>>> +	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
>>
>> ... considering the text in the changelog the "resctrl_mounted" check seems
>> unnecessary. Looking ahead I wonder if this check would not be more
>> appropriate in patch 15?
> 
> How so?
> 
> This is secretly relying on rdt_mon_enable_key being cleared in rdt_kill_sb() when the
> filesystem is unmounted, otherwise the overflow thread keeps running once the filesystem
> is unmounted.

hmmm ... I do not think my feedback was clear. I understand that this is done
as a prep patch but that was only clear when I read patch 15 because as the
work is presented here it seems unnecessary. 

> 
> I thought it simpler to add all these checks explicitly in one go.
> That makes it simpler to thin out the static keys as their 'and its mounted' behaviour is
> no longer relied on.

Understood. If you want to keep this as a prep patch, could you please update the
changelog to reflect this? The following sentence in the changelog makes this patch
hard to follow since it essentially claims that what this patch does is unnecessary:
"Tests against the rdt_mon_enable_key become a test that resctrl is mounted
and that monitoring is enabled."

I also do still wonder why these resctrl_mounted checks cannot move to patch
15 when they are needed. Adding them there makes it obvious that rdt_mon_enable_key
had a dual purpose that patch 15 splits into two separate checks. 

Reinette




