Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC376F0F2A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344359AbjD0XkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344432AbjD0XkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:40:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507512D55
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682638807; x=1714174807;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b0Nv18EPDO/68IevaScKIlb98A/kRwioZQRK2ntey8M=;
  b=EO1mNStKl0HJ/Pt3qJ0WuWt3shei8sDwsc99gqk3xKIdK+qTdZ2Ew8ec
   elvN15jmAjTOjivkd9/gOFMzAY8U7Mwk0hT3YoAAbg3ROdi03gy3F9KIQ
   Ye53PODmLzowpyXdGhHoyBVAHoRBlZT510UbOwEcLw4X1akfTg6gEhJ3i
   kwOqkzUYudOHVfaYKn/5D2nCeZw0O0ZjB+/WZNxVdvwM6qgoRR5XLNRX8
   1Z4ITVYYN8c9RdI0DHvINxXOQQVjMZ4Qo8Tt9FtrreHrX2cCVZtcMOAFq
   158pZxEPA6zf6/EGbn08Z01JKIAKBGY7xS3klNfaoJoIyw8cFJjPA8CJC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="336632619"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="336632619"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 16:40:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="764049535"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="764049535"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2023 16:40:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 16:40:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 16:40:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 16:40:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 16:40:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HttCpQBTSnmRwvGHsG/2lU4dKSOPZd7nZvhrSpl79FxoEU7ZcNfzapCXxkA/zGkNjEzriSJLhqQCXK/efZ+klLK/oCOUD5stue9qou9p/dZqgLP9j+A2VgXC7O5naOxOEpJLKoulZaY4TbGj9gCvAtxllEPodHD60hkxlXOeWJAOXXx0RVEhglI9HptswuCYgUnIT8zcx6qa8WIvOLyHhgguqkufNAeRvLhKtKMvJ1NnOhen3tEbDZyxkQ+BQ+fNA7cm5B4s2OS3dXZxtGBEz8+x5TYhJnk7WzYMzeH3wOcxedwcHCQal1MO9aqahC+FmeNeIPw0HCswFd9Jtk2s6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hem/5pMIJA8Nc9XlSI7WUTZOZmzLUa1MWNJCfRK7/54=;
 b=noyqRNDbHUnFvn6gAy2RCiq7GL/ybSFsMyDyAdZgmNCeVMICXNfaj1/d2xjUxScBe/2/LdUDDKyYeDpi3mA8cQ7OE8Vx754BWCSsEtIRPTKEmKnb38386LjHxeQmGGxxpWyejro2V4ffJ1S8xoSu+MedMFUuh2vTOfuKQ5DUo+67wdr5bDuyPhUAT0NF7G4WB9RTrj4HucPretokYLLgf6c5ljmFK2BwQOfz02Ydn4ymJpuYwVEkn+Z3FkUF5khiVQSWodHd/ncxg4OtLe0Gn9WFEyJrSFrJqDXbzAU0LBwLYS701poe50BHwpdglhLUoa5xneB4DP+6vg3oDsTQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5460.namprd11.prod.outlook.com (2603:10b6:610:d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 23:40:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 23:40:02 +0000
Message-ID: <28845d8b-cf7a-b5b7-d5ae-1284e33d063c@intel.com>
Date:   Thu, 27 Apr 2023 16:40:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v3 11/19] x86/resctrl: Allow arch to allocate memory
 needed in resctrl_arch_rmid_read()
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
 <20230320172620.18254-12-james.morse@arm.com>
 <36af82d5-0d48-f899-9e95-1ec89be20581@intel.com>
 <24d3616a-7800-ba91-deed-8bcc639ce6ba@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <24d3616a-7800-ba91-deed-8bcc639ce6ba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0184.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8b703f-d418-4355-3602-08db4778b8c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U3cYT2tNqi9ird+7nUtJOd1lpIB9baX3NYyrOuiEvaXyd6juvW8p4aoYfRpxN2wgsMnvhLm6Tm00T8E0MR4pynj8mM8CxUhbax7VNcc9Q+QEJSwP9WWtZ5a/nIkBDWyxIFkRH1h79SWMM13I77xaTB7w4gESwXb9pEDmYGOYnmWsgxSjvRfpW5sGDHNGjmGCn5ZJAEtMot6oL1A6kGEch4Ln3Y64kHS0WzSPsGo+sI3l+qeuBzm2v6y5fX8rOAo8WAbibKwWiVXbP2SKebuzjxBcQsc4U0WayUdBfn8fgVPaWecavkOqME0PmhLKiXXrjTr5aO42zC9W1dg5aVG6O8947GOHDBeyx55IdWNf4Db83ZCKBWZwrTpOiHTuPmWL9P6dhdXGrYGxlybQV1UJ3gtT7SGk/XfceAnARNWeMmZGu1beH3h3bQM5szRHRfJtA2TdXfYthl5x8VPuPJEwqdBoM+Uqxd8JTQI7FDH3cskAYihwfNv7MMKD4utgxQ/X8hpUEBvDoXX2EiwItBTY2CyxefqsF0DM3dj0teKnHcG5MpnWAgrnXXcj4yHitnqUGjTEeBW7smb7P22aiSihDnJvZWbT9hov2MwjVzsYp1M0j06VQPd8JH7W108hOSjVR1HhNowMQiIJX2uCStEvzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(26005)(2616005)(6506007)(316002)(66476007)(41300700001)(31686004)(4326008)(66556008)(66946007)(31696002)(82960400001)(83380400001)(6512007)(53546011)(186003)(86362001)(6486002)(36756003)(478600001)(5660300002)(2906002)(54906003)(38100700002)(8936002)(8676002)(44832011)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1MzR3lyK29tSkVsTDJLSTJ2WitUMTNiZjhSaWI5bGhYS0FCMlhjZWtPNkFz?=
 =?utf-8?B?TUJWTlQxdGlxUjV3R0NxMVByN2pIQzZKSURpalYvaHo0Z1U3bjFrN2lMZFVK?=
 =?utf-8?B?aFRVUHVPMFBOR1pZWG96QTJLbUVOcHJHckRjQ3U2bkJMdm9UUDhlSGJUa3Nu?=
 =?utf-8?B?U0MzZ0RzMGpCeGZIZTNtQ2tCcnpCZ3c2WVRmTHNKQWFtWVp2Y3B3NzNCZnpx?=
 =?utf-8?B?U3p5ZERIME15Z0RqREFkdGM3cGorOWY5UDRuMXRKQ3JTTWdpTnYrMFpFNFAx?=
 =?utf-8?B?UDY1ZHZ2RDhHSVZaRFpEa09EQWkra3E3NllVS3NFZHhHSzdmK25oRW9xTHZ2?=
 =?utf-8?B?b0VodGY3WmU3dFZ2bkNPdkl2dDRSNXFNNjhNRUh6WEhydk9TYlJKeS9tRzRl?=
 =?utf-8?B?Rk9vWmdEbkZsRzVxYnVzTlNlUXZzZHVCYjV6S3RFSU0wTXJwUDBQVm1ZbEFx?=
 =?utf-8?B?ek9TNC8zcmdTbjlDYjBsd1hCT0llTitaSThvVmZlYWx0TGNSYnhYVmhzUjBX?=
 =?utf-8?B?aDZwZ09aUmFVY0pOdVFCRzh4eE1CNG5VNFBTeStPTmQ5b1RGQnhiSENhRmVH?=
 =?utf-8?B?dk9jTXRtVSs2OE9qVUNmdXNQUFplejBwTjZsR0NKY2VhZkQxTDc1Rkh2Ukwv?=
 =?utf-8?B?RHRrN0NzSytJdkJ0cFBvdmRVZzlaU3FzUmMrbVZya2F1eVNmTTZDV3djek0w?=
 =?utf-8?B?REcvdjhrN0N0NjNHWWpvWUZPV2lZclVrSytUN3ErYWl5b25OVUE2bXNEUXFN?=
 =?utf-8?B?eExqUG9sajhDU1A3bkVxN0RXZHByV0ZFblFpZHg5b1k0NkVkcWxOWE1PNmdp?=
 =?utf-8?B?VmIyWkVSVHgzUDNpWWhJOXZMeFdFajVjeW1JVXRjM0hmTDB3UnV0ODVnVjhT?=
 =?utf-8?B?N25MbGtQYTc1Ty9TamtkVXkwZ0o1WHdvRTFxbjU3c3VhWmIrWmpsaDZCREtY?=
 =?utf-8?B?MDE0MzRRaml1dlZ2OXMycjdGWm9ERHZMN2hrSGhNZFpTMUl2RkpMMW9HL1NV?=
 =?utf-8?B?cUY1d0I3djJ4SnFuMFZLQWh4QmhkK1VydGwrQlBMVVZtUFIyd1RnT1VDVEpD?=
 =?utf-8?B?U215ci9vZHJ2WVRGYnRpallXRGI2MFczajRqemtVanQrUmRvVGcyclZFWFdV?=
 =?utf-8?B?T0Z3dElzS1hnVThKYit2bEFrT2NuWisrQ09WeUVCd0d5dGtxVmRSNnJtU0Mv?=
 =?utf-8?B?M3E0dXB5dWJsYWFRdzFHSVkzclEyWDRlZDBSaFZwek9ucXdnYUE3MjdKWW5Y?=
 =?utf-8?B?WHFuN0k5Y3JKbFFYdXhQU0UzeWdlTWNpWTJ6UXpzQmJvVVMwTEl2aFNJVWVj?=
 =?utf-8?B?aVJIeGhzbjEwWUcrVVdFUUFGeWp0V1NlcHd6OEpPeHc3RnlVL3dWdHdNTkdi?=
 =?utf-8?B?WHM0WlVtVWFQV29ueDZaWnhLUnNyTFFlTHoxc285Y05aR1AyT2k2Wm1TdWs1?=
 =?utf-8?B?NVRFZDdzMHVGMTNtcVA5RWkyQTJMcVoyQlZ2REdsOEtGY2xMSWpDd00rNzNX?=
 =?utf-8?B?MkpxaEhIQ3crMTBqNFlRZHNFalBGWWtnUU5YRTVpZkNaODE2NnFva1lTb3lm?=
 =?utf-8?B?c2RhRjkzdENML1hVV3JqeEU1TEJtUkhjdWJFdXlhVjNmcUdYSnNsaWMyVjNh?=
 =?utf-8?B?N2hWWjl0d0NUSWdUWFZDb1NDTzdTQzVoRkNDOURsVXY0Q216OEpSclM5a3Q3?=
 =?utf-8?B?dGpXMHZUR3llK0VLVzEzUFhXSlZkVWYyTHFwblBmR3loS0xySmNPK0w3TzEr?=
 =?utf-8?B?bVpzV1QyVi9sb0R0YVNhdTFkWkhuaWFjQU1mNmtQYS9BeHhWZjRpUng5TlFG?=
 =?utf-8?B?d0tNNDFYbFdlOXhZcnB5dlYzSStMQjkxVVpURnR6UzZ3Ty9JNmpDS3dleUpu?=
 =?utf-8?B?c0pMVkVsNFczV2NqN1c2SWhwR3V4ZFdacUUwdC9kTzRHZkpETDVJaHZRYjlu?=
 =?utf-8?B?bmN4NWdZNGZXZUkrQ0dYTkMzdmxaQzBjSGFINFJMaVJpYzlLSFpZSDNzc2o0?=
 =?utf-8?B?a2RMSExtVGoxdC9ZcTRIZHlzYThzUjdzVGpCenE1eEZLNzNoZ2tXMStRMTRF?=
 =?utf-8?B?MllWYnNZYXFpdVo1VXkrcmVodmVoWlNWQUo0ZUI0VnR5Y29YSkVmYzhYMTd4?=
 =?utf-8?B?YmNmcTU1MThWMzc1RWoyYzNmMktvOERBSDV5eVJySFM2eEhMTXIwWFdFZlh2?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8b703f-d418-4355-3602-08db4778b8c3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 23:40:02.6311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJDU/8PEBK9feh9V7viTThRDaYpSMKE+MQyC5RCWVr+3Mxs/Kw3SAqQsWWf3xgUJ7JM4J2PtrB3GOm+0bXNALTwjvMpqAMRZU2N0Zmd6yLA=
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
> On 01/04/2023 00:27, Reinette Chatre wrote:
>> On 3/20/2023 10:26 AM, James Morse wrote:

...

>>>  #include <linux/module.h>
>>>  #include <linux/sizes.h>
>>>  #include <linux/slab.h>
>>> @@ -271,7 +272,7 @@ static void smp_call_rmid_read(void *_arg)
>>>  
>>>  int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>>>  			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
>>> -			   u64 *val)
>>> +			   u64 *val, int ignored)
>>>  {
>>>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>>  	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>>> @@ -317,9 +318,14 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>>>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>>>  	struct rmid_entry *entry;
>>>  	u32 idx, cur_idx = 1;
>>> +	int arch_mon_ctx;
>>>  	bool rmid_dirty;
>>>  	u64 val = 0;
>>>  
>>> +	arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
>>> +	if (arch_mon_ctx < 0)
>>> +		return;
> 
>> The vision for this is not clear to me. When I read that context needs to be allocated
>> I expect it to return a pointer to some new context, not an int. What would the
>> "context" consist of?
> 
> It might just need a different name.
> 
> For MPAM, this is allocating a monitor, which is the hardware that does the counting in
> the cache or the memory controller. The number of monitors is an implementation choice,
> and may not match the number of CLOSID/RMID that are in use. There aren't guaranteed to be
> enough to allocate one for every control or monitor group up front.
> 
> The int being returned is the allocated monitor's index. It identifies which monitor needs
> programming to read the provided CLOSID/RMID, and the counter register to read with the value.

I see.

> 
> I can allocate memory for an int if you think that is clearer.
> (I was hoping to leave that for whoever needs something bigger than a pointer)

I'd rather not complicate it in this way.

>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>> index ff7452f644e4..03e4f41cd336 100644
>>> --- a/include/linux/resctrl.h
>>> +++ b/include/linux/resctrl.h
>>> @@ -233,6 +233,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>>>   * @rmid:		rmid of the counter to read.
>>>   * @eventid:		eventid to read, e.g. L3 occupancy.
>>>   * @val:		result of the counter read in bytes.
>>> + * @arch_mon_ctx:	An allocated context from resctrl_arch_mon_ctx_alloc().
>>>   *
> 
>> Could this description be expanded to indicate what this context is used for?
> 
> Sure,
> "An architecture specific value from resctrl_arch_mon_ctx_alloc(), for MPAM this
> identifies the hardware monitor allocated for this read request".

This helps. Thank you.

Reinette
