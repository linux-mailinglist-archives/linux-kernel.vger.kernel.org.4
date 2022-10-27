Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC406100A6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbiJ0Suw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbiJ0SuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:50:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CF42E6BF;
        Thu, 27 Oct 2022 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666896607; x=1698432607;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZqaJiJDe50WsUgdHyMZUWt93nQHRwkxinUm1qNCJyHU=;
  b=YXm5H2wOjCiUEBnAY0yLYCSs8do5Ax4qDITyhhHh/99qPpgQ5SOrDFlh
   l0AoLqLmaeVY9Gk8mgwk2ctRX1KREmuy9IoK113HAJ8ydeBLUljFwmdwi
   Fbkdy5QGrghHnkmwioTe9iQewbM/QsPtbIuX7Z4EnXojMEDMUHSq1kCLq
   4G3QIBts70J88O9c+AawbzYHq50scVfNmWL6l14Vtq+NYsgE2HzLXeXa5
   ou3XNbk9EyWWH3m+SDUN1m6vij0uQ2HMbbgoqEVa7Vh5a2uRI/NZxPq5e
   7cFbKDYWXAZ5dISQoaguRJP4vbrv7cPdSpwU21SXM6lBo0dUI60cTS2sN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="370379315"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="370379315"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 11:50:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="635018500"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="635018500"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 27 Oct 2022 11:50:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 11:50:02 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 11:50:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 27 Oct 2022 11:50:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 27 Oct 2022 11:50:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciDky7XoKJO4qi8BMRGsuxtg3xcWHtk6s2jrfSpPZGafeQoNcUE7010eZTxV3XooIqXrBBnUI+OfKrWCUmw0W+jODF9kgBARcRmP5a1iPlRT7+T4k0k0y9NGAE817ZVfmdUwFNSWPyqpauLW8f1In5ePcDQtV/4zhBCA8jovIXA0+qtMz6WEQ2bj9zqKmBzcehjbdndI/Scsh6/mdN1Hks4h0aYHkOt+aSKyxxyPOqDWKVJuXWFkW3hQmMi+an0+Fs/O4/nHakWVihJJ+vhbGYVabErD6SQrd/czcpcsr66FetDOAWqdbADgMef881gHsy1bZzsq97WEeK2ZHMxgiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rw1vHK7zORtf8AqUMOHywVDe1WmikG4Hv9Pg+S/UzAQ=;
 b=dxdBCy1wbDEhs3P4b8n+vb6sPC9odvrc1yWcX2l3tw+B1n9FwNW2MXwysft8epdOrRWQlWPBLJVoEvn3VbGcSz73tUWEJHXytfsTsxMeHO4SzFZXNUEIjGek+3m9NFqxUpvMwsdNHSAWfFOBh1WzIXvnmDJ/UYspfuCKQaqoysE6uwoZqHkksaLS07zwb3i+3YAt2rcsOsOmw040mmLjTPnkHB1HzuyaR/ZyHjdF4afPMB7bG60cKPjXEqY9F6g5tNGFm/QXLA5sUj/gqxXjp/S7My3wPST65rGbLzDr6khwctiLBYtEeCaGkbhY8hVczB/qQEBEXxKucL1U4r37oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ2PR11MB7519.namprd11.prod.outlook.com (2603:10b6:a03:4c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 18:49:55 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5746.028; Thu, 27 Oct
 2022 18:49:55 +0000
Message-ID: <1f30019f-51ac-0d73-3024-03a7b33544e4@intel.com>
Date:   Thu, 27 Oct 2022 11:49:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v7 01/12] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
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
        <eranian@google.com>
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
 <166604557098.5345.506719195181543985.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166604557098.5345.506719195181543985.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::25) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ2PR11MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: aefe319f-7f91-4ac4-4997-08dab84c09b8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVEm6oi6FyU0Iq0BubifHooPFms/82mEc5uFhW9RgJ8Yue++NqQHqH5GiU5Zj8DJ5LDRS9IDzv7P/0ikfnzSSD0NrN5sxPfb6EzjbHzkdmVo3gFLhCqiNEc3P+uaC/Wf8WJJsffgTbq+34bcTRCe4oWkYRom1yN+PPxwkmU6KEfUhCHKFx4GnQIj0snywKQWpx81blPbouk1qV6DY8izrk1s7HP0LFehe0HFxXVEDHPR99r98Zc8ldteApnowwVx+TV2H52QQ/PABvMiXxA6SqQlEpY6JaJe+QT7afs5PXErkD3OZEjg2mDOj8cFrfpkTcHm5lkGsOLXgDiV0KfyOTIJrQHl/11OcDGkBWXkp8Sna0vF6BClwFUe6RvUb2Sf1pcsfpdulaxGhEAR2caAEScZtXWikztLVXU8yauBZlHwIFCeSIow27bMZSoYelcNRJsbcDHlLNH/BJqzzukxWKQ7C58bf4sQjgoADOyxhhHdbWpYAuIaPItpIQwD7Vu/+X0u3QqZpFMsCE7s2PitM5cOYAVkn7S8e5xruRGoLt7FczqnWOFPvqh34gHImcPXqxcVw7+ZDK5qaFC2kqCZr4ey4YZmu2q3i4rbrQugfMFm3+WR0Bs8OkbdoQ1XRXDbZF1oK7mcIhqJS8KyWStW9DZ0d/FykX2ndLAoiIaOGiYPD39sUcMCXGeURldGNXlI3nZ3Mj5JiOiGa3QCKOxQHz0Hzt11VfEvJnza2l3lEQeqQY8WQWqwuUFxeE+V/ysPx3s2cHFQbscozktKm6HiU7wvIH9Grvjd7/n8gLBiwLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199015)(6486002)(478600001)(31686004)(4326008)(31696002)(316002)(53546011)(8676002)(66946007)(66476007)(66556008)(86362001)(6666004)(6506007)(6512007)(82960400001)(26005)(41300700001)(5660300002)(2906002)(83380400001)(7416002)(8936002)(4744005)(2616005)(38100700002)(186003)(44832011)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEY4cS96MlNWZEhtcWFpcks3VnNRQ2lObGpvR0ExWXJkeVRBdDJNaFN2RGZG?=
 =?utf-8?B?T2tJcUlYZ2Y1c2J0b0s5ejN6am45N3A5LzVyN0NpWituRnZtZERpNzlMQzJ2?=
 =?utf-8?B?enJXZ25Nc1VmTXhERnZPN24wS2VKT3NMYmxuM0FRTHpoYm9WbUNqMGVOTTVk?=
 =?utf-8?B?MjJwOWpqWmN1LzJOek5VcWFIT2ZsZnkvYlczV0thMjR0d0MyNnIyY3E4cTlL?=
 =?utf-8?B?QTNJTENLbzIva0htSmwyMkV3ak5WQVg5MWhicG9QV2huVlkyM0s0SUlaSmVQ?=
 =?utf-8?B?YW8xV21MUHduU2VLVXdWNkRtTkRDYTFWWmZvREVpYlhqRDNNbks0cEtJaE50?=
 =?utf-8?B?T2t1cDhNZzJyTkpDYjJqUDFlOGkxTkJDTGRhTVlUM1VoZ3R3MFhYYy9RU1l0?=
 =?utf-8?B?TEtCQndRMi9BZTJ4K2V0eng3ZkdsZWZNSEJWN0ludHFReG9SM1JMWXZSNzdj?=
 =?utf-8?B?ZXlCemNxMlJpcGVWekk3VlQreFpXTkF1TG94QktieFhYS0xobjlPSmhSK2Za?=
 =?utf-8?B?YTVLZ01lUHlYM0VhUWkwRncrUFFISjlZQit6S2ZFeW5xOUx3dHExSTBVU25H?=
 =?utf-8?B?WWpzNDBtTGs3MTFaYlZIT1BtZ2REazA4U0lJTU1GY1BpblhZMkVWMEFzeFZV?=
 =?utf-8?B?TGJmQWQ3YkFkMU1FcVZ5bm9WUlpnWlB1Q0MvYjVCRGZ0SEJqbzMvR0FrOElT?=
 =?utf-8?B?eTZ4MHlaSTliKzlRaUtVblliUHlqREpJWTlpS096WHJRbEZwOG50MEtoMUts?=
 =?utf-8?B?K0x4R29JelM1eUgrWGFmdkZCK0NKYlRNZkQ4Q0JNWnRaQUxRb2hoOVo0STJ1?=
 =?utf-8?B?ckhmdlEzeHF1dDV3WjF3dlUvQjNzREJjVWNWd0tqcDAwU3MyZU9tZ0xCMERa?=
 =?utf-8?B?U0k1ajVaVVdFbmJjcHBYQmxKU3dkUzZtdnFRdW1Ibm9oSGd1bzJSakdETGRI?=
 =?utf-8?B?amFkZTBnenBhSUROUkprNCt0R0lwTzlDc2hWWHZhemRjZmdlNXNzS3h3d0ZH?=
 =?utf-8?B?ZlI2ZVpsaDZIOFhuWHE2OVVlSlVMakhOQzVkcnN5SDNYMFpVU252Q0RVdncy?=
 =?utf-8?B?OG1aaTROSVBRL2N2dk1pK000RHBQSkpyRFl6Z2g0ZlprUUVnTGUrNEFjUHNu?=
 =?utf-8?B?Y01iTzRrbjg5a3hqc21sVmZJcDJWdDR0TkZNWjRrR2FteFlLMFFoQU5FY0FD?=
 =?utf-8?B?RWtGdTRjc3ZPMEo1bXQ0MGVQd3hjQ3piN2Q0eENhdWFVS0I2NnlqWlJ5S3dV?=
 =?utf-8?B?aGhLSlJDTE9KVnRpOW1JL2FhTENUdndLdnlXdW0wNlV6dEE4K3lES0FFYmFF?=
 =?utf-8?B?c0cyb0d3QzV6OUtsa2I5dlppM2RZeEVlSFI4eXZqV0ZWZ1ludE9RR0c4NUpz?=
 =?utf-8?B?NVBYeERWdzlYYUl4YjBvNkIraWUrUGFkL0VmMzRudzZiY1hFaTk3QUNVMmhx?=
 =?utf-8?B?b21HWjdGdGh2THhsTE5pa0NiNzk5YWV3YnlZdElybHk3Ty9OOHNTRklWcXpP?=
 =?utf-8?B?SVNTZ3F6dU5YQXkrK1RDeTNldUN0K0xQN3V6bHh3NHRqWWlrd0JJbXkzeGQ3?=
 =?utf-8?B?enpPQW1rdnVNQUxvWXdRZTE5QmZDTUxxT3U4OWxqSWh3aHFSZHpiVURRTjI3?=
 =?utf-8?B?aVpUM3lSVEVVRDJIWHl1U1dXL3NDT05rUlhTc1ZnSmVDMmwxOHFqUWs2SlRU?=
 =?utf-8?B?UkRFZU90MWkzME9BRkR5RUIwdytJbzMrQnpyR3ExL0I3cW1mY1hwbi9mWUIw?=
 =?utf-8?B?L1F6SmpWUThqVjYxeDRyK0FORDM1dFgvdFNGUDRsK2dnNTczYmxHQkNEU3gw?=
 =?utf-8?B?VDZmdFA5dU1OVWN2M1ZJS0RpdmI2Ukx1L0dOYWRFOUVpTmdNOWJmNE00TWRv?=
 =?utf-8?B?UTNMOFZOZEFoczBqWG1DcVM5ckhqaTFuY3lITjJrWUdRbHBCSjZVRGxEdTlR?=
 =?utf-8?B?dlBGR013Mnc1MXpiMlFYWmJkSXdIUjM3eThZWGxYcWo0T0hvSWY3OTJCdzdk?=
 =?utf-8?B?eTM4d1NpVkJuRElMbzYveGMxcGN0ZENxd2J5dDNNS2c4U2ZCTWZxL1RIbDY4?=
 =?utf-8?B?L2I5aGxxTldQeEZ4VzFyZUhFbFUwL2dDUXl3R0llYTBIMG9mMjVlRzlhQkQ0?=
 =?utf-8?B?RjRRSXVVaGVycDhORkxYWlNqcUxabmNSN0tac0VZemZCdEN6T1ZjYkUxUHJa?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aefe319f-7f91-4ac4-4997-08dab84c09b8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:49:54.9256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNQPcYSUtno5+kJxAwR94z7JF6rqcYPCVyQd9rGC7NCLQWfTkE+PMKINPrGEYQApqDsdid7OaXZnGGEjQwDGyS9QljNBlvDcDJr3ddZKr3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7519
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/17/2022 3:26 PM, Babu Moger wrote:
> ---
>  arch/x86/include/asm/cpufeatures.h |    1 +
>  arch/x86/kernel/cpu/scattered.c    |    1 +
>  2 files changed, 2 insertions(+)
> 

I see arch/x86/include/asm/cpufeatures.h patches that also include
a change to tools/arch/x86/include/asm/cpufeatures.h in support
of perf. I do not know the customs here but I see others
change both in the same patch and if it is not done together a separate
patch to tools/arch/x86/include/asm/cpufeatures.h would be required
anyway to address the inevitable perf build warning.

Reinette

