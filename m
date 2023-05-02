Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9DF6F41F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjEBKsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBKs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:48:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2906C172B;
        Tue,  2 May 2023 03:48:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdZvCZQfSfF5EI73E1vrG8Ij9bThsbNfUW12oL3hMycxXmbbHTu84mtgCoyieL/pYiplS8WXsS6S1X7Q64gFuksjC8wNybgB7s99ze+gWv9NJBKeZKuUrTLU6WhjRH6Yn6+wbcX4sT/7arD2G0WHbbTTVOquWRTmtvK8EmqgxhKsPzMoivUMKvyYFq5zTgx8xAL6unYJ5DrFk3/YEtGL31Igtl2Kh495dbimI8kHRL9JKNTLxwIV19Cu5bmRRcZ40Tf9zcFCHthIUT9LxI+U3YRQv8XYcOa5mxSkC0mQPSLLr4u0zPFO+MSEi/h/Wu5WDVhRN+9PXnU1Ph6n1mTfHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syLMu3YQQdA1gSqRKGLuffBCBiK/9nD4S7f1TiINeYM=;
 b=a7IifP3dpDixgwfagAs+/x82XXosVgADFx+OBG1H4zaPo4g3ubjqNfaUqYLz+5GAuHFU1Vbh4QsKg/gSwsxueY3pPPazXggOt7kNA/99qPhku7IuOklBpOkV9abPmvUGiEY84fcfkHjbtwzLT0KL8+XK3KdEkk5EQHWoujvM7ETWtc8Hy7pkop4sJRwEtm47SSH9EQwu5yijBoYd3m4zirTQLVA7LiWFd9oRcihiEFi5Xx7NRwkc5GBazRCeL+hKuszkRgkNXR5IM/0mBNaFV4M04t+atg8oKovXQ29cUNsXKXZQZSKT00/w/s+UXWpRBu2lXxEuDKNx8o7W2+HJyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syLMu3YQQdA1gSqRKGLuffBCBiK/9nD4S7f1TiINeYM=;
 b=pA8W78eBPtG2yXDs0X0zuUfPUYCdApo/vq1FBmGn7HiplWpdX/z4qGOSpVRWCxMR3OEuppQMLIvesM7holetISZvk+3Wa2l9odNHkDwPl17beKuA5Z+yG/aGmwvQjGSrJdJn7DirCeaZYyWO/0yMxq1FEK7OXUQpIOAZssL9ixQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 10:48:24 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%7]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 10:48:24 +0000
Message-ID: <56dd818d-3f2a-59ba-3c56-af45f488ad8d@amd.com>
Date:   Tue, 2 May 2023 16:18:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 27/46] perf print-events: Print legacy cache events for
 each PMU
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
 <20230429053506.1962559-28-irogers@google.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230429053506.1962559-28-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0203.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::15) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 1074937d-9bf9-4d2d-1c5f-08db4afac094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eoxp3PHQJboJeDDINc3AFduwuh99OZap2iN7ebjfOpy+Qv2SfYCpmZzagsuCwoX4PIKatUESAIU4sISHGK3U6NJZZVyCN3xAQ1Rufqw0PO0OrSBTXXXjwf/GFNMhU+IS6l57kmzrOIx72jPTBL77VBamsL8sIOzbUF0Wl6f0NPaMlnVlqkEar8ucrT8Wpdi9rHAFavq5fbjCOoQRUzoXhnRYzqWy9R4hFrbDRYX+9sucBl7GrtZrAurGZ3yAjdk8kn5QZUm9axT9ZE/hjSag1NoLz3xm/i8aaW8lzSAdalEvMTefwtLbrXzY/B+WEAlgXIwUL7Vm/E4cXU/yykwsIuGOswNoI6dnOmUuzeiizS9sJux+ZX2FACxKhvN/Djw47b1b9tGfvZFIFMI5nFOUY0MVjlTB55J1iKiJHB71bwVKe4hj6+dsHE7PdSDQb9/+W/tCPaxFwVdkWeOrZFOSNlINsIQB8LTjTWqJf0ALz3N+p8sDnnlqHjaAJqECqu3U1oY35XFBZEQo0v/0l0FPy2SGFYJ9erBUtFyDEZ9+48QXQRedJX5fjtT+cAno+4oc3xjqdi1H69ixik88aweLcOO+gGDMBdzWCyt9o6uO620qxdWsaQsd81w0hyYxkLUrVS9/Kk0FvRt7E+He9qfrqASoTmTM0Z5H7EL5E3q4X0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(186003)(66556008)(66476007)(66946007)(921005)(316002)(478600001)(6486002)(110136005)(31696002)(86362001)(36756003)(6666004)(6512007)(26005)(6506007)(2906002)(2616005)(38100700002)(53546011)(7406005)(7416002)(31686004)(5660300002)(8676002)(44832011)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFUvdmdGemRvZUdCcDFXLzhIdHpZaGRQZzQ2NGdldU4xb212aVRXdFB2RFBk?=
 =?utf-8?B?MjQ0UXh0MThlaTlSRDBMODRheStQbElyeExGNnErY0NFK21WNWM3Rkh2bVJO?=
 =?utf-8?B?RVc4Vjlza1p2VHozVHh4QkVHc0Y1bzVPNWpjMlFJYnJzclRHU21LK0JPdHN3?=
 =?utf-8?B?SG5DVVRNRUJqWG9KU1ZNczZad3FvQllDemNXU3Vlc1h2TmViNFJ1NHhNY093?=
 =?utf-8?B?ditKbDFIMUNBMVJTaTBSMUoyS1lDcmxQclpKY3F4SGhyMFgzZWJ2bHpqaG5V?=
 =?utf-8?B?Z3Ywa3BNSWpGSlBmNGRoalJ0VFRYK1FDSmlPRmNuMU5ieE5MZDBxcjhXY0s1?=
 =?utf-8?B?V1RSUWdHTFdGcE1IOTViOTBLNnk2NSs1NnJrZmtYa3lWZWdLM0ZaT29vYzdp?=
 =?utf-8?B?N0RpeTFLZkxSVFVBM1ZrVmtuZVY2dGNOM1RrY0VBQkNHbVN4VDhBcU5hMzlZ?=
 =?utf-8?B?V01rYmJtSjhaV1FxdkpsSGY5VHg5SjViS090bTdtb1JUOWxETnF6UDBLbTBt?=
 =?utf-8?B?S3ZXTkkzelRPeDJkYzUxVVlvODFlOG41QlkyL0p4enVzc1pFNkZyRzdMdGNm?=
 =?utf-8?B?Z2M4SFl1ejkxc2hDQjJhUXpuejRpaytrUEQrc01xQS9QMDhGUzJ2OXRqWUJC?=
 =?utf-8?B?SkgzZjJ6Y3VrcHlzNWxPN0VBNk41dHVQSkN6OWRnMHNVYjk0aUFyMHVLMDZX?=
 =?utf-8?B?R1VLclNxR29QTVFWZHE1Rlk4WE5KcU1QblRuSGgvaUNrdUtTVkc5aEFjbWxS?=
 =?utf-8?B?eUNwbWlDTmNxQlk2NndFcFcrK1BlT1Jid1JZa2Jka3R1d0t0Rk8ydk1vTHhT?=
 =?utf-8?B?b0Y0MWdHYi8xYmp5RnJhR1BRNnpIcFZ1N0lWZERIRDNUdXVnMEVzWFNESklQ?=
 =?utf-8?B?blFLeVpTK1FpcU1Cb0JhNzF5aTI5VkJUYmdNQThCRDhpVWlyV2Q3WUdENVNo?=
 =?utf-8?B?SjFBZVhUVjdTb3QvYW1UL2gzYys0TXRyb3VrRDVQb3U2MjJrdzR5WHlramdV?=
 =?utf-8?B?UTFxaDBvazhJd3BWbnBXaXpNYUZXNk1oR0pBb3ZUc1JxS0llQXhrbjdCcnYx?=
 =?utf-8?B?K2t5aWdYN20wRWh0N1JiWlNtdTRCQkEzN2FFUitoR1A4dU1VT05sZ1NhS2lw?=
 =?utf-8?B?cWNDUjZMWU1PeVcrM1JIRW1KZHVzaldtVlYweitQUEhVQVJ0U0lETVVTemFy?=
 =?utf-8?B?d05lU01LNGhsYjlKalJtREZXdU1ucDV3ejRWLzhaM3laeXlzNElvUU5Fbnpp?=
 =?utf-8?B?SGtoTXQ4QzNRUGt6ajF1aGYzZDlBMStWOFp3cW1lQmxObEZvNzJkUkUxaUJv?=
 =?utf-8?B?Y1NJTld0cXR3TzZFditWT3djS0NhQ3RDUmU3WGt0YnF0TDBNZ2RId0xobkh4?=
 =?utf-8?B?dkZFSVFTN0Fubm05anZnTElaWDFScnRHRmVUY2VkcWYwZzFMMFpLSXBnRDY0?=
 =?utf-8?B?T2txUGNSMkZ4VHFac3FYZnFiMndlS0c5MldCd3B3azNGUmZCdWtkektEVDhW?=
 =?utf-8?B?L2xOVE9yTDc3RFcwek95VzFHQkdHK2dXNmhQcldGSlppTzJHbjM3aDNKdXdm?=
 =?utf-8?B?a01ySmo5VTN3RG9vcTZ3Q2FDUVlFaWlreFo0WHZvNlJjVlZyNzYyeWFVZ0x6?=
 =?utf-8?B?RVplVFl0NmVQcVlld0pVczhKOG8xZ3F5cGZHdmp1VlpJMWxmT3ZkN3l3cm5Q?=
 =?utf-8?B?Z0I1Z0UzY2ZRanhiZk82WEY1NUZIREdBZDZzTFlJdmVnaGVNeVhHajVjMEJO?=
 =?utf-8?B?RUd5ckVXVmJDaFd3YlQ1UTY2NE9IaCtEcDFCRWJDZ2MxSnhYT0wybUNXb0E5?=
 =?utf-8?B?eGxrQnpId0NuTUFFbjlDN2JMUVhLeXA4SUhTSnJtc2lYcVIrNEliQ1pJNENq?=
 =?utf-8?B?cW0rMUttZExabzg4YS9wWXRqTFBOaDFWVXpmYUhBaXk5b2hleXhqTlZCelF0?=
 =?utf-8?B?QjViQnBtVVNIK1NzR29uVmtKVHlQRzFqbVZCWTVEOE9aays2TlRVWlIrdms3?=
 =?utf-8?B?eTlaeTh2YUswa2szSEk5YWxybGsxb2JHSkU0SytnVkREa2hZTTdTYnc5eEV6?=
 =?utf-8?B?d3pabnRBUk9EN05zUkNocHU0T05BUnByVlBTRExUM2tFRGlwYmc2ME5YWUJB?=
 =?utf-8?Q?RiuwKKZC51SLEwlAKNf3Ub82A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1074937d-9bf9-4d2d-1c5f-08db4afac094
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 10:48:23.9847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnuWWSCVmCXl4nKCUA1GeLG/X29+x+nZwfMFu8KcXGTF/1Mig8CY5oRQpOb+63HCub0CXfy4Ni5HChpKo2nx0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-Apr-23 11:04 AM, Ian Rogers wrote:
> Mirroring parse_events_add_cache, list the legacy name alongside its
> alias with the PMU. Remove the now unnecessary hybrid logic.

Before patch:

```
$ sudo ./perf list
  ...
  duration_time                                      [Tool event]
  user_time                                          [Tool event]
  system_time                                        [Tool event]
  L1-dcache-loads                                    [Hardware cache event]
  L1-dcache-load-misses                              [Hardware cache event]
  L1-dcache-prefetches                               [Hardware cache event]
  L1-icache-loads                                    [Hardware cache event]
  L1-icache-load-misses                              [Hardware cache event]
  dTLB-loads                                         [Hardware cache event]
  dTLB-load-misses                                   [Hardware cache event]
  iTLB-loads                                         [Hardware cache event]
  iTLB-load-misses                                   [Hardware cache event]
  branch-loads                                       [Hardware cache event]
  branch-load-misses                                 [Hardware cache event]
  branch-brs OR cpu/branch-brs/                      [Kernel PMU event]
  branch-instructions OR cpu/branch-instructions/    [Kernel PMU event]
  branch-misses OR cpu/branch-misses/                [Kernel PMU event]
  ...
```

After patch:

```
$ sudo ./perf list
  ...
  duration_time                                      [Tool event]
  user_time                                          [Tool event]
  system_time                                        [Tool event]

cpu:
  L1-dcache-loads OR cpu/L1-dcache-loads/
  L1-dcache-load-misses OR cpu/L1-dcache-load-misses/
  L1-dcache-prefetches OR cpu/L1-dcache-prefetches/
  L1-icache-loads OR cpu/L1-icache-loads/
  L1-icache-load-misses OR cpu/L1-icache-load-misses/
  dTLB-loads OR cpu/dTLB-loads/
  dTLB-load-misses OR cpu/dTLB-load-misses/
  iTLB-loads OR cpu/iTLB-loads/
  iTLB-load-misses OR cpu/iTLB-load-misses/
  branch-loads OR cpu/branch-loads/
  branch-load-misses OR cpu/branch-load-misses/
  branch-brs OR cpu/branch-brs/                      [Kernel PMU event]
  branch-instructions OR cpu/branch-instructions/    [Kernel PMU event]
  branch-misses OR cpu/branch-misses/                [Kernel PMU event]
  ...
```

Is this intentional change?


> -	for (int type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
> -		for (int op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
> -			/* skip invalid cache type */
> -			if (!evsel__is_cache_op_valid(type, op))
> -				continue;
> +	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> +		/*
> +		 * Skip uncore PMUs for performance. Software PMUs can open
> +		 * PERF_TYPE_HW_CACHE, so skip.

This statement is bit confusing. Can you please explain how SW pmus can
open cache events.
