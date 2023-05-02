Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3206F419D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjEBK33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbjEBK20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:28:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FE15270;
        Tue,  2 May 2023 03:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbkU6Z6Dh5YXlIp11h3PVPvjNY5wyzOSlX5ku9pGbsZGlFMAxWnY+f4GnuE4ZZ9mO+cp/DnMbIBkzIf+tQHcDQ8t4epjYq+Txa/t+8FikVhYKV9AC/ebwjl/ZHrExCqE6MYyQKcieWDKSqnzX5Qc1wWnfBW+6Ildqwjw+/Hi2z5C6y628jyFTvPJdKu+IeQJgexYZf0qiEO78jRgM8sHeRkKwVhW7LgcNFknYr7i6tsDYYDJM5N98YKfCmx7MVbKv1l9CcqSf24n/caNvYro04xbr9Z+VoZZCwLIC5WmAwZW09gXBaN5RPk9yTl07aWr4XT5gkGpDkH7pTWTKvoCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZEscH39tAGkfTrs7ZKxN9bU6qGxu1Erny9xCMSgoNU=;
 b=iI8ZJvEZyiFbKfZ8B0QOJqu2qM74hSzxW7dkV8rBlTK9Nst3dkVQ32ljOCcVMuR9t+/Sfdgo/6NWR/lcMpIh2IaGsLc2P6c+jtJI3HAwjssbB0JCewAp1oEL0fZefjeY5M7iDUuSwSfpeUKIRpL2r10HbZdzmTElMkkaHuBm87nMbNzIbYMt62F4m2VJuUC/vGmLRDXfPbH3/KwbZBrrrz8QZGJnDlwxUeOxGm3XY35jksAB1zEZDa73O2ltqli6QrcF7GyJ1RUM5LmCgXFvCKiT9Up+LhtPXqtIDrdSEb07k5zgF6CHt8cY5hxCl5ugrYgy7FoH/KpcHywmNCdXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZEscH39tAGkfTrs7ZKxN9bU6qGxu1Erny9xCMSgoNU=;
 b=fyJXoaCim82VzD71cQaaNCq8YwvozmHFpQsY/Q1omR4sG0Eq5KgjhYiL86fsxtl047hbYh8lEItwOD/G0JSB+W5xcqbeyYhJ6iqZ7u6FtXRwSyNVR+A9u9XaS7JL/NayCafHlYqQHDtNa0JHlbmxhGPqp3qmpxxg1K0nnvYoz5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW4PR12MB7311.namprd12.prod.outlook.com (2603:10b6:303:227::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 10:27:23 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%7]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 10:27:23 +0000
Message-ID: <31dbae6c-4cbe-d7e2-bc78-beed959cbddc@amd.com>
Date:   Tue, 2 May 2023 15:57:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 12/46] perf test: Test more sysfs events
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230429053506.1962559-1-irogers@google.com>
 <20230429053506.1962559-13-irogers@google.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230429053506.1962559-13-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::15) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW4PR12MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f99ce2-ee13-4e98-67b4-08db4af7d12e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zD5HoKDUpvQbjE6K2TPq//bmPB1vRAKF7iCGVD9TJNsBREmeo8rtn098f9vhuDPl9JR5Ru8cAJh3mkqHhmfX66zpzKDd+crwtNTrjTSG1YYTATbcG3fDC7xy/QBLJNKLygomymxXdEiOw1wIBozFZZuWrYy0X0lV4hUP604xiVRTzA50mKwJf+DCKYmix4vBYS0vcRhwITUSJO7+iZG+TSPfD+8Vjd/avo8pcCr8YQVCvKVFriqvbLmVuTUiKmjmihkv8uIfMKJd8c6FXiQG03QLzTIzg8Ko83Vrnq3SMdnIbWBdf/NZcxplBweEdEIR1iycMkxcb4Bq0KJPe8XR2Pj0eXUkDYthkVEPEYkweMY8YkV1Dg2sWJOouLYmPse2opk6kd1R+6rZ1wLipT6AMeGfOCuGiSN3blhCB/Tup7pJeqRadEBs0gc59XjCAP947D0ydAlajpVMnTeN1fYEBF30aYdEbFKGgUlEfz25j5JpE1/syOG19MewUpboKXqpp8SzYAkvpKywA1bCSnnlKtIPDhUgrB/ys1k00Nilt/Vkb+16/dywQ4WwQvr1ZveKruljtVnUwZb8dyZTgfPrn6/jSZsOZbTBiZ9Of/ZH1nAUL629358Rgxqtak1UK2GUXZ84xnMcxQyLLDx3Xf5wxNhIklBrM6YK+oIKJBmA7a4m/UT2viiYEhCV/wIQf3NFSnWLTR3UyhZKkQcnzbU59w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(6506007)(6512007)(921005)(26005)(186003)(38100700002)(8676002)(8936002)(7406005)(7416002)(5660300002)(41300700001)(36756003)(44832011)(2906002)(478600001)(110136005)(31696002)(6486002)(6666004)(316002)(2616005)(66476007)(66556008)(66946007)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzNQV0x6L3E2My9yS21sQzUwUGFYbUJhRGpTUGZGdjVsVG5PUmhxZWZqMVhJ?=
 =?utf-8?B?RHNXVGRzQURQR2xxdFQxVFl1cEVHWXlyWWJyQWJTNURzbXNRbjFaYWN5bUxw?=
 =?utf-8?B?MnRERWNmZ3JHUXdqdVduYlFxS0diWTFsTmhKeSt3SlpsMGFMdk5pN2xIK0hr?=
 =?utf-8?B?eU0wckQwYUM5Y0VEeVFqMWM0YjNTeWlTOHFEOHJ2OFBhUURGZUJsanBPZkNV?=
 =?utf-8?B?YlVpZC9hRnRzRWoxYzVEdm9zcno4VHhVRmtBMGJxWkVQbmZzTUM4dU9RY09y?=
 =?utf-8?B?Qk9OWVhmQmVERVZrUFlUcUN0dmhBTThSVUg3cXRhSi82OEt2OUtWYXlmL3ha?=
 =?utf-8?B?MnZDY3Z6N3Q0cE9CbzNiTGpzZ1FTZCsyVjZTVFROc1VlY05pNzhmTERBWS9P?=
 =?utf-8?B?T21tL0VqcVprL3BWUzlZblpMbXU2aktxRFpKREJZc2gvUXdVbVBsM3BZb3Av?=
 =?utf-8?B?Z1BwR3pGejdTWXBMNEQ5WlFTdDhRYlBkZVhBRi91T2pVZUZ4RmtXZE51UDB1?=
 =?utf-8?B?ems5RnNncGkyOEMyNjIzZHBDWVU0QTV3UXdaOWIwNzdGMzFZUHVMUU10UnEz?=
 =?utf-8?B?UDRqNzl6YUdjSEZZOXc0a0toWXF6NFk0bm9pMjg5ZW0yUktPSnBFdlhHZkMx?=
 =?utf-8?B?OGdLbzU1T3J0d3RZMUhTK1RoTTkvYVBNMXlmams0QjNieU9nejBQUXU2NDlO?=
 =?utf-8?B?YTZjTFJzd1QwczQ4aENHSXVZVUg2blBRV2V2T2FXOHMyRlhpVXFtaGw2OGVy?=
 =?utf-8?B?V2tSdGZuSDNKUUp4M3Z6NGlsY0xObGlhYmY3RnNibkVncWRZMlZuclVDbHpW?=
 =?utf-8?B?L3JGWk1pcEJxNWpPc0JnNlI1TkkwTkNOV3k5dzNWaCtTSFFrQ210bURTYXlH?=
 =?utf-8?B?dTd0NXlhaWFIOGRjb3gxQUxteGp4dFRJZGVPK1c0UGtFNFdDTytxVkM0Sms0?=
 =?utf-8?B?UkxJMWFCTnBIcmVERlFjdGpNUzFaZWRvaEFXSjBVQlF6NHlSejRkZGZQbDNh?=
 =?utf-8?B?MHpDckNFME1tSWQzUlZYbHhWNTc0eEZNWVFFTm9hRkVka1BuLzcrSE1yeXk0?=
 =?utf-8?B?RVlRUllBZVhUcmpxaldsMDRuZUtXcm1hbENUOG1rRC9mTStmeVJ3dHZNRFNi?=
 =?utf-8?B?NTc4WDlBblVNeTV1VWYwZkNCUUFadVB5OEo3bERaYmxubHNEQWdyQkdYRzVS?=
 =?utf-8?B?Z0k0S25nK3ZwS2RRdkdBenVTaGZnOVRjdEVET3NQUGZFaDcweVQ3ZDUxUFlZ?=
 =?utf-8?B?N0J5RGRlN3ZkL0JPcHlWRUdSbW5Pc3BkZmFmOG15dHZXNnkyb1gyblgxK1dR?=
 =?utf-8?B?bmN0SkpYSmRtdHRPVWt3ZktiVXM1SnpZemlSSzdwZmZQT3VJZzllVG1BMlR5?=
 =?utf-8?B?cG45Zlk3Z1A2UDhkMkF2b293VGo5Nm9XNjhFTlRrOW5DQnFBR1lVZ2pKSFh1?=
 =?utf-8?B?a1Y0M3dsdVQvNmZhZmRBWVJMVmpLaHBUTllXdlJ6eHhDamovMTZqU2wvYUdO?=
 =?utf-8?B?SksxbE5OVkdEZ2poOVlFejI3bks3L2N3NUErS0ZHcS83a2c2NFJIcmZOQi80?=
 =?utf-8?B?ZjY5SS9mZnYyaldzNUNvdURGOHVIclVnQXp1ajU0RkpKTjJzc1M0d1hnc2JC?=
 =?utf-8?B?R1hqUSs4Y3pxOW51M3loTFJnZ2J0eVA3c0hkMC8xK0pwNGxkdkZSSnd1eXQ0?=
 =?utf-8?B?ZlI3QlpmQlo4ZmRETjJPalhlWkRHSWxWbVQvQ3VleXhvTmJNMk5pdkZta1Vt?=
 =?utf-8?B?UzkxeEpCWXpyVCtvZk0vckV0MU1WMGJyMU5sQW5QeFNSVEthZmdjUi92N2dS?=
 =?utf-8?B?eVBKTFg0NVptcFR6dy9zamNhRmVBR1BoclVzSjFJYUdyVFlSaDJPOUNtN3pC?=
 =?utf-8?B?eUdDUjNzYW5tN3NEeVNyeGQ1Q0phRnRUK0ZOS1pwSWVGTjVtNktBVHpGc1gw?=
 =?utf-8?B?SVlOLzh1dnc5OFlFMmRtdnk0OTRNbVR1TEhzRzdyajlYMS9oMmRQdzZsNTdm?=
 =?utf-8?B?RXRtQ0htOXRMWTJRYzdLS3N6WVFaOTJHNExIU09sQXZTSVMxY2ZFZ2QvK0FE?=
 =?utf-8?B?RWs1ZnBIVGQ0MnF0VUplSDFvTjVQN3Ruc0lFVkIwaHZ6UWZRYytGVm5LMVVa?=
 =?utf-8?Q?CgIAXfEHQBBP/knJl6Ibu176p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f99ce2-ee13-4e98-67b4-08db4af7d12e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 10:27:23.3789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wd7roxGQky5/tRntqCThuiQyEP7Prxb6OE/+btkeF08bt2q/OWY0a2w4CsrGHTdXUiaaKNHzip609WJECcZsrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7311
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -2225,74 +2226,82 @@ static int test_pmu(void)
>  
>  static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>  {
> -	struct stat st;
> -	char path[PATH_MAX];
> -	struct dirent *ent;
> -	DIR *dir;
> -	int ret;
> +	struct perf_pmu *pmu;
> +	int ret = TEST_OK;
>  
> -	if (!test_pmu())
> -		return TEST_SKIP;
> +	perf_pmus__for_each_pmu(pmu) {

'pmus' list might be empty and, if so, we need to fill it first with:

        if (list_empty(&pmus))
                perf_pmu__scan(NULL);

before iterating over it. Other option is to add this code to
perf_pmus__for_each_pmu() macro itself.

With that, the test fails for me:

$ sudo ./perf test 6
  6: Parse event definition strings                                  :
  6.1: Test event parsing                                            : Ok
  6.2: Test parsing of "hybrid" CPU events                           : Skip (not hybrid)
  6.3: Parsing of all PMU events from sysfs                          : FAILED!

> +		struct stat st;
> +		char path[PATH_MAX];
> +		struct dirent *ent;
> +		DIR *dir;
> +		int err;
>  
> -	snprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu/events/",
> -		 sysfs__mountpoint());
> +		snprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/events/",
> +			sysfs__mountpoint(), pmu->name);
>  
> -	ret = stat(path, &st);
> -	if (ret) {
> -		pr_debug("omitting PMU cpu events tests: %s\n", path);
> -		return TEST_OK;
> -	}
> +		err = stat(path, &st);
> +		if (err) {
> +			pr_debug("skipping PMU %s events tests: %s\n", pmu->name, path);
> +			ret = combine_test_results(ret, TEST_SKIP);

combine_test_results(ret, TEST_OK); probably? Since many pmus don't expose
events via sysfs.
