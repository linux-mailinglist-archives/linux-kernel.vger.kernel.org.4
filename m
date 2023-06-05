Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A71721D32
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 06:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjFEEqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 00:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjFEEqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 00:46:34 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B9998
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 21:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzAeYQH+cc8QLjt46W7rZWQK1Dj4tXY2zaUBmb5/V6CnDpO2tjPnVbA+nh76KzCtM1ybCHRFvq0DxrrLX6pHRW+jaEu649RrIR8sQ37mWVES4PBGISUg43aCt9IVm1HUlefikFolb4KwdiGoL1f/evaHMy+T10GbrhtUhO83dhtw3aLBPk8CPM7Za7GYracby2ko2iLJ/xJvhOmtA9PHjBBzuYrXctiHHLlhOKFXmLXfXNHOIzzm9I4TylMzV8Wde1JvGgpLk6QTpsU48Z02S6mY/k39Qp3RKP0c6SYTRUHFCQ/5+OFITLh82pSQEqURWOSUrmj/V/bFLIqhyTR/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pb+FKyki8jLWOFqFl9aDb7dSOdCutbpd3qsqcFSIqfI=;
 b=DfSxcRidXDm/HVMLN+xUJDv5xBd2hUgJ7vl8aAC8CzSKysjjMpE2V+cczdKTCqWVZJkjdLGuoSMMY5Qir/bjiIwbmVFw3MFZ5Qs6mT52vXA3zFpQbd9OLzUj4dUPDqQPnZ9teYNTEhXP1dYMsGdniM/Nirb3lUtpJfpCT2xaMlHQRXZwlQ9YD2Z1Zidu3bPUQGc56C66adnkBfmEo5uz7fMTH75kU03QhuxDbl7h1xPFc6MSV5j0nWhteBE4nMSKPz/WePZa/F6eeViPCML8XhJaw+FOUYmrSrmIJtjvMwSsGpesKCotlzJuGW5yCjhArkkRAIl43MYZWIPO6YeTzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pb+FKyki8jLWOFqFl9aDb7dSOdCutbpd3qsqcFSIqfI=;
 b=TUEmec5vNf626/paVtTrfYUnDZ76WU9nFnBw1NrpQRI+IijcoTAzpAgd9Jku1pqT4ny1nXz5QUIpIKynalVRozPUSxGyuZc0nZsZ0RqoE31042gOJesJ03CV9jEasGF35P5IZ++0XFOHEcu1ACZcb4N9rPp37Mq/graNKuyCd2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 04:46:26 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::8801:420d:4748:33b1]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::8801:420d:4748:33b1%4]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 04:46:26 +0000
Date:   Mon, 5 Jun 2023 10:16:08 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, libo.chen@oracle.com, srikar@linux.vnet.ibm.com
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
Message-ID: <ZH1okIz83ELfjy4o@BLR-5CG11610CF.amd.com>
References: <20230519001709.2563-1-tj@kernel.org>
 <20230523111818.GH4253@hirez.programming.kicks-ass.net>
 <CAKfTPtB11Zwt9bgOJrNVDfs5yY7Dws_vnQBuXZHErSsbn9Edhw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB11Zwt9bgOJrNVDfs5yY7Dws_vnQBuXZHErSsbn9Edhw@mail.gmail.com>
X-ClientProxiedBy: PN3PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::17) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3286:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 2478ae17-6376-438d-e231-08db657fd1a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2yCBlrfjRiNKfrmraudMJ+lw/wICqiVRESm6nBib5dVxhHTSf2EV0MuKKq+opBZYTHVKg9JnPPvwdFX6YX0vyyJybjzJLKaF/NC/QDxYUadQSJhh4FJf7KucGaMDrJntUIwNxCojPOe6G6zOtg2K5rehRbXNXJLShNA/jW7LOEFG3EP2Bd8CaJ0+k9sYeIrbxFqtGgjGFAoiypXNfrLLoMdF3qbU8bqZDNknPPNDdrwyUHLG3nr1QloHKwC8tKZ9nC1M4PrndNXvgyz9Hu5cROI7axYetvpMcrSkV9HhsGOn+TnUkVvxCwRQU+tLfbWGVMLHHd+GSJ7z3fbPf3Ioo4yHSJqmK1J1gJt44WRV04PS/QAI1r5/H3jVw1k44dy3hqNUC11pQJ+DiGW0AbG37jksb6onXvvf+ZPizsPgokzLfSRLTHG3VbClBbwX9C0/VEPA1bgXsjh+0RGlavj+/SwoRsHneG/TjmbUwsP1tjOt1Y4c89yqvaqutf2gb5KETqz9uf878lCBoSX6mrM5Uuw0NEZQYMaY/J3ufLtE+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(66476007)(66946007)(2906002)(478600001)(6916009)(316002)(4326008)(8936002)(8676002)(41300700001)(54906003)(66556008)(6666004)(7416002)(5660300002)(6486002)(6512007)(6506007)(26005)(966005)(38100700002)(186003)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bw7bDrkaFVmMNHbJmTdlAAII0/G+pZn0fMENFfKha0zQ+4urc2bMAAeTpl3U?=
 =?us-ascii?Q?24pkxBp+rxF1xhjPZtebUukuU8m1fpWkL5yVIeMVp9CHsr4hGUEO1ZbiLrGc?=
 =?us-ascii?Q?8STWhPq56wxQHStD60MM8CFHKh+2+J1EyynsiwyEIy4RmkzuF3kjn3NxW2ia?=
 =?us-ascii?Q?7IUKbUw5xSHuAYTgt+mk2OfCETAQ0B9b4tk2b2IUCarR9JcH8Xyv+iJ1D5fU?=
 =?us-ascii?Q?SvIU0S9K5ApAHNIna1/KvWLc9KzR4yUst6LgeowzpOHuxKONh9o2afrd0k/1?=
 =?us-ascii?Q?JrubWVy6cZUmUtdVTcvQ3c09lnGZzLevufBt9fmMA/yU5iozcIgoV+v4YyMl?=
 =?us-ascii?Q?riy3HRuTndppJ7vFGqEgMlDhcTvFy7yxAzVnmSNv/8o898tNjlHrl89MBBr6?=
 =?us-ascii?Q?6N3DrJt/g0uteDAgvk2boI3RWdbUfy3xscfG0yv4f3LY4S/0AihLPxH7teND?=
 =?us-ascii?Q?k/2zQ94hvpaq3xQpDIY/ociI95KYg5kkuKEbj3xClay4g8p2JI84Bbbb9OyQ?=
 =?us-ascii?Q?/uzeVBaQlOg1EETIHMwURVMhanTGkaJB6EjN8E/J1g8dx5ox33UjWvIYl3Wo?=
 =?us-ascii?Q?U9gAg3GGPCTu3NvdpiZ4xqJpn/5afsp1EbR3SIIPS4PO7lSjPEO1s4X0fp3V?=
 =?us-ascii?Q?wlU3Bl+FS1FoZnGbT4TE8VMJDScrbj5FPqi19zukESjdHn0UC2ck9Gop9Zoo?=
 =?us-ascii?Q?GxwxjXvV6gtn/9xMNgiFFrI4JLi0+bX81G/72g+j2gdfBfKD2LTLEWcnI2+a?=
 =?us-ascii?Q?Eede/nbQN763UX9kkBS9T07/YMW3yWm9pSLrrh4bJKyP/WAN2ckXOSxjpfI/?=
 =?us-ascii?Q?ItMflsB1h55Z6pgJ7uc8cgMMpHu4es7YKXsgRoyNSwaErcozXdUF4RyOPMcN?=
 =?us-ascii?Q?KSq3aGdNvfPlXudCzVMgPGQmcKa59oKeNbkTVkz44U3UhOez8InscPHyzmER?=
 =?us-ascii?Q?QWVwSH6IAp8qETiA1EBTe3oDvhTXNZQYAtlg2O7/7pnKwpSvIWKxWWxT1WL3?=
 =?us-ascii?Q?HvwNRPYJdNN+ZkVfutjRfiQa1urb9V2r67ZGMlvF+c4QnXaJ8xCrRBrsILAu?=
 =?us-ascii?Q?/klF+bm2qfbInyDciisK3xo1lA3LF3NTROwMj//VSFh49RDP8OD6J8PW2bom?=
 =?us-ascii?Q?OI/WYVk8ohLQ80IYejzAjfYAU8Vuh8rEdx3F9V404vrMSBbLLvEAU0QwyunZ?=
 =?us-ascii?Q?gCtFgH11CqdIIUPBLY3yLk7pV+rUmP00R1N98Qthm/d+i4GFJQ/PBzoVjKXn?=
 =?us-ascii?Q?tONVjMOqXil3s+popTz29cD8IMJye8tfWqrx+y211k4asyw/yHz1/aLNidXM?=
 =?us-ascii?Q?YiYuZRRMrCrbNvgv9oJAitoMN6fDH2AnRLBMI8EexcQJvWpSVZCHyRidTdlg?=
 =?us-ascii?Q?mP3VDVtlj6hRuHjmwOhCc2Tro5E21pMJykD2dXhulCMQzDuGGQouTcgJpQX5?=
 =?us-ascii?Q?6vClaRU9KUeCeNG03IfgbJUZy3Vw59506y3apd5LU9EsDhKNIqXiJX1UnbQ8?=
 =?us-ascii?Q?/aodMDy1uoENk0q1wfmrHbl30WdsFFx0SKXPMeOSXmD92gk/V3PZXgq4tCZ7?=
 =?us-ascii?Q?LoXMPJEMLjT4y6k+u9EMGqSeitv+Ye/E4hZZV8Jx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2478ae17-6376-438d-e231-08db657fd1a3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 04:46:25.8260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAoF+/IPCYfHSXU7eRXkBIXrVlqCyIrWrtasMbTtNZHlouQIPMJEvo0SE/eMro5J+J2AlTK4JM9w2RVtX2YGBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vincent,

On Tue, May 23, 2023 at 06:12:45PM +0200, Vincent Guittot wrote:
> On Tue, 23 May 2023 at 13:18, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > So wakeup based placement is mostly all about LLC, and given this thing
> > has dinky small LLCs it will pile up on the one LLC you target and leave
> > the others idle until the regular idle balancer decides to make an
> > appearance and move some around.
> >
> > But if these are fairly short running tasks, I can well see that not
> > going to help much.
> >
> >
> > Much of this was tuned back when there was 1 L3 per Node; something
> > which is still more or less true for Intel but clearly not for these
> > things.
> >
> >
> > The below is a bit crude and completely untested, but it might help. The
> > flip side of that coin is of course that people are going to complain
> > about how selecting a CPU is more expensive now and how this hurts their
> > performance :/
> >
> > Basically it will try and iterate all L3s in a node; wakeup will still
> > refuse to cross node boundaries.
> 
> That remember me some discussion about system with fast on die
> interconnect where we would like to run wider than llc at wakeup (i.e.
> DIE level) something like the CLUSTER level but on the other side of
> MC
>

Adding Libo Chen who was a part of this discussion. IIRC, the problem was
that there was no MC domain on that system, which would have made the
SMT domain to be the sd_llc. But since the core is single threaded,
the SMT domain would be degnerated thus leaving no domain which has
the SD_SHARE_PKG_RESOURCES flag.

If I understand correctly, Peter's patch won't help in such a
situation.

However, it should help POWER10 which has the SMT domain as the LLC
and previously it was observed that moving the wakeup search to the
parent domain was helpful (Ref:
https://lore.kernel.org/lkml/1617341874-1205-1-git-send-email-ego@linux.vnet.ibm.com/)


--
Thanks and Regards
gautham.


> Another possibility to investigate would be that each wakeup of a
> worker is mostly unrelated to the previous one and it cares only
> waker. so we should use -1 for the prev_cpu
> 
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 48b6f0ca13ac..ddb7f16a07a9 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7027,6 +7027,33 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >         return idle_cpu;
> >  }
> >
> > +static int
> > +select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
> > +{
> > +       struct sched_domain *sd_node = rcu_dereference(per_cpu(sd_node, target));
> > +       struct sched_group *sg;
> > +
> > +       if (!sd_node || sd_node == sd)
> > +               return -1;
> > +
> > +       sg = sd_node->groups;
> > +       do {
> > +               int cpu = cpumask_first(sched_group_span(sg));
> > +               struct sched_domain *sd_child;
> > +
> > +               sd_child = per_cpu(sd_llc, cpu);
> > +               if (sd_child != sd) {
> > +                       int i = select_idle_cpu(p, sd_child, test_idle_cores(cpu), cpu);
> > +                       if ((unsigned int)i < nr_cpumask_bits)
> > +                               return i;
> > +               }
> > +
> > +               sg = sg->next;
> > +       } while (sg != sd_node->groups);
> > +
> > +       return -1;
> > +}
> > +
> >  /*
> >   * Scan the asym_capacity domain for idle CPUs; pick the first idle one on which
> >   * the task fits. If no CPU is big enough, but there are idle ones, try to
> > @@ -7199,6 +7226,12 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >         if ((unsigned)i < nr_cpumask_bits)
> >                 return i;
> >
> > +       if (sched_feat(SIS_NODE)) {
> > +               i = select_idle_node(p, sd, target);
> > +               if ((unsigned)i < nr_cpumask_bits)
> > +                       return i;
> > +       }
> > +
> >         return target;
> >  }
> >
> > diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> > index ee7f23c76bd3..f965cd4a981e 100644
> > --- a/kernel/sched/features.h
> > +++ b/kernel/sched/features.h
> > @@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
> >   */
> >  SCHED_FEAT(SIS_PROP, false)
> >  SCHED_FEAT(SIS_UTIL, true)
> > +SCHED_FEAT(SIS_NODE, true)
> >
> >  /*
> >   * Issue a WARN when we do multiple update_rq_clock() calls
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 678446251c35..d2e0e2e496a6 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1826,6 +1826,7 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
> >  DECLARE_PER_CPU(int, sd_llc_size);
> >  DECLARE_PER_CPU(int, sd_llc_id);
> >  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> > +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_node);
> >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index ca4472281c28..d94cbc2164ca 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -667,6 +667,7 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
> >  DEFINE_PER_CPU(int, sd_llc_size);
> >  DEFINE_PER_CPU(int, sd_llc_id);
> >  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> > +DEFINE_PER_CPU(struct sched_domain __rcu *, sd_node);
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
> > @@ -691,6 +692,18 @@ static void update_top_cache_domain(int cpu)
> >         per_cpu(sd_llc_id, cpu) = id;
> >         rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
> >
> > +       while (sd && sd->parent) {
> > +               /*
> > +                * SD_NUMA is the first domain spanning nodes, therefore @sd
> > +                * must be the domain that spans a single node.
> > +                */
> > +               if (sd->parent->flags & SD_NUMA)
> > +                       break;
> > +
> > +               sd = sd->parent;
> > +       }
> > +       rcu_assign_pointer(per_cpu(sd_node, cpu), sd);
> > +
> >         sd = lowest_flag_domain(cpu, SD_NUMA);
> >         rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
> >
