Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3D774FEEB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjGLGAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjGLGAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:00:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6608DBB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:00:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEjVCy98iZRpd5X/LbWagTeurlVPlDGNdmDKKYDVne8NvXgezhuKEspTLoME6krL8NhQ36no+ZdEH3i/Per3mZ+Jg//d4dwyUm1FlSHq5xTAfeS22nrETNF/ne89XBXRBhWJ86horpkCeDXvx/+i3U/AhRTZORBPYuE35p2+wD1HGAawmCBmy9JJ0IPbxPauTTorqlOMnBZ0ntbIoD95udamaInLVMcaBFAjv+825z7LkUJu490KGhDegDxE+PqVFxnkU5BIHa+b0BDQHW+wWjpSQlZK28Lzukaqw7BwqietvDGqXvugOXoJBowLvad3VwdimQ8g8LsgRiBQTsgjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hxoHlxTglLTsKP7jt8aagU9Mb8X3M53cguC3g2Hf3I=;
 b=nyBt16EY/hq7tBrhgE3N6pQOdXRdbMHyvJV1vYSM9nxj56AztSlkFjnwFTosJ4XRVmSr9CufFVfBOAuyS5lKqwTmF0exoQNvUzPf0MzI3wNI6KToWHVRRSEyg+0tz9B51DP9SduwmC5bYqD1K7Aegq5pPmp9Q+Y5h4cLbR5mm5ml6+fvBsi0TP9JxO1LFckj+wvvUsbN3juC3qcM6XmVvw6u1ioGE7SPuwEBvPUbwVdhpBw3TQaoTzXaTBNKfPJ7cFJfjdZpiJJbCC/WBt20544tn9nfGMZhFMEmkSoDcS3QpB5sLP+47DLpFTx8by5oL8JkXvBsWkGTl2Hy8qnY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hxoHlxTglLTsKP7jt8aagU9Mb8X3M53cguC3g2Hf3I=;
 b=IYhKBk8DFizylaxtVk4ib9x3vQJnsbKPGGTcjNSW72vnqCEGdKTwPyrxs0M3YPyEjjXyhV9Pk34HXthIguYGj+HSBQ7wwnX6K72/t/O0p8SFMS/TPhpkUTSy373bpak8FbsPuvpopi2uQO04U8un2cB2ouvxsHCc3SQHTNT6leo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 06:00:42 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::ad86:9034:bfef:7d23]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::ad86:9034:bfef:7d23%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 06:00:42 +0000
Date:   Wed, 12 Jul 2023 11:30:23 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, kprateek.nayak@amd.com,
        aaron.lu@intel.com, clm@meta.com, tj@kernel.org,
        roman.gushchin@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v2 5/7] sched: Implement shared runqueue in CFS
Message-ID: <ZK5BdysC0lxKQ/gE@BLR-5CG11610CF.amd.com>
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-6-void@manifault.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710200342.358255-6-void@manifault.com>
X-ClientProxiedBy: MA0PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::9) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: ce93ab39-7c3d-49a2-54aa-08db829d52f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCwXwQNQns9A1FJU8+xNJVBR1zSUciau1w+B+54TvFmEno1FNIGxBHBQpzJC3rYH0uDelxuDPbQpwx3k/tSzo8TQcamjVz14Mr8m79uu6IQ+NcYMuKX6FuD8V9iD1oC6XSqJqwWHkgADTWsTC1eVP5KdxoPNJTKQmiBW2K7UOicZ+nqlEu2frw8Xg8BZNYgezqwTu+RNZCcI5ZJrdeRNcmyor8YF1+m4wAAK5QZet5OzzYrD6a/JI8/UCb7hdM9gsjrS9TK0HLbVNYKAuhctsufy+BVHFl2zfLoQZE9b+OxSazrU8iV+a34JfWLirb/wZmqWjyIJ3mzgi+hvly0DDuHANrJVeT9t57/CfOGctDqYCyTLDzVR8SNfr56JM+IAsQd+ZJBINrt5MBEPYQq+oWk0tPY07lbNkcfMfCatXBOEUdoJYrdNyy3aKnj+jqY46KTh+RiHFteWUFn0Lbn7uDc8I5K7zj0kCKKUojqNNOubLg14XVr966QQOoy1TccI2+K2kZwthgJl6db+9/urkfCSICr2XMYp31rmXUPhMqnNEx/j+uaueijmK9VEI96V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(38100700002)(6666004)(6486002)(478600001)(83380400001)(86362001)(2906002)(66946007)(55236004)(6506007)(26005)(186003)(6512007)(8936002)(6916009)(5660300002)(66556008)(316002)(41300700001)(7416002)(4326008)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CWzEw3YHbv1pdwwkeVGcog9gFfG80fnYD9eUfM1M3kOnHNTQuFT7Od1cpkcq?=
 =?us-ascii?Q?k7NMcnhMvI3TAmdcM6AQaiMXyUlLsfg6FpdF6ifRDfprZ6sCR/4i+bze+wHZ?=
 =?us-ascii?Q?A6Br4cbB04oydFdiCvgdpIHKuJ3KHEDLRiteTFKdHMOWhTBMtBaDTqXz+6fe?=
 =?us-ascii?Q?7P3Qjpu5hBX194xQxBBfvSgsOtd8c3qWkaWlnxs1+a5Yj+NzawEJu60+AagK?=
 =?us-ascii?Q?+e+mzmgcEGTH0m1XRDk5EWETeEmhecethWqbkI7jGkZSiI/zPG3tmaWWQznw?=
 =?us-ascii?Q?WVFshiizanqequnDhIduuk/ysx/fw6bQ9X5q1oWgVRyWyE0vQHwbWf7h5RNu?=
 =?us-ascii?Q?C1/Hq0NSMPkNP6gkTHMYDDzbAQup0KjkGfXpZVkDKWPELhm0vfsEONmoB6MF?=
 =?us-ascii?Q?HT7ODviRiEs+HhPjGCr8mchB/M/xeEdSfCY2WH6ayyezYrUu0FRKsKTZGC4M?=
 =?us-ascii?Q?iaL7LMhoU0APZNjY0NLi8AleSQWqDWNUrka5Eu9NcVvYx/r9w8+a5MzaBJ91?=
 =?us-ascii?Q?LiEJkMJqjQj6BJ8Dn5Mt7I76Je7Ic2nlrw7iiGHn6utvayBRp8UZVFpIESyu?=
 =?us-ascii?Q?PdHaPYaS9e2VEjFL/l92XWEKRi8uwKMKX4ZF9e3PQDSH5mM889vKHjCr4aCV?=
 =?us-ascii?Q?LtgzdwmToWL56S+3XXUeag/CGC+1cweIJpQGfgzdOh0phm+wxtHW8Ojp5jz+?=
 =?us-ascii?Q?VZHXXjirzwM1FZoasK/Zqpmx3jUcAnZ3o2bUGcwoiSSCsbNgBXGWmsS1onSM?=
 =?us-ascii?Q?Ccs1HHeKKmaPdTvnLIhHRr39glqLEFe3KvydTBbNroFd6KsGhWn9qLgTdMkY?=
 =?us-ascii?Q?uwX8DniZY5TYZbYCX/OoyE7HFFFTeUrbpC4sd/75XkkPX464P7qoUSLyf5He?=
 =?us-ascii?Q?HruNLPv+IbSUtsn8spQtTGe21tu29ZE4pE7T4O7QDtQBJffxIpRIuGxu2BQZ?=
 =?us-ascii?Q?EmJfGIb/lefZKjCcxC5WmaOVe/mMRxvaNjpAZVGrZC6oaKkTmZnjsQQD0ecO?=
 =?us-ascii?Q?Vgv4nvpg8q0v3GPfMC9lM8b3zWpUF2KIuhekED5JWSeN3PS2OsjKF5KhGVHV?=
 =?us-ascii?Q?4zsxv7lFD9+yD9J/pQ7B2Iul6HfnH90vDRLNiawKqyR0ptzaJOfsbWjc8tfm?=
 =?us-ascii?Q?lS2NWO08FWmSnsvTrYJUXJWOOqmqZx25TPFi2tQN3UO9vxpRjGWCZKSFqFOA?=
 =?us-ascii?Q?9usxdt9Gd8qVJq1heIaT5Gw6Aa7P+JR0qmgOAYDOl+P5R/y8UFkudCqjqGEJ?=
 =?us-ascii?Q?xCDMjKVy17RWeJWQK549lQQi/y5ggusUWZ4tQexN+XbioPdhT9mUroPiEkAx?=
 =?us-ascii?Q?D110MUggSNjteLM0pnWu6h2WTPY5t/CkQ6Mn5VMr1tftMwLrgF9DFM84dvvS?=
 =?us-ascii?Q?SRLZK4ZtlvIMfXvEcR3cw5la8sCHWAkgyppyuwdvDZWzkxCdzK9Miw9or8A4?=
 =?us-ascii?Q?DQ19+rcz8HtfH4p/z/yKgn+Y/WT08BASfzwCmlT5cCmeDdFFn9OLr9Y6+Vp7?=
 =?us-ascii?Q?0JoYwmT+T8UhAoe983Lv6/Yny2fuZ5plIWBd3vUejwq9b06xrq95t+YbFze5?=
 =?us-ascii?Q?1aX5Zzu/zqet9z7QbvbxqsfMTW2H2X5X4OL51qVW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce93ab39-7c3d-49a2-54aa-08db829d52f2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:00:41.9826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rtWgBnFGkUOTyVyzzhzd9Jc91q/HAHwwzN3NuOI1e47o72MOAWtCPX4EE/PEbUscPZP/mLe0elLmmlBJ7qqxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045
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

Hello David,

On Mon, Jul 10, 2023 at 03:03:40PM -0500, David Vernet wrote:

[..snip..]

> ---

> +
> +static struct task_struct *shared_runq_pop_task(struct rq *rq)
> +{
> +	unsigned long flags;
> +	struct task_struct *p;
> +	struct shared_runq *shared_runq;
> +
> +	shared_runq = rq_shared_runq(rq);
> +	if (list_empty(&shared_runq->list))
> +		return NULL;
> +
> +	spin_lock_irqsave(&shared_runq->lock, flags);
> +	p = list_first_entry_or_null(&shared_runq->list, struct task_struct,
> +				     shared_runq_node);


Apologies for the bikeshedding comment : Here you are attempting to
remove the task from the "head", while in shared_runq_push_task below,
you are adding a task to the tail. Which is the usual queue
semantics. Then why call them shared_runq_pop_task() and
shared_runq_push_task() ?

Can we name them __shared_runq_enqueue_task() and
__shared_runq_pick_next_task() instead ?

> +	if (p && is_cpu_allowed(p, cpu_of(rq)))
> +		list_del_init(&p->shared_runq_node);
> +	else
> +		p = NULL;
> +	spin_unlock_irqrestore(&shared_runq->lock, flags);
> +
> +	return p;
> +}
> +
> +static void shared_runq_push_task(struct rq *rq, struct task_struct *p)
> +{
> +	unsigned long flags;
> +	struct shared_runq *shared_runq;
> +
> +	shared_runq = rq_shared_runq(rq);
> +	spin_lock_irqsave(&shared_runq->lock, flags);
> +	list_add_tail(&p->shared_runq_node, &shared_runq->list);
> +	spin_unlock_irqrestore(&shared_runq->lock, flags);
> +}
> +
>  static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p,
>  				     int enq_flags)
> -{}
> +{
> +	bool task_migrated = enq_flags & ENQUEUE_MIGRATED;
> +	bool task_wakeup = enq_flags & ENQUEUE_WAKEUP;
> +
> +	/*
> +	 * Only enqueue the task in the shared runqueue if:
> +	 *
> +	 * - SWQUEUE is enabled
> +	 * - The task is on the wakeup path
> +	 * - The task wasn't purposefully migrated to the current rq by
> +	 *   select_task_rq()
> +	 * - The task isn't pinned to a specific CPU
> +	 */
> +	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
> +		return;
> +
> +	shared_runq_push_task(rq, p);
> +}
>  
>  static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
>  {
> -	return 0;
> +	struct task_struct *p = NULL;
> +	struct rq *src_rq;
> +	struct rq_flags src_rf;
> +	int ret;
> +
> +	p = shared_runq_pop_task(rq);
> +	if (!p)
> +		return 0;
> +
> +	rq_unpin_lock(rq, rf);
> +	raw_spin_rq_unlock(rq);
> +
> +	src_rq = task_rq_lock(p, &src_rf);
> +
> +	if (task_on_rq_queued(p) && !task_on_cpu(rq, p)) {
> +		update_rq_clock(src_rq);
> +		src_rq = move_queued_task(src_rq, &src_rf, p, cpu_of(rq));
> +	}
> +
> +	if (src_rq->cpu != rq->cpu)
> +		ret = 1;
> +	else
> +		ret = -1;


So if src_rq->cpu != rq->cpu, then the task has _not_ been moved to
rq. But you return 1.

While in the else case, since src_rq->cpu == rq->cpu, the task has
been successfully moved to rq. But you are returning -1,

If newidle_balance() were to interpret this return value as the number
of tasks pulled, then, shouldn't it be the other way around ?

> +
> +	task_rq_unlock(src_rq, p, &src_rf);
> +
> +	raw_spin_rq_lock(rq);
> +	rq_repin_lock(rq, rf);
> +
> +	return ret;
>  }
>  

--
Thanks and Regards
gautham.
