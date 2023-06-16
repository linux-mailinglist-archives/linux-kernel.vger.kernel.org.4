Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5084073285C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjFPHF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244389AbjFPHEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:04:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::61b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170983C06;
        Fri, 16 Jun 2023 00:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeRSfWNNlrykvp9sxBZTCxxuizc6FPDnsnRnnHuzvonqIX0wl1iOpLcVZPY1uwjb1lxJ+ZtnUZ0Zlh0b7xGK8iOOniKHhctWnr7KNYcQ0ioFNNNdkPmMPEHlIgCF/bdjLMFPR9Q+rw2rQ4680HZujUpUHQlJcvTeX7eft5yLfolmYpeFKCQu/Pt4XvggCPVY7IJ9QF1ccFZIbjDilPCEFr4RcwaX0KhdaGRcsaDdbPo0iMa8z8HBIRshUYlaVSTIFM4PVnTg+He70hf/d8Mnx2QoiaICyKRP/25XAfnp3SCaqEnYtc7SNIe6g9/LWZomOO1aneitcn2YLjGFzNNePQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtMOWh8JTT09HMeEl/GRwhKhR4m+65GTdqlAPDJw8Ts=;
 b=Ab3N1nX+1U4bnJotM/ajBgfh2qmVT27St2WAvtg1ddu/f0gtEUMJwMcYmvXqOi6y+W0qzUGETHTZRXdzE/DNiLHPxUG4gT1nT/NClct3xVcaoaEttiVGjmVN3SH4A3EKgQM1kiILR2iVlYa95xM3S1ePoPafeVQq8MJ46w6om8oy8V30nZZdgEaU2Jt5hRZlIE7mv+T5f2PCP6f2xFHMFz1hGDiM2OB7jjK0F0NqUWkvz0Hv7Zh6/AgsS6uiMc7gTTQTaJTOBMSLZ6JF6AP1ZwMhEPvIBSxh0vnAMKGy8DpMHjCOK07njeeIVO3+iUUv3V+NBwJF3FPx8wv9VcEzBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtMOWh8JTT09HMeEl/GRwhKhR4m+65GTdqlAPDJw8Ts=;
 b=J3tf3ACVmrEZDntGQtLxt2mS7zbXmE70iDU78UEUY5mo7vLmbtegNN9337b/wZT2MffXDM0FE+ugH6lnlxNCjaqGm49c7a89f206SMWtsyGlz/b6KX/k3MKMxk9+DbRDoaK6ZGZTeWmIBHUwvhFsEsR+0VBfHOB2yZoz2eerrx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB8778.namprd12.prod.outlook.com (2603:10b6:510:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 07:02:57 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%4]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 07:02:57 +0000
Message-ID: <bc18bc42-3df8-30c9-10ff-8a4ba3d3d9f6@amd.com>
Date:   Fri, 16 Jun 2023 12:32:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH v3 1/3] perf test: Add metric value validation test
To:     Weilin Wang <weilin.wang@intel.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <CAP-5=fVixzBLLiWnim8x6qcDOKH7uVfEWojTCP_H531Fhy7j-g@mail.gmail.com>
 <20230614203824.2895333-1-weilin.wang@intel.com>
 <20230614203824.2895333-2-weilin.wang@intel.com>
Content-Language: en-US
In-Reply-To: <20230614203824.2895333-2-weilin.wang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH7PR12MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e2af3c8-0d4f-4d0e-36cf-08db6e37b663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dcWtqyJVjGAeDfSCu0/7m5APObggONO0c7Tqr5RyWN0Xxikb0Ul1yhuS78PADOVfvtAiVwrxbxM41r1q/LqA/HQaojbNsaI6Cbyua1HL6cUqkbnM8T6L1YeVyHfanCU1TtrCJx9CX+CFivsGOqVEs9iswiF3sS1HQoFtZS6+mZFBP7PVznc7WyjRTF4l54bWkK/07tzpRb4GHt20gjOH+uSTr2nZ5fEI9K0253t2Yflq6GtqQNi6IuqR8NkshZ66VolaSub+cBaBFrUdoPDMppRWo1Cf2tmdY6wCZPWiIAIzLcxB4Zzkf42rjPFtMTZWZWWJa67h0IZjj3bZDpIlZXQfQOYIkzvVgUi1wz/kDrJwP9YZ7rkO8iQG9TcGXm/kdbxR+qiR29fHc32GDi2xnjvY4TJhLs0r2WVhi3/CbQZm1+1J8hgaBZXFHcilykk8Yyl9NOj+nSwrKe3gPTnqtyCJnGlF8aCEgP47Xti0l3wAJn8i1vRhiBJ2JWC9Bf6mcqKlw+JjDktvi+tYpLhXZ9oni+bA9hFBeOz5ujqmEOIha6WrMrHDMZd1T3PuJY15os9S7GrcoJEYQm4liAtD50oUVOwcI/vmaqoJufYerSX8kYp0TaSTSTerRF4l3bjC2QnnmrwRDGmpOAsw1kbZYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(2616005)(83380400001)(2906002)(38100700002)(36756003)(41300700001)(6486002)(316002)(6916009)(66476007)(66556008)(6666004)(4326008)(86362001)(5660300002)(8936002)(8676002)(54906003)(478600001)(66946007)(31686004)(44832011)(31696002)(6512007)(6506007)(26005)(186003)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MENWTTFZZmhOZjFVUStxQ0dwNWtmRjVaU1VUcFZPeGVLZUJ5L3lKbHBhZTdP?=
 =?utf-8?B?bWNkQnBYaWJBajh0R1JZWWRIY0REc1hIaU5aOHNRUksxS2VwOGw4T1lYamp4?=
 =?utf-8?B?MGdodmZ2Y1FkQ1AxdWNNeFJCQlpRcFg3SjgzUWJwby9VTnRrVVVCRjA5MzZh?=
 =?utf-8?B?dXpVMW5ISkxUUkwvcXRORnh6RW5ET1plRXZBYUNoOTRLOTM2YTlGTEU1Zkpi?=
 =?utf-8?B?ZU1SbTh5YUxxcHFGZEU3SUZGQVlsVDBKR0xQMW5DTnpVelNsUkNUd05nR1lG?=
 =?utf-8?B?QU1tc0swSW9Jb3pzcEE3RTJlUlZKWG10eG15N2hocXhOaGZBQmdRVnNuV0RR?=
 =?utf-8?B?eWlZNXhOWW81YUhJUGhieVd6WC9JdU40bW5WVHJYc25Fc0dHMzRpU3Fkb09Z?=
 =?utf-8?B?WDY5SktKR0tiZnd0emYrdDJHTWNscE5LUkNIcGt6ZGFtUHg3N0ExdUk1UlYy?=
 =?utf-8?B?TE1EUVNuMVdJUXREWmRWNVNQenc5VUNOVTA1TlVJSmQybERZY2ZtMFJoQzVw?=
 =?utf-8?B?a3NaWTJudjhSckE0RzdoMjh0dkI2aVczSkZMYlhqTTJwNStXakF6Q3NQUmpq?=
 =?utf-8?B?K0NyZFpzamQ3OWtwTmJEd3ltbmExVUU0STJMOUlSSUcxRC84ZCsyRkZldlN6?=
 =?utf-8?B?ZEhYMy9iTUpyR21EQ3pVZEdzQjArQWdwL3hsNi93NUpZdW1HQ2UrSGlNemQ2?=
 =?utf-8?B?SForMU5TejVhUWJ0WXhzVnlHVmRNMjhQUjQwOEk3QnhZOTZPNFZqeUZza1Yw?=
 =?utf-8?B?Mi9rWjY3QmFtc1VWa1hCbyttbEtPeEdYUGZpNitES0Q4c1RHandiWGpVOGJO?=
 =?utf-8?B?V29kREJjSjZLRHNLdlJnRHlYWUd6cUcxTGxGbSs3OXl1cmRwb09PSVRyWjBO?=
 =?utf-8?B?SGRidGlnVW5yUGRpU2ZJUWR3QUtwZDE3YUQ3ZzlMbnVyM0VKWTNMVFB0TE9T?=
 =?utf-8?B?OWpHMVZuUTZVOGVLVGpyRjVTZHdkblpXLzh6VXJXbk8zSEROcTJ2bjJUWEs5?=
 =?utf-8?B?Slpwc1JnNUJ6OWErSVRzMEZPUlI2RzB5c1VKVnQxTDRFZ3JlcE83a2RTdTNR?=
 =?utf-8?B?cUR1WGthSnRFV1JqbUczNEx0cXQxL0huY0hHZFdreFQ2eXJEdmhkYXhZWDY0?=
 =?utf-8?B?MzZDYWJhL1p4Lys3cGd4YWd2c0diOG5NRnFCeXF1Q055UVRVSmJXM2k3a3lO?=
 =?utf-8?B?Uk5VUkpaQlZIQ1A3OWRQZ2FZSlBEeGNOSnE0ZkdqV2NjbjRIVXVUTis4cmpL?=
 =?utf-8?B?ZlZSUzEySzY2NFVyT2dDajkrckpqMjlPbTdKRFRaS0lkU2IwRjZTV25TeVVB?=
 =?utf-8?B?TTkrbU1JSStFdzV2VFo3U3dFSEZLZGk4Q2YvWXBvcEUybW5pdHZkdkJ1d0Nr?=
 =?utf-8?B?RkNDU216a1VRRVZjVVA1Nk5TVlRGTVJqdjczb2F6d2hvVHRERTF1dDlYa3Fp?=
 =?utf-8?B?TmUyWnZHMDJoZ2ZBNVNoNUZFN3l0NzcxRStoVUs2Qm1Mc0ZXMWthVTN4TFVU?=
 =?utf-8?B?NU9yK3FSeklVc1VpRk5lSnh4VEpldWpQQ0tvZ09NQzJ5Z2FGZVpPQjNkOVNO?=
 =?utf-8?B?MEtsbzlvYTA5eEhaemphVTZSOUg1UXMxaWU0QTlBNmEvcnhXUDIzRitiMGF0?=
 =?utf-8?B?dDd0VFVRMkQ4dGV3TmNqRXNYcU03czlNWEpWa2JnVWNuczl1R2xZczY5K3lO?=
 =?utf-8?B?RXMvZWlHRWlLR0Z3NVUyT2J4VDJMM2dBVFVtc1Fwa2N1R1EzNU5seCtYb0dD?=
 =?utf-8?B?Wlpkalc3Q0VPUGQ1Q1hyb21RRDk2cXV2cFJQTUkyOUNNcG1LU2szdkhOays3?=
 =?utf-8?B?d0ltN0phcTJzaEhhWWhjamtRMDh0eHh4bEpqRmViQkltWUJGQWRUTFRPV25N?=
 =?utf-8?B?U0FycVFKaU1nK3lOZWVyaDEvcDBlT1FDbUVGekREb2pubzd4aXRaT0NEc0ZP?=
 =?utf-8?B?WWNCemNGS1VyTUxTeTZFVG5IVXlCZFpDRVJqUWpWcXpYaDdQdC9Za2lDQXlP?=
 =?utf-8?B?bVBSQjJnVW1UcHpDV3crbGYwaWpEdFlYVm44MUtLbWM0NFZCMmJtb0NOdjIy?=
 =?utf-8?B?OE5aa0w3a3RwKzMvYzFXbGZrcXVUaTlycG1mTHpTamN3SGJmN3FSTElXK3hi?=
 =?utf-8?Q?r90ZJESM8wtp8s/rwYhS0jX8+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2af3c8-0d4f-4d0e-36cf-08db6e37b663
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:02:56.9143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O21bXYO8hUCq2lroRccGSfZ2/VbxMZ9e+EgKn7POrtGfXqVWE5l6On97jJqM4+XKYkAJZo1rkFis2naNUnSQ/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8778
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> diff --git a/tools/perf/tests/shell/stat_metrics_values.sh b/tools/perf/tests/shell/stat_metrics_values.sh
> new file mode 100755
> index 000000000000..65a15c65eea7
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat_metrics_values.sh
> @@ -0,0 +1,30 @@
> +#!/bin/bash
> +# perf metrics value validation
> +# SPDX-License-Identifier: GPL-2.0
> +if [ "x$PYTHON" == "x" ]
> +then
> +	if which python3 > /dev/null
> +	then
> +		PYTHON=python3
> +	else
> +		echo Skipping test, python3 not detected please set environment variable PYTHON.
> +		exit 2
> +	fi
> +fi
> +
> +grep -q Intel /proc/cpuinfo || (echo Skipping non-Intel; exit 2)

This check doesn't seem to be working. On my Zen3 AMD machine:

  $ sudo ./perf test -vvv 105
  105: perf metrics value validation                                   :
  --- start ---
  test child forked, pid 518035
  Skipping non-Intel
  Launch python validation script ./tests/shell/lib/perf_metric_validation.py
  Output will be stored in: /tmp/__perf_test.program.tnPoW
  Starting perf collection
  ...

Interestingly, it passes :)

  ...
  Test validation finished. Final report:
  [
      {
          "Workload": "perf bench futex hash -r 2 -s",
          "Report": {
              "Metric Validation Statistics": {
                  "Total Rule Count": 2,
                  "Passed Rule Count": 2
              },
              "Tests in Category": {
                  "PositiveValueTest": {
                      "Total Tests": 12,
                      "Passed Tests": 12,
                      "Failed Tests": []
                  },
                  "RelationshipTest": {
                      "Total Tests": 0,
                      "Passed Tests": 0,
                      "Failed Tests": []
                  },
                  "SingleMetricTest": {
                      "Total Tests": 2,
                      "Passed Tests": 2,
                      "Failed Tests": []
                  }
              },
              "Errors": []
          }
      }
  ]
  test child finished with 0
  ---- end ----
  perf metrics value validation: Ok

I haven't yet investigated whether it's genuine or false positive.

Thanks,
Ravi
