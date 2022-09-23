Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A96D5E7B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiIWNAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIWNAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:00:08 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2084.outbound.protection.outlook.com [40.107.115.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D45A99D1;
        Fri, 23 Sep 2022 06:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+0nvVm6hvjVAWRQG3UHYHPtrtSBabKK1Y6HoZtfIfhloNRiO9ecQmwE1VN0sq+zZF88x+CbriVC5czg3KPyXWi5jvQkZh3jS0xoWojYMLo+EL110jZguPJUxG10ocJunwcdpvba2a/R9odekA1xUbNAYjEiOTuAgztn80F8KVD54zx1anCUEv9ibCL2eqAaB9KIvgpXDOiXg9+PPZuC87OkBesjTaMPkanJ2Ypku+2LRqwDGCtUDMVqby3EY6heMCHfFADPyq8nurKIXJs7tKtA4oWrq5GL0l6UhKFS/yy6IgThz1NSHA+hqg+e4wre68yesA85IJ7rgWQHbaKAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeNKHROqwhttgtasngxa/0MeR+byb9sqTAU3Pg/KNo4=;
 b=XdIVUCiPXFxWpoA3sNlZjUXAATeZNFt4oxrwjmaD+5tIiL9e4uofTWw2fz+/b9+Bj9kVFKFY7tnZzQUfcibaBUweNC7I/6QH8aV1/7GtDxlAxHyDPiZOh1OLh90zcOqX9WJFpdwrVs1IiTDmQWPT9J8wgW2SQM/WZyYBHR/s2fcuH1dmDrdDNiiV2Rf7/Ufvn7WDVhAbjGGeEZP8vUdgJ6OMAbKVlerP09+pjl+pylPPkYxGJPdJiBo+d20y6jJlNl+80DIBpEiqsynK8AQCXOgMSP7nxfK4zZ2rkKpyJRNPkGiPpnTP5WtKZb2D92emTr4TlvAuywsKEKJ7oq5dbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeNKHROqwhttgtasngxa/0MeR+byb9sqTAU3Pg/KNo4=;
 b=BFFHbNOY1GyNM0wRawivYOX+2bPRfm3XNyeQM8qid2gV2Csc6fnJFJfgW7GBC63BtUn23US/XytXK0Vcp+C0kir1b04l5O6rMphxJP14X4qc2m28TXAkt+JmhtQ/4CHg169kHUFX8uXOswrnHMLNAkjE2WjyGz8VYvpelZ1X1Kt+0WjzxxuRfO5cdA3T2x7whP81C3fGZH/37ha6lCX+DkpUjcWOR46AERAszhCz2wAZoq90TfyExIXguI+2GgDPGU3c61TDELFwRuMAxcG4cvVju2efIiUcD58vrPwMl1fr4EzYPOrhOkpICd5u04voVrTAJtpnFyXa1zNLi04wvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB6665.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:49::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 13:00:05 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9%6]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 13:00:05 +0000
Message-ID: <64eab1fc-c46f-7e1f-39ec-523d8183b878@efficios.com>
Date:   Fri, 23 Sep 2022 09:00:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 03/25] rseq: Extend struct rseq with numa node id
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>
References: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
 <20220922105941.237830-4-mathieu.desnoyers@efficios.com>
 <Yy2UyL7vtQqWqKyI@hirez.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <Yy2UyL7vtQqWqKyI@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0308.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::22) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: fa56622c-8b97-44df-043c-08da9d6388b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4iUEziA/8cy+uIOmtTFh1towVYhKgseohOo3lZiiGSYhPQje3huDeCe02A+lvFD3bCESGrh0k2YfwdH/+TOtxUvUMofc2nflFElFNdpI9ijqSZCPfYgUWe6XMBgm4S6wMpYFLtukqf+VuuSS4VdBktG1aQIODC+H3xkLX68wO8GXrEhVhCjFyQmWYtSyjmAcaG4xoBKE/l1fTzVrVfqKFKkKs1HBspaaYCApcoKNZqGBYR2b4OQ5F13GgUXCjAmCQqertsXCo1/xyHEup3CwW168jRADfbo7t0okJd98t4qBBlSz/h6JhPY8NTtah7YrCOTnuV7IEge5Q3Vy+PTl/Gbe48e6qkJQPQrl+mkwQxg98oQM3ZN8boaASSzBo1GEiAEp7bVwxVDPNgHlzrU5j8pRUYNbliAL1E+zMBgEDK5rRWPf1swmzSzgwnXXo2mRwQcx6ATHIcDQ6QXvFW8G2vv0tV8VCUxjPHix/KbjgCCmJk8hMwtxTNY3obi31MCrcCBUbqEtdYTa8/U8b7+701OY33ZawwEikpC8xbgTIYlT2KGJrJvlw0szw2VaWFLC90VRm/gS4aYmLUUYRUSf5YM5nF+Df+QgmUGod3IjWx6Nka6LbhXjishbfSFSrR5SOaG6PisDMHR+g7wBi1gvOgHl4iwNx9rFTMfNYpUxRHxOILscCqDOUnNNC/IBBClGUgBId9gUV9Ov2y10+en/a9zTyaN3lTTUr4hx78qaIjjAQsnD8v4TnqKPhZpqEqztg+b7P55tZ41+lcq/yFgp5leY/jrLh0R4vVANZgZ0F0PeQkAflRG5Fdf3BCK0Lx1L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(34036004)(346002)(376002)(34096005)(366004)(396003)(39830400003)(136003)(451199015)(66556008)(6486002)(586005)(41300700001)(966005)(6916009)(54906003)(4326008)(6666004)(498600001)(66476007)(36756003)(66946007)(8936002)(8676002)(31696002)(86362001)(2616005)(186003)(38100700002)(38610400001)(6512007)(6506007)(26005)(53546011)(41320700001)(83380400001)(2906002)(31686004)(7416002)(44832011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFVPRlZEZmlOQ1hQWGZWSHRkbDZraVRBN0JsU2d3MzM2dHpkTVNEc0kvMlZ6?=
 =?utf-8?B?UlRvZXR6bVZuZ0orZmZVWkJDK3BLQjdydW1SSmhKMVRqK3RGNlFZZm1LeGgv?=
 =?utf-8?B?dUZucmlrMkcxdHdqQThHRlRNRjJmdUtwMlJCRFp1U1dPVXM3d2hFY0RBMDV1?=
 =?utf-8?B?eEVCOXBLOVdDckJDeXJZOHR2U1dlRHlaMDNmOUV6U1l0Y00ySnEvUGIwdHJT?=
 =?utf-8?B?NDYrNXVpeEl2MURQb3JrNUNEQ1ZxcnA2aHJka2x4dEtUeTJXZUxYZHlRQ0U3?=
 =?utf-8?B?dWkzbHQ0SUM5c3U5U29Kcm96T1dYVFEvWDdIT2R1ajRFVVJjOERoRTNtTjln?=
 =?utf-8?B?MnVIcytjNDdtcjZWYUdhMERIa2FKZEZGUENtWUlEK1doVjE4eWxlQkl4U003?=
 =?utf-8?B?aG82VVdBbktBM21XNDJ0bUExQ0JIMkpPWmsyOVQvdmlHUmVKL0FZQUxyMXF3?=
 =?utf-8?B?L015TjcxU1hFSXVLNlNHMkNuL2NFTHR2V1FwbEp0enMzUHo0Q0E5czU1WGJt?=
 =?utf-8?B?Z1RuMk4zUlNNODg3QmFIbzlZd2tsYnllMlBDZnp4bXVEQTlZUEU5RWdibEww?=
 =?utf-8?B?WDlZd3VtR2VKMG9KZXlMYkY5di9QRS9nUE1sQWNLdE5FV09aa0NtYUIrV2Uy?=
 =?utf-8?B?VStpTEEvT09GOW5JOWY0eUI4NytrU2c3UjYvT2VUOStoOVJzOTNjMTRzYm9s?=
 =?utf-8?B?SWUxcVpaamJaV1RETENGUEowRHJlY05FY0ZzOFYxT1o2a0ROY0kxNU1sVDlX?=
 =?utf-8?B?Y0JwUzN3byt5ODVKekY3NnRPeWllTFBRMGxsWXZxZnVOWDl3ZytON051OXJk?=
 =?utf-8?B?alRaWU5YTTRMYm9MRWNkT01yNE45VWNZZ0t0ZWRkL2NSZit5N0YwSk5YYkhR?=
 =?utf-8?B?bVBFZ0tjb09uRWxVQzdLNUVQQ092NWpzbEFDVFZqNVJzWXhOaitnZDFrNVpr?=
 =?utf-8?B?TFV0TndkU2p0UE5HVktUUlpuaEhyRGhzc2gxR0lYTUNTbEhaSkc3L1pEMVdH?=
 =?utf-8?B?ajY1QTU5K09FTXlyTnhJK1FaMUNMc0sycVBwVU1DcnlLbTRxTmUrbURsWHVX?=
 =?utf-8?B?OGE3c1Bid3M2eUV2RnZRZTA1SlRUNjM2aWxjNlpuSG43cFVTemxRUXRVUWtO?=
 =?utf-8?B?OHZHY25OdEc3bVl4L0JGV3B2d3dOQWY0WFRoVlJOT2s3aWR5bkNHbWZsckdS?=
 =?utf-8?B?alRTejNoY1FyNHRVTmlXVnl6RS9TMkJhai93TGdaNDczVEdNRTlBYVNKa21N?=
 =?utf-8?B?UDRYVzQ5dzEwT29sZE9PU3NOTHVSamJjNVR2RjRmdVJ3T0YvTHNLVnlIdWpy?=
 =?utf-8?B?Z0gyR2dDSVdvU21sbVowTHBxS1pBTEpJZjd3andrL3F3V0tscGZ0V2xWQXRK?=
 =?utf-8?B?VEpDZldOUmo3bXlRTXlBRWloMVNWVmpldmQxQjR4L1lkbDRuWEVtaUJSZFNU?=
 =?utf-8?B?aFJqSUxYQy9sdkltTEtxOGJQa1craFMwWGs4NDRRdTVnWnhjdUxlT1JoSDBC?=
 =?utf-8?B?S0JwangveFAzeXJFN0JWeE9kKzZQQjhucGQxYWFKYkMxd3VSc1RnTlpHVjZS?=
 =?utf-8?B?MlRINnVKTXZNZGY5TXdMZHplb0s5MHZwa2FuRFZoVnVOYm1zT1huNVI0S0pB?=
 =?utf-8?B?VmdDMG5ibFlPSm00UkxHMWZYOEp0M0oydEQzTUVacjJEMmM3WGc3dVZvUVpB?=
 =?utf-8?B?ZHVmV01XT3JwR1poWHFtUW15d0xkRVY3QXdiRWRIdm93Q080R3Z6c0ZscmVV?=
 =?utf-8?B?TzZXMStsc09GNEdacEM5V0txd25XWXdGOWZtRk1yZVg3Z0swWjRsdU5tUEZ3?=
 =?utf-8?B?dWRESWlaQ0dYYzYrR1NWV1NOU0d5KzEwZ0k5RWV6T2llckJ3RUlPdlRxZFhs?=
 =?utf-8?B?NGlydGpFUWZjYmRWQ2J0Mm5SVGgvektJTVFzSUtNcUJNeXEzUnV0ZlpBVkE4?=
 =?utf-8?B?M2xSMnYwZVJJbkhFdDhUZmFMMGVoRW9jL1NhWTRqbzlVNVd4WndrTkY0VExO?=
 =?utf-8?B?a3ZsY3lpNGVEZmVZTFVTTWtNUS9xRS96R09EdkptaEVwZHIzUEtQVjM0b1lE?=
 =?utf-8?B?dytlTFpIaVBPQlVReUpWcEF6WEVYM0ZGSXExR3dxNE1TWkRaa0lQS201V3dH?=
 =?utf-8?B?QjhiQkcvZHVON2FyTnRETHlpb1prOU1ocVZMdVZpSElHWjIzZWhmUkhwOWdN?=
 =?utf-8?Q?4C2yM/ZgnxHaVxt9UMHVv8k=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa56622c-8b97-44df-043c-08da9d6388b4
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 13:00:04.9199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PacIVyKGcctCvegitYejtxT9PD+4J8sQvhLbBitwt6vHmir4wx9EFCb7dOPZhpBhvwL4p4Qhn0ovxuWOn7TyyJ94La52CMrhhY2UzvlmlS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6665
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-23 07:13, Peter Zijlstra wrote:
> On Thu, Sep 22, 2022 at 06:59:18AM -0400, Mathieu Desnoyers wrote:
>> diff --git a/include/trace/events/rseq.h b/include/trace/events/rseq.h
>> index a04a64bc1a00..6bd442697354 100644
>> --- a/include/trace/events/rseq.h
>> +++ b/include/trace/events/rseq.h
>> @@ -16,13 +16,15 @@ TRACE_EVENT(rseq_update,
>>   
>>   	TP_STRUCT__entry(
>>   		__field(s32, cpu_id)
>> +		__field(s32, node_id)
>>   	),
>>   
>>   	TP_fast_assign(
>>   		__entry->cpu_id = raw_smp_processor_id();
>> +		__entry->node_id = cpu_to_node(raw_smp_processor_id());
> 
> Very minor nit: perhaps:
> 
> 		_entry->node_id = cpu_to_node(__entry->cpu_id);
> 
> just in case it does a reload and finds a different value.

I agree with your proposed change, but I don't think it will have any 
effect, nor that it matters, for the following reasons:

1) Tracepoint probes are executed with preemption disabled, therefore 
preventing preemption and migration within the probe callback. So 
reloading the processor ID should not matter.

2) trace_rseq_update is done in the __rseq_handle_notify_resume() called 
from the exit to usermode loop. If a preemption/migration happens at any 
point in this code called from the exit to usermode loop, the loop will 
observe that the thread flags have been set again, and iterate on the 
loop once more before going back to userspace. So indeed, even if we 
*could* observe inconsistent cpu_id vs node_id in the trace, it would 
not matter because it would never be observable by user-space.

But nevertheless, I agree with the change you propose, just not the 
justification. :)

Thanks,

Mathieu


> 
>>   	),


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
