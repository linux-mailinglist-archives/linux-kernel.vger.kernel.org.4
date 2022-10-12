Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2575FC7F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiJLPIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJLPH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:07:58 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F48AE201
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLv3zAc2vQ0eXMM879o6b/bCk//LrThPsYqM6rD/BRc76ZQqSus9ZhJacYaHDySzN0OPbONgGGTfqkrjytFjor1VUDZPQ9DAaIw1wuatYgpOCEmDp60w4shP1A6hRtN727WiKjGX6tdSAZsswSehCDLRifQlwHWXXeJXg9hAKd7jwqg5OH9e8flvw8JvmOjw3xlMDiTGUsTr8YTv97vGmd6JNTjCKPJX3kfasdGxLbNiDCg43ghrtNHxO3yaXeSMJlsLw0MjwYGTw6Tddsrd9fRKlDDI3DBjiS0uQ4PnHMRlvOc/ZuNAmZQczdJU9pXvdFuRWhYwFTBA+MeSPlkxlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DK68r0y9ktOsRJ7mkl2VF6pgWY1GAT5DRAmGALW/Q8A=;
 b=Gg7fi+pH0PUimJVCDNppWvfSyq3cny96Nov0Ng92ip4UHE/ssHjK0O1pB3pF3j72UoyEfka3sHm5pwB/nAOvg4pOPVsLKKydW7lMtNB0PMMoG9kELs8ChupKCQSCQTUu3/KspJaGdlLELXirXdRQ7zs5QgH+pAsSOwz4bzWVXV+vu1N/AYDlPvbC1xLhqZ6n1C9E0j5ZyRy2z7cyN0ieE0UsFAdtMVZYgB+QNHZIu+YEAVILk/jS4lBD3AYZga5KMbmDTLN3galKaN5ZejjCI5HLkCvaKRRkncKUm9dGMfhoRSZGyN9Nk8L8J4Hcif3NjOCbKTmi4UzJ6T+S2pGosQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DK68r0y9ktOsRJ7mkl2VF6pgWY1GAT5DRAmGALW/Q8A=;
 b=5iWNbc2D3QqJt7WDP332YyWxkRGAbFulzLhx/mERlbVVoWLQNnYEpi6YmKptS9o3yo0DGFEigs+mcEgowWWEzeE0kDQB8MkItoI7/H5RUqTqXo01o+cQerIJKda56uHj8FePGdp0QVhcbq2wYmViz9vWdIh606MYHUcajLiVM6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 15:07:54 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2e7d:cda3:bb38:a1ce]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2e7d:cda3:bb38:a1ce%6]) with mapi id 15.20.5723.022; Wed, 12 Oct 2022
 15:07:54 +0000
Message-ID: <4d23ef51-6bb9-0410-77cf-5fe44173eee7@amd.com>
Date:   Wed, 12 Oct 2022 20:37:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 3/7] sched: Allow sched_{get,set}attr to change
 latency_nice of the task
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
 <20220925143908.10846-4-vincent.guittot@linaro.org>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220925143908.10846-4-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::16) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 4084b071-bc9c-48e3-4620-08daac63899b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S8fletRfAQjFLsSrvdzcgUf6wg5Ma3xZTlsSsLsI/S/hD37eoiE0ow43FI4zstVNB+ZRkCkWAEbhXbQvirIMaozOp88mJbK/xCjloirbtaJlilGXerjO1CSHG0g6dhGwEYVxdB7N0nQs6jq/eJ56DwNt8yJI269oaSslcsrJ4IKelbGXMJ2xOPKSkyruTaDFkpsSojrd4VIodKmjjFfvbQqiAF2teF8XqjA8lQ62onppRmev03KnwZvt0VblbxWXd9XdU8Kol4k49vClrGdL4TuwfSHLmYDc6LJzMpVDJwh39CIWh2cTPDNCgPyQZd/LunnsVS2I84SJExK2xiBnC/Ichm/LeZ2KuxBUnQbvmGjDb/KbS/6U3A4L5D3KyR9242mSADmLxxbcmmUC/L31YiHy19tQYaw/HyqRKmXyaFqHHfeA/AApWSJsiQhgto26j5kt9XHMSWSFAM5LW2J9hYWf0W0cnq0DpxDRq7pKbr2VAO9qdBfn0rRn2pWv9iDVlA2HdRwesMXbCFF+r3oXp7htz+Uws+A2Kp1JQA2WFtbBWaTapMk46tlBMygyLq1pvfPpgoUdhfLuv6zXuPqLI1VGAyLOR94xE+r+4kryioA3GZ1krKf0SGsoB7agr3fgK2sd8+4M58EWEbsOfBoy6iA9wOfTW0rdNtB0CU+bEHCngdT50T6F0bbVOZfSukz3XOjCQ2gy6RZdL4Tl5lTK8Tfwr/KwKFvyzrv3PlaxvR0hb/eK1HtRo7ME+kbSqEbFIxOav/k6kXCKw5ZbU59FVwdE93OogzJ2uMtCrJnJ9u3oks0DnvhtJOhlvEBgmwkukz+Sku/M6Kk6440juUUTNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199015)(4326008)(36756003)(86362001)(316002)(31696002)(66476007)(66556008)(66946007)(31686004)(38100700002)(921005)(83380400001)(6512007)(6506007)(7416002)(53546011)(26005)(6666004)(8676002)(6486002)(41300700001)(5660300002)(2906002)(4001150100001)(186003)(8936002)(2616005)(478600001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHBlYjdyMkRYY25ia29yb0gzMmtSSjI2MmdzRjA1SStxdjIxVG93SkNlNmtv?=
 =?utf-8?B?SDc3WjdEOVNaL0ZqVUVSbWtNSG8vZTJaTzdYaThpR0ErVlkvTVZxSE5BeERW?=
 =?utf-8?B?NkJGN2VTSkd2am8rd3JVUXBiOUY3U3hlekFsN3F6K3NUMFBUM3YrWThYS0Zs?=
 =?utf-8?B?QnFOQ0JOWFRGNEhhMnZqT2xQWHpBRkcwcTQxN3BEZXR5WkU4VURXb1FXSVFG?=
 =?utf-8?B?Q3MzcVRwYzlZREtEZFhtakN0R3NacW1iakVsZkN3Y1lKMHlYV2Y2SDlWOHM0?=
 =?utf-8?B?TFljWGMxVWFvcXI4RUVaaC8rRkt6cnVjc3V3YnlYeGJxTVByM0dLTGlNc210?=
 =?utf-8?B?aWJudjV0RU51TGthR3BLYTh6MFhQQzRoQy8wMEhZMnhlK1ord3crUmdpMnhQ?=
 =?utf-8?B?RWpoVlBPUUdnUVllU0RRMW55a0xtNHI4SGVSbkMyZWM3aStnMzJsMlNLbmht?=
 =?utf-8?B?d2N4Z2h2SGVsY0QvU2kvVzBQQ1EwMithRTBxTGhKQUt4b2p6L09Iak9PbzV2?=
 =?utf-8?B?bEd6TVZUaGdNYXlGQzNYcUcyUGhNY0daR3lYTjNyalNjWjNiSVVPNWRtdUh0?=
 =?utf-8?B?WHZQbCs2dXVpcWpqMldnMy9TcHlxbEFFWlgrQWg3c3NJSUNVZExTVDJDK241?=
 =?utf-8?B?L1pYeFVqa2o4Y0s3K0hsdHE5ejRmeFJ4ZStuK0hTdUVueFdGTkpwKzhWWVpE?=
 =?utf-8?B?OTAza21iMzl1czk5L3AzUlY3eGl2cXFsZ1c1dGZaUWdaU2FlUVBMUmZiVUV2?=
 =?utf-8?B?cHo1TStIcHI2aFRneldzNWdsak05UWhPZy9vV1d1YWxTQ3lRSGZIR2RQMnJ2?=
 =?utf-8?B?Vm9iY203Tjl0TGpvaUxwZHdqelhCYXNvWHdLQkgxUkc0cUZmWWcxWDgrV3hD?=
 =?utf-8?B?c3plcnNJUG5hOXJOcGRwZ1Rnd3BDUTk5c1lYS0VUaXNqMGg2Vk5jUUpWSEdy?=
 =?utf-8?B?amlzWDcyV05uNFZycmwwR0lRZitrMmt4b2xiOUVGSFZ1akVnd0hPbjYrKzhY?=
 =?utf-8?B?bWJDdjB4ajlVU3JiYS9ZcFV4dXd0c1FPY1c4akI4SVdhK0E2R2pXRkZQWE9I?=
 =?utf-8?B?RG9aTjBmTHhESTN1MkRGclJPQWE3UXBBK1hxTkMxcDFMOCtUZ1dGNTVEb21o?=
 =?utf-8?B?dzVSQTJkemJ5TUhqcVowaUVHcmM3WmtrVVltcTZ2NnpFRkZrSXRjU3ZPYUpl?=
 =?utf-8?B?Q2FrS2JnaS9tSUYvU0JoQVpUOVRZRWxHTHZwempmR1hRYU9HUXEwOGd2cFp2?=
 =?utf-8?B?YXV3bGhpTjh0MFgvZEovV1JqKzBlT1hYWjV1VFJNYmxoZUJXeldvMUM1eVVk?=
 =?utf-8?B?YlhLempseDNSTmhrcFdHQUgrOXQyVlphaERjWUZ4ZFE5K01YbVhSbUF1UGxQ?=
 =?utf-8?B?UGlPbll6a0pIckRmanppaVN4QUxXVUkxc0Z4ZEpaMmpWNEpqOU9xaDNBQkZO?=
 =?utf-8?B?YktleGgrMmlCMmxTdS9tU3ZVZkpsQXVmNDk1SFdPSFcrUjZ6bzlvL2pxUlZ3?=
 =?utf-8?B?VUNWaHo0WjVESFFKd2E0QzNjckxNeW52V05ER1EwY05Ma1IvbEdMejByTVJu?=
 =?utf-8?B?WUJPWnV4dERhNC95NERyVkw2ZjZyZjg0bEZVUVRLaGovVDdzbFVXUmw3OTNC?=
 =?utf-8?B?VHdMTENKeWFHdU5JUnRqdXJleDR5TC9jT2NvdUc3aVlCcEdHRDhiTmJ5cHdz?=
 =?utf-8?B?eHZxV2ZMaXB6d0JHZWxrZlFmS2wxU0lKUE42dDkvdWM3RXFvTEtuK0t2UjJU?=
 =?utf-8?B?SktVN3A5SUwyRitFdlZUblRRMW94Vk1INmJPdXhMQ3JmK0RNWGVNdWUxUnc4?=
 =?utf-8?B?QzQvbnJWU0lVUHJBQkxxNjlPdy83cDYwY05NWVlDTFp5SXZYUm0wV29MK3ZR?=
 =?utf-8?B?dFhBQmhMUzlvR3FDSGJac1NzaUhlM29ldXk2VUlWSlhHNmZGODJKMXhoNTVa?=
 =?utf-8?B?V0grMVVjazEybUJaenhxOU05QitpMFdYbGY4WFN0Y29DVEdPVmN6VlNMOENr?=
 =?utf-8?B?dThRRlVRVDNLOU5EVTZFdnF5UmZUWjY2Qmg1clUyNnVGTURwYjV2UnI3LzNw?=
 =?utf-8?B?aFRQMVMxUDMvQW15K0JPSkJGQ3phaVR3ZnJXT3l1RHJCNHBTSVpUSk1LSHY3?=
 =?utf-8?Q?/1wFa+ByedRjgd5FXM1DXG5ZQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4084b071-bc9c-48e3-4620-08daac63899b
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 15:07:54.0490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qNxlI3GEIwoNR8CY8SOGPmkjU5cHc6OXVFEysWD4NKkhVTfjtZ44GLaHFjGQsDQEiVpAmyN8NphTSWMmYERiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vincent,

On 9/25/2022 8:09 PM, Vincent Guittot wrote:
> From: Parth Shah <parth@linux.ibm.com>
> 
> Introduce the latency_nice attribute to sched_attr and provide a
> mechanism to change the value with the use of sched_setattr/sched_getattr
> syscall.
> 
> Also add new flag "SCHED_FLAG_LATENCY_NICE" to hint the change in
> latency_nice of the task on every sched_setattr syscall.
> 
> Signed-off-by: Parth Shah <parth@linux.ibm.com>
> [rebase and add a dedicated __setscheduler_latency ]
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  include/uapi/linux/sched.h       |  4 +++-
>  include/uapi/linux/sched/types.h | 19 +++++++++++++++++++
>  kernel/sched/core.c              | 24 ++++++++++++++++++++++++
>  tools/include/uapi/linux/sched.h |  4 +++-
>  4 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index 3bac0a8ceab2..b2e932c25be6 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -132,6 +132,7 @@ struct clone_args {
>  #define SCHED_FLAG_KEEP_PARAMS		0x10
>  #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
>  #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
> +#define SCHED_FLAG_LATENCY_NICE		0x80

[1]

>  
>  #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
>  				 SCHED_FLAG_KEEP_PARAMS)
> @@ -143,6 +144,7 @@ struct clone_args {
>  			 SCHED_FLAG_RECLAIM		| \
>  			 SCHED_FLAG_DL_OVERRUN		| \
>  			 SCHED_FLAG_KEEP_ALL		| \
> -			 SCHED_FLAG_UTIL_CLAMP)
> +			 SCHED_FLAG_UTIL_CLAMP		| \
> +			 SCHED_FLAG_LATENCY_NICE)
>  
>  #endif /* _UAPI_LINUX_SCHED_H */
> diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
> index f2c4589d4dbf..db1e8199e8c8 100644
> --- a/include/uapi/linux/sched/types.h
> +++ b/include/uapi/linux/sched/types.h
> @@ -10,6 +10,7 @@ struct sched_param {
>  
>  #define SCHED_ATTR_SIZE_VER0	48	/* sizeof first published struct */
>  #define SCHED_ATTR_SIZE_VER1	56	/* add: util_{min,max} */
> +#define SCHED_ATTR_SIZE_VER2	60	/* add: latency_nice */
>  
>  /*
>   * Extended scheduling parameters data structure.
> @@ -98,6 +99,22 @@ struct sched_param {
>   * scheduled on a CPU with no more capacity than the specified value.
>   *
>   * A task utilization boundary can be reset by setting the attribute to -1.
> + *
> + * Latency Tolerance Attributes
> + * ===========================
> + *
> + * A subset of sched_attr attributes allows to specify the relative latency
> + * requirements of a task with respect to the other tasks running/queued in the
> + * system.
> + *
> + * @ sched_latency_nice	task's latency_nice value
> + *
> + * The latency_nice of a task can have any value in a range of
> + * [MIN_LATENCY_NICE..MAX_LATENCY_NICE].
> + *
> + * A task with latency_nice with the value of LATENCY_NICE_MIN can be
> + * taken for a task requiring a lower latency as opposed to the task with
> + * higher latency_nice.
>   */
>  struct sched_attr {
>  	__u32 size;
> @@ -120,6 +137,8 @@ struct sched_attr {
>  	__u32 sched_util_min;
>  	__u32 sched_util_max;
>  
> +	/* latency requirement hints */
> +	__s32 sched_latency_nice;
>  };
>  
>  #endif /* _UAPI_LINUX_SCHED_TYPES_H */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ada2d05bd894..6a6116ea4c2c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7318,6 +7318,14 @@ static void __setscheduler_params(struct task_struct *p,
>  	p->rt_priority = attr->sched_priority;
>  	p->normal_prio = normal_prio(p);
>  	set_load_weight(p, true);
> +
> +}
> +
> +static void __setscheduler_latency(struct task_struct *p,
> +		const struct sched_attr *attr)
> +{
> +	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
> +		p->latency_nice = attr->sched_latency_nice;
>  }
>  
>  /*
> @@ -7460,6 +7468,13 @@ static int __sched_setscheduler(struct task_struct *p,
>  			return retval;
>  	}
>  
> +	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
> +		if (attr->sched_latency_nice > MAX_LATENCY_NICE)
> +			return -EINVAL;
> +		if (attr->sched_latency_nice < MIN_LATENCY_NICE)
> +			return -EINVAL;
> +	}
> +
>  	if (pi)
>  		cpuset_read_lock();
>  
> @@ -7494,6 +7509,9 @@ static int __sched_setscheduler(struct task_struct *p,
>  			goto change;
>  		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
>  			goto change;
> +		if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
> +		    attr->sched_latency_nice != p->latency_nice)
> +			goto change;
>  
>  		p->sched_reset_on_fork = reset_on_fork;
>  		retval = 0;
> @@ -7582,6 +7600,7 @@ static int __sched_setscheduler(struct task_struct *p,
>  		__setscheduler_params(p, attr);
>  		__setscheduler_prio(p, newprio);
>  	}
> +	__setscheduler_latency(p, attr);
>  	__setscheduler_uclamp(p, attr);
>  
>  	if (queued) {
> @@ -7792,6 +7811,9 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
>  	    size < SCHED_ATTR_SIZE_VER1)
>  		return -EINVAL;
>  
> +	if ((attr->sched_flags & SCHED_FLAG_LATENCY_NICE) &&
> +	    size < SCHED_ATTR_SIZE_VER2)
> +		return -EINVAL;
>  	/*
>  	 * XXX: Do we want to be lenient like existing syscalls; or do we want
>  	 * to be strict and return an error on out-of-bounds values?
> @@ -8029,6 +8051,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
>  	get_params(p, &kattr);
>  	kattr.sched_flags &= SCHED_FLAG_ALL;
>  
> +	kattr.sched_latency_nice = p->latency_nice;
> +
>  #ifdef CONFIG_UCLAMP_TASK
>  	/*
>  	 * This could race with another potential updater, but this is fine
> diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
> index 3bac0a8ceab2..ecc4884bfe4b 100644
> --- a/tools/include/uapi/linux/sched.h
> +++ b/tools/include/uapi/linux/sched.h
> @@ -132,6 +132,7 @@ struct clone_args {
>  #define SCHED_FLAG_KEEP_PARAMS		0x10
>  #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
>  #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
> +#define SCHED_FLAG_LATENCY_NICE		0X80

Small nit.
Can you change the "x" in "0X80" to lower case here to make it
consistent with [1] and other #define in the same file. When building
tools like perf, I see the following warning:

Warning: Kernel ABI header at 'tools/include/uapi/linux/sched.h' differs from latest version at 'include/uapi/linux/sched.h'
diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.h

Following is the output of
diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.h

--- tools/include/uapi/linux/sched.h    2022-10-12 14:56:00.925360275 +0000
+++ include/uapi/linux/sched.h  2022-10-12 14:56:00.917360219 +0000
@@ -132,7 +132,7 @@
 #define SCHED_FLAG_KEEP_PARAMS         0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN      0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX      0x40
-#define SCHED_FLAG_LATENCY_NICE                0X80
+#define SCHED_FLAG_LATENCY_NICE                0x80

 #define SCHED_FLAG_KEEP_ALL    (SCHED_FLAG_KEEP_POLICY | \
                                 SCHED_FLAG_KEEP_PARAMS)
--

>  
>  #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
>  				 SCHED_FLAG_KEEP_PARAMS)
> @@ -143,6 +144,7 @@ struct clone_args {
>  			 SCHED_FLAG_RECLAIM		| \
>  			 SCHED_FLAG_DL_OVERRUN		| \
>  			 SCHED_FLAG_KEEP_ALL		| \
> -			 SCHED_FLAG_UTIL_CLAMP)
> +			 SCHED_FLAG_UTIL_CLAMP		| \
> +			 SCHED_FLAG_LATENCY_NICE)
>  
>  #endif /* _UAPI_LINUX_SCHED_H */

--
Thanks and Regards,
Prateek
