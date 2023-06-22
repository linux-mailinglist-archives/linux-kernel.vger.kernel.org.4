Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091CB739C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjFVJW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjFVJVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:21:46 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A5365B7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:12:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=di2ltX/jSuzTUJ5/eSGM3K0aldstYjqKqWEXPOkpNOZJ7pedn3M8s0KkwBQGeGZ643qRhg39vlwtGp/Jz0K3p5qErQ059K7q+BRqexY8WQrVWhFaQhX/oMR2+kQT8HloYomSGeCYdvatYpeJbOGBF2nJn4mN8pQ8Ciqrhc0AiVdPy4VHdcvrnBtVdAhR45WCSIqxzWcK81JCJwPCnAYNP0aHRk2AGL1A18WotInef6rfkAQHp+CndUw2mBtm4nJCIQwgyPwy/NqCyG4IUQ7zTXyWgbDXcBECinY+xD53x7ONjpHMIhusmuNGNHFdu+LrQjeyQQVi3zx3Y8sBRonRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knHYs3NoNDPiBhVIWBiWCHMzhs+LiyCowf+j5GxHj4Q=;
 b=M6jA2Yqz0RS1VZnw2RFqJWjYqwSDMBXmDfHRib50ouJCtxxJare5yDMZzGyg+4ZLoK/+zc+VqBDhRtw9/RXB6wumXyUSVt15oOdRQCEz/+DsjtkVmNTgISqEHFS4AwNuOh+BHGez8+0l86Ot0iw2F4Q95fwK1HG/J/butFjgnyeYoqtddDXqAof9tf60HBK2xuxeCOLtSRMz6zgsZLpeEktKiXk0/GV54mNbBtUXqjVbXIUgNOrkJNJBEzwVaZF3rScnUMyg+99wlLuPD1s08hkpHi5Rvz7aekYEaiCNn/zjw2xiIpgw9Z1pivPvlFGI6WKlnL9nCz9W74YTezDiWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knHYs3NoNDPiBhVIWBiWCHMzhs+LiyCowf+j5GxHj4Q=;
 b=ZszTlRHmOY2FLW64dunAW/RNwmgfO4QcZNSzmiRffbW/zumcU1g5cThVZN0S7/8DI3A+BXpSmiHFL3YuvQp1usyhC9qCpnEyYNeQ8HKlASQr15C1RqXbR/iXchSLs6NjNPAN818QFoV3eWbZqQzHX8a1fCBEpOKZpOH1B5vGBis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 09:12:09 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::8801:420d:4748:33b1]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::8801:420d:4748:33b1%4]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 09:12:09 +0000
Date:   Thu, 22 Jun 2023 14:41:57 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joshdon@google.com,
        roman.gushchin@linux.dev, tj@kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <ZJQQXQ/+p4f5FcAd@BLR-5CG11610CF.amd.com>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <ZI/x+RkSqpct4bM3@BLR-5CG11610CF.amd.com>
 <20230620200822.GC3027191@maniforge>
 <ZJKx/LQwc3bWS5nh@BLR-5CG11610CF.amd.com>
 <20230622014329.GD15990@maniforge>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622014329.GD15990@maniforge>
X-ClientProxiedBy: PN3PR01CA0138.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::10) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3286:EE_|SA3PR12MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5f3849-ee82-49e2-e146-08db7300c167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlOg71racOUGpoOtdF+hHx/JwNN/3d0f6JNV0MfIUAu3mxHO+iIj+Vun3If3cAtHZFjzu9ZEelZQXvREb8EsNHpODy8INXP8FF2dlbwCa52NlMEBPpnAV5HFXaCvwxqznznPjtITn2IQHYT925RP0BH6Q+pYF84k0DvP9CrGDRshoXvXr44RhVceVRWS3ZA4pLjQdhQhSWySrsYDqUv0c1/V06eJqxmuAn1clLnAKYTOzuR79MEZtMMhXIbePMvovfzX/vaC10gNRopvcPyp3PqCWxDzEINzbkfHz7uoSMYrnKo+1x9EDZCho1B0i8KJKPGdV7aoAkSeNmRHQ9pzxxGORTq1Z0/VjSqy1U5yaZL389yCzYsbsvQvrriBF0FVuGwPiguU7wTXDAuB2Y/3gfHu4PseZMFyO6oAdeJsvLEMoH/ayI/vSUHEvxolQDiN0ep0TIOHtYnfcVrzBdVwp12SMZgfGLFjW45KyXJGoSbTBl0SfBkEI/gnwDhw7pl/qjBcjgnDsvSgvvPvxMI83476serhiB4m51V+0/P3ywKOw0yUNGLo8u1ROKIHUXhi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199021)(6666004)(478600001)(83380400001)(5660300002)(6506007)(6486002)(66946007)(4326008)(8676002)(41300700001)(66556008)(66476007)(6916009)(8936002)(7416002)(2906002)(26005)(6512007)(186003)(38100700002)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?grd0gw7tKxNKgNduqxwINPM4eFVWotMumS1WPVgMvq54y4kcQSOAIiaVE+pc?=
 =?us-ascii?Q?cJEuTvbpGuCH4Om/uJl+c8UHZEw8cUeokC7QJDUHlY9cOOGNOeWvZIMeFcjr?=
 =?us-ascii?Q?CNPdznHb4bV3bt1A26Bj6SA1+RJJNTB9HloUhmpwNGuycJwBgPbvH+NO9haN?=
 =?us-ascii?Q?3End3NVwlyheDcwz3vXvaO2jrUhDgIGaE0DZGxcBL/dSST7NeuKmq3rVS+gL?=
 =?us-ascii?Q?n/PVWua0JEJxO4qsx6Ou+y9RcNVCGwoWMMPYr5f7pXv8qdRE+YWDm7AqYku/?=
 =?us-ascii?Q?Z4fJZrsfUVA8bN7mPyx8RvS8ufR9PfuBvjonvFzsP0kkUt0OkgU8KGbOhDkH?=
 =?us-ascii?Q?PRAQ9aPcjq7U5vAHEdrxJzNXeI2KqQJdGaPCfF7CcRpV/NVWW33kTFD4FXyL?=
 =?us-ascii?Q?t5182pHp4q5mdm1mdhL3fGV33oN6dgl7uhrNIMd4oy9g+ii8QAtGYFXxkKTk?=
 =?us-ascii?Q?gNU/UgrCUXYosqUpJuBIwSlOS8gSkeDvKQsxY2i/tCHfPoRHzthyXeGY6epq?=
 =?us-ascii?Q?QAKMJZEZzBgeMOpw5L0hA/eo6f++BLGRCSYwd2jwmyd+fgT90Z7EQLBEbUqS?=
 =?us-ascii?Q?rv3rY5QT6YQmeCnKGHKWfpQDWcRlSjc5cNVgAUhwmAATfPaE9qnsvUDoNCBA?=
 =?us-ascii?Q?1ja/UU8KyIKdFmjBN1gfgXZX7yERjXtwkVSGuaiDpYAg1IBWx20JQXAb2Dek?=
 =?us-ascii?Q?v3BiNHT1DXpSexMuzRIvUm+8F9s2tfRo5V9EO+2qGh79LGIhh5QIzAoFwb2G?=
 =?us-ascii?Q?P+ObtAKKdPkhu8V2ne4GS7tjATW9YOnKBEtzxH+hr99NwTmsYYm2pOvQaMop?=
 =?us-ascii?Q?0CeoLt7/2ogRIASNDFgp6K++4XBpQ5qIG8rRCatwkrABrc4AiI9zyJCBE21K?=
 =?us-ascii?Q?TyBmwmfOMyruNccAOLtK4p4myE5mpZ4Y86M0NFOhZO1R1UEbrggqvxWzj35N?=
 =?us-ascii?Q?baamDDcvlL7wNGBwyMPZ4aNY0dB7gQnge+3Mnm/5D+s1f0Ns3KOE0F9I9YYD?=
 =?us-ascii?Q?QHDB15tX3eKVp0gQTUf4dK8qcPA/7G6w+vT3upj8QFrtBg1HI/e60gKZxRFz?=
 =?us-ascii?Q?afSeenEGc+ZYTKpiqjEdE712ahx8y7DmVxemYYVAvrmT0ksGym96O7MKIEBN?=
 =?us-ascii?Q?cFTz8C3OeL3rpDwIWr/0HpK5Lsc89MLUOjCT5Vtpy0VQ/Cey/sbovT7zzprb?=
 =?us-ascii?Q?8C690EFw2kWyIqy20cmiso6B9xNAZrcrXwFQi+2oqPizER9vEVkN+Cgc//+z?=
 =?us-ascii?Q?H7sxKh+CpeRJJtXu8TBZCmw4Gl3xytbSL45Azc6f3m8xa8uZWjGREZ6g2YrA?=
 =?us-ascii?Q?4J2khUKmJsWvPjSCTTsOZHnBSiYoaq+lxdk1ajSugShim+eO5phF1xKpBIv4?=
 =?us-ascii?Q?VvUj+kIQPgbAoHMF1Mj2KjxyIWgC8kwN7+ma+foCFVTKEYuL25f2lDCHqJEn?=
 =?us-ascii?Q?bE9FWzsSzVky/ezPB6xrY/zuP83QIsLFe/cfoYXGwIfpdZyAyNaCdvEiz7Kw?=
 =?us-ascii?Q?fiFekxMTJOKf2c3d0k/Y9Q9mRxJdAUD194tytFqBXwKsfdDtZUKGVm6nm0x2?=
 =?us-ascii?Q?3gbG3PYng5xJCxI7QQKAdbXPXAdITHWP8N/lz4jT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5f3849-ee82-49e2-e146-08db7300c167
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 09:12:08.9004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOJEgtep2PyFmpmPkBehcvPXTVXx4MaK82LUe/bzcPGHaCKhvHFDh2eob6BGGtg3MbAQ7Va3943V4ac7s5VpjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 08:43:29PM -0500, David Vernet wrote:
> On Wed, Jun 21, 2023 at 01:47:00PM +0530, Gautham R. Shenoy wrote:
> > Hello David,
> > On Tue, Jun 20, 2023 at 03:08:22PM -0500, David Vernet wrote:
> > > On Mon, Jun 19, 2023 at 11:43:13AM +0530, Gautham R. Shenoy wrote:
> > > > Hello David,
> > > > 
> > > > 
> > > > On Tue, Jun 13, 2023 at 12:20:04AM -0500, David Vernet wrote:
> > > > [..snip..]
> > > > 
> > > > > +static void swqueue_enqueue(struct rq *rq, struct task_struct *p, int enq_flags)
> > > > > +{
> > > > > +	unsigned long flags;
> > > > > +	struct swqueue *swqueue;
> > > > > +	bool task_migrated = enq_flags & ENQUEUE_MIGRATED;
> > > > > +	bool task_wakeup = enq_flags & ENQUEUE_WAKEUP;
> > > > > +
> > > > > +	/*
> > > > > +	 * Only enqueue the task in the shared wakequeue if:
> > > > > +	 *
> > > > > +	 * - SWQUEUE is enabled
> > > > > +	 * - The task is on the wakeup path
> > > > > +	 * - The task wasn't purposefully migrated to the current rq by
> > > > > +	 *   select_task_rq()
> > > > > +	 * - The task isn't pinned to a specific CPU
> > > > > +	 */
> > > > > +	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
> > > > > +		return;
> > > > 
> > > > In select_task_rq_fair(), having determined if the target of task
> > > > wakeup should be the task's previous CPU vs the waker's current CPU,
> > > > we spend quite a bit of time already to determine if there is an idle
> > > > core/CPU in the target's LLC. @rq would correspond to CPU chosen as a
> > > > result of that scan or if no idle CPU exists, @rq corresponds to the
> > > > target CPU determined by wake_affine_idle()/wake_affine_weight().
> > > > 
> > > > So if the CPU of @rq is idle here, can we not simply return here?
> > > 
> > > Hi Gautum,
> > > 
> > > Sorry, I'm not sure I'm quite following the issue you're pointing out.
> > > We don't use swqueue if the task was migrated following
> > > select_task_rq_fair(). That's the idea with us returning if the task was
> > > migrated (the second conditional in that if). If I messed up that logic
> > > somehow, it should be fixed.
> > 
> > Sorry, my bad. I see it now.
> > 
> > So as per this patch, the only time we enqueue the task on the shared
> > wakeup is if the target of try_to_wake_up() is the same CPU where the
> > task ran previously.
> > 
> > When wake_affine logic fails and the previous CPU is chosen as the
> > target, and when there are no other idle cores/threads in the LLC of
> > the previous CPU, it makes sense to queue the task on the
> > shared-wakequeue instead of on a busy previous CPU.
> > 
> > And when that previous CPU is idle, the try_to_wake_up() would have
> > woken it up via ttwu_queue(), so before going idle the next time it
> > will check the shared queue for the task and find it. We should be
> > good in this case.
> > 
> > Now, it is possible that select_task_rq_fair() ended up selecting the
> > waker's CPU as the target based on the
> > wake_affine_idle()/wake_affine_weight() logic. And if there is no idle
> > core/thread on the waker's LLC, the target would be the busy waker
> > CPU. In the case when the waker CPU is different from the task's
> > previous CPU, due to ENQUEUE_MIGRATE flag being set, the task won't be
> > queued on the shared wakequeue and instead has to wait on the busy
> > waker CPU.
> > 
> > I wonder if it makes sense to enqueue the task on the shared wakequeue
> > in this scenario as well.
> 
> Hello Gautham,
> 
> That's a good point. My original intention with opting out of using
> swqueue if select_task_rq_fair() caused us to migrate is so that it
> wouldn't interfere with decisions made with other select_task_rq_fair()
> heuristics like wake_affine_*(). Basically just minimizing the possible
> impact of swqueue.
> That said, I think it probably does make sense to
> just enqueue in the swqueue regardless of whether ENQUEUE_MIGRATED is
> set. One of the main goals of swqueue is work conservation, and in
> hindsight it does feel somewhat artificial to add a heuristic that works
> against that.

In that case we can perhaps have an explicit flag that is passed by
try_to_wake_up() when it cannot find an idle CPU and the chosen target
is just a fallback. The task gets enqueued on the swqueue of the
target only in such cases. Something like the following entirely
untested:

---------------------------- x8----------------------------
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b64fec55a381..38005262a7fe 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -910,6 +910,12 @@ struct task_struct {
 	 */
 	unsigned			sched_remote_wakeup:1;
 
+	/*
+	 * Bit used by select_idle_sibling() to signal enqueuing the
+	 * task on a shared wakequeue.
+	 */
+	unsigned			sched_add_to_swq:1;
+
 	/* Bit to tell LSMs we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e311d1c3b992..f4246c33f3c5 100644
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
+	if (!READ_ONCE(p->sched_add_to_swq))
 		return;
 
+	WRITE_ONCE(p->sched_add_to_swq, 0);
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
+	WRITE_ONCE(p->sched_add_to_swq, 1);
 	return target;
 }
 

> 
> I'd like to hear what others think. In my opinion it's worth at least
> running some tests on workloads that heavily utilize the CPU such as
> kernel compile, and seeing what the outcomes are.

I will try and get some numbers for such workloads on our setup over
this weekend.

> 
> Thanks,
> David

--
Thanks and Regards
gautham.
