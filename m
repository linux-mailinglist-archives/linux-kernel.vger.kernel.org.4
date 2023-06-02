Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5947571F993
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 07:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjFBFNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 01:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFBFNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 01:13:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF1018D;
        Thu,  1 Jun 2023 22:13:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=go8TBcK5Z/bdH1L5+tryQNHT28MPC3Xewt5FNBnhovTG8Cd7hBI0eZg6Cke2yH3U5e3JN3pQ0QTXNGc2bsCrZ7eqDzP2iK4hjSzv9+ADyNTLEJxgMymZATOh7SEdWjDErv27YOok97BSaxpdAGEKxNpdK+gEGq/qMiQ9bDhiMRQLCLzCTIpoZx5z9G7CxdK3cftZuZLRVAfkSjLjhwU/ZB7fF9KWOi/CyYDrw7jmZ0xxmBtP+YtaVLupBA9v4qHmcQlBghrUR6EdUEgua9HVv/OKl281qIvb1IS6dmozIQ6uPrqHmFBn0p+QYAT6OWpCEXjLnEabCSVMljByBP+WKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgR8dz4p9zr0g9DK3K4OsIbpt8v8u1QrAd4ylXrILgA=;
 b=ENdVMfkG/LP5mZDVzbhW+vzklfiCuGql4RhblbFoaLKZ/I6Nw0fYw3d0DmRiCDsb8qwxwNHyb6s5Yeq6erRVYyXrJBI8xb3o0rra63XhqEesDuS6OvInwW4G1nOuAk5oIt/f96iTqKjn+SUpp17rlaX5Ih8mCbs3Af48YTWPZoKrICBTsG1ztiAX88vn79ml1Bthyeq+v149+xBy43H2MT0/gmkkfpNMZcVTRJ2y+FcGxOjXH7yv9fdjNCwbOmWSGuQqPIEzxvUru5ZblidVlYu6lCfSwUTBcqLgH6GdK5jI6cDZyutYkZCB3rfKRBbaxTBg3WFJC0yPn7hshkqgpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgR8dz4p9zr0g9DK3K4OsIbpt8v8u1QrAd4ylXrILgA=;
 b=Qouta9gP4sR/bzeYRE7ekIy2wlJVLHwM+Zo71xjeRhZ9PK81vi/QDdBUFGBceAvpWlwcOkkRP8+gFw1tWRcvVvQz7UkpMv0QXSZ+CwPbAz8xBV1A4/BU35Yj4YFtM/D6IvP4go1m/lOI1MOQ/wF31Dfuq2pMdjc1HvmFQpbnUnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 05:13:47 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c%4]) with mapi id 15.20.6433.022; Fri, 2 Jun 2023
 05:13:47 +0000
Message-ID: <7bee9860-2d2a-067b-adea-04012516095c@amd.com>
Date:   Fri, 2 Jun 2023 10:43:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
 <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com>
 <20230601111326.GV4253@hirez.programming.kicks-ass.net>
 <20230601115643.GX4253@hirez.programming.kicks-ass.net>
 <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
 <20230601144706.GA559454@hirez.programming.kicks-ass.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230601144706.GA559454@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0235.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::13) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f2b142-f782-4b98-4c5f-08db63282495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LC0vvcFimnYZuwvAwcxCC6rrlXvjQiFFne/etMpMfcJHl1zecmJksR9UKbZzLBAiLlGQxNkCdhmAlRE3NqlYaLANtTxviQmIrLSy1vKWBgnhu+ffgg9LHx/INthsu7LXgL1FqL9wPla6XPSlvJztcV2dEFU6zyF2onajxbGnMfqHEE45lkNp6Yde5ndIp+EWG1x0p5n0Ri1iqUOvOB+dnWKqBSbbsSkvrYegtWcDXJ/g0Kn2oBWWbvHlpp+ye/XpsUeWSoXIoHT7DHbWGDxaCMx/NvkVloUUEcdnytQOhIaGWORzGUyuUqsgXAYC74P8npd1jVgKUOg818xzfW7BB5WSf+NYgXj2Fpgojb4vClmg0m4bEzsjBW/jTJVLIZ7qIo3eRcMzI7anRX4n202CWW6KAFpHnmOSll2G3kzdn0WETa8psIyMcNbg0fkCkuTHLlzxgCOGaVBtepdvTL5rGfRt1z+oMeddnlng1IrtQArg2sUrQUwhggo0KQp7YBpz9JZVAel6sLCaAZ5AFpo+fxnIw0eBBtWB0RFQIxSjBqISs5pBBNSdbmprr92D3Ocy7v9vWM/w0nIiWFd3ZbdxTi3ThREnXFGuL/trZ8+9RGyaWGeCcpOTzcFHaAz7WQG2Ghf1TNqNDq3mUVAkOBZiaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(66946007)(66556008)(66476007)(6916009)(4326008)(6486002)(186003)(316002)(2616005)(31696002)(26005)(38100700002)(6512007)(86362001)(6506007)(966005)(53546011)(83380400001)(36756003)(6666004)(54906003)(478600001)(8936002)(8676002)(2906002)(5660300002)(41300700001)(31686004)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1pYVHRUVHQ2aExxU2NBNHVWVXlrQjl0eFZXaE53V3FaL3p6MDdZc0M0ek5i?=
 =?utf-8?B?MkZ2T0JncU5KYnRqVmtra0VvU1Z6WWZnQUZQWmFtczhMaVBpUVp4VzdmWVpG?=
 =?utf-8?B?RDdaVzhDSWdRbnpRc2YxR2xHampHeEdqNE1kTHZiRk9mcVNKV3dENDE4Sjdm?=
 =?utf-8?B?bk81YVl6elhzTXl4bmFsZ0VVOTlMWGJ0NUU5UE1Tc3RoNURFKzk1a3VHSDBt?=
 =?utf-8?B?N1BETVJPSG5WSVpvaGlsbUZGY1AyNmxBRkZpYnBJa2tlK3lTMUcrSHdVQ3U1?=
 =?utf-8?B?a3ZRMURjZDVCa042Y1M3Z2N2VGpueEVtd2tEN3o3NUZFR2MrQi9WakM0dWRN?=
 =?utf-8?B?Z1VBVE5POThxa3lweWJ4cWVYWUlhWXJuTGZTakVOOE9yYmcrd0NnS0hQMnFD?=
 =?utf-8?B?T2xaTWdLNGZVSmQvTi9YNFNiSjhZRURZZ2pibnBmYnBmbFBXY0h4QWlLOEFs?=
 =?utf-8?B?R0N5bytORHFvakNYaTlSOVJnaXJ1MnM3MEFtM3RBNVBsN0dXYjRsQmF0allT?=
 =?utf-8?B?UlpSVWJnNWt2ZXUreDlJbEJ0TjhsSDBSY2JNVjk1V2F0QW5qMTlrdlBiUUN5?=
 =?utf-8?B?MmJ6bkRjM3RwM05raGVoV1R4QWdjZDBKODZBM0hoeDJmWUdpQStQSi9mNDVt?=
 =?utf-8?B?b3Y3MlpXUE01cGVxUjhHY3AwYkFFWFB3TWpiZ3pjTk1NYmdlSkhoMEpaaHVY?=
 =?utf-8?B?QVZaZnlWZnZPVmZ2YUpNbXdMT2dMOHNBcFNEekN6VDlhSVdwTWlaQm55bFht?=
 =?utf-8?B?UmFmTHJDT0h4Qjg0ekU3cUlqQW1tZUJOa3pFOTJDeEx5UDdtQWNyOWladlBE?=
 =?utf-8?B?eCt3MnZvZi9BWnlMN0FiZnpQT2VENkZQK2xHckg0WjErc0VHTTZJclpkNDdQ?=
 =?utf-8?B?SWgxWWdQWXVtWGNYcjlJYWRvZUdhNWY5d0xZcEZXOTdEZ1NBL3lOcklqQkFT?=
 =?utf-8?B?eW1jdG0vYVpRamZ2ekJ6bTdidHRiWmlTTERyYzNxOEU4YVBoemQvRFZOVWh1?=
 =?utf-8?B?bUtYcEdKS2t6blRKaFJXaXNJbkMrYUdPeit1b2sybmJHeHpRdE5Za210V1VB?=
 =?utf-8?B?amcvWEFwTk5sY1JOYi9kdzRxTlZSVnNOSldGeEFPc2tWSDlpUXkrMHJRdUha?=
 =?utf-8?B?TG1YdE9VTHRjdkVDK0R3R0h0MXcvKytHOGZ6NkdnUnMrVmhReE5Sc1hkM0Z6?=
 =?utf-8?B?VkFkOW4wTVdtNWlQNkNQdHF6OVp1N0VCN09KbnhpbGo3QkdEaGdqcTF2VVpr?=
 =?utf-8?B?NVlVZE9BVlVLWnJsbkFtZ1RiSmNQK2pBWWZYRktBQlpQcGkzem85bFZPZFZn?=
 =?utf-8?B?U3A2dmRjUlhMTGhtTnhIdysrWlExeFBNbzljNHpoR2VvSEJ6UitaZnlBSUFt?=
 =?utf-8?B?OG9xMnVRQXFsTHBNd3hodjI2L3o3N1ErUENueDFacTV1VTEyK2IyU21VdUpp?=
 =?utf-8?B?dkx1ZWNDWVBtMURKeGlDN1lpY1Z4OEZaemozNEw4QlU0Z1dreXhkSXVlYzJ2?=
 =?utf-8?B?QjB4cTRKdnFYYUdGcWNuZWdQdWlzcjBROERzNG9JWm43WE5yeHMyaDdvc08x?=
 =?utf-8?B?UUs2QlJzK3cwc0NZRzlMaDVyeitzYWFWUG5LLzJhcDlTWXlObW1xQzNKR1Nq?=
 =?utf-8?B?WjJtZ3JjWDBncWg3cmNCVGdEN21YOEFWOG5KSjg1dXEzbndZNUYwTXBVY0FC?=
 =?utf-8?B?VmFmZmJVVEYwV1R3V0NJbkJVaC9BMGp1bEJLbG96blpHYUU4Nk04S05SR2Zv?=
 =?utf-8?B?dWZ6c25LTVpRRS9CdFBUSlJReFgxaWV0M216MUdPMEJkOWl1RU50ZkJ1YUU4?=
 =?utf-8?B?MFJaWkl4ZmZLcDkvNk5rQ0RnZ01PaWFrNG04b2RJcTlBTHloMHdVU3Z2Wm10?=
 =?utf-8?B?TXNDaUhPRFdUTTNyekdlVUlwRDFZTGFPdjhOeTFPNE4yZVZ5RGU0dkt5RzdK?=
 =?utf-8?B?L3FyemQ2b1E3SGw1WXE1MHpDejc0ZmZSV0lHNHVGWlRaNkw1SlY3QVN0SXFt?=
 =?utf-8?B?ZHNVb0xsNHJ2M2ptNVc5UGgxR0RCQlZ2eUt5NFRxdnlmR1VrRnlLSnpQVU5O?=
 =?utf-8?B?Sjl5VWdKNkhyM2NJSjN4NGtIVVBpSDRoZlE1MlpwWjFIQmcxc1hrL2xFa3Q5?=
 =?utf-8?Q?UqFe1ldWiyj8ZmQM40nVBqB6o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f2b142-f782-4b98-4c5f-08db63282495
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 05:13:47.1144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yK5q3E4Sm0Y4c2/tg13TAEFu+YeZAF11dnt/94pWctYClfwfS/0rNBcTIChzmHG/fs55dBmq3UyjtggGc+8LNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516
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

Hello Peter,

On 6/1/2023 8:17 PM, Peter Zijlstra wrote:
> On Thu, Jun 01, 2023 at 02:00:01PM +0200, Peter Zijlstra wrote:
>> On Thu, Jun 01, 2023 at 01:56:43PM +0200, Peter Zijlstra wrote:
>>> On Thu, Jun 01, 2023 at 01:13:26PM +0200, Peter Zijlstra wrote:
>>>>
>>>> This DeathStarBench thing seems to suggest that scanning up to 4 CCDs
>>>> isn't too much of a bother; so perhaps something like so?
>>>>
>>>> (on top of tip/sched/core from just a few hours ago, as I had to 'fix'
>>>> this patch and force pushed the thing)
>>>>
>>>> And yeah, random hacks and heuristics here :/ Does there happen to be
>>>> additional topology that could aid us here? Does the CCD fabric itself
>>>> have a distance metric we can use?
>>>
>>>   https://www.anandtech.com/show/16529/amd-epyc-milan-review/4
>>>
>>> Specifically:
>>>
>>>   https://images.anandtech.com/doci/16529/Bounce-7763.png
>>>
>>> That seems to suggest there are some very minor distance effects in the
>>> CCD fabric. I didn't read the article too closely, but you'll note that
>>> the first 4 CCDs have inter-CCD latency < 100 while the rest has > 100.

There seems to be visible difference in latencies when you cross:

- CCX boundary (From 20s to high 80s,low 90s)
- NPS4 Boundary (From low 90s to high 90s)
- NPS2 Boundary (From high 90s to 100-110s)
- Socket Boundary (From 100-110s to 180s)

>>>
>>> Could you also test on a Zen2 Epyc, does that require nr=8 instead of 4?
>>> Should we perhaps write it like: 32 / llc_size ?
>>>
>>> The Zen2 picture:
>>>
>>>   https://images.anandtech.com/doci/16315/Bounce-7742.png
>>>
>>> Shows a more pronounced CCD fabric topology, you can really see the 2
>>> CCX inside the CCD but also there's two ligher green squares around the
>>> CCDs themselves.

Yup, same as above except there is drop off going beyond CCX and
that low 100s remain until the NPS4 boundary. I'm not able to spot any
noticeable difference at the CCD boundary.

>>
>> I can't seem to find pretty pictures for Zen4 Epyc; what does that want?
>> That's even bigger at 96/8=12 LLCs afaict.
> 
> One way to fix all this would be by having arch/x86/kernel/smpboot.c set
> an AMD specific set_sched_topology() that has a CCD domain above the MC
> and below the DIE domain that groups 'near' CCDs together based on some
> AMD specific topology information.

This makes sense but I wonder if new domain will add more load balancing
jitters. Also this will require larger evaluation with some more diverse
workloads. Let me go check if we can get find the NPS2/NPS4 boundary when
in NPS1 mode.

> 
> Then for small systems that will probably be just a single CCD domain
> and the degenerate code will make it go away, but for these large
> systems it will do what is right for their respective configuration.
> 
> Then, since this new multi-llc code uses MC->parent it will end up on
> the fancy new CCD domain and not scan the *entire* socket.
> 
> Hmm?

Grouping near-CCX for the offerings that do not have 2CCX per CCD will
prevent degenration and limit the search scope yes. Here is what I'll
do, let me check if limiting search scope helps first, and then start
fiddling with the topology. How does that sound?

--
Thanks and Regards,
Prateek
