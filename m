Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870F66BBC75
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjCOSkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjCOSj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:39:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4292222CA;
        Wed, 15 Mar 2023 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678905540; x=1710441540;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3rWFMh0uHiV3a3/sgggsOBs9lkqjK2OXlx9TdJ2aLg0=;
  b=OdOxQ/GafKDLySy6+tMD4YNq3b+M4SqBKJ68NiO9QJ/rNrCduOofX2aX
   o7TuC6/OLCmshQGdn76p6Iig8spkbaDJ1eKLWIkiRVR3SumOk06lHuRLR
   9nsnlJ3SezG8CpDsfnLHHzp7ypK2RavoDmFpZIXoyHRgIr/0ofVg4Pc1/
   5tWAz9TlCQvi4Va/1veEvuFkemp+8Y/9ouJxerhGLa5XKAfiZN90GcjYD
   PZHVBBTE7olJY9NngHsC3VBbYs5qnLdUq+nKJFOoWlyGGoj5P9REcgVDx
   fRmFI1NIOFRclUVzEjWi913aPyanNhoXVaNw+jUS6a2LvL9DVvEYMyJxx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="339333254"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="339333254"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:37:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="679601041"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="679601041"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 15 Mar 2023 11:37:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 11:37:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 11:37:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 11:37:48 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 11:37:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcI8mwDXs3J6JqgvCcfdQiIhnCSh7mBNuwwE1XTqUAQ5HKrg5+k5krzppi5ugwHy3rHLsioeS+IMzbGtjMOJbEb8uZPOFGIqtja70saZzxyv8axqWeQKPzb7KaUvolZmgR2gI4qptcTwBPUaiLzh5cxJeio+H0cPTnhf13yeR8pWFGJazi7shU4inrO1E2FNId3bWL7QBDCTk1SQ8S8vc63g308UC6D9T2gkE8YC3zfp6CQp5AAO2hwl885FD6Nn+YF29GIaltY806WdqEcvfa/Jv0Z4kHSIgz6AfwLSaN7xxd7m1rd1Bq9clbLxz0P3v5BmZXlXyMElNeTp3iAgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLsg7kEjav6dF6sh4v6CJkNg3IrS0Xw6g5k5eTbkBhg=;
 b=TVLW9bdWEWkHdaLSgk1ZGxKRpducr36CDmjM+f5snstIZwrgSB0CCw+m7F6fYihs1TZUHyb6Ph1kZx97uem9Jbpd8wAKPkd/d3H0bnnsPiiex6Oc12gXVvrS5sUC/9ir7GWQtSo5IBGqTkisrgP3lxMzmGCg1Q1MVyZLonGl2/dKZRHKf+4p5cpKRN83oNJXFRewJZzhJwgdWRY3L5yHmM5hurdioVxZU8elAgpqJ6ZRkdb997VRfSqOs6jlk62CboV2IO8tPwKPAziOtn4tCXAqk5ES0TQTgZPjTj2fGPdYzQ1NutIprcfWf7MsV3LrPrXc01vIrGzHVO6wH0sr5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA0PR11MB7814.namprd11.prod.outlook.com (2603:10b6:208:408::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 18:37:45 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Wed, 15 Mar
 2023 18:37:45 +0000
Message-ID: <26400c6a-dcde-9ac2-df7a-117a12875f0c@intel.com>
Date:   Wed, 15 Mar 2023 11:37:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v3 4/7] x86/resctrl: Re-arrange RFTYPE flags based on
 hierarchy
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
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778868692.1053859.13490646651097380957.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <167778868692.1053859.13490646651097380957.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::36) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA0PR11MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7908ac-364d-4674-a0c6-08db25845dce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gec8qySnzojZQQ80BuKa5nOxv8ZEo4Aj4qMEt+fZS3w1qK0PTEozog+xIcLY5gN1PrvjlYhArSuCVfAsvwNDFfEMWeK7MSvjThZE03QLdDOoPq0HIziiTgrCzHE5AOcGdzvQrwhw+GGwQRYqgze9q+Mnl44bwxAYV0UKdJsXAl2V4TckqaFw1WkFhwWGGXOLeVB1/uvOQuJ0B9F4YwvEX5cKEz0ROradXRa4MWL/W0PLhB+rhSXnqQMkVlp/s1W5yMV9kiF7RPkzssii53XlX2rqeuMTX+z7SwuRrU2/5sI8Wsf1r6fP2tJ6W5WH+9PCFp/HPpIX1Lka1dSS5rRQZp3KKGdr+8CJ4aRp9c9DP5HL1t9iRfNZGV4Pp4/k7GvyHloUcUXffmq+3xU1SjFBDJhDxvYw607lgeYwQfeOjrsiylFKHZV1IWcalILQ/TQ5eE7Cg+kFvuB0medTiPX0aWSpCcwLMuum2SuqLEKEZmQExyKI4qZUbrgHzgItlf2VxA5bKJPzqTMSMA8lb6ME4qkYYfBMU0wEnf+j86p7o1hfnu3wCO4yGXOAbP+I6ZqW0tByDalEI2z7JNEHA+nUG1tZBWDT8WlUtJM8n/d98iQC6xc7jzoQlphlcUBDvfXoFEvVxsyA4mU7kHSczc4RzoctpLIXcI3+r9sZmeypX8AQDQmmVoCvv+Lj+iKGYIg7L9ojThdR0qEokuUE7KG11oMJJGll9NAkJcZBEATgflY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199018)(31686004)(36756003)(41300700001)(7416002)(7406005)(8936002)(4326008)(5660300002)(44832011)(2906002)(38100700002)(31696002)(86362001)(82960400001)(478600001)(6486002)(6666004)(8676002)(66946007)(66556008)(26005)(66476007)(6506007)(316002)(186003)(6512007)(2616005)(83380400001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnhMVVRpQ0JlYWh6R2VreUcyNVg3bVNLUnRiZlJmRkl6dUNUeU1JaHkwYjJy?=
 =?utf-8?B?cmhPTDVCOVJwWGNOS1hCNU8vOENmVEhKRFpNMi9rM0F0N0NmWWp6cmdEazRl?=
 =?utf-8?B?dTE5Tk9kU3RhUnBFR1VuOWpJSWxqbU1jUm1vclpBVjFIdERySWdkNDF1ZVpO?=
 =?utf-8?B?Z1NHYzhoMGhJVzEzNk9rbnVVUll2cEZ4OW1NQjRqNDMzMGpSR0F6eDdhRDR2?=
 =?utf-8?B?eVUvejl3Ykk5N3pVT0N6VXAwUWxtSzZ6NlprcE5uWEIwMFNHd1o1QWNMbm1M?=
 =?utf-8?B?Zy9tbjlDM1FKWTRFeXdQS1lKNEtVL01EUnYzOWpnSjE4TXErMTlXVnoxQ2Vs?=
 =?utf-8?B?Sm13Q0VrWkRpTmxLZ1pZYVVwam80RjIwZ3g5dFFyRWlpTHNocUFQMjBPR1p4?=
 =?utf-8?B?ejZsU0svRjYxUXVPVmp2Znh4MFQ4am0xTFFMeXgvZ09SRDJnWjJZOFRybUtR?=
 =?utf-8?B?QU10MURsek1sSHI4cU05YUJDUm9nS1Q1ZHV5TTlMMjY0d3RjMVVnK2FhOG4x?=
 =?utf-8?B?TlM3ZjhkaVU4UmZQWCtWNm5RUitPV1BPMFNydFNzYUFBYU44a3grbHgyM3I4?=
 =?utf-8?B?L0xQTkJrcENvQ1p4eFdCeTYzSWVYQTNVKzIxWk00WTFLdzBqMXU3N3Y1Sk1H?=
 =?utf-8?B?NEZsTG56MDlndFJCYXBpU3hndWowNnpRNE9wY3hzNHRzNmc1dHpNWG81QjVz?=
 =?utf-8?B?VSs2a0tQK3lpbkNQeEs0UHRFaVllKzVNc3BrR3VkckRkT0xQbldQTWJ0TzQz?=
 =?utf-8?B?UzlGeThKUllDL2prRGFMNjZXb1dGcElRZ1pLc2lWYThQNTIzSUhmOGozbTJo?=
 =?utf-8?B?Q2JsYXJjYmNZRjFPZ01Ici82bG5SZFIwOVM3QWpwNUN2MVNhVHZsNWpaRStE?=
 =?utf-8?B?UzI4L1NGK0hxVFN6YnhiNGtGMGtYSmpOVFBmQkUxZFVpdmgxa3pBTkY5THVn?=
 =?utf-8?B?OTFKVXBGV0dHUWtXcUxQZ0lMSGRQSTFaMWMwa2h0U0RLLzRRaURJL0FycjdT?=
 =?utf-8?B?Mm51R0pXbHhmMzZtS1AwYkJFMnhnTHpLNWFZZ2VDSXJ1ay81K0prU083ajdm?=
 =?utf-8?B?NG1hUHRFc1AxcStPdVFoeDNCanlnSGZweGMvWGxwL0FWMVBNY29seGdpVWJX?=
 =?utf-8?B?SG1MZm81OGd5eHU3Z0l5Z1JwUnNPc0ZHVk5KK1loZk1LQytScGcwL3c0ZnBx?=
 =?utf-8?B?ODdDaWx5NlM2MVVoUlg3UTVkbVV3d1hZelQrcnltcU85eWFwVnRpK00xd2E0?=
 =?utf-8?B?ZU43cGtvZWl1S1BXNjFYQzBwTEp1VmVyaU45azUxbjFuRTg4aldITFNaSWJI?=
 =?utf-8?B?NEllZlNqUFlNcVNtaWtkQXhMbUJ5UXNDNHYxY2N5emFISzlhVFU2akZDYXM3?=
 =?utf-8?B?eWx2T2RFT29XdC93eE9CR1ljYm42M0JYeERvSk9OMGQ1aFNmMHBMeWxEQ25O?=
 =?utf-8?B?TkhNM2k2dmsyL0c3ODgrd1hoQi95OFBBRmVNeFRheWR5dHJTLzh1ZTRCWkYx?=
 =?utf-8?B?anFXbmZmWnlsa3c5OG41L21wU0dMV3kxWWhOeUc5UkFlQ0pyZnVScGpKYzRl?=
 =?utf-8?B?a3ZlRm9neTBDUVU4dFhLL2V0QTh1T0pWZXhvOGFmV3JzMnVjc3VteXpQMzJx?=
 =?utf-8?B?bDdGSlMrYmw2SkFPUURwZkY3TjRyWmlHQ3VRTVVjRXQ4bkRERjhvZFBzaEIv?=
 =?utf-8?B?ZjBkcUVqMXgydmtDV2RPN2gyVEUxeWM3NEJQM25PTnpydEJScUdrOWJsZTRr?=
 =?utf-8?B?Z3BGTCs5Z29LRVlzRGJkaEpxOUxyU1NQTEVnd3hNSTI5amUrQ2pWbk1waHY5?=
 =?utf-8?B?T0NORVgrQlBTOUNka00yTndaTnJUM1EvN21kdEZJZklSdktraUYwSXVqK0Er?=
 =?utf-8?B?dklUWHB2N3BkOXAreU9zV04zUkt0MGF6cW8yeGpaWmVRbzZyY3FwM293S3N4?=
 =?utf-8?B?SmVOOXU3czYyME5JaUFhWmk0QVVydXl4Y0RzbEpBMDFwWUYwZk8yTmRTVXBY?=
 =?utf-8?B?TDhYQkk4ZTNrb0JtdGtRbGxqWDhsa3JrUFptZFlZWW9XMUJXMm1CbmV0Y0du?=
 =?utf-8?B?c245TkhFT0F6OTdaMFJHRXJ6NUQ5SWxOV1JaWDBEbVY1UDdNOVhpcHNjakFD?=
 =?utf-8?B?WlpLUi82ZnBEcU9IblJsQVl6eXd3M2lxNTVvSnVFeGVQaUpVcDcwNm5lVVpv?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7908ac-364d-4674-a0c6-08db25845dce
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 18:37:44.5915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlVEl9JQYAj6jjxwUratztoCsvVkypIQTTQHyij99P6NPYTPHv4274K2jlU4RKAhuM9HIvmnwK/Ju0/a+jdIoPH7IUNVaiwubjRxc716nxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7814
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 3/2/2023 12:24 PM, Babu Moger wrote:
> RESCTRL filesystem has two main components:
> a. info (Details on resources and monitoring)
> b. base (Details on CONTROL and MON groups)
> 
> The rftype flags can be renamed accordingly for better understanding.
> For example:
> RFTYPE_INFO     : Files with these flags go in info directory

This is not a rename but the current name.

> RFTYPE_INFO_MON : Files with these flags go in info/L3_MON

How does this improve the current RFTYPE_MON_INFO?

> RFTYPE_BASE     : Files with these flags go in group's(control or mon)
>                   base directory
This is not a rename but the current name.

> RFTYPE_BASE_CTRL: Files with these flags go in only CONTROL groups

How does this improve current RFTYPE_CTRL_BASE ?

> 
> Add comments to make it easy for future additions.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     |    8 ++--
>  arch/x86/kernel/cpu/resctrl/internal.h |   64 ++++++++++++++++++++++++++++----
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   44 +++++++++++-----------
>  3 files changed, 81 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 030d3b409768..d1c6b2cc8611 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -69,7 +69,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  			.domains		= domain_init(RDT_RESOURCE_L3),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
> -			.fflags			= RFTYPE_RES_CACHE,
> +			.fflags			= RFTYPE_CACHE,
>  		},

How does this rename improve understanding?

...

> @@ -97,7 +97,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  			.domains		= domain_init(RDT_RESOURCE_MBA),
>  			.parse_ctrlval		= parse_bw,
>  			.format_str		= "%d=%*u",
> -			.fflags			= RFTYPE_RES_MB,
> +			.fflags			= RFTYPE_MB,
>  		},
>  	},
>  	[RDT_RESOURCE_SMBA] =

ditto.


...

> + *
>   */
>  #define RFTYPE_INFO			BIT(0)
>  #define RFTYPE_BASE			BIT(1)
> -#define RFTYPE_CTRL			BIT(4)
> -#define RFTYPE_MON			BIT(5)
> -#define RFTYPE_TOP			BIT(6)
> -#define RFTYPE_RES_CACHE		BIT(8)
> -#define RFTYPE_RES_MB			BIT(9)
> -#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
> -#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
> -#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
> -#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
> +
> +#define RFTYPE_TOP			BIT(2)
> +#define RFTYPE_MON			BIT(3)
> +#define RFTYPE_RES			BIT(4)
> +
> +#define RFTYPE_CACHE			BIT(5)
> +#define RFTYPE_MB			BIT(6)
> +
> +#define RFTYPE_CTRL			BIT(8)
> +
> +#define RFTYPE_INFO_TOP			(RFTYPE_INFO | RFTYPE_TOP)
> +#define RFTYPE_INFO_MON			(RFTYPE_INFO | RFTYPE_MON)
> +#define RFTYPE_INFO_RES			(RFTYPE_INFO | RFTYPE_RES)
> +
> +#define RFTYPE_BASE_CTRL		(RFTYPE_BASE | RFTYPE_CTRL)
>  

It is not clear to me how any of the renames improves understanding.

How does renaming RFTYPE_CTRL_BASE to RFTYPE_BASE_CTRL improve
understanding? Renaming RFTYPE_MON_INFO to RFTYPE_INFO_MON?

This all seems unnecessary.

...

> @@ -3218,7 +3218,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  	if (rtype == RDTCTRL_GROUP)
>  		fflags = RFTYPE_BASE | RFTYPE_CTRL;
>  	else
> -		fflags = RFTYPE_BASE | RFTYPE_MON;
> +		fflags = RFTYPE_BASE;
>  

Is this intended?

Reinette
