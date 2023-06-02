Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACC271F9A7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 07:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjFBFat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 01:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjFBFaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 01:30:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8A1197;
        Thu,  1 Jun 2023 22:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJkY4iYx+S+ou7mZFfayIoBW5old8TM2TLFQwH9KAN2lb7rqMOFe5E7IjWOeQHhz3qv6E+j1y3G9jcAkOoH0fP8i0Z3nc0cLuu+cJxAqy5VAaWyHGntqdPQWpvksUCvrrJYsG/7dlYIyx+L3oHJhSLglO2LcxBwIbS6NCKmvzv20Idi1EU6s4RWYaH4zOtspttLKd79Fi3lGTrgED7qMzASX+XUFGDm9oLmNNrQBdo75yDtHFIKCGk0m022bsGSjtz5EaWTSP0tw30yC/SzEWvQDrwpqTqwLp5NKDwWg8igywrm2VYltrTCYDRIjw6ejHBk+QEyk/sUBfie7zbbDwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AO02Te0byOtwNzL9COuG3dUT7OfVBL5a7L/slCpYP/E=;
 b=AGngxEyCwmmSUgdFrLtMAlkLVGrJdgEN0e+iG2kbw7RDiDpiO9t0e4wlv0EKUOwtw3oM5gSveRH5beh7wBaeiQ+sVwrrpfGHhndARno8kBAplWbG1bc+S4ZALYxhH8+3QrRGhVYNa/Cn+G6Ytga6BRskJ3/qbDL2ceaaRN6RIGapYIq0SV1V6R0Qae2U5AQLo2maj6C7pSHMFtIayrwAWFwPDgs+bWiadndicylCsNe/Dy6b/rWiLsGTUxMlvBrrnjKXwDflTi36iTmdduJPX2LgEoPz0aSQlQITstvaTdqV5cNBUbIJRA86z+XkdEH0EMJNwzfALjeEJ8dmpBkRkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AO02Te0byOtwNzL9COuG3dUT7OfVBL5a7L/slCpYP/E=;
 b=WH4TLiCBoQfvmAJz+5gLmPF8Vlzr3cYn5A6QPiEhq9WJu+j0abAKD9Eg2GWSWTtbxJtBsKPqbolDnhIQtQHi2OzQ+y/iVLvy3KXklVZfnvSM5JCPJBm0IikJSnmU9A2GrdBLrGt2k51c6fNjUCKhvTB20Mjd9Dk/eHE19Hws2s4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) by
 CY8PR12MB8409.namprd12.prod.outlook.com (2603:10b6:930:7f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23; Fri, 2 Jun 2023 05:30:41 +0000
Received: from DS0PR12MB6584.namprd12.prod.outlook.com
 ([fe80::9c51:cf05:a2d3:4061]) by DS0PR12MB6584.namprd12.prod.outlook.com
 ([fe80::9c51:cf05:a2d3:4061%6]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 05:30:41 +0000
Message-ID: <f0d9ff32-c4e6-674e-0719-833334f39e5d@amd.com>
Date:   Fri, 2 Jun 2023 10:59:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: [PATCH] perf test amd: Fix build failure with amd-ibs-via-core-pmu.c
 -- Was: Re: [PATCH v5 27/34] perf pmu: Separate pmu and pmus
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230527072210.2900565-1-irogers@google.com>
 <20230527072210.2900565-28-irogers@google.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230527072210.2900565-28-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::17) To DS0PR12MB6584.namprd12.prod.outlook.com
 (2603:10b6:8:d0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6584:EE_|CY8PR12MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: 13215103-9478-4609-0f02-08db632a80e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qYd9qkbMXC9Eg7ulO98rd/WFUi93SK6fn0ypUho7TdQLV8aC4waQ1KeCmZ1fKkzIVj9QmmYyPN5tWfoH72bWkhzF81sEvAE1UQBFUXMPC2jiFbFvFpQqa+YUm5geWD94SuTpd67lboDd/kiief1zDjKXo/YJmxeBk0yCZWLG/S4ssEmMzCcp2Js8vknlj40VtEWBzsacqFBKEJs2eyK8MUvX/DLcLj0I/MlxgTZsXeSfXgHQAahcN3qbYb5IoVTCvqi4H0rj0jslRpTCJa0X2OuEVWgTU2X7LNjaGBcf+WHWLu/hhCMbr5y4wpkzkNJ1jweCqBoR66I7Bo9u7Jni8BFPKgQsPfw37CMDoHeuuO19ZELAst9Q/7tgjqrXcmq+l5ej8Hmmx9piRaTB/orj71JYeRUjkpfx+vZX+Hjx1JfF+5lJGGUR1vK2dJaWN/P1lh4s2j+mAIXdxrRZ0U+SerN/bsQ0tTCy2hnb2polKbfeGYShSeIRZRwnz9UFlw75KLgbt4mz28mLKtz1iT0PRP8/kHODZWJqODKm5O4gosrQ1WGF9wYnY2u2Ab5fZ5kDujORBOnYkpbIzxds85Cc6JeGmbD1PvgjsZZd0l2WpA03uLc5E8oOY/gTjtvpIaOn/w0PH/5BZ6LC7PlNTrJ6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6584.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199021)(478600001)(6512007)(2616005)(6506007)(26005)(53546011)(36756003)(186003)(83380400001)(6486002)(41300700001)(6666004)(966005)(38100700002)(4326008)(66556008)(66476007)(66946007)(316002)(44832011)(7416002)(7406005)(86362001)(31696002)(2906002)(5660300002)(8936002)(8676002)(31686004)(54906003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THNncklOejJNZVlxNHJRREM5QUFwUGdqbnhhTTBEWG9VNWhwSWpoZUgwV2lr?=
 =?utf-8?B?c0pyK21LUXZoOUMwZVVFUkVwdjYvVkY2d1VEaC8xSys5UWNnN2oyQUJ2WTE3?=
 =?utf-8?B?ZWgxWTBUc0s5YmFzOTVBUHBWaGJNQ0YybTR4Q2RqTEo1dzFMNWxTM3hpMHdw?=
 =?utf-8?B?OFVpUWNxcUJ6OSt0VVVNeHd1MmZZTmtBcWtpVk1PNEE0cjFiZURJVWlVVmZk?=
 =?utf-8?B?UUttem9zcmxtMm5tZmFLN01nVFhPZGdEQVpNWkFlM05QRkFkbk91NU5hajVJ?=
 =?utf-8?B?LzBlV3Z2NmRyV0taK2ZqZzJqVzZvVFFpRVBXUjkycnJtcm1hMHdUOWNEVDZq?=
 =?utf-8?B?dFpMMlE1cEZTQUZIYk1qYmFPOE5KbU1GYUt4TTZzdjBxOFFFWHBJRVhMazFJ?=
 =?utf-8?B?TGVmdFo2YnY2SUNuZndjQ3FLVUlLSXI2dndjeEhDQ0YxelBUQXg3a3hCMnBr?=
 =?utf-8?B?QlhUZUg5L3JrUGFpZTd2QTBacW5vUUJRUkQrdWgzTTFGajBYSnkyaXFUMmVV?=
 =?utf-8?B?T0NqelZHKzI0dmlNc3lxWUNxMUJQdy9IZVZlZG1hQTd0NW5XbzJaTHM0ajk4?=
 =?utf-8?B?YzJQOE1aMVM2M1JTRUJ4UkRETGtEYk1aSW9QZE5TTlExTGNwTFBZRnVGOUpY?=
 =?utf-8?B?L05ENWp5STh6TVFaR3hRVUJtV09zWGo3ak02SXc3Sm9TL3Q2T3REM0h2NUM2?=
 =?utf-8?B?YmdqTEJZTXdyNkRlbjJUM0JkRlMwUTNTNWQ0UFlmeUozNDc4bE9pTE1pU1Nz?=
 =?utf-8?B?NkMrZ09WSnVNT1RVdzNGbEZnRVY2dVpFYnFoS0RYTTdHb2toQ1RVY2F3d2E5?=
 =?utf-8?B?OE1SQUhCZGpVT2twaGRtaVF5ZFhRbGY2dmNGd0YxTzVmNmIzYVRQa1libFJp?=
 =?utf-8?B?dHF3TzgwTkVTektucnBwR1grVFNsRk05Wk43VmpoUVVWYmlFU2ZOUnJEY3Z2?=
 =?utf-8?B?b1EyL0ZTcHdHYmh6L1Jma3R5QXB1Q05ZLzZEbkV6b3ZodXcvWUJFTnkrWEtU?=
 =?utf-8?B?cWxSM0N0ZnFGV2RkMlNVMmVIQkwrN3kzWTNZYWlmQXp3dUxTOTB3Q1dEZDlM?=
 =?utf-8?B?OHl2TUJDWjVvbkVHUythQ2N0bnRuMEdEUTlNUUtnSTRNd3JtWW5aQWdIQjVv?=
 =?utf-8?B?bFhJSTFrOFZMb1M0Sk5kSnY4TzRQSzZDY2hBSElZeWtZWWtiREF0SU9Tc1Bn?=
 =?utf-8?B?VzFFaW90amlPanh4Kyt5ZTQ4OUtnRFdwMUxsZEcvcWV3T0lNdGZPZVh2SmRL?=
 =?utf-8?B?ZmZSMlVraXdid2lPYjI2QjkwNHd1TzJQVEdUV0RhNlZFT3IzRWFrbGNGeGFo?=
 =?utf-8?B?ajQxbFhRTXc2RVhjb1BnckVjam5CaUdmR053eGNVYks5U2oyQmNRaHBJemhm?=
 =?utf-8?B?amRXNGJtbkRhWCt5NWVaYUE1RjdxeW02cXFTWFdEaDBOaEhKSFBDT3J0c1I3?=
 =?utf-8?B?ZE5JQTFqWkJMSXBld2g4VEIrSlR3NnQzQ0FKenJNb1pjVUMzWXQzT05jUTli?=
 =?utf-8?B?Z0hlWi96YTJTZjNBVFRURU9TRGtkQU1vSnpMYWt4YzJpcm1wdWNpWlVKNHpk?=
 =?utf-8?B?cGlHaWtncUdWSmYxWmgyWnlzR3lzcS85NFZ4dzd2UXZPaEc5ek5KcUxiTVZ0?=
 =?utf-8?B?UVVUL2U3NFI3R2FyOWYyenAzRnErUjN1Njh4bjFrNjUwWXRZYUhNazJjdGVW?=
 =?utf-8?B?MmhHb213Q21UeVlWRndXczZndlFpeTBGbE5WbjJuRWMveFN1RC9KT0dJVnhB?=
 =?utf-8?B?M0NZTFdpK0JEa0ViS05nRDFNYzRtV2trRENaWnlhdUR1bE5FQS9uTSt0OGhS?=
 =?utf-8?B?MnBkWEdmNFRMZ2RLYXpYbVhEb0h4SXZYQkdHNXFnWHk1NjlpVW1VVjJQT2RE?=
 =?utf-8?B?Um10ZjBqdWExNWV2Y0Zxdm84OXZFM1RGUC9SZ0IzMjZvRzN1Zm42RTByMjNI?=
 =?utf-8?B?TkhmYjI4cWJWdjVJNldZRy9mOVBOa2llV2lMekVJODF2MnpTWmE4ZWNGUWhn?=
 =?utf-8?B?ekZrN1AxaGhONjg3RlFsdk0wSDVsdmJCODFJcVNRWG1yWGU2OGx4Z0FFTlJ5?=
 =?utf-8?B?djNJc0ZzSG83bGZUV2RKQnE4d1BKV0Z3WWtOWTdiWUMwTU81aUQzVjBtUDZG?=
 =?utf-8?Q?ME2oU9DXafQBY05en242ALfBr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13215103-9478-4609-0f02-08db632a80e7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6584.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 05:30:41.0551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEH8ykFSdZSs6ozhVvvkSHGw8Yp2kiuKCym9hWHQUi6muYGMPicvtfn0NVyLPZREQ5trMkWref6CBTxmLcPSOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8409
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-May-23 12:52 PM, Ian Rogers wrote:
> Separate and hide the pmus list in pmus.[ch]. Move pmus functionality
> out of pmu.[ch] into pmus.[ch] renaming pmus functions which were
> prefixed perf_pmu__ to perf_pmus__.

I'm seeing perf tool build failures on linux-next because a patch[1] went in
via Peter's tree needed some changes done by this patch.

[1]: https://lore.kernel.org/lkml/168372562075.404.10852387134590654382.tip-bot2@tip-bot2

Below patch fixes the issue.

From c041b94df00baea024b64d4b19e37ee827484e74 Mon Sep 17 00:00:00 2001
From: Ravi Bangoria <ravi.bangoria@amd.com>
Date: Thu, 1 Jun 2023 15:23:22 +0530
Subject: [PATCH] perf test amd: Fix build failure with amd-ibs-via-core-pmu.c

Since amd-ibs-via-core-pmu.c was applied via Peter's tree, some of
the changes came via Arnaldo's tree did not reflected in this file,
which is causing build failures.

  arch/x86/tests/amd-ibs-via-core-pmu.c:47:25: error: ‘pmus’ undeclared
  (first use in this function)
     47 |         if (list_empty(&pmus))
        |                         ^~~~
  arch/x86/tests/amd-ibs-via-core-pmu.c:48:17: error: implicit declaration
  of function ‘perf_pmu__scan’; did you mean
  perf_pmus__scan’? [-Werror=implicit-function-declaration]
     48 |                 perf_pmu__scan(NULL);
        |                 ^~~~~~~~~~~~~~
        |                 perf_pmus__scan
  arch/x86/tests/amd-ibs-via-core-pmu.c:50:19: error: implicit declaration
  of function ‘perf_pmu__find’; did you mean
  perf_pmus__find’? [-Werror=implicit-function-declaration]
     50 |         ibs_pmu = perf_pmu__find("ibs_op");
        |                   ^~~~~~~~~~~~~~
        |                   perf_pmus__find

Fix those.

Fixes: 1eaf496ed386 ("perf pmu: Separate pmu and pmus")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c b/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
index 2902798ca5c1..1e08b2455725 100644
--- a/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
+++ b/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
@@ -44,10 +44,10 @@ int test__amd_ibs_via_core_pmu(struct test_suite *test __maybe_unused,
 	int ret = TEST_OK;
 	int fd, i;
 
-	if (list_empty(&pmus))
-		perf_pmu__scan(NULL);
+	/* No way to know whether pmus list is already populated or not. */
+	perf_pmus__scan(NULL);
 
-	ibs_pmu = perf_pmu__find("ibs_op");
+	ibs_pmu = perf_pmus__find("ibs_op");
 	if (!ibs_pmu)
 		return TEST_SKIP;
 
-- 
2.40.1
