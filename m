Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE67772359E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 05:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjFFDLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 23:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjFFDLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:11:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D7D118
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 20:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686021081; x=1717557081;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9Z3RZ0bLr1E5FoW92Wh3rJVqDOFOD7PtEHdDkePi2ls=;
  b=m5qDvUBv7HOhiWbYIdyZQKWz6GBGP5EkmeF9L+l3stHglym6oz7XkBNd
   LJuguFTq83i3gZh89Y/Kt23froiNFTRUjyAWfgc1xEUYw7bW83dfer1DJ
   rMIOSKx1CMure81wbiPoTSVcWCf4hEnZAIiDauYszRizFSaROXqdhz594
   Md71Gev/fQy/8fx9OFDJEH+d5uQchfCYEqrVDbp5Y1uPLyBeExErCkvgG
   TJDmG00O4Svy7aLzE+o9fkLBSr8FDknYkyC4ZtE0FV6lp8ueaEH+I2mqG
   MK41qsvsikw5JIAO4iZP4xtQRtFQmBCd3unoJ9j7tt2PUowco19VyV1H0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="420096320"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="420096320"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 20:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="883162865"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="883162865"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 05 Jun 2023 20:11:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 20:11:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 20:11:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 5 Jun 2023 20:11:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 5 Jun 2023 20:11:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNtoCrLqSpxUFCet68h41NASpteE8NcO6SLUta4Tc3H/2Rw4ZlVMzBdoQDkhpoeIlVSO8bMeJAWdqNLXJg1i0j+btvxjOQdZDmyCr5k4aBq97Ecld/rrYvG/vxfHWuqMAMiSJY+uTZi0Grp4lhE+LBCXGWfweAj8uqZguMjM3BkRD0xyM4LWJmKo4UmwcD0EExzLIiaLB0Sy4leOnHKJdpHh7GPWEkXxzo4uhil4wYkX/5PWq0ybmenZbH8t6kkh5OSnlaw14NGVpJDvAtuxIT97560azD+UxvMPHzc2FAyN//NVoW4xm/jqm0x7YcDdWF8rwXSYI69id0WnJcdnpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0PTptSUOd21hoIEplM1tLKRcoTeIhvf/Oa1Slp35GE=;
 b=HCK8eBG2sQuv1xCI+z5sO4pDR0TE8BR2vVxqsaUK5jzhO8Mlg+N8lc2OvFlViB00qiv5qC5+AOFZ73+PG+b8fpwDTcTT9d51JTUkTnh+gBOJ5vifM9iB/hVfI7XuXI5/Rv+SqMP6Ba1GaAKPazKm1PMKpHjSYs4VHDbUUa9DiD0AcTTWI8XUb4ID0ww0qsW3fdAPN3ihvKFwoRj2yzTey21cwS4xpz61FLC1TovSo1tbBOaGd2bqL4jC4bQ7/U7q7KotFjW20SzVDB55Ibzmfcr9U4pjrFs0eHRNcLKQMcaEZ1Ejn+B0DMqeO/UPuQCyNwo72DKnehSMe428vPx1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Tue, 6 Jun
 2023 03:11:17 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 03:11:17 +0000
Message-ID: <205e7eae-fb30-1464-447a-5d284417c603@intel.com>
Date:   Tue, 6 Jun 2023 11:11:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH 00/14] Reduce preallocations for maple tree
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>
CC:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        <maple-tree@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, "Liu, Yujie" <yujie.liu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
 <7a5dc9ce-b58f-e1b3-db1a-d00a8a556ae5@intel.com>
 <fad3c833-1ab3-2d34-aa85-dcc7c40c3587@bytedance.com>
 <a9d2ab1b-23a5-8c06-9f7a-6872c726db03@intel.com>
 <b5f2d527-8887-eb0b-d3f2-4e7cd8f3c022@intel.com>
 <4fb5f66d-c8c2-f857-7461-b974154dbc2b@bytedance.com>
 <20230605140344.66pwpdg5zgb6rfa7@revolver>
 <9f4c10bb-ee7c-cd41-f1b9-c1a7a1a562fd@google.com>
 <d4d7157d-1e5b-fc7e-34de-66def46a344c@intel.com>
 <ff754a68-4f94-e818-a31f-c8a1fd11b4b5@google.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <ff754a68-4f94-e818-a31f-c8a1fd11b4b5@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SN7PR11MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: e45189fc-e4af-4707-8a7c-08db663bb187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGJQ4TJGaw+b61OQGNmrB7iBoxbrxmz59cgqcuUZO5/cT8H3otOV3/saKTO45cB4pS7LpUVFxFwCY6ewbbjD6RvrdXfSEQEKFLHNrAhrcFUfMVzY1jFySdjyssb1dwwptDpkUw/YMK/zitaCX5+5ANJJJ8Ue2NMQehLxP5TTcQjIdpRPogOxnd+gB/EAmJ6xi3DVMV1htlbjd1IFmY1AyxYqb7qu0F4vWJDQcK5y0razMkOQvOoaOXYt5hY0TtBDTu7wiXJynYKRYl5icKNC8M3yp4Fzdkd2ZX970p8C84t8j7MDInGsUIABMSX1ebYeDB+ciwni9ViLNiYbcoj1F9POG5+5DVjBNYsWAK3GZRxAmzMc2YNes31Yz+iO2qweGdW1bFf3AbkZHIQzW/9RV6YAY9lNZv66i5yMmNhaBFqvzghnbzebNzL3TkkP3Ljn5P7ZGd4qdArWL+MmNhGFin/ysSw3eaBb1ICirSBpCVRBaq6fMUSl5vAgegaRP4o0J6emDYcY1cb6m5RpIVcMi27mx5hwK76bMnetVgjWdI+lEbeH8pMxkQ7Yi3sOs/fduOPgo/aGbY7q3GmLeF8VNfOgBLvzREnz6Zho6HmBgzU05vHrGjAnsF02jZYBEpmzg4yOuYLuIRcPzepisXkEtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(41300700001)(316002)(54906003)(82960400001)(5660300002)(478600001)(2906002)(66476007)(66946007)(66556008)(6916009)(4326008)(8676002)(8936002)(31686004)(6666004)(6486002)(31696002)(86362001)(186003)(38100700002)(2616005)(36756003)(26005)(53546011)(6512007)(6506007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2NPZWYvSEc1U0pVNjZ0NXRObkpUTUdOeG9UNTltZ25WZlVkMUh2NjhzdzJs?=
 =?utf-8?B?bWd4NTExZ1RsTTNLU2xsak42SjJUSXhidUNCeVhNN3laMmE5TjdyQ0lpSXlC?=
 =?utf-8?B?aExCZEtGVExKKzFHSDRwbktwT25nR1lxOGVEc1B6N3V6RkVRK0pSVXBlejRL?=
 =?utf-8?B?OCsxZjg2TXVJcWs2K1lWdmhNbytlSXZCQXB2MUM5eDBla2l4aWg5QUcyVlhF?=
 =?utf-8?B?a0VmL3pQbWFGaGs3Z3Z3YUY3SVVlL1RQN0FnZFZIMkloblZ5L0xrRHozOHFJ?=
 =?utf-8?B?Q0NHTlBqbDZPNU1GTGxTV053STR2dWg5ZU9FL1VaY2VVR1FvTnAzS2lPYm1z?=
 =?utf-8?B?Ym8xQmNzdmxheFJhYTRvQ09jdlFLSXZDeXhrNDRUWU5teEoralUrbzF6cmlz?=
 =?utf-8?B?dUYwRXdnZm05M2NRSm5ENWtXS1pISHhPdjYydnFGZHFmNXFPVUtBWUwvNEdX?=
 =?utf-8?B?dnB3L3FlUldJTG1jVUZBWDdTRHQ5eWRrTG9SZzdaa1ltNUs1dXJYWTljVU0z?=
 =?utf-8?B?cWlKZ21vdXZ0Z2lQeHBBQ2tWZzlhN1NuZEhlMklmRmtLY1Eva09vY1FhcFRB?=
 =?utf-8?B?a2tOV1lyTDMxOWVlZU1rd0V6bFAzUWFxcCtaRDhmQjVqbXNGNWFDaVlMbW5T?=
 =?utf-8?B?N09mdUlNSWl5N0c1NHBFay9nanhGejVDOXJRQS93d1NROGxkckV4SUUxbUFp?=
 =?utf-8?B?RHVMcWVzaGo4aHc1ekUwT2RlTFA1TGxsMUJOWStpUGd1ektyaVd5dmVaTHVr?=
 =?utf-8?B?MUlUR0VvckNESXlTbkFTOHJaRDdaN3FiTUxCZjhpdmcxV2VCMml5Mmd6RGxh?=
 =?utf-8?B?OWxYeXdGN2pnMUpkQjR0NE1ESkQ4OWxIUU9GbllnWnVUd3UrZkVrdnFxYXNo?=
 =?utf-8?B?MElLVU45SmthT2FFNklvWVlXeDVPYTJ3SW90SFJLQXh4cVhLMHVWdGV4Q3Fp?=
 =?utf-8?B?bzB4aWprOFRVWkJXYlR1MzY5b1V6alJocWtxK2daVWlCWGdwdWVKLzJ1UjBQ?=
 =?utf-8?B?YnRsc0IzRHBkcEZmSXo1RXlLVE04YWlJRk8yRERRUW9wTnRyQnV6WDkvbkxy?=
 =?utf-8?B?NU1QRTg5a3VSWW5SN1QxZXlzR0tGQ2d1M2tab05ta2dNUmVSbnFmRGxaczht?=
 =?utf-8?B?QXNDZVFIWGdvb2FpZ1Q4c0Mwc05HVHlwQ09obk1VYkRKeHgyWnY3ajhqWFlQ?=
 =?utf-8?B?a2JNcUt5T0RGSmFCNThVNGErSllMVG1YWS8vNmh4ZDU1SEVrU0I0Ni93alFB?=
 =?utf-8?B?b0NQRnVpbjVZbFJEdmRodUpYdWlsNmh3V1lKVUNwc1JLRFMrZ2kvUXVsZlRF?=
 =?utf-8?B?bUZQV0huTWNkeGdXYlh5QWxjYnIrU0JpbzVsYVpYS3o1MEdjSkVqWXJKV1RR?=
 =?utf-8?B?YzVLVmxieHp6WkZZSlhtd1lJMDdvbUFBa0hnR3F1anBVRkVIYzBzN1RhaS9W?=
 =?utf-8?B?aVBOQ0J6RGFkMy9ET2FzRzF4RS8wSnlPek1FajVDU0M3QnJnR3gxMGYxK0VK?=
 =?utf-8?B?SXlDSk9JcWgrdGZYSHhKeUVoME5CR2ZRck9KZUJQVnlPVmFlYnVvTWxZZ1k3?=
 =?utf-8?B?L2E5clZlZGpTQ0g4YU5DeUVNcXlzSmFWTWt1T2h5ZEZwc3ozZlhaUlBuUmFi?=
 =?utf-8?B?Smk3V3R6MHN2UnJwdEtYVmZKLzJqazFxSDBWd2dxcmJuY2pYV1JENnExc2xy?=
 =?utf-8?B?cld2T29ScisvOWJOMktpUGdZY0JsN0Q3alV6UVFMVzJlYXVoZ2lIc2w1emlL?=
 =?utf-8?B?N3oxSVpjWEdOeU9NZ0NDSHJGUklsdU9GMDZsZ01vbVpaYXNNTVdPQ2czcE1l?=
 =?utf-8?B?UFZOdUcrT28vdTNXMEFIUE4wQ2tOM083WHJBY1lGK0Zxbys0UUduY1V3WkY2?=
 =?utf-8?B?OE5zVTJRS3JpcUFmMllNV2lKZEEzYzA0YnBGdEJaK09DY0JJMVE4dWNmMUU5?=
 =?utf-8?B?ZzNzM05GN1pkQytwbmVRR0hwZzVFakNJU1dJVkN6T3NQNlJja0d1Z3llazJE?=
 =?utf-8?B?T1QrUUk1RmEya3FrQXRmaVBDNEI3ZmdSSC82WE52VnJHN1dTM3Jwcmh4NUhV?=
 =?utf-8?B?ZTJLK3JUZjZHVGExVnJvakNGZ2ZyelE3eFJDQ1ExaFJPUXZuQ2t0ZWlWUG9U?=
 =?utf-8?Q?EhoQlb9TpdbEJ89PRCqSKHNUW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e45189fc-e4af-4707-8a7c-08db663bb187
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 03:11:17.4110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0hBEDAd9gTdLCHDsCJD9ebDXZWBcy2IDb8zwIsosM5+uaJBL1WQ+qq/xWgwYnflw+g1NmasdF5+M5gdSPBKkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6776
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



On 6/6/2023 11:08 AM, Hugh Dickins wrote:
> On Tue, 6 Jun 2023, Yin, Fengwei wrote:
>> On 6/6/2023 10:41 AM, Hugh Dickins wrote:
>>> On Mon, 5 Jun 2023, Liam R. Howlett wrote:
>>>>
>>>> You mean "mm: update validate_mm() to use vma iterator" here I guess.  I
>>>> have it as a different commit id in my branch.
>>>>
>>>> I 'restored' some of the checking because I was able to work around not
>>>> having the mt_dump() definition with the vma iterator.  I'm now
>>>> wondering how wide spread CONFIG_DEBUG_VM is used and if I should not
>>>> have added these extra checks.
>>>
>>> Most CONFIG_DEBUG_VM checks are quite cheap, mostly VM_BUG_ONs for
>> Indeed. I had CONFIG_DEBUG_VM enabled and didn't see surprise perf report.
>>
>>
>>> easily checked conditions.  If validate_mm() is still the kind of thing
>>> it used to be, checking through every vma on every mmap operation, please
>>> don't bring that into CONFIG_DEBUG_VM - it distorts performance too much,
>>> so always used to be under a separate CONFIG_DEBUG_VM_RB instead.
>> So does this mean CONFIG_DEBUG_VM is allowed to be enabled for performance
>> testing? Thanks.
> 
> I was going to say:
> No, I did not mean that: I just meant that even developers not doing
> strict performance testing still like to keep a rough eye on performance
> changes; and historically CONFIG_DEBUG_VM has not distorted very much.
> 
> But then I wonder about certain distros which (wrongly or rightly) turn
> CONFIG_DEBUG_VM on: I expect they do performance testing on their kernels.
Fair enough. Thanks for explanation.

Regards
Yin, Fengwei

> 
> Hugh
