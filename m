Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358746461DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLGTs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiLGTsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:48:21 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924146A775
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 11:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670442500; x=1701978500;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4ZPP83MfqwzdUSCWIXQbLvexfRZKjAu5tJcOi5qvgFk=;
  b=ggXH4KiFmhUvC9PtPiaigBUwNgKJOplU9tYgSMllGqU4Ph3vN4wb75eO
   jDP5mGMQ8Z/VumDHS0Eb9lnqpiQzDNm/koUaskqybuzKZyBoGW3+TWAXi
   tOx0pxtfyQN1Bd7uw7GGz4L5FCAxvwCOnYGuYgnF/m4j4aQhsw2/tqWh9
   sG36UnqZoZ0A/ARHFZGVTfOx5PeAV2agHkay7Ma+bIvE8/ngsfRrbWRY/
   lXMoo5EowOJ6Q9Sl1vDS+0MPkuR2R0RFJO6K5TtFlUd1JjEQ2JoyFh7jC
   kx3lN38gslblUBxevl7CglUI0pNVUlS9OsgT2pJp8tvR3byv2Wh1ODOkj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="318126413"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="318126413"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 11:48:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="715306285"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="715306285"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 07 Dec 2022 11:48:19 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 11:48:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 11:48:18 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 7 Dec 2022 11:48:18 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 7 Dec 2022 11:48:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCGtzRm/gz9VWMAi20JYMt71dP4iEvtV1bUWXS6SKYLg5aejNnE2szukakDKeXcjtrI9jSgQB4dBAzXy5DhIEFMqSx/6hBoYhL4PQ04m536wUwOFV8ey4tZdgspL3m8esdEWQ21CVz4/niSfx8sGvySA5oHwmELk1EEXAlsc+HPkYrzKSAyqdO/AFhgXCSnZB/lOrdz+s0rlWV1w3BfgYRvcAEQaiHAaFgNPcvJQnb0tY0Q7UKE1c/RvFlLwDUutAyeg6DOtXzOwiM+LiGZPZxh+TtXSyA2jPp8k9nr7WDwd9l55xTssa/ltEO3zHRGFAOoFJ3Z8U4KsVbUyN68LIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwkEOZPmckILx3CIa4LZ5M/B4MXhzmPKKUaDLkZ18Ds=;
 b=kDFHagdt+JZDyDJ8Hf7SAP8GT+qzzAM9j6YuP2iZlxWcXNlbp5qRuYCTaZ4FlIHxyvWZhsyIz6AmdDx8zR08UrxG/cxy7fLpbRfnZhzBKrfRdoFw/Lz6hqW1BAnFbfArvfPdpKIsokNyhmUBu6f832+r/i4+vkYxOGREEeXjku1JEYFCVkqRYT9ilpgEErS5sSFU8HN5WyBDLTw4i3M5KIc68xf9oIpZbFrTRAGKsKdH1AZqNseO66gniOw6MtZHx7EZuT9NTwq9X9pC7N6dAoRrVSd4rlszVmtbQ5cF5ev+dyNXtPsUzrZZnJdNelZqtz5u2fNJE5LS8mevwoXQ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MW4PR11MB6620.namprd11.prod.outlook.com (2603:10b6:303:1ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 19:48:13 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 19:48:13 +0000
Message-ID: <f58e6af2-aa16-9461-d40d-1e4e52ee6943@intel.com>
Date:   Wed, 7 Dec 2022 11:48:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH] x86/resctrl: Fix event counts regression in reused RMIDs
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <eranian@google.com>
References: <20221207112924.3602960-1-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221207112924.3602960-1-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:a03:180::40) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MW4PR11MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5fa2ba-9737-43a3-df47-08dad88bf9d1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewM3NVEAqa/RKo0NbyCt/R2owkd2Z3euP/9iFQWsNNTj+sh8FdGqPL8FlBm87PV/vBI07dtMp0qw2TYkUKczZlujr0HYUNeTXIitrus53niyxqhBkeJun8F5yZAW+a1+tnTMVAPCjKR/xTGai5oBvM2eMPJZDCqct8gCReVsSE2HBD6KKC8pNNnSSil77UpJtcMrNmHxng7aRPTW3nl0piczaVTtIPab+wHMXTN2W9CJdWGFvNp4VKb3tTOE15R5pEX8WvZtzgpRVHz/mbn2dq+W+pJwUwARRDXBWpkRgSzON2zbC5AU52Nobn8GeM/MzeM1i62DKflcIOnfdCZDOH3NDM5bYsVrIwY2MxH00JfGvv6zKWKDw4HDEpLCds2spN6kScpa7YmGGvwMP2jy7oHSnszmP18pU8bSsoQT1N2ISewOiJ9JLWbP0jEiJ8Xd0QUYwgcuOZuPrEOWGQHbAP4ZXcZ6BzU0DUSn8jepN3ffOleH9GSRniZQVR/LvTuBDF/DUdrBH6fPitEQlwCWeoxbw0aRIDikgPat0fD7D5fGRkeLENXlwNfu3i+WNGhMaGSXxPGQvpVmeSc57LG34v0Q5wO3lC+x1qI26e4+davYWLliyGc3qhPSIphtgiYVxjageiFoADg56SHVlsbQNOgfCokD46wI0l8geAkeT0V8m7uyJlIX7ammjY2bihLECoGThaSrIo/YgTrr9ffKXas42D9VDqk5Z7efwHC5jEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199015)(6506007)(26005)(6512007)(83380400001)(36756003)(53546011)(2616005)(82960400001)(54906003)(186003)(7416002)(110136005)(31696002)(66476007)(66946007)(316002)(4326008)(5660300002)(31686004)(38100700002)(86362001)(8676002)(41300700001)(478600001)(66556008)(6486002)(44832011)(6636002)(8936002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXBMMDNHeFl3TGdmTnYrd29XOG9lUTR6bXMyZE0rUnQ3SUc5TEdIaGx6aElw?=
 =?utf-8?B?cmZFQW5hVU5qWDJEajdzSjM2L3hjTUdPZ0xrLytadDZlMmM1c2xVTWs0MW9h?=
 =?utf-8?B?Ty9vdGhrbmpWNFpMTEdlS1dLSWZGdGxka0tJTW8yS2U1ZnVONXBuTHhIbFVF?=
 =?utf-8?B?by9WdjVsSjE1cWRHUEdrMGlvUGRSV2lUSVI5QzZ4ejUvbkdOb0NtSmtsRUx6?=
 =?utf-8?B?V0UyQjJSTWd5bDFlWjZBekJxOTNiM1JMSDQzaUJYd3R4aGxGRDgyRkY2eTYr?=
 =?utf-8?B?d1d3QkUvKzY3UUpHYnBmWFVZWFNvTkhHckJjUWFKRWZXUGU0anZTL0VFVUtk?=
 =?utf-8?B?UG02OHdmOGVnakdYWWI2RTgvcVcvQjlPek9pcFc3Rndrb2ljbU95NExFdGpS?=
 =?utf-8?B?Zjh6NStGN0owdmZNRko1akMwcnpGTmdiMVVMaHJSVmsvVEJES0tkNVVuV2M4?=
 =?utf-8?B?M3kvdno3UlhFWml5MExSYlZEdjdRZUVTK252UkEwQTlpRlJmSE8ySkFXWlBX?=
 =?utf-8?B?VUxPRU8wMzVFNk5HZDhEZXMvNnB4a09zZHRrR2pRNEFLSzR2OFl4Y29rVUhv?=
 =?utf-8?B?N2hNejdMWVp1ZXZhODJDNFFXK1pVbVpkY00zakpiMzJ3K0VWcnZBVUtBWTlT?=
 =?utf-8?B?OUVRYW5Tbk1la0puVkVGWlpwT2RRUCtEWXZ0bG9HYWExaUptZVJvUkVpQ1dZ?=
 =?utf-8?B?N0p6YTg2aFFIUzNEQU1hSjE5cmdlWlpVZ0pjRm9XM244bTlQUW5ReVV4L3VT?=
 =?utf-8?B?bzcxVmp4UitCOFBXeEJKOFM5V2NLUExvMnRWRWhCcGc1UjhOMFI3RmNPSExs?=
 =?utf-8?B?NWVIK1FxZGNWc1Q5UXFaVGNtY0hYaWJzM00rUGVZbTlWNW9OakhWVmVDZ084?=
 =?utf-8?B?Mm5kZWgrTFEyTEFDVUR3bm9NKzZic2g5cjZDT3FqZHRLRUF5VXJka1gyQ2xo?=
 =?utf-8?B?WmZVQUsvNURxV2Q1T3dMTDhoaVdlZS9oZUVycGtIbXBwRG1NblB2aE5ha0ZH?=
 =?utf-8?B?NDBGekVtRWdja0RBRGN3Y0R2VDYvU042K25NcGNrQi9BNnZWdmxNQktkVGda?=
 =?utf-8?B?Y3ozTks3TndFSlVNT1hZQVN4elRPSkpXSzBYU05KajRrdHFPenhLZ05GcUt1?=
 =?utf-8?B?c2NDQ2lrVlFEajI2M3QvZ3F4T3FiNWRxZStuOXBIVzFUaWtWbmRsTzlxSUxM?=
 =?utf-8?B?M1paMFZWSENjbnRTRFJMM1RmMWhBVUcxaVFqT2JEME1ZcGovTTNEcHQyYURM?=
 =?utf-8?B?STAzZ1R0L2RKMVdaNHhuWEgya0ozTXRKcm1Yc1dBdU93eHhxSmo2Z3UxSmRE?=
 =?utf-8?B?RFZSRit5VGc4T0dGWldjTk1rQlYxenV6YXJFMVdmcG5nWEZ4ejlLMlA0VFFE?=
 =?utf-8?B?cmN5S29mTGlwSkYyeDBub3dVc1VZTFhLT1I0QzVPVkZybVRsdHZjN3VaYW1v?=
 =?utf-8?B?dGlHNHJmRFRmKzJlWk1IbUlJOTFXV29ZeDkrN01ZTk11R3J5cjdKNE9CVE9z?=
 =?utf-8?B?R3J5dlZVMTh2UFZjWllia3pTTjlQQ3lGVnl4bmlzcDV5NnF1SHJWR2szNC9l?=
 =?utf-8?B?Y1EvdkQ5ekgyVm1sWXBnby9ueUtyblczT1JyczhBUGJSNXJmbmFCUXFGNHNS?=
 =?utf-8?B?NFlEZkZPdmFkdTVERCtPUDlFZzVZVVhkN0lDL3o5cjZGVjNGWm9yOGUyYXJB?=
 =?utf-8?B?NGxndkRkVXdreGxzOG4zUUZZVjltWTlJT29qMnpZalI1ckhHL3FKZ25IWEF3?=
 =?utf-8?B?K1puL1AzU2xJK3RhalBHZnNkaU9KblI5MmtNY1NhUEVGby9odXhQclpqcm95?=
 =?utf-8?B?UzIyRXJNWHF6VnVJbzMyS0JteWFVS3YrL1JNWHQrSG9mR2tmUnVTY3BLdVVk?=
 =?utf-8?B?SWlUWGR4L2RMOTloa3dzYjVHSVJqeUdUcDNJQlJlaUE1K3hDU1lWclhLZVJk?=
 =?utf-8?B?Rnh4cmt4b3JyQW8zQUwrcE9sVEN6dk1DRGpwbE1ESSsvR21SYjlKSXdUU0tH?=
 =?utf-8?B?UDNEVDBmc0JVRXZtdW0reVdwYjdySEdMeVhYc1hyNWxhYUJYTmtldXRPZk1i?=
 =?utf-8?B?dk5PRkpnMTdJK05mMExkMGNxcnNKOWQwSmF6YzJVVlNUSzZJb3dlZGVma3c2?=
 =?utf-8?B?QWdUejRUdys5VENWbjB2dVFUbS9WelNXNFNMR1dVWWd6S1Z1OVJhTlFZaDhR?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5fa2ba-9737-43a3-df47-08dad88bf9d1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 19:48:13.1868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9YCj/jUarpF6gL3p6lUmM0EWeJx6LZ7sbi7xI52dpcUy8vInKqf++FqIsCIx/g22KlabaxcuOBuN2E2Tqcl1kTpSsP2yj1e3XgN7nqQGxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6620
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 12/7/2022 3:29 AM, Peter Newman wrote:
> When creating a new monitoring group, the RMID allocated for it may have
> been used by a group which was previously removed. In this case, the
> hardware counters will have non-zero values which should be deducted
> from what is reported in the new group's counts.
> 
> resctrl_arch_reset_rmid() initializes the prev_msr value for counters to
> 0, causing the initial count to be charged to the new group. Resurrect
> __rmid_read() and use it to initialize prev_msr correctly.

Thank you very much for catching this.

> 
> Fixes: 1d81d15db39c ("x86/resctrl: Move mbm_overflow_count() into resctrl_arch_rmid_read()")
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c | 39 ++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index efe0c30d3a12..404dd9c472c7 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -146,6 +146,24 @@ static inline struct rmid_entry *__rmid_entry(u32 rmid)
>  	return entry;
>  }
> 
> +static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
> +{
> +	u64 val;
> +
> +	/*
> +	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
> +	 * with a valid event code for supported resource type and the bits
> +	 * IA32_QM_EVTSEL.RMID (bits 41:32) are configured with valid RMID,
> +	 * IA32_QM_CTR.data (bits 61:0) reports the monitored data.
> +	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
> +	 * are error bits.
> +	 */
> +	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> +	rdmsrl(MSR_IA32_QM_CTR, val);
> +
> +	return val;
> +}
> +
>  static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
>  						 u32 rmid,
>  						 enum resctrl_event_id eventid)
> @@ -170,10 +188,17 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
>  {
>  	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>  	struct arch_mbm_state *am;
> +	uint64_t val;
> 
>  	am = get_arch_mbm_state(hw_dom, rmid, eventid);
> -	if (am)
> +	if (am) {
>  		memset(am, 0, sizeof(*am));
> +
> +		/* Record any initial, non-zero count value. */
> +		val = __rmid_read(rmid, eventid);
> +		if (!(val & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL)))
> +			am->prev_msr = val;
> +	}
>  }
> 
>  static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
> @@ -195,17 +220,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
>  		return -EINVAL;
> 
> -	/*
> -	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
> -	 * with a valid event code for supported resource type and the bits
> -	 * IA32_QM_EVTSEL.RMID (bits 41:32) are configured with valid RMID,
> -	 * IA32_QM_CTR.data (bits 61:0) reports the monitored data.
> -	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
> -	 * are error bits.
> -	 */
> -	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> -	rdmsrl(MSR_IA32_QM_CTR, msr_val);
> -
> +	msr_val = __rmid_read(rmid, eventid);
>  	if (msr_val & RMID_VAL_ERROR)
>  		return -EIO;
>  	if (msr_val & RMID_VAL_UNAVAIL)
> 
> base-commit: 76dcd734eca23168cb008912c0f69ff408905235
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog
> 

To get back to the original behavior before the refactoring it also seems
that __mon_event_count() needs to return right after calling 
resctrl_arch_reset_rmid(). The only caller with rr->first set is when
the mon directory is created and the returned values are not used,
it is just run to get prev_msr set. This also avoids unnecessarily reading
the counters twice.

So, how about:

static int __mon_event_count(u32 rmid, struct rmid_read *rr)
{

	...
	if (rr->first) {
		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
		return 0;
	}
	...

}

Also ... there appears to be a leftover related snippet in __mon_event_count()
that does not belong anymore and may still cause incorrect behavior:

static int __mon_event_count(u32 rmid, struct rmid_read *rr)
{
	...
	if (rr->first) {
		memset(m, 0, sizeof(struct mbm_state));
		return 0;
	}
	...
}


Reinette
