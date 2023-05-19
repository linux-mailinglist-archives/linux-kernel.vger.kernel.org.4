Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B5A70970C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjESMGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjESMGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:06:12 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341FBA0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmOQU+C6X50ttnTZ6R5l3wWKXpzh0ySpT9dz8FysS7XBxJF4lP2JXXH8ZaxqJaW++Gs9DqJl71pi8qmyAZnFc5r+SbFCuYkbD7bAYQaukeLw4KyA25/wPtGjvsosc31x9xYuqoM4Xg737EbFJtcjnM5yi7TfoJ1sWOxRJpSBJj3g3Ksk9ta/qN907C+/Z0pAzN6YjB2SOLEd05ZUshMUmeroRuqq1zPuKlb/vW6U1vidJDdN7qe1b8xZQ4ecGSGUvTFnve7p4xT3erURQT6pjuJHx4jnJP4rzcArr541qzVMBHjq+WwLWEP18sUpQDuiOH6yXRO7tuv8aCWuLfMj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+wUfYCHAjDClh2g6/xMbydrBY8ypsxiBw4YipVDX2g=;
 b=JNjCHoYURC1MrBsTpIDxL/XJo4swUEYuKoB9aSEQ3UpUwrpebVM4dWKrDG0dqICVNDSTHJ5A93Two4NdY3Cb5ClGQAbC9XjwskG0hjec/nksaoS9qFHVzDqRGk59FU5qzspVsp39mPYkTm0TdT86eMZcA9RjBo8X0cUM7X0ylIF12kwOekwvspgcKhq9bXqghbYOK6m9Kp4IPnDh0iZhCQr9mWiiE7HcCUmI5sKKUpCdTBypnusrtVhO4r9ADQvR7bha8zLnyfs3hAlK2qR5NdFkbnc5qktODtocuVEkF9O+Y5FuH/ABnykdMGw9IYNVRksz3tEYU9LJnqynrnXo4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+wUfYCHAjDClh2g6/xMbydrBY8ypsxiBw4YipVDX2g=;
 b=COtyUjv63no/Nqw3NV8bCee41WWqf8tL128kC07CvhwY7wpyeBCFE7HvTj/dtVahUilCKH302BYF0H+CA0HPjupB71eVmfnVnudVG9KP7VtjwlB5+Z6exN7DRk+xZkflvyXWGR6yFOAuSlr676xRnOaX3i7rYOhCQtNhaIREr64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 12:06:06 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::3d2c:e06a:5a1c:b1a4]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::3d2c:e06a:5a1c:b1a4%3]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 12:06:06 +0000
Message-ID: <14f8c395-9d13-dbaa-9180-46e0148556c5@amd.com>
Date:   Fri, 19 May 2023 17:35:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V2 1/1] sched/numa: Fix disjoint set vma scan
 regression
Content-Language: en-US
To:     Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Aithal Srikanth <sraithal@amd.com>,
        kernel test robot <oliver.sang@intel.com>
References: <cover.1684228065.git.raghavendra.kt@amd.com>
 <b0a8f3490b491d4fd003c3e0493e940afaea5f2c.1684228065.git.raghavendra.kt@amd.com>
 <226b9290-deea-53f5-54b3-42ee52c67e1d@amd.com>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <226b9290-deea-53f5-54b3-42ee52c67e1d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::12) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|SJ0PR12MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: effb8fae-bf5b-412d-774f-08db58616c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjDWjIDcIAJt0/yBiL1ZviY/YHAOSxmuXrGj40wDeolaDouu4EhFfVzpPR9/LpzRGE9ve6a+5DKsXYIyfjTdc1jdymqiev9IOegpj2s7I6feYf/lA+PWuxgcSbkaCxKeC3n67Q+JYwNsjyO2YRoWcpBP5fT8JdfnRIKP8kYKyEs2OkVyi+0yUdMOfuDN+SRnomhXe/5v6X+yyNuEjoI4V0A+ioMhHBJsRmXHzOFOhYntFPyK8KWKUA/sOk7KEyOXPBJteCWyGHpF/RgTxlkDfhjRcy7fsbxrrb+HW2QlNZmDDv1FLspNoBaUsfG4/ySs4yw36WSusDAceRVnNER1Gwp5eanRcE+g2bxxyubjc/sqoFpj6Bbuk4prn7uhSq0VqrT7NWN4rsR+i1O4nzC2/BheIIop6NYXhaa+NBn3EYgaQrPye9uu2knMpF8XNdlxzF/qFAi3ls3vuXkI3wruiRY1NJ9WDwHDHqw8MUlP62TRPA5JSI2RMjoWv4qzUyIu2f19n6cj6+jIme19W8K6yzYl521fs3zO0CD9AL/XOT21v6OFS5YklHPX4MPRjBCtJ0I7fo9HeCvr8+1TlTnJ51nxcdsD9UDZj1nBcOAkFk5Rqd5V213NNMQSD4WIp+yFKvKZoSUMMGzll1JEUMscSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(66556008)(66476007)(66946007)(4326008)(316002)(6666004)(6486002)(31696002)(478600001)(186003)(38100700002)(2616005)(6512007)(6506007)(26005)(53546011)(83380400001)(36756003)(54906003)(8936002)(8676002)(31686004)(2906002)(7416002)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVNTMFdtK1JORnRHMU11aDlVbGxwcmYrVHBWS3pUak9xQkgySG5pcTFHSzAw?=
 =?utf-8?B?UFpwSklYVGZUam1UOG5DSXJpK3lVZ1dQVzlzZjF6Y1RDeW12T0F1a2tLYit5?=
 =?utf-8?B?NGVuWkNiUHlxRFd0VWZ4MmFpNkJpMnZMYVJvSnZSS0szSkVIS1dRNlV6cHE3?=
 =?utf-8?B?OEE1djRIRkFqRlFIUTY1dTJObEJBRUk4ZHJhTmNNVEdBTUxaVVg0aGp5SlN6?=
 =?utf-8?B?b2Y1NnQzMXZhd1NsQTd4dEVIcHlOVFBKTVY3MnpGRmZkcjdOSTR2RE5DOHdD?=
 =?utf-8?B?NEpwaG1QSmhtTExXb0R6N3ppMGMyMkdBTC9ObXN6MHc1cjd5ellCTDZYc1dS?=
 =?utf-8?B?Ymo0Ujg4bTVOUzYvWVFOc2FMckhlcUFHVzVxaUh0UkFLbkswZ0lRbHp3TGZq?=
 =?utf-8?B?T25NVmNGUlVxelJTcUZBMHJwNDFwSXJaTGdvcll4Ykg0dlpORklHemh3OS90?=
 =?utf-8?B?cThVOFQxM0g2UFhTR2p0Ty9odTk5V05oWFo1eXozS0NlQ1hGLytqU2FUVmFH?=
 =?utf-8?B?NEc0TmMvNTNDUWlEbTVwb2lzTDZzTG52aitBVThLbzB2VVkyU3liQUlEZ2NF?=
 =?utf-8?B?MTlJdmNwL0thUU1CUzh5OEpCM0lMUFBxSGZydG5zSGxNdXVqU3BOWk1ka2lH?=
 =?utf-8?B?T0ViWXlEenV0ZUJSRmVqb0dMWVhsbUYrSk9HcC9taFRRbmsxT0I0ZjhvODRr?=
 =?utf-8?B?YXlSTllaK3Zzc05DRXdPNXNFU1Q5TUlQcWpyUTA1SHdxYnBqd2ZyWkQ2dHM3?=
 =?utf-8?B?MEFiMTl0YVEraDJaalhCYXVSN2UzcXo2NmdVWm9ocFhHQnRrdEVSbmt0YnJY?=
 =?utf-8?B?ZG1wZ2I1MDZXdFRtZGtJdXFNVm5lRGtLUk9BSFRhRVNSY0wwUEgwTXlBTXhH?=
 =?utf-8?B?T2N5eTJ5MjdTNnFrU01hek9mZmwwcVdOdytXcU9LQVlXcExwaDVtdzZCK3N5?=
 =?utf-8?B?RG9FVkQyM0hpRjdPbldZejlwY3I2cDdpYjZxYlBlVGgrVDVJTnNabEh5SjJP?=
 =?utf-8?B?aXAxQmxpQlNYOGkvYzl3Z3hOdGFndzdydk9oYzdObHFnaTByWTZZeEpUTGNI?=
 =?utf-8?B?SFN1R1VJcVRBem1iVVpqNk9DdTFVNTh5YkYrMEVELytlVFVjSndJMnJ3ZmZG?=
 =?utf-8?B?SmsrUmRHMEtKWEI4TXdIVGtPVUlNSDcvbmpJaGZqNURBSlRSdFNkNnhZZFY2?=
 =?utf-8?B?Tjg2N3o1TnNqU2pVWlVyclFETzRpTEJBKy9FZUJhSlhYVnhaUnpRQjNCQ2I2?=
 =?utf-8?B?cWhWM0FFbElkUnZxNlgwVjdqZjdGaDJ6U2RvSk1sNmZDZ3J6a2xpNkVpYVR0?=
 =?utf-8?B?RmVJT3dxTS9LVWNBU2xQbEpST0FaN1BQSkt6RjMyZ1M1bWphQUlPL25uWEZH?=
 =?utf-8?B?KzZBREJnbERWM1NFNlpQbDAxRmh2OGg3S1o3dEwxNWd3NE1yWm5zdm92dk9O?=
 =?utf-8?B?d09VeUlhSlFlVUQ1ZzhUd1pyS0dHbXkrN0F6L3JaT0YrRkF6SXhiMWNSd3lr?=
 =?utf-8?B?SDVBaHlmSUtvR2hrdVZvZlhaRExqM0FBQXZTUUxFb2h1VUQveld2UzhjSTZZ?=
 =?utf-8?B?ZXQwY3BzdWxqVENGcnJqOUR0STZ2WXUrckFCaTVCZ21EaE5jNjNqRkpVMkFU?=
 =?utf-8?B?MW1iOEh0aEEyaVlZSnpEZVQvU29kTzlZaUZZOHNyL1NHTFlhcnhYN1hGYnNz?=
 =?utf-8?B?aEdYZzV1ZVZnRE9tZUNOQWpOYTF3bnl5anZJeG5rd3RZUUszdW8yaGlreG9i?=
 =?utf-8?B?YXNNMTJCWkVWbWd1S1Y2RmxmaExnQWtOcURGUjFDM3BaY21ST2pGanJIUDVs?=
 =?utf-8?B?aHIrdEF4NDZWY1ljQndvUGxSNlZYanQ2bTNheWY4MER0SWlSbDRDa1hqaXBU?=
 =?utf-8?B?SmdJd1hzV3JVWlN5SjJFOWVGRWVoWHYvZFBhcTEyNEptaEU5Sk15cUxiS1lK?=
 =?utf-8?B?bjZ2eUxyVVRHRUc1MHVua3kvLzdnYVBUMm84UjV1VU8vdWtkWDN0QjhGdVMy?=
 =?utf-8?B?NDJLVlFGOFlLMHNiTm9oVHc0NTVSVmczLzMrWlB4QXFRRFFMcWVtNkRweHJQ?=
 =?utf-8?B?bjd0cm1ER3ZWNng3UFV5a2Y5VWE0Zk5mcHBCWng4czRWSWUra3gwUmpSaGgz?=
 =?utf-8?Q?U4NU7aeljQRFIz3C3musLtX+n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: effb8fae-bf5b-412d-774f-08db58616c58
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 12:06:05.9913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKGdeigLBCGNv5KdYdEzRz++Jebb4ISESCyKMjSQyDiNXfOITHVMtH2I21+ghcI5iaa/hIXLMVvDQcDwHivceA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8165
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/2023 1:26 PM, Bharata B Rao wrote:
> On 16-May-23 2:49 PM, Raghavendra K T wrote:
>>   With the numa scan enhancements [1], only the threads which had previously
[...]
>> -#define VMA_PID_RESET_PERIOD (4 * sysctl_numa_balancing_scan_delay)
>> +#define VMA_PID_RESET_PERIOD		(4 * sysctl_numa_balancing_scan_delay)
>> +#define DISJOINT_VMA_SCAN_RENEW_THRESH	16
>>   
>>   /*
>>    * The expensive part of numa migration is done from task_work context.
>> @@ -3058,6 +3072,8 @@ static void task_numa_work(struct callback_head *work)
>>   			/* Reset happens after 4 times scan delay of scan start */
>>   			vma->numab_state->next_pid_reset =  vma->numab_state->next_scan +
>>   				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
>> +
>> +			WRITE_ONCE(vma->numab_state->scan_counter, 0);
>>   		}
>>   
>>   		/*
>> @@ -3068,6 +3084,13 @@ static void task_numa_work(struct callback_head *work)
>>   						vma->numab_state->next_scan))
>>   			continue;
>>   
>> +		/*
>> +		 * For long running tasks, renew the disjoint vma scanning
>> +		 * periodically.
>> +		 */
>> +		if (mm->numa_scan_seq && !(mm->numa_scan_seq % DISJOINT_VMA_SCAN_RENEW_THRESH))
> 
> Don't you need a READ_ONCE() accessor for mm->numa_scan_seq?
> 

Hello Bharata,

Yes.. Thanks for pointing out.. V1 I did ensure that, But in V2 somehow
leftout :( .

On the other-hand I see vma->numab_state->scan_counter does not need
READ_ONCE/WRITE_ONCE since it is not modified out of this function
(i.e. it is all done after cmpxchg above)..

Also thinking more, DISJOINT_VMA_SCAN_RENEW_THRESH reset change itself
  may need some correction, and doesn't seem to be absolutely necessary
here. (will post that separately for improving long running benchmark as
per my experiment with more detail)

will wait for any confirmation of reported regression fix with this
  patch and/or any better idea/ack for a while and repost.
