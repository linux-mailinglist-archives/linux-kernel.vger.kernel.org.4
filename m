Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7FE73011D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245353AbjFNOD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbjFNODY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:03:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C418011B;
        Wed, 14 Jun 2023 07:03:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAY6DF7o+BkSaDhOeRkzC4wT2Q+jXRqC7OFTJL5W9IUBd/qOi/FVxqnjmrQHQWVhEoRHz2Ci+zAOuLO75A0nw63hCWEL+c0ya3QzEY1H3MCOIXx5UPujx0oKiB/qYX4/jdUc3J8pt8CBwdOVLNNP6dEgfDt/HJrP3Ll7Ob+xUIBriZyEZizIoEB0sYZ+BEbzhinSRRjVeylaenJ77cYwXV1InDYcXkDY0gehZw3qBvh9sUMJQtc74miD3+XZfMM6CcygXuSwgwtQqTqwbQhgUiXK6S8QmWU6tleIJJTN529Z5pFbe5DRUnnBa9f2hJRVMBIeCWnz/R6PxtvnI590HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0io+HJCBbNOPsA7U6bov4dVmPLGBV9Q7uOaLGMGHS8=;
 b=ATkB+ywTWb3Rr2OG1fBTCrCeIpQKR5inNxthdyMKEZuksyUS9Rd7T/GsFnjLCwnid89E0vAR9DO9pxclV+l08WPQU0Pcq5HW0/M6tGp8nmv2bobpx0VQcrSBWebpgPr5pvn1a0qNlGYdT8BCbex7ksF4yWGJ8fQWF8xk2+0UJy+2g+m2myYpJUNu9mxB0NwthIrv5GVjSBIHSh2ErEF8tyGTf788KxF0+gWGD5ywDJhDfHLFFO9Q5VhufAYBKh7+4oTdA+1a/YTj8Ze0r+/2ynfdv1IJDlVCDyUOmEitvELWBzzFS6K2R/k33nFSKmsKNqhubsZWN5oScNJAHQDDHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0io+HJCBbNOPsA7U6bov4dVmPLGBV9Q7uOaLGMGHS8=;
 b=AsJPWuKCaiaD2Hkrm0M6A9sftmSRwNAHg6E8QioQMyPF/Ny/McJK9EiRK5HzAxr5iDkj6P5BNpRiWLyPTPtmhnno/ba470X2GuDYL+J4CwpsxN8eqIuf2Qq32TruB5FZwO8Bf9W1N4r9KK2IEO6nps+tXqhqz0EZW8J36j4hKkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 14:03:19 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%4]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 14:03:19 +0000
Message-ID: <c721a4f1-bf25-5aca-4ae1-1dfd5041ff95@amd.com>
Date:   Wed, 14 Jun 2023 19:33:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] perf tool x86: Fix perf_env memory leak
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230613235416.1650755-1-irogers@google.com>
 <ZIkShy2yj1b0+GDv@kernel.org> <60477a13-1b8b-5aad-b635-73b9d8e3f734@amd.com>
 <ZInDzUVOyuUda7A7@kernel.org>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ZInDzUVOyuUda7A7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::20) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: 61550d75-f10c-4e38-d33f-08db6ce01b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PElv+7aWyshpEXVngJ7kB1va8cOuFV0kx1EIU5BgFsh9L4mT5Kdk9Kx9jerlZo2dk5mlKV1gObun32PR+pRBVF/Z4dgdPHZQNH5j2ZftqBGqGnmPsJZD/fKQhMG6fNPiHkEk9rQmGWC2jysEn1vGHV1STErYezxXW7/y5XFAn16Ye9CDE9y9F6iLEIhH89KopffyzyyH7+PHzF2H5z53BUF8iHz1FS7bGIkFbB3w+8qWPhiIG7qIIefqX+AEFjR5BYhUTk62lNHUJpWJo4WTBYTXaQN7YIt6DY+pZ6N/YDAdh4yD38fI+YWNHzgwPDViljcd1uWVXtBIcm8OYBFGQJ7WWnlZJdXKyQPtfEvGPVHZDZqvXfAnewQOf+jpDgnpM8MDFMxm2FsIXHjQkN+nLTsB+RB0uIJ97Cckhnr0F9coXwbY7IqvycVkzx2prBpUXMJuN9toQLUlcrIc0JMZ6O9e9oml1Rn67LrOtN5Pkc8Qbik9+s8wNu4E0V3thKxcJCcRiTRyCF5CtL7LTSeeTT6G/ojseGqlT75r/hpr4Fdxi+Nwgk9lngqGrfDmf3vGClZjMjgAYGvnm2gKDuVTis+XtJtXOOHSInExgzDRLnc/ROg1yyzra3WEZewqsvjd1UJBVmBnqrhKmVrAM21waQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199021)(6486002)(6666004)(86362001)(36756003)(83380400001)(2616005)(31696002)(38100700002)(6512007)(6506007)(26005)(53546011)(186003)(5660300002)(2906002)(54906003)(44832011)(316002)(41300700001)(8676002)(8936002)(66946007)(66556008)(6916009)(31686004)(4326008)(7416002)(66476007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTJuOXY2WXpEcHg5bWIwSGVxbTQrd1I2c2ZuUERFQmZoRHZ2Q3JydzFTaVFD?=
 =?utf-8?B?amxGVjE5dzFDNE1RdHZMMmxqZ3RpMFBsSVB2UFZRb2Q1Njd5YUI5OGRWcVMr?=
 =?utf-8?B?SVpPcnZEdlU5QlFhZ0NBUWdTZGhkWkcvcVFJeEhRdXAwaElFTncwWDBIYVRh?=
 =?utf-8?B?S2VOYi9QNUFyeWU1QTB1NFRlaDZ6Q2N1VE9DRk5RY1c3Z2V5Qk5scWM4ME5R?=
 =?utf-8?B?aHQwRXcyd2Zaa2psYjdDMy9zNEM0QkZNT29sUnRacC92UzNpUnlMZGZydmQ4?=
 =?utf-8?B?dVgxcmx1SDQweThvWmZ2QTljTWV5Wis5cUFBUG1UeHhTUFRHdGpWbVlXMWJM?=
 =?utf-8?B?aDd6ZmlBT0kxRENHdGZnYTRJWkhobnJzQWgxYjgzemhmbmc3Z3Erd2cxa0dD?=
 =?utf-8?B?aXQwWnNjNFJiaUJnKzdYcEhKR01KMzZETzB3SUpSanpaWWg1QlMvZUFFUHVh?=
 =?utf-8?B?NWtXdkNOdzQ0S0dMd2txakFZY3NpUTFEVzVIaS8wY1dTYmNTUFNhN3hsVzA1?=
 =?utf-8?B?MVNybWsvZmpEY0poN1c5cmE2QzdxYjJFQ0o3VkplSVhsbzFIOG1FeFJsdGxY?=
 =?utf-8?B?dWd1RE02NUMycHVoNVlLdmZBamxiaVhFeDhtMHhnbmw5NDl2M2pGUDJsSXBG?=
 =?utf-8?B?ZmFIUURscG92TWNMMmtSdTVOYkNQYWxpL1gwRkw2dnRPUGY4MUJGMEhYU1FH?=
 =?utf-8?B?MHNWRnFwWkM1TzhiaHYzalJTRkRRYXl6c04rbGwrNytOOHZra2xYbCtBRVV0?=
 =?utf-8?B?MnRxSHZTMVgxK1dNNURtQkNkMTFCbDh6aDFhT3BVaC9Wdll1S3VkMFhLU3pM?=
 =?utf-8?B?ME5Nd2d4bGFwRGxmaDREL0ZEL1RRMW50WmRPcldmdS9nME5xOG1rOFNmdlBS?=
 =?utf-8?B?QTdxKzNCWU9oY1BSUDdMRzFZSExIdjdTT2x4aWRmZUZlbFd4YmRPbldnOGtn?=
 =?utf-8?B?QmVPQW5BTVpnWnFNRzV5YkJ4RkRocEIzL3BTV29zNWdmK0phMTNZVm1WZ3FJ?=
 =?utf-8?B?b1lqbmNBck8zYnZRVmd2NGRzaUVTaTlndjBKL2RKZjZOWGhJaG01YkVMc1px?=
 =?utf-8?B?RW5LeVVWcTllM3h0Ymx5aHIyWGFEUHg2YUZ6b0J2NksrTlNoQWc5Z1Rja2kz?=
 =?utf-8?B?TnZRSS9mQk13VDhSbkkyRWZKRVFGUjM4VGxOSzJGOVhBRG9XOEN1UlFyQk45?=
 =?utf-8?B?TlJYU2ZMV29LalFNTDBsekZmSDY3TkhqS3lGazFGdjFWOXhmSFgxNm5YWWxz?=
 =?utf-8?B?blhGajVISWU2REovcmd4aXkzZmkvYmhpYU9HVXpCUllLak9BanpSclI4Q0hy?=
 =?utf-8?B?ZzBpRzN5NVlVRndPUTczbkVSN0tIWmMrc3NnUnNmTWFtbkdvQzQvKzJwcVZD?=
 =?utf-8?B?N25ZYVlSRmNWbFowbnZ2Vkh6bnFiME1La0sxenh1WmQ5ZElTOUptMk9yNldX?=
 =?utf-8?B?ZzRXY2xsUmxCaDNCKzVwdXdvR25TRmhmVjJRY3dWbm8rOVNnK0JzeGoveXEx?=
 =?utf-8?B?eE5EMnRicHJCQVl0V3ZMQVdOMTRxNFdna0NkRmFPejBjVDlXUkNGUThaOXBB?=
 =?utf-8?B?VnlUY1hhc1oyRFNjS1AyRUZKV0ZJNlFHOXdoR0xhZlFqTDZjb0JZM1BoOEpD?=
 =?utf-8?B?SWJmUW5XYm1taDM3M2RrdG81cHVwendDSmYyTVk2bnZKajl4T1lLMFpoc1dw?=
 =?utf-8?B?REtVbk9aUHJNMytSYklJaE5TRHdkemEwMXkvTVBEOTg0TTlvUndyN1oxeGhE?=
 =?utf-8?B?Wk5PQ2ZneFBMbTJDQ3IvTWhVaUI3NFFIOFAwZkVmd2ljTFp0MVE2YjR6a2Vi?=
 =?utf-8?B?VzcxVld6UXpKeXYzeXBXT2cyMlRiNlZvY3VHTEVFM1pVSEhCcGVWTDFZRHk4?=
 =?utf-8?B?NURUSVdxSUIzMTl4N0NCdUlaeTdXTFJoT1BzRVY5UCtuUlUwQUNRcmhPYmZW?=
 =?utf-8?B?WlQwOEl3SkdJUmlUM0huTTIyai9semEwS1JqVS9rN0JYajdQcEgwN2xoSjV3?=
 =?utf-8?B?QlhDNmhMVzNRSjNhZUdFdGlzQmxESGo2MlJxTHNnVythMDBZb1BETE1vTHl4?=
 =?utf-8?B?T1pSUUJ3aE8rMXlwVUFKdUpaSy8wdUl1ZEdDMm5va2R3UnVrOEtMeDBOVFIz?=
 =?utf-8?Q?e2gS1mE/Km2LGOnal8TJQwdtk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61550d75-f10c-4e38-d33f-08db6ce01b13
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 14:03:18.9616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgOHwhpmXwfQlXyB742xANo5GTE4TSBryNGxaF1+2n3hhAlRKQADaXA9gOpxxWrpAs2kmHbmo85wGdvBmso1+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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

On 14-Jun-23 7:12 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 14, 2023 at 08:52:43AM +0530, Ravi Bangoria escreveu:
>> On 14-Jun-23 6:36 AM, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Jun 13, 2023 at 04:54:16PM -0700, Ian Rogers escreveu:
>>>> Found by leak sanitizer:
>>>> ```
>>>> ==1632594==ERROR: LeakSanitizer: detected memory leaks
>>>>
>>>> Direct leak of 21 byte(s) in 1 object(s) allocated from:
>>>>     #0 0x7f2953a7077b in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
>>>>     #1 0x556701d6fbbf in perf_env__read_cpuid util/env.c:369
>>>>     #2 0x556701d70589 in perf_env__cpuid util/env.c:465
>>>>     #3 0x55670204bba2 in x86__is_amd_cpu arch/x86/util/env.c:14
>>>>     #4 0x5567020487a2 in arch__post_evsel_config arch/x86/util/evsel.c:83
>>>>     #5 0x556701d8f78b in evsel__config util/evsel.c:1366
>>>>     #6 0x556701ef5872 in evlist__config util/record.c:108
>>>>     #7 0x556701cd6bcd in test__PERF_RECORD tests/perf-record.c:112
>>>>     #8 0x556701cacd07 in run_test tests/builtin-test.c:236
>>>>     #9 0x556701cacfac in test_and_print tests/builtin-test.c:265
>>>>     #10 0x556701cadddb in __cmd_test tests/builtin-test.c:402
>>>>     #11 0x556701caf2aa in cmd_test tests/builtin-test.c:559
>>>>     #12 0x556701d3b557 in run_builtin tools/perf/perf.c:323
>>>>     #13 0x556701d3bac8 in handle_internal_command tools/perf/perf.c:377
>>>>     #14 0x556701d3be90 in run_argv tools/perf/perf.c:421
>>>>     #15 0x556701d3c3f8 in main tools/perf/perf.c:537
>>>>     #16 0x7f2952a46189 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
>>>>
>>>> SUMMARY: AddressSanitizer: 21 byte(s) leaked in 1 allocation(s).
>>>> ```
>>>>
>>>> Fixes: daea405f5f06 ("perf tool x86: Consolidate is_amd check into single function")
>>>
>>> Its a fix, yes, but it is not for this daea405f5f06 patch, he just moved the
>>> perf_mem_is_amd_cpu(), that was leaky, to a different file, the fixes is
>>> for  for:
>>>
>>> f7b58cbdb3ff36eb ("perf mem/c2c: Add load store event mappings for
>>> AMD").
>>>
>>> Right?
>>
>> Yeah that's correct "Fixes" commit. Thanks for the fix Ian!
> 
> Thanks, I'm taking that as an:
> 
> Acked-by: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> Ok?

Yup.

Thanks,
Ravi
