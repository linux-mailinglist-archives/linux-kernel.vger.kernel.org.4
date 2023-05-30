Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D044D71634E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjE3OM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjE3OMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:12:22 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD167109;
        Tue, 30 May 2023 07:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buFL1ST6g1tNGf2MDjOPJvaCqvpLQk5CiPY4wu7/O30eiCL2h8eFxA+rrsOaaFoylGNUQUF/w98NEsogUCfzR85+raY7NHvdgpS8OLvNBqFQmspLRS/V+bQIpKvYCIox+qIBq9tpBpIhLIR6zy3rFQrIEPBzsgdOwLm7NFKkB9hleaiU2bKN8IF2hV0dh3+Z2cDZG0g86MqnhkL5e7rsONiL3BPmQ2UmWs/GKYhKrYawYfFQR7n2aLH4EFvCldlOoTWwARLuvppOOxDZNM9NE4pgsTUs5sFHTWXAnnOHGJZooE1YuK9hvW3BsHDWS+zMOhiOuSZq7R4F7YaL4JdE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnJHi2ZlqSuDd0Mx7M9qF4+qh+fPN9VcRTMp4ilwUeg=;
 b=UDVUPVj8m20VCm+ZmiQCVZq3LyizgCHpNYZP3mhMnkNs337aN6V02i3kRVPV9z23OXTC8788QxhwdzD1Z0fNUrsUHiG2YWNwkGPROYzTfY5ZpRMRo1emGvI3dbS6cJgLzysef/HJoCx6JBtiZb0jkH2YC0k/Qi0iO6kxIaa1+WQsgSl00asTa//nfOOQZbwuTSDsFNhJhmtT54I3JDc7RJRSySpqc6bDQSCzOk7iNcKGvxQTnFH2QeRoaaDBussRa87dox3wfq2cwqpZeq9p6pn5cyS69q2ahaEyS9KgYYKZnjesinsBSaOB/7Ur15LNdr8dveBbCczrmZaGh8/61g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnJHi2ZlqSuDd0Mx7M9qF4+qh+fPN9VcRTMp4ilwUeg=;
 b=dY94+bMTX60g3ZgX7nfDjJRFuK274Jlmb9/0W2y7CKTOhlyq6jU3qiC8SANywsiE4mxY1+uPM5YUDwLPgJPD7gjgeyo8HLe9d8ZHL2rOoXF+LuX6IhZwthN4mobWcmclO4hSFVlZQn1qoxy+Lxba/Z6M9sepYUF8yzoHMLbqLbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by DB4PR03MB10105.eurprd03.prod.outlook.com (2603:10a6:10:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 14:12:10 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::8925:5293:e478:c934]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::8925:5293:e478:c934%6]) with mapi id 15.20.6433.020; Tue, 30 May 2023
 14:12:10 +0000
Date:   Tue, 30 May 2023 16:12:06 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Vineeth Pillai <vineeth@bitbyteword.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        youssefesmat@google.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 1/2] sched/deadline: Fix bandwidth reclaim equation
 in GRUB
Message-ID: <20230530161206.0ba6e956@nowhere>
In-Reply-To: <20230530135526.2385378-1-vineeth@bitbyteword.org>
References: <20230530135526.2385378-1-vineeth@bitbyteword.org>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::16) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|DB4PR03MB10105:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b1a073-8850-42a4-78c2-08db6117dbb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +9fBFo7CT/QDHaB4BUiHh2brhJTPnxq5t+GDJqQufbJHRqaWr8J77Bt0rvJISVADKBNWMECt9rpY+M3d/NJhNg4wmNVY8PpmPhBZ0PgOtbBUpkOPzG34QzCroYFjiCJ29AnwAydf3bRxhknYWBbHRkgSYMlAS5hGdTWcAv4NZ3k//k7D0shbkk1r0ibhTu7q2nA6p64C7eNQHksbHRj5B8J7Px0Rc6QgdZTMjW1aW7QfwYbbgHAapMyI0TbySAcKfnnV7PJkrhgzQIJ6IY6f5qYIHXALaw1flo1ytY/o0YdgFi9YN8KepBJNxliGyAaTkV81Ah4WhPtMNPizQqOB9nq81fctlfyeQdNE5ih8iWUbQFdFx+WaxIiDGpjr0u9LEi7CUJpThNlas9sZij1shRDXGKS520yfYpnUnlj8ntBs3tGx4hVsA/c7LQtHHS3EQoMxxe2mggw7NBlSs5dg5mnPFepcQMpvfGBfqDIE6OWEJ8suod213KBr3J6utihaE5zhTi7uCuOL6JfB7blmiZGlEdBiVHDnuX/myqYFYzcCjm5w7hbO2Teu4H0trcuC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(396003)(346002)(39850400004)(376002)(136003)(451199021)(54906003)(478600001)(5660300002)(8676002)(41320700001)(4326008)(7416002)(8936002)(2906002)(33716001)(86362001)(66476007)(66556008)(66946007)(6916009)(316002)(786003)(38100700002)(41300700001)(186003)(26005)(6506007)(1076003)(6512007)(6486002)(9686003)(36916002)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K1/XysAH7PQnB+hrVcesw5UWa3SKnvgdcOhRlwsewlDKvamdRsmSDvfKxj26?=
 =?us-ascii?Q?sub6pkcuQ8tWS18vQLON9Rosc0P4yDd4hUGwdOFVC21ttYTSGlR2N+tPqAjv?=
 =?us-ascii?Q?MH0Xs7mGKFrJ5rJshtXcwalX7x3YTuIUHq81ClNBUTJneiAhoqWGeF7AUQj+?=
 =?us-ascii?Q?YM0ucoEq7wKRxkMqROP/nffEmhBIZ/QT/cu4gTvNzV9fbF2S1CRQExfN3o+a?=
 =?us-ascii?Q?V5Md4OLjZR6A7/jYH80Wgo7ZJmsFVsP4S1YJFm2TEPjNWxmj8yPNnUxyIKR4?=
 =?us-ascii?Q?xnZpyv77wnOiS43KskKQ2866ws0MreOZ9zns8J/uA8lqhb6HjJ5VsRvKEu01?=
 =?us-ascii?Q?sH0dWLmSzj/0Eh2LNiymyYA4Zs/XgkTXnxb3XiB5Q29Ms7OMIRqH8QCIHMmn?=
 =?us-ascii?Q?fmTriscsaMjGIHIHtBvDbKuY3KnRNLm4oEyEZOME5/FG/PN5nLSqy/gVHxke?=
 =?us-ascii?Q?IGgUSSSiSu1Zh9ma1Zlbmv693arQEmkhsJ3JRaP8nDxnPxQ7gqzlkqlPIoD+?=
 =?us-ascii?Q?+kK6si+rGIANGYgfPEvGvmhZQMui3pck+4zhOZlv9MR1gmedt+T+cGlyFL+o?=
 =?us-ascii?Q?JW+5PQAtSsC/N72AjKnjlC0yg584R1BHZMelA82sX9yR/XuAXmF25vt4aaW/?=
 =?us-ascii?Q?gwJnKEquyaoqVK98XSNoKBerooSrWhJA82LJlRa64NXcvZ4J+/8IvHmnsKrs?=
 =?us-ascii?Q?qCCCYJw+AvKGLZynal58VPUinOGpMhg0qEH6wWUiDOjs/tjbPg2JtzHZFe1q?=
 =?us-ascii?Q?OZncryXK1nwfxPK+mfwK+cfa7RTBGmn0ARiT5/CPqGUhi4p5nAaX+TkFYKMB?=
 =?us-ascii?Q?7wOwNRV6lYdOBHuppuDDan/v8x3zkhyfDtmhK6fCBBqc8LWpOUnD88RnkBwe?=
 =?us-ascii?Q?c/TLfUMv+B22As70r2xaZM+ZgQT3WnOPG8xufXlirvUKnKys4C4IHp4cfOWE?=
 =?us-ascii?Q?yd85SwItsOf9DVFxptidGV6WFDOriumO7k7oN5zudMN1wYBuwF3ng0hcupW4?=
 =?us-ascii?Q?t7s+2Uop/g+psftCrRr0Tj7w9ruA+qQdZufvFOq+6dwai51pwkc78odCtgdb?=
 =?us-ascii?Q?5uPWaBNx7iZzRuxSMCrCvzR5F8tQWXtXQg8snpNmWY/d02yrURZ2JLr6FYrw?=
 =?us-ascii?Q?FFxDVyPPCUZIPZ/QIFJp84iP0GkKuE3Uvsz+9CGpP9xQlbCDmaMHqVpCCWIc?=
 =?us-ascii?Q?C+IZv6+WJPKVl6PMdBsfWHUYhscuUzU94BBnILElWk9I0sdZewni0XbWOjKY?=
 =?us-ascii?Q?eL2Gom1WHxmq8kjbNvYIaKoM526UlcO+zbWubSxDcWQ+J2Rifv+F/fasyAJ2?=
 =?us-ascii?Q?wWRor/1W60EnuiNWCCkG0peSSbI6hhfiiFq4eRWbYZ/bc3uSX8v+hgJBiIbX?=
 =?us-ascii?Q?k/P6FZH0DwUaDaDcb8p+tg51f9CDaGN8wghXuv+wzSztIHyt6AVUN9dglBfN?=
 =?us-ascii?Q?EpEdSX7BJT1p01woDSyRKvzP9HEXrFwD3laNkkVq9YnUkj+rz8oLIScekUQk?=
 =?us-ascii?Q?S7eVj6AlurXYuxyy3B38KB6DBLHBnAsQYZDoHEfHU7gIwYf1O3ePqUCJWF1b?=
 =?us-ascii?Q?z+jA/ZAs67BmfnQ0p4JhVlP2CUZ7N2AOraNnPiZ2FqOVZ4fZwHLzenQLgIhA?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b1a073-8850-42a4-78c2-08db6117dbb4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:12:10.3389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlY9LR1Sz+j9H/6fFZP5fcUV1le7lctPIWzDRrY1BvRBfxUJyVG6TQFeZGniJ1TewIdR5JtEDShw1WvhPmD5bMX1hkktkXBHFbi7woBpiFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB10105
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think this patch is OK


			Thanks,
				Luca

On Tue, 30 May 2023 09:55:25 -0400
Vineeth Pillai <vineeth@bitbyteword.org> wrote:

> According to the GRUB[1] rule, the runtime is depreciated as:
>   "dq = -max{u, (1 - Uinact - Uextra)} dt" (1)
> 
> To guarantee that deadline tasks doesn't starve lower class tasks,
> we do not allocate the full bandwidth of the cpu to deadline tasks.
> Maximum bandwidth usable by deadline tasks is denoted by "Umax".
> Considering Umax, equation (1) becomes:
>   "dq = -(max{u, (Umax - Uinact - Uextra)} / Umax) dt" (2)
> 
> Current implementation has a minor bug in equation (2), which this
> patch fixes.
> 
> The reclamation logic is verified by a sample program which creates
> multiple deadline threads and observing their utilization. The tests
> were run on an isolated cpu(isolcpus=3) on a 4 cpu system.
> 
> Tests on 6.3.0
> ==============
> 
> RUN 1: runtime=7ms, deadline=period=10ms, RT capacity = 95%
> TID[693]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 93.33
> TID[693]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 93.35
> 
> RUN 2: runtime=1ms, deadline=period=100ms, RT capacity = 95%
> TID[708]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 16.69
> TID[708]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 16.69
> 
> RUN 3: 2 tasks
>   Task 1: runtime=1ms, deadline=period=10ms
>   Task 2: runtime=1ms, deadline=period=100ms
> TID[631]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 62.67
> TID[632]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 6.37
> TID[631]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 62.38
> TID[632]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 6.23
> 
> As seen above, the reclamation doesn't reclaim the maximum allowed
> bandwidth and as the bandwidth of tasks gets smaller, the reclaimed
> bandwidth also comes down.
> 
> Tests with this patch applied
> =============================
> 
> RUN 1: runtime=7ms, deadline=period=10ms, RT capacity = 95%
> TID[608]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 95.19
> TID[608]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 95.16
> 
> RUN 2: runtime=1ms, deadline=period=100ms, RT capacity = 95%
> TID[616]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 95.27
> TID[616]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 95.21
> 
> RUN 3: 2 tasks
>   Task 1: runtime=1ms, deadline=period=10ms
>   Task 2: runtime=1ms, deadline=period=100ms
> TID[620]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 86.64
> TID[621]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 8.66
> TID[620]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 86.45
> TID[621]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 8.73
> 
> Running tasks on all cpus allowing for migration also showed that
> the utilization is reclaimed to the maximum. Running 10 tasks on
> 3 cpus SCHED_FLAG_RECLAIM - top shows:
> %Cpu0  : 94.6 us,  0.0 sy,  0.0 ni,  5.4 id,  0.0 wa
> %Cpu1  : 95.2 us,  0.0 sy,  0.0 ni,  4.8 id,  0.0 wa
> %Cpu2  : 95.8 us,  0.0 sy,  0.0 ni,  4.2 id,  0.0 wa
> 
> [1]: Abeni, Luca & Lipari, Giuseppe & Parri, Andrea & Sun, Youcheng.
>      (2015). Parallel and sequential reclaiming in multicore
>      real-time global scheduling.
> 
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> ---
>  kernel/sched/deadline.c | 50
> +++++++++++++++++++---------------------- kernel/sched/sched.h    |
> 6 +++++ 2 files changed, 29 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 71b24371a6f7..dfb59a363560 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1260,43 +1260,39 @@ int dl_runtime_exceeded(struct
> sched_dl_entity *dl_se) }
>  
>  /*
> - * This function implements the GRUB accounting rule:
> - * according to the GRUB reclaiming algorithm, the runtime is
> - * not decreased as "dq = -dt", but as
> - * "dq = -max{u / Umax, (1 - Uinact - Uextra)} dt",
> + * This function implements the GRUB accounting rule. According to
> the
> + * GRUB reclaiming algorithm, the runtime is not decreased as "dq =
> -dt",
> + * but as "dq = -(max{u, (Umax - Uinact - Uextra)} / Umax) dt",
>   * where u is the utilization of the task, Umax is the maximum
> reclaimable
>   * utilization, Uinact is the (per-runqueue) inactive utilization,
> computed
>   * as the difference between the "total runqueue utilization" and the
> - * runqueue active utilization, and Uextra is the (per runqueue)
> extra
> + * "runqueue active utilization", and Uextra is the (per runqueue)
> extra
>   * reclaimable utilization.
> - * Since rq->dl.running_bw and rq->dl.this_bw contain utilizations
> - * multiplied by 2^BW_SHIFT, the result has to be shifted right by
> - * BW_SHIFT.
> - * Since rq->dl.bw_ratio contains 1 / Umax multiplied by
> 2^RATIO_SHIFT,
> - * dl_bw is multiped by rq->dl.bw_ratio and shifted right by
> RATIO_SHIFT.
> - * Since delta is a 64 bit variable, to have an overflow its value
> - * should be larger than 2^(64 - 20 - 8), which is more than 64
> seconds.
> - * So, overflow is not an issue here.
> + * Since rq->dl.running_bw and rq->dl.this_bw contain utilizations
> multiplied
> + * by 2^BW_SHIFT, the result has to be shifted right by BW_SHIFT.
> + * Since rq->dl.bw_ratio contains 1 / Umax multiplied by
> 2^RATIO_SHIFT, dl_bw
> + * is multiped by rq->dl.bw_ratio and shifted right by RATIO_SHIFT.
> + * Since delta is a 64 bit variable, to have an overflow its value
> should be
> + * larger than 2^(64 - 20 - 8), which is more than 64 seconds. So,
> overflow is
> + * not an issue here.
>   */
>  static u64 grub_reclaim(u64 delta, struct rq *rq, struct
> sched_dl_entity *dl_se) {
> -	u64 u_inact = rq->dl.this_bw - rq->dl.running_bw; /* Utot -
> Uact */ u64 u_act;
> -	u64 u_act_min = (dl_se->dl_bw * rq->dl.bw_ratio) >>
> RATIO_SHIFT;
> +	u64 u_inact = rq->dl.this_bw - rq->dl.running_bw; /* Utot -
> Uact */ 
>  	/*
> -	 * Instead of computing max{u * bw_ratio, (1 - u_inact -
> u_extra)},
> -	 * we compare u_inact + rq->dl.extra_bw with
> -	 * 1 - (u * rq->dl.bw_ratio >> RATIO_SHIFT), because
> -	 * u_inact + rq->dl.extra_bw can be larger than
> -	 * 1 * (so, 1 - u_inact - rq->dl.extra_bw would be negative
> -	 * leading to wrong results)
> +	 * Instead of computing max{u, (u_max - u_inact - u_extra)},
> we
> +	 * compare u_inact + u_extra with u_max - u, because u_inact
> + u_extra
> +	 * can be larger than u_max. So, u_max - u_inact - u_extra
> would be
> +	 * negative leading to wrong results.
>  	 */
> -	if (u_inact + rq->dl.extra_bw > BW_UNIT - u_act_min)
> -		u_act = u_act_min;
> +	if (u_inact + rq->dl.extra_bw > rq->dl.max_bw - dl_se->dl_bw)
> +		u_act = dl_se->dl_bw;
>  	else
> -		u_act = BW_UNIT - u_inact - rq->dl.extra_bw;
> +		u_act = rq->dl.max_bw - u_inact - rq->dl.extra_bw;
>  
> +	u_act = (u_act * rq->dl.bw_ratio) >> RATIO_SHIFT;
>  	return (delta * u_act) >> BW_SHIFT;
>  }
>  
> @@ -2784,12 +2780,12 @@ static void init_dl_rq_bw_ratio(struct dl_rq
> *dl_rq) {
>  	if (global_rt_runtime() == RUNTIME_INF) {
>  		dl_rq->bw_ratio = 1 << RATIO_SHIFT;
> -		dl_rq->extra_bw = 1 << BW_SHIFT;
> +		dl_rq->max_bw = dl_rq->extra_bw = 1 << BW_SHIFT;
>  	} else {
>  		dl_rq->bw_ratio = to_ratio(global_rt_runtime(),
>  			  global_rt_period()) >> (BW_SHIFT -
> RATIO_SHIFT);
> -		dl_rq->extra_bw = to_ratio(global_rt_period(),
> -
> global_rt_runtime());
> +		dl_rq->max_bw = dl_rq->extra_bw =
> +			to_ratio(global_rt_period(),
> global_rt_runtime()); }
>  }
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3e8df6d31c1e..73027c2806dc 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -753,6 +753,12 @@ struct dl_rq {
>  	u64			this_bw;
>  	u64			extra_bw;
>  
> +	/*
> +	 * Maximum available bandwidth for reclaiming by
> SCHED_FLAG_RECLAIM
> +	 * tasks of this rq. Used in calculation of reclaimable
> bandwidth(GRUB).
> +	 */
> +	u64			max_bw;
> +
>  	/*
>  	 * Inverse of the fraction of CPU utilization that can be
> reclaimed
>  	 * by the GRUB algorithm.

