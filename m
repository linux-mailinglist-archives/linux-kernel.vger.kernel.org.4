Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429B866BC40
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjAPKyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjAPKxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:53:37 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC45196A1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:53:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSNHq2SQlIzCcd0YFV5lIBfCpUuyIG3eEUZdILiq0UcDnDEfM6dbMuyd29FEN1nDoLurh7RPTRvox+H8izFCG4GtKNhNRIrxQ6sopHxn7zFMOoVbUoN5AWq2yfkZl11M2l8ORSYum3FVppEbk5ZGjE09L5rsjuCG+UO7FZpPsd7L37N/3MAsxB8CAz8o+lMr5Py9fO5fjK+Nf8axgD9PQzLwlvhyZBd7joZVHgXs2GbWNI+HRT1k8blaORzXy0vV87KkpXG3sgtl0UkCwWtJMxqBDa09GwH5giyrC4VVFhRYsPZMSg9K3KzOKfEg8FkB2vB4CTdL7ukhGVllW3lsuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwrsixnuUq9RIulz8ajnV4mw4aC2Z1nKiOgKFRksxs8=;
 b=S/ZWZkeQjtJ69GQtq8AlGi4YalBs6LT91l4KZDukeib9lZlo0AVX7BFsywG0qfKVNvWM7gzox/92TsZtSlgsf9tG8ha96T3RmR6wpHFdqs+9LSq8NXwvNlq1eOAF4B8t9eWBuYq8XG17y5vcADBhI+SP0h2q5pO39yFZSQohASjz4moVaJSiDGp63pKvdmaDtUnU4fANNRKnIHuhVDegzDziv+zCEpHGxKXm8oon/pTa6y3OZqej/iLxKS24+YVz19zBb+UKMZRI6rVtBoEsU9ZI/anFT7g+6Oerze2HLD5cIe5XWc+3Zj2BTAnIwiaHol2Df6UCWtg23wayZg7G0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwrsixnuUq9RIulz8ajnV4mw4aC2Z1nKiOgKFRksxs8=;
 b=JsYWpUJgCCY3yGcoK2RtH8pWPiJcrZZv9J2DBVs/uBhUlbou689SfQAHRj3loo+zSK5D5BhzKCiBhPger00ebHns95BqKGj1BeOOLCFAi7W+pa/znsWqTBIcjlVKhQRgG3+A+w9vUd/ct740R4zetMlKebeCLEfQlxzg1WvSE7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 10:53:32 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3c8d:4028:1920:2b41]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3c8d:4028:1920:2b41%4]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 10:53:31 +0000
Message-ID: <45b9c3e5-7ab7-0256-790e-cee92c37762d@amd.com>
Date:   Mon, 16 Jan 2023 16:23:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH v4 0/2] sched/fair: Choose the CPU where short task is
 running during wake up
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org
References: <cover.1671158588.git.yu.c.chen@intel.com>
 <105eede3-2125-5a1e-836c-954fc67f575b@amd.com>
 <Y65RNzj522d7Q3OI@chenyu5-mobl1>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <Y65RNzj522d7Q3OI@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::17) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: e9513f3a-b36d-4032-0e6e-08daf7afe7b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UrhBb2ZyN+swwCroBm/JKqVqLtMnJNDR4dNCxhHc1GLjKQvOntJp4EQpr+gd2nXiDHKFCSPw6FUoasgpZjvO/MB2ImvCahyBfpI6sTl4gkoaUnCauAa9c7ZiefpXIc09PvZBzfQPsYSZpErV0SmMtCk1eHRmemdRJyETG5U2CfwjxeaTqwa40bivsAnNYoxe5ZkuW5atC//I+DLpt4OUFxuike1VNYuiGXYfoNnEdTEtNTv0Av9VQ9N2C5sm0AkEqfe+mgo9EN2LyD0wOWDB+XVLME6ymadcn3+qq+XYoUigSspMuWo+1AL6AToKRzbIf+BXepmC/pB/NVAVeFrU6ippaXZsmgcY13tLpEVCUghu/PyL47p4JVMKvz7xCRUcdjvFDORGFX8LlHZ/B8aotU3SGw6g1dS2QUwUNo8g3tnu88Z5Eb7XtYgA6DiDVNuB1DzC6ahvXBXKj7t5Fp/OqclSdvDXe0BMn7A6u2EA2qd/A3TL6sMir8qW17gV68l3EqrRPVTzRUwW6sD6wgQBlY1EJrytUUZD9syEoIY0NAd64LEdYE2GKO0OnLIy+Q9WQT/qzPE9zaVZXOZpGR4YluIIvwSsBeOFZz9XLK2wR30yxcMcNgllWIKV8l8SRMuFKxvt7N5MsM/+9PwuUkTGj1Oy1AmluDzSNFOJbIhR5kaWcaIrv12ugEsTw+W4bqyKM6HJeSncasq1Hi0w5MAviSg5Vy74RXOQIaVa/vp8L7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199015)(38100700002)(83380400001)(8676002)(30864003)(31696002)(7416002)(4001150100001)(2906002)(5660300002)(6916009)(4326008)(66946007)(66556008)(8936002)(66476007)(41300700001)(86362001)(6512007)(186003)(6506007)(26005)(2616005)(53546011)(54906003)(478600001)(316002)(6666004)(6486002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1dSamRxeS9mclpUNXlmd2xkZFlBdFVhSUs2ME4zVTRhQ3dSeFgvZzBJeEJy?=
 =?utf-8?B?V2R4UWZVYjlJL2UrNHROT1VtMHBheHRuMWQ4MUdlckhXbTJiVS9XMW5FNDBV?=
 =?utf-8?B?ZVBWUDFFUmx3UWJHVEZlejhHbE1WRjB1UE5nTXpOa3Z0OHBHdnRqY2Vaczcz?=
 =?utf-8?B?TDlrc2ViQ1FLbWowT1BoSHR3ODRwYVV5R2dYaFpkUm9JNzRMT1RsTWY3TU4x?=
 =?utf-8?B?a3R5RGtyNzhDZUdzdlcxVjdUN1YrZE8xVWlGWVhQWkt5V2tQWHZjUWwwVXU3?=
 =?utf-8?B?SGtpTFJVdk02eHdtTGtRdzlQekRTZ0hReGlOWDlvbzM5MkM2OGVsdUpBRFBv?=
 =?utf-8?B?ZW5hUTRTcTdMWHdFVXZPdHJmbjE1eWlocEVBaGNpSXBrQUJyNmZhSkE5R0lj?=
 =?utf-8?B?bEsxMExqOENwbmp6NXVka0dtVGZpNkhtbzZhMlhtcTZUc095c3BVb1J5TmFK?=
 =?utf-8?B?MDRrQmw5VXBCazNDenNna29qL1JoMzh0UFNaV0ZCMCtBa2cvYktielRNeFpY?=
 =?utf-8?B?R1FTQlQwUWhJb0VZRTc3UVgxL0U3c2tFWVlEOUVvWUVsNlpNMWM4cnhqbXNk?=
 =?utf-8?B?RVptZ0JZNE02eDNUTU5rSUtYei9TSHhmakVWbVRGSHpCVEV1QURUMVlzbldp?=
 =?utf-8?B?VnBvbkY2anRzV2c5ZnpYZTN3M0MzQ1IxSUorcWtPVVZ6T3AxWmpRSTNOQ21E?=
 =?utf-8?B?SWNiV2ZSOStsWWU2TzNxUFdRTDZDZnI5ZVVKQmdlWm5aTnFROThraVJRSkh3?=
 =?utf-8?B?NmU2ZE1vVnNDT2VQVUlEQ0NlWDdPZXZWcC90RFcvL0puV0lIRmRDbHBTYU1C?=
 =?utf-8?B?TDJpa3lzZVdFdE1zcW1Ya3hHV2FlNENZOWxTL2NpMkU4V25QdUVyTGZTdnhF?=
 =?utf-8?B?YWxtWW1nMmc2c0ZDaVFkSHZtU3V3aWx5WWI4em5jMVNYOHVmUXRsbjhiUTl3?=
 =?utf-8?B?c1BSVXFFYnA3REZ3eVEzcnRaendiYTY2Tm1GMkRrZWo5ZHZTOS90ZG10VHRB?=
 =?utf-8?B?OVZnT3JQRzJXb3ViTVlUaEJIenNLRjFGOFVTcm9rUndYc29UMVFwYkpqbFhk?=
 =?utf-8?B?YnY2R1FPbm5aWG1wdDcvdi82NnpaVDVWeVhURldzUStrSmE4bFU0OHVXd1B6?=
 =?utf-8?B?V1hlek5rbGsrNFhPS21pK2M5cHAxcWczVlQrb0VVWHZCdGNZdUlSWEhlUEpz?=
 =?utf-8?B?K1hHMW1IQ2RqWHRGNUFwM1I2NTNOUHBMbW1jelllTGlOUklzWjVMY0ZlUEor?=
 =?utf-8?B?K3NRdHBIbklqSkhlWEhQNHJLSFJSOWZjK1NxUCsxWEdpbW1FR1JjTkN3UWlD?=
 =?utf-8?B?NUpyNS8rVXJRREpaaWVCOHAyRFlyeEd5WHJ4UjFPWW83d1pIcWVHR3g0VHZk?=
 =?utf-8?B?ZGNaL0ZQQjNsdHF0R2MzWjVwd0NUbUZvY2Y4YW9IWXBMWUE5UXR1c2lmVFp2?=
 =?utf-8?B?MzNQN3kvdVZnRUlNc1JBV01kWkNldGx0bUNNKzJCbjVqbWFnb3dibHV5ZkJY?=
 =?utf-8?B?TDBOZjFiQzFpOFBZRnpWWVF3NG55T3lXZkRXNG83MlBDZHA3Smp4djIvOUhF?=
 =?utf-8?B?SDB5SDFGYTRPUGh2K2M2VWZWWUpPNWVBd3YzbVJkVGVQL2hHc3lXYkZCdVcy?=
 =?utf-8?B?U21wVGhoaWhvTEJHNG02RXFqaVlGaUk0QXFxOStwQWlZYVY4QXdRQkx6UElM?=
 =?utf-8?B?cTFNeEE2Y25hcU53VHY3a1dydkVvaVNqSVRvcHJJT0Z2bmJ6d1AzTTcwMUJP?=
 =?utf-8?B?NFFsazFWd3poQVk2V2xWUlhWbEJjemwrSk5JUm1DMkVFemtJREU0L0hENWpy?=
 =?utf-8?B?MnphaTVFMjZBKzNmQk5CdGtxZHhUOExTVHFoemFuVUlQbXZJSlVOTXJHTElv?=
 =?utf-8?B?elNxSU5TRXl1eEVjanFFSEdrMVRZS3UrZ2EzUXF3dTRZR0hPNXk4dHNsYW0y?=
 =?utf-8?B?ei9xbzFCczdzOVFsQjVPYXcyMXlnOFYweFE2SVRRV0k5Q0ZJbTZBZEwwMmxa?=
 =?utf-8?B?ZzlxMTdOTVlReG0zQjNJRVVsVER0T1dUbEVrSHR1K0NtYnlOY21JNnJ4MU9p?=
 =?utf-8?B?bkFWZ2cxS3M2WUFuWXV5Z2Z2aEZFNG5KdHRia3c5RjJwa0FDb1VyNHJJc3Vq?=
 =?utf-8?Q?MlAf27+CkzFaqlBa0tgBwX/A/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9513f3a-b36d-4032-0e6e-08daf7afe7b1
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 10:53:31.1230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwS6rl/tTYIwVRXlUwtm2pGqcvaCexKEHDDqzCKWpXv8XhMOu60Q8kNMSD7Sc6NfzVR65vH3XdqfAKerqXNUEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

On 12/30/2022 8:17 AM, Chen Yu wrote:
> On 2022-12-29 at 12:46:59 +0530, K Prateek Nayak wrote:
>> Hello Chenyu,
>>
>> Including the detailed results from testing below.
>>
>> tl;dr
>>
>> o There seems to be 3 noticeable regressions:
>>   - tbench for lower number of clients. The schedstat data shows
>>     an increase in wait time.
>>   - SpecJBB MultiJVM performance drops as the workload prefers
>>     an idle CPU over a busy one.
>>   - Unixbench-pipe benchmark performance drops.
>>
>> o Most benchmark numbers remain same.
>>
>> o Small gains seen for ycsb-mongodb and unixbench-syscall.
>>

Please ignore the last test results. The tests did not use
exactly same config for tip and sis_short kernel which led
to more overhead in the network stack for sis_short kernel
and the longer wait time seen in sched_stat data for tbench
was a result of each loop taking longer to finish.

I reran the benchmarks on the latest tip making sure the
configs are identical this time and only notice one
regression in Spec-JBB Critical-jOPS.

tl;dr

o tbench sees good improvement in the throughput when
  the machine is fully loaded and beyond.
o Some unixbench test cases show improvement as well as
  ycsb-mongodb in NPS2 and NPS4 mode.
o Most benchmark results are same.
o SpecJBB Critical-jOPS are still down. I'll share full
  schedstat dump for tasks separately with you.

Following are the detailed results from a dual socket
Zen3 machine:

Following are the Kernel versions:

tip:            6.2.0-rc2 tip:sched/core at
                commit: bbd0b031509b "sched/rseq: Fix concurrency ID handling of usermodehelper kthreads"
sis_short:      tip + series

~~~~~~~~~~~~~
~ hackbench ~
~~~~~~~~~~~~~

o NPS1

Test:			tip			sis_short
 1-groups:	   4.36 (0.00 pct)	   4.33 (0.68 pct)
 2-groups:	   5.17 (0.00 pct)	   5.20 (-0.58 pct)
 4-groups:	   4.17 (0.00 pct)	   4.19 (-0.47 pct)
 8-groups:	   4.64 (0.00 pct)	   4.71 (-1.50 pct)
16-groups:	   5.43 (0.00 pct)	   6.60 (-21.54 pct)    * [Machine is overloaded with avg 2.5 tasks per run queue]
16-groups:	   5.90 (0.00 pct)	   5.87 (0.50 pct)    [Verification Run]

o NPS2

Test:			tip			sis_short
 1-groups:	   4.43 (0.00 pct)	   4.18 (5.64 pct)
 2-groups:	   4.61 (0.00 pct)	   4.99 (-8.24 pct)     *
 2-groups:	   4.72 (0.00 pct)	   4.74 (-0.42 pct)     [Verification Run]
 4-groups:	   4.25 (0.00 pct)	   4.20 (1.17 pct)
 8-groups:	   4.91 (0.00 pct)	   5.08 (-3.46 pct)
16-groups:	   5.84 (0.00 pct)	   5.84 (0.00 pct)

o NPS4

Test:			tip			sis_short
 1-groups:	   4.34 (0.00 pct)	   4.39 (-1.15 pct)
 2-groups:	   4.64 (0.00 pct)	   4.97 (-7.11 pct)     *
 2-groups:	   4.86 (0.00 pct)	   4.77 (1.85 pct)     [Verification Run]
 4-groups:	   4.20 (0.00 pct)	   4.26 (-1.42 pct)
 8-groups:	   5.21 (0.00 pct)	   5.19 (0.38 pct)
16-groups:	   6.24 (0.00 pct)	   5.93 (4.96 pct)

~~~~~~~~~~~~
~ schbench ~
~~~~~~~~~~~~

$ schbench -m 2 -t <workers> -s 30

o NPS1

#workers:	tip			sis_short
  1:	  36.00 (0.00 pct)	  26.00 (27.77 pct)
  2:	  37.00 (0.00 pct)	  36.00 (2.70 pct)
  4:	  37.00 (0.00 pct)	  37.00 (0.00 pct)
  8:	  47.00 (0.00 pct)	  49.00 (-4.25 pct)
 16:	  64.00 (0.00 pct)	  69.00 (-7.81 pct)
 32:	 109.00 (0.00 pct)	 118.00 (-8.25 pct)     *
 32:	 117.00 (0.00 pct)	 116.00 (0.86 pct)      [Verification Run]
 64:	 222.00 (0.00 pct)	 219.00 (1.35 pct)
128:	 515.00 (0.00 pct)	 513.00 (0.38 pct)
256:	 39744.00 (0.00 pct)	 35776.00 (9.98 pct)
512:	 81280.00 (0.00 pct)	 76672.00 (5.66 pct)

o NPS2

#workers:	tip			sis_short
  1:	  27.00 (0.00 pct)	  25.00 (7.40 pct)
  2:	  31.00 (0.00 pct)	  31.00 (0.00 pct)
  4:	  38.00 (0.00 pct)	  37.00 (2.63 pct)
  8:	  50.00 (0.00 pct)	  55.00 (-10.00 pct)
 16:	  66.00 (0.00 pct)	  66.00 (0.00 pct)
 32:	 116.00 (0.00 pct)	 119.00 (-2.58 pct)
 64:	 210.00 (0.00 pct)	 219.00 (-4.28 pct)
128:	 523.00 (0.00 pct)	 497.00 (4.97 pct)
256:	 44864.00 (0.00 pct)	 46656.00 (-3.99 pct)
512:	 78464.00 (0.00 pct)	 79488.00 (-1.30 pct)

o NPS4

#workers:	tip			sis_short
  1:	  32.00 (0.00 pct)	  34.00 (-6.25 pct)
  2:	  32.00 (0.00 pct)	  35.00 (-9.37 pct)
  4:	  34.00 (0.00 pct)	  39.00 (-14.70 pct)
  8:	  58.00 (0.00 pct)	  51.00 (12.06 pct)
 16:	  67.00 (0.00 pct)	  70.00 (-4.47 pct)
 32:	 118.00 (0.00 pct)	 123.00 (-4.23 pct)
 64:	 224.00 (0.00 pct)	 227.00 (-1.33 pct)
128:	 533.00 (0.00 pct)	 537.00 (-0.75 pct)
256:	 43456.00 (0.00 pct)	 48192.00 (-10.89 pct)  * [Machine overloaded - avg 2 tasks per run queue]
256:	 46911.59 (0.00 pct)	 47163.28 (-0.53 pct)  	[Verification Run]
512:	 78976.00 (0.00 pct)	 78976.00 (0.00 pct)


~~~~~~~~~~
~ tbench ~
~~~~~~~~~~

o NPS1

Clients:	tip			sis_short
    1	 539.96 (0.00 pct)	 532.63 (-1.35 pct)
    2	 1068.21 (0.00 pct)	 1057.35 (-1.01 pct)
    4	 1994.76 (0.00 pct)	 2015.05 (1.01 pct)
    8	 3602.30 (0.00 pct)	 3598.70 (-0.09 pct)
   16	 6075.49 (0.00 pct)	 6019.96 (-0.91 pct)
   32	 11641.07 (0.00 pct)	 11774.03 (1.14 pct)
   64	 21529.16 (0.00 pct)	 21392.97 (-0.63 pct)
  128	 30852.92 (0.00 pct)	 31355.87 (1.63 pct)
  256	 51901.20 (0.00 pct)	 54896.08 (5.77 pct)
  512	 46797.40 (0.00 pct)	 55090.07 (17.72 pct)
 1024	 46057.28 (0.00 pct)	 54374.89 (18.05 pct)

o NPS2

Clients:	tip			sis_short
    1	 536.11 (0.00 pct)	 542.14 (1.12 pct)
    2	 1044.58 (0.00 pct)	 1057.98 (1.28 pct)
    4	 2043.92 (0.00 pct)	 1981.64 (-3.04 pct)
    8	 3572.50 (0.00 pct)	 3579.03 (0.18 pct)
   16	 6040.97 (0.00 pct)	 5946.20 (-1.56 pct)
   32	 10794.10 (0.00 pct)	 11348.54 (5.13 pct)
   64	 20905.89 (0.00 pct)	 21340.31 (2.07 pct)
  128	 30885.39 (0.00 pct)	 30834.59 (-0.16 pct)
  256	 48901.25 (0.00 pct)	 51905.17 (6.14 pct)
  512	 49673.91 (0.00 pct)	 53608.18 (7.92 pct)
 1024	 47626.34 (0.00 pct)	 53396.88 (12.11 pct)

o NPS4

Clients:	tip			sis_short
    1	 544.91 (0.00 pct)	 542.78 (-0.39 pct)
    2	 1046.49 (0.00 pct)	 1057.16 (1.01 pct)
    4	 2007.11 (0.00 pct)	 2001.21 (-0.29 pct)
    8	 3590.66 (0.00 pct)	 3427.33 (-4.54 pct)
   16	 5956.60 (0.00 pct)	 5898.69 (-0.97 pct)
   32	 10431.73 (0.00 pct)	 10732.48 (2.88 pct)
   64	 21563.37 (0.00 pct)	 19141.76 (-11.23 pct)  *
   64	 21140.75 (0.00 pct)	 20883.78 (-1.21 pct)  [Verification Run]
  128	 30352.16 (0.00 pct)	 28757.44 (-5.25 pct)   *
  128	 29537.66 (0.00 pct)	 29488.04 (-0.16 pct)   [Verification Run]
  256	 49504.51 (0.00 pct)	 52492.40 (6.03 pct)
  512	 44916.61 (0.00 pct)	 52746.38 (17.43 pct)
 1024	 49986.21 (0.00 pct)	 53169.62 (6.36 pct)


~~~~~~~~~~
~ stream ~
~~~~~~~~~~

o NPS1

- 10 Runs:

Test:		tip			sis_short
 Copy:   336796.79 (0.00 pct)    336858.84 (0.01 pct)
Scale:   212768.55 (0.00 pct)    213061.98 (0.13 pct)
  Add:   244000.34 (0.00 pct)    237874.08 (-2.51 pct)
Triad:   255042.52 (0.00 pct)    250122.34 (-1.92 pct)

- 100 Runs:

Test:		tip			sis_short
 Copy:	 335938.02 (0.00 pct)	 324841.05 (-3.30 pct)
Scale:	 212597.92 (0.00 pct)	 211516.93 (-0.50 pct)
  Add:	 248294.62 (0.00 pct)	 241706.28 (-2.65 pct)
Triad:	 258400.88 (0.00 pct)	 251427.43 (-2.69 pct)

o NPS2

- 10 Runs:

Test:		tip			sis_short
 Copy:   340709.53 (0.00 pct)    338797.30 (-0.56 pct)
Scale:   216849.08 (0.00 pct)    218167.05 (0.60 pct)
  Add:   257761.46 (0.00 pct)    258717.38 (0.37 pct)
Triad:   268615.11 (0.00 pct)    270284.11 (0.62 pct)

- 100 Runs:

Test:		tip			sis_short
 Copy:	 326385.13 (0.00 pct)	 314299.63 (-3.70 pct)
Scale:	 216440.37 (0.00 pct)	 213573.71 (-1.32 pct)
  Add:	 255062.22 (0.00 pct)	 250837.63 (-1.65 pct)
Triad:	 265442.03 (0.00 pct)	 259851.69 (-2.10 pct)

o NPS4

- 10 Runs:

Test:		tip			sis_short
 Copy:   363927.86 (0.00 pct)    364556.47 (0.17 pct)
Scale:   238190.49 (0.00 pct)    245339.08 (3.00 pct)
  Add:   262806.49 (0.00 pct)    270349.31 (2.87 pct)
Triad:   276492.33 (0.00 pct)    274536.47 (-0.70 pct)

- 100 Runs:

Test:		tip			sis_short
 Copy:   369197.55 (0.00 pct)    365775.06 (-0.92 pct)
Scale:   250508.46 (0.00 pct)    251164.01 (0.26 pct)
  Add:   267792.19 (0.00 pct)    268477.42 (0.25 pct)
Triad:   280010.98 (0.00 pct)    272448.39 (-2.70 pct)


~~~~~~~~~~~~~~~~
~ ycsb-mongodb ~
~~~~~~~~~~~~~~~~

o NPS1

tip:                    131328.67 (var: 2.97%)
sis_short:              130867.33 (var: 3.23%)  (-0.35%)

o NPS2:

tip:                    132819.67 (var: 0.85%)
sis_short:              135295.33 (var: 2.02%)  (+1.86%)

o NPS4:

tip:                    134130.00 (var: 4.12%)
sis_short:              138018.67 (var: 1.92%)  (+2.89%)


~~~~~~~~~~~~~~~~~~~~~~~~~~~
~ SPECjbb MultiJVM - NPS1 ~
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Kernel			  tip		 sis_short
Max-jOPS		100.00%		  100.00%
Critical-jOPS		100.00%		   95.62%	*

~~~~~~~~~~~~~
~ unixbench ~
~~~~~~~~~~~~~

o NPS1

Test			Metric	  Parallelism			tip		      sis_short
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      48518455.50 (   0.00%)    48698507.20 (   0.37%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6268185467.60 (   0.00%)  6274727387.00 (   0.10%)
unixbench-syscall       Amean     unixbench-syscall-1        2685321.17 (   0.00%)     2701231.47 *   0.59%*
unixbench-syscall       Amean     unixbench-syscall-512      7291476.20 (   0.00%)     7886916.33 *   8.17%*
unixbench-pipe          Hmean     unixbench-pipe-1           2480858.53 (   0.00%)     2585426.98 *   4.22%*
unixbench-pipe          Hmean     unixbench-pipe-512       300739256.62 (   0.00%)   306860971.25 *   2.04%*
unixbench-spawn         Hmean     unixbench-spawn-1             4358.14 (   0.00%)        4393.55 (   0.81%)
unixbench-spawn         Hmean     unixbench-spawn-512          76497.32 (   0.00%)       76175.34 *  -0.42%*
unixbench-execl         Hmean     unixbench-execl-1             4147.12 (   0.00%)        4164.73 *   0.42%*
unixbench-execl         Hmean     unixbench-execl-512          12435.26 (   0.00%)       12669.59 (   1.88%)

o NPS2

Test			Metric	  Parallelism			tip		      sis_short
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      48872335.50 (   0.00%)    48880544.40 (   0.02%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6264134378.20 (   0.00%)  6269767014.50 (   0.09%)
unixbench-syscall       Amean     unixbench-syscall-1        2683903.13 (   0.00%)     2698851.60 *   0.56%*
unixbench-syscall       Amean     unixbench-syscall-512      7746773.60 (   0.00%)     7767971.50 (   0.27%)
unixbench-pipe          Hmean     unixbench-pipe-1           2476724.23 (   0.00%)     2587534.80 *   4.47%*
unixbench-pipe          Hmean     unixbench-pipe-512       300277350.41 (   0.00%)   306600469.40 *   2.11%*
unixbench-spawn         Hmean     unixbench-spawn-1             5026.50 (   0.00%)        4765.11 (  -5.20%)	*
unixbench-spawn         Hmean     unixbench-spawn-1             4965.80 (   0.00%)        5283.00 (   6.40%)	[Verification Run]
unixbench-spawn         Hmean     unixbench-spawn-512          80375.59 (   0.00%)       79331.12 *  -1.30%*
unixbench-execl         Hmean     unixbench-execl-1             4151.70 (   0.00%)        4139.06 (  -0.30%)
unixbench-execl         Hmean     unixbench-execl-512          13605.15 (   0.00%)       11898.26 ( -12.55%)	*
unixbench-execl         Hmean     unixbench-execl-512          12617.90 (   0.00%)       13735.00 (   8.85%)	[Verification Run]

o NPS4

Test			Metric	  Parallelism			tip		      sis_short
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      48506771.20 (   0.00%)    48886194.50 (   0.78%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6280954362.50 (   0.00%)  6289332433.50 (   0.13%)
unixbench-syscall       Amean     unixbench-syscall-1        2687259.30 (   0.00%)     2700170.93 *   0.48%*
unixbench-syscall       Amean     unixbench-syscall-512      7350275.67 (   0.00%)     7858736.83 *   6.92%*
unixbench-pipe          Hmean     unixbench-pipe-1           2478893.01 (   0.00%)     2585741.42 *   4.31%*
unixbench-pipe          Hmean     unixbench-pipe-512       301830155.61 (   0.00%)   307556537.55 *   1.90%*
unixbench-spawn         Hmean     unixbench-spawn-1             5208.55 (   0.00%)        5280.85 (   1.39%)
unixbench-spawn         Hmean     unixbench-spawn-512          80745.79 (   0.00%)       80411.55 *  -0.41%*
unixbench-execl         Hmean     unixbench-execl-1             4072.72 (   0.00%)        4152.37 *   1.96%*
unixbench-execl         Hmean     unixbench-execl-512          13746.56 (   0.00%)       13247.30 (  -3.63%)	*
unixbench-execl         Hmean     unixbench-execl-512          13797.40 (   0.00%)       13624.00 (  -1.25%)	[Verification Run]

> [..snip..]
>>
>> All numbers are with turbo and C2 enabled. I wonder if the
>> check "(5 * nr < 3 * sd->span_weight)" in v2 helped workloads
>> like tbench and SpecJBB. I'll queue some runs with the condition
>> added back and separate run with turbo and C2 disabled to see
>> if they helps. I'll update the thread once the results are in.
> Thanks for helping check if the nr part in v2 could bring the improvement
> back. However Peter seems to have concern regarding the nr check, I'll
> think about it more.

SpecJBB Critical-jOPS performance is known to suffer when tasks
queue behind each other. I'll share the data separately. I do see
the average wait_sum go up 1.3%. The Max-jOPS throughput, however,
is identical on both kernels which means sis_short does not affect
the overall throughput but only for the critical jobs, do we see
the regression due to possible queuing of tasks.

> 
> [..snip..]
>
--
Thanks and Regards,
Prateek
