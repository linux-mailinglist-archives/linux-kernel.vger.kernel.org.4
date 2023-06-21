Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9139E737DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjFUIRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjFUIR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:17:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC3D1BC7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IY3QeU/m6csNP04vzFmzTcg7t6RjHSOiukSyCjR1Q23fF6N9LSE4kXL5fcp9QMoBgWRVxQOCmuHj7wIbt0k0Wi3VPbcX4uuxolnlVn3SGCP5N1MM0rfa6AwmAyfbE0+bku7LDYX9HBjU0qBlp38YymihQcNoNN4sc7bk4YCOPGpBDnvwdI00c8u69xjBkWvCUNmf38Lggsw7eIbTE51dMvne1LohnRF5Vdq3Awzm/7BM5/Ag201zDLH2pEYAKKS4spD/jRUdTLRP9aoBx32mSEkHAsSdPDD/5mtxo0rLVS6CR3CCUX10+LWkKmXzwrJj4IzHBaJf8rI8sYuWZh7fkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsU11Ua5zmLeBqy01KiQ24kR/3j28/Ytj/IWE3Z3Rvg=;
 b=aTEmJDWmANRNKcjTQXoP7INQ72O3guInr+Yje4JYN2iFJB45vCKDGJPWY2Gx1L/R5fMqTccfQUsOFWpufS4YZIz5MmCryD0UnZhrVmFGyq3A211iYiRmr8Q+HiH0z3rx+NgpYlGGatk8IIvdHt4vEkOgkjgSJPfA5Dl2PsEucLXXgHmeN6vpvyh01PjqtBbzZAq+BP0zTaYb19iTnkfX37D+Anm0RI5u++GRq1NkNGpc6cEqIS3TR98OvLJNtjNkJVfVIUwCgNj8JnBev53yBWmJQOjTAvLGnJgliy46srLY36b8rZBR5WjIqnng4PyZeEgZhNmZHqlVAqdcs8XVnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsU11Ua5zmLeBqy01KiQ24kR/3j28/Ytj/IWE3Z3Rvg=;
 b=C+3ZxLPMsRI2KidUg8ObgEN0xknF9xqA2zOycyQ4OdD/MHYfarOUwQJlT8383A3ck6YsVYDSz1W11xkY2GOoUqh8W5nZ4lbSh34QJP59ag3GnrpHHf+vGXr0ABoEwco79kfVi0jV013AD3mgUD18u9iTHc0WWHifOZ7FENF/j5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 08:17:18 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::8801:420d:4748:33b1]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::8801:420d:4748:33b1%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 08:17:18 +0000
Date:   Wed, 21 Jun 2023 13:47:00 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joshdon@google.com,
        roman.gushchin@linux.dev, tj@kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <ZJKx/LQwc3bWS5nh@BLR-5CG11610CF.amd.com>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <ZI/x+RkSqpct4bM3@BLR-5CG11610CF.amd.com>
 <20230620200822.GC3027191@maniforge>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620200822.GC3027191@maniforge>
X-ClientProxiedBy: PN3PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::20) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3286:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: fed9aaf1-e703-429f-595a-08db722fedc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4Jf0msxtihWJB6ngGBdw52GuPkND9cWD5FBd2j5h499sKaloc749NH0en0ShN8f9R+/MXu8B6uGIgH/xvS9AoYG1Hxajj+CkunUSkkp8EIdtE1sUNmMgtilnT3q8G+ioVEeo6H2cTIT2gD5p+0qedW/eF7oj0fW0o8+TcvFWEFkEa2S+6EOHw1X0xazqFOevYZV8PbWqGKhPY3Imtf5w9So4j2eUv/dzDpQRpQv08FVoAY0eI1g8gco3MeTWYL3Zy1HN2ccQWWbU7CwT+KUJ/5whBsVKZjF/OEygOZfDjfCDpD74p4oFeDtJg6AR9UqvVFtUv6G+musflMMIoS3jb5lTGyzNvCape1yQkKU9QvqyUgEVVNjYK8sR9OS5uPTG17obh17xCfauNuqQM+OwpWj4fpQmtXT/L82rXyN6oM6h2+CX9WpHty302wU8SpZRSP+Y4glT0qLjI/jJ4NtJMSIFMVnUb6Hnrj5P5HJQSEKCgpWr00lOpLZa8aSMp2FI6Zc+ZEp4I+kn8uH7fuyh/WilpyYgXefyRSRW8f6qfU6NQDvBlHo77Lokkk+uKoJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199021)(38100700002)(86362001)(66556008)(66946007)(4326008)(316002)(26005)(66476007)(6916009)(186003)(5660300002)(6486002)(8936002)(6512007)(6506007)(6666004)(41300700001)(2906002)(8676002)(478600001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gMC1ewQyRjKMj03mxflYv9H6pmAmnqmwSkn95oz0fpK8KAnSfbm3XYhUeEry?=
 =?us-ascii?Q?/1wgbwXlhndqwIOzpiT/Hdppy/IEws60hikoahARL6ZSA3RIS1Fy8ajXtvr6?=
 =?us-ascii?Q?TdP32iRnB4Rbr6ajystbrzSNlncxuNZtiGC7xIhaFsIDuNy2U9CJfhLLTcxF?=
 =?us-ascii?Q?R14JICtGNeabAX6IoqSQ73n0Uos3dZu1/5OKLmou7VWAm4BObf0O+/5SWtG9?=
 =?us-ascii?Q?0H6jzhjUOQzoDfvH0zSW0vQgX6hseoDtwJ7P13AhxeYq/Zb8VJ3B7mG5tzG5?=
 =?us-ascii?Q?Jf5U8HQUjVYNbskEWeFz7Bt4cGHLdETNkqXcYeGijbpj0xGNnJjmStHPQ75b?=
 =?us-ascii?Q?CQIS0SJIVoi+pA1X1ynN5b5UyCcMWWU0W7wsRYSPVi5TqI6BtxnEPXCxbBWa?=
 =?us-ascii?Q?qRikbCjW/pip3cem/DV8tBjIm1aa3OUH06MzR8yRNOTuCZN2wHDE28/rCgd2?=
 =?us-ascii?Q?AfxFMk8uhOuPp+TLLq23v3OJVZOgJ/+qXXZrnah8fBHqAqc2vl5VGEeqXT2z?=
 =?us-ascii?Q?LKWtDILqIggqQQhYHIF2+Ii25ZKpX7sR4/h+NkUrciDoGSH9wmGDIzmisQYv?=
 =?us-ascii?Q?3CfpHKOUKP8UKzRFGnaP66Jbhinr8fX5GR+urs0sXR4wtsar3TNtk/2hOoVr?=
 =?us-ascii?Q?F73zA4sZTifQHA4BATUHhwHqdG4nIazLDP9//aycw9fwOsMg7dWn/VmZjThk?=
 =?us-ascii?Q?+NfttPwRdwgX2oz7fwKS5elXfYImTVTTJPTVZeH4W3RnYFMgs6Usr/pbef42?=
 =?us-ascii?Q?1nR3bq0uvvjTz4bIRJ2bsyrT8vqGB80comWPJKxU95ZQfcdT1NuFoDajvV9J?=
 =?us-ascii?Q?n3XPT846eSH4UnjPdHGtBFP62LQh+TmWr3ZAzA3gt+PPc7o1tW+RBxV/ogMA?=
 =?us-ascii?Q?OUrps6C+u0IDg/bJzRuXfV9pScAHG0J8x7k9WaWh+w3CqCJU5qkRPgqf/1Hg?=
 =?us-ascii?Q?WHa9qrXtEvd4tsCTTaKjA4oVR3j5v9BFhBwnTSbf0B57th07TAOEsD2GJ+N8?=
 =?us-ascii?Q?oSy8EmQuImCOrbo21twaabs/BbkS7eqAmcnWrauIhzO277PtVfdq+rlvzOCc?=
 =?us-ascii?Q?YyBtumljUGJZU1WyctTpQ4Z5zWpYMFN1OeslZ+Ti8uO3Nut7hlaYpeAwLAHG?=
 =?us-ascii?Q?CS1IYrlS2XoIAR7+anaqlsVqHe8d5QOPAPkMnyggX2y8/8KRvIUs6Kvdjtnk?=
 =?us-ascii?Q?KlIqFvjmPSE/Xocoa/hHC0kV7iLQ3aggaLf/vZw0Qv2UyQqIN67LJWyKLHFu?=
 =?us-ascii?Q?VoEPDX2rBnh67P72lvsUo8kkM9FM9DIhP67JIs9JvmDLVdB1pafssDHL2fNc?=
 =?us-ascii?Q?M+N3hOEYvncqKz7o5w5eR4Bzif5O0RHN6ivnko13XnF3tYPwSJwW9gPCzsqP?=
 =?us-ascii?Q?p+RSeIuE0JqoHhKi6O0lMcnllhEZWJp+hyHcmFwxyOeZWhv7FJBwT/lcNsup?=
 =?us-ascii?Q?d+7HlTGkEIvhONITO9qbK4XiYTts7aNibMvVur34cJ+1THC2WBR4hObPxwpn?=
 =?us-ascii?Q?avtzxNlBemeOaLDkgd7fdkgxml5Dk10bj3ntiyNHS4Eqj+/XQnv7bNIAUciR?=
 =?us-ascii?Q?4ae6W//e8zoIWv/uFRsOhgkVsGd23sKiOqGnOCoV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed9aaf1-e703-429f-595a-08db722fedc8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 08:17:18.5422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcUGraPV2u5coFFyfCfDpVHoMYIBgIski61ozihwCui20vGZmHRhUi4I+z+VlDVVkJ5+i5ity59HPx6ddqUrlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On Tue, Jun 20, 2023 at 03:08:22PM -0500, David Vernet wrote:
> On Mon, Jun 19, 2023 at 11:43:13AM +0530, Gautham R. Shenoy wrote:
> > Hello David,
> > 
> > 
> > On Tue, Jun 13, 2023 at 12:20:04AM -0500, David Vernet wrote:
> > [..snip..]
> > 
> > > +static void swqueue_enqueue(struct rq *rq, struct task_struct *p, int enq_flags)
> > > +{
> > > +	unsigned long flags;
> > > +	struct swqueue *swqueue;
> > > +	bool task_migrated = enq_flags & ENQUEUE_MIGRATED;
> > > +	bool task_wakeup = enq_flags & ENQUEUE_WAKEUP;
> > > +
> > > +	/*
> > > +	 * Only enqueue the task in the shared wakequeue if:
> > > +	 *
> > > +	 * - SWQUEUE is enabled
> > > +	 * - The task is on the wakeup path
> > > +	 * - The task wasn't purposefully migrated to the current rq by
> > > +	 *   select_task_rq()
> > > +	 * - The task isn't pinned to a specific CPU
> > > +	 */
> > > +	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
> > > +		return;
> > 
> > In select_task_rq_fair(), having determined if the target of task
> > wakeup should be the task's previous CPU vs the waker's current CPU,
> > we spend quite a bit of time already to determine if there is an idle
> > core/CPU in the target's LLC. @rq would correspond to CPU chosen as a
> > result of that scan or if no idle CPU exists, @rq corresponds to the
> > target CPU determined by wake_affine_idle()/wake_affine_weight().
> > 
> > So if the CPU of @rq is idle here, can we not simply return here?
> 
> Hi Gautum,
> 
> Sorry, I'm not sure I'm quite following the issue you're pointing out.
> We don't use swqueue if the task was migrated following
> select_task_rq_fair(). That's the idea with us returning if the task was
> migrated (the second conditional in that if). If I messed up that logic
> somehow, it should be fixed.

Sorry, my bad. I see it now.

So as per this patch, the only time we enqueue the task on the shared
wakeup is if the target of try_to_wake_up() is the same CPU where the
task ran previously.

When wake_affine logic fails and the previous CPU is chosen as the
target, and when there are no other idle cores/threads in the LLC of
the previous CPU, it makes sense to queue the task on the
shared-wakequeue instead of on a busy previous CPU.

And when that previous CPU is idle, the try_to_wake_up() would have
woken it up via ttwu_queue(), so before going idle the next time it
will check the shared queue for the task and find it. We should be
good in this case.

Now, it is possible that select_task_rq_fair() ended up selecting the
waker's CPU as the target based on the
wake_affine_idle()/wake_affine_weight() logic. And if there is no idle
core/thread on the waker's LLC, the target would be the busy waker
CPU. In the case when the waker CPU is different from the task's
previous CPU, due to ENQUEUE_MIGRATE flag being set, the task won't be
queued on the shared wakequeue and instead has to wait on the busy
waker CPU.

I wonder if it makes sense to enqueue the task on the shared wakequeue
in this scenario as well.

> 
> > Or if the idea is to avoid the scan for an idle core/CPU in
> > select_task_rq_fair(), then 
> 
> No, swqueue_enqueue() is called from enqueue_task_fair(), not
> select_task_rq_fair(). If select_task_rq_fair() (which is of course
> called beforehand for a waking task) found an idle core/CPU, we don't
> bother using swqueue, as mentioned above.

Got it. Thanks!

> 
> Thanks,
> David

--
Thanks and Regards
gautham.
