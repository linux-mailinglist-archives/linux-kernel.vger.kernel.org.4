Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9016452FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 05:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiLGE0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 23:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiLGE03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 23:26:29 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBF056568;
        Tue,  6 Dec 2022 20:26:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjAIr8f9HDKcKLpEFfTEROFGplfYIen0mDeE/EIvuKSPDhQsXJ15RhlF7tkI5jFUrv59pu/a+SBMhH1yw9HZuUfGAVcfZA/H134W3CfKTf3Pz/vigX93TX9vW0aCeTHE37yA3QfQhtaAscwj3kbtAyf4RMRxRxaa8Ge6vAaVxFnTx633/Q+wFtbtpX7vRcT6268K5Jl72xvJgEkLHAnQSVqvZL0EkODZc02FUvdPLA0v6V/svqroxjDJ7RfqtAQKMxRCd7sPmJcQyvFkLZ9s9QkNaaPePW3v4cXolJGByn5jjV9ft00HzBLQGrbaxLY8AhdWPd5ktaSGXjg/9pPTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOya5TAlyGEDmuEmlFTnzMnj4A370R/CzGThcb31XfQ=;
 b=UxA8uW9N3bjbOk1CglKg6CtYcsVCsR6Q7Ozrxhh8ynNoAYL8KMU99fsG9RCQsG50PhXFgfGCLK6e38n/u0SttKhUNunjcb6t3LeMF/vjsf7Mt+Zh9UfJ+GIuPv9Xh8XqHGkqmEJw8L/E2KVEwtxLy8oFvKCMgwm8h9JTUgrYa0XuvjgAzTJmXp5tJbT1PpqO+u5Xai3Wnop6MaNqnvCFpBT/0wmbbRrpHEc/AIHUBROchUX5uW2y/ZhzzaCet0zv1LHKt599Lu4QkcJvQREnnoTE6huZbRYSkfBxzGtR14COmZNkvg0cSxER5FswgYKGKVKvwe2eDd7wNlt3ZUPX3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOya5TAlyGEDmuEmlFTnzMnj4A370R/CzGThcb31XfQ=;
 b=pknTCIgmaAxxEGQQud0wWAjAQTlxIZC1ljnSg3UPTNb7ZZoxGY1S3EfIutgiHcqg9pC/ZnTmDHxm/YUFK8ggeU+DmfakwJWw419vYJkTfRXwDXzUl/eolzQlsIdIvLdjWcdnNYWzzG6cROsZFLtqySb/uWVFpcaYhcVQc5qLB5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 04:26:25 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981%8]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 04:26:25 +0000
Message-ID: <2e45a93d-56fd-b18e-de61-51ceccfee8a3@amd.com>
Date:   Wed, 7 Dec 2022 09:56:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 2/2] perf test: Add event group test
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        carsten.haitzler@arm.com, Leo Yan <leo.yan@linaro.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20221206043237.12159-1-ravi.bangoria@amd.com>
 <20221206043237.12159-3-ravi.bangoria@amd.com>
 <C7F7A9B0-421E-40AB-987C-6D250B9633D3@linux.vnet.ibm.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <C7F7A9B0-421E-40AB-987C-6D250B9633D3@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::17) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CY8PR12MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: ce64073c-abae-444f-ad56-08dad80b33c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZqR3r8zDisL3XTJFF8fqw5YLsr/uWbBeheAimTyNd9wlxb1yYsu03FrnQ/pYwEdR66c+h2ULx3Xir7mGW3uC0uXoTvaOLkM3RWd0vFHQK5fqYgumr0BvIVY0s1i1cuOydZvx99/sLvvpMTIPkuNHPGpFl5fwnBsESFu01YebgtpVtdECbq2kU47SUXHQ71Fz6W+k0sBUC58MrBnqQi+F2Y7yc0VulFGe1mG1AcFbuuC1QDxoDAt+TiK62nuB0xCC+W8XOxJO9zPuMmjq6VnT6flgrpv2vFetCcvzA0YOnV7mg0/8leGC413A3Ti553D3nwZv8DDJSOMnev/j8iYkhgT08cb7C9kVc2/jhVDWnQa0K/FVyLQiOwIMruSFq7ROypWxdqSf+GzuqKcpOaLqv3u/KU2rJC8w0HDxwnseApd7PFKVe8Q8jVZQtwPgBeBlIf99BeK/SAjJuMwkUZSsLx6Q4YtVJPnx52Kfs7gjYO/lrI5W8NfE2ndrtJ5goj2LddX0HGtD662iLJQOWJyS0/d+rcLsj/bH7LvObRyH0aRYe0SIJruHSmKHHByF42fV3gNzewqwZEB+/VwHtx65lIz7qJBUUHA1Nn68ZuFvs6VdV7ZAPuVcLKwkftBtGtyCQ/ZvOI8p/MjAQUHvPHZJpI1PdMzF04tNqVmKhzOJ3OqfvN19iQxFkM3bDXB0H2+nyQaCfZTKKD4X23DA8bjHUT5qS8VpZ3041klifHyYkVM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199015)(36756003)(31686004)(4326008)(86362001)(8936002)(66476007)(66556008)(2906002)(66946007)(44832011)(31696002)(478600001)(41300700001)(8676002)(38100700002)(83380400001)(6916009)(6486002)(54906003)(316002)(2616005)(7416002)(5660300002)(186003)(53546011)(6666004)(6506007)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um1Qd2RuOTVqQ3dwL1ZvaWJvbElsWmtWb1BJanFHb3dQMWlWV3F0a09VTzRN?=
 =?utf-8?B?cm14ZSsxK29WbTl6VWVYd3o3NGp5cXJUNkFUQmhaUzR6QXdUdHMwOTdMZDZ5?=
 =?utf-8?B?RDUwODNaTnhRdnNkaDdscmtqQVZNNzU0bXJpZFp4L09iYlJKaWVLWC9hVzc1?=
 =?utf-8?B?bFdrYjRlcTlSOWxnMjI0MXFydVI2UTZKTTBNQTUwWFV6bGM3RFlNODkyUWQ1?=
 =?utf-8?B?cldoMDVYVDljSkp6Nkl5QVJ5MkhnZ3pRa1FaeE0xNTlLdGZ6RHZnU3h5cDhm?=
 =?utf-8?B?YnJyUmQ0MU9SQmZXM25KaUEzNzFlN3I5c2F1aGp6SlJWd09yT3ArRGlxRG12?=
 =?utf-8?B?V1NwempxUkN6eXBYT0huWWVjK1IzaWFMK3drNmhCUEFLUGJRRGRZelhlRmM4?=
 =?utf-8?B?QlZDNnN0VVRQLzdmekxMekkzQzVqYU8zTVg0UDBRSjlZcWJXSS9wQ3ZnbENr?=
 =?utf-8?B?SlNxbFNHVDdHbXFoSTlzdGtvQldFOXBuM3UzNWdMZ1hMWkhmYUR5bGsrT21V?=
 =?utf-8?B?R0wrclU2a0ZjOHVKS212TGprLzBSUHVsSWpZcFJoTFhKTi9EcE9XMmZUVkdv?=
 =?utf-8?B?WXVaYjB2YkdJeFZmT0IrVnhITDQ2dzhHRlFSbkhPMks4V0VMNlVvZEMybkV1?=
 =?utf-8?B?am9EaDJPVVh0YlM0cXJTSjlrd2cyaGlNd0pZUGx0VXhmQnQ3WlV5ZGN3dnU3?=
 =?utf-8?B?dVkvUnJzdUtnaHI0K2hEdDQxYUE1dVliYjZDY2xFcE9nMmNaeG9GZnB1OVl5?=
 =?utf-8?B?c0FDemttOW1qYUJpMjdFV2hFQlNIUktPN3RwSytiQ0Q5WlE1ZTNxbHIvTGtU?=
 =?utf-8?B?R3d5UURpMGJjblNqMWRFRm16SmxvZnVPL1lGVDJTbkNEZXkrcVhHaUpCQnBo?=
 =?utf-8?B?NTYwbjlFekp6M1JXQXc3Q3lEZHVrRFpkamlydzZPRkV1d3FzUUQxdWhSYmI0?=
 =?utf-8?B?SUdDUEh6VkZORVRpNzdmYTRVaTM3enJ4VEdtZHBsbzMzUkJFWWNLQWdWekxZ?=
 =?utf-8?B?bUxyU0o2K1FNQ3E4UitqT2h5cmxrMHFrUGhyaVVsT3ZubVZGSzgxV1dsa3dZ?=
 =?utf-8?B?bmVyK2xmWU1GWU0rcVg1dFp6Y1d0QVBjYlRUMVR4MUYwQXFxejNrRHFCVUd6?=
 =?utf-8?B?QVJqNVNVTWw3VE82MGF1YzUxOGNjUlJvcVErQWJXakFnL2lxNzJjT1F0aEtU?=
 =?utf-8?B?bEJuYWlTU0duRWJSdTdNbkt2QlRYSWdDMHBkdTRPdjRZSGpYMVVuVVJ3MHkv?=
 =?utf-8?B?WlREYUdmOGdmcHdha3NZbkNBSXVUbzhuK1VtZW1pcGRwV2FuSjhXV3ZIbzUv?=
 =?utf-8?B?aW5KWTBZMGdMbllEVWx2a0kwcU96LzRmMTBWVGpmbHFKQkRlUVh6Vy9XSU1K?=
 =?utf-8?B?YldmQU8vUHllbWNWbDVjdEltSFF0YzZsUG1qK0lzRVhPdGpBRGZUQU1ERVdx?=
 =?utf-8?B?K1M5ZjFKSDVkK2ZEV1R0Q0lpNEl3R1BuTmxIdUMyOTRGbk11VjlyT0hBMk56?=
 =?utf-8?B?WkhDOWNxektnZ3g4UlFXMGs0K2VlNTIvQXRjR0JZbnBjU1FxN1dUbWNkbkRo?=
 =?utf-8?B?V2RYSnBxOE9uaFVzcjZsY3Z1eVRQKzBkSDcyQlBCWFdrL0lCQm1YbzNwek5j?=
 =?utf-8?B?L1RVNlNQcFhzV1cyL3BRemNTTW5lc21VbHlXdEF4VDFDNmRoTVVJT0UzWXgz?=
 =?utf-8?B?bHI3WjJLajdGK1dCaWRGVDd6OFozdktDaDlNNnFCS3laZ05rTzNVYTFHNGZ4?=
 =?utf-8?B?Yzl4Q012eGRQSng2Qmhkc0ZXa0VpTzdiOXowc1UzUmhBdlJyNkh0dDRpbUFD?=
 =?utf-8?B?QzV0OVNja0FGbXQwUnVpTXE0V0FBRUp4OGZDVDRNbG8yeW5GWmJDZEFiV0hS?=
 =?utf-8?B?c0FuS2RYMmdHQ0xMRkNCVTBPSkNlZ1ZvUFJGRFoyVGFNSkltU0RrbFA3ZWhW?=
 =?utf-8?B?U1hZZ1B2WVViU1d4MFNwNThJejN5YjlXS2tJMTErK2dZaEp4MFd1K1UvWnND?=
 =?utf-8?B?STluQWNYRk9FeHRsbXRrZ0JYV3pQeWhEZU1QSndQbTVacGd6T3NDR3hUaWxE?=
 =?utf-8?B?RFdvNUFYQS80N0drQ21ZdmhLcERueVE0c2Z6YWg5V21rU2ZDaldMRDVmLzRo?=
 =?utf-8?Q?vrdjMt/VavjXEuKXGpzcYyp6a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce64073c-abae-444f-ad56-08dad80b33c0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 04:26:25.4289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKTIaIKgTgUa0u+Nbtgf+Wr/7Wr+d1drSOlrv/NqrcCtq/ySDB1vC/+W4xdLE+6wCoNsTrLPRkF8R5iFUMxOZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Athira,

>> +static int setup_uncore_event(void)
>> +{
>> +	struct perf_pmu *pmu;
>> +	int i;
>> +
>> +	if (list_empty(&pmus))
>> +		perf_pmu__scan(NULL);
>> +
>> +	perf_pmus__for_each_pmu(pmu) {
>> +		for (i = 0; i < NR_UNCORE_PMUS; i++) {
>> +			if (!strcmp(uncore_pmus[i].name, pmu->name)) {
>> +				pr_debug("Using %s for uncore pmu event\n", pmu->name);
>> +				types[2] = pmu->type;
>> +				configs[2] = uncore_pmus[i].config;
> 
> Hi Ravi,
> 
> Observed failure while running the test on powerpc. It is because the uncore PMU ie hv_24x7 needs
> performance monitoring to be enabled in powerpc. So to handle such cases, can we add an “event_open" check before
> proceeding with the test. Below is the change on top of “tmp.perf/core” .
> 
> 
> From 8b33fb900c26beafc28f75b6f64631f8fdd045c2 Mon Sep 17 00:00:00 2001
> From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Date: Tue, 6 Dec 2022 20:17:25 +0530
> Subject: [PATCH] perf test: Update event group check for support of uncore
>  event
> 
> Event group test checks group creation for combinations of
> hw, sw and uncore PMU events. Some of the uncore pmu event
> requires performance enablement explicitly.

You need to open an event to activate hv_24x7 pmu?

> Example, hv_24x7
> event in powerpc. Hence add a check to see if event_open
> succeeds before proceeding.
> 
> Fixes: 5c88101b797d ("perf test: Add event group test for events in multiple PMUs")
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/event_groups.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/event_groups.c b/tools/perf/tests/event_groups.c
> index 612c0444aaa8..ad52e1da259a 100644
> --- a/tools/perf/tests/event_groups.c
> +++ b/tools/perf/tests/event_groups.c
> @@ -51,7 +51,7 @@ static int event_open(int type, unsigned long config, int group_fd)
>  static int setup_uncore_event(void)
>  {
>  	struct perf_pmu *pmu;
> -	int i;
> +	int i, fd;
>  
>  	if (list_empty(&pmus))
>  		perf_pmu__scan(NULL);
> @@ -62,6 +62,10 @@ static int setup_uncore_event(void)
>  				pr_debug("Using %s for uncore pmu event\n", pmu->name);
>  				types[2] = pmu->type;
>  				configs[2] = uncore_pmus[i].config;

Sure. Just add a comment here to explain why are we opening a
standalone event here.

> +				fd = event_open(types[2], configs[2], -1);
> +				if (fd < 0)
> +					return -1;
> +				close(fd);
>  				return 0;
>  			}
>  		}

Thanks,
Ravi
