Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B78E6C4385
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCVGti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCVGth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:49:37 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418EC30E1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJXHHrTOX3sROrZrAI0MrqVpyAsv4zpXLNEg9TrTyyQ8F0dT1pXwT0nofTqhdWiMje5453/YkX+/hiabCH2MInq2/5X0qYTC58ElPEsFBM10S1z0S2VfSF4hS4b1fq2F74lHZ3TZ7H95PaYZufBYg+Yddh6aZ/q2l3AZrfF+YbGIxGciwW/Re0V5qcFsZpuEdEu5wQG/YZL7GhS4SdImMNt34yCZys4EHcQEU1XVQJVAUtLuGJTpPw24J03dlU0INOWlTsOggCsmotrIRXymACx+aiiufFtuSNVHmDn22JiYaT7tVb/dAT82YipjMfIjoCpjKAYz7Ix5v3lQ6r0qhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fr2vviSSsjGWxoeyx2t24gB9mcvj9FQi9ulRo9WUdXA=;
 b=Txg6IcK6lF2+aSmpIQG8dBfNSJFQfKFwgrxp2kDxohpHjANclbmWIjRDVpzmMHYr09TQuPMWipvZtUkt+DH83f075X+PNIYweKu2ccGjNy+EDFWVOsvPyNOu9r1QdYSQugxGm5TvR4BU1rimvIF8Gu0K8w4f/CC9yre3iiZ2F/VEll0hOCGCUxm/j5kthq/jYfUxx7gtV2umC3Bys6nkbTQhVVaXFGNcCZp0u2FKf1A4xqEyEyoLVNjTwBPCdVjZpg5lMCc6vI0zBuPhdJE160D8eydbUxd5X42JIkxcBZsyMZd7ShZ9NVa/z4Fdj2ozUIozDEWe3CQC4IzIfJiPEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fr2vviSSsjGWxoeyx2t24gB9mcvj9FQi9ulRo9WUdXA=;
 b=TvixLItdrR6w+S8caG5zuUVqomQPDyRM5lBBOFcmxe+j7ZXMlBTKewv+hev/o3VvEHCN+v/XkCzUt9IIsIu/GDM7zQzy8h2vGdbyv2btq9EBqQFkNRMXl0TlVlNpwY0lQZu51vcPsDPxg2989qCUgnfy5B13BiDif8HRw+Z24Tk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 06:49:31 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::f2f8:a2b0:8e91:de7]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::f2f8:a2b0:8e91:de7%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 06:49:30 +0000
Message-ID: <18199afa-16e2-8e76-c96b-9507f92befdc@amd.com>
Date:   Wed, 22 Mar 2023 12:19:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 00/10] sched: EEVDF using latency-nice
Content-Language: en-US
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
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230306132521.968182689@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::21) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|MN0PR12MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 38895964-a09b-4baa-4eb2-08db2aa195ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +c4m28faFm7jaYOmQpNFYZHbMTK7X7LIVMTjjArNa5/fqqgugpecknC8juSqBKalbKWhaoCblAlmwafEymxbz/0ARFKfriqL9oVZZmANNFHDIkJNNeFE+0F3+B0XHZCYVxZrnwz6/bJW4nJBUEFh1e16PC9wdmsduYeHxbiHD3OlGmn9RJJI9RU2eBVXEyv+zNYvnzcSse8F6xT0fzBprtkDQqvA5UFRkiWN9HKOdYU7nGrgNHVx67R+3nxcExdLpC5Yj7OUVSmy+JJ7Esr1SZqdPI2jOmhn/3C7/XwaeP5mVYtSzhTJX2xNHFeQ5+EmYAvsdj7uD0esxHRrBMdxUse7nRSQzgiuHl67NEAx7eBQ//vaYB09QT0muLTnPrUwqOdjrib1lwSHpK4Dxl4xmxI3clpMFI6U5wCg1S7dEDv0y4MwnjNPSyNAKuBHoXh0T9VRncUyUXClKLXDNoplbCJGWsaN5KvxglUyuHbkqd+YCNVEngbt/n3r/Ng7us/y2fLsg1S9EgTpxkVCfR9hv8kzRguI+AII1abAEF1AvZjYNsLYCUa45fZv8M1HYiO2CScXFx9wdDKx//A33xnaivprMONXA1YuFe96MZwOf0dGlBokwitwWxEYaoOmTGdJdwPVrFgiHUrgQFuKdUubx4XGfzjUrvsiz9rMqcclU02vAY1e3LeUCBrIq+B6NjXUSZFNeih1KmFVmJY2mK75fXYTgS6PH6z5APoNyPqm260=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199018)(2616005)(186003)(6486002)(478600001)(83380400001)(6666004)(316002)(66556008)(66476007)(66946007)(8676002)(26005)(53546011)(6506007)(66899018)(4326008)(41300700001)(6512007)(31686004)(7416002)(8936002)(30864003)(5660300002)(38100700002)(2906002)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1d4QUowVGJzWmlLNTZ5VE4vUytmUTZRNXo2MjV2SzRuMUQvT1JuVFFmb3dp?=
 =?utf-8?B?SU00bWx4SFhVMEdxSGROY3pUMWQyMXVnRWljaUI1Skk4Yk14SktaNnVKbVJV?=
 =?utf-8?B?OVZjUW12NVhSMWpERk5XM2FPRE5WbldaL3IyajRrc0ZockxiZWp3Mk1YckFF?=
 =?utf-8?B?ZzhpOXRoUEhIM2ZPNUtvNUFJQW5ET05KNW9uUDF6MjJaTE5hZHNBTms3L0Jo?=
 =?utf-8?B?RXduc2NmQWJDaHdNZnlaSk5kcEx3KzVsaThMakJoTE41UGRiWXVzU1o2R2Yy?=
 =?utf-8?B?UDI4ZW1VZ2J1YytRWHNuRktaVTRWdGNiN2lqUFFwRURteUloc2hWUk14VXNO?=
 =?utf-8?B?QnJIeXdiZmkyTFF3eERuZGk5L1RYc0tvZys3ZEk1V0YxL2NUSVd0NWRDbTkv?=
 =?utf-8?B?N1lLSTQwSm1mc2JnbVN6QjJtZlV2dFhaNWNEOHAraElYS1lwQ2tEMnczWm5k?=
 =?utf-8?B?RUhtc1dxYjJ1dldsb3NSSXEyUFgybDl4RzE4UmJHOGd1eGdmdDQzdzdxZ2Qv?=
 =?utf-8?B?ZFNJelcvK2QrMDlWMDh0QlJ5VXJTa0prTC9nODhqaHczcmtWRGhuWDVvNlJi?=
 =?utf-8?B?b1dkSVEzUVBOY2loMURwbjRQRG14Mmpha1hIczRaclVzSllEOXVrUktoWGlG?=
 =?utf-8?B?VkpIZ1NkbWtlclgzME93cUhlc2h2eUtTZzRHUmtONnIvd0hXY20xeDJFSCta?=
 =?utf-8?B?T3pNcTF2Ym5VVjFjWEhYLytEdklrYUltTnMzTUtHUHpFWVBpWXo4TnVFaTVY?=
 =?utf-8?B?a0RFU3JPcjk3em5YeGc3S0VodU03UkxkdVBQRmlTa25LdzlxNmFxdWdyOG9W?=
 =?utf-8?B?ZVdxRndneXhiZzc3MGoyZUw1M2dXNXhPWDl2MVpWS2p3MEJjSVcvKzh2NW9k?=
 =?utf-8?B?OURLdzVGSzVKdlVKTldwaHduc1ZGN0lSRFBDaTV0MlpURS8rOG1mMW9QZkxN?=
 =?utf-8?B?ZVVXeEI3NUFJSGEvSHdMendVYjgvVU5TSUZHU1M1bU9ZWkZYZnU4c1JxRXBy?=
 =?utf-8?B?SjRaTHBPTDRLZVptYWVubUJHUys4bVR5UnlFRXpkVnNFMjZBVkIwQWRKRmNn?=
 =?utf-8?B?V2J2ZnFPRFhxN2tsWFFyYUNxL0xKVVBMdUZiSk9NNHpxMlJBUVhwaWtMc1dW?=
 =?utf-8?B?cW51eUVGbWk0N1BFODYzNEpBRmVxTUVOOWZXaFhubDJCZFRDTHRxaHgzejlo?=
 =?utf-8?B?VjcyZkpKNFc5Um5ISnFsdzZYNk01SlZZWWw2bXRDRmNtNlRIY3dmdkF3RTRp?=
 =?utf-8?B?V2hVWDNDKzI4ei81SllIeFA5ampVZUc2K05wcUZHdVhrbktFYWFEdDNRTkhI?=
 =?utf-8?B?NXdMb0NvREtwOWRmeWE2YXh3MFhuTlMvclVlL2lPMkM2MU9pOUppOEhFUkFj?=
 =?utf-8?B?OVpoVHlGMlN4RjhCTHVpOUlOY0ZjellXbTZCWWw5cEExNzYzUGh4Q0Y1QVdh?=
 =?utf-8?B?YU1xdEVhYkJnMEErSnY1dnJyUDhKenB6SGVKYU80Z1B6ZTFpZ0QwemxiNXZH?=
 =?utf-8?B?N3lYeC85aHNybVdmQ2MwRzlGSUEyZExBYndyRFIxSmZjQnN2VTN5QUxJSjNT?=
 =?utf-8?B?YnREbTNPeXIzOUdBYVpDNDJ1dVlhOGNBOGFqQnhOMDdJRTlXWmM0Y2U0NVhW?=
 =?utf-8?B?MTRGUFdXaUNrZ3o1QUF2dFp3UEtsR3V3QmVxQlcyTGJCNHNKRlRleDJabGxn?=
 =?utf-8?B?V1ArQTFETGN1TC9OVEI0cHdlOE5nRGF3ME1SMWdYdXBxOGpjQVAyUlgyOVVy?=
 =?utf-8?B?dkc5QXhvbTNBYk50WmlGeDZDTllEOEFoRWFjQ3FURzYvcnNRZGptcmFDMmpw?=
 =?utf-8?B?SzVQTHhVMjViaFhiQU84Ry8vcmdVOGwvM0o5aUUzSERabHd4UFo2a3dWbk0r?=
 =?utf-8?B?d1g0ajhlWEIycjIyOHc4V3B4c1p1b21VSG4rd2xyN1Y5Qk9QM3lzVVNKcTEz?=
 =?utf-8?B?TUs5WWQ0NW5wc0s0anVlaTNQd00zM2dvNmFtL0R0Y2JEMXp4TkpMQXlJVC9z?=
 =?utf-8?B?ajJtSkxQbVYwTUs5dHNQdWcrZVVCOHlCNEY1d2p6Tkk0Mjc1dTBOMlNOT3lN?=
 =?utf-8?B?ZXpnQlo1dFZxdVozZDdPaXFXWURHOHplNnVsbE4weFo4L01CdEYxUEs4NHU2?=
 =?utf-8?Q?/jvPY1KFFJbr6H3jJbF+rekP9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38895964-a09b-4baa-4eb2-08db2aa195ec
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 06:49:30.3793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73lvDpDQS2pAsI+4HZ6Bf6U3yKLUW5OLhIR09x62AUriNDpPd5Opm1qiv/GsB0fKsMkFrat+PEWL9/Un400O3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953
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

Leaving some results from my testing on a dual socket Zen3 machine
(2 x 64C/128T) below.

tl;dr

o I've not tested workloads with nice and latency nice yet focusing more
  on the out of the box performance. No changes to sched_feat were made
  for the same reason. 

o Except for hackbench (m:n communication relationship), I do not see any
  regression for other standard benchmarks (mostly 1:1 or 1:n) relation
  when system is below fully loaded.

o At fully loaded scenario, schbench seems to be unhappy. Looking at the
  data from /proc/<pid>/sched for the tasks with schedstats enabled,
  there is an increase in number of context switches and the total wait
  sum. When system is overloaded, things flip and the schbench tail
  latency improves drastically. I suspect the involuntary
  context-switches help workers make progress much sooner after wakeup
  compared to tip thus leading to lower tail latency.

o For the same reason as above, tbench throughput takes a hit with
  number of involuntary context-switches increasing drastically for the
  tbench server. There is also an increase in wait sum noticed.

o Couple of real world workloads were also tested. DeathStarBench
  throughput tanks much more with the updated version in your tree
  compared to this series as is.
  SpecJBB Max-jOPS sees large improvements but comes at a cost of
  drop in Critical-jOPS signifying an increase in either wait time
  or an increase in involuntary context-switches which can lead to
  transactions taking longer to complete.

o Apart from DeathStarBench, the all the trends reported remain same
  comparing the version in your tree and this series, as is, applied
  on the same base kernel.

I'll leave the detailed results below and some limited analysis. 

On 3/6/2023 6:55 PM, Peter Zijlstra wrote:
> Hi!
> 
> Ever since looking at the latency-nice patches, I've wondered if EEVDF would
> not make more sense, and I did point Vincent at some older patches I had for
> that (which is here his augmented rbtree thing comes from).
> 
> Also, since I really dislike the dual tree, I also figured we could dynamically
> switch between an augmented tree and not (and while I have code for that,
> that's not included in this posting because with the current results I don't
> think we actually need this).
> 
> Anyway, since I'm somewhat under the weather, I spend last week desperately
> trying to connect a small cluster of neurons in defiance of the snot overlord
> and bring back the EEVDF patches from the dark crypts where they'd been
> gathering cobwebs for the past 13 odd years.
> 
> By friday they worked well enough, and this morning (because obviously I forgot
> the weekend is ideal to run benchmarks) I ran a bunch of hackbenck, netperf,
> tbench and sysbench -- there's a bunch of wins and losses, but nothing that
> indicates a total fail.
> 
> ( in fact, some of the schbench results seem to indicate EEVDF schedules a lot
>   more consistent than CFS and has a bunch of latency wins )
> 
> ( hackbench also doesn't show the augmented tree and generally more expensive
>   pick to be a loss, in fact it shows a slight win here )
> 
> 
>   hackbech load + cyclictest --policy other results:
> 
> 
> 			EEVDF			 CFS
> 
> 		# Min Latencies: 00053
>   LNICE(19)	# Avg Latencies: 04350
> 		# Max Latencies: 76019
> 
> 		# Min Latencies: 00052		00053
>   LNICE(0)	# Avg Latencies: 00690		00687
> 		# Max Latencies: 14145		13913
> 
> 		# Min Latencies: 00019
>   LNICE(-19)	# Avg Latencies: 00261
> 		# Max Latencies: 05642
> 

Following are the results from testing the series on a dual socket
Zen3 machine (2 x 64C/128T):

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

Kernel versions:
- tip:          6.2.0-rc6 tip sched/core
- eevdf: 	6.2.0-rc6 tip sched/core
		+ eevdf commits from your tree
		(https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/eevdf)

- eevdf prev:	6.2.0-rc6 tip sched/core + this series as is

When the testing started, the tip was at:
commit 7c4a5b89a0b5 "sched/rt: pick_next_rt_entity(): check list_entry"

Benchmark Results:

~~~~~~~~~~~~~
~ hackbench ~
~~~~~~~~~~~~~

o NPS1

Test:			tip			eevdf
 1-groups:	   4.63 (0.00 pct)	   4.52 (2.37 pct)
 2-groups:	   4.42 (0.00 pct)	   5.41 (-22.39 pct)	*
 4-groups:	   4.21 (0.00 pct)	   5.26 (-24.94 pct)	*
 8-groups:	   4.95 (0.00 pct)	   5.01 (-1.21 pct)
16-groups:	   5.43 (0.00 pct)	   6.24 (-14.91 pct)	*

o NPS2

Test:			tip			eevdf
 1-groups:	   4.68 (0.00 pct)	   4.56 (2.56 pct)
 2-groups:	   4.45 (0.00 pct)	   5.19 (-16.62 pct)	*
 4-groups:	   4.19 (0.00 pct)	   4.53 (-8.11 pct)	*
 8-groups:	   4.80 (0.00 pct)	   4.81 (-0.20 pct)
16-groups:	   5.60 (0.00 pct)	   6.22 (-11.07 pct)	*

o NPS4

Test:			tip			eevdf
 1-groups:	   4.68 (0.00 pct)	   4.57 (2.35 pct)
 2-groups:	   4.56 (0.00 pct)	   5.19 (-13.81 pct)	*
 4-groups:	   4.50 (0.00 pct)	   4.96 (-10.22 pct)	*
 8-groups:	   5.76 (0.00 pct)	   5.49 (4.68 pct)
16-groups:	   5.60 (0.00 pct)	   6.53 (-16.60 pct)	*

~~~~~~~~~~~~
~ schbench ~
~~~~~~~~~~~~

o NPS1

#workers:	tip			eevdf
  1:	  36.00 (0.00 pct)	  36.00 (0.00 pct)
  2:	  37.00 (0.00 pct)	  37.00 (0.00 pct)
  4:	  38.00 (0.00 pct)	  39.00 (-2.63 pct)
  8:	  52.00 (0.00 pct)	  50.00 (3.84 pct)
 16:	  66.00 (0.00 pct)	  68.00 (-3.03 pct)
 32:	 111.00 (0.00 pct)	 109.00 (1.80 pct)
 64:	 213.00 (0.00 pct)	 212.00 (0.46 pct)
128:	 502.00 (0.00 pct)	 637.00 (-26.89 pct)	*
256:	 45632.00 (0.00 pct)	 24992.00 (45.23 pct)	^
512:	 78720.00 (0.00 pct)	 44096.00 (43.98 pct)	^

o NPS2

#workers:	tip			eevdf
  1:	  31.00 (0.00 pct)	  23.00 (25.80 pct)
  2:	  32.00 (0.00 pct)	  33.00 (-3.12 pct)
  4:	  39.00 (0.00 pct)	  37.00 (5.12 pct)
  8:	  52.00 (0.00 pct)	  49.00 (5.76 pct)
 16:	  67.00 (0.00 pct)	  68.00 (-1.49 pct)
 32:	 113.00 (0.00 pct)	 112.00 (0.88 pct)
 64:	 213.00 (0.00 pct)	 214.00 (-0.46 pct)
128:	 508.00 (0.00 pct)	 491.00 (3.34 pct)
256:	 46912.00 (0.00 pct)	 22304.00 (52.45 pct)	^
512:	 76672.00 (0.00 pct)	 42944.00 (43.98 pct)	^

o NPS4

#workers:	tip			eevdf
  1:	  33.00 (0.00 pct)	  30.00 (9.09 pct)
  2:	  40.00 (0.00 pct)	  36.00 (10.00 pct)
  4:	  44.00 (0.00 pct)	  41.00 (6.81 pct)
  8:	  73.00 (0.00 pct)	  73.00 (0.00 pct)
 16:	  71.00 (0.00 pct)	  71.00 (0.00 pct)
 32:	 111.00 (0.00 pct)	 115.00 (-3.60 pct)
 64:	 217.00 (0.00 pct)	 211.00 (2.76 pct)
128:	 509.00 (0.00 pct)	 553.00 (-8.64 pct)	*
256:	 44352.00 (0.00 pct)	 26848.00 (39.46 pct)	^
512:	 75392.00 (0.00 pct)	 44352.00 (41.17 pct)	^


~~~~~~~~~~
~ tbench ~
~~~~~~~~~~

o NPS1

Clients:	tip			eevdf
    1	 483.10 (0.00 pct)	 476.46 (-1.37 pct)
    2	 956.03 (0.00 pct)	 943.12 (-1.35 pct)
    4	 1786.36 (0.00 pct)	 1760.64 (-1.43 pct)
    8	 3304.47 (0.00 pct)	 3105.19 (-6.03 pct)
   16	 5440.44 (0.00 pct)	 5609.24 (3.10 pct)
   32	 10462.02 (0.00 pct)	 10416.02 (-0.43 pct)
   64	 18995.99 (0.00 pct)	 19317.34 (1.69 pct)
  128	 27896.44 (0.00 pct)	 28459.38 (2.01 pct)
  256	 49742.89 (0.00 pct)	 46371.44 (-6.77 pct)	*
  512	 49583.01 (0.00 pct)	 45717.22 (-7.79 pct)	*
 1024	 48467.75 (0.00 pct)	 43475.31 (-10.30 pct)	*

o NPS2

Clients:	tip			eevdf
    1	 472.57 (0.00 pct)	 475.35 (0.58 pct)
    2	 938.27 (0.00 pct)	 942.19 (0.41 pct)
    4	 1764.34 (0.00 pct)	 1783.50 (1.08 pct)
    8	 3043.57 (0.00 pct)	 3205.85 (5.33 pct)
   16	 5103.53 (0.00 pct)	 5154.94 (1.00 pct)
   32	 9767.22 (0.00 pct)	 9793.81 (0.27 pct)
   64	 18712.65 (0.00 pct)	 18601.10 (-0.59 pct)
  128	 27691.95 (0.00 pct)	 27542.57 (-0.53 pct)
  256	 47939.24 (0.00 pct)	 43401.62 (-9.46 pct)	*
  512	 47843.70 (0.00 pct)	 43971.16 (-8.09 pct)	*
 1024	 48412.05 (0.00 pct)	 42808.58 (-11.57 pct)	*

o NPS4

Clients:	tip			eevdf
    1	 486.74 (0.00 pct)	 484.88 (-0.38 pct)
    2	 950.50 (0.00 pct)	 950.04 (-0.04 pct)
    4	 1778.58 (0.00 pct)	 1796.03 (0.98 pct)
    8	 3106.36 (0.00 pct)	 3180.09 (2.37 pct)
   16	 5139.81 (0.00 pct)	 5139.50 (0.00 pct)
   32	 9911.04 (0.00 pct)	 10086.37 (1.76 pct)
   64	 18201.46 (0.00 pct)	 18289.40 (0.48 pct)
  128	 27284.67 (0.00 pct)	 26947.19 (-1.23 pct)
  256	 46793.72 (0.00 pct)	 43971.87 (-6.03 pct)	*
  512	 48841.96 (0.00 pct)	 44255.01 (-9.39 pct)	*
 1024	 48811.99 (0.00 pct)	 43118.99 (-11.66 pct)	*

~~~~~~~~~~
~ stream ~
~~~~~~~~~~

o NPS1

- 10 Runs:

Test:		tip			eevdf
 Copy:	 321229.54 (0.00 pct)	 332975.45 (3.65 pct)
Scale:	 207471.32 (0.00 pct)	 212534.83 (2.44 pct)
  Add:	 234962.15 (0.00 pct)	 243011.39 (3.42 pct)
Triad:	 246256.00 (0.00 pct)	 256453.73 (4.14 pct)

- 100 Runs:

Test:		tip			eevdf
 Copy:	 332714.94 (0.00 pct)	 333183.42 (0.14 pct)
Scale:	 216140.84 (0.00 pct)	 212160.53 (-1.84 pct)
  Add:	 239605.00 (0.00 pct)	 233168.69 (-2.68 pct)
Triad:	 258580.84 (0.00 pct)	 256972.33 (-0.62 pct)

o NPS2

- 10 Runs:

Test:		tip			eevdf
 Copy:	 324423.92 (0.00 pct)	 340685.20 (5.01 pct)
Scale:	 215993.56 (0.00 pct)	 217895.31 (0.88 pct)
  Add:	 250590.28 (0.00 pct)	 257495.12 (2.75 pct)
Triad:	 261284.44 (0.00 pct)	 261373.49 (0.03 pct)

- 100 Runs:

Test:		tip			eevdf
 Copy:	 325993.72 (0.00 pct)	 341244.18 (4.67 pct)
Scale:	 227201.27 (0.00 pct)	 227255.98 (0.02 pct)
  Add:	 256601.84 (0.00 pct)	 258026.75 (0.55 pct)
Triad:	 260222.19 (0.00 pct)	 269878.75 (3.71 pct)

o NPS4

- 10 Runs:

Test:		tip			eevdf
 Copy:	 356850.80 (0.00 pct)	 371230.27 (4.02 pct)
Scale:	 247219.39 (0.00 pct)	 237846.20 (-3.79 pct)
  Add:	 268588.78 (0.00 pct)	 261088.54 (-2.79 pct)
Triad:	 272932.59 (0.00 pct)	 284068.07 (4.07 pct)

- 100 Runs:

Test:		tip			eevdf
 Copy:	 365965.18 (0.00 pct)	 371186.97 (1.42 pct)
Scale:	 246068.58 (0.00 pct)	 245991.10 (-0.03 pct)
  Add:	 263677.73 (0.00 pct)	 269021.14 (2.02 pct)
Triad:	 273701.36 (0.00 pct)	 280566.44 (2.50 pct)

~~~~~~~~~~~~~
~ Unixbench ~
~~~~~~~~~~~~~

o NPS1

Test			Metric	  Parallelism			tip		          eevdf
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      49077561.21 (   0.00%)    49144835.64 (   0.14%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6285373890.61 (   0.00%)  6270537933.92 (  -0.24%)
unixbench-syscall       Amean     unixbench-syscall-1        2664815.40 (   0.00%)     2679289.17 *  -0.54%*
unixbench-syscall       Amean     unixbench-syscall-512      7848462.70 (   0.00%)     7456802.37 *   4.99%*
unixbench-pipe          Hmean     unixbench-pipe-1           2531131.89 (   0.00%)     2475863.05 *  -2.18%*
unixbench-pipe          Hmean     unixbench-pipe-512       305171024.40 (   0.00%)   301182156.60 (  -1.31%)
unixbench-spawn         Hmean     unixbench-spawn-1             4058.05 (   0.00%)        4284.38 *   5.58%*
unixbench-spawn         Hmean     unixbench-spawn-512          79893.24 (   0.00%)       78234.45 *  -2.08%*
unixbench-execl         Hmean     unixbench-execl-1             4148.64 (   0.00%)        4086.73 *  -1.49%*
unixbench-execl         Hmean     unixbench-execl-512          11077.20 (   0.00%)       11137.79 (   0.55%)

o NPS2

Test			Metric	  Parallelism			tip		          eevdf
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      49394822.56 (   0.00%)    49175574.26 (  -0.44%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6267817215.36 (   0.00%)  6282838979.08 *   0.24%*
unixbench-syscall       Amean     unixbench-syscall-1        2663675.03 (   0.00%)     2677018.53 *  -0.50%*
unixbench-syscall       Amean     unixbench-syscall-512      7342392.90 (   0.00%)     7443264.00 *  -1.37%*
unixbench-pipe          Hmean     unixbench-pipe-1           2533194.04 (   0.00%)     2475969.01 *  -2.26%*
unixbench-pipe          Hmean     unixbench-pipe-512       303588239.03 (   0.00%)   302217597.98 *  -0.45%*
unixbench-spawn         Hmean     unixbench-spawn-1             5141.40 (   0.00%)        4862.78 (  -5.42%)    *
unixbench-spawn         Hmean     unixbench-spawn-512          82993.79 (   0.00%)       79139.42 *  -4.64%*    *
unixbench-execl         Hmean     unixbench-execl-1             4140.15 (   0.00%)        4084.20 *  -1.35%*
unixbench-execl         Hmean     unixbench-execl-512          12229.25 (   0.00%)       11445.22 (  -6.41%)    *

o NPS4

Test			Metric	  Parallelism			tip		          eevdf
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      48970677.27 (   0.00%)    49070289.56 (   0.20%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6297506696.81 (   0.00%)  6311038905.07 (   0.21%)
unixbench-syscall       Amean     unixbench-syscall-1        2664715.13 (   0.00%)     2677752.20 *  -0.49%*
unixbench-syscall       Amean     unixbench-syscall-512      7938670.70 (   0.00%)     7972291.60 (  -0.42%)
unixbench-pipe          Hmean     unixbench-pipe-1           2527605.54 (   0.00%)     2476140.77 *  -2.04%*
unixbench-pipe          Hmean     unixbench-pipe-512       305068507.23 (   0.00%)   304114548.50 (  -0.31%)
unixbench-spawn         Hmean     unixbench-spawn-1             5207.34 (   0.00%)        4964.39 (  -4.67%)    *
unixbench-spawn         Hmean     unixbench-spawn-512          81352.38 (   0.00%)       74467.00 *  -8.46%*    *
unixbench-execl         Hmean     unixbench-execl-1             4131.37 (   0.00%)        4044.09 *  -2.11%*
unixbench-execl         Hmean     unixbench-execl-512          13025.56 (   0.00%)       11124.77 * -14.59%*    *

~~~~~~~~~~~
~ netperf ~
~~~~~~~~~~~

o NPS1

                        tip                     eevdf
 1-clients:      107932.22 (0.00 pct)    106167.39 (-1.63 pct)
 2-clients:      106887.99 (0.00 pct)    105304.25 (-1.48 pct)
 4-clients:      106676.11 (0.00 pct)    104328.10 (-2.20 pct)
 8-clients:      98645.45 (0.00 pct)     94076.26 (-4.63 pct)
16-clients:      88881.23 (0.00 pct)     86831.85 (-2.30 pct)
32-clients:      86654.28 (0.00 pct)     86313.80 (-0.39 pct)
64-clients:      81431.90 (0.00 pct)     74885.75 (-8.03 pct)
128-clients:     55993.77 (0.00 pct)     55378.10 (-1.09 pct)
256-clients:     43865.59 (0.00 pct)     44326.30 (1.05 pct)

o NPS2

                        tip                     eevdf
 1-clients:      106711.81 (0.00 pct)    108576.27 (1.74 pct)
 2-clients:      106987.79 (0.00 pct)    108348.24 (1.27 pct)
 4-clients:      105275.37 (0.00 pct)    105702.12 (0.40 pct)
 8-clients:      103028.31 (0.00 pct)    96250.20 (-6.57 pct)
16-clients:      87382.43 (0.00 pct)     87683.29 (0.34 pct)
32-clients:      86578.14 (0.00 pct)     86968.29 (0.45 pct)
64-clients:      81470.63 (0.00 pct)     75906.15 (-6.83 pct)
128-clients:     54803.35 (0.00 pct)     55051.90 (0.45 pct)
256-clients:     42910.29 (0.00 pct)     44062.33 (2.68 pct)

~~~~~~~~~~~
~ SpecJBB ~
~~~~~~~~~~~

o NPS1

			tip		    eevdf
Max-jOPS	       100%		  115.71%	(+15.71%)  ^
Critical-jOPS	       100%		   93.59%	 (-6.41%)  *

~~~~~~~~~~~~~~~~~~
~ DeathStarBench ~
~~~~~~~~~~~~~~~~~~

o NPS1

  #CCX                      	 1 CCX    2 CCX   3 CCX   4 CCX
o eevdf compared to tip		-10.93	 -14.35	  -9.74	  -6.07
o eevdf prev (this sries as is)    
  compared to tip                -1.99    -6.64   -4.99   -3.87

Note: #CCX is the number of LLCs the the services are pinned to.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~ Some Preliminary Analysis ~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tl;dr

- There seems to be an increase in number of involuntary context switches
  when the system is overloaded. This probably allows newly waking task to
  make progress benefiting latency sensitive workload like schbench in
  overloaded scenario compared to tip but hurts tbench performance.
  When system is fully loaded, the larger average wait time seems to hurt
  the schbench performance.
  More analysis is needed to get to the bottom of the problem.

- For hackbench 2 groups scenario, there seems the wait time seems to go up
  drastically.

Scheduler statistics of interest are listed in detail below.

Note: Units of all metrics denoting time is ms. They are processed from
      per-task schedstats in /proc/<pid>/sched.

o Hackbench (2 Groups) (NPS1)

				tip		eevdf			%diff
Comm				sched-messaging	sched-messaging		N/A
Sum of avg_atom			282.0024818	19.04355233		-93.24702669
Average of avg_atom		3.481512121	0.235105584		-93.24702669
Sum of avg_per_cpu		1761.949461	61.52537145		-96.50810805
Average of avg_per_cpu		21.75246248	0.759572487		-96.50810805
Average of avg_wait_time	0.007239228	0.012899105		78.18343632
Sum of nr_switches		4897740		4728784			-3.449672706
Sum of nr_voluntary_switches	4742512		4621606			-2.549408415
Sum of nr_involuntary_switches	155228		107178			-30.95446698
Sum of nr_wakeups		4742648		4623175			-2.51912012
Sum of nr_migrations		1263925		930600			-26.37221354
Sum of sum_exec_runtime		288481.15	262255.2574		-9.091024712
Sum of sum_idle_runtime		2576164.568	2851759.68		10.69788457
Sum of sum_sleep_runtime	76890.14753	78632.31679		2.265789982
Sum of wait_count		4897894		4728939			-3.449543824
Sum of wait_sum			3041.78227	24167.4694		694.5167422

o schbench (2 messengers, 128 workers - fully loaded) (NPS1)

				tip		eevdf		%diff
Comm				schbench	schbench	N/A
Sum of avg_atom			7538.162897	7289.565705	-3.297848503
Average of avg_atom		29.10487605	28.14504133	-3.297848503
Sum of avg_per_cpu		630248.6079	471215.3671	-25.23341406
Average of avg_per_cpu		2433.392309	1819.364352	-25.23341406
Average of avg_wait_time	0.054147456	25.34304285	46703.75524
Sum of nr_switches		85210		88176		3.480812111
Sum of nr_voluntary_switches	83165		83457		0.351109241
Sum of nr_involuntary_switches	2045		4719		130.7579462
Sum of nr_wakeups		83168		83459		0.34989419
Sum of nr_migrations		3265		3025		-7.350689127
Sum of sum_exec_runtime		2476504.52	2469058.164	-0.300680129
Sum of sum_idle_runtime		110294825.8	132520924.2	20.15153321
Sum of sum_sleep_runtime	5293337.741	5297778.714	0.083897408
Sum of sum_block_runtime	56.043253	15.12936	-73.00413664
Sum of wait_count		85615		88606		3.493546692
Sum of wait_sum			4653.340163	9605.221964	106.4156418

o schbench (2 messengers, 256 workers - overloaded) (NPS1)

				tip		eevdf		%diff
Comm				schbench	schbench	N/A
Sum of avg_atom			11676.77306	4803.485728	-58.8629007
Average of avg_atom		22.67334574	9.327156753	-58.8629007
Sum of avg_per_cpu		55235.68013	38286.47722	-30.68524343
Average of avg_per_cpu		107.2537478	74.34267421	-30.68524343
Average of avg_wait_time	2.23189096	2.58191945	15.68304621
Sum of nr_switches		202862		425258		109.6292061
Sum of nr_voluntary_switches	163079		165058		1.213522281
Sum of nr_involuntary_switches	39783		260200		554.0482115
Sum of nr_wakeups		163082		165058		1.211660392
Sum of nr_migrations		44199		54894		24.19738003
Sum of sum_exec_runtime		4586675.667	3963846.024	-13.57910801
Sum of sum_idle_runtime		201050644.2	195126863.7	-2.946412087
Sum of sum_sleep_runtime	10418117.66	10402686.4	-0.148119407
Sum of sum_block_runtime	1548.979156	516.115078	-66.68030838
Sum of wait_count		203377		425792		109.3609405
Sum of wait_sum			455609.3122	1100885.201	141.6292142

o tbench (256 clients - overloaded) (NPS1)

- tbench client
				tip		eevdf		% diff
comm				tbench		tbench		N/A
Sum of avg_atom			3.594587941	5.112101854	42.21663064
Average of avg_atom		0.013986724	0.019891447	42.21663064
Sum of avg_per_cpu		392838.0975	142065.4206	-63.83613975
Average of avg_per_cpu		1528.552909	552.7837377	-63.83613975
Average of avg_wait_time	0.010512441	0.006861579	-34.72895916
Sum of nr_switches		692845080	511780111	-26.1335433
Sum of nr_voluntary_switches	178151085	371234907	108.3820635
Sum of nr_involuntary_switches	514693995	140545204	-72.69344399
Sum of nr_wakeups		178151085	371234909	108.3820646
Sum of nr_migrations		45279		71177		57.19649286
Sum of sum_exec_runtime		9192343.465	9624025.792	4.69610746
Sum of sum_idle_runtime		7125370.721	16145736.39	126.5950365
Sum of sum_sleep_runtime	2222469.726	5792868.629	160.650058
Sum of sum_block_runtime	68.60879	446.080476	550.1797743
Sum of wait_count		692845479	511780543	-26.13352349
Sum of wait_sum			7287852.246	3297894.139	-54.7480653

- tbench server

				tip		eevdf		% diff
Comm				tbench_srv	tbench_srv	N/A
Sum of avg_atom			5.077837807	5.447267364	7.275331971
Average of avg_atom2		0.019758124	0.021195593	7.275331971
Sum of avg_per_cpu		538586.1634	87925.51225	-83.67475471
Average of avg_per_cpu2		2095.666006	342.1226158	-83.67475471
Average of avg_wait_time	0.000827346	0.006505748	686.3392261
Sum of nr_switches		692980666	511838912	-26.13951051
Sum of nr_voluntary_switches	690367607	390304935	-43.46418762
Sum of nr_involuntary_switches	2613059		121533977	4551.023073
Sum of nr_wakeups		690367607	390304935	-43.46418762
Sum of nr_migrations		39486		84474		113.9340526
Sum of sum_exec_runtime		9176708.278	8734423.401	-4.819646259
Sum of sum_idle_runtime		413900.3645	447180.3879	8.040588086
Sum of sum_sleep_runtime	8966201.976	6690818.107	-25.37734345
Sum of sum_block_runtime	1.776413	1.617435	-8.949382829
Sum of wait_count		692980942	511839229	-26.13949418
Sum of wait_sum			565739.6984	3295519.077	482.5150836

> 
> The nice -19 numbers aren't as pretty as Vincent's, but at the end I was going
> cross-eyed from staring at tree prints and I just couldn't figure out where it
> was going side-ways.
> 
> There's definitely more benchmarking/tweaking to be done (0-day already
> reported a stress-ng loss), but if we can pull this off we can delete a whole
> much of icky heuristics code. EEVDF is a much better defined policy than what
> we currently have.
> 

DeathStarBench and SpecJBB and slightly more complex to analyze. I'll
get the schedstat data for both soon. I'll rerun some of the above
workloads with NO_PRESERVE_LAG to see if that makes any difference.
In the meantime, if you need more data from the test system for any
particular workload, please do let me know. I will collect the per-task
and system-wide schedstat data for the workload as it is rather
inexpensive to collect and gives good insights but if you need any
other data, I'll be more than happy to get those too for analysis.

--
Thanks and Regards,
Prateek
