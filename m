Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE9B6279B3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbiKNJ5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiKNJ5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:57:15 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CA91F605
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:56:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BI/lF0v25Hyc6JxwUSPUdvYC1594K58im57bIwPaPsH9QkIJWekj60laMTPi8EVAK0NAc/H8BVDu5hWzL/FREmdnDsxeZvt9/knWuGEE9xfuFuLKXxkjeo6in5zY+MTr1pJ2uu8qnbyy7YBOO6cEuAwCZs1ngCFnSq4uPa+Mt0W85/m8YowCV5l4SHe0SJDmgPu/B3gdGfaG+Ns5yR7yhxyyb96dsGKtHXyNGHgkprs9VZzjQJu4pFYMnpK6OEVM7reCAvCbYoJj3OqeuY+6HBDNdF+npYdeUNkNLGjr9hNZamDwsDDumt0QGKEAPpE2akNESKZN5V5oJhd36+QZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihxfQDot/AE8PJCu/uyLvk/8N45oy5xZ73AThzc+EG4=;
 b=NpxhzcMw0GymReYSrsWbpyCc1unvFXFAcqYnd+mrce57QMNP969D+OcK0JARQFbbAA5Xw3ElLVtFli7zkkej2vhB5WIf6Jfs4ftJpZ1QAko/MnGuzHTuhoi6wAhK6v6jmCk38v7yxnWc1L1rn0m0F8Cs3Uhttu6B3JOeC7aEKFLXdrO5CbJzDs2kQeZTWYMCZ6K2Sss7NYZu0NfNZjWcliSFB1ghQeVmhzp/HOeJyf22G0hKMAA75V/6tDHz1B9gEGAeyQ0JoBeHJ/r2cMNivFpPDlfGRchGskh2owx6cv2KsLINHjQ+2mkNcRzqYRgGAKi1FOyVWzYYtyjRGPXuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihxfQDot/AE8PJCu/uyLvk/8N45oy5xZ73AThzc+EG4=;
 b=EFUr7ORYPifULE/A6OVOKY/k/uMri21xXo75Hunit5yzTp7Wws5oChMAm6Svxk5pIg8gkndYGzG3hrv/3lmdrQr0KIuMvfAhOSxZILpq1qA+qexTbuPNxoILUNDTCRwX+VAurua5lpYcu2/MAf1WMUUz5/5i9Aifogcje8oIWC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 09:56:42 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d9a6:6f94:8e92:9e20]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d9a6:6f94:8e92:9e20%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 09:56:42 +0000
Message-ID: <19d0d8c3-5488-d62a-3ac6-4100c3ab30ec@amd.com>
Date:   Mon, 14 Nov 2022 15:26:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] sched: consider WF_SYNC to find idle siblings
Content-Language: en-US
To:     Andrei Vagin <avagin@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>
References: <20221027202603.670616-1-avagin@google.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20221027202603.670616-1-avagin@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::19) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e40444-59a0-4627-6ba2-08dac62687d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJ+EE95f3sqjDhMtzUyeZ5/EFSSsbAPToq2Pqy2WGBoLFwyr2c3p0qPEH89u45K6MsUDB6xBJrqrhDf+cbByMcNRIf5dXZd4cwJqXyGz74aCUvE/8DiMqPCTyyhfep15x9u/I4305+EtqRzKsEr8sw4Co2t38nn+vbxT/Gj/Nkv6Zr+MmiDKi/S4kGZwMYee6OYjuMJZqaSKAckw+TcZ/qCWezL0XQPwSsVKqzXczqRmS7cn+y6+nXr1Nw+yiaKAmseEcW7NJ2ZNyYgR+YlWOuf48LcceRwdyuWQfBq7/9IhYR0RQaE0C7dY0vH/yOWHqFPMwGU+xz+k5JzYVHgqXztp9ZkYHJXT0U8xH13BFwfTPNzker9GM0OkFPLczPxoPpb7HJGfAdjFzDzBhkAfj7SK1S2gdv2XdwG9q/1zvBWOpeAxavAIcKuMDuMK3JoCGAo0yf1cW1JyXj5QYACSK1zCOpIsOsqKs3lYGEMPXhiQnwo2tw8MtH/SIir6okHjAFxGzZpUcUepL4a7GaHa7TYzj9+cWoJWbeMmNuDd8PQshy8tBtgwnUbPoNdGWImL4pFlMsqe8PwptZ/S3CARFZY0texFX0seJkBYKXkmR3XqE74bE8kOvBEjpM0xeDZT3RbD+d6UremOtKQma7IwOpBZZap+gjujvu+4X1SjUtY6X7cNsZYFCP1U704AijH7SBWOcqtkP1UTUdLIE4JWLLotm/Xmn+yGV0ZKZPSBJss5UPFtGAcM39SDF47dE/gxMXaX28CosWa5w15SUsYXVPB58NIoNxUOf3aoA/q1STdShslPIaBk+UW7XY0MskyEs5u5KrLQ6vQvZw125ZmksxFtMzY5yQuggQARfGwrvQClSYDOm0+2/W9M/0xLq/7B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199015)(110136005)(6666004)(54906003)(53546011)(478600001)(966005)(6486002)(36756003)(6506007)(26005)(38100700002)(186003)(6512007)(2616005)(83380400001)(31696002)(86362001)(31686004)(30864003)(7416002)(5660300002)(2906002)(8676002)(4326008)(66556008)(66946007)(66476007)(316002)(8936002)(41300700001)(37363002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2ZVajdJcXNuTkd6OS9nN3BRRVE2SmlEZVpEU3BGU3kraDM0VjVUaCswNlMw?=
 =?utf-8?B?OUo4Y2ZDWXRuMldHOEJVNnpLVS9NSm9TaU1nN1pXZ2JwMHlvUXhzNi8zV0VW?=
 =?utf-8?B?U1BJQW9kdWl6eXBHa0pJRDFRY1pXUjg3c1FSb29EdGltM2YyRmFBQjJQMXht?=
 =?utf-8?B?TmpMQXlFZ3VGQ2xSV1dHbm9MOUE1NW9IOHBMZTdaekp4MHhWQXIzZ1pxUjFi?=
 =?utf-8?B?ZWlvSFJ4dWVEYWllNGdRNmFoTEZ1RXgwSGJrNW1XaWZxeWZCTjZSWlNOQ0NZ?=
 =?utf-8?B?SkxnaG1sTmFyVFNVUjJHZ2Z1UTlwelp1Z1ZBNTBBWDZWZ2FXdy83SmlISzlu?=
 =?utf-8?B?MVNqdVozT3ZmeWpMV29FWURWQlg1ZWs3Nm9IeGg5eWFtakZCNUJzT00wZXZN?=
 =?utf-8?B?dDdMaytoL2tLb0JneVRFMzczMGo4WGFRMHkxYTFuaFhtdWZiSlRFUG9TdWhL?=
 =?utf-8?B?MWxuaWhhRzh5VkZjMmlDUWxYNmRoODlBQ2hvTFJSL29zdDlhdEh3UnordHhO?=
 =?utf-8?B?TXkvQ3puVldVSk5uQlZzNlNoZGRTdGhadGM5Y2g5My9KWjZxNStPczJ0UEdh?=
 =?utf-8?B?eTgwb0lUTFhNYkYraFJxSldEY09OZjIwMFlrci9ocmJ2ZGRSL3dtRGdHSXBF?=
 =?utf-8?B?Zng3ZFBUaFpmUHNFQzEwTDZ4QmswWmJ3ZkRobHNZV2VuVHVmSHdhTUNKb3M4?=
 =?utf-8?B?Yy9WcmVhQllDbW8vVHBYQnltVHp4THlDZ3hOM21SMWc2SUgyWGhVOS80Tk1t?=
 =?utf-8?B?Ym5uQXhUT2UxSHQ5U1BtY3JFZHYrVGJFWXlDNVZKcmErSjNrRmsyMUlBZlky?=
 =?utf-8?B?ZkNYQ2VkTk5vNFN0MlJDZjRTMVFETTkzWDduOGZOS0dRUHcwYTlZT2xEblVu?=
 =?utf-8?B?Nnk3SW1wcW1iNkJUbTNCNHhXc2VxUkxabjVHQkJTSXYwV2VuSjcwYmdLR0FN?=
 =?utf-8?B?SE9yVjY1cGVkOWJ0cDd2WEt0VC9aazNGUTVJcFhGOFFxeFVGM2JESVcvSC9k?=
 =?utf-8?B?TUxpTmJXU1BvNXZ1TUJMN2o1amdDT3VadkkzS01na0VoUVBSZUJ4bzkvNUtj?=
 =?utf-8?B?SHFXZmR5NFZQRnhjbnd3bkFUQWV5eXhBbis4SkNJbi9USmRmL3NJbVZEcmNN?=
 =?utf-8?B?Vk1rWkx6VStHN01RK2RVZjg5d2hVMnVkWFBEdDBwWXl0N0JUaEZOeWhpZUo2?=
 =?utf-8?B?NFJuRDYyS1M0Si9LQXFhdFZmdmlsMXQrZjlpZE5qb0xsNmpVdFhueHRyNUV2?=
 =?utf-8?B?bFhrU09qeVh5Ty9DTUFHblY1ZDMyUUdSa0FjM0xJdUEza0ZaWitOM2c4aWJH?=
 =?utf-8?B?dnpLbGZQRkpHMndHNkZWSkpvcjBzRW1mcVRoNnF2dmNGVUZ5N1Q4TitCaUdC?=
 =?utf-8?B?QlpuSUVCYllyZVRhQ0hDNUxBNnQvZ0V0eGVaNUpaRXozRUo0MTNoK0Q4SG9t?=
 =?utf-8?B?eVM1QUUxaUhrWGlBYlp5UFkrdWZ1UjJ5RmZ4ZGh0N3RLUWp4QjJCbkgzRGk0?=
 =?utf-8?B?dElFczdyNFZzNldiMFRvZUNjQUtsYnpIeFJ6eUVGanpEaVdqa25telFNQi9r?=
 =?utf-8?B?cU0rdkNpKzZ2MTF4d1BKQzh6RUtkN3VKd0J3V1hydVpXQnpBR2FSWXp2YzJF?=
 =?utf-8?B?SFgyMmEzVDRXMERSK1UybExuWnpLMzRMT2tTcHZtQkFDOG1IelBNaTVjU3hm?=
 =?utf-8?B?eU05dHo4OVAxeW45VlErZzRnVWtsSFhyNFROb0wxekRhVzZucVRoMnN6TXBE?=
 =?utf-8?B?SVY2TERNcDNvNXFtYmRnUi9oQTBVcmJWbVVrZEV2QnZWWUJkR1VPbDdrWnVh?=
 =?utf-8?B?bHh0V1cyM1Q1KzB2cjBTM0VpNEhTd1BsVFJYbVNiQ0FlVVZyWGlhUnB0NHhv?=
 =?utf-8?B?bXY5c0dnL0RPZGEyMHBPRlJBMzJIeEpXUDJHYndVK21KZWw0bHVnLzlwSVZs?=
 =?utf-8?B?L2RWL2RFTGcrM3ZuSTN5Nm9vUURmcHF3T0FEd2ovS3lFV3pEZ0sxMS9FMEJu?=
 =?utf-8?B?TUNCSG43QjJPdEQ3UmhFV1g5SEZxN1BQcUhrb3VhNk5JWVB1djZmYkhWUW9n?=
 =?utf-8?B?REFEMGd1aXljd2hJSE5ZemF6WTlYdVVHM1NFREtCUWVGcUo3bitSMzNQMGxH?=
 =?utf-8?Q?asyYHuBjNt9ytV6iQi7d9ycbf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e40444-59a0-4627-6ba2-08dac62687d1
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 09:56:42.0739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/3carIkRZVxT+SnkJHdakazQYu/KqyDo0pyHRHzjwCaGlHBm5PGVcL4jHC5qHAA2amAhUYTRO02hFNbys3X8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrei,

I've tested this patch on the a dual socket Zen3 system
(2 x 64C/128T)

tl;dr

o I observe consistent regression for hackbench running
  smaller number of groups.
o tbench shows improvements for smaller number of clients
  but regresses for larger client counts.

I'll leave the detailed results below:

On 10/28/2022 1:56 AM, Andrei Vagin wrote:
> From: Andrei Vagin <avagin@gmail.com>
> 
> WF_SYNC means that the waker goes to sleep after wakeup, so the current
> cpu can be considered idle if the waker is the only process that is
> running on it.
> 
> The perf pipe benchmark shows that this change reduces the average time
> per operation from 8.8 usecs/op to 3.7 usecs/op.
> 
> Before:
>  $ ./tools/perf/perf bench sched pipe
>  # Running 'sched/pipe' benchmark:
>  # Executed 1000000 pipe operations between two processes
> 
>      Total time: 8.813 [sec]
> 
>        8.813985 usecs/op
>          113456 ops/sec
> 
> After:
>  $ ./tools/perf/perf bench sched pipe
>  # Running 'sched/pipe' benchmark:
>  # Executed 1000000 pipe operations between two processes
> 
>      Total time: 3.743 [sec]
> 
>        3.743971 usecs/op
>          267096 ops/sec
>

Following are the results from running standard benchmarks on a
dual socket Zen3 (2 x 64C/128T) machine configured in different
NPS modes.

NPS Modes are used to logically divide single socket into
multiple NUMA region.
Following is the NUMA configuration for each NPS mode on the system:

NPS1: Each socket is a NUMA node.
    Total 2 NUMA nodes in the dual socket machine.

    Node 0: 0-63,   128-191
    Node 1: 64-127, 192-255

NPS2: Each socket is further logically divided into 2 NUMA regions.
    Total 4 NUMA nodes exist over 2 socket.
   
    Node 0: 0-31,   128-159
    Node 1: 32-63,  160-191
    Node 2: 64-95,  192-223
    Node 3: 96-127, 223-255

NPS4: Each socket is logically divided into 4 NUMA regions.
    Total 8 NUMA nodes exist over 2 socket.
   
    Node 0: 0-15,    128-143
    Node 1: 16-31,   144-159
    Node 2: 32-47,   160-175
    Node 3: 48-63,   176-191
    Node 4: 64-79,   192-207
    Node 5: 80-95,   208-223
    Node 6: 96-111,  223-231
    Node 7: 112-127, 232-255

Benchmark Results:

Kernel versions:
- tip:          5.19.0 tip sched/core
- sync: 	5.19.0 tip sched/core + this patch

When we started testing, the tip was at:
commit fdf756f71271 ("sched: Fix more TASK_state comparisons")

~~~~~~~~~~~~~
~ hackbench ~
~~~~~~~~~~~~~

o NPS1

Test:			tip			sync
 1-groups:	   4.06 (0.00 pct)	   4.38 (-7.88 pct)     *
 2-groups:	   4.76 (0.00 pct)	   4.91 (-3.15 pct)
 4-groups:	   5.22 (0.00 pct)	   5.03 (3.63 pct)
 8-groups:	   5.35 (0.00 pct)	   5.23 (2.24 pct)
16-groups:	   7.21 (0.00 pct)	   6.86 (4.85 pct)

o NPS2

Test:			tip			sync
 1-groups:	   4.09 (0.00 pct)	   4.39 (-7.33 pct)     *
 2-groups:	   4.70 (0.00 pct)	   4.82 (-2.55 pct)
 4-groups:	   5.05 (0.00 pct)	   4.94 (2.17 pct)
 8-groups:	   5.35 (0.00 pct)	   5.15 (3.73 pct)
16-groups:	   6.37 (0.00 pct)	   6.55 (-2.82 pct)

o NPS4

Test:			tip			sync
 1-groups:	   4.07 (0.00 pct)	   4.31 (-5.89 pct)     *
 2-groups:	   4.65 (0.00 pct)	   4.79 (-3.01 pct)
 4-groups:	   5.13 (0.00 pct)	   4.99 (2.72 pct)
 8-groups:	   5.47 (0.00 pct)	   5.51 (-0.73 pct)
16-groups:	   6.82 (0.00 pct)	   7.07 (-3.66 pct)

~~~~~~~~~~~~
~ schbench ~
~~~~~~~~~~~~

o NPS1

#workers:	tip			sync
  1:	  33.00 (0.00 pct)	  32.00 (3.03 pct)
  2:	  35.00 (0.00 pct)	  36.00 (-2.85 pct)
  4:	  39.00 (0.00 pct)	  36.00 (7.69 pct)
  8:	  49.00 (0.00 pct)	  48.00 (2.04 pct)
 16:	  63.00 (0.00 pct)	  67.00 (-6.34 pct)
 32:	 109.00 (0.00 pct)	 107.00 (1.83 pct)
 64:	 208.00 (0.00 pct)	 220.00 (-5.76 pct)
128:	 559.00 (0.00 pct)	 551.00 (1.43 pct)
256:	 45888.00 (0.00 pct)	 40512.00 (11.71 pct)
512:	 80000.00 (0.00 pct)	 79744.00 (0.32 pct)

o NPS2

#workers:	tip			sync
  1:	  30.00 (0.00 pct)	  31.00 (-3.33 pct)
  2:	  37.00 (0.00 pct)	  36.00 (2.70 pct)
  4:	  39.00 (0.00 pct)	  42.00 (-7.69 pct)
  8:	  51.00 (0.00 pct)	  47.00 (7.84 pct)
 16:	  67.00 (0.00 pct)	  67.00 (0.00 pct)
 32:	 117.00 (0.00 pct)	 113.00 (3.41 pct)
 64:	 216.00 (0.00 pct)	 228.00 (-5.55 pct)
128:	 529.00 (0.00 pct)	 531.00 (-0.37 pct)
256:	 47040.00 (0.00 pct)	 42688.00 (9.25 pct)
512:	 84864.00 (0.00 pct)	 81280.00 (4.22 pct)

o NPS4

#workers:	tip			sync
  1:	  23.00 (0.00 pct)	  34.00 (-47.82 pct)
  2:	  28.00 (0.00 pct)	  35.00 (-25.00 pct)
  4:	  41.00 (0.00 pct)	  42.00 (-2.43 pct)
  8:	  60.00 (0.00 pct)	  55.00 (8.33 pct)
 16:	  71.00 (0.00 pct)	  67.00 (5.63 pct)
 32:	 117.00 (0.00 pct)	 116.00 (0.85 pct)
 64:	 227.00 (0.00 pct)	 221.00 (2.64 pct)
128:	 545.00 (0.00 pct)	 599.00 (-9.90 pct)
256:	 45632.00 (0.00 pct)	 45760.00 (-0.28 pct)
512:	 81024.00 (0.00 pct)	 79744.00 (1.57 pct)

Note: schebench at low worker count can show large run
to run variation. Unless the regressions are unusually
large, these data points can be ignored.

~~~~~~~~~~
~ tbench ~
~~~~~~~~~~

o NPS1

Clients:	tip			sync
    1	 578.37 (0.00 pct)	 652.14 (12.75 pct)
    2	 1062.09 (0.00 pct)	 1179.10 (11.01 pct)
    4	 1800.62 (0.00 pct)	 2160.13 (19.96 pct)
    8	 3211.02 (0.00 pct)	 3705.97 (15.41 pct)
   16	 4848.92 (0.00 pct)	 5906.04 (21.80 pct)
   32	 9091.36 (0.00 pct)	 10622.56 (16.84 pct)
   64	 15454.01 (0.00 pct)	 20319.16 (31.48 pct)
  128	 3511.33 (0.00 pct)	 31631.81 (800.84 pct)  *
  128    19910.99 (0.00pct)      31631.81 (58.86 pct)   [Verification Run]
  256	 50019.32 (0.00 pct)	 39234.55 (-21.56 pct)  *
  512	 44317.68 (0.00 pct)	 38788.24 (-12.47 pct)  *
 1024	 41200.85 (0.00 pct)	 37231.35 (-9.63 pct)   *

o NPS2

Clients:	tip			sync
    1	 576.05 (0.00 pct)	 648.53 (12.58 pct)
    2	 1037.68 (0.00 pct)	 1231.59 (18.68 pct)
    4	 1818.13 (0.00 pct)	 2173.43 (19.54 pct)
    8	 3004.16 (0.00 pct)	 3636.79 (21.05 pct)
   16	 4520.11 (0.00 pct)	 5786.93 (28.02 pct)
   32	 8624.23 (0.00 pct)	 10927.48 (26.70 pct)
   64	 14886.75 (0.00 pct)	 18573.28 (24.76 pct)
  128	 20602.00 (0.00 pct)	 28635.03 (38.99 pct)
  256	 45566.83 (0.00 pct)	 36262.90 (-20.41 pct)  *
  512	 42717.49 (0.00 pct)	 35884.09 (-15.99 pct)  *
 1024	 40936.61 (0.00 pct)	 37045.24 (-9.50 pct)   *

o NPS4

Clients:	tip			sync
    1	 576.36 (0.00 pct)	 658.78 (14.30 pct)
    2	 1044.26 (0.00 pct)	 1220.65 (16.89 pct)
    4	 1839.77 (0.00 pct)	 2190.02 (19.03 pct)
    8	 3043.53 (0.00 pct)	 3582.88 (17.72 pct)
   16	 5207.54 (0.00 pct)	 5349.74 (2.73 pct)
   32	 9263.86 (0.00 pct)	 10608.17 (14.51 pct)
   64	 14959.66 (0.00 pct)	 18186.46 (21.57 pct)
  128	 20698.65 (0.00 pct)	 31209.19 (50.77 pct)
  256	 46666.21 (0.00 pct)	 38551.07 (-17.38 pct)  *
  512	 41532.80 (0.00 pct)	 37525.65 (-9.64 pct)   *
 1024	 39459.49 (0.00 pct)	 36075.96 (-8.57 pct)   *

Note: On the tested kernel, with 128 clients, tbench can
run into a bottleneck during C-state exit. More details
can be found at
https://lore.kernel.org/lkml/20220921063638.2489-1-kprateek.nayak@amd.com/
This issue has been fixed in v6.0 but was not a part of
the tip kernel when we began testing. This data point has
been rerun with C2 disabled to get representative results.

~~~~~~~~~~
~ stream ~
~~~~~~~~~~

o NPS1

-> 10 Runs:

Test:		tip			sync
 Copy:	 328419.14 (0.00 pct)	 331174.37 (0.83 pct)
Scale:	 206071.21 (0.00 pct)	 211655.02 (2.70 pct)
  Add:	 235271.48 (0.00 pct)	 240925.76 (2.40 pct)
Triad:	 253175.80 (0.00 pct)	 250029.15 (-1.24 pct)

-> 100 Runs:

Test:		tip			sync
 Copy:	 328209.61 (0.00 pct)	 316634.10 (-3.52 pct)
Scale:	 216310.13 (0.00 pct)	 211496.10 (-2.22 pct)
  Add:	 244417.83 (0.00 pct)	 237258.24 (-2.92 pct)
Triad:	 237508.83 (0.00 pct)	 247541.91 (4.22 pct)

o NPS2

-> 10 Runs:

Test:		tip			sync
 Copy:	 336503.88 (0.00 pct)	 333502.90 (-0.89 pct)
Scale:	 218035.23 (0.00 pct)	 217009.06 (-0.47 pct)
  Add:	 257677.42 (0.00 pct)	 253882.69 (-1.47 pct)
Triad:	 268872.37 (0.00 pct)	 263099.47 (-2.14 pct)

-> 100 Runs:

Test:		tip			sync
 Copy:	 332304.34 (0.00 pct)	 336798.10 (1.35 pct)
Scale:	 223421.60 (0.00 pct)	 217501.94 (-2.64 pct)
  Add:	 252363.56 (0.00 pct)	 255571.69 (1.27 pct)
Triad:	 266687.56 (0.00 pct)	 262833.28 (-1.44 pct)

o NPS4

-> 10 Runs:

Test:		tip			sync
 Copy:	 353515.62 (0.00 pct)	 335743.68 (-5.02 pct)
Scale:	 228854.37 (0.00 pct)	 237557.44 (3.80 pct)
  Add:	 254942.12 (0.00 pct)	 259415.35 (1.75 pct)
Triad:	 270521.87 (0.00 pct)	 273002.56 (0.91 pct)

-> 100 Runs:

Test:		tip			sync
 Copy:	 374520.81 (0.00 pct)	 374736.48 (0.05 pct)
Scale:	 246280.23 (0.00 pct)	 237696.80 (-3.48 pct)
  Add:	 262772.72 (0.00 pct)	 259964.95 (-1.06 pct)
Triad:	 283740.92 (0.00 pct)	 279790.28 (-1.39 pct)

~~~~~~~~~~~~~~~~~~
~ Schedstat Data ~
~~~~~~~~~~~~~~~~~~

-> Following are the schedstat data from hackbench 1-group
   and tbench 64-clients and tbench 256-clients

-> Legend for per CPU stats:

rq->yld_count:                  sched_yield count
rq->sched_count:                schedule called
rq->sched_goidle:               schedule left the processor idle
rq->ttwu_count:                 try_to_wake_up was called
rq->ttwu_local:                 try_to_wake_up was called to wake up the local cpu
rq->rq_cpu_time:                total runtime by tasks on this processor (in jiffies)
rq->rq_sched_info.run_delay:    total waittime by tasks on this processor (in jiffies)
rq->rq_sched_info.pcount:       total timeslices run on this cpu

o Hackbench - NPS1

tip:    4.069s
sync:   4.525s

------------------------------------------------------------------------------------------------------------------------------------------------------
cpu:  all_cpus (avg) vs cpu:  all_cpus (avg)
------------------------------------------------------------------------------------------------------------------------------------------------------
kernel                                                     :           tip,         sync
sched_yield count                                          :             0,            0
Legacy counter can be ignored                              :             0,            0
schedule called                                            :         27633,        25474  |  -7.81|
schedule left the processor idle                           :         11609,        10587  |  -8.80|  (   42.01,  41.56  )
try_to_wake_up was called                                  :         15991,        14807  |  -7.40|
try_to_wake_up was called to wake up the local cpu         :           473,         1630  | 244.61|  (    2.96% of total,  11.01% of total  ) <--- More wakeup on local CPU
total runtime by tasks on this processor (in jiffies)      :     252079468,    316798504  |  25.67|
total waittime by tasks on this processor (in jiffies)     :     204693750,    207418931             (   81.20,  65.47  )
total timeslices run on this cpu                           :         16020,        14884  |  -7.09|  <------------------------ The increase in runtime has a
                                                                                                                               strong correlation with
                                                                                                                               rq->rq_sched_info.pcount
------------------------------------------------------------------------------------------------------------------------------------------------------

< -----------------------------------------------------------------  Wakeup info:  ----------------------------------------------------------------- >
kernel                                                  :           tip,         sync
Wakeups on same         SMT cpus = all_cpus (avg)       :           854,          556  | -34.89|
Wakeups on same         MC cpus = all_cpus (avg)        :         12855,         8624  | -32.91|
Wakeups on same         DIE cpus = all_cpus (avg)       :          1270,         2496  |  96.54|
Wakeups on same         NUMA cpus = all_cpus (avg)      :           538,         1500  | 178.81|
Affine wakeups on same  SMT cpus = all_cpus (avg)       :           590,          512  | -13.22|
Affine wakeups on same  MC cpus = all_cpus (avg)        :          8048,         6244  | -22.42|
Affine wakeups on same  DIE cpus = all_cpus (avg)       :           641,         1712  | 167.08|
Affine wakeups on same  NUMA cpus = all_cpus (avg)      :           256,          800  | 212.50|
------------------------------------------------------------------------------------------------------------------------------------------------------

o tbench - NPS1 (64 Clients)

tip:    15674.9 MB/sec
sync:   19510.4 MB/sec (+24.46%)

------------------------------------------------------------------------------------------------------------------------------------------------------
cpu:  all_cpus (avg) vs cpu:  all_cpus (avg)
------------------------------------------------------------------------------------------------------------------------------------------------------
kernel                                                     :           tip,         sync
sched_yield count                                          :             0,            0
Legacy counter can be ignored                              :             0,            0
schedule called                                            :       3245409,      2088248  | -35.66|
schedule left the processor idle                           :       1621656,         5675  | -99.65|  (   49.97% of total,   0.27% of total)
try_to_wake_up was called                                  :       1622705,      1373295  | -15.37|
try_to_wake_up was called to wake up the local cpu         :          1075,      1369101  |127258.23|  (    0.07% of total,  99.69% of total  ) <---- In case of modified kernel
total runtime by tasks on this processor (in jiffies)      :   18612280720,  17991066483                                                              all wakeup are on the same CPU
total waittime by tasks on this processor (in jiffies)     :       7698505,   7046293108  |91428.07|  (    0.04% of total,  39.17% of total  )
total timeslices run on this cpu                           :       1623752,      2082438  |  28.25|  <----------------------------------------------- Total rq->rq_sched_info.pcount is
                                                                                                                                                      larger on the modified kernel. Strong
                                                                                                                                                      correlation with improvements in BW
------------------------------------------------------------------------------------------------------------------------------------------------------

< -----------------------------------------------------------------  Wakeup info:  ----------------------------------------------------------------- >
kernel                                                  :           tip,         sync
Wakeups on same         SMT cpus = all_cpus (avg)       :         64021,         3757  | -94.13|
Wakeups on same         MC cpus = all_cpus (avg)        :       1557597,          392  | -99.97| <-- In most case, the affine wakeup
Wakeups on same         DIE cpus = all_cpus (avg)       :             4,           18  | 350.00|     is on another CPU is same MC doamin
Wakeups on same         NUMA cpus = all_cpus (avg)      :             5,           25  | 400.00|     in case of tip kernel
Affine wakeups on same  SMT cpus = all_cpus (avg)       :         64018,         1374  | -97.85|        |
Affine wakeups on same  MC cpus = all_cpus (avg)        :       1557431,          129  | -99.99| <-------
Affine wakeups on same  DIE cpus = all_cpus (avg)       :             3,           10  | 233.33|
Affine wakeups on same  NUMA cpus = all_cpus (avg)      :             2,           14  | 600.00|
------------------------------------------------------------------------------------------------------------------------------------------------------

o tbench - NPS1 (256 Clients)

tip:    44792.6 MB/sec
sync:   36050.4 MB/sec (-19.51%)

------------------------------------------------------------------------------------------------------------------------------------------------------
cpu:  all_cpus (avg) vs cpu:  all_cpus (avg)
------------------------------------------------------------------------------------------------------------------------------------------------------
kernel                                                     :           tip,         sync
sched_yield count                                          :             3,            0  |-100.00|
Legacy counter can be ignored                              :             0,            0
schedule called                                            :       4795945,      3839616  | -19.94|
schedule left the processor idle                           :         21549,           63  | -99.71|  (    0.45,      0  )
try_to_wake_up was called                                  :       3077285,      2526474  | -17.90|
try_to_wake_up was called to wake up the local cpu         :       3055451,      2526380  | -17.32|  (   99.29,    100  ) <------ More wakeup count for tip almost all of which
total runtime by tasks on this processor (in jiffies)      :   71776758037,  71864382378                                          is on the local CPU
total waittime by tasks on this processor (in jiffies)     :   29064423457,  27994939439             (   40.49,  38.96  )
total timeslices run on this cpu                           :       4774388,      3839547  | -19.58| <---------------------------- rq->rq_sched_info.pcount is lower on newer
                                                                                                                                  kernel which has strong correlation with the B/W drop
------------------------------------------------------------------------------------------------------------------------------------------------------

< -----------------------------------------------------------------  Wakeup info:  ----------------------------------------------------------------- >
kernel                                                  :           tip,         sync
Wakeups on same         SMT cpus = all_cpus (avg)       :         19979,           78  | -99.61|
Wakeups on same         MC cpus = all_cpus (avg)        :          1848,            9  | -99.51|
Wakeups on same         DIE cpus = all_cpus (avg)       :             3,            2  | -33.33|
Wakeups on same         NUMA cpus = all_cpus (avg)      :             3,            3           
Affine wakeups on same  SMT cpus = all_cpus (avg)       :         19860,           36  | -99.82|
Affine wakeups on same  MC cpus = all_cpus (avg)        :          1758,            4  | -99.77|
Affine wakeups on same  DIE cpus = all_cpus (avg)       :             2,            1  | -50.00|
Affine wakeups on same  NUMA cpus = all_cpus (avg)      :             2,            2           
------------------------------------------------------------------------------------------------------------------------------------------------------


> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e4a0b8bd941c..40ac3cc68f5b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7245,7 +7245,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
>  	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
>  		/* Fast path */
> -		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> +		if (!sync || cpu != new_cpu || this_rq()->nr_running != 1)
> +			new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);

Adding perf stat data below which shows a larger dip in IPC for the patched
kernel as the system gets busy.

~~~~~~~~~~~~~
~ perf stat ~
~~~~~~~~~~~~~

Command: perf stat -a -e cycles -e instructions -- ./tbench_runner.sh

- tbench (NPS1)

-> 64 clients

o tip (15182 MB/sec):

18,054,464,226,798      cycles            
14,634,257,521,310      instructions #    0.81  insn per cycle      

o sync (19597.7 MB/sec [+29.08%]):

14,355,896,738,265      cycles
13,331,402,605,112      instructions #    0.93 (+14.81%)  insn per cycle  <-- Patched kernel has higher IPC
									      probably due to lesser stalls
									      with data warm at L1 and L2 cache.

-> 256 clients

o tip (51581 MB/sec):

51,719,263,738,848      cycles
34,387,747,050,053      instructions #    0.66  insn per cycle

o sync (42409 MB/sec [-17.78%]):

55,236,537,108,392      cycles
28,406,928,952,272      instructions #    0.51 (-22.72%)  insn per cycle  <-- Patched kernel has lower IPC when
									      system is busy.

>  	}
>  	rcu_read_unlock();
>  
If you would like me to run any specific workload on the
test system or gather any specific data, please let me
know.
--
Thanks and Regards,
Prateek
