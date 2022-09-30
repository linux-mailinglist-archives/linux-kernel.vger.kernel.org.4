Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBC65F0400
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 07:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiI3FF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 01:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiI3FFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 01:05:54 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2057.outbound.protection.outlook.com [40.107.212.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E2EFF3F9;
        Thu, 29 Sep 2022 22:05:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbDVORVnW4AtaUOjzbbLjbfzwFvUClqx3ma47sDOYpqpQCY4bOVEVm8cya9qgU/cLC918xGUB/pJSkpc6W4KUKeE7wDIYDOOKEgeat/5wtfEYaGD2pnqM2lBCVjmkEWFVtPdJlhwWmPnCxCJ+k7b9aIOQp/JRQ5MPJ0Hp9kd9C0BJiX3GKfVl5X7tbVTkQnlz9m9KcSGZaCmJvkJD/Wguz0/05BHspVozmGL1Ooem3UmG41z+JFTcB5qj9mKgiuabNpKB/1+a2qLUCUjIhJxUHxriPXiUMox3Km4dkCPzuNKQMk1qWpvZW7ZiR52DhBouYCfeMg/IUoTRQ1qEkCtVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+SeaY8LOml6c2MfGUhdVYZh0S7bWrDhvxNsICO+jpc=;
 b=GqsTEERy+4Ka6SKtvd8oMLKt2mDgjwPzZEitpAQKMRVokDQOZSfafP1YSmXGmMQn8nRJ0RZnA8so3AJgCoyK8peVwcOMsby9Fz0YBXXGAGgc4fzXtYEIDXmtNfoLv3J5i49nV5dXNeJH8qDVanEQw2epoI8PFLfQNYD8qpdPjUgwM7I5a828pGYWds+Q0i12lHI5uznE3eDuncbVo4BHv5yH0hInFnCjGC0qyUiZ0qwjFeQoqQ4TVPDaUcjkvgebpTZx3S+5e2dqYQjPHML5JAzLigOYJDyYXEZdXH56+Dnk5MTZv9hwh+RhS7KGhzu+tsFjpga35LNW0+R3mkN2oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+SeaY8LOml6c2MfGUhdVYZh0S7bWrDhvxNsICO+jpc=;
 b=uWHm0Kc8BRA6LlzQENMSA8lEosHQTjVocDOly0zZrCA+PI2OkooOraOrNKmDA4RD+yJceJLr6DDki94nf9ImLQl2OZyCTR4osdQwk/U+JEvCGj1bL9+sCG1QfsqDa2LR2ux5LiBpSvKbtaZZ0S4Z8szOckH+roJXDBcQR/r0BKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 05:05:51 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::3c18:7a48:4291:c9b]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::3c18:7a48:4291:c9b%8]) with mapi id 15.20.5654.025; Fri, 30 Sep 2022
 05:05:51 +0000
Message-ID: <b630847b-eeab-5def-9e66-7352294c4a24@amd.com>
Date:   Fri, 30 Sep 2022 10:35:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 06/15] perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR
Content-Language: en-US
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
 <20220928095805.596-7-ravi.bangoria@amd.com>
 <CAM9d7cgDTZRR+eciX-4N0VZ5uoEYqikUOyiEE_hu3JTEBsONOQ@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7cgDTZRR+eciX-4N0VZ5uoEYqikUOyiEE_hu3JTEBsONOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::9) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 086ed224-23b3-4b37-1dfd-08daa2a171b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yfjihXR8Vb1cqLPBiU2DHh7IgMUD11OBiRFCYHGWxnSFg4Ui6FSiNOw4mckXnaii46wy/9kGfuJScaXnOigCLxYkr++9TvWY87jHLqDDJo0YVtTG0arNwfQgXRhYByBv0JuvMb3Yhs4DRyosJkIKVSr4ue5wnNSqCUK9zKMG7L0RbVSYhDXpaDSL5Lu8qJXLrvtOTwp+JwHXtUDqfXvFACHitvvK32kg8RYvHCQc5qicGZDCWv3IwfPW3tz0ExFT+O662ozExA4XGkATR/j3h92dox1cgP26DZd1zm5Ebb9OsD+30cyZpLOghuPWs/T7GBFJFQDQm1MzNG0T5iNXoRc143aEiHAHGcb8klktJTOSom82GoNDzxOljmMU82ohJcmhCEi0CZO3QIrAL6hX3M7aMspQdmw6aYlaqGZKPJ5H9hpBQ0znP+oydBQimu9fabUJAXjkjjMZClTRx9VrQVfNxOqEsyTjNFishTHiTYGz8lbt8WzvV7jRio0QlQleW1b1Vh0YEuF2stON3aMogtg1st0TFb3SFGdDuQgcYpZZ0irh8UMCiWO7tnjlcStTObwvQq6ob7t+/7C1ilqBsNTFHTU2+iEGRYrivCdUUfhs+klY5oR803vE6bjcwnQw9cbKSsjC/Siv3wv2UaPOsFdfPo15Syms4t/0DpuivIrFnu0/PPTF+Da0Hgd2sZwYr8hwdzr2pcCgE+6SJwTyax28+8p9+MPSdb5K1CGRSUuuXWA/VuLzjP28CgHq1zir32XylFXM92YoA/I3TItKgXIvwgLZNKD03/6noMIFgMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199015)(54906003)(2616005)(186003)(8676002)(66476007)(66556008)(66946007)(4326008)(86362001)(26005)(6666004)(6512007)(6506007)(6486002)(31696002)(478600001)(38100700002)(36756003)(6916009)(316002)(31686004)(2906002)(44832011)(4744005)(5660300002)(41300700001)(7416002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlpuVTlhS0tiaGJaZ1Q5a0NaanlrMVdPSllmYUVEVWlWWXlDc2VSZit1L3VY?=
 =?utf-8?B?U2c5US9vd0lZbkkvUjJqV2QvV3MrOHBlaW11ZWVNNTY1Uzd2akhBSHNJeW1s?=
 =?utf-8?B?MmJwRUhESlhQT2grUjNKRGhVd1pXN1pXOHY2NEdUWkJOR3VveFRMc05yNG80?=
 =?utf-8?B?QmFGOGlndnpvUUVJbHg5OG1aQTZlcUZ0b2NEODhnSHhkSHBnaS9aOTE1dGc5?=
 =?utf-8?B?WnZSa3ZwZXN3VkRmM0lyOXBSR1BGUnIvdUVYeUVUVHV1em1ET3k1aE1FZzNV?=
 =?utf-8?B?dVRiR2lBM0NFaEhCSnQza2NzK0ovWnRhb0M4dmxUYlhKVldEeDJtRlZMTWc0?=
 =?utf-8?B?MzFVbkR0WWw4OXZHUG5Pc0FiL1B6aXYrT1pPcFcrdWEwZkNxUkFhcFFMK00z?=
 =?utf-8?B?R2JuNHF1K3F4WlI4TjBFc2lBc3YwaC9OME4yRXhlQXF1akpYTDJHZEJaVElP?=
 =?utf-8?B?QzZxNEJLLzczS25yd05lS0IrVjEwQWtZYVAwQm1kWEV1bkhMb3NYalorNEpo?=
 =?utf-8?B?aWhQQkhOMWRHWkQ0MW5Vc2RNNHJDTnJGb3Y5MHkwZlgzc2tKUkYwRzRvMmF3?=
 =?utf-8?B?QU9Pc1loMkI2c2tRTVJWVmR5T25ZbmJGQ3RlSitjcGJpL2JTdlZQZzNzRWw1?=
 =?utf-8?B?Q0d4RDRnb1ltMzQyVVozUUp6aDgwWkVoV1h3bnFsYU5NSVRDeFQ2VVFaSWlM?=
 =?utf-8?B?ZFM0Rk9janBOMDkvdXpzanNIeVczRmNlMFRxbittYTdYLzRiNXppd2JaZDlL?=
 =?utf-8?B?KzJkQWc3YjBKOEpzSzBhNmVHYXZPUDlwTzNPMFNuU2ZXUW40T2dwU01UZklo?=
 =?utf-8?B?Y2hIQVhZa2xPRzYvU1NjQk93Z1VuL3l1QU1xQ2JXSkxzcGZONWQrTEpKQ1Fh?=
 =?utf-8?B?M2ZlODRnRHhiUVBaNFhiWExTTUlkN3FwY1g2UTRUUHpna1ZIcGZ5K2syamJy?=
 =?utf-8?B?dDZPeS92dGxzZWpIZE1HdlRXZWtGQ3d2S1ZjNFNEL21BaUtqZ0YrNjI2RjZG?=
 =?utf-8?B?WjZiYkxaMFhxM0xOVWJmdnpZV0h1SHo1NVBGZS95TFJhbGNDZk9kZk5wb0xJ?=
 =?utf-8?B?YmJVbDNscmxXemlFNG1JV3BJUXFrM3RlVXJ5a2Q1YXkwbW9YelFwZy9XZnhy?=
 =?utf-8?B?aDlHc1NMUjhiY2NlUGJpa0tqY2ZNTG1GWUdWMmorMXFib3ZsclFpTVl0OWpo?=
 =?utf-8?B?MDhwVytVTlhZZlY4dE5OTkZLQnlIZU04U1VHZDJCdGZ5bjV1elJQVi9FUDJR?=
 =?utf-8?B?elM3R2FScGl1TXN1ZktqaDZGWURqdzhYVzFBWFA3TmhMYzk1emJuWXU2Szlh?=
 =?utf-8?B?NjczU0VuU3B5Ynp6UWNFbjRyMWtVeVphUnROcXR2UnpyOVpMQUg4TGtmRmRw?=
 =?utf-8?B?ckx2OTJJYXJESUdkTnBxQ0VDa2FyRldGNEVxVmUrUDN3U0p6OXZEZlh6enll?=
 =?utf-8?B?WWVnN3VaSEdwMTJ2V0Fjcm9GQ2FkQUY3Sk16ekQ2ajlxdmRwa2cveGU5MWwy?=
 =?utf-8?B?SStTWVFRMk1WQngvTDZEckE3MytVWDk0MHo5ZmtlbmJrSFJXR2ZpbXJSRDFk?=
 =?utf-8?B?UDZPQUJSUVg4VmhFU3NFY29qeTg4NnZOK0V3U1BEYkxmcDlrUWJMT3J3REhG?=
 =?utf-8?B?cFp6M1FQU0d3amQ4MXl2VERaS2V5QnlMY0ZIV3dMOElyeGlpbnF0WlBLMTNG?=
 =?utf-8?B?Um5jaEtqaUM3UEY5Zk9HYmRHZHRRNUlHYWZBYVlWajdmbTB1ZGxsWU9Da1NR?=
 =?utf-8?B?Q1Y5TUZYdW1wQUszUDFJT2grcmdqS29TUUUwUzE2MktHRDdCSVFoSi9SUHBk?=
 =?utf-8?B?UGlwVUVJenhzRU9ubHllN0tpYUxFNWJFQUsyQVRDTE5vWEVRSEE0MVU1MndG?=
 =?utf-8?B?OWh3S2JHWUVMT2hHSXZpNmxpZk9ydG83REthQ0tWa1JabTJ5N1pCY0FuMnNY?=
 =?utf-8?B?Rm93aGFyWE9DVFM3MmhibzdrWHMrVTV3WmJVK0EzQ0wwWkpCRExjWmdHSzRD?=
 =?utf-8?B?MHlxMGNza3pqdlBCLzdYQis5aUloeEhtVG1HTDdCa3I4dlQ2WlVuOGp6djZq?=
 =?utf-8?B?aGFwYmtTeWZUbmQ2Qk45TnRDUytRMWQvakFZbmN0QURwUW1lNTUyNUtBcDZN?=
 =?utf-8?Q?XHRze5Lv28QRSs84OdJ/IEt8d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086ed224-23b3-4b37-1dfd-08daa2a171b3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 05:05:50.8594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Vuif5wIYEAR+t7E1ShT6RzjtsSkF+e4VYZmFmSrPWX5j908xUZwvB+9A6xDR2m6SX0EQsrmbOFoYStMDuInOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index e1ffdb861b53..49bc3b5e6c8a 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -7435,7 +7435,8 @@ void perf_prepare_sample(struct perf_event_header *header,
>>                 header->size += size;
>>         }
>>
>> -       if (sample_type & PERF_SAMPLE_PHYS_ADDR)
>> +       if (sample_type & PERF_SAMPLE_PHYS_ADDR &&
>> +           filtered_sample_type & PERF_SAMPLE_PHYS_ADDR)
> 
> It'd be enough to check the filtered_sample_type only.

+1. Will fix it.

Thanks,
Ravi
