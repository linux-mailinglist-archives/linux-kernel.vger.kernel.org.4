Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0912E6FC4F5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjEILZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbjEILZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:25:46 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57A72127;
        Tue,  9 May 2023 04:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJZDzW6hyCjZrGmZomf9+afv7OaFa+owmbrkF24W/q5mdCiMX3IaIyiK4S+MkPs2yJypqXMH91GkhRdHU1KcYHZF2O/MWvv8bHzJehfGkH/rs7rBy09LFJZ/8F/cSyYN1yebbPcQyrB+29HXIx3ycUbNX0KQ/OTksewQ+ilXQuOZ986Cm2mG2BoWk2JVJxvsjnGtoZsNn7c4zIPPsea0Fl6V7mCAtlWhJhlqP0ZYIXoAhg8MCvnktZWqdPhosBn29Yu8N4y9KVjuKqQ9wJvTbysgYnBvP8WzLR/bCzIS+nuHCB3TTxB2sJFudweXMUCcijYZLJYIVcQawW1P+bM+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYU1XfIOORhp/+gkx+/el46tU/e2lpK2rQDaHNFZVAo=;
 b=ihCvDzkWeVjvY/o8Gpdj0Qyo7XyIFinDBcng2+gUXzrbt32yMI7c4mVOykxMctSjDJ126Rh2iHVKg4tQE9/+3Pv7EPHb6nFzIVwYu/xzEL27AcE/tTWKf13MonbIiagWvtAUjzrwnZ4oaqdEf4S5wg/U5HF06KERL//JAKIFUygQoakyofB9j1tt0vV5/YGucpfDqm1IuPyZq7HMsaBzyZZI4w8NZlCBnMXuk4CE20LReKcy4Xp0R/Puu9a4kI46CHRJNDYyAUt1cQUptlbpT1n8lGT+TSsAMIikPn6S7g+vKZ/TA46xDvjo9LmTq2BUakRtpVtymLX2sg8QqIBzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYU1XfIOORhp/+gkx+/el46tU/e2lpK2rQDaHNFZVAo=;
 b=mgaj+VsRifywXjPMq2AXAh9Wca/EPm0MsLUVuAnFWTILY6u7NoNuvb71uUQL3pMelyfAvmr9ZptzRqIEidW0abmEmwIXsQHsupdTpu2jrpZZIi+RkW0gKDezOjmFtn9kxyZcAGegqsuKJWMs3N0+dNsdOSYvFcwGZZ0ymRA6FeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by PA4PR03MB6846.eurprd03.prod.outlook.com (2603:10a6:102:ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 11:25:38 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::8cd9:c5f1:f698:5600]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::8cd9:c5f1:f698:5600%3]) with mapi id 15.20.6363.031; Tue, 9 May 2023
 11:25:37 +0000
Date:   Tue, 9 May 2023 13:25:34 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Vineeth Pillai <vineeth@bitbyteword.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/deadline: accurate reclaim bandwidth for GRUB
Message-ID: <20230509132534.09098acc@luca64>
In-Reply-To: <20230508160829.2756405-1-vineeth@bitbyteword.org>
References: <20230508160829.2756405-1-vineeth@bitbyteword.org>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0151.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::12) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|PA4PR03MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 96fa3f61-42b3-45cd-812b-08db50801cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbgnw72vQThGYQ3frs+sIktNwaNfze86EILqFy/mYytgABd1c/DfyBNN1ac2+CNPWtAtPF+MZd5b4GlaLwZ4EQsdqySUXr0tHOTpSQR/hDtkSFZfzrX9td7kwA2bb0nZyTX7QeEr+x9+vFpB0Y20f4k2fvxAcKWKSoa5v2rpUb8iAwfpfopgFHKnGFsq12F6zx5a/p1nYL1BDb/HmeKBHNQFIzH7uCYKJ/06l1M7IPnvlBK0PuZlSd2MOnOk+49BBRrCKFQ453ejarr86ovjpM3R7FUlpn0+F8R7mZXA0dUO7JibMsVu/VjIriUyY+zJKcNTiNNMdC1sP5HSJTjiBXZYTmN66noqSxRS7otDFkgLbxLpHs5/7yWJ7RrqhN1Sdo/ADPt2VF4Ek8ZQ+/7IC62Ew9D47m0lZohdZpQWcXgFHrFxa5150uesYs05T1WWNfDTpnvrExsMOxdUUIFF0Xfbb1DV/gQCo25W6D7oblWoicaj+1G5Lu+4o+3kjcclpKXGtYnaiedWNtT+bKkOvaHHo8J2UgqAuxFjYP6h/0HwADUnI76yGTXkJ0CJPqnj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39850400004)(346002)(136003)(396003)(376002)(366004)(451199021)(36916002)(33716001)(54906003)(86362001)(786003)(316002)(6486002)(66476007)(66556008)(6666004)(41300700001)(66946007)(4326008)(6916009)(5660300002)(8936002)(8676002)(7416002)(478600001)(6512007)(9686003)(38100700002)(1076003)(6506007)(41320700001)(186003)(2906002)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tfw1iJ43y++Nq4MLjwxkJyBYNmHT/imZhxBrTfN3S+xcdxFXcVdKqMWUXCdH?=
 =?us-ascii?Q?kd0a1XpmYksDzAV0/2SYnlLPeHnLf+IdSWzce+a9cfgZQUdSuyp+nUMnDzP8?=
 =?us-ascii?Q?GWwb9YZhmtMu3C45jr/bX2+Iod7djcBwfJZpKJ6ewjOaAhCJruQ0uB3h7bJh?=
 =?us-ascii?Q?kwpcL32DUcv98/IL/YkPX9FX/gha9AETm4/ELnlC9U6VAaQ9arYH1S58Bdo6?=
 =?us-ascii?Q?zuuqeQ8dDrMxQWYrDK5SwzT1VNoXVeD/tG6Xl4fjvPuOWP5PO+xYlRJh0RBB?=
 =?us-ascii?Q?CJKH7032iZp9s49JyXmkYa39fQfjwl6dVsUNxLmcfIC1RcFuSh0tTSFnMpqT?=
 =?us-ascii?Q?B1Ym2Pft0TXS5OfSvNjc+AppNODm1b6bHHVmXGM/b4LJDoQiZO6TSDYaRDJv?=
 =?us-ascii?Q?6ZPIG6aAJccUR8il2FVGQm/iEvpati1tSjwRNWo8phjWtrzpnF6OQyOIf0K9?=
 =?us-ascii?Q?lZqGeU3zG5t1vwA1PQWKzvtFLupu8YEPA9oQpFr0xn7E2AJhBKnoAu1oJIGF?=
 =?us-ascii?Q?YR2K5k5PCcofFstQSL+eigdy7CN3m0/2pDHY9Nx9iXXBpmC8CYybyhTPeeH6?=
 =?us-ascii?Q?ptrqEKVpFd43qITbeI2FPz68O3gdMUCP9kZpFWMr91gmH4YqahvuMVnj4ORq?=
 =?us-ascii?Q?czv70cbOtdt/mefEweMoh+MKz5QsC5K0a4elXa4BYELODu2WpxBcXwO0qxQb?=
 =?us-ascii?Q?pHZyN6cQNCSjdPleOP8dDGIFhx7tfgrVtcS5P+dB85JlOGNuMmJGFQLRKq6H?=
 =?us-ascii?Q?wPYvX+TCq9DvbRoGNxiD2tU9HEwGsb1x9llyUFg+MfwRUfnUqBp+tKhSS00G?=
 =?us-ascii?Q?ks2X5X6i9G+16fgn+UtmA7aLCVDIDNPgeXDlz2peJCTDWXJJb5aPCCAiBoCx?=
 =?us-ascii?Q?/txk7GeuH15RWtgvMPnUi5vFTCoJLV0cr/+f5OXqwJUWqej91D82fjTZVzch?=
 =?us-ascii?Q?WvN7DUUQjifwrfTrafIgOjMLsxOyDWP4zSi9m+inGsO8qHEisXLYT50iw2k9?=
 =?us-ascii?Q?2R914AoQ0OrMNfeD705UCGnFifrvMrpNF5x0lXKNLRagAICTfw/72WWdOe7P?=
 =?us-ascii?Q?EhRxeNvPwMfH8pWdTRVZ1sJNDadaipDoyqCfiMeoTZ9AVa26M9CkFIJIqowM?=
 =?us-ascii?Q?4D1yE7HDrGtGzikKYRPQU7+FJPQhfI+8F4PVSGOrlD8dkNVxUccOhgGQUBD5?=
 =?us-ascii?Q?9CFlzJ97b2HrzcIbqTcmiowZ1MNo9fWLrI2MX/sK3IUMZZSm9nQq897W2Eee?=
 =?us-ascii?Q?NrZ2WqVMhRgPMo9phDQOPpQsAlonyf7jr9TsFndFi89Cg9TD8gIaOLkd/z5h?=
 =?us-ascii?Q?QVFyjNFT6Y+k0NSf0pz8qnJpKK4xyHnHy1Vqv1Lx9Rby6Qg4MfnEOVblwN67?=
 =?us-ascii?Q?2DVn6vXHqtp7RUywduidq/1pF6rrvLiORN/Trn/mlyFBT0yCW+NfkxN3ofCF?=
 =?us-ascii?Q?QyTeOFzCWjDs7lXoWMMtNuByF1/Q2SBk3MOPlLE+Bzs40jAAeVEaPjQX/XpQ?=
 =?us-ascii?Q?L3mayPcv38e+tIBhdxKmrOFYQ6SrQYykaY9upSPDCDvS5RZR4QueCt6dPN+1?=
 =?us-ascii?Q?rTOp+ofe4WEizl8kXlg30fbQP/fBW6SYu/bZRpMp1C3xmfd72bAdpXI4XaNH?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fa3f61-42b3-45cd-812b-08db50801cee
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 11:25:37.6574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzXms5mQVvzCVZahBEn7vwDcHxTMS8wJXU+wn0ddPcfIYX8HqNk44ZbsT4OxjxOGjEaNCfZ25v0UsTSydEtOMnLdrsNpvQ4dDhmLaKTvIC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6846
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

if I understand well, your patch addresses 2 separate issues:
1) The current reclaiming code uses an approximation to avoid using
   div64_u64(), which might introduce too much overhead (at least, as
   far as I remember :). Your patch changes it to use the exact,
   non-approximated, equation
2) Currently, the reclaimable CPU time is divided as if all the
   SCHED_DEADLINE tasks (and not only the SCHED_FLAG_RECLAIM tasks)
   could use it; your patch changes the code to distribute the
   reclaimable CPU time only to tasks having the SCHED_FLAG_RECLAIM
   flag set

Is this understanding correct?
If using div64_u64() does not introduce too much overhead, then I agree
with the first change.
The second change also looks good to me.

I have no comments on the code, but there is one thing in the comments
that looks misleading to me (or I am misunderstanding the code or the
comments):

On Mon,  8 May 2023 12:08:28 -0400
Vineeth Pillai <vineeth@bitbyteword.org> wrote:
[...]

> + *	"dq = -(Ureclaim / Umax_reclaim) * dt"
> + * Where
> + *	Ureclaim:	Active Bandwidth of SCHED_FLAG_RECLAIM tasks for this rq.
> + *	Umax_reclaim:	Maximum reclaimable bandwidth for this rq.
> + *
> + * We can calculate Umax_reclaim as:
> + *	Umax_reclaim:	this_bw + Uinact + Ureclaim

I think this looks like a typo (summing this_bw to Uinact
looks wrong). Should "this_bw" be Uextra?

> + * Where:
> + *	this_bw:	Reserved bandwidth for this runqueue.
> + *	Ureclaim:	Active Bandwidth of SCHED_FLAG_RECLAIM tasks for this rq.
> + *	Uinact:		Inactive utilization (this_bw - running_bw)
> + *	Uextra:		Extra bandwidth(Usually Umax - this_bw)
> + *	Umax:		Max usable bandwidth. Currently
> + *			= sched_rt_runtime_us / sched_rt_period_us
> + *
> + * We use the above formula to scale the runtime down
> + *
> + *	dq = -(Ureclaim / Umax_reclaim) * dt
> + *	   = -(Ureclaim / (Ureclaim + Uextra + Uinact)) * dt

I think this should be the correct equation. BTW, since you are summing
Uextra and Uinact, mabe you could just use "Umax - running_bw"?



			Luca

>   */
>  static u64 grub_reclaim(u64 delta, struct rq *rq, struct
> sched_dl_entity *dl_se) {
> +	u64 scaled_delta;
>  	u64 u_inact = rq->dl.this_bw - rq->dl.running_bw; /* Utot -
> Uact */
> -	u64 u_act;
> -	u64 u_act_min = (dl_se->dl_bw * rq->dl.bw_ratio) >>
> RATIO_SHIFT;
> +	u64 reclaimable_bw = rq->dl.extra_bw + u_inact;
>  
> -	/*
> -	 * Instead of computing max{u * bw_ratio, (1 - u_inact -
> u_extra)},
> -	 * we compare u_inact + rq->dl.extra_bw with
> -	 * 1 - (u * rq->dl.bw_ratio >> RATIO_SHIFT), because
> -	 * u_inact + rq->dl.extra_bw can be larger than
> -	 * 1 * (so, 1 - u_inact - rq->dl.extra_bw would be negative
> -	 * leading to wrong results)
> -	 */
> -	if (u_inact + rq->dl.extra_bw > BW_UNIT - u_act_min)
> -		u_act = u_act_min;
> -	else
> -		u_act = BW_UNIT - u_inact - rq->dl.extra_bw;
> +	if (reclaimable_bw > rq->dl.max_bw)
> +		reclaimable_bw = rq->dl.max_bw;
>  
> -	return (delta * u_act) >> BW_SHIFT;
> +	scaled_delta = div64_u64(delta * rq->dl.reclaim_bw,
> +			    (rq->dl.reclaim_bw + reclaimable_bw));
> +	return scaled_delta;
>  }
>  
>  /*
> @@ -2783,12 +2797,9 @@ int sched_dl_global_validate(void)
>  static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq)
>  {
>  	if (global_rt_runtime() == RUNTIME_INF) {
> -		dl_rq->bw_ratio = 1 << RATIO_SHIFT;
> -		dl_rq->extra_bw = 1 << BW_SHIFT;
> +		dl_rq->max_bw = dl_rq->extra_bw = 1 << BW_SHIFT;
>  	} else {
> -		dl_rq->bw_ratio = to_ratio(global_rt_runtime(),
> -			  global_rt_period()) >> (BW_SHIFT -
> RATIO_SHIFT);
> -		dl_rq->extra_bw = to_ratio(global_rt_period(),
> +		dl_rq->max_bw = dl_rq->extra_bw =
> to_ratio(global_rt_period(), global_rt_runtime());
>  	}
>  }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3e8df6d31c1e..13d85af0f42b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -257,6 +257,11 @@ static inline bool dl_entity_is_special(const
> struct sched_dl_entity *dl_se) #endif
>  }
>  
> +static inline bool dl_entity_is_reclaim(const struct sched_dl_entity
> *dl_se) +{
> +	return dl_se->flags & SCHED_FLAG_RECLAIM;
> +}
> +
>  /*
>   * Tells if entity @a should preempt entity @b.
>   */
> @@ -754,10 +759,20 @@ struct dl_rq {
>  	u64			extra_bw;
>  
>  	/*
> -	 * Inverse of the fraction of CPU utilization that can be
> reclaimed
> -	 * by the GRUB algorithm.
> +	 * Maximum available bandwidth for this runqueue. This is
> used to
> +	 * calculate reclaimable bandwidth for SCHED_FLAG_RECLAIM
> tasks.
> +	 * By restricting maximum usable bandwidth, we aim to give
> other
> +	 * tasks on lower classes a chance to run, when competing
> with
> +	 * SCHED_FLAG_RECLAIM tasks.
>  	 */
> -	u64			bw_ratio;
> +	u64			max_bw;
> +
> +	/*
> +	 * Active bandwidth of SCHED_FLAG_RECLAIM tasks on this rq.
> +	 * This will be a subset of running_bw.
> +	 */
> +	u64			reclaim_bw;
> +
>  };
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED

