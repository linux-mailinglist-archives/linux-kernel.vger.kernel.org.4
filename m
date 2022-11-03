Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A06B6183E3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbiKCQNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiKCQNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:13:12 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB5B10F2;
        Thu,  3 Nov 2022 09:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcvF2ULoYJLx1M8Nmm1kmhf0vLWx30c1vEF8YETJN9p3SFqd9UMZW5dllG9nhAtyvE0UgcpIQEvrGZ1BVwx+IQgReICpiJHXtDkYd0MSGevImHUt5RheWkVvQxHsD9Pl/icRzNDFhogYno5d7jldR03B8ZLeiZwUptx/1zPNMvn47T3+8fhvzKWJzd3KCy90ixU8xrJ34AjoOe2KSmzyEA/UZV3kJNi2acKFQxnK+OeKuCp7p7AlZ3R1RMlLCSgIy4GD8UE0IU7RUsLWr+qaDpfnwHk/sR87BfwQUcJ5sKzjdKVa+DyxI79jZKiAN/EaL3ME1UZJST4ggv5p+6X7JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlhZ2bJZoQBEjJLOWausbWUdhELHAoLKU8vP+pfVq2g=;
 b=JZfKwsyg+iTTljwJV1kn5Y1t5QlRTzChG2sMHBLycM1dfI2EIyVej0c7i7vVeixo4kz3dNZnmspMhUwgGyPDhx/j3EBn9HrgncsWJsv+SNH9Pmypl41GCjr9l/pR39qWf5KRoTZSVMcmmuG3bF5XceTAVlGNfoRnpFNhezJ31bYokZ8udZN+uOZLu1CYwui6mN81RUNuh8nHZWyhiA7zPTZrH3SbaeqRp15kejdTz9sW4xX0D8snhimOpz+IZgrnpuj6UJOqYBdMK0ShsitZqLg6VTW/8r+GhfHdtlMh0bJCf2dadZ/EJE/4TA4FQUFkNADZRPuDkGlOs+GQCE7YHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlhZ2bJZoQBEjJLOWausbWUdhELHAoLKU8vP+pfVq2g=;
 b=Fz28dejx+oAXyRQr9qcrTAIeF0YNp0l9oOUDaOxRGGGLVGFW4OeB/0LQDlubRviT9ZfBiWHWpHfgLmrkfY6Z9k9KoV05nFvCyehdCzf3595Kous3rnc1yKF1kS6/FaLdnpB8kBDeAgbwoyGHJLavJGHwsy3SA8Z1QE7cAcEUc3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SJ0PR12MB7065.namprd12.prod.outlook.com (2603:10b6:a03:4ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 16:13:10 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f397:c6b1:a8a5:55f5]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f397:c6b1:a8a5:55f5%6]) with mapi id 15.20.5791.020; Thu, 3 Nov 2022
 16:13:10 +0000
Message-ID: <f00ecc51-a387-1801-0db6-e18060c620a7@amd.com>
Date:   Thu, 3 Nov 2022 21:42:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: Perf: BUG: kernel NULL pointer dereference, address:
 0000000000000198
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Stephane Eranian <eranian@google.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <CA+G9fYtOP-spGS7gYyBB-8wpUDiKxd5e_Nk05J9gzWR_DLBeFA@mail.gmail.com>
 <4429582f-155a-04d2-d139-a834bb325612@amd.com>
 <d577887d-b86b-82be-8081-f7bebacd8067@amd.com>
 <5bec4620-2e2b-abe0-1e82-528c084d4d16@amd.com>
 <cb40c209-9c4c-f645-8454-bcd74cb72405@amd.com>
 <Y2O1GDRrJqIu17vM@hirez.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Y2O1GDRrJqIu17vM@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::18) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SJ0PR12MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b1b87e-e4d7-4626-1b44-08dabdb64cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVpnJZM+BLiE50b4N7STIWBkpE7jMhd7yDo7pVedK+Oi+Hb9N5jSMwzweC3o9W6/eYxPWu+FpaEArL0FTsCdMPql/T4M9Ad3YffjWbFkxr985RzNd/jTCvy1BkAR4XYmYvyBx1CnU6ZPzXZ027KwmWJ1FmXLKNWCnDaLbwr0+G9BTS5Il9ETh5yMOcZse9yms745+sDPOkzoaJGgiE7Eml7alPNkCO2AY8a1sxg0MFbNgznOqe0DdqI0ye+ah1bBGMrmqFpNGaB2IY4SY57oQh5SshzDcDB+9e28ZC2ef0+2zWidmheZXabCLsomwmOAFFOkus51dnKNJHiQfDlqggekZ0ID3iufG/ky3N/GmW5eppJhiz/UiGDYje8u+P2yzFzKJYNSkM/cw/OeajWKaBIZiKpWXZ4s+wG3jCB+D0g5lSg/lh1N1bvP3bzRCWO1Ph4+vcG9fx9fyMsM0HjleizwELDpfhga9+WEY8qNg9QohmyRzYbhuGkKBXP77OG6d2oDQ5YOCh2bmJBHNZIGm9dhwRKr3F5WQP1hBWXGO2ksr+7mkJbP4ojNYD2sJCtsr8f+Ybgmrs1pPD2hlG0swVHRZVVhFbBnKUEb7yHqsGfEOlfFFcKqcBjsSd4f5fzIe1axM+KvvaiZLNnx4yGm9EqHMficnapaXH1uB+zYUZPBorfd9QxgZiC0QmrsSyISNSaEL49yJA7FrQqkxFsZuqmNnlQuqpi7KYSEepxaNUNo4DxyztU6HWtlpLz8Dtx4i9PgFUuNxxADC9iNo6qRJMe72YNitO3U142Ehn6jKf5fDBoH2Y5NyC0vm7kGeH3T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199015)(66946007)(4326008)(54906003)(8676002)(66476007)(6916009)(66556008)(83380400001)(316002)(2906002)(6506007)(26005)(966005)(186003)(2616005)(6486002)(7416002)(5660300002)(36756003)(53546011)(38100700002)(31686004)(86362001)(478600001)(6512007)(31696002)(41300700001)(8936002)(6666004)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXJJQzcxN2Rkd0FyS2hGNStDbS92Z0M1VXRnbGtsRHdkQVhxWXRxZU5qRkUv?=
 =?utf-8?B?a0RYcmpZc2hxbG9zN2NVWVFFWEpnbkRMOVFpL3czOXA5Q0pCWjBmZ3NnVGY5?=
 =?utf-8?B?VFVTb0czV0ZURVUrVXArcmRMQk1vTDdNTytUa3kvV1BaTWRVVFdYWUY5emhH?=
 =?utf-8?B?bUduLzJmSkMvam1mYUk4WUovdTVnM0F3MVo0UUtnR05OYTlCY2w3UDJwV3Fw?=
 =?utf-8?B?ay9HSWRyWktsQ1dhazdaOU5HZDZaYi8rM2QzaENjR0poK2lwZVhTTDI1UDlz?=
 =?utf-8?B?Mm15ei9CeDEyUHdvQUwyM1ROaHowaGZvYUZBczZneFR1WWRCNUplaExsUU5U?=
 =?utf-8?B?M0FvZUwyMGpnUm1kcDV0K2RCMTd5QXZkY2V6RFl1aEFJekVsSnVmdk1HT2x6?=
 =?utf-8?B?ZUM2bjhPMTZ4N2E0eSs0Zm92MmxrbEV1UGhKTGgxL0VnSXJNWTJqcm12OE5i?=
 =?utf-8?B?YXh5RGxEeW1PdExCY0hJWVZuNmt6WnJPWkRiSUZydHk0bUdyWUJiZzE4ZDlU?=
 =?utf-8?B?b01zWHFPZmw5d3A3YVFJRU5lbUJIZmk1UEd6MXJENS9sUHZ4ZUwwVjVaZ2VE?=
 =?utf-8?B?VDcySDFFaG9zbmpjY0lFZVRLOWFWYThQSXBvWFlucDRoQ2lCZjc4ckFqTmVT?=
 =?utf-8?B?R1IrMzNxV2Y4aUkzbHBrMFFtbVhvVWdSdGZqdk8weEo3a3FlaWlINkNZT2l2?=
 =?utf-8?B?TlJDanlFc084eGpTbWo4THpPbzlidVRLY2VYY05LV2krdGZMbHJ3RGJPc0Y4?=
 =?utf-8?B?OVlFOWRSUS9Zd2xJS2tSMUpENVpUVDladG0ybWlBUTNnQktlT0U2dGpNMTNv?=
 =?utf-8?B?aEJXSXFOUm9FbzQ0eWhtZk1SYVhvMUMzajIrcGJNV0pvazhGRHFaVU9VVGtw?=
 =?utf-8?B?TDFmUkRYSCthTnZQUnhnZFFkTnBGcmJYVjE1cG9kMllXRk0rREp5YkNmSFJT?=
 =?utf-8?B?dlNZR0E4WFBKbTIzZk55aVVmTGJlNmVtRTBCS1hHdDJUcUxFTldzTisvaU9F?=
 =?utf-8?B?ZUZOYjUydlE1ZmEvd0V0WDRHeGhtdlF1WWV3Mk9wK3V0TS9iQ3crZ3NRci9w?=
 =?utf-8?B?dzE0WDd4QkpwVEFQWHAvYVhPaWJnSmk0cjM5UEZmaWtVRVcyNXZMSzFuZkJa?=
 =?utf-8?B?N09uWUhyOVRYUkRhV3NmQi83R1B3YktvU2N5SnNqYzEwWkNySjErYkZGemZK?=
 =?utf-8?B?a2NQcnlsSFVqYkw2OXZhTmpCTWp6R1hlcEtjaDJJaW9pSjBnM0NKcElia2E4?=
 =?utf-8?B?azNkT3RiV04xMXFkR1VkY3ZqV2J0TTZuSXBxMU5wWGo2dWxWRE5EaE9TWVJx?=
 =?utf-8?B?eTFlNWd5SzhFQjF0M0hEOFVtWW1LSjYydVZVM1REVkY4aTBrL2xHeVZVcXNW?=
 =?utf-8?B?S2NuNlJKV2UyMUlCb2o1b3kveWQ0Mk95YjYybDBxOHo2YVN2S2g1bFNhRnpt?=
 =?utf-8?B?d3U5UGRKajlCemVONkpsRVlKMGNNWm9sQ0xpTW1GV0FVaGtKNjJqaXZBbUda?=
 =?utf-8?B?MVJLNmFYbVdsTEh5V0E2cTF1ZVNQUlB3MGtMd2MzK3hTVkJLTkhRVDBCL1cv?=
 =?utf-8?B?dndPc0RIeGFDTG9RdC82aDlvMkYxL2hOYWxudExsVUd2NDRvSHo4aXg3c21N?=
 =?utf-8?B?akttdWJWZVZDbE5FaCt2S25RNnJ1RUZEMWF5VGZXYytxVW1DZXlWdXBVckF6?=
 =?utf-8?B?SjM4VnpSN0QxTEZnaXhwVXV4YnNkS0NrT0Q0dFVmeDQvcEY5M0Y3ZFlyY1lB?=
 =?utf-8?B?RkNZeWlZOXFHakdCbzdGelFwM0NmWnpicnpqNGdOdlNjSnVhTkpxK1lyQUNO?=
 =?utf-8?B?ZlIwcjhDbytLVXdnMGttekhVak1NVE9DQ09FUlNvaGY3N1lVaVBOVWdieVls?=
 =?utf-8?B?UDEzc0hyM0oreTVLaFU5T1hvLzRTM1dUMmR6azUwSmhQcGVvS0hhQk9WcktS?=
 =?utf-8?B?Z0VLZ3ByOWVrcEh4d2RYekJUWGpvSU1yY1F0K2dyMFVBdUphUnBIbkt0VjZQ?=
 =?utf-8?B?MGFDOTUwZTJBcmhLMlBjVFY5VEoxVGRaYTlITFJ1UFhpUU0rVjlKdTRXcVd1?=
 =?utf-8?B?dVpIc3ZEMFJLRGpHZ3BxS1lvcVdwK3RKTk1sclp4UEFBSDJEMGo4NXZMWmdH?=
 =?utf-8?Q?PXxz8jim+dfjm8X/RIVsZr4fM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b1b87e-e4d7-4626-1b44-08dabdb64cfa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 16:13:10.3110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YR6FwxTz+bAntxA0BRNHbQYzeLKRdhFnXvuefm4U+p7J6O3klxtNGln4/35P4Q7kprbja3BmS/PF4EwYrcekzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-Nov-22 6:03 PM, Peter Zijlstra wrote:
> On Thu, Nov 03, 2022 at 05:15:30PM +0530, Ravi Bangoria wrote:
> 
>> Sorry was distracted a bit. So, this seems to be happening because of
>> race between amd_pmu_enable_all() and perf event NMI. Something like:
>>
>>   amd_pmu_enable_all()
>>   {
>>       if (!test_bit(idx, cpuc->active_mask))
>>
>>   --->/* perf NMI entry */
>>       ...
>>       x86_pmu_stop() {
>>           __clear_bit(hwc->idx, cpuc->active_mask);
>>           cpuc->events[hwc->idx] = NULL;
>>       }
>>       ...
>>   <---/* perf NMI exit */
>>
>>       amd_pmu_enable_event(cpuc->events[idx]);
>>   }
> 
> Hmm, do you have more information?

I've extracted function graph logs from crash dump and uploaded it here:
https://github.com/BangoriaRavi/function_graph/blob/main/trace.function_graph.dat

crash was on CPU1.

> Something like that would require
> calling amd_pmu_enable_all() while it is already active -- and that
> seems suspect at first glance.
> 
> That is, you shouldn't be getting an NMI for @idx before
> amd_pmu_enable_event().

I too was wondering about this. Will try to get some more data tomorrow.

Thanks,
Ravi
