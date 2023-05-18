Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385AF707A54
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 08:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjERGpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 02:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjERGpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 02:45:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BC5FD
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:45:07 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 34HNX27f011195;
        Wed, 17 May 2023 23:44:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=QnuUxYELR7wanVElOR5YmjHL+3rZ2hLSMuOnorxmuWo=;
 b=e00eJPejo2eYQ6r5Bhjs+5y/VhAqkJSs1SX8aHq57i8djO745fR2Grzq3Bu0dIdJ7zDU
 1MBJrDavHxemibv298UlkffhRQubmJOoYmT+xwFlxjfyEVNPTXSXPg0HNK0/zqeL4JjT
 dxWUH0pZUMI0B301EpZZu8g8PzMk6EkNCxkt6wS3pROmop7OiMQuKVc962DKRpH5z3N/
 BEitSlLAzUmddhyNoVAKKvfY0E9/7uzpWlOItTwvfLJOo1RaWlqTD6x5vqckt7SAr2zb
 U5mEHvQi1b8GbgahY/IutuKyoq1ROevnGNne3d5M0csRUfBP0m+N/oUzImyyXyrZovb7 ZA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by m0001303.ppops.net (PPS) with ESMTPS id 3qn12jnet3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 23:44:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fimnEMNh/QwSUk0vIDBXUMcHj6+KvGDHdemyL8T4D+gOuKQV1tOkcft/qML5VtNXxpe1PEyJUHL2HrzBZwi8fvvcM69zle21Mis0RaXZsL288E6gTSWSfhu37vWrTsaXBQO7kEGV6L9n8kokElXWiaZ0LjLZRL49NmxZpaNXxWeopAw4/2XrNBHi+TpCFVJ2S4q4hdJjW7ORHTa4XVYdY6aqJltXLD8clvn/cKTZ39uUDQmvqfdDxHDKHWn8deBUpjJ6x/hRky5LSM6r43on2+i4Xtq3cLpUfV6hnjpYxp4vV9J1s2iCrb7V3JfEHiIreU4p2IJY/od0drXR6QQnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnuUxYELR7wanVElOR5YmjHL+3rZ2hLSMuOnorxmuWo=;
 b=Cnl/3eJYn07pyDuY9Ibe7uuH+0RZxVIr4fbkh/arxfr7NRjiL2nePmGHNefNL2POa13P7FYR9Qr6dX9M+pruxDp/HjqDuUPMgQA0Hi6PAKpFgxrlyECqdBZafexSsGJm5Ju8vK43vVdzqLEtCP59yTpa1r6CtLq0vgjPu7jBszIuyEHcNo9kitWGFMR0zmixVITubZxP2Zi8NXYwE10m3pPjjrxC/WpK+fAi2l6sGJap5ohV4/TOFAdLiNNuSKfi13Os2Y51Vfb9Vdz4Tkdn8TwVuNUfw6HG+6h9RjVXQYq5treo8Vkx7HB0hPUkPGGL6nzwa30MizbZ0hkybFMhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CH0PR15MB6113.namprd15.prod.outlook.com (2603:10b6:610:193::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 06:44:43 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%7]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 06:44:42 +0000
Message-ID: <437cc3c8-73e0-dbc2-2998-39310e1597e9@meta.com>
Date:   Wed, 17 May 2023 23:44:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v4] watchdog: Allow nmi watchdog to use "ref-cycles" event
To:     Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org
Cc:     kernel-team@meta.com, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230518002555.1114189-1-song@kernel.org>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230518002555.1114189-1-song@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::41) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CH0PR15MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2dd2a7-1dff-4e24-a2bb-08db576b5bd7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAw/7AURQz28EdTnavBFZWJiADf4YIkDtgI3+AF6lQJsUbZeTC3aQY5eV0RR9j8IK7GBoK3Ool+BFGEZInhT7y+aszfI0wKpGUlB4YxajdcxXj6JDMftpUnVwfsRSR9nmtcC+rBEVhmB6xBRPFESARFdRZUvwaE2XIDe9d915T4cX+xakXIa40KmLiuMjs38JgRw8c5cA07rwXPwnFjKw/QhhwulTbA1aroZ+pkjztEPVN1qZTvdB2nx5x222fsyF99xQUGUBe35ZWTcyM6nxL4aDjO8GgfqHEr1X0chMzqM/bKbaisW08QSc05pRtHE0BTHzcsrvoY5u03Bv+U0ZTl0pHQUdGyIS3PscznGQSeBz2Mi5aaJMAAV3vT2PJDgFAR2dhN6I9SJCykWM3mMU7BTYUbLNSg7gk6hnmHGGvelIzapVCBTJacPnLIQzHL5sa+VQgIX+NVeCQ8y6Y2KxpEwp4eY3nogSdQpFYp9kdS8FwcZGjVGOOa3bb3wW/141HSqb4nIk/zEsaYfrjgDKahqxgWv+BBYS+1LQFMbsU1kEIdOmeuMBs8T3CYPVtIbLGKqy1g8kGau3A4By+5Yrmqg7XVNoezPIU/dqryV5fT/LBRxnmXjGYARRjP7nRv5kcYlUIXQa+8kAK9Ui1jIu8J/p4uq77pAQ0Dj684wZ0G5J/SnWPnIMyUyS7KCAZVN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(53546011)(6506007)(6512007)(186003)(2616005)(83380400001)(66476007)(5660300002)(66556008)(4326008)(316002)(66946007)(41300700001)(8676002)(8936002)(6666004)(6486002)(54906003)(2906002)(86362001)(36756003)(31696002)(478600001)(38100700002)(31686004)(461764006)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnZDdjdwTU82R3JWNDlneWVScWpFUzEvY3cxVUYzMGlRRzVnTitsM3VmcHlr?=
 =?utf-8?B?QWlUbjhDYitOdjQxejAvNjNFaGdwR2dya1ArMHJneTdIalV5UWNoS3pkd0lQ?=
 =?utf-8?B?Risrd0ZXOUtVdDNHb3AzMUtWOFZCSUNHN3owUmR5aXQrcVY4RHduWTAxQVBP?=
 =?utf-8?B?UEFnOTVKTU05SmxsZnk5SjNRS08xRDRaVGdvOWFkamtKSWo4WVNBR09MdWRn?=
 =?utf-8?B?TnV5ZWYrZUtKaTgyTWY5ME9SbzQ2amZueHdJMDcyUlJJTWNIRTZmYXIyNEZR?=
 =?utf-8?B?akZ2NVFodlpSMG52NVNFY1lBMmFDQXFETGY3MmxRNUQzQlN2UVkwczFZOHRj?=
 =?utf-8?B?QXFxQUlMR0k4MjN5anNaWFdaK3N1eEtmT2ltNWxDbHE0aXB6SThEQTk4MkRL?=
 =?utf-8?B?MGxCR1daTTRiL0lnZ2E3MkJ4TFdJVlpwd0J6QlUwa05XeUcrOWFtNm1hNDBQ?=
 =?utf-8?B?UGdCbFZtUXFFaEFSbmVxam5UcEMzS3ZpQ2hCK3l3NTcyYjduSTZsUWJHNDlq?=
 =?utf-8?B?eTlObDRyb21iUUlHbGpBRFpJbW90S2RWZHBFMkRPWmNObG1uL2h1ajJ5S0tu?=
 =?utf-8?B?VDFBVG1wak1LMWNzS1hXbCt5R25yc2svNEoveUJBWmVCdGtGcVk3ZzdrdmQw?=
 =?utf-8?B?UWpJTERLaDVXbU0ralBMbVEyOWhob1BaZUF5bzE4VTJxS1YrWWoydE5NWWVn?=
 =?utf-8?B?V1QvOGFrUlNDUktZQ2REc29EOWdzWFk1dUltNytheTVJbTlYRDhFQ2t3UzVJ?=
 =?utf-8?B?cXkvQ2ZDNkRKK1FaVTFUTGZ6OFpYR1ZWaDJBNkRPVkFrUnROL28yQlVaaU8v?=
 =?utf-8?B?azVwVTJVOHVHTFpxVjZ4cll6OGdKYnZyNGJJR0pGcmQyanJaa1lRWXcvS1Vt?=
 =?utf-8?B?ZmJPdXUrblpIdVppdjhIMTBqOTlmOGhrM0x4czF2YitGMEFRcGU2RVpNSkhk?=
 =?utf-8?B?Y2FtZXhvd2ZvS2dQZFNTcnd1TGhxSFIyekRHS1FlNGFLU1M4OUlYdVNXY0Vh?=
 =?utf-8?B?Z25WRUUwMEY2TXhSbzQvakFDQlptNzJMdnowOGZJL0VoSytoeFpIUEUveWVL?=
 =?utf-8?B?RkR4U25iU2taMkZIb2czZVhtUGlwTGQxQ0FENFR5bjg5QjJYdHN4aENSZ3Uv?=
 =?utf-8?B?ckNKZERZWXpTRVU2dmptK1l5ejJKL2NvQmJvMWhPRy9MUEJJN1NFakVYdkRj?=
 =?utf-8?B?eWlOU3l3VHBQazlQeHlKQzZlQ3llNjkvWmZ5eUFpSXdhVGtJdEpKM0s3VFp4?=
 =?utf-8?B?SlhQb1ZUKzc5emdoMWhpUkFqMkZrQkhGNk5VZjBzSUVPSXU1RVp6OGlaZXdT?=
 =?utf-8?B?bC9HSXd5K2xlNjZVYWxRa1hKU0xXK2ZGaXdYUmtyQUJ2ZDVuRUxZSFJTMm8x?=
 =?utf-8?B?TWk1YzE1enZlY3A5cFpmN2h5TTQ5NVJ5Rjk3WW9TSk9vMjBwMTVwL3paenB6?=
 =?utf-8?B?bmRWUXhjZjVpVUhqTmRHV3h1MFoway9nbHF0ZEZiVFhCV2gvaFBFWkRiK3VJ?=
 =?utf-8?B?VTg4MWcwcm9rSFV3V2RKSG9aMXlXR1hmSlk4cTJEU3BDQXlHS3RXS2lYdjhy?=
 =?utf-8?B?SkpMcytrNHVLWGZ6eW9kSkNlWTJUM3A5Q3NqUEhDRHNEckJCbmNqc0tlZDZ4?=
 =?utf-8?B?NWt6VUQ1WURpTWZ1RnhaZFBhbW5NNVJ1SlMxa29sVEJqSVZ5R01XYnpvcmhY?=
 =?utf-8?B?UlY0Zk5ldTZqUm9XRDJWdnE3MWdJSTNYUU9mUGtqZ0dZTjJvaEZYMmFwQWFI?=
 =?utf-8?B?RTZhTldnYkt6QXZpWWdmdVJPOHQ1WnRnZS8zbFc5Q2dWaTNkRDEwWkJsRTNF?=
 =?utf-8?B?S1g0cEpkUXM1ZHV2K2lldktSZUNOeTIxeXM5YkRKKzlFZ00vNmFrTjJvUjFQ?=
 =?utf-8?B?S0lENDBkcjBva29lNzVCQTh2WEE5SkVFVWtBclh1bzdRVmFJMDh1UzZ6OENj?=
 =?utf-8?B?OXk3M09RVkJHU0NaM294ZTV5Yk9aVGhOZGU0eU0wNktKSFFhK0taekh6a0lK?=
 =?utf-8?B?VU1ZR3hZZmJkb2NraUxWZFFmNWV3OU96bHZrVGp6MzVjUUc4V3E4MDd5UFdB?=
 =?utf-8?B?T0NtUGk3NmNoSm9kSnJMNVFIaUl6YnNpT0VlL3FlZjgyV0VHdDArRE0zT2J0?=
 =?utf-8?B?d1pIVDhpR2VUdnpDZUUrdnJ4VG5lY2l1Z0tBZ0hpL3M5dFZNSmE4WHJmeVBG?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2dd2a7-1dff-4e24-a2bb-08db576b5bd7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 06:44:41.8955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VyYuUvka8viH9p6uzbJsy/OM2UVE4UUcSjFE477YXfRlOcYP4J+Ys1hRnvne5pZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR15MB6113
X-Proofpoint-ORIG-GUID: ghfSZFEbMTnGXwIyS0xeqAl3Ei6M-SiJ
X-Proofpoint-GUID: ghfSZFEbMTnGXwIyS0xeqAl3Ei6M-SiJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_04,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/23 5:25 PM, Song Liu wrote:
> NMI watchdog permanently consumes one hardware counters per CPU on the
> system. For systems that use many hardware counters, this causes more
> aggressive time multiplexing of perf events.
> 
> OTOH, some CPUs (mostly Intel) support "ref-cycles" event, which is rarely
> used. Add kernel cmdline arg nmi_watchdog=ref-cycles to configure the
> watchdog to use "ref-cycles" event instead of "cycles".

Maybe list some example how this new option will used?

> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Song Liu <song@kernel.org>
> 
> ---
> Changes in v4:
> Fix compile error for !CONFIG_HARDLOCKUP_DETECTOR_PERF. (kernel test bot)
> 
> Changes in v3:
> 
> Pivot the design to use kernel arg nmi_watchdog=ref-cycles (Peter)
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 5 +++--
>   include/linux/nmi.h                             | 2 ++
>   kernel/watchdog.c                               | 2 ++
>   kernel/watchdog_hld.c                           | 9 +++++++++
>   4 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9e5bab29685f..d378e23dad7c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3593,10 +3593,12 @@
>   			Format: [state][,regs][,debounce][,die]
>   
>   	nmi_watchdog=	[KNL,BUGS=X86] Debugging features for SMP kernels
> -			Format: [panic,][nopanic,][num]
> +			Format: [panic,][nopanic,][ref-cycles][num]
>   			Valid num: 0 or 1
>   			0 - turn hardlockup detector in nmi_watchdog off
>   			1 - turn hardlockup detector in nmi_watchdog on
> +			ref-cycles - configure the watchdog with perf event
> +			             "ref-cycles" instead of "cycles"
>   			When panic is specified, panic when an NMI watchdog
>   			timeout occurs (or 'nopanic' to not panic on an NMI
>   			watchdog, if CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is set)
> @@ -7097,4 +7099,3 @@
>   				memory, and other data can't be written using
>   				xmon commands.
>   			off	xmon is disabled.
> -
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 048c0b9aa623..edfd1bcce0f6 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -102,12 +102,14 @@ extern void hardlockup_detector_perf_disable(void);
>   extern void hardlockup_detector_perf_enable(void);
>   extern void hardlockup_detector_perf_cleanup(void);
>   extern int hardlockup_detector_perf_init(void);
> +extern void hardlockup_config_perf_event(const char *str);
>   #else
>   static inline void hardlockup_detector_perf_stop(void) { }
>   static inline void hardlockup_detector_perf_restart(void) { }
>   static inline void hardlockup_detector_perf_disable(void) { }
>   static inline void hardlockup_detector_perf_enable(void) { }
>   static inline void hardlockup_detector_perf_cleanup(void) { }
> +static inline void hardlockup_config_perf_event(const char *str) { }
>   # if !defined(CONFIG_HAVE_NMI_WATCHDOG)
>   static inline int hardlockup_detector_perf_init(void) { return -ENODEV; }
>   static inline void arch_touch_nmi_watchdog(void) {}
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 8e61f21e7e33..fed4f0be8e1a 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -81,6 +81,8 @@ static int __init hardlockup_panic_setup(char *str)
>   		nmi_watchdog_user_enabled = 0;
>   	else if (!strncmp(str, "1", 1))
>   		nmi_watchdog_user_enabled = 1;
> +	else if (!strncmp(str, "ref-cycles", 10))

str vs. 'ref-cycles' is tested here.

> +		hardlockup_config_perf_event(str);
>   	return 1;
>   }
>   __setup("nmi_watchdog=", hardlockup_panic_setup);
> diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
> index 247bf0b1582c..4deca58ba6ed 100644
> --- a/kernel/watchdog_hld.c
> +++ b/kernel/watchdog_hld.c
> @@ -294,3 +294,12 @@ int __init hardlockup_detector_perf_init(void)
>   	}
>   	return ret;
>   }
> +
> +/**
> + * hardlockup_config_perf_event - Overwrite config of wd_hw_attr
> + */
> +void __init hardlockup_config_perf_event(const char *str)
> +{
> +	if (!strncmp(str, "ref-cycles", 10))

It is unnecessarily tested again here.

> +		wd_hw_attr.config = PERF_COUNT_HW_REF_CPU_CYCLES;
> +}
