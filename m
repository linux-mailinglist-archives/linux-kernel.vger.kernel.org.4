Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBD85EABA6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbiIZPwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbiIZPvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:51:48 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E68248DB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgZt4wxGwbz99qWNrnG4kyKIrmodK9tIxQtEgKrY9fl7wgwXsbp26E5AzfiA7oKBlhFG4JuuEr+4DR7L0JIa6oS6DTtFgUw8jHfPcrXQMrjQwxHLyApzROxi+77BWVGAl5bsazyPOCCZDhvvyaZZ0NH99mrVvbslcujxS9URj5hF6qxuZ0d7yEjebS5848XWjX3jWuxsK2nmmcUb8dzz2l+20nPVzlGqdJ3WBnhxlBG7W1+hRDJqoiK56wJcco3meocllrctKQSKFQevYB7vdwZLHmeEPhkM/jS2dDKIXuwKh98FLbegrf4E6+vvMqwcVot/CotyDCGeTmfcwlzfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcGEzZWymqsBpefRkbZX8YmwxcetGpYJFl82foZQrmY=;
 b=JgFytjmMmZ2ngpmZtU9EMq+joycld/Qw3o1Kxfdsza+8CGJrTS1a/F9AJjBIAduNEWhWvAHH+jvZn0GQ/Hd/lcVcNYFVEM2lkMTYazOxZ9B1ZU0rC6nOMkWUR3joNQTWF9uC2I5kyVkpS+8NDLZywbUKFFHa5hHPswWOt5u9TM1U3kxxVCH0Mz38h7z12D06U1PL7PVitSmZQmA1/YKFWziaXEX3T/vACByb6w7s+RjnM5qTguaCGiqTrieCB0vs5GbqSHrQH1nQwhvQHHRzgaGfdfjBeA6bykBhcMYt8NoFgSxb6dC5IuKqJ23KEPnST4k39cQpv27B3bS0fVh1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcGEzZWymqsBpefRkbZX8YmwxcetGpYJFl82foZQrmY=;
 b=z3OfMcs1g0Ljr4x8C1bRUnqsJF4qgwEkJU8Dae3BmxGeG1WkOA2i608SVZntMwVBj7QC5eCcHkURlNsKN8r9jfxY3zdIlH32ELjo2ofmES/xcwAepL5xaThZ76EF9k+1FS2E51ThjiSmoC7xyd4inBrfoPCe4U+UQjaNKMfynmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by SJ0PR12MB5486.namprd12.prod.outlook.com (2603:10b6:a03:3bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 14:39:22 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::d9d7:b36a:edfd:62cd]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::d9d7:b36a:edfd:62cd%5]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 14:39:21 +0000
Date:   Mon, 26 Sep 2022 20:09:04 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Choose the CPU where short task is
 running during wake up
Message-ID: <YzG5iAyJv3YCDKcp@BLR-5CG11610CF.amd.com>
References: <20220915165407.1776363-1-yu.c.chen@intel.com>
 <7975dcbe-97b3-7e6c-4697-5f316731c287@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7975dcbe-97b3-7e6c-4697-5f316731c287@amd.com>
X-ClientProxiedBy: PN2PR01CA0240.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::17) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3286:EE_|SJ0PR12MB5486:EE_
X-MS-Office365-Filtering-Correlation-Id: 569b9053-37f3-46b8-f2ae-08da9fcce65e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02IYm5RIByjPsKYSxZk9TVHNFK+gFRJD+UJW5ZF+rf0v9QVzdWljRciaBnzLAakWDSlTAHnMhYcBCHbRhzQtroOLR6CMm65EjSgEx5KdDPdnnOSHwQZ6Z0XR9DKIvchiVCSsVrhaOfDd1hf0Yl8TYM3Xr/u4bB5x2uA7Wb+tnj1jaEKp/amY38B+Yp1EllQCXAUAveBu8ooP0TGIDwVfikZjUHrRwyJgTK98pj2W5BMe0FrWEI5BfPoiNZZk/BkoMNckiu6+q4ZoqF+6LbFa48sRw8kwgkfS+rHp4blgM/b9IctnZHFIMLxefNTB1VwRwvRKJ3SkUbgmtEbOqQ4SotCFBKge/VfDrcNazOEMO3XzCIndH70akeT9JiRJ4FG9C4JXEGpgDY73WHea2ryypMR9n4bxR89IUl07BiLOntMWsP3h+z7KxfFBSvV0IOAD2SgHch3/bnq/LsIR2crmJ2RvJtRzuZNMiAObRANDOI5gh1tIVIZC+6wciwUpQHstKYW+zkLYv6k3nOe4qU/VZ/24B1yzk75iFmOA8/STFdtjN70Ln2XvdXuHx2n+4OePFjyMSKNvEkfnZGccLARZFrggKwEbjo24GPyDNbTvBZpr7jnDvZ3RaCMS03BLXJlw+yUaaW+b3GFtUwRPMF8jTxfWOCxrx7ISGVh2J/9XDfk/UDnItnkS8Rlq3X6RxiWHH90nqEB7msak5sRDHLlPvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199015)(6636002)(54906003)(66899012)(4326008)(6486002)(66476007)(66556008)(66946007)(478600001)(8676002)(316002)(6666004)(7416002)(5660300002)(41300700001)(8936002)(6862004)(6512007)(26005)(6506007)(38100700002)(2906002)(186003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cdFF8GXrXdsohTMLuJdyYQwK0hnmWs17dzRDHhW4U2zhae4fm6iA7KbZFrHV?=
 =?us-ascii?Q?UbyG5b1tHMkF0XUScijvjte4Z/VNBG4Qh8XGzrUgd8lwoCuRUmK7OtR3IuVj?=
 =?us-ascii?Q?Gs54t0NIeguWPSyGNCIEQTvxQOtvLoatBq2Wp54c0l9ApzaqzSitk0cfAzdn?=
 =?us-ascii?Q?0UATLQideJhdmUlT8lBepF7ClKdfMv26/pVUwqgq81Hmyk2iRnVJW+rgWDDK?=
 =?us-ascii?Q?w/RllfPu4kZhxkf5MRgDOOWKFta9uAZFEUXIlmoOfxvMqS2UpUkNPzDb/zCn?=
 =?us-ascii?Q?QQZvUerOF3wRHYkJKPLn/g8FnQKxd5fqC8GN7mcWjc54BSGtTRUwSbCEgNNE?=
 =?us-ascii?Q?U60KnpqScbLqw3EMAj55ezwHiTInWBsh1X2YbbzkRD7kv08hJqKWkBoxfsi3?=
 =?us-ascii?Q?UvV8F41Xfu1Z3NfyGvNmFW3hwBpMX469SMc+JrFqqVqao9Co6a6lDML9GMFN?=
 =?us-ascii?Q?q+aFMcpENwAvXL3N/1rSI6K/rl47wJPyX/qpg3gGq2sBmM9d/+luiElOC11J?=
 =?us-ascii?Q?HPexgggHx5aENRFaLybegXZn4XkklxuKIh9Z/hYl3SOSBYgLdGDKR3/3nXiF?=
 =?us-ascii?Q?tNbt/sVVyt4fpzr6N5q9j5qVOQkzrhSJlJ64L01PdY0hRKk8dgoxZkSv9jMQ?=
 =?us-ascii?Q?5yjCLG4rQpOkou7A63F5743kut7j781BmnacTa1auzAuTExMr+3vXFJvbSu4?=
 =?us-ascii?Q?MDV8AUyQfxlCtCqE5pfEYTFKBsGdrFrK9/wOPU44nNmh9UBpZXsEcC7J39IW?=
 =?us-ascii?Q?/60cnbDExnI5AWrScxPRXVwxNMQhuoR0hWg47Cb9zH6XxMGyaY47hPlIOYbH?=
 =?us-ascii?Q?81AkWvY79bnNeZqqKQ0DKp1UBxWq7zxgz4opdAbwkAUjK7QwHLFhNGmGY6T/?=
 =?us-ascii?Q?fAYw7j0w84NoAJu/eCDHzxg219fteeegGWZhes81zCMblkw8XVmmi/h0EV+N?=
 =?us-ascii?Q?9c42iNA1lxQpzvUVqez2VCu5oBkAF/esyhKF7BqoP1u8aldxkMKUBxsI5yao?=
 =?us-ascii?Q?bOu4VO+PyfU0WlTlllOtCMRIOJIyrkADeETkTcsgLWxWMiJPZIFTPT0Tj4WX?=
 =?us-ascii?Q?8ejSYEb1oLTNm5i5UHcPsK/OQDHbbuavRN/NLt3gkwHzHSsNxi+gJd0EyNeu?=
 =?us-ascii?Q?nnTqBdAwOw4ZV9Fdk5MP+vrMXLiZlQ+NDYHkzbqVOFYW/v2bbVKW4nG4fjp1?=
 =?us-ascii?Q?wZymNRfDvh7Zkn6KiyMFuZestNcdF4+JlQ8vIZMQYWuBIG7Ea3x5+fYVWmWn?=
 =?us-ascii?Q?Vs6U/3/CGJh3oNpr7klPpjk9KGIvCRkoSmKg8dp9dzUajpzjyVf7dQR6GDFj?=
 =?us-ascii?Q?VKGD23DS5rAje4Bo/RPCp97D9lOOUFS6WpxtU+4q28f9kAq7vU8jnxuVzn2U?=
 =?us-ascii?Q?RPYKX8HQIcNsqV/4mRLa2Z98P247v4kMneE3zBiaRgxCdsvt+2d6QFxoE33T?=
 =?us-ascii?Q?MWfsjFXFdjtB51LWJNmp2S4QJ4JlucDRe310hXRC6h78u05yGY8rCZUp0Hz1?=
 =?us-ascii?Q?Av6tpnkF9xU1ZFYC+ifVYyVff/IfRAh4Hh/U9tuOIecky2MN25dKgF8K35ND?=
 =?us-ascii?Q?ohsxcaTM3iI49zRyRTA1PFDF89Rqyo9MW2Ec6uD3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569b9053-37f3-46b8-f2ae-08da9fcce65e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 14:39:21.7066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I33aka827AEPIsg//azynPQTO6vDUzkuAX17G9Yn9+qzlNY+pHzVc20814KF/pnk57aERXcFJdlbguqHUGhojg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5486
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Prateek,

On Mon, Sep 26, 2022 at 11:20:16AM +0530, K Prateek Nayak wrote:[

[..snip..]

> > @@ -6050,7 +6063,8 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
> >  	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
> >  		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
> >  
> > -	if (sync && cpu_rq(this_cpu)->nr_running == 1)
> > +	if ((sync && cpu_rq(this_cpu)->nr_running == 1) ||
> > +	    is_short_task(cpu_curr(this_cpu)))
> 
> This change seems to optimize for affine wakeup which benefits
> tasks with producer-consumer pattern but is not ideal for Stream.
> Currently the logic ends will do an affine wakeup even if sync
> flag is not set:
> 
>           stream-4135    [029] d..2.   353.580953: sched_waking: comm=stream pid=4129 prio=120 target_cpu=082
>           stream-4135    [029] d..2.   353.580957: select_task_rq_fair: wake_affine_idle: Select this_cpu: sync(0) rq->nr_running(1) is_short_task(1)
>           stream-4135    [029] d..2.   353.580960: sched_migrate_task: comm=stream pid=4129 prio=120 orig_cpu=82 dest_cpu=30
>           <idle>-0       [030] dNh2.   353.580993: sched_wakeup: comm=stream pid=4129 prio=120 target_cpu=030
> 
> I believe a consideration should be made for the sync flag when
> going for an affine wakeup. Also the check for short running could
> be at the end after checking if prev_cpu is an available_idle_cpu.

We need to check if moving the is_short_task() to a later point after
checking the availability of the previous CPU solve the problem for
the workloads which showed regressions on AMD EPYC systems.

> --
> Thanks and Regards,
> Prateek

--
Thanks and Regards
gautham.
