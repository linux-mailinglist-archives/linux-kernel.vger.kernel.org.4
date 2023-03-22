Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DFF6C46A8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjCVJie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCVJia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:38:30 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B46C1989
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:38:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZybKDpv7nh5eRxomp+vZZ7ivwndXBrO9OBuLKg3S6v9NcdvZlWhwUPwNgVebv3r3PtShLAsIxarZ/Hv4HiLQ/9rZyV4J38IR8wksWBcaIri6IeUuzP+/vd4lBD6av1vS01HOTE+uE4odlZXJd1PXFNA8NnlaLXePkXUtq1rhPb1zN83AGBFDe+NjeoCJXSJqurJvSuPenwPxgfOBO/uOdeoCL6K/troVKOUdBQRsfGUQWm97IHpuP3glP5dvDn19kkzbUDX08nporJ5n7Hfl5X2qy2GnlxMUCPegbj+MmfwIHN0d1e3zrKziYdWcZ2bpB/NfA3tLvlW63TOH8eFZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhLp+aEIOkCKqx2ruk+lTi0kgVW0qV37x1ag3Q1Vu6U=;
 b=bTpI/pwVzu4gO+JHvj9Tz4oPQ+26h0Q88FKH+JXFkvxl76MQVvH+d8Y4qTESV6RGSIgEEL3XE7hbRtyj4H6UZZXSnSSRe/yVRy2uAN16/oGBB0mggT4At9T9CqYoTvePu7eSrxuRitdeWe28NE9vyHXi4x+OYU9d5yIdiMGprJ58b6/f5S94wwYL3OdLj9Sdckng//iq8bp0xja4RA9HKDM++CPsMW234WEpLi0hZ25MIvmmPdKj7+8qtKjAa1EfH5Amqb15wEx5ioj9co8Imbsc7vDeBopYzDddpmEMatlhWsPf7j8J7M1r80ziPJBdg/jWhcIJZQDoV0wv6LwBjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhLp+aEIOkCKqx2ruk+lTi0kgVW0qV37x1ag3Q1Vu6U=;
 b=eDeXSdFJMQnFz5c6YDmNYIQWb4QqW5rN0F0PoW3eN8CFoc1NvaLSQGwqwQ27AWLF5v3OQLPT7vjUkxYhtN5tWLWdkG2se+jf6r159CQzVW5KQVXHGGE0hTO72PiO4em5HZkmAZpZyQNsPRo+6+6LhaaEI9QZvcmszem9wz09rhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 09:38:26 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::f2f8:a2b0:8e91:de7]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::f2f8:a2b0:8e91:de7%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 09:38:26 +0000
Message-ID: <0e80b9b6-cd71-66d5-f90a-ba8584f8d8df@amd.com>
Date:   Wed, 22 Mar 2023 15:08:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 00/10] sched: EEVDF using latency-nice
Content-Language: en-US
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
References: <20230306132521.968182689@infradead.org>
 <18199afa-16e2-8e76-c96b-9507f92befdc@amd.com>
In-Reply-To: <18199afa-16e2-8e76-c96b-9507f92befdc@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::10) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bfed4e2-c368-43e2-82f0-08db2ab92f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +iyEARCF2UdOBqgRegun2O56I98vm587ZtHLJcFmMMRdMiZgkVkLF5yS5vP7DebDYAWe8KvDlsuCwboucXuffd5cT2vUipbN0vobne8ozFd8RiOzV8uDjH7Y8xkrshpzlgVngX2GPlwcNEATxbmB5T/1N17zmusDMcAzdyhC/iKX6tIFOsfVfjH09q4rK1jzUGTU7LEaG6mryv8nw3y8xjOhysl14+9ooDeVB8g9IxAyWR5Y9+ROWmyhrzpObSGpAxsUi3fA3xxoTsU13ooTZ7lrpmrG5fexlCo3/B9COwxUEjSrnDUA34roUg73g/+cpHBcKmTDYbKbh2v/59RSl+lQnjzyjMHBf7k8qgBuNn6N7IYfY1tYG6pEBbs3p2YguM5OqwWUrrJkUWpsCqgKhG0SqGXKzycNkZ1SUHtqGTWMrIHnCxSvbeTIOEuLz4b5NP0r3aYksLSM91wQXmDgnkeXu8TZVhqZZyHF1GdZ7JdD1UpIAlnCVlpQtrw1Pe7QiVkejszVmqiTfKKM9qefhEyDqJnUi1yZOVfflXCIxGz9MOveA22D8NrBetrlZy6qGD6XieSRcRgqpOp+dH8liWTLogZ8oXFsMJhvRPIvn0Ar3NkmrzL6U9AhRoXu3cHs6/LaPPev8+wCh92aTe+Ob8m1tJYN9UEJ0MP5ubEHpRi0eXZKU2OPUM5mwBxECRgr61AvN+qHFeWilI/XxQG2ot9agrb2EAtWd+FV2OyjCLeBRC2mZB87HCtZ8CEizRWws0jrMD1BKpjKYqmtnUS0FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199018)(31686004)(41300700001)(8936002)(2906002)(66899018)(4326008)(8676002)(66946007)(66556008)(66476007)(7416002)(5660300002)(86362001)(316002)(31696002)(6486002)(36756003)(478600001)(6512007)(6666004)(26005)(6506007)(53546011)(186003)(83380400001)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjVqYVBvMnI3SkNuM3VpTGVlUzFoNE8yRzhBcWVNVDlmK1Jqb2JGem44NFo5?=
 =?utf-8?B?Ujc3K2YyNnFOcXc4Q3VOV2ZDZVZKd3J6c0JoQmtidzQrL0x3LzduZlBUSTZH?=
 =?utf-8?B?bURwVGR3NDlqUUtvYW1FekU2K3RCdWFud1VUZXROaXZKaGlFaEI3bW1VOU1S?=
 =?utf-8?B?aGZMdTRieUNyM1BOK1pVNE1NMkpTOVBiSVJYSUZoVlRWMGdPTFZaWUNkUkVT?=
 =?utf-8?B?M3RIM1R5UEpzUlQ1NzJJczlLODJzRCtaTjZ3TWhNYWxKUkIzRGc3UjczQlhx?=
 =?utf-8?B?YXZxRldmMVh1cldvaHk1N2pXN081MHd3cjdmV29sQ3VMNFZkaC95QjZ0a2ZR?=
 =?utf-8?B?c3UybUdHaWQ2a1NsNkZoUzQ1Q0xENDNGOS9rZXBRbkd0UjBQaU5TR0V3SkRs?=
 =?utf-8?B?NTVaZ3c5NXc1UmxaS2ZYbVBpbVBYdlJsRGlKKzRvWjBIWUp3c0FZbEk5KzE4?=
 =?utf-8?B?N0NyTGRpSkpNVEdKSFVQdFhNeTRwbkYvSGdVUnA4MlNxR3RtRG03WE55alVB?=
 =?utf-8?B?akJYOFkxVDJnOW9MNEp0VEpkb05ibDJWSElEbG1kY3Fsd0h0RTlZaEFHVDQ1?=
 =?utf-8?B?OTN2cm5MNTRsT2FpUnNJZCtKYlBzeGMwckMzVWpzekpoOG5MazM1SUVkWDl5?=
 =?utf-8?B?bnJqS2ZDUlh5L1U0ZFRVVW9hQ3IzblcwTDkwazNDbStHVUZmbjZ5dER5eGZX?=
 =?utf-8?B?YjZLOUg1Zi9jeHNVVkUrWHpqYTYvdnNWNm5mTUxBbzNneVZ6SGZBYlp1amJS?=
 =?utf-8?B?Tk5VQW9LK0psK2pjTWRWWGc5OG82UGNSSU1PTHFtQVlIV09iVldHcHBwdThl?=
 =?utf-8?B?T0NXUjFOQ0tUNituU2xSNGJWTHYyUlZNUjJtZzJWU1d5aW9vc0lFTXRrRzVa?=
 =?utf-8?B?MXVuWmFzc2FFdUY5a3paL20yczNyY0k2RFJpd3g2Uk5KN1JjN1ZNMG1HS093?=
 =?utf-8?B?Szl1a0R4RllneDVuc2tyTFdwV2VYdmVid0pIbS9weG1qQ0dsaTNSUjM3YU5X?=
 =?utf-8?B?anpmblRnaXhONGR2T05NdHBRakJBWGFmWjBqeWZ0SHA5ZFJMYWhWYVptd05E?=
 =?utf-8?B?UDlNMlh0M2l2cjkrU2x3R0MwZ0FIN09BZDliZy81QzIybmJRVkpDK1FXd0RN?=
 =?utf-8?B?aHMwVnRWSnRTRTdxVFZQd3piWHIwc1Z6cEwvTStYRlFpNHBoOXEyWlBveVA5?=
 =?utf-8?B?bzM1UlEybWtoTUduOXp0WlhTSVdTbnIvSzR2b0M0Qm5nS2Q0NWxqREJvejhB?=
 =?utf-8?B?S281U3o0SjkyZzhzZWVhMWl0K3ZmMTgwSDRYYU13aVNEdEVHaDJqNlFuaEo1?=
 =?utf-8?B?bFVPOWVON2h1N2pJVWhyOHEraFJYbGh0VzczRGJsSklHenlESkxnR1Y0WlFK?=
 =?utf-8?B?bitYaER5SlR0QVZaaDRFcTNkZURYSDRlYS9hbVdQQXl4elpoVmt4d2ZPWDlZ?=
 =?utf-8?B?K0UxaHhqMlBoOThVa3NsUU5qUThlNzhOVW1JY0p5cVlkbTN4WldtR0lMd21R?=
 =?utf-8?B?YjhrZmZXSnM4b1ordU1vZUJyK1hKS0g5K3I3VFBCa1V0Tkh1NjhJTUl3bDFO?=
 =?utf-8?B?K0ZQelZBVFNiOXgydG4wbWd3SlJIaWs5SFhtMmx2Y3VFb0JzbEhhOExZZkU5?=
 =?utf-8?B?RnBJaDAzTTZnSU1VRnNEQnVqUlRPSW40RWoyTk1oZWFVMmpZUkx6NkE1UnJE?=
 =?utf-8?B?b2tzRDdFajk1YkQvUHN0NFZLclAvUjNOSzgvUndOUS9lWEZIcmdIWVFaemlT?=
 =?utf-8?B?SmVFdWZpc3k2aVc1UXkrMk9RbVphUnh0RVFlMncwWjdyK0d2OWtSeExyS24w?=
 =?utf-8?B?ckxmZUdiUUY5R2dHS3hpRkEwMjBjOTQ1Y2lBR3FKdG9kd1pjKzhmQXNsL0RM?=
 =?utf-8?B?dEZrckhKYjY3emtDSzNDTzRCU05jNnV3dGMzQ3E5OVp3MEtZZm1mSUk4Zk1q?=
 =?utf-8?B?SHdYN09kTGJyUGlCWDBGc3FFeFIyYTM3a3JFWU9neEF5WG9MSDRnakdQQlFz?=
 =?utf-8?B?OFh0TCswTnBVTXhXZVQ0d0xsbUY3V0tMZWpIWndIaTZBNCt0NHNyK0hubW94?=
 =?utf-8?B?TUM1TXhNWEZtQ1hKeVJvWGY5ZXFpUVBpektzclBCdkR0U0VQOTkvanBrWm40?=
 =?utf-8?Q?EjUWf6ZEdkXj3Hw6NZLFbkB0Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfed4e2-c368-43e2-82f0-08db2ab92f6b
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 09:38:25.9854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vokv17hCpzVK9JOteABHKbusPNIl+SCExLiLVMQDfZpq7n7xpCBnGmBzNbNsqPrJERkt138XqBC6GFNQvHEojQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

One important detail I forgot to mention: When I picked eevdf commits
from your tree
(https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=sched/core),
they were based on v6.3-rc1 with the sched/eevdf HEAD at:

commit: 0dddbc0b54ad ("sched/fair: Implement an EEVDF like policy")

On 3/22/2023 12:19 PM, K Prateek Nayak wrote:
> Hello Peter,
> 
> Leaving some results from my testing on a dual socket Zen3 machine
> (2 x 64C/128T) below.
> 
> tl;dr
> 
> o I've not tested workloads with nice and latency nice yet focusing more
>   on the out of the box performance. No changes to sched_feat were made
>   for the same reason. 
> 
> o Except for hackbench (m:n communication relationship), I do not see any
>   regression for other standard benchmarks (mostly 1:1 or 1:n) relation
>   when system is below fully loaded.
> 
> o At fully loaded scenario, schbench seems to be unhappy. Looking at the
>   data from /proc/<pid>/sched for the tasks with schedstats enabled,
>   there is an increase in number of context switches and the total wait
>   sum. When system is overloaded, things flip and the schbench tail
>   latency improves drastically. I suspect the involuntary
>   context-switches help workers make progress much sooner after wakeup
>   compared to tip thus leading to lower tail latency.
> 
> o For the same reason as above, tbench throughput takes a hit with
>   number of involuntary context-switches increasing drastically for the
>   tbench server. There is also an increase in wait sum noticed.
> 
> o Couple of real world workloads were also tested. DeathStarBench
>   throughput tanks much more with the updated version in your tree
>   compared to this series as is.
>   SpecJBB Max-jOPS sees large improvements but comes at a cost of
>   drop in Critical-jOPS signifying an increase in either wait time
>   or an increase in involuntary context-switches which can lead to
>   transactions taking longer to complete.
> 
> o Apart from DeathStarBench, the all the trends reported remain same
>   comparing the version in your tree and this series, as is, applied
>   on the same base kernel.
> 
> I'll leave the detailed results below and some limited analysis. 
> 
> On 3/6/2023 6:55 PM, Peter Zijlstra wrote:
>> Hi!
>>
>> Ever since looking at the latency-nice patches, I've wondered if EEVDF would
>> not make more sense, and I did point Vincent at some older patches I had for
>> that (which is here his augmented rbtree thing comes from).
>>
>> Also, since I really dislike the dual tree, I also figured we could dynamically
>> switch between an augmented tree and not (and while I have code for that,
>> that's not included in this posting because with the current results I don't
>> think we actually need this).
>>
>> Anyway, since I'm somewhat under the weather, I spend last week desperately
>> trying to connect a small cluster of neurons in defiance of the snot overlord
>> and bring back the EEVDF patches from the dark crypts where they'd been
>> gathering cobwebs for the past 13 odd years.
>>
>> By friday they worked well enough, and this morning (because obviously I forgot
>> the weekend is ideal to run benchmarks) I ran a bunch of hackbenck, netperf,
>> tbench and sysbench -- there's a bunch of wins and losses, but nothing that
>> indicates a total fail.
>>
>> ( in fact, some of the schbench results seem to indicate EEVDF schedules a lot
>>   more consistent than CFS and has a bunch of latency wins )
>>
>> ( hackbench also doesn't show the augmented tree and generally more expensive
>>   pick to be a loss, in fact it shows a slight win here )
>>
>>
>>   hackbech load + cyclictest --policy other results:
>>
>>
>> 			EEVDF			 CFS
>>
>> 		# Min Latencies: 00053
>>   LNICE(19)	# Avg Latencies: 04350
>> 		# Max Latencies: 76019
>>
>> 		# Min Latencies: 00052		00053
>>   LNICE(0)	# Avg Latencies: 00690		00687
>> 		# Max Latencies: 14145		13913
>>
>> 		# Min Latencies: 00019
>>   LNICE(-19)	# Avg Latencies: 00261
>> 		# Max Latencies: 05642
>>
> 
> Following are the results from testing the series on a dual socket
> Zen3 machine (2 x 64C/128T):
> 
> NPS Modes are used to logically divide single socket into
> multiple NUMA region.
> Following is the NUMA configuration for each NPS mode on the system:
> 
> NPS1: Each socket is a NUMA node.
>     Total 2 NUMA nodes in the dual socket machine.
> 
>     Node 0: 0-63,   128-191
>     Node 1: 64-127, 192-255
> 
> NPS2: Each socket is further logically divided into 2 NUMA regions.
>     Total 4 NUMA nodes exist over 2 socket.
>    
>     Node 0: 0-31,   128-159
>     Node 1: 32-63,  160-191
>     Node 2: 64-95,  192-223
>     Node 3: 96-127, 223-255
> 
> NPS4: Each socket is logically divided into 4 NUMA regions.
>     Total 8 NUMA nodes exist over 2 socket.
>    
>     Node 0: 0-15,    128-143
>     Node 1: 16-31,   144-159
>     Node 2: 32-47,   160-175
>     Node 3: 48-63,   176-191
>     Node 4: 64-79,   192-207
>     Node 5: 80-95,   208-223
>     Node 6: 96-111,  223-231
>     Node 7: 112-127, 232-255
> 
> Kernel versions:
> - tip:          6.2.0-rc6 tip sched/core
> - eevdf: 	6.2.0-rc6 tip sched/core
> 		+ eevdf commits from your tree
> 		(https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/eevdf)

I had cherry picked the following commits for eevdf:

commit: b84a8f6b6fa3 ("sched: Introduce latency-nice as a per-task attribute")
commit: eea7fc6f13b4 ("sched/core: Propagate parent task's latency requirements to the child task")
commit: a143d2bcef65 ("sched: Allow sched_{get,set}attr to change latency_nice of the task")
commit: d9790468df14 ("sched/fair: Add latency_offset")
commit: 3d4d37acaba4 ("sched/fair: Add sched group latency support")
commit: 707840ffc8fa ("sched/fair: Add avg_vruntime")
commit: 394af9db316b ("sched/fair: Remove START_DEBIT")
commit: 89b2a2ee0e9d ("sched/fair: Add lag based placement")
commit: e3db9631d8ca ("rbtree: Add rb_add_augmented_cached() helper")
commit: 0dddbc0b54ad ("sched/fair: Implement an EEVDF like policy")

from the sched/eevdf branch in your tree onto the tip branch back when
I started testing. I notice some more changes have been added since then.
Queuing testing of latest changes on the updated tip:sched/core based
on v6.3-rc3. I was able to cherry pick the latest commits from
sched/eevdf cleanly.

> 
> - eevdf prev:	6.2.0-rc6 tip sched/core + this series as is
> 
> When the testing started, the tip was at:
> commit 7c4a5b89a0b5 "sched/rt: pick_next_rt_entity(): check list_entry"
> [..snip..]
> 
--
Thanks and Regards,
Prateek
