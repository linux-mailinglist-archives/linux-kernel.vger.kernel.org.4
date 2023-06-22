Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADEA7396D3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjFVF2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjFVF2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:28:16 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4A31AC;
        Wed, 21 Jun 2023 22:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbWOaypIBJNSNyP++1h2SmLseF/BncYpfF7d+fJVjmPaRpJkVTtfnC+v9eP5Wok9b5/qDCvXUrwMnWWMsSrABtl6h+2T4KFCRYbw0F/C0H7mggfSybtDMDVcuRgs/2DkAtONtNQoW2BpSNrDnUaUTING8WQfufvG/xuJGq9XX9R2LsbU+unMIhWbLU76NJuuMDIz5WBXKlPpb8HTQ2H1NjBi2hbjg8F9AAB3S/uzbdcr8eU/lv+7oAtChbNQ6IzGt7CTomD23X3S4DK6b0YU09NnE5zLfmLotKMGf0TtEWXT+5AgFwbMd4Ql4z/qt+CRUK2ALk+zPQxR2hkIDHPEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnKHl/kWQcv2JQe/eUH37llhBtKlm5E2+85tBZ/Hep4=;
 b=fYKR6UXCIINcH2sxFGhsMZkj8omICwzrb58gz7e2+LFUuYyrxOIH908pFvryjPWxxFqODvjJrDmPrmlcxp32NCRTfrqUzTn932RJiNu6w39Q7r4i2Bhzgdf5UBC9lIIfG/1Psx4jK2rd/NWWcaOmCFsdhKksSWXW82RogkEJAyboq5VWGfxVqGSvrVR1OxP5DBfECQnc4v38EFLZPe5I0cCm+ykJvyhJ7Y39UVUmKetWPtjU2mYkc9cU8uIk+/FEuWqFppkm25e07Ovv1aiQiGWlpqsGxl9UQ/cHwzJ3FN1YMfl5inuLOxMiXU6FGBcE5sNVCeMbkPXPg8SxXILjfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnKHl/kWQcv2JQe/eUH37llhBtKlm5E2+85tBZ/Hep4=;
 b=v33xKXBP03xMm8prr0BzTKpL7Sx2/hQtpZmdOKkL2SGhcFEwRqxNdfqDkHy+pXnqVjR8/hJAo2Y+g5YMzgVlrwqwbmuTTiKom3AbOHPhSu+c+LLREo4qZM/DgkXtxm5ou4VrxkpxZjUO7EVVC7L2+brm9J5Etp5TSBVivimmYIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 05:28:12 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 05:28:12 +0000
Message-ID: <27a64673-63f1-e438-ff17-164b008c674b@amd.com>
Date:   Thu, 22 Jun 2023 10:57:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH] perf evsel amd: Fix IBS error message
References: <3b0abd4a-6450-c282-65ff-ec0c7df67b03@amd.com>
 <20230621062359.201-1-ravi.bangoria@amd.com>
 <CAM9d7chbpiSJ6eSu9_Gs7aLZZb58gtHsvH9tsE-U4eM1eyDvKQ@mail.gmail.com>
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     acme@kernel.org, peterz@infradead.org, irogers@google.com,
        jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7chbpiSJ6eSu9_Gs7aLZZb58gtHsvH9tsE-U4eM1eyDvKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::9) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 24dddbe7-466b-48cc-d7c3-08db72e17855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vBzh73HPXRj6ALe3we5cIl7PyY88FKRTeSPP++rPoCrU+v4285btpR0ZbGN3vPqO6+RSlDST+JngXsJYeZ4bbw06wqGvE2JfFlLwgrYG+GkEF8JODYRakVLpMrno+D+tFErm5UM6oP9vtq7Fna/SpmhgE4pTNqAUtXc1aYl7mih0uq1EE+W8UoPib62ffDrBgwK1FyoqGezIbgInwoEeHdZnMfNIpqOG53nt+oK1J2TYsXSxtYtsuptSmPlngVp6NaG7BJ0ErEKm99nHBcP7pb+DLPb3BGDuRMlrcfdFKgbvbZKm3O3Km9rE4CpDRfGqZ9Ae/IKoeB2LkH3BH9ZkSXtAXc2hViZ6TPQUBtSAgmtvF4tFAtfMV5rNGAMi2utLNpZlU/w1bZabU5XEJevj65WItQp7X+wNLYdjLeryXw96pETZQ7bHpZ0100pobyhM8EoiodyyRysvxOy9L0Mb391RfeTemsPM1SqLhqy0timcnBXkeIHgO14tiWL5Hkdr+o+GhXxZQugDSfWf47Qb4+oM15OQ2iNcu2XVoQUwRK+lPPsci3hHa8qvgCq3BTn7lq2KuMRvP062ltfSOl7mY4GhWEI5KsuzNi0gPGcyP6yLQdHnVE4N5y7l2twHWjmDNNzfdYwW74QZtdYWOP7mZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199021)(6486002)(966005)(6666004)(38100700002)(83380400001)(186003)(53546011)(6512007)(6506007)(36756003)(2616005)(66476007)(316002)(6916009)(4326008)(66556008)(66946007)(2906002)(8936002)(8676002)(26005)(86362001)(44832011)(31686004)(15650500001)(5660300002)(31696002)(41300700001)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFl3cis5Q3hYWTJSRHBZQ2xCbnFDZ014M1A4OFlBdGJuWGlYS2dtSjR4bGJz?=
 =?utf-8?B?WTJ3TUhvUnZib25uVGtLb0tWbStKV1JvV0NlU1hzejJqUXdJdTlUMkNTay9Y?=
 =?utf-8?B?aUpPbkZqQ0N3Vk5Ddm1KNzJ6amU3amhLbHJHZ1hqSUt4b2dxeXpZR1VpbVBs?=
 =?utf-8?B?aklKNUJUSUdGblRIVWhPY25nNEFGUDBySUZDU1luZTA3MzI0a09LYVFBWksw?=
 =?utf-8?B?OVZ3V1Y1V3ZhUjdYZk43OWhmeTMxU0lsRHlHR1RIUFpJTytMZDZPZTh2K2po?=
 =?utf-8?B?Q0VaSS9CbUE3U1hzTm8zRDhzVHM2REg2ZHU3S1c2Q1dMRHdzWDNBMUtQVEp0?=
 =?utf-8?B?T2VjY21SeC9CSDBYbVBVYUx4VTJJVmNOSnQvampUY0Y5a2cwMGJjZ0lxUnhH?=
 =?utf-8?B?OUNCM21lMlNVV2tiQVowSUM1SE1JbGFBb0p5bWdIb3BKTWF0VDVwWTI3U2ts?=
 =?utf-8?B?MEkrUW9EZU9ZV1dJZkF2L2RkTUk1Qm10MWhRZDVFZVZTc0QvNVFjMmZjVGw5?=
 =?utf-8?B?eDRPek1BaGpEUUxXT09YanBaNjJEZUQ4SHRTZ1BiZWJYUERya0JTTC9HV0M5?=
 =?utf-8?B?TTF5VlJ6R3B2Q1VSUWN1MUtqTXdMSVNKRWhGZkR2dUZab1FONDVaa0ZVQVVn?=
 =?utf-8?B?cjRXL3JWdGEzWnVuaVFZUmxkb2huOG44RTBDWFdDZnUwU0tZMC9QaVhVTW9z?=
 =?utf-8?B?RmorVGxwbitLb0pwU3E0VXlHcWJyYkdSM3V6WHVHV1BNTUF3aGNBRCtRM2dZ?=
 =?utf-8?B?T3BVREdSRUpvWDk5L3AySjQvK2Y0SUYrUmo1T3RmbzJ3TGwxWHUydjIzMGRR?=
 =?utf-8?B?UHo1YWlJZVFJR3ZnOXZ4VzB2cnBLWlZocUpnZFh3YWxLdS9DVjNWdXAxcjA2?=
 =?utf-8?B?NFQwQjRma0JUL1c5LzRBTXdweENta0o5bFNaQ3k4Q2N0eG5PM3FveFRCclRP?=
 =?utf-8?B?Q2VMdEt4ZWl0NkI3dTMxb0VDeCt3NVdYYzJFbzhPOTBpRmNOS0locU8zM2tJ?=
 =?utf-8?B?b2p5YU16TCtIVEdLVU5Lb0VlSFpRZlZNZ2tLY0V0Sit3NlhYV2t5VFlHaC8r?=
 =?utf-8?B?b2dEWHVYSzBmVCtJdHJSbjJpdjdlNkowVHRPT1kvSzR3dStPZ1c5bG9DRXlU?=
 =?utf-8?B?RzRwMkNNa0NCRlBSQXhlL21lNUtIRHZJRzlIcW1lUDlrN3NQTzJocFdCS3l2?=
 =?utf-8?B?dUF2NHhzYUM1MGUvYlVWbjlEbFpsYWpPT2huWmdwd2Jra0M1ZFBBNnpmZksy?=
 =?utf-8?B?dFVVcEJlcVVzVjMySHZUWWF2YVVVcE1Zc0FPM2FSR2pkR3BXU2NtK0t4Rjgx?=
 =?utf-8?B?N2c1YmtkbDRGVURuY3h0OWMxQXZReDQ3a3hYRG5NWlJVUnhCSGNnc3VOWmpa?=
 =?utf-8?B?dm5GeWVhMWxXdFYvWjVJR2RERGhvQWoyY1BQTTlRMldMTzAyd2JvNVBZQU5m?=
 =?utf-8?B?OFljQ2pHNjhhTXBVKzFZZmpxbUdZc2E1Sm96NXIxS3ZNYnYxWmlPaEhhdUVP?=
 =?utf-8?B?V2xqZ3RJQWwrNlc3R0RBRSsvTnovL1VueGJRN0RXd3JOWEdjbkcyYVdrTU8w?=
 =?utf-8?B?V0FtMGtmMXJXZU8yT1RxZmphTmVRWlFIVlJLZlRZZm9OMWM3WVlMN2p2cHZB?=
 =?utf-8?B?b1dHRTVkYnFpQXdMeUE5TEpTV2Q0aFByMzVrc1dKQ3JTczByaDFaQ2ZFYm8r?=
 =?utf-8?B?bGowdjZmdUtMTll5Yk9iOUR4SDcvT0EvSWJiRFZWMWp2M1pSZDBYVU1PQ3dY?=
 =?utf-8?B?aEtSL3hVOTVRT2pWK2U0Ymo3NS9Ndmw5by9ydE9Dd09pQ0FaYzFrVFZ4QXBr?=
 =?utf-8?B?RjIxSmFSTTNlWG9aQXVPSEpiSDRCd0UycmRCT2FnMzRFTEQ1VC9KVlhiUHRr?=
 =?utf-8?B?MHJMWnFkRlI4KzkyTGVVYVVjcmpMVXJ1TjVjRGtwY0gzb0ZIZ2FMZW82cDhN?=
 =?utf-8?B?SUY4djZTZlNQSzErUGNiY3NOb28yaTFkSzMzNUN1ZmV4QzNOcVNiMzlQeWtt?=
 =?utf-8?B?NWl3MjRkZUFndldqL0kwdTBhdXhSY0drUDVWVzB5c1c4am5rT3RwUjRnaFFa?=
 =?utf-8?B?MGdRN1V0ZHloekw2cHFERFFjbzRTQXFESVd1eHpWeEt6S2tLdTExdXhBZlhq?=
 =?utf-8?Q?QKf05kWpBJESLM0syH/sDal5B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24dddbe7-466b-48cc-d7c3-08db72e17855
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 05:28:11.9026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fjIgiiapKSV4hu7167I20nUFYLj39pI48VVY53/g5PmMpN5Y4/2mtdOnnbDnf6k/4rt1N9C/Zn3JqcAxnO/AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On 22-Jun-23 4:03 AM, Namhyung Kim wrote:
> Hi Ravi,
> 
> On Tue, Jun 20, 2023 at 11:24 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> AMD IBS can do per-process profiling[1] and is no longer restricted to
>> per-cpu or systemwide only. Remove stale error message.
>>
>> Before:
>>   $ sudo ./perf record -e "{ibs_op//,ibs_op//}" -C 0
>>   Error:
>>   AMD IBS may only be available in system-wide/per-cpu mode.
>>   Try using -a, or -C and workload affinity
> 
> It was strange that the -C option was given already.

Hmm. evsel->core.system_wide is bit confusing for me. A Comment on it's
definition says "irrespective of user requested CPUs or threads":

        /*
         * system_wide is for events that need to be on every CPU, irrespective
         * of user requested CPUs or threads. Map propagation will set cpus to
         * this event's own_cpus, whereby they will contribute to evlist
         * all_cpus.
         */
        bool                     system_wide;

So, I guess evsel->core.system_wide doesn't depend on -a / -C.

> 
>>
>> After:
>>   $ sudo ./perf record -e "{ibs_op//,ibs_op//}" -C 0
>>   Error:
>>   The sys_perf_event_open() syscall returned with 22 (Invalid
>>   argument) for event (ibs_op//).
>>   /bin/dmesg | grep -i perf may provide additional information.
> 
> It can run newer perf tools on an old kernel but the old error
> message seems to be invalid anyway.  So I'm ok with removing it.

Right.

>>
>> [1] https://git.kernel.org/torvalds/c/30093056f7b2
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>  tools/perf/util/evsel.c | 10 +++-------
>>  1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index 356c07f03be6..65b0b70830f0 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -3092,14 +3092,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>>                         return scnprintf(msg, size,
>>         "Invalid event (%s) in per-thread mode, enable system wide with '-a'.",
>>                                         evsel__name(evsel));
>> -               if (is_amd(arch, cpuid)) {
>> -                       if (is_amd_ibs(evsel)) {
>> -                               if (evsel->core.attr.exclude_kernel)
>> -                                       return scnprintf(msg, size,
>> +               if (is_amd(arch, cpuid) && is_amd_ibs(evsel)) {
>> +                       if (evsel->core.attr.exclude_kernel) {
>> +                               return scnprintf(msg, size,
>>         "AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
> 
> I'm not sure if it's enough.  The IBS PMUs have CAP_NO_EXCLUDE then
> it can't exclude user events too, right?

That's correct. Let me try to fix this whole `if (is_amd())` part properly.

Thanks for your feedback,
Ravi
