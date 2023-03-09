Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5D66B1847
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 01:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjCIA4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 19:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCIA4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 19:56:31 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77714B53F2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 16:56:27 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3290srdR012144;
        Wed, 8 Mar 2023 16:55:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=XTlYvXWWJC/rMxRK0bixs6m5X4FIvO70+O9da34lGxY=;
 b=dMwScc3hhXZ9PIh5S9ZKpkG80tx1B++v7QASAskdicdFVpDP1qsIGRmbAn2pj6PQyD2C
 EvCKwA2ysZax2bnRlfaCph0rKYQks1AyBwv+Z/wGKtmhc+qaWr1YhP/rRyHi6Oh9geU2
 iv/qIZbp5zaS6mXJ3V8YhZv6fqJb7b+zKUj8ZAFK4O/ZxWVoastYTpRjJXiy1mb80EdU
 AxCiW15sduJylM2EU9c3T8EnL3kQuMiPoVZYVS1iySgblK9kQ6sfB5L3sSokHX5juHKF
 EzfQYDB2jwfAadParyQXPySfBt1N9qqJY0hfClDssLBL9W7Yd0pCC+aHCx+BSR+q8apI Hg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p75at00an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 16:55:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrSs+OHjOg6QQC6mH7KJjdZPwKHiPDStifGrZjmHNo5cGn4F8KK+NWmXcvCeFXSvlULjHVXWFgPOae3vxBY1H4d5CI+BAzqWoWhZEIbH/Zv5LsIs0m5xKsusiBi0HfpyL81bqPL0z0xjMDx8TzmWDOUiXVFL/YZ8SNW2VppFjAvP0aB/rwWf6fXHFnDA2t8YS6MUOsRdCi2g+urDR3/1bdLGYptgmR1O+UReniY1wU4qwAlFmrBq4Q5hiRJs8xPwlI2RTLOJAMEfB/8fQKGRO4aze+KCUMWoTgRU+CjR8hK4Y3qM8VC27FdiaEiNuwtwLCc8WrIFmqU+gY+Ofbf68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTlYvXWWJC/rMxRK0bixs6m5X4FIvO70+O9da34lGxY=;
 b=VPHX3HiToxnTIZPISgR7aSnnHAjbCFj3uTLdYL6cYSViuo0wZFqF7TgHt0+v+mQicm5bvJ+6zH21yUIhkWBn29V6y5UXNxdogKIgQ01OakLJ/9/ut6GG2A1N962s7eGqNkuuoSGpGz8LpRdgd8sKNvcn/zoUyGY3Fia82gUamlzvy0j7T0R4a1PQDgAN+kUapDfqO9q7FOgmC8zVQCFqdTvDG7AVYUd+VZ/0Zt2653JF2/eyXoWj2EgqovzoLFQF8Rmfua1JhbN0Bb5Oe6g3F6mr0o05qQWg59/Lj3WUggH275m/thob1lJ0iY7v1scnDBro3b3Ocq6wHKylrZs2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by SJ0PR15MB4471.namprd15.prod.outlook.com (2603:10b6:a03:374::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Thu, 9 Mar
 2023 00:55:56 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::2bc5:11e2:5c70:387c]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::2bc5:11e2:5c70:387c%8]) with mapi id 15.20.6178.017; Thu, 9 Mar 2023
 00:55:55 +0000
Message-ID: <e8027eca-16ee-2fb2-081a-e54a21821dc0@meta.com>
Date:   Wed, 8 Mar 2023 16:55:53 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] tasks: Extract rcu_users out of union
To:     Oleg Nesterov <oleg@redhat.com>, David Vernet <void@manifault.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, kernel-team@meta.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
References: <20230215233033.889644-1-void@manifault.com>
 <20230216080459.GA5200@redhat.com> <Y+54c0YvXcMIFva4@maniforge>
 <20230217102521.GA27682@redhat.com> <Y/zWPoCjQ6gLSNGU@maniforge>
 <20230307171913.GA4387@maniforge> <20230308182907.GA16406@redhat.com>
Content-Language: en-US
From:   Alexei Starovoitov <ast@meta.com>
In-Reply-To: <20230308182907.GA16406@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0050.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::25) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4490:EE_|SJ0PR15MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: e0513874-131d-49c3-79f7-08db203909ea
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Apm4S/R9SXkeRuz3Mh6oLxxAEQpYINOMMep/M3OoVGbB6aP1wQ4qnVCqs1ufTKaefSpruXdWliRnblb4+IhmIwaPOj6LdHM3w6N1ubZmp3cYATfFf5LtxdfSRJ62TX+ub1Of/29HAQerzhfYn1eRJRZXHhGEaLzx7TMTjYnaOXeXQcrnDe5DitXf7AqZXGKp3UdKmqkkSj8MXh89y4M6kf2hCYW5BSh3D/hBqYPxlZUx4QcR7qKC5AGcxDAOxrzfXdPnaF8vWsmS+qC5O9YU+sqQzzaNO5JaOXof62IFVXUbLBdghvRb+1NH2gxQdf1o1o6hHp5hwrhxPwzXoOI51kOTg3QlrU+HB1YH8Wp+HEhcHg8+U9bpRshR6lWQUQ+xRPQeWSf/Xug/7rSGraobmyApXnN0V6thWNaHRKvxcZKg8SjWKwTvBmf3XGzXTj9echMdfdYEKwwPpK6xJowc/j2i6x/KFa2IKPycANd+3JnlVk1WQnqLbpz8dNKET1N2Y5P6kjVLk4gKBxj5j3NiXUeBznL0e6mulPzEAx8Fc8ZItulWALEHxOXlZ3JFLopHhjBtU9aIAvspnyUEwevDLarCHo7+GyV0+5IFU3Vpe5pDVhXERKbYX2FIoeKdHAQO+boXN6caBr5v1l/zrnHzBOgxLvqdaYeNrTTXcwFnPp2A0UBR1FUbqIZx/+Hdno17hQPpidhqxPXiZ2prYovwXjNlSZM5Og+UNLJZ3ngCgk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199018)(8936002)(6486002)(186003)(4744005)(83380400001)(7416002)(5660300002)(36756003)(6506007)(53546011)(6512007)(110136005)(2616005)(316002)(31686004)(41300700001)(86362001)(66556008)(478600001)(38100700002)(66476007)(31696002)(8676002)(66946007)(4326008)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0xnRHBISWZnSDF1WUVScGRDRDVRbjE3SHUxbk0vZUhHL0VxS0NHVDdlS0VC?=
 =?utf-8?B?ekhzY0E4UUJQaFR4aXVpQnUvUG5pK3JFNDhKUE9zVUdJL3NlTVJPQ3JvN0xD?=
 =?utf-8?B?WElWLzFUMUIyNVNtV05jR2MxNWUwY0ZSTElVbWthR2tTY3VaQ3FUem94emNY?=
 =?utf-8?B?dVMrbGhtT2pTZ3VhZDByUmxKNzlrRjQ2ZTdrY3hZb3BNNE9hUDlpTXJCQnpz?=
 =?utf-8?B?dkFaNm9GT2dBVUNXc3BjT2dwaFAxQWlvcDkyU1NTejF1ak9lNWJZRFVNcWZZ?=
 =?utf-8?B?MnI3amRTZ1Z0dWRUYVh6WWxlM2pZWWNEQWFJQ2gvM3p2MnhWWkxWUXQrVVhj?=
 =?utf-8?B?Q1IyUXZmY3h4Y2xFeW5vSWl1YzAvUDN2MnNKVWt4Mm5tNVJXakEzbG9vMjBX?=
 =?utf-8?B?NG80ZEYwanJQaVdUcXlpQXZiNitkYTRTMXVpbjlialdoU1pzZWxNRE1PT1k2?=
 =?utf-8?B?NlZMSU5wa1AzS256a3pEVkNleWRSaFF1N01IL0cxaEU4Ni92TFN0T2RHUldt?=
 =?utf-8?B?S1dTYTQ4NXkrVkx2eWowa3lFVDhrSVR3d2pkdVdhcUQwd1JpOG9FVzROZUlL?=
 =?utf-8?B?Q3QzeE5UaXpOTWNlenhlMUZNMGtpbjU1Tm51WklUazdTMkdqdnN4MjBtMkRy?=
 =?utf-8?B?SnpETzFpU3J0VW1JVTZHMW9WTVl2T3JQUEcxSEszZkN3S0ZlZEZLR1hmT05q?=
 =?utf-8?B?MVgyOWVCWjRhaExkSko4ZjN2N292RGs4VmZvQVVuVWhpcGFnckZHQ2RZZlNi?=
 =?utf-8?B?ZjlhSHRUZVJZaGZVMERIUTA0bnRHVDI2dFcwZXBjU09pR0gvK3ViaU0xbUV5?=
 =?utf-8?B?SjZWTWNvaVpSdHZPOUI5Y2ZWTjl6Q2xCYkw1WFZnY0hSdCtoU01DRlJZN3pJ?=
 =?utf-8?B?ZVRYa2ZZaEJGMHFGalRQRlhqNmlBMG00cGxWY3AvN2FEcmJMUnQ5MnRFN1lq?=
 =?utf-8?B?Um9wNnp3NjZGallMeEpwRFJ3Wk1iNHNyM3dBU3JmSldrVjdVVUd4YkNjbjNK?=
 =?utf-8?B?NUJlUXV3QTlnTWlkZHYySjhwN1ZvS0tNN1FJOERFaGxvcTBCUEdhVzBDZXRN?=
 =?utf-8?B?WlZCTW9iM1cxMUpSZ2FjWXkxaTNWTE1LNTdIOGF3Nm1VQ1JEdWJkSlE5YTk4?=
 =?utf-8?B?VnQrR09LazM4M3ZrNmhoWjRhYk84WXlMUTdHWFplMUxpcFIveG0vOG85Z2N1?=
 =?utf-8?B?dEhFYVRRZUhhZVhvam1pSGxlNWUrSUt1YlJHSmVPU3oyOFY4WjE2OStrZlVq?=
 =?utf-8?B?TzQvdmpha0E2c09xVzdsMEk2NHRobzFLRjhUUmVxTCtHZlVZczJHUlZ4TmZl?=
 =?utf-8?B?S29mQXZVL0tOMU9IckVwOXZIclpBZEdUWWJENTBBVEFKaTFlSGU1UzVJYlVh?=
 =?utf-8?B?SVJVUU80VjhjdG1rNFZNaHZYKy9jdi9DWk55eTBCQkwvRUhobEJWZ1BreWRp?=
 =?utf-8?B?b09aSGtpUzZHMUhKcWdCdUNyRXBncDdLeE81WDdsZ1FDS1JTYXhFNVA5OEgz?=
 =?utf-8?B?ZUt0UWdpVkxPcWZEbnBVRlJtazZTTUd5TlJkdWs4aEs3UUdnTWlDWXMyelRH?=
 =?utf-8?B?K1Y2d0U2VGJZd0xYMUZTM2tISzBBVDNKaUV6bytMMHBIR0hlUUhzVkIram43?=
 =?utf-8?B?SnpNU2FoZmRMRWNIQ0Q0R2NCK0hmQTNkZVJXMDQ5NWQxOTlURGZNeWV0dThu?=
 =?utf-8?B?aWsrb1BiaWRCemFLWGRMd1h0NnNYTC9qK3d2T1YvS3NmSWRJcDBkWHhocStY?=
 =?utf-8?B?OEdwalRKc3ZKbzFldEtnbGV6Z3NjVG9VY2kzdTBYNHM2elBZVGFkV3AzZE9r?=
 =?utf-8?B?VFpycjh4U3pZYWdTYmowL1J1dXhrN3BGa2dXcDc0SVBaM1RTY3F6Nko2TEk3?=
 =?utf-8?B?VlJaa09ETG92bC92ekl5ZnVCQlJtRDJoZVM4NzFEOGlncDZKaENCOHladG9K?=
 =?utf-8?B?YXY0cDg3LzhRMFBzbjNjcUdmMC9nbTE3Wjh6akhUZDJaZTROa29tYWZIRzVR?=
 =?utf-8?B?MlJUaGo2T2g4MEFPMTZWVzh0QW05bm81S3pidHdzWThZVFE3TFJWQW5uUzFK?=
 =?utf-8?B?Qk8yNldtM2hjdGYyVk5iN0pPaEF6STcwUmZoZ1NwWWxtWlZ1cVhGZDJ1eTNq?=
 =?utf-8?B?dzltaXBSeStiMFg0VHBYcUY2cGgwZlhPUnlzNFh5dW0wRjZGd3RNYUhFaWZM?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0513874-131d-49c3-79f7-08db203909ea
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 00:55:55.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5kU1Fz2sgh8u+hhduYRhWsgBNIdXp0lKLlvzRYL/ei16+USDRgnHinkkUAzMchs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4471
X-Proofpoint-ORIG-GUID: IoqzU3SKZKlhx4wExQLJ8d63kX5EIWFC
X-Proofpoint-GUID: IoqzU3SKZKlhx4wExQLJ8d63kX5EIWFC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 10:29 AM, Oleg Nesterov wrote:
> On 03/07, David Vernet wrote:
>>
>> Sending a friendly ping on this now that the merge window has closed and
>> things have settled down a bit.
> 
> Well, I can't help to merge this change, I lost my account on
> kernel.org years ago.
> 
> Perhaps you need to resend this patch? FWIW, feel free to add
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>

Thanks for the review.
If everyone is ok with it, we will take this patch into bpf tree.

