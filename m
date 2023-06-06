Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68745723582
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 04:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbjFFCzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 22:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjFFCzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 22:55:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DAB102
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 19:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686020136; x=1717556136;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=XNGXIiAV8ULs5UJqZAkYi3EOj2Fm24b+D2suF7UEwI0=;
  b=OmQaRQJ3Ohwmq9MSU2s/bly+MpbFHljhERhmUcZRkvSAnxlpvtmJ/LKJ
   wDQpW3Cwo/MKYpf/F6ZCv2Vi0m5VRfw0XXJROkhPS3UlCR8rHnT4J281D
   QCjD9HuxeKABMNIJah+fxXqcbXrLH7XU2hEh9Lq6qrgaxDy9RXTFvno63
   0qhDdmWQ5XQr73V7f6kdgf46iERpxhrnVJfj97xrYoErFu1HLXGDURkfD
   W+HqEI6Rwyt2dIIG0Kygb9V3AkU+4oxWW9XjtWoQRP3OZbcQYIrInJN3G
   gp9JsxcMxA4bXkWoxpCPChyysLZdiBT/ON8clWWjr+tIKw9lkJeJVgsuN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="356554582"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="356554582"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 19:55:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="738585555"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="738585555"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 05 Jun 2023 19:55:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 19:55:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 19:55:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 5 Jun 2023 19:55:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 5 Jun 2023 19:55:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2xl/FEMDMBChyX10/BF0gx8PazP8NDl4lJ8WcCGdvfipLJvEeaMIPlwKXgEWqbV9O/Rzxp9+8RLTqvjKM38aytw3FkJiCE7XEZILFQB6k+LRENFKMtrzGYeEwlP90vqG2mZUlRFs9SjRaWYycaMNzdNdwA+e8gmYHP6zoSbgdcYG/ZGtmi1+0Fv716RIy7HgTOysakpGu61PLtc1eOS9nHmYfmFLpDuMkMh1i6I0xAd1EyGRNYCsn5Vayxt+U3/19zw+8VwU3+B1OzblzNFP2kyIZazHOQW1gJiiLmQZsPTNHQrKw972AArH+mPnspXMK3N9SX4F9mh0AMaeNSjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXvKtg+HdLe+XIy3KYPc3YDmCC32i2uGPCIQ8eOHMFY=;
 b=RhnCaiCrIYbtiNZ3cMAAT6Y4wSxPC6b77ySouuRiVTeVPMIoplezg4LvssdwTNCavRfpmmj8mGA4rnnK2QNKeX05kmtTSsfwj187TSXNOu8FDjKcPMgYnxoMu5CxKonDsvGhfooycL/eBW4tCSoL4jdkZVB1tjx1W5Imb6hIAghORu7xgeoj9QzbXrNbd9ERi75tIsOJSuCXS2n68J6vTnZIKf/xUSRjUSEp0LyxvSQOXnuiTEGlGXcBR2LHMQ1sZmSbayiJw+JPkNmR1pZ9m6EpCXb+KIMdEbnm8aF4odhSkip1hzu3uJfYEmU4LFLYwtg2JjSwZwO+NH6Clj5qcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BL1PR11MB5432.namprd11.prod.outlook.com (2603:10b6:208:319::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 02:55:32 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 02:55:32 +0000
Message-ID: <d4d7157d-1e5b-fc7e-34de-66def46a344c@intel.com>
Date:   Tue, 6 Jun 2023 10:55:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH 00/14] Reduce preallocations for maple tree
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        <maple-tree@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, "Liu, Yujie" <yujie.liu@intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
 <7a5dc9ce-b58f-e1b3-db1a-d00a8a556ae5@intel.com>
 <fad3c833-1ab3-2d34-aa85-dcc7c40c3587@bytedance.com>
 <a9d2ab1b-23a5-8c06-9f7a-6872c726db03@intel.com>
 <b5f2d527-8887-eb0b-d3f2-4e7cd8f3c022@intel.com>
 <4fb5f66d-c8c2-f857-7461-b974154dbc2b@bytedance.com>
 <20230605140344.66pwpdg5zgb6rfa7@revolver>
 <9f4c10bb-ee7c-cd41-f1b9-c1a7a1a562fd@google.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <9f4c10bb-ee7c-cd41-f1b9-c1a7a1a562fd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|BL1PR11MB5432:EE_
X-MS-Office365-Filtering-Correlation-Id: f33c9453-09df-4551-05be-08db66397e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5L/HnnXQLFlWXJkGXIkTAsgTmBmAKdijqdzB9Ud6TxpCo8hfDvMRd5RnSzSf9E07vXi0HUVvYInK1CtvhSudFQ584ntWnP0D0vJdvWtKXvPZznXd4SaX3nhVNc/R5Eea6hdH8NZEKrv0m6oS18NWSoYWY/gWheF+5BlWyZQvOaPqkd1Xnv38BGpQsDEuU5hHyQ1C5/NsZ6UKwlsNerEd3vo2/EWVn0rtteJmnDUAYrzaBFFGBJQkhYO6wSRHNYVPLmcMHrKOZiMrmhIEtxZx2e3cGpoDYM42xD8JEipLLbT9YgvwP6ok2wUafG7N2kUQcHY8D/HoOLugkG0l6HdIumHq4gtM73dDbSm31fk6GvCp9b5bWj4R72LE3mKYbz1K5msr7kxcSQAa5Q5lKegp+N+jAHJDsIWWmvTaj141TGsMkSC4bBfhH6C+cs1rE2vqZKwImm37OAIv6Tuva9CqHp3MzrIKNBEdAHtjJbaLcbKDGZlJm/3guTR3z/ZHhbVYVItjdWNOXdhR5illyLl0iZvnuo17VrEOYjh8nClHDx5ZdMB8AvnOOUplnBv8zVypVIotIIHPcTdYfrA0zlFZbR5qb2jOI9qtKKFP9omOuyyotrsI1pCQyumG1BpT9As8r1rbP0Vcrd5a8iWPgH6pRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199021)(86362001)(83380400001)(110136005)(38100700002)(66556008)(66946007)(66476007)(6666004)(6486002)(478600001)(2906002)(36756003)(186003)(2616005)(8936002)(8676002)(41300700001)(316002)(5660300002)(82960400001)(31696002)(31686004)(26005)(53546011)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkFhRWE3b1dFUHVHSnhDQ1hmZUo5bFVRVlpMbUo5LzJOMkt2cFBvSm1yRkRa?=
 =?utf-8?B?QkJWR0hWYnV0ZWhza2VkbmJ4STd6TVVMQ3FNR2RXd1VSUzlLb3NaOWJBQ3Mw?=
 =?utf-8?B?MkdxYlg4Vm41NnVmbVppbjQ0UDRSVTdiVHdiRG1vRXpNQlpZQTJ4ZU55TG1a?=
 =?utf-8?B?T0NvejNwVFJ4ZXFkWnJyaGZkNGhpQXNGR0Z2YnFEaFNYMGM0MjZDdkJjUzBT?=
 =?utf-8?B?RGRVaWo1ZFQvV2Z2eFV3eUtDQ3cvblg1MEZhS1NUMmxueXd2eHNySW4zcnFY?=
 =?utf-8?B?cUlmWWRVeDRvUmo3SzJKSTB2VEdha3d2RU5wWmZuNTdpYTNxdDNsSDYwYWYy?=
 =?utf-8?B?UWc5RnhiYmtjUHMxK0pYL0doZ3pvRVpJRFdjbGlQc1lTNW9UOVZJK21Dd1NK?=
 =?utf-8?B?cnROeGpDdWJxa1luQ0tMQ1hwNzBkRlI2ZVhLNUdlMTgyU2p0NlRkalcwVHp4?=
 =?utf-8?B?WVZQdmZyci9VNVBMWVozbWo4Y0NaTDZPaHcwMDQ3Qm5ONTJPaFo0OVRvQTZ6?=
 =?utf-8?B?cHVmMHE0VDZXcHdpMTdEdlovVVB0d3AzdU1GUHFmc2NWNFpTVEhpcENJVVdG?=
 =?utf-8?B?ZjFjZGk3NVl4OXYvSDZRRmo0THJYWERqVkRQekNTdTdYd3g3dVhYYkRVVURR?=
 =?utf-8?B?M0dqUW51aGZnZ3AzVEhjS1NNdXBWZmJ1eUdwVHFOemRnc292SThTMDYxYjJV?=
 =?utf-8?B?WU1DMmVKZ2hlbGFoRkRKa3crQkxFa0orQ3A0Z1dBRWc2YWk0SzZVMWdvOHdz?=
 =?utf-8?B?NzR4djZmVGVJL21BWCs0RFBHOHp6Q092UVVuWGJKWFY0V2pETE14aHpKTFVm?=
 =?utf-8?B?STVnWFpjZWFlQ0xtL2x5NHR2aDF3UlpQV2M0UTlFV3NGQkRHQmtVWm5mdUNJ?=
 =?utf-8?B?NFp1bVdxVzBrdkEvbXFEdEoxMDZlMU4vOThHTGphWFFJQUJIb2x3Zk9WMnhX?=
 =?utf-8?B?TTRDSUFkcjNKalNpd0lJQWtpSnNmcW1Lem4wUnlSYmZra2MzTUdCYWxHSnJR?=
 =?utf-8?B?TUJTU2dVVWp6Zk91ZlNrUnU2dkJjVmdXOVE1cmJObFlTcXc4L0JneDFCVVRl?=
 =?utf-8?B?Y2p5aXZkSGE5U1hnWVJRVHJPdVhFaWM2eUlXcEVpbzl2OU9zcjNpRzRGbCs2?=
 =?utf-8?B?YVprcXRhSDNScTlVYWlXbnNFcG5JQlZDMXhWQWhrVTd6eHAwNmFIVXpGbHVJ?=
 =?utf-8?B?WUlMcjlmU2lqbFo1cGtXaFN2bGV2ODBjdlNKN00zaFU5TkRNWE5sOG5JeVdo?=
 =?utf-8?B?amZ3Q0RtamFxQnBqU204ZEVZZGNHMlBvMzZmNUxlQSsrcUVzMm5DTHRRUnFi?=
 =?utf-8?B?OGw2a3lIVEhLNnZqeUdoZ0xpRzQ5dmZwSDl2aGZCcXF3MS90Z1dabTlZWEx2?=
 =?utf-8?B?ZDdzdTdiTTNkYlFyWitZUjZUTkZDSUs0UEU2RHNnY1A0ci90cVVnWUs2bFVp?=
 =?utf-8?B?VG5yS3F2bnVzSWR6TllnelcyRllhU1ZVZ0ZKL0M4RVRNc0tjck9ZZmZYZ0NE?=
 =?utf-8?B?Qm5WcG13MURpckgwb3ViMXZKN21YaUhMMUZ1cGhMZ2NsZWdUbGptM1diTG9S?=
 =?utf-8?B?a2c2Mmk3UTNvYktSVHIyUEp2TUxYRlNjMUNTVG9ON1BlaUg4OEd3WWxSV2Nv?=
 =?utf-8?B?ZzV2TzBXQVl6WWRIcnJsYWwzMjRBZlBxRWppRm0xWU1UZDBlYjFCVFEzUWg3?=
 =?utf-8?B?RXlUSGdhdENLY3ErYTlVTHNHMTI2SUZLSzF1RnpkdkNROUJtZDVGdEhId293?=
 =?utf-8?B?dE1zUTdMQktoVHhlTFlIaWY5THo4VWNKSWM0dzl1SnRFNW0xRE1oU1dkVitz?=
 =?utf-8?B?OWU2cUFOME9UVWI1Rmh0eUY0RVk2M0RyOE5GU1padVY0TDF1NDAvWVZJeE1v?=
 =?utf-8?B?NVBPMTJtejJ2cVFVQ2ZDMTJyYk91ZW80dDRtc1ZSV3FObXV2TTJrUGNHS296?=
 =?utf-8?B?aHpmV3lLaGNuT2ptTC9lL2ZDZjlwMW9wbU9tV0tWRGd5UTltTEloR1dVdHVT?=
 =?utf-8?B?OEJpTGk5L1lXQ0djMnVzYmpKc1RLRUZaU1VtdUVCSXptZXpWcC9CelFjWDJS?=
 =?utf-8?B?TVNmQ1ZjVU0wNnNxdzl6WUJLbXpSejdPaDRLMmdOTFUxdkhYVG1MS3hEL1A2?=
 =?utf-8?Q?htzZRwOcvTde4xl3RqQtNuYNY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f33c9453-09df-4551-05be-08db66397e66
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 02:55:32.5327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0dnsmNerwYJSjk1/I/andUSQTw/GYwAH1xn+kpVsvbBE6iykMUlEMccQQ4urr4hhxGUYASs7CmuNZHbI1THjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5432
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

Hi Huge,

On 6/6/2023 10:41 AM, Hugh Dickins wrote:
> On Mon, 5 Jun 2023, Liam R. Howlett wrote:
>>
>> You mean "mm: update validate_mm() to use vma iterator" here I guess.  I
>> have it as a different commit id in my branch.
>>
>> I 'restored' some of the checking because I was able to work around not
>> having the mt_dump() definition with the vma iterator.  I'm now
>> wondering how wide spread CONFIG_DEBUG_VM is used and if I should not
>> have added these extra checks.
> 
> Most CONFIG_DEBUG_VM checks are quite cheap, mostly VM_BUG_ONs for
Indeed. I had CONFIG_DEBUG_VM enabled and didn't see surprise perf report.


> easily checked conditions.  If validate_mm() is still the kind of thing
> it used to be, checking through every vma on every mmap operation, please
> don't bring that into CONFIG_DEBUG_VM - it distorts performance too much,
> so always used to be under a separate CONFIG_DEBUG_VM_RB instead.
So does this mean CONFIG_DEBUG_VM is allowed to be enabled for performance
testing? Thanks.


Regards
Yin, Fengwei

> 
> Hugh
