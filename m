Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7A55F04B9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiI3GRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiI3GR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:17:26 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD57B208552;
        Thu, 29 Sep 2022 23:17:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhNNd4Y0UxrwDkY1rB+ILg7NIoN4N/Tv5gbcCFGopOCV0RLvehM6CquAscs9CFLllaU6NiCWajhIuvVCLp9ymU1YSX3rUDwTAmu04AgqcUlTpPKfvcfzGRgCIRpYdG5ZeIUYzEVpnKh5cBH4kKV5PerAckPO4RzJUWlQU4PXIQA4p7FobAjTVUTn6+cwLKe9AW4OJztWMNAGWscTkEV9LKgnHTUOaKa+JAv2qJNG2Nd56+jf67O7W+HSRUm6DBInXPAndCK+zqzhNyQKr1Et/aQOdYZqwMza0aS9681AoCLNDzZbyjp7xGfIYjFXfW7XsbHKwepAIODKSOdKbpsyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnwqAzc3kL/nCCJ98SD9o66Wz5saBH7jCUPtdCEvdOU=;
 b=FUQWS4QAWa+2uQQ5FfC9syL4YR43xwcgSo3PJipvQdDqoaX7kvZ5NAtN06W+TOdiauUypuutBzz8Q7F6FYJhqa5jVN9QYBvtK5K7ASPC2SirZAtb2+aTI3JQqZQsXxkK6YEK/M0lS4kmbcS78apgy8b7okg09esif+SLqvAIMBI3fOmYZcIETwi7+hVj75jxAVTpB/cJLttXyrrValRzIUVnJCTtUUMBsiMoZFbO4SA5WFWO4CbzVgMuuJci9o6IdJx6V7ZelzIDUkcSnYUg1m+qm+zNZnsYCF4sBJIMz0SxFNfDZvWG0I/FyGxbvfNZLpX1i0h/0SIjaqA5EFDBDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnwqAzc3kL/nCCJ98SD9o66Wz5saBH7jCUPtdCEvdOU=;
 b=RPBcMlZMhbidav5/1oeOYnb3pUnyUT34jM0Vmw+Fo9p/TKY7ih8X5U5l7/nG/shFUVyx3gh1uFlSo1HJ8ekBsQ4y087ae1UQ03hrPauyoUQLuO1lxGhLAlk2kiG0rsYoWecl2K5D8qDgorUO02fFRa+FyPpqMuDkb8Ls7hJ/N1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Fri, 30 Sep
 2022 06:17:08 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::3c18:7a48:4291:c9b]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::3c18:7a48:4291:c9b%8]) with mapi id 15.20.5654.025; Fri, 30 Sep 2022
 06:17:08 +0000
Message-ID: <09bbdae3-b0c3-c0bb-f276-b268a7bf6905@amd.com>
Date:   Fri, 30 Sep 2022 11:46:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH v3 02/15] perf/x86/amd: Add IBS OP_DATA2 DataSrc bit
 definitions
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        Leo Yan <leo.yan@linaro.org>, alisaidi@amazon.com,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        dave.hansen@linux.intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sandipan Das <sandipan.das@amd.com>, ananth.narayan@amd.com,
        Kim Phillips <kim.phillips@amd.com>, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220928095805.596-1-ravi.bangoria@amd.com>
 <20220928095805.596-3-ravi.bangoria@amd.com>
 <CAM9d7cjVcGLn+dmajox6ASxx=YQYv9Viv+wzSXdaqCEJrow56w@mail.gmail.com>
 <aa91fc2d-319c-bbb2-d011-e60f7c04d776@amd.com>
 <CAM9d7ch3gEn15g7zZOHNUcEJ0aO-Gu2+7nz9QD45+WeY0fcgyg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAM9d7ch3gEn15g7zZOHNUcEJ0aO-Gu2+7nz9QD45+WeY0fcgyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0200.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::11) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d423393-5d6c-414c-03fb-08daa2ab66cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6uKwXJYjq/hmof/iDHxW2gKh/hn3i8q2T/y/UPEil8NQxpNtLCbKat+knuD0VB7FQB7eGtY18HYbsN8xWAzC+VzDRxQxkDKG5LJ/zKdSZHxLYnKh8iKpCM9eaEiIZQn44Q2krip3kZs82npR1ri7GJJ43NYLqbvmHX9SWF2R2cgSPLk8bHAqRfZtJIewVokfWS8aZp/51PTqW4xP7EC/RbBvwq4e3/YrmzW20jWwhupgZg5cIeqIdDYrGi3ZBJY4Rnq33j7mGW0a2OyEphpS8vX6Y/dUhpY3YwhTeD2qxt/0kAcOL+Y/Arxco7kVL/1rE/24LESwwDITPnnkqXe/uYneHLyCwC3bk+wgyfQdZIWi4weVJEf40v2wyMR3SjqKT3K5uryPYVVAQO8clhJuVTIyzw5wAye655d3o7b3D63wLeAm0bDi8/+PQ+6IEe6TLCGsaYOQyTg2H9X/BgY3Bt8mX5TKkyCtvqfpbNLkOv2lDtoXfzhwK6wRy79KD+KEHCwk7wYmVE/k1B28YC0nyAawITU1FQ/I+4kOYziQlvP73a+ufi0nBNO6konpuuUL/7eTzpE79ja/jqEdTPTGvBX3uk5VhJwtQ8AKPhLezuKUcq7ZWjRaOw8Ts7yFnmndPuVosLJtrXAatGBXcfb1lG4AxuOkCU/sFfitbdKQ3QTsoNglOk72Wu3estFYMPYZJszzfEPVMUuE/Fn5WMREbUXXJG/C+nrBr7xuDCDnie7kelSF+nFsz38XtgUjpVHOhQJhZtsz+jjqastvOlo1hjLkrO4Jq5cjSIfTXWkBAGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199015)(44832011)(7416002)(5660300002)(8936002)(41300700001)(36756003)(2906002)(8676002)(66476007)(38100700002)(31686004)(66946007)(54906003)(4326008)(66556008)(6916009)(478600001)(316002)(31696002)(86362001)(6486002)(2616005)(6666004)(6506007)(186003)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEUyTmxWVGhDZ2UzaUhmTldLM3VRbE9PZFhIY1YrZEc0dDNRelJSem5FUXVs?=
 =?utf-8?B?QmhBdWR5TzYrVVZNVTE5OXN6RllMMlRKSFNVajNFSDN6ZEsvWnBSZXJ1TnlG?=
 =?utf-8?B?WlVKMitpM0dudFdka3ZDcXJpSjNTak5WeGp2cVhNVzh6b1RYTkd5QVorcWRE?=
 =?utf-8?B?aU9VcnhROXZ6bWt1b3drTVZ6V2x6cS9jQTFUU0xaa0dXT240Z2JlMHdhOGgx?=
 =?utf-8?B?Q3JaaDdsblF0aXArb2pYb2k3cG9OWTltMHFocmJkTGRIZUEzd214RWNmc1Br?=
 =?utf-8?B?Rjk0ZW5XblhYUUFOdFdkUGhlaE5ZVHoyWFRRQTIyMjNRSmZQY1AvSEVMWEhX?=
 =?utf-8?B?SGdKMVcwTVlHQ1AzTnBzU2VSeVNIUWY0MXVYWUV1M09XMlY0RXZLbEV4OGRN?=
 =?utf-8?B?OFI0eHhacEZ4d0pVZ0JTWnNHSHN3ODhLLzB3Mk1DT1BEcElHSEFLbzVtdU5K?=
 =?utf-8?B?Y2lhSXhzMndmMmR1dWVwTEUxNElTaGJlbkVZbUczTUtVZDV3R21nK2RiZS9l?=
 =?utf-8?B?MTJjb1FTWnJsNUxPTG9NR00xRU45MWl6bmpwbUtBV2FmRURqQTVHeFExRWg5?=
 =?utf-8?B?UC9uL3d6WXd5M0dYSlJ5NWQraFdNMmVmNHpJcVNDMjJZTG1QWmJZcnQ1cG5R?=
 =?utf-8?B?TnBoVFZPUGJPSmFsb3hzeGFoM012QUw1UTBDSEExY0FyYjViR2Z6RlByZXVp?=
 =?utf-8?B?OXd3RFpTSmwwc0lsWi80OU1IYlE5SEMxdzdoL1B4NVdVQjRKQWNzVjFNTjdF?=
 =?utf-8?B?NTRleFhuVUlOcktQdmVoYzJtWVEvTDJ0bXpWWWZ0VWw3K1FLYnV1dDRRYjJQ?=
 =?utf-8?B?MjlrVEJ0dFNIZWszZEx5MXRINk12dUZaV1VPTkd2Wm5SY0NYbkJDL0FMYnZn?=
 =?utf-8?B?cjVNV3NrVEo5ZUQ5UmNlNTltU0NhSDY1bnlIVVlmLzVxaXZGK2NKNlJ1K3pB?=
 =?utf-8?B?VWpXcW0zZjFsejB1bVVhOGVkUjB2WlBVL1g5andXendPVVUvSGhUU2FuWGtl?=
 =?utf-8?B?S3hEUTk5SnRqNlpWVERYT2hzSUJwRVNCMTBuNU1ibWVEN1J6dkZiRS9pRURJ?=
 =?utf-8?B?c2RLTVZzdGxNOVJMcjBMeVFsekptdnRBT2lXY2FHczR3THJ2eGVxcUdXUXp3?=
 =?utf-8?B?cFAwMWpQcTBieXFMN0ZoSzB3UkZJQStOMlVBRjZ4U1B4UkRmWVcvb1lld3Q1?=
 =?utf-8?B?Y2R6RXZCaWl6Y29LSEFjcjN0QWJGQTZ2OFhIckNCTGZNbHVNWlBiTFo2ZVJB?=
 =?utf-8?B?WVdKaE94ZUhmY2Z1YXg2NC9QV0lxdTVleWJHTldSTGYrK1ovdXZvcDN2SnZ3?=
 =?utf-8?B?WCtpcXN5cVdlM1pwbjduamk1cVlpbzVHR1FLTmlDdlVmb2hiRzZ0eTN5UDg4?=
 =?utf-8?B?MXFPUDlhazZnRzVSZUtUVVhCNW5maTVVTjNUNHhKY3VQdDFYbVJqc3lVMlJn?=
 =?utf-8?B?cHVQVysvWEo4d3FuLzRCM0NLTWN3TXlCU2pES2lGSS9waFpxSjlWRnpMamRQ?=
 =?utf-8?B?cm5iRlYweWhKSm8vbjZFTnFieVM1TVpNeWd1cTVsVXVVdmszMXQ5TlRBbmwr?=
 =?utf-8?B?Mlc3emRwY1dBd2YyNmpYeThZTEN4QS84ODFVaG5vd1VVcGRJT25BdXFLM2tV?=
 =?utf-8?B?N29FSVpJZjFOMHAveEZVZ1UydmxPeDBiQlVIamlLTm92YkVyRURmQUV4cTQ5?=
 =?utf-8?B?R3Y1VElUWjdyVW1oUTQzQytIc1Zva3M0U1lHQXp0djdmNmdxV1ZKRVRlbFl5?=
 =?utf-8?B?bnVzYzlyY2lBM2V3dExqMTVuNVl0RHB6cHIwcllmcTc0MEZheUMrMkRrbkl1?=
 =?utf-8?B?ZkRZLysvZW9LdDNqNUlzSHJxNW82ZzR3WVFwOTU4M0gxZWVXRkcrZ0h2dUt1?=
 =?utf-8?B?UkdJd1BsL04xZWhWV0NJMDMzaXBOU0E5dUJEN1dNRDU5Z2V4cTcybTF3bnIv?=
 =?utf-8?B?UlBiNnZvc1ljMjN0eGRnZ2h4cWVpbUkxbXU2ZkNJMDQra29nbEtTZkdqMTB4?=
 =?utf-8?B?RGtWUTZXMFpUa1dUUFJGbW5oMnV1U2RqZ0l0VHViZVZDZld4K3RLQjRXYUoy?=
 =?utf-8?B?ckJ5SmJyVFlyZTF1RmZ2WVFpYlppR0NGN0FyN0dySFlZYXg2cUQ2RlZBVFhL?=
 =?utf-8?Q?W0D/TbpOe1aR9pyod/fCAt48c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d423393-5d6c-414c-03fb-08daa2ab66cd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 06:17:07.8383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnCKIAUL7b/ba4ydPzjGEVtLYodqIBwdbpBAUT3RmNlMAP3uLawgDmm2tdCNTa6ku0yVowJuKHJCXm7wRW8utw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> +/* IBS_OP_DATA2 DataSrc */
>>>> +#define IBS_DATA_SRC_LOC_CACHE                  2
>>>> +#define IBS_DATA_SRC_DRAM                       3
>>>> +#define IBS_DATA_SRC_REM_CACHE                  4
>>>> +#define IBS_DATA_SRC_IO                                 7
>>>> +
>>>> +/* IBS_OP_DATA2 DataSrc Extension */
>>>> +#define IBS_DATA_SRC_EXT_LOC_CACHE              1
>>>> +#define IBS_DATA_SRC_EXT_NEAR_CCX_CACHE                 2
>>>> +#define IBS_DATA_SRC_EXT_DRAM                   3
>>>> +#define IBS_DATA_SRC_EXT_FAR_CCX_CACHE          5
>>>
>>> Is 4 undefined intentionally?
>>
>> Yes, Here is the snippet from PPR (Processor Programming Reference) doc:
>>
>>   Values | Description
>>   ---------------------------------------------------------------------
>>   0h     | No valid status.
>>   1h     | Local L3 or other L1/L2 in CCX.
>>   2h     | Another CCX cache in the same NUMA node.
>>   3h     | DRAM.
>>   4h     | Reserved.
>>   5h     | Another CCX cache in a different NUMA node.
>>   6h     | DRAM address map with "long latency" bit set.
>>   7h     | MMIO/Config/PCI/APIC.
>>   8h     | Extension Memory (S-Link, GenZ, etc - identified by the CS
>>          | target and/or address map at DF's choice).
>>   9h-Bh  | Reserved.
>>   Ch     | Peer Agent Memory.
>>   Dh-1Fh | Reserved.
> 
> Thanks for sharing it.  It's a bit confusing since it was available before.

Right, these bit definitions have changed in Zen4.

> 
> Anyway, is the PPR for Zen4 publicly available now?

Sadly, no. But it's in progress.

Thanks,
Ravi
