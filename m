Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0E2719707
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjFAJd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjFAJd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:33:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F42124;
        Thu,  1 Jun 2023 02:33:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDVzsl8uzui1p/rbS/LvT/9mdNyO9zUNvbqrwOWFHAx+/DHMtVkgih9XpKg0+TVqu2K2T+YZt7ppDfgv11e62g5NEaPgfqVB8vpix3Ld7kWNzPzpG8Vq+DAE6P+fA0DVj0BCfXPskrYORmxT9PRklJhWN2lCiBik7UMx41Ma5djO+K3SoQp9HHBYXu9+8PbmX/rSro9rO6qzn7siHnSlTkwklr6i87dU4eFi3FeXNB3raxnC915vvZkC2Tth4yYXVGylDPvQNCKny+DFGGbGz7aY//XbVfvN7YWsuHGIrs8npbALisjLPbDLP9N/pk8j+Coy4D9hfoZ2ATtTBA9oVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amtTZKjtjDM98xIXe4i6hzecm7ePvE6y5kTMmXmaIJA=;
 b=a4Fghvp9gbuZvKzSy3SvYn9u/t0LwZwTQgECUF22tMd0ZMDn5rBT6Gz8q+4Y07ZOoNY7Hy4b2jt7f9NtuKqFlpI/IRtKskqqx90WgNjVYVzK4wgqgnKYiaZNHkYg4DrXQEzrBTeuH5iayr3oDiMy6DnDihpxn9WFJ9PtkP9Vi78mUWHKOFvZpUgiC+TQTcxsSaP2kIt4eWT8xRS4QmIx2qsoqCARvEQqME3v2odStl3F6YhY5HNr1q50I/fxItNDRneb7RjcTkJXngCU47VLaJlNwvzu1jDcM2/kxUTNeZiHk20Lni/EruD2V9koYB2HIsnzOOVlOYgFanRsTTI7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amtTZKjtjDM98xIXe4i6hzecm7ePvE6y5kTMmXmaIJA=;
 b=mTrFd3l4l97gIoi0xiuC8KvFmLlWMvBqFbGsXdJTEc5MM+FiAnUeTMc5uEB3ZrglSZjKmMOZQD0HdFYsogn9EzqCQxV5vmlisJ5pdufXC+czJS1+tWNKdi0FNw9/W/xnwdVRP3XBm0usDih2UAy6JKu7cAKBYR6OXHJdwyukLv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 09:33:51 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c%4]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 09:33:50 +0000
Message-ID: <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com>
Date:   Thu, 1 Jun 2023 15:03:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::9) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: c949362b-0029-4eb3-d30b-08db62834e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tb37B3tccCMhvxkzUdIMwhgm/aP294Gud6/Ojs7YJVm7zYy54a1k/Y3p3Eobo2AF/jQrSJyPb7zDBPFbwVtzdqtCV61+IzaN8CbcGdvTFDhG1MMlag2d0RjDgw1fqfXJeTWc1jfQW8Fd1ZzlxomxLt/7rNPmHm7zoo8p7Dg8ALtg7yJUdAgaqANWhf7LwpiZTg2CPbGz5ScNIFVJldo52w9sXUPqBDLyG/OIW1FEQrBOOtgb+tAVr1Hm73k4FqMnn5T4EQkCcg1bhYaelyoIgQ7qHVci9QjEajzNyi8qKc4kPcs6MTJ2M24Ro5xtXt6s2OFYyXQ9pqlpqryi0Js+LkWk8Dgar9TMwdN01uTyUWvfMxpNqzcUZu3UDJGXZ9LuCmjK3BZAVJ+gBAZAu2YZqgOKhWGJctNaUSIR+y3XR8oiWqE1Me62jB0jjeZpocvbFism9/jrD6GUTgycy0d740qrYehOd2pwbxHToTTGmSMyrL48ebm52Ux5IoE5IimKBjkoGThxLt0sXDDkOvrsf9MwA19JgwKO/8zqidPbbMIo3mE+l5LKwnZVte4yU2J8S5sdUEKtA7+ucqUrjqg+pfrN0xqLQsSNpQ1LEdlVswF0amIkTRGDJ2F8asvzKqQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(36756003)(38100700002)(86362001)(31696002)(31686004)(8936002)(8676002)(41300700001)(966005)(5660300002)(26005)(6512007)(6506007)(53546011)(2906002)(186003)(83380400001)(2616005)(6666004)(316002)(66556008)(66476007)(66946007)(6486002)(54906003)(478600001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDFIMGtVYXhkQVNjbk5sbng1T0NQNm5pN2hDbDhReUI4aTQvSWNhWldhc2Np?=
 =?utf-8?B?ckt1Z1Z4djIzNWQzbXFYbS9NZ0tHTy8rbEsrelI0VVQ2UWdqdGJ4MXR0VVdv?=
 =?utf-8?B?UWZtVjhPV09yV2ZNaE1ROC82QW5UVDlVVkszdWpnYXJDNVdKL0ZJa2psSjJK?=
 =?utf-8?B?bEYwa2pQdjIxSEpEVElCYStlUTRrVThNL3F3MUR5TXNacUhvckduSDZaUHMx?=
 =?utf-8?B?QU9aV08vdXpZaGQ5YmNEemNPZzJEU3NoVXdBeFdlU0VlMm1OZ003blovNzJW?=
 =?utf-8?B?Q3c2VGlVSGVMdnd1VUE2MG1zSTBUWUNaNDBXeHVlaEs0bkR4WngxQjVPNUk4?=
 =?utf-8?B?SG9DZjJqaUhCSlg2NG9jaEI1aCszN04rTG51WHpvVFpFTGhPQkJuNGZvRFhm?=
 =?utf-8?B?Tk8xc2V2UzJCTjlycldBMHFyQW5UdHljVXFTV0FuM2NZa3p0WEw1NHVQcWI5?=
 =?utf-8?B?cERNUXNCSzYwV0RlbWpJTTBrVVcrSWhjSFIwYSt2Y28yYXBwT2c2TDdJVGRh?=
 =?utf-8?B?V2czRTAwNE1GWUZwWTRWQkk5QTBVVmpIZWhxL2NkakRqdWtZM2VrU090K1Bj?=
 =?utf-8?B?UFdaY3ZiM0FpSmVpcFNMcjNlelFuVldFUUJWWDFqcG5SeTZjZlkxQ1JwSjJY?=
 =?utf-8?B?UnhOSDdkc2gybEJ2dmhVYk9GN3piUEVHVVVuaDJlK0x4bmFzc1F5aGJGcGNK?=
 =?utf-8?B?T3JEZUpuU1JLWXpzbUdlSzRmU0hGNGlFMVRnZkRkeEx3VFZsOXFuWjJ2SHh5?=
 =?utf-8?B?c3V0NkFDRGNWa1dZcXVkWC9keUNTaFVFMTJkM1JmRDJ4ajhjWm9iYWhWRldz?=
 =?utf-8?B?ZW1pVzk5TmcvYk9aVjVWYXNjZi85QmhkNm94SjVTaUVScGE5M0hZdEVUN1Bm?=
 =?utf-8?B?RENHTlVDVUNHcDlvUEJYYWVvaFlXTXhkcUp6akVVSVhaZm4yNjM0UEo5QnBQ?=
 =?utf-8?B?Y3pxZytzWjJTWWhVSWRyZUFaRnE5RFgrNjN4Q3o2MUd4S3VXMlVKQm9pMGh2?=
 =?utf-8?B?MDgzcGhQU1BMeWEreFFXUEVxN2tTQlhCVVExV1I1dVhIMHJtOUVEUFMrcGlQ?=
 =?utf-8?B?U0tEOEdaVG5DN2RxY0JIRzIyUERzZXh6ZmlzNnBjUkE4dXZJUHhDMU5YRTZ0?=
 =?utf-8?B?ZjNFNTczZ3d1dHM0SGJvMSs5Z1EwcXZwQmIrYnV1NkNoY3VJL3FIU055WmFI?=
 =?utf-8?B?cTliWFU2dmhHSTJ3d3lNaStpdGVud0x3bFFVb3Nzc0lPN2l2Y3Ntb2tBSXNB?=
 =?utf-8?B?anJMVHJjdXNrNlpKeWM1bG9zVVB0bHJ0QUhUaDdLZEpLRU9OcDlxRkdSUlBm?=
 =?utf-8?B?V0NCSmVuTDVVS2ppNFE1Q3dmYyt5R0tHdXd6dUNBTTcvcVV4VkRzWUF0cSsw?=
 =?utf-8?B?eWsyVFE0ZzZnaEVvdlJ3UjJSMDRHYVF0d3ptRkFIbmZBdmt5Szk5ZnNodDR4?=
 =?utf-8?B?N3ZNNGxvS0tRTGRxVE84SnFRYjdxRUVBOFFST0dzL1k1SnZ1Qk1NSHFOS1k5?=
 =?utf-8?B?eDFGZlZzZkZrZnN6NzI0WW9TWWlReHFicGlJSURCT091MDRZRDlhbWJkUTVh?=
 =?utf-8?B?Y2YyMC90WU5RSEh5MDhoQzBEeHV4MTBTOE5XZXpoamtiY01ab1pzend2SFhG?=
 =?utf-8?B?SVowTmZDeFdLcXZFZENsdXJ4RWptbFdYUVNlekcrMWF6d2l3ZzVsR2o2Vmcw?=
 =?utf-8?B?RElhTWF4YndMTlErQUhHVGk0QUdQalorWHUrSWljOU1KbVZ4bFQ4NEhrTGMy?=
 =?utf-8?B?R3BFS09sSmZzOTdLbmJUYlNKQ1dJTkhadGhoU3YwK0YvZXFNUHVRMkxEeEcy?=
 =?utf-8?B?d2d1MEFtK29MM3JueTNFOWlwR0JkbVJaektkaUZZUi9NUlNRUWdTellQS0sw?=
 =?utf-8?B?RFNpNjhlYUZ1ZFVqQ1VINmJJcmZHcW8zOVlrN3MrZVYyZnJKVE1zSENORi81?=
 =?utf-8?B?VjJLTElRamVoRXhXRnVWajVUTzUrS3VYbkxHZHgzVWd1VktOVUUrY0oxN0FT?=
 =?utf-8?B?WjVMQ2llOXJyeHZEWDBST1FhRnpTU2svVXdqSm1BczliOTNyZndKeml0dlRy?=
 =?utf-8?B?Ry9QeGVHN0k5SmxWdm82RzRQT2NZYkJtSjd2VTJlTmlwMkNMemRQbUJlUzAz?=
 =?utf-8?Q?iMPgHiwo0eYq51qt51c0JUUwT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c949362b-0029-4eb3-d30b-08db62834e69
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 09:33:50.4153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAmCouH3BzZT8WdRVgqZEhr724RTITxETDNwM3yOtXB7JYEX6AJYOiNFK3lTwiA5jHqjD/EjB+rKg+lAZQWiRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter, 

Sharing some initial benchmark results with the patch below.

tl;dr

- Hackbench starts off well but performance drops as the number of groups
  increases.

- schbench (old), tbench, netperf see improvement but there is a band of
  outlier results when system is fully loaded or slightly overloaded.

- Stream and ycsb-mongodb are don't mind the extra search.

- SPECjbb (with default scheduler tunables) and DeathStarBench are not
  very happy.

On 5/31/2023 5:34 PM, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     c7dfd6b9122d29d0e9a4587ab470c0564d7f92ab
> Gitweb:        https://git.kernel.org/tip/c7dfd6b9122d29d0e9a4587ab470c0564d7f92ab
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Tue, 30 May 2023 13:20:46 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Tue, 30 May 2023 22:46:27 +02:00
> 
> sched/fair: Multi-LLC select_idle_sibling()
> 
> Tejun reported that when he targets workqueues towards a specific LLC
> on his Zen2 machine with 3 cores / LLC and 4 LLCs in total, he gets
> significant idle time.
> 
> This is, of course, because of how select_idle_sibling() will not
> consider anything outside of the local LLC, and since all these tasks
> are short running the periodic idle load balancer is ineffective.
> 
> And while it is good to keep work cache local, it is better to not
> have significant idle time. Therefore, have select_idle_sibling() try
> other LLCs inside the same node when the local one comes up empty.

Tests were run on a dual socket 3rd Generation EPYC server(2 x64C/128T)
running in NPS1 mode. Following it the simplified machine topology:

    NPS1: Each socket is a NUMA node.
    Total 2 NUMA nodes in the dual socket machine.

    DIE0: 0-63,   128-191
        MC0: 0-7, 128-135
           SMT0: 0,128
           SMT1: 1,129
           ...
           SMT7: 7,135
	MC1: 8-15, 136-143
           SMT8: 8,136
           SMT9: 9,137
           ...
           SMT15: 15,143
	...
	MC7: 56-63, 184-191
           SMT56: 56,184
           SMT57: 57,185
           ...
           SMT63: 63,191

    DIE1: 64-127, 192-255
        MC8: 64-71, 192-199
           SMT64: 64,192
           SMT65: 65,193
           ...
           SMT71: 71,199
	MC9: 72-79, 200-207
           SMT72: 72,200
           SMT73: 72,201
           ...
           SMT79: 79,207
	...
	MC15: 120-127, 248-255
           SMT120: 120,248
           SMT121: 121,249
           ...
           SMT127: 127,255

Since the patch extends the idle CPU search to one domain above MC in
case of on an unsuccessful search, for the above topology, the DIE
domain becomes the wake domain with potential 128CPUs to be searched.
Following are the benchmark results:

o Kernel Versions

- tip              - tip:sched/core at commit e2a1f85bf9f5 "sched/psi:
                     Avoid resetting the min update period when it is
                     unnecessary")

- peter-next-level - tip:sched/core + this patch

o Benchmark Results

Note: Benchmarks were run with boost enabled and C2 disabled to minimize
other external fact.

~~~~~~~~~~~~~
~ hackbench ~
~~~~~~~~~~~~~

o NPS1

Test:			tip		   peter-next-level
 1-groups:	   3.92 (0.00 pct)	   4.05 (-3.31 pct)
 2-groups:	   4.58 (0.00 pct)	   3.84 (16.15 pct)
 4-groups:	   4.99 (0.00 pct)	   3.98 (20.24 pct)
 8-groups:	   5.67 (0.00 pct)	   6.05 (-6.70 pct)	* Overloaded
16-groups:	   7.88 (0.00 pct)	  10.56 (-34.01 pct)	* Overloaded

~~~~~~~~~~~~~~~~~~
~ schbench (Old) ~
~~~~~~~~~~~~~~~~~~

o NPS1

#workers:	tip		  peter-next-level
  1:	  26.00 (0.00 pct)	  24.00 (7.69 pct)
  2:	  27.00 (0.00 pct)	  24.00 (11.11 pct)
  4:	  31.00 (0.00 pct)	  28.00 (9.67 pct)
  8:	  36.00 (0.00 pct)	  33.00 (8.33 pct)
 16:	  49.00 (0.00 pct)	  47.00 (4.08 pct)
 32:	  80.00 (0.00 pct)	  81.00 (-1.25 pct)
 64:	 169.00 (0.00 pct)	 169.00 (0.00 pct)
128:	 343.00 (0.00 pct)	 365.00 (-6.41 pct)	* Fully Loaded
256:	 42048.00 (0.00 pct)	 35392.00 (15.82 pct)
512:	 95104.00 (0.00 pct)	 88704.00 (6.72 pct)

~~~~~~~~~~
~ tbench ~
~~~~~~~~~~

o NPS1

Clients:	tip		 peter-next-level
    1	 452.49 (0.00 pct)	 457.94 (1.20 pct)
    2	 862.44 (0.00 pct)	 879.99 (2.03 pct)
    4	 1604.27 (0.00 pct)	 1618.87 (0.91 pct)
    8	 2966.77 (0.00 pct)	 3040.90 (2.49 pct)
   16	 5176.70 (0.00 pct)	 5292.29 (2.23 pct)
   32	 8205.24 (0.00 pct)	 8949.12 (9.06 pct)
   64	 13956.71 (0.00 pct)	 14461.42 (3.61 pct)
  128	 24005.50 (0.00 pct)	 26052.75 (8.52 pct)
  256	 32457.61 (0.00 pct)	 21999.41 (-32.22 pct)	* Overloaded
  512	 34345.24 (0.00 pct)	 41166.39 (19.86 pct)
 1024	 33432.92 (0.00 pct)	 40900.84 (22.33 pct)

~~~~~~~~~~
~ stream ~
~~~~~~~~~~

o NPS1

- 10 Runs:

Test:			tip	   peter-next-level
 Copy:	 271317.35 (0.00 pct)	 292440.22 (7.78 pct)
Scale:	 205533.77 (0.00 pct)	 203362.60 (-1.05 pct)
  Add:	 221624.62 (0.00 pct)	 225850.83 (1.90 pct)
Triad:	 228500.68 (0.00 pct)	 225885.25 (-1.14 pct)

- 100 Runs:

Test:			tip	   peter-next-level
 Copy:	 317381.65 (0.00 pct)	 318827.08 (0.45 pct)
Scale:	 214145.00 (0.00 pct)	 206213.69 (-3.70 pct)
  Add:	 239243.29 (0.00 pct)	 229791.67 (-3.95 pct)
Triad:	 249477.76 (0.00 pct)	 236843.06 (-5.06 pct)

~~~~~~~~~~~~~~~~~~~~
~ netperf - TCP_RR ~
~~~~~~~~~~~~~~~~~~~~

o NPS1

Test:			tip		   peter-next-level
 1-clients:	 102839.97 (0.00 pct)	 103540.33 (0.68 pct)
 2-clients:	 98428.08 (0.00 pct)	 100431.67 (2.03 pct)
 4-clients:	 92298.45 (0.00 pct)	 94800.51 (2.71 pct)
 8-clients:	 85618.41 (0.00 pct)	 89130.14 (4.10 pct)
16-clients:	 78722.18 (0.00 pct)	 79715.38 (1.26 pct)
32-clients:	 73610.75 (0.00 pct)	 72801.41 (-1.09 pct)
64-clients:	 55285.07 (0.00 pct)	 56184.38 (1.62 pct)
128-clients:	 31176.92 (0.00 pct)	 32830.06 (5.30 pct)
256-clients:	 20011.44 (0.00 pct)	 15135.39 (-24.36 pct)	* Overloaded

~~~~~~~~~~~~~
~ unixbench ~
~~~~~~~~~~~~~

o NPS1

						  tip			peter-next-level
Hmean     unixbench-dhry2reg-1   	  41322625.19 (   0.00%)   41224388.33 (  -0.24%)
Hmean     unixbench-dhry2reg-512	6252491108.60 (   0.00%)  6240160851.68 (  -0.20%)
Amean     unixbench-syscall-1    	   2501398.27 (   0.00%)    2577323.43 *  -3.04%*
Amean     unixbench-syscall-512  	   8120524.00 (   0.00%)    7512955.87 *   7.48%*
Hmean     unixbench-pipe-1    		   2359346.02 (   0.00%)    2392308.62 *   1.40%*
Hmean     unixbench-pipe-512		 338790322.61 (   0.00%)  337711432.92 (  -0.32%)
Hmean     unixbench-spawn-1       	      4261.52 (   0.00%)       4164.90 (  -2.27%)
Hmean     unixbench-spawn-512    	     64328.93 (   0.00%)      62257.64 *  -3.22%*
Hmean     unixbench-execl-1       	      3677.73 (   0.00%)       3652.08 (  -0.70%)
Hmean     unixbench-execl-512    	     11984.83 (   0.00%)      13585.65 *  13.36%*

~~~~~~~~~~~~~~~~
~ ycsb-mongodb ~
~~~~~~~~~~~~~~~~

o NPS1

tip:			131070.33 (var: 2.84%)
peter-next-level:	131070.33 (var: 2.84%) (0.00%)

~~~~~~~~~~~~~~~~~~~~~~~
~ SPECjbb - Multi-JVM ~
~~~~~~~~~~~~~~~~~~~~~~~

o NPS1

- Default Scheduler Tunables

kernel			max-jOPS		critical-jOPS
tip			100.00%			100.00%
peter-next-level	 94.45% (-5.55%)	 98.25% (-1.75%)

- Modified Scheduler Tunables

kernel			max-jOPS		critical-jOPS
tip			100.00%			100.00%
peter-next-level	100.00% (0.00%)		102.41% (2.41%)

~~~~~~~~~~~~~~~~~~
~ DeathStarBench ~
~~~~~~~~~~~~~~~~~~

Pinning   Scaling	tip		peter-next-level
1 CCD     1             100.00%      	100.30% (%diff:  0.30%)
2 CCD     2             100.00%      	100.17% (%diff:  0.17%)
4 CCD     4             100.00%      	 99.60% (%diff: -0.40%)
8 CCD     8             100.00%      	 92.05% (%diff: -7.95%)	*

---

Based on the above data, the results seem to be mostly positive for
the microbenchmarks but not so much for SpecJBB and DeathStarBench,
which have high utilization. There is also band of outliers when the
system is fully loaded or overloaded (~2 tasks per rq) for some of
the microbenchmarks.

I wonder if extending SIS_UTIL for SIS_NODE would help some of these
cases but I've not tried tinkering with it yet. I'll continue
testing on other NPS modes which would decrease the search scope.
I'll also try running the same bunch of workloads on an even larger
4th Generation EPYC server to see if the behavior there is similar.

Let me know if you need any data from from my test system for any
specific workload. I'll be more than happy to get them for you :)

> 
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/fair.c     | 38 ++++++++++++++++++++++++++++++++++++++
>  kernel/sched/features.h |  1 +
>  2 files changed, 39 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 48b6f0c..0172458 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7028,6 +7028,38 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool 
>  }
>  
>  /*
> + * For the multiple-LLC per node case, make sure to try the other LLC's if the
> + * local LLC comes up empty.
> + */
> +static int
> +select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
> +{
> +	struct sched_domain *parent = sd->parent;
> +	struct sched_group *sg;
> +
> +	/* Make sure to not cross nodes. */
> +	if (!parent || parent->flags & SD_NUMA)
> +		return -1;
> +
> +	sg = parent->groups;
> +	do {
> +		int cpu = cpumask_first(sched_group_span(sg));
> +		struct sched_domain *sd_child;
> +
> +		sd_child = per_cpu(sd_llc, cpu);
> +		if (sd_child != sd) {
> +			int i = select_idle_cpu(p, sd_child, test_idle_cores(cpu), cpu);
> +			if ((unsigned)i < nr_cpumask_bits)
> +				return i;
> +		}
> +
> +		sg = sg->next;
> +	} while (sg != parent->groups);
> +
> +	return -1;
> +}
> +
> +/*
>   * Scan the asym_capacity domain for idle CPUs; pick the first idle one on which
>   * the task fits. If no CPU is big enough, but there are idle ones, try to
>   * maximize capacity.
> @@ -7199,6 +7231,12 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	if ((unsigned)i < nr_cpumask_bits)
>  		return i;
>  
> +	if (sched_feat(SIS_NODE)) {
> +		i = select_idle_node(p, sd, target);
> +		if ((unsigned)i < nr_cpumask_bits)
> +			return i;
> +	}
> +
>  	return target;
>  }
>  
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index ee7f23c..9e390eb 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
>   */
>  SCHED_FEAT(SIS_PROP, false)
>  SCHED_FEAT(SIS_UTIL, true)
> +SCHED_FEAT(SIS_NODE, true)
>  
>  /*
>   * Issue a WARN when we do multiple update_rq_clock() calls

--
Thanks and Regards,
Prateek
