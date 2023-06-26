Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A1B73D783
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjFZGFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 02:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjFZGFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:05:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16C8E50
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 23:05:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhmeTuZ/Fz87KlS/vZJS3fRo/r6Wn0WJs65FrvPWlrOBsOZgLkNfQ4prVO4p4zydafdSZaAZCbVCC+LUjEJAL3ISs1QRNrlLKq3yMRixzM2qHi8WDmUo+H3J2HBzlGGdM3gpvgVTQaW0dysiPoGbYIYRj9KG5olvAtIJVbD0k7MBOevlSxxjE9yMqHeAi+ZxahNn9ZADFq9jliTtrHcGvEJ75gs0+9+HJcZZMUVfjQQJTxjJyvbRHtmL6eyJpy4mhgqChL+BeW1kXojn1/8EEg/sC195TlnH+kvDXIIUW3eYnlXNNzOsg53xitzyxbHpc60+AGMzmRYdhD+cSApXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrg8lZQ35S8/LqBXhF2qVrnMyVzXFpeSi/V7GAXSayM=;
 b=FwAptAo6vQgmXfjOh1lphn+75P7d0RH8Zo/JDB9qivRwsKUX7EYdOx4ytOU+M/AX121aZ3dRiALWHp4pMml3PCivcALqsEzf+vTyLSCQRc+FqCjcu8y0VHAP50Q688JhQW2tXZR1ZPyEBf9jzpuOfc4pDMeNwQprJyoisuCoblRxgtzjT21sIWAKJik+qZAi52/UyPcId21q7YZD/pjseOGFRfKYfSkUCjcT8H82tAdROoRCFyvrx5fF1xwGLtnH52fAkGcnu83/FWLb9IhxxYalyguj4ACT1h6mLFjlbEeCmGgKfuumEiM83p0bkcUGHNknpX07ySfDGMfMsm7lcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrg8lZQ35S8/LqBXhF2qVrnMyVzXFpeSi/V7GAXSayM=;
 b=g0EwoKYSk4dxJGN9FVHQ/9FcKUWwAIINixOt473XvNOyY192ASPN0uY50CdgITP1Q1Q6TjgSmcaJLdYgYhj7j/cGPRURxhRro1EAqsS86mNu+2p83S0l5qiUV2c1OnGeWR89/s+Pxux46tiyUGyuZ+Zw8B4M4s2k8+A2xPKv+k8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Mon, 26 Jun 2023 06:05:04 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::792f:873a:c975:1999]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::792f:873a:c975:1999%6]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 06:05:03 +0000
Date:   Mon, 26 Jun 2023 11:34:41 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joshdon@google.com,
        roman.gushchin@linux.dev, tj@kernel.org, kernel-team@meta.com,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <ZJkqeXkPJMTl49GB@BLR-5CG11610CF.amd.com>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <ZI/x+RkSqpct4bM3@BLR-5CG11610CF.amd.com>
 <20230620200822.GC3027191@maniforge>
 <ZJKx/LQwc3bWS5nh@BLR-5CG11610CF.amd.com>
 <20230622014329.GD15990@maniforge>
 <ZJQQXQ/+p4f5FcAd@BLR-5CG11610CF.amd.com>
 <20230622102935.GG4253@hirez.programming.kicks-ass.net>
 <ZJVq1+dSkMAsOIKw@BLR-5CG11610CF.amd.com>
Content-Type: multipart/mixed; boundary="iIvtSLGF+N61/3UL"
Content-Disposition: inline
In-Reply-To: <ZJVq1+dSkMAsOIKw@BLR-5CG11610CF.amd.com>
X-ClientProxiedBy: PN2PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::16) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 116e6ab2-c929-46f2-4a43-08db760b47d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8tWIBUrJXE2l7SBzecMMYdAL2Wh80QLczK0O+odaoC4pyEGwViQV9p5LhDWVN79Jk2mud9j5qnOQA8Vy7qZBB+Y0VEDrAkO0deXNgKiZUwcfzgWZaYzW3Daz3CBTxIQ93UiC3DqNcea/l46rahqhAYMx8QewwVpkcj25P2C9D/SpGzY5GOQDVRPgFlzmt0tME3jnx/Gupe3jWFWSXgUeAkniihbMxo0x7RO+a/zFOEhjx0q2WS24KlUKTHZgaA/x0DYtIzUxVZYeHx/O3ozdGhe0Cuv58v7ckpt4StUqUItfeAYSSrFFe20S0HFPcxhnlwWbckmxQ93IHvD8AEefAdn1y+yvKGHE075FIJ5l6PNm4Urv0SaSlV80MRDR0MBFBy1gVXrxvE4tq24+WTDND46ULm5Gg9ei5GioIKFgTnbBBItbID+zHMKliy+JjIxnYe/3bNZqO2ZSYL0Qf6cydIVSf7meCtYjq+QsJ/dvjOawCDNYTkvGEBtjcNLd4jrv2dpq6ORDaSKS371gCjqWq0Lu4346Gr733rliBIE2YxV6fEcHcyFvYQjAJFVziAORlNDNZjZebhLakVysl11eryz+qhxE78RrW+6o5iWYGiUhwq37ypnQdqYQytO+qno
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(44144004)(6486002)(6666004)(6916009)(235185007)(66476007)(8936002)(8676002)(5660300002)(7416002)(66556008)(478600001)(54906003)(26005)(83380400001)(6512007)(6506007)(186003)(41300700001)(86362001)(2906002)(316002)(66946007)(4326008)(38100700002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/DYsansR8R6S5PaqqOnjwt/mPgt4E+tSHlGG1MuiKWiYfzuJuyq1sTUfqIvc?=
 =?us-ascii?Q?qt5GQskkXTs8g0DF8/gEVDju7GjwKurKwqA58DH+O9I6t0wXa9PkD79kjkrr?=
 =?us-ascii?Q?KgeYTo+BntPwEwqvF6RRQkdP2QtC5TV/QHcXBXO5Cu4GfXdNiKI1ooX12Xic?=
 =?us-ascii?Q?/04gj18VFQS+X9RIGj/vWk8HgMzy9PLi+4HAZA2amsWUFE3fjRnVuPNlDKqa?=
 =?us-ascii?Q?QfXYoq0e6JeW6lPNTtP6zELmUfgCvNURDCHM97Cbo+rZvtAixFgFJecD4u7T?=
 =?us-ascii?Q?8liuv4PGBWT12BV+Ebz4IOf7hqe24f4O9ktTyxXKcdtLVx9TpM3YfZW4TgrQ?=
 =?us-ascii?Q?icY2bIcrpMeRj0x74i0i15FfVBrT2WXg8mel/1qR7GOcmrj+Wa9WB2pEU/96?=
 =?us-ascii?Q?xwBjvZ3XFzKHyQqAIvHLyzS07OzjRnG4G1hdNImt+kiMXT97MmqSwVbzSqlU?=
 =?us-ascii?Q?aARONFRQwMI6/CP+sBj+L5yT2lbjFHDm/NhH8p8++r1Cer71uBdPZejKptRx?=
 =?us-ascii?Q?0IwfQXoef1F3/89mhSdLMHjSupbkzGB2WQaRg8qxOYXc5zBBaerXnCKTVD8v?=
 =?us-ascii?Q?h6GACKlgvG+fOYtf7QWQO7QgKRV6HPxCpg8pnUROno0f8+Ed5lSzrr8+VeE+?=
 =?us-ascii?Q?EHSxQkykFjBBzxVEaYPEfNpJ5Ur5h0f5C3sSmw8uWeADD0Bk6vm/KopHzQGb?=
 =?us-ascii?Q?T9dYtCgdhkYY5222RHjTtv5UyWB4YAYy9v5VpQ0t/mTw2SSmtmCvoVb0aQm4?=
 =?us-ascii?Q?9EEnSwmXD/V5SHs3n/Lu7UgRB+QaGZcbtYS76sZF8S/7Vpw5sdv3CwDmp2Nx?=
 =?us-ascii?Q?1Sk0lKdJ3rfiA6GlOE3nwXCWR//6GTtAHnM+96RXtEFcTIrnODAk3SRD44Yw?=
 =?us-ascii?Q?G8Xyn64GxIsZne+v4ALemU3BzlWoG2h/kEVKkc5k5SKc+JrhRMPSrC8gqhrF?=
 =?us-ascii?Q?TrL/oek9aCD3a09HU50AKsC23OJHsb+XuHtIJDVxyr2Ye4VBghm0MsKfG6bI?=
 =?us-ascii?Q?O81yPCgYcfVwSAG/7ZoTIzH3Lqdp+svVdkaD8+NqwXAMyw8o/14kHm72CTyW?=
 =?us-ascii?Q?GUCIHRs88lUoDNJKx/L6d9NSsOcEkTl28VPkgfBUJ0lLLeIPsQQn59TLk4ce?=
 =?us-ascii?Q?cvi5kw8J3uHqFlm0ewPoIc8UtgLq3rumzDz6Ox0cZi0HHy+U4UsPXqKlMEEZ?=
 =?us-ascii?Q?mPIx4DuPMR2VD6iAR895ieXvqnE7JBaZ7ekzCEsXhZPYgMvw5qyNFf+13sD1?=
 =?us-ascii?Q?AXYGrq2MZRyropQrtkrEwhIMsckAnjb30ofTy32d1knDI/yeClo74kPQZcrG?=
 =?us-ascii?Q?Bi/mZqUV1VA95bqmud51aI8ZxOytu9Ax30QiVY7dDx+DQr9pfe6QeeGD9dCV?=
 =?us-ascii?Q?wyEga4bjSkQ4JpZzNYhMQP1jVvFs6Vbj8N8X7EpQax3IrQtdBWEw6TuOe3YS?=
 =?us-ascii?Q?46RcW8PZ0gNwhwFCoLRetdjUPzss35sqA98e2XRdPftwaR81NHoG7JjBM/z8?=
 =?us-ascii?Q?leYu7RLkQB3NdZja4bJNb2jPMlHHnX2pypm2es2eg7sx93aGYwfCd5TtNw5J?=
 =?us-ascii?Q?2PW9QIc5NImHkFZhqHY72RrrLYxThH9BU1c9XLll?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116e6ab2-c929-46f2-4a43-08db760b47d5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 06:05:03.1767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZAKpnRLFrXaVr+gZ2zCSwCCnXDo+dj7FbouVXXOYswwK0b9YwODQeUaD5ZpjDyoUlSbqdNBxOg9kFEIfPRDpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--iIvtSLGF+N61/3UL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Peter, David,

On Fri, Jun 23, 2023 at 03:20:15PM +0530, Gautham R. Shenoy wrote:
> On Thu, Jun 22, 2023 at 12:29:35PM +0200, Peter Zijlstra wrote:
> > On Thu, Jun 22, 2023 at 02:41:57PM +0530, Gautham R. Shenoy wrote:

> 
> I will post more results later.

I was able to get some numbers for hackbench, schbench (old), and
tbench over the weekend on a 2 Socket Zen3 box with 64 cores 128
threads per socket configured in NPS1 mode.

The legend is as follows:

tip : tip/sched/core with HEAD being commit e2a1f85bf9f5 ("sched/psi:
      Avoid resetting the min update period when it is unnecessary")


david : This patchset

david-ego-1 : David's patchset + my modification to allow SIS signal
              that a task should be queued on the shared-wakequeue when SIS cannot
              find an idle CPU to wake up the task.

david-ego-2 : David's patchset + david-ego-1 + my modification to
	      remove the first task from the shared-wakequeue whose
	      cpus_allowed contains this CPU. Currently we don't do
	      this check and always remove the first task. 


david-ego-1 and david-ego-2 are attached with this mail.

hackbench (Measure: time taken to complete, in seconds)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Test:         tip                david                david-ego-1          david-ego-2
1-groups:     3.92 (0.00 pct)    3.35 (14.54 pct)     3.53 (9.94 pct)      3.30 (15.81 pct)
2-groups:     4.58 (0.00 pct)    3.89 (15.06 pct)     3.95 (13.75 pct)     3.79 (17.24 pct)
4-groups:     4.99 (0.00 pct)    4.42 (11.42 pct)     4.76 (4.60 pct)      4.77 (4.40 pct)
8-groups:     5.67 (0.00 pct)    5.08 (10.40 pct)     6.16 (-8.64 pct)     6.33 (-11.64 pct)
16-groups:    7.88 (0.00 pct)    7.32 (7.10 pct)      8.57 (-8.75 pct)     9.77 (-23.98 pct)


Observation: We see that David's patchset does very well across all
the groups.  Expanding the scope of the shared-wakequeue with
david-ego-1 doesn't give us much and in fact hurts at higher
utilization. Same is the case with david-ego-2 which only pulls
allowed tasks from the shared-wakequeue. In david-ego-2 we see a
greater amount of spin-lock contention for 8 and 16 groups, as the
code holds the spinlock and iterates through the list members while
checking cpu-affinity.

So, David's original patchset wins this one.




schbench (Measure : 99th Percentile latency, in us)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#workers: tip                     david                   david-ego-1             david-ego-2
 1:      26.00 (0.00 pct)         21.00 (19.23 pct)       28.00 (-7.69 pct)       22.00 (15.38 pct)
 2:      27.00 (0.00 pct)         29.00 (-7.40 pct)       28.00 (-3.70 pct)       30.00 (-11.11 pct)
 4:      31.00 (0.00 pct)         31.00 (0.00 pct)        31.00 (0.00 pct)        28.00 (9.67 pct)
 8:      36.00 (0.00 pct)         37.00 (-2.77 pct)       34.00 (5.55 pct)        39.00 (-8.33 pct)
16:      49.00 (0.00 pct)         49.00 (0.00 pct)        48.00 (2.04 pct)        50.00 (-2.04 pct)
32:      80.00 (0.00 pct)         80.00 (0.00 pct)        88.00 (-10.00 pct)      79.00 (1.25 pct)
64:     169.00 (0.00 pct)        180.00 (-6.50 pct)      174.00 (-2.95 pct)      168.00 (0.59 pct)
128:     343.00 (0.00 pct)       355.00 (-3.49 pct)      356.00 (-3.79 pct)      344.00 (-0.29 pct)
256:     42048.00 (0.00 pct)   46528.00 (-10.65 pct)   51904.00 (-23.43 pct)   48064.00 (-14.30 pct)
512:     95104.00 (0.00 pct)   95872.00 (-0.80 pct)    95360.00 (-0.26 pct)    97152.00 (-2.15 pct)


Observations: There are run-to-run variations with this benchmark. I
will try with the newer schbench later this week. 

tbench (Measure: Throughput, records/s)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Clients: tip			 sis-node		 david			 david-ego-1		 ego-david-2
    1	 452.49 (0.00 pct)	 457.94 (1.20 pct)	 448.52 (-0.87 pct)	 447.11 (-1.18 pct)	 458.45 (1.31 pct)
    2	 862.44 (0.00 pct)	 879.99 (2.03 pct)	 860.14 (-0.26 pct)	 873.27 (1.25 pct)	 891.72 (3.39 pct)
    4	 1604.27 (0.00 pct)	 1618.87 (0.91 pct)	 1610.95 (0.41 pct)	 1628.45 (1.50 pct)	 1657.26 (3.30 pct)
    8	 2966.77 (0.00 pct)	 3040.90 (2.49 pct)	 2991.07 (0.81 pct)	 3063.31 (3.25 pct)	 3106.50 (4.70 pct)
   16	 5176.70 (0.00 pct)	 5292.29 (2.23 pct)	 5478.32 (5.82 pct)	 5462.05 (5.51 pct)	 5537.15 (6.96 pct)
   32	 8205.24 (0.00 pct)	 8949.12 (9.06 pct)	 9039.63 (10.16 pct)	 9466.07 (15.36 pct)	 9365.06 (14.13 pct)
   64	 13956.71 (0.00 pct)	 14461.42 (3.61 pct)	 16337.65 (17.05 pct)	 16941.63 (21.38 pct)	 15697.47 (12.47 pct)
  128	 24005.50 (0.00 pct)	 26052.75 (8.52 pct)	 25605.24 (6.66 pct)	 27243.19 (13.48 pct)	 24854.60 (3.53 pct)
  256	 32457.61 (0.00 pct)	 21999.41 (-32.22 pct)	 36953.22 (13.85 pct)	 32299.31 (-0.48 pct)	 33037.03 (1.78 pct)
  512	 34345.24 (0.00 pct)	 41166.39 (19.86 pct)	 40845.23 (18.92 pct)	 40797.97 (18.78 pct)	 38150.17 (11.07 pct)
 1024	 33432.92 (0.00 pct)	 40900.84 (22.33 pct)	 39749.35 (18.89 pct)	 41133.82 (23.03 pct)	 38464.26 (15.04 pct)


 Observations: tbench really likes all variants of shared-wakeueue. I
 have also included sis-node numbers since we saw that tbench liked
 sis-node.

Also, it can be noted that except for the 256 clients case (number of
clients == number of threads in the system), in all other cases, we
see a benefit with david-ego-1 which extends the usage of
shared-wakequeue to the waker's target when the waker's LLC is busy.

Will try and get the netperf, postgresql, SPECjbb and Deathstarbench
numbers this week.

--
Thanks and Regards
gautham.







--iIvtSLGF+N61/3UL
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="david-ego-1.patch"

From 05d8efe2f3ae3abafd4bf94a0579d378dba63bb6 Mon Sep 17 00:00:00 2001
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Date: Fri, 23 Jun 2023 11:02:03 +0530
Subject: [PATCH 1/2] swqueue: Control if a task should be queued on swq in
 select_idle_sibling()

If select_idle_sibling() fails to find an idle CPU to wakeup the task
on, then update the newly defined sched_add_to_swq field in its task
struct.

Use the value in this field to later on to determine if the task
should also be queued on the shared-wakequeue of the LLC of the target
CPU.

This extends the use of shared-wakequeue to cases when the target of a
wakeup is the current CPU instead of the task's previous CPU.

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 include/linux/sched.h |  6 ++++++
 kernel/sched/fair.c   | 15 ++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b64fec55a381..38005262a7fe 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -910,6 +910,12 @@ struct task_struct {
 	 */
 	unsigned			sched_remote_wakeup:1;
 
+	/*
+	 * Bit used by select_idle_sibling() to signal enqueuing the
+	 * task on a shared wakequeue when it failed find an idle CPU.
+	 */
+	unsigned			sched_add_to_swq:1;
+
 	/* Bit to tell LSMs we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e311d1c3b992..fe33f6b13299 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -215,21 +215,17 @@ static void swqueue_enqueue(struct rq *rq, struct task_struct *p, int enq_flags)
 {
 	unsigned long flags;
 	struct swqueue *swqueue;
-	bool task_migrated = enq_flags & ENQUEUE_MIGRATED;
-	bool task_wakeup = enq_flags & ENQUEUE_WAKEUP;
 
 	/*
 	 * Only enqueue the task in the shared wakequeue if:
 	 *
 	 * - SWQUEUE is enabled
-	 * - The task is on the wakeup path
-	 * - The task wasn't purposefully migrated to the current rq by
-	 *   select_task_rq()
-	 * - The task isn't pinned to a specific CPU
+	 * - select_idle_sibling() didn't find an idle CPU to enqueue this wakee task.
 	 */
-	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
+	if (!p->sched_add_to_swq)
 		return;
 
+	p->sched_add_to_swq = 0;
 	swqueue = rq_swqueue(rq);
 	spin_lock_irqsave(&swqueue->lock, flags);
 	list_add_tail(&p->swqueue_node, &swqueue->list);
@@ -7361,6 +7357,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
+	/*
+	 * No idle sibling was found. Ok to queue this task on the
+	 * shared wakequeue of the target.
+	 */
+	p->sched_add_to_swq = 1;
 	return target;
 }
 
-- 
2.25.1


--iIvtSLGF+N61/3UL
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="david-ego-2.patch"

From 88f52c2df8a2d92423ddd12c92edec949148bf3c Mon Sep 17 00:00:00 2001
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Date: Fri, 23 Jun 2023 23:25:04 +0530
Subject: [PATCH 2/2] swqueue: Only pull a task with valid affinity from
 swqueue

Currently swqueue_pull_task() dequeues the task at the head of the
shared-wakequeue and then tries to migrate the task onto the current
CPU.

This may fail, since the current CPU may not be set in the task's
affinity mask.

Hence in swqueue_pull_task(), pull the first task from the
shared-wakequeue that can be run on this CPU. With this,
swqueue_pick_next_task() can return a 0/1 instead of 0/-1/1 as it is
done now.

Singed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 kernel/sched/fair.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fe33f6b13299..e78b8302b4c8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -195,17 +195,21 @@ static struct swqueue *rq_swqueue(struct rq *rq)
 	return rq->cfs.swqueue;
 }
 
-static struct task_struct *swqueue_pull_task(struct swqueue *swqueue)
+static struct task_struct *swqueue_pull_task(struct swqueue *swqueue, int cpu)
 {
 	unsigned long flags;
 
 	struct task_struct *p;
 
 	spin_lock_irqsave(&swqueue->lock, flags);
-	p = list_first_entry_or_null(&swqueue->list, struct task_struct,
-				     swqueue_node);
-	if (p)
-		list_del_init(&p->swqueue_node);
+	list_for_each_entry(p, &swqueue->list, swqueue_node) {
+		if (cpumask_test_cpu(cpu, p->cpus_ptr)) {
+			list_del_init(&p->swqueue_node);
+			goto found;
+		}
+	}
+	p = NULL;
+found:
 	spin_unlock_irqrestore(&swqueue->lock, flags);
 
 	return p;
@@ -238,11 +242,11 @@ static int swqueue_pick_next_task(struct rq *rq, struct rq_flags *rf)
 	struct task_struct *p = NULL;
 	struct rq *src_rq;
 	struct rq_flags src_rf;
-	int ret;
+	int ret = 0;
 
 	swqueue = rq_swqueue(rq);
 	if (!list_empty(&swqueue->list))
-		p = swqueue_pull_task(swqueue);
+		p = swqueue_pull_task(swqueue, rq->cpu);
 
 	if (!p)
 		return 0;
@@ -255,10 +259,8 @@ static int swqueue_pick_next_task(struct rq *rq, struct rq_flags *rf)
 	if (task_on_rq_queued(p) && !task_on_cpu(rq, p))
 		src_rq = migrate_task_to(src_rq, &src_rf, p, cpu_of(rq));
 
-	if (src_rq->cpu != rq->cpu)
+	if (src_rq->cpu == rq->cpu)
 		ret = 1;
-	else
-		ret = -1;
 
 	task_rq_unlock(src_rq, p, &src_rf);
 
-- 
2.25.1


--iIvtSLGF+N61/3UL--
