Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860F475041B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjGLKGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjGLKGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:06:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B588210FA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:06:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmOipkNEJppvvXaeT1oGqvyndpAFC0+BUjYmvXErP2dyF69sdV+bKnxBwOk+7CuxCV0zbCwZ67azKyhy6VDMgbNeXHDywEPfKbFgNkfVVv/FcXxw3ZTx4JHhAnx4UQI5qSd/wDd4wlhGnGACNIc+uK3cmsT8kwcQTmrSVStM1fwHV+IVjcEZS/iA5cHMlwoupWNqU/n/5yXTvmWKeuEb3KZHCEb5n9rxEdX4zkB2T+wZwDa0Jg47jwHfZ8aLQh2PU2kd9BtJfo0enpjgnBjH727G8q0CYUyH6Rssrz6UGtu3s2kicf1C9h6aCYbw6keNx7WttpYA7Q2RdaSOIuwumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qCavJVzDnkp/+54d9PNB+lKb1b+SgpzSBJ2eZoHtDI=;
 b=KAu6v/ZqJs5XCx7164DoUDizZtMexjiAMHC7kWdkis7k/Z6ycQj9wfnaX6kcAnFkUu25eavyTYxryhiYxVam2cwDyD2ohHLwMV6n6jUxCxbJGJagmETKKsNDxAcOACUoMnbI5JkAdUR2ajCAz3qWZoEbsEBJICijXAOl51L7EzD+XgvfKsZcoaJyjnRONIfR3m5HzyLJ8Kza4BGnsm/YQwjBokM1M9Amz5VZi3wrqw7eUykT3pbCtqJJKq4l9DhuiagX26bP41i4bNdVfOsV2cB4MyLcTes6qR1wVNm1WgL4+/AGGUEeZXpp8ZYyuknRjQBgKDUl+SplP6+mjHxB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qCavJVzDnkp/+54d9PNB+lKb1b+SgpzSBJ2eZoHtDI=;
 b=cdmD6E0S8uU7dGdK06iD1ceXBEiztDMhVze6WIOzgcsgCL48Ai4LBbEKMTUarRgIJcVfA9y+GjNf5dJkktToKj2ta/gYRmBeyMo660OvGC2PQHiKjN8jqra08dLN//4eEG+JxVXpvuVZnab/1Dq1UlcbaBKK2bINImKmi1bvMyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SA3PR12MB9092.namprd12.prod.outlook.com (2603:10b6:806:37f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Wed, 12 Jul 2023 10:06:49 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::ad86:9034:bfef:7d23]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::ad86:9034:bfef:7d23%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 10:06:49 +0000
Date:   Wed, 12 Jul 2023 15:36:27 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     David Vernet <void@manifault.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com, clm@meta.com,
        tj@kernel.org, roman.gushchin@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v2 6/7] sched: Shard per-LLC shared runqueues
Message-ID: <ZK57IxhhZMw2ZaEA@BLR-5CG11610CF.amd.com>
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-7-void@manifault.com>
 <20230711104958.GG3062772@hirez.programming.kicks-ass.net>
 <20230711195757.GD389526@maniforge>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711195757.GD389526@maniforge>
X-ClientProxiedBy: PN3PR01CA0131.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::18) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SA3PR12MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: d8626e06-eb0d-4850-b789-08db82bfb490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pamwHvCP0dv2khnKZ4ovqG8pf6sRBOuMgxTVY0oj53ssKcsHsAgoLeG+RklgspANoOO6lJ7N+xlOCSOAcMe80qon8k+O5JuKl40QgnoLu+yPdR2AkiA//WziOn4nIte99Uhjc/jjvgBcq3NwINzOGeX87cLp8F1dqqKSyi0JWl9LMynbN2MeXdw+Eh+XjEkM3zjrrUfn7yOHrpjOEXmSxG8WIkKu5MScN+qGoMnFYpbCO1IWeVyXJhcH11M8yK5OOe2MqgYfpgbrxXcfHJ07XSywpBTwD+T1H6KKY+YuRnLm5KE6M/yfukGHxZq1Z+tHVeLuY6JXNljWH9U7PqLTreMJvFDGJHp4h3MEjt3xI/o7GvWweqRMe1gGRPG96g56odtqkgAoAOxNiHBYRGhGuHovy8BzbPoYNftQDeOTJPTdaMmnMRxbvYnTT3Xznp78eeOWUBB1s3aCcaINFHTGxuz6crILGY4/zQFqRLiwCpen18wlEy6qIdwFbFwPKmem28kHAPRG2UCw5yVbi6xvyZZMyEiIHifi6rH78l5c78e5g8/0w1liTNH2Q1HQWEza
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(6666004)(6486002)(2906002)(478600001)(7416002)(41300700001)(8936002)(8676002)(5660300002)(38100700002)(316002)(66556008)(66946007)(66476007)(6916009)(4326008)(83380400001)(86362001)(186003)(26005)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OKyPQ9RSV/hxNiPm5XN12hzaWwgybOSxfgUqvr61lzFeobLd2l7LIdmz7gI3?=
 =?us-ascii?Q?kkgTW6Q/Xe+F15SZZXZuazLE0uc2Lp8LNswKWbo9vxXNQUQLMZp2GwgW2YJB?=
 =?us-ascii?Q?LV+aCFnVBFOdyQqM5xU7cHqTT19UjBX6GF+dTGW2v/A3riMWYMDMb/7wzEmz?=
 =?us-ascii?Q?MZd3oL6eYCvLu7bSwqfxhmdGMY5SBwTJNPAJcxipHYbei4pn84wRbVXQyS2M?=
 =?us-ascii?Q?m9CO6mP77MsVd1ic1W+Ar0/Btr1tsMol4cweWKQl+u4VAG4dwHglDuN0jBz1?=
 =?us-ascii?Q?MK7D9DOQADTYXwySNcZc504XU78hffaoL8o+GSCfu2oVi1l/+lOzU/L9nFoI?=
 =?us-ascii?Q?5/GLJQF0bL8hN/sVcRK4LvjtuDH9Sc/3ocnw89UalFEQhNyvjbNJydQDoxWl?=
 =?us-ascii?Q?acGZAnIDNkVzXs437xxh9rFxE10AEGIkXbmrJ5OpEBXIxV0JvfQSaWSsXhlc?=
 =?us-ascii?Q?itqVDjHh5YYYFyeT48mMjZxSwXNYnTXCl+WLLEsjqc+1BCArCZG23igpA3QJ?=
 =?us-ascii?Q?+LQyUTwJUYv2ck3BSVYHpgtmH5qfFFsW7mPxIF3GvvCD1xa+/t2t+QxjWIIZ?=
 =?us-ascii?Q?UnJ6Jp6V8TlMguq6HEtIT+j1jBoOIKcj8T6NOUwjimDhLpzvZpIIpgB85hRF?=
 =?us-ascii?Q?ev77M6bw1vGE4Xh4sv2w6Hq+QCXspibsrOunuXIDwvg+gn29ZI+bplZe9p8P?=
 =?us-ascii?Q?3zBMglCgxwTgTBJZYhI891qUHqABtnbNHzcPbc6YsYYNq/a00nltc26fSD8K?=
 =?us-ascii?Q?fVPBqg/zFGQ7Z1ut9tJWntvJOE0G6KR23zY9uEtH3V8ZKh+piYNK0C39i0o4?=
 =?us-ascii?Q?H6czrGQ0mCGr+k3nwSOuy1ILMzI9MIR69mUBvcrStKmwg0em4S0V5phG1AmF?=
 =?us-ascii?Q?fUbrzVptxU4lr99mUo9wK97TqMLS09Ipm9XWQWgQ4WsOj3UDD0HK8UQ4ziKX?=
 =?us-ascii?Q?tDmz1dwiqhhVARpAIaTJDvl9hQtQra36j+lBVAeVlOdTIrLWyIcaJMKY/Jtb?=
 =?us-ascii?Q?qN6xo/RbfNDg/8n15K6El2zzhFbd4CmkYsrSrVWlv924Mg7H4qzm5W8Bp035?=
 =?us-ascii?Q?aYdqNVOXW0YbZjfwHSBywzQPuDCy0arSbBK0Y+4GGp2BckRS1FXjLQ6eSdd3?=
 =?us-ascii?Q?U7yY850KGZTw5RyhNhNg6LAo57Rq6mEosLX7si0lNIcwNjVj5luRbJm/lB99?=
 =?us-ascii?Q?aCkBAXNlMDCOFV++hdQWsd7496KlxnqhVk7oBz8sBMPYHoKLAtQpaPkhOBfZ?=
 =?us-ascii?Q?5SH5xTcuY5LburCSuZ1rMvpmU2hmwbVCgWkNuGUDNIDgSAKM4ADDh4LYlyBy?=
 =?us-ascii?Q?DrvrlZ/AMZ8uakW5+Q7Ub3xqPEYLy2j5lwREAwYMJxIB+M4NNw8F80MRURF6?=
 =?us-ascii?Q?ZWDsgPReWslpVBR/r3CoiqgVH3UDbRr/JTqnfMAFwPt1K9UwXqq67L8alAbW?=
 =?us-ascii?Q?g+1DZa6kJJzJ7+Hd608zQXYWr8teQ4+PDy7OMSwf8v0rzpJtniv29EFMQjdE?=
 =?us-ascii?Q?X+B1XrRO2jn1spKGjH3QFTJmP8SgEDAxL6PyAI8uJJyV3Orl9tRMMtY8xv1w?=
 =?us-ascii?Q?8sdsZXkRVhCjb6Ty2bpT7TLWCaQSa3Cf1VkiMZHD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8626e06-eb0d-4850-b789-08db82bfb490
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 10:06:48.6870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOIx+wc9uG0PsH6yrC1ou4DM4dIur7vpK/M58yu7+j68PyUn1PYwicoUE9Oaivg2krPdgLgPF6fUz5d7cIHuqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9092
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 02:57:57PM -0500, David Vernet wrote:
> On Tue, Jul 11, 2023 at 12:49:58PM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 10, 2023 at 03:03:41PM -0500, David Vernet wrote:

[..snip..]

> > > +static int shared_runq_shard_idx(const struct shared_runq *runq, int cpu)
> > > +{
> > > +	return cpu % runq->num_shards;
> > 
> > I would suggest either:
> > 
> > 	(cpu >> 1) % num_shards
> >
> > or keeping num_shards even, to give SMT siblings a fighting chance to
> > hit the same bucket.
> 
> Given that neither of these approaches guarantees that the SMT siblings
> are in the same bucket, I'll just go with your suggestion which is
> simpler.
> 
> Seems inevitable that we'll want to have another debugfs knob to adjust
> the number of shards, but IMO it's preferable to just apply your
> suggestion in v3 and hold off on adding that complexity until we know we
> need it.
> 
> > (I've no idea how SMT4 (or worse SMT8) is typically enumerated, so
> > someone from the Power/Sparc/MIPS world would have to go play with that
> > if they so care)
> 
> Yeah, no idea either. If these things end up varying a lot across
> different architectures then we can look into making shard assignment
> architecture specific.

On POWER, the SMT siblings are enumerated in a sequential fashion, i.e

CPU id of a thread = Core_id * threads_per_core + thread_id_within_core.

But IIRC, POWER sets L2 domain as the LLC. On POWER8 (with SMT8) and
POWER9(with SMT4 on Baremetal and SMT8 on VMs), LLC size is 8. Even
with SHARED_RUNQ_SHARD_SZ = 6, there will only be 1 shard with the
current formula

	num_shards = max(per_cpu(sd_llc_size, i)/SHARED_RUNQ_SHARD_SZ, 1);

(Aside: with the above formula, on a topology with 6 < sd_llc_size <
12, num_shards will remain 1, with the shard size exceeding the
intended SHARD_SZ. Was this the intention ?)

Even on x86, there is no uniformity in how the SMT threads are
numbered. On AMD EPYC Baremetal, the first threads of all the cores
are enumerated first and then the sibling threads. So, on an EPYC
server with 128 cores in total, the SMT sibings are {0,128}, {1, 129}, ...

With SHARED_RUNQ_SHARD_SZ = 6,

On Zen2 EPYC Baremetal, with LLC size = 8, num_shards = 1.  This
simplifies stuff!

On Zen3, Zen4 EPYC Baremetal, with LLC size = 16, num_shards = 2.

Here, (cpu % num_shards) ensures that the SMT siblings belong to the
same shard along with 3 other cores.

On some Intel servers, it is possible that the CPU numbers are
interleaved across the two sockets. On my 2 socket, 32Cores per socket
Ice Lake Server, all the even numbered CPUs are in one socket and all
the odd numbered CPUs in the other socket.

The SMT siblings are {0,64}, {2, 66}, .... on one socket and {1, 65},
{3, 67}, .. on the other.

On this system, LLC size = 64. With SHARED_RUNQ_SHARD_SZ = 6,
num_shards = 10.

So with (cpu % num_shards) the siblings {0, 64} ... will belong to
different shards.

What would be good to have is

1. shard_size determined by individual architectures. If none is
   provided, we pick the default shard_size.

2. A sharding scheme which guarantees that SMT siblinngs will belong
   to the same shard as long as shard_size is at least as big as the SMT
   size.

--
Thanks and Regards
gautham.


