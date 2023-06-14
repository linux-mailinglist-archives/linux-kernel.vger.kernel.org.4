Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F4972FD12
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244167AbjFNLjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244085AbjFNLja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:39:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCB626BF;
        Wed, 14 Jun 2023 04:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKZJWy7q9FVBXtv2GK4gEq7J5fKowVrtasDaOKcE3u3wSozcZGVckwsCGS3nKuX6SGqqQLT5t/67HnsRsRWDNQH/iG1HmvTiR9BHb36CcRSsX18oSNpcWyAnHEJ0q0TRigHrg9yqgjSlk3YIUBYG7cZzoqyjyos2wpASMA+h6jRBqbcAb8ZczPMp7OnCtnL1k00hV4WQK8RsQyVH58nKQCNYc/EmcTFl4iQjpcNuw3DLP2X3n7pKep5yCzq8s9X9L86708xP+Ucc2sEgJeFeoGwrNqizacjnu+654SPEVWbfaXu6QYye7W4pVTtmyN8D818cwi1Q42LBkDTszuGIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lPexcpp1qpj9zRj8kTI3+HCyWD6SZUjLwJ8gXzhzuA=;
 b=Bo4mTisBO/3a+jYOJpWDRAlNawiwOc4NpflgzvDuqbWdw4lyyMvzGkT/ULpeZXWhmOBJ5rdcRJ2z0lOhJKtBB9jHtdoHzZYiSGAKEdzkgDZuwwGBQ2/YajD7OuLYy6BcckaHNKMmN9BUfc6ZpE/0OqX8MdBx+8RueSezJvt3WP5lzXOeK0tTYg1OCckDp9IQUs+pvdkSzOWJd9iRPHsihwxVQsG/TXHQOx6NjeepLXogoLNS/q6I1eExLoRMzInip7tpU6sNKQFZC2KXOP77dr+txSp8Xrk/yGKt8OIgXL+5+t5dH3qkFPimk/h6uq5g1wQ4ozBj13XDWfqGJynu7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lPexcpp1qpj9zRj8kTI3+HCyWD6SZUjLwJ8gXzhzuA=;
 b=WvDmKysCZC27VdIGODi6vUyc8bM+xjMezxNZcO1nNEwhlsQ0tTniBlBU6wcuLa+C/Eys2eX6aj7odBKqXsfoqQbDkQ0a5ITyYEkYE+K23/Ywnxz3TPyr7O3NJBL4VL0uqqSUYqn5otKJYXrftMrNRF7ENXuZfxVRLYy5UNwiBhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20)
 by BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 11:38:35 +0000
Received: from IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::5f70:8e17:f854:91ed]) by IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::5f70:8e17:f854:91ed%4]) with mapi id 15.20.6455.045; Wed, 14 Jun 2023
 11:38:35 +0000
Message-ID: <1320e6e3-c029-2a8c-e8b7-2cfbb781518a@amd.com>
Date:   Wed, 14 Jun 2023 17:08:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] perf test: Retry without grouping for all metrics test
Content-Language: en-US
To:     Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, barnali@linux.ibm.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
References: <20230614090710.680330-1-sandipan.das@amd.com>
From:   Ayush Jain <ayush.jain3@amd.com>
In-Reply-To: <20230614090710.680330-1-sandipan.das@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::24) To IA1PR12MB6137.namprd12.prod.outlook.com
 (2603:10b6:208:3eb::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6137:EE_|BL1PR12MB5269:EE_
X-MS-Office365-Filtering-Correlation-Id: 15de3cab-212c-4397-49e0-08db6ccbe32d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+P1rObzZqmbwYZTTvOizgcQic8BIqbOPYpO7IfJ702EcfsVuZtor3bX87PR/NKo9maGMVDL+/6FDxc/0p8Rzo2bBvhhPa50e4mfUvKzT8x1iD2vmiajcXuWitJ3QVJbUnDZIpG93oCE/ghcOhNtcTLftmukqGwTLiC9Y26DAbn/GR3B5U+sQC9CVgNC0FZ82hjyIXHbMkD1s/GwQgrT1SbsCkcbSMrwSYCm4Yugj9/jnoQ/1YpiaaxTkprvOwp4JTJowN/q3gDHUo7GI/0957X/G6CHSZCxs5jn4Djf3P0tHeKkAZcmDL27HrTc0Fq6PiHqwQAyoLLe17kbPER/jD68Vp6DG1nSGW2ivnUf5Jmm8Ub6Koyaydk30Cf2CzXk/pnX2zPCxAm2rNfpbTAJz5P93RCxp8/z4ckWm3yCfYPuyVfz6oJKOlM5y/i7E/eSucvZvBGeexP1yJxylSP17N4k2Jw1beCkWXf9SHusabeulAdzfcw8sTeXHIRPcV7p5oYKmpQQq+6tIgI4bT10GFASzkZ2tMdO7sbcmIwVXaTrFfZg/c+omZLmfzEAQMCiHr4oGXB8oKEduNc/hPa7k9pyOEADcKQoRnRIUCGOs+Q+o8nGT6lz18eL/cHP5R0+c7SLO74s57dNGUE/g04PGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6137.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(31686004)(7416002)(5660300002)(8676002)(8936002)(41300700001)(2906002)(316002)(478600001)(66556008)(66476007)(4326008)(66946007)(6666004)(6486002)(38100700002)(186003)(53546011)(31696002)(86362001)(83380400001)(2616005)(6506007)(26005)(6512007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVFtMlJOM05qNnFXaXJBaDk0K1JVcXhqeUxuNys1MXdBZzQzNnJsekwxa09S?=
 =?utf-8?B?WndDVFlES3RxdndjUW04bmRRL2FNNjJpeGFRd0VpTVpsWXJETHFxTCszSzU0?=
 =?utf-8?B?b3BVQkNUSHZtYzR0Y0ZLYUhuaGRmUWxwNHJ5QjRoazBDMmY2UTlIRmtYV3B4?=
 =?utf-8?B?Uy9qUnNaYk8rZkFLNkIvdS9XalgyNkp5OS9ZMmR3am1iak1WUWViSEQ5Unlh?=
 =?utf-8?B?YTJJaUNpTklaaUhIKzVZZTBqVW5aWGFUWEdSSEV6Yjk5RzV4UjgvVW40Zi9U?=
 =?utf-8?B?aDN2aXcvREtUTTVtZ3Vnd2V6QVc4N0dQSlpLNGFjRUxiRkdlbXd5ZmhFbGJE?=
 =?utf-8?B?R2lQYWdrVXkxYzZBTnI4c1pkWkdUSzJlOXBkTHFCenVEV2hwUGJCRmUySjht?=
 =?utf-8?B?M0R2R3FDZHJTNmViQjJBSjdrOHNzUlFYczZNOTBTRnNibTFBZDB5RmNueTYw?=
 =?utf-8?B?TDB2eWxFbndmQ0JBKzJOSElHbGtuNit4R1FiRWVoMlZKdDRubU5iRGMveVpy?=
 =?utf-8?B?UktHekZJSi9FbnpvU05lM2dPWWx6MkRBVnhESXNGNFU3TFQyZUxJcE0xWXVR?=
 =?utf-8?B?WGZsc3JSV0g4YTZoTEF3UVVmNklnT0NnNTZaNWp4RVNnd2lLN3l1S3dXd3V4?=
 =?utf-8?B?a0ZEVnA0aTYvajhxMnNqeDdEYk1jcXBWcHEwQVd1Uzg4SlIwclNnM2huUWs4?=
 =?utf-8?B?MDlkajQvTFRpMnB5T3hjalEvd3M4QVQ3R2hxMGtvMjNGcjlNUVQ4TWNVQjZX?=
 =?utf-8?B?NmVqdHJJYThsTnEvbDMrOWdURWkrMWZOTWF0WDBiWURnVFkyakVHaXQ5NVNU?=
 =?utf-8?B?SUgzZkRtTXZhdGw1NUR5bnUzdk9HaTN0TUR3eUlRTG9RVSs5Z2VmeDhnandn?=
 =?utf-8?B?ZEE5Z2VXaGNKbmVzYzF0ZzErbDc2YzBkUFdIMlArSjR5TFRUbCtybVRaTjR0?=
 =?utf-8?B?UjNCY3RYZjFTOWQzN1dkdC9VSzZ4dllMSXhUZFRqd1NQZ2JnTXlkWUZOZW9M?=
 =?utf-8?B?TmM3cGt6ekY0SDNOSEVsUXVkRzEvVGF5YVNPVDJHWjJMbUpXWURCbDc1K0h1?=
 =?utf-8?B?UGpEeGJyLzRsLzhSQkVSaWVjdnNFN1ZKZzVNWWdQeFZONjBKV3V3bWgxbERU?=
 =?utf-8?B?em5Uc1ZhZk42SkdtbVVncXBMMXhhYzdoSzFpVE1MYVIxeUlRUWpIS2ZWMG5m?=
 =?utf-8?B?RTVPVlNiRG9sdG0xZEd3RVRRREd4OHI5S3BWUmFtRkNRcmVEVUpRbkowVWt4?=
 =?utf-8?B?ckpFOHpobFUwaHUzS0RKSUZyRjJuWGMyaTdlNmlVNFZmZXA0OE05eEVJZmlt?=
 =?utf-8?B?RFhpb2pDRmJtTVlkVEpXbjk4ZDVGTXJ3NlVQWTJvU3hva3RRQUQwYmZNVDFP?=
 =?utf-8?B?WGZYUXlDUnp4QUdZd1k2N0ZEMVk0OHBvNmNabUpteVdQM0NzSHZUZlp5TmNG?=
 =?utf-8?B?cGNHSDZQTzVpRkZ6SHZjR3k1WjhoSEd3a2Z4dyttL0pqaS9ZSkN5OVhFM2pQ?=
 =?utf-8?B?alFDNmdTWXFReVRHWlBWcnlDM1VubTV5b3FGTDRFNUNqdUlqR0N1aUpuZXpG?=
 =?utf-8?B?dHBWOHVmTEdXZmhWTlY3eEkxVm5yakFCUnRMdk5PSEtxYzNTRjRESWJhTTBP?=
 =?utf-8?B?cGlGNVNpR0RhM1VybjNIZ2NoZG5DM01DMXByZkJLb0Q2TEU0R2lpRE1zTGtH?=
 =?utf-8?B?TWxmRjREamZzeTNGVVBhNzE4N3dHV2REUFpyTzVCbkRSSE53NC9jMFVnWW5R?=
 =?utf-8?B?b0lJaHJCUy82M1ZFTTJnbS9LQ1VCc0YxZHAvSjhHbmk1eExtWGdMWVl0WDg3?=
 =?utf-8?B?azJoTHVTK2FVU0tNY2NCSk5WalJscGNFa0FpRThSd3M5R2NVYThQM0VLV3cr?=
 =?utf-8?B?ZFhXSW8xSzk0OUlSUDQ2WGRMb01oV0RiOGt6VUJYTmFYU0hMTU1nN1YyYlN0?=
 =?utf-8?B?V1dtN3UrK0cwajZMSE1GTDRXQlpMbzdZUDg2d2NZajVaUUp2ZGJrY2o4Rm15?=
 =?utf-8?B?NzhDN01mV3hRUXFBQWx0SDMvN0RsS21qaUhQTHIrQUMrazU5OVROTlBxbkNa?=
 =?utf-8?B?OEVMcE03RlBNWHBDMWlsVWVUUWZoYU5KbytraTlnZ2FTU20zREYrcHRJQ09W?=
 =?utf-8?Q?9McbHyKM8wlGpQsJO4A/nAAQp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15de3cab-212c-4397-49e0-08db6ccbe32d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6137.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 11:38:35.1806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOLl2JadJXSkNpK5s0f5uC4reSHY9k6KqoaRQfZaXQq3etMeeULgawt2A0zCeu2gllHB/axtEo7PCimdb0tuog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5269
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sandipan,

Thank you for this patch,

On 6/14/2023 2:37 PM, Sandipan Das wrote:
> There are cases where a metric uses more events than the number of
> counters. E.g. AMD Zen, Zen 2 and Zen 3 processors have four data fabric
> counters but the "nps1_die_to_dram" metric has eight events. By default,
> the constituent events are placed in a group. Since the events cannot be
> scheduled at the same time, the metric is not computed. The all metrics
> test also fails because of this.
> 
> Before announcing failure, the test can try multiple options for each
> available metric. After system-wide mode fails, retry once again with
> the "--metric-no-group" option.
> 
> E.g.
> 
>    $ sudo perf test -v 100
> 
> Before:
> 
>    100: perf all metrics test                                           :
>    --- start ---
>    test child forked, pid 672731
>    Testing branch_misprediction_ratio
>    Testing all_remote_links_outbound
>    Testing nps1_die_to_dram
>    Metric 'nps1_die_to_dram' not printed in:
>    Error:
>    Invalid event (dram_channel_data_controller_4) in per-thread mode, enable system wide with '-a'.
>    Testing macro_ops_dispatched
>    Testing all_l2_cache_accesses
>    Testing all_l2_cache_hits
>    Testing all_l2_cache_misses
>    Testing ic_fetch_miss_ratio
>    Testing l2_cache_accesses_from_l2_hwpf
>    Testing l2_cache_misses_from_l2_hwpf
>    Testing op_cache_fetch_miss_ratio
>    Testing l3_read_miss_latency
>    Testing l1_itlb_misses
>    test child finished with -1
>    ---- end ----
>    perf all metrics test: FAILED!
> 
> After:
> 
>    100: perf all metrics test                                           :
>    --- start ---
>    test child forked, pid 672887
>    Testing branch_misprediction_ratio
>    Testing all_remote_links_outbound
>    Testing nps1_die_to_dram
>    Testing macro_ops_dispatched
>    Testing all_l2_cache_accesses
>    Testing all_l2_cache_hits
>    Testing all_l2_cache_misses
>    Testing ic_fetch_miss_ratio
>    Testing l2_cache_accesses_from_l2_hwpf
>    Testing l2_cache_misses_from_l2_hwpf
>    Testing op_cache_fetch_miss_ratio
>    Testing l3_read_miss_latency
>    Testing l1_itlb_misses
>    test child finished with 0
>    ---- end ----
>    perf all metrics test: Ok
> 

Issue gets resolved after applying this patch

   $ ./perf test 102 -vvv
   $102: perf all metrics test                                           :
   $--- start ---
   $test child forked, pid 244991
   $Testing branch_misprediction_ratio
   $Testing all_remote_links_outbound
   $Testing nps1_die_to_dram
   $Testing all_l2_cache_accesses
   $Testing all_l2_cache_hits
   $Testing all_l2_cache_misses
   $Testing ic_fetch_miss_ratio
   $Testing l2_cache_accesses_from_l2_hwpf
   $Testing l2_cache_misses_from_l2_hwpf
   $Testing l3_read_miss_latency
   $Testing l1_itlb_misses
   $test child finished with 0
   $---- end ----
   $perf all metrics test: Ok

> Reported-by: Ayush Jain <ayush.jain3@amd.com>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Tested-by: Ayush Jain <ayush.jain3@amd.com>

> ---
>   tools/perf/tests/shell/stat_all_metrics.sh | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
> index 54774525e18a..1e88ea8c5677 100755
> --- a/tools/perf/tests/shell/stat_all_metrics.sh
> +++ b/tools/perf/tests/shell/stat_all_metrics.sh
> @@ -16,6 +16,13 @@ for m in $(perf list --raw-dump metrics); do
>     then
>       continue
>     fi
> +  # Failed again, possibly there are not enough counters so retry system wide
> +  # mode but without event grouping.
> +  result=$(perf stat -M "$m" --metric-no-group -a sleep 0.01 2>&1)
> +  if [[ "$result" =~ ${m:0:50} ]]
> +  then
> +    continue
> +  fi
>     # Failed again, possibly the workload was too small so retry with something
>     # longer.
>     result=$(perf stat -M "$m" perf bench internals synthesize 2>&1)

Thanks & Regards,
Ayush Jain
