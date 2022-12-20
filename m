Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588A7652147
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbiLTNLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiLTNLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:11:02 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251E82624
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:11:00 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id qk9so29103378ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fzFOzPhQbi8QGG3iwzeynQ0Hrvfzjm+8/wOA9/uICo=;
        b=B1YrI3NWnQwi46PhUPq5bjEF3S0Uqz9WA2vmjQHkOlkQ/TzqDbqOvilDmXjznpDHOG
         YUVKhgFEMNq106DiMSmL1XsxMLinLqtw33K22Ps7hp5zZG3tkCw2Kytv7ZAcph4wIIkd
         2G9F6Kfszy13fNEjz4Y1cw0rTCVEqJXuj1evfDTKtYGwHBNBubSghgbEzkfY3Q25guP3
         vy2+cZ2GX46yMi7YK53Jg6Z3jpoKarqA1fofDyxZr01z58U2wnUPJP5YCfJp/lZJ43yJ
         bTbSzSiWPqkKb1JTFDrZi8afyDENx6OXzlp/qSSynPcdCyttkgK3R2ROyU91JRMR1PyE
         /+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fzFOzPhQbi8QGG3iwzeynQ0Hrvfzjm+8/wOA9/uICo=;
        b=zhcA+sWZckkt6376nlZKXHvMZFTTaSf9urGYKdvOyC7Kf0A2/ymw4OzZd+ntoK9tqN
         pc2exlP939nezQFRnL+QcHZmeeBBqdgWKlMgUm9VTJ+H41NMEaUD0IPC3MWcnF9vFrWt
         da9LKdN7vDsWZO7jNqDU6eYFm0VuHwnzjSyqblFRq8E1KFz76ptWLl4gHR3WxGuFDPHU
         ZobHeVqTduJrMLI8h5mMrxJMH6almg+/pKQyKEVLVchw2nRx1bgNf0vXKIdZiCBRgt6e
         wpHGmGDJ/WXprfU0bJdb5u5MCOud1Kb+BklSSrOk4+H1adb4spHG3+UR/IQlWeRwUzx6
         4KFg==
X-Gm-Message-State: AFqh2kpIehnt1CuoH88Vn2if75VkvkuVTuImPpZt3DVvH/x+gOLPHUHr
        d54BFOW59zQtWYWZRnmO7NrbAQ==
X-Google-Smtp-Source: AMrXdXvMmPuIL9c1Ky4F4FaECw8UIkUutM/3XMqGXx3ySjTAT7YW17bnQJDquoPuld7qVsGmlgG1MQ==
X-Received: by 2002:a17:907:2ce4:b0:7c0:e5dd:6e5f with SMTP id hz4-20020a1709072ce400b007c0e5dd6e5fmr2480378ejc.4.1671541858461;
        Tue, 20 Dec 2022 05:10:58 -0800 (PST)
Received: from mbp-di-paolo.station (net-93-70-85-0.cust.vodafonedsl.it. [93.70.85.0])
        by smtp.gmail.com with ESMTPSA id q25-20020a170906a09900b0078d76ee7543sm5682545ejy.222.2022.12.20.05.10.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Dec 2022 05:10:58 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V10 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <cd41583b-ef11-a3b7-1e39-c4a224050c7d@opensource.wdc.com>
Date:   Tue, 20 Dec 2022 14:10:56 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Glen Valante <glen.valante@linaro.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <60582F89-8020-4468-80FE-BC52202D1129@linaro.org>
References: <20221209094442.36896-1-paolo.valente@linaro.org>
 <20221209094442.36896-2-paolo.valente@linaro.org>
 <cd41583b-ef11-a3b7-1e39-c4a224050c7d@opensource.wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 16 dic 2022, alle ore 01:00, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>=20
> On 12/9/22 18:44, Paolo Valente wrote:
>> Single-LUN multi-actuator SCSI drives, as well as all multi-actuator
>> SATA drives appear as a single device to the I/O subsystem [1].  Yet
>> they address commands to different actuators internally, as a =
function
>> of Logical Block Addressing (LBAs). A given sector is reachable by
>> only one of the actuators. For example, Seagate=E2=80=99s Serial =
Advanced
>> Technology Attachment (SATA) version contains two actuators and maps
>> the lower half of the SATA LBA space to the lower actuator and the
>> upper half to the upper actuator.
>>=20
>> Evidently, to fully utilize actuators, no actuator must be left idle
>> or underutilized while there is pending I/O for it. The block layer
>> must somehow control the load of each actuator individually. This
>> commit lays the ground for allowing BFQ to provide such a =
per-actuator
>> control.
>>=20
>> BFQ associates an I/O-request sync bfq_queue with each process doing
>> synchronous I/O, or with a group of processes, in case of queue
>> merging. Then BFQ serves one bfq_queue at a time. While in service, a
>> bfq_queue is emptied in request-position order. Yet the same process,
>> or group of processes, may generate I/O for different actuators. In
>> this case, different streams of I/O (each for a different actuator)
>> get all inserted into the same sync bfq_queue. So there is basically
>> no individual control on when each stream is served, i.e., on when =
the
>> I/O requests of the stream are picked from the bfq_queue and
>> dispatched to the drive.
>>=20
>> This commit enables BFQ to control the service of each actuator
>> individually for synchronous I/O, by simply splitting each sync
>> bfq_queue into N queues, one for each actuator. In other words, a =
sync
>> bfq_queue is now associated to a pair (process, actuator). As a
>> consequence of this split, the per-queue proportional-share policy
>> implemented by BFQ will guarantee that the sync I/O generated for =
each
>> actuator, by each process, receives its fair share of service.
>>=20
>> This is just a preparatory patch. If the I/O of the same process
>> happens to be sent to different queues, then each of these queues may
>> undergo queue merging. To handle this event, the bfq_io_cq data
>> structure must be properly extended. In addition, stable merging must
>> be disabled to avoid loss of control on individual actuators. =
Finally,
>> also async queues must be split. These issues are described in detail
>> and addressed in next commits. As for this commit, although multiple
>> per-process bfq_queues are provided, the I/O of each process or group
>> of processes is still sent to only one queue, regardless of the
>> actuator the I/O is for. The forwarding to distinct bfq_queues will =
be
>> enabled after addressing the above issues.
>>=20
>> [1] =
https://www.linaro.org/blog/budget-fair-queueing-bfq-linux-io-scheduler-op=
timizations-for-multi-actuator-sata-hard-drives/
>>=20
>> Signed-off-by: Gabriele Felici <felicigb@gmail.com>
>> Signed-off-by: Carmine Zaccagnino <carmine@carminezacc.com>
>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>> ---
>> block/bfq-cgroup.c  |  92 ++++++++++++++------------
>> block/bfq-iosched.c | 158 =
+++++++++++++++++++++++++++++---------------
>> block/bfq-iosched.h |  51 +++++++++++---
>> 3 files changed, 195 insertions(+), 106 deletions(-)
>>=20
>> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
>> index 7d624a3a3f0f..7ea77f994424 100644
>> --- a/block/bfq-cgroup.c
>> +++ b/block/bfq-cgroup.c
>> @@ -704,6 +704,47 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct =
bfq_queue *bfqq,
>> 	bfq_put_queue(bfqq);
>> }
>>=20
>> +static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
>> +			       struct bfq_queue *sync_bfqq,
>> +			       struct bfq_io_cq *bic,
>> +			       struct bfq_group *bfqg,
>> +			       unsigned int act_idx)
>> +{
>> +	struct bfq_queue *bfqq;
>> +
>> +	if (!sync_bfqq->new_bfqq && !bfq_bfqq_coop(sync_bfqq)) {
>> +		/* We are the only user of this bfqq, just move it */
>> +		if (sync_bfqq->entity.sched_data !=3D &bfqg->sched_data)
>> +			bfq_bfqq_move(bfqd, sync_bfqq, bfqg);
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * The queue was merged to a different queue. Check
>> +	 * that the merge chain still belongs to the same
>> +	 * cgroup.
>> +	 */
>> +	for (bfqq =3D sync_bfqq; bfqq; bfqq =3D bfqq->new_bfqq)
>> +		if (bfqq->entity.sched_data !=3D
>> +		    &bfqg->sched_data)
>=20
> Already commented on this one: please do not split this line. The code
> looks silly like this.

Actually this mistake was in other places, sorry for this extra one.
Fixed in upcoming version.

>=20
>> +			break;
>> +	if (bfqq) {
>> +		/*
>> +		 * Some queue changed cgroup so the merge is not valid
>> +		 * anymore. We cannot easily just cancel the merge (by
>> +		 * clearing new_bfqq) as there may be other processes
>> +		 * using this queue and holding refs to all queues
>> +		 * below sync_bfqq->new_bfqq. Similarly if the merge
>> +		 * already happened, we need to detach from bfqq now
>> +		 * so that we cannot merge bio to a request from the
>> +		 * old cgroup.
>> +		 */
>> +		bfq_put_cooperator(sync_bfqq);
>> +		bfq_release_process_ref(bfqd, sync_bfqq);
>> +		bic_set_bfqq(bic, NULL, true, act_idx);
>> +	}
>> +}
>> +
>> /**
>>  * __bfq_bic_change_cgroup - move @bic to @bfqg.
>>  * @bfqd: the queue descriptor.
>> @@ -718,53 +759,20 @@ static void *__bfq_bic_change_cgroup(struct =
bfq_data *bfqd,
>> 				     struct bfq_io_cq *bic,
>> 				     struct bfq_group *bfqg)
>> {
>> -	struct bfq_queue *async_bfqq =3D bic_to_bfqq(bic, 0);
>> -	struct bfq_queue *sync_bfqq =3D bic_to_bfqq(bic, 1);
>> -	struct bfq_entity *entity;
>> +	unsigned int act_idx;
>>=20
>> -	if (async_bfqq) {
>> -		entity =3D &async_bfqq->entity;
>> +	for (act_idx =3D 0; act_idx < bfqd->num_actuators; act_idx++) {
>> +		struct bfq_queue *async_bfqq =3D bic_to_bfqq(bic, false, =
act_idx);
>> +		struct bfq_queue *sync_bfqq =3D bic_to_bfqq(bic, true, =
act_idx);
>>=20
>> -		if (entity->sched_data !=3D &bfqg->sched_data) {
>> -			bic_set_bfqq(bic, NULL, 0);
>> +		if (async_bfqq &&
>> +		    async_bfqq->entity.sched_data !=3D =
&bfqg->sched_data) {
>> +			bic_set_bfqq(bic, NULL, false, act_idx);
>> 			bfq_release_process_ref(bfqd, async_bfqq);
>> 		}
>> -	}
>>=20
>> -	if (sync_bfqq) {
>> -		if (!sync_bfqq->new_bfqq && !bfq_bfqq_coop(sync_bfqq)) {
>> -			/* We are the only user of this bfqq, just move =
it */
>> -			if (sync_bfqq->entity.sched_data !=3D =
&bfqg->sched_data)
>> -				bfq_bfqq_move(bfqd, sync_bfqq, bfqg);
>> -		} else {
>> -			struct bfq_queue *bfqq;
>> -
>> -			/*
>> -			 * The queue was merged to a different queue. =
Check
>> -			 * that the merge chain still belongs to the =
same
>> -			 * cgroup.
>> -			 */
>> -			for (bfqq =3D sync_bfqq; bfqq; bfqq =3D =
bfqq->new_bfqq)
>> -				if (bfqq->entity.sched_data !=3D
>> -				    &bfqg->sched_data)
>> -					break;
>> -			if (bfqq) {
>> -				/*
>> -				 * Some queue changed cgroup so the =
merge is
>> -				 * not valid anymore. We cannot easily =
just
>> -				 * cancel the merge (by clearing =
new_bfqq) as
>> -				 * there may be other processes using =
this
>> -				 * queue and holding refs to all queues =
below
>> -				 * sync_bfqq->new_bfqq. Similarly if the =
merge
>> -				 * already happened, we need to detach =
from
>> -				 * bfqq now so that we cannot merge bio =
to a
>> -				 * request from the old cgroup.
>> -				 */
>> -				bfq_put_cooperator(sync_bfqq);
>> -				bfq_release_process_ref(bfqd, =
sync_bfqq);
>> -				bic_set_bfqq(bic, NULL, 1);
>> -			}
>> -		}
>> +		if (sync_bfqq)
>> +			bfq_sync_bfqq_move(bfqd, sync_bfqq, bic, bfqg, =
act_idx);
>> 	}
>>=20
>> 	return bfqg;
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 7ea427817f7f..16dbf52ce74b 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -377,14 +377,21 @@ static const unsigned long =
bfq_late_stable_merging =3D 600;
>> #define RQ_BIC(rq)		((struct bfq_io_cq =
*)((rq)->elv.priv[0]))
>> #define RQ_BFQQ(rq)		((rq)->elv.priv[1])
>>=20
>> -struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync)
>> +struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync,
>> +			      unsigned int actuator_idx)
>> {
>> -	return bic->bfqq[is_sync];
>> +	if (is_sync)
>> +		return bic->bfqq[1][actuator_idx];
>> +
>> +	return bic->bfqq[0][actuator_idx];
>> }
>>=20
>> static void bfq_put_stable_ref(struct bfq_queue *bfqq);
>>=20
>> -void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, =
bool is_sync)
>> +void bic_set_bfqq(struct bfq_io_cq *bic,
>> +		  struct bfq_queue *bfqq,
>> +		  bool is_sync,
>> +		  unsigned int actuator_idx)
>> {
>> 	/*
>> 	 * If bfqq !=3D NULL, then a non-stable queue merge between
>> @@ -399,7 +406,10 @@ void bic_set_bfqq(struct bfq_io_cq *bic, struct =
bfq_queue *bfqq, bool is_sync)
>> 	 * we cancel the stable merge if
>> 	 * bic->stable_merge_bfqq =3D=3D bfqq.
>> 	 */
>> -	bic->bfqq[is_sync] =3D bfqq;
>> +	if (is_sync)
>> +		bic->bfqq[1][actuator_idx] =3D bfqq;
>> +	else
>> +		bic->bfqq[0][actuator_idx] =3D bfqq;
>>=20
>> 	if (bfqq && bic->stable_merge_bfqq =3D=3D bfqq) {
>> 		/*
>> @@ -672,9 +682,9 @@ static void bfq_limit_depth(blk_opf_t opf, struct =
blk_mq_alloc_data *data)
>> {
>> 	struct bfq_data *bfqd =3D data->q->elevator->elevator_data;
>> 	struct bfq_io_cq *bic =3D bfq_bic_lookup(data->q);
>> -	struct bfq_queue *bfqq =3D bic ? bic_to_bfqq(bic, =
op_is_sync(opf)) : NULL;
>> 	int depth;
>> 	unsigned limit =3D data->q->nr_requests;
>> +	unsigned int act_idx;
>>=20
>> 	/* Sync reads have full depth available */
>> 	if (op_is_sync(opf) && !op_is_write(opf)) {
>> @@ -684,14 +694,21 @@ static void bfq_limit_depth(blk_opf_t opf, =
struct blk_mq_alloc_data *data)
>> 		limit =3D (limit * depth) >> bfqd->full_depth_shift;
>> 	}
>>=20
>> -	/*
>> -	 * Does queue (or any parent entity) exceed number of requests =
that
>> -	 * should be available to it? Heavily limit depth so that it =
cannot
>> -	 * consume more available requests and thus starve other =
entities.
>> -	 */
>> -	if (bfqq && bfqq_request_over_limit(bfqq, limit))
>> -		depth =3D 1;
>> +	for (act_idx =3D 0; act_idx < bfqd->num_actuators; act_idx++) {
>> +		struct bfq_queue *bfqq =3D
>> +			bic ? bic_to_bfqq(bic, op_is_sync(opf), act_idx) =
: NULL;
>=20
> Commented already: why not add a "if (!bfqq) return NULL;" in
> bic_to_bfqq() ?

You have probably missed my reply on this.  The problem is that your
proposal would improve code (only) here, but it would entail the above
control for all the other invocations, for which it is useless :(

I'm sending a V11, with the above nit fixed, and with only this patch
needing finalization.

Thanks,
Paolo

>=20
>>=20
>> +		/*
>> +		 * Does queue (or any parent entity) exceed number of
>> +		 * requests that should be available to it? Heavily
>> +		 * limit depth so that it cannot consume more
>> +		 * available requests and thus starve other entities.
>> +		 */
>> +		if (bfqq && bfqq_request_over_limit(bfqq, limit)) {
>> +			depth =3D 1;
>> +			break;
>> +		}
>> +	}
>> 	bfq_log(bfqd, "[%s] wr_busy %d sync %d depth %u",
>> 		__func__, bfqd->wr_busy_queues, op_is_sync(opf), depth);
>> 	if (depth)
>> @@ -1812,6 +1829,18 @@ static bool =
bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
>> 	return bfqq_weight > in_serv_weight;
>> }
>>=20
>> +/*
>> + * Get the index of the actuator that will serve bio.
>> + */
>> +static unsigned int bfq_actuator_index(struct bfq_data *bfqd, struct =
bio *bio)
>> +{
>> +	/*
>> +	 * Multi-actuator support not complete yet, so always return 0
>> +	 * for the moment (to keep incomplete mechanisms off).
>> +	 */
>> +	return 0;
>> +}
>> +
>> static bool bfq_better_to_idle(struct bfq_queue *bfqq);
>>=20
>> static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
>> @@ -2142,7 +2171,7 @@ static void bfq_check_waker(struct bfq_data =
*bfqd, struct bfq_queue *bfqq,
>> 	 * We reset waker detection logic also if too much time has =
passed
>>  	 * since the first detection. If wakeups are rare, pointless =
idling
>> 	 * doesn't hurt throughput that much. The condition below makes =
sure
>> -	 * we do not uselessly idle blocking waker in more than 1/64 =
cases.=20
>> +	 * we do not uselessly idle blocking waker in more than 1/64 =
cases.
>> 	 */
>> 	if (bfqd->last_completed_rq_bfqq !=3D
>> 	    bfqq->tentative_waker_bfqq ||
>> @@ -2478,7 +2507,8 @@ static bool bfq_bio_merge(struct request_queue =
*q, struct bio *bio,
>> 		 */
>> 		bfq_bic_update_cgroup(bic, bio);
>>=20
>> -		bfqd->bio_bfqq =3D bic_to_bfqq(bic, =
op_is_sync(bio->bi_opf));
>> +		bfqd->bio_bfqq =3D bic_to_bfqq(bic, =
op_is_sync(bio->bi_opf),
>> +					     bfq_actuator_index(bfqd, =
bio));
>> 	} else {
>> 		bfqd->bio_bfqq =3D NULL;
>> 	}
>> @@ -3174,7 +3204,7 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct =
bfq_io_cq *bic,
>> 	/*
>> 	 * Merge queues (that is, let bic redirect its requests to =
new_bfqq)
>> 	 */
>> -	bic_set_bfqq(bic, new_bfqq, 1);
>> +	bic_set_bfqq(bic, new_bfqq, true, bfqq->actuator_idx);
>> 	bfq_mark_bfqq_coop(new_bfqq);
>> 	/*
>> 	 * new_bfqq now belongs to at least two bics (it is a shared =
queue):
>> @@ -4808,11 +4838,8 @@ static struct bfq_queue =
*bfq_select_queue(struct bfq_data *bfqd)
>> 	 */
>> 	if (bfq_bfqq_wait_request(bfqq) ||
>> 	    (bfqq->dispatched !=3D 0 && bfq_better_to_idle(bfqq))) {
>> -		struct bfq_queue *async_bfqq =3D
>> -			bfqq->bic && bfqq->bic->bfqq[0] &&
>> -			bfq_bfqq_busy(bfqq->bic->bfqq[0]) &&
>> -			bfqq->bic->bfqq[0]->next_rq ?
>> -			bfqq->bic->bfqq[0] : NULL;
>> +		unsigned int act_idx =3D bfqq->actuator_idx;
>> +		struct bfq_queue *async_bfqq =3D NULL;
>> 		struct bfq_queue *blocked_bfqq =3D
>> 			!hlist_empty(&bfqq->woken_list) ?
>> 			container_of(bfqq->woken_list.first,
>> @@ -4820,6 +4847,10 @@ static struct bfq_queue =
*bfq_select_queue(struct bfq_data *bfqd)
>> 				     woken_list_node)
>> 			: NULL;
>>=20
>> +		if (bfqq->bic && bfqq->bic->bfqq[0][act_idx] &&
>> +		    bfq_bfqq_busy(bfqq->bic->bfqq[0][act_idx]) &&
>> +		    bfqq->bic->bfqq[0][act_idx]->next_rq)
>> +			async_bfqq =3D bfqq->bic->bfqq[0][act_idx];
>> 		/*
>> 		 * The next four mutually-exclusive ifs decide
>> 		 * whether to try injection, and choose the queue to
>> @@ -4904,7 +4935,7 @@ static struct bfq_queue =
*bfq_select_queue(struct bfq_data *bfqd)
>> 		    icq_to_bic(async_bfqq->next_rq->elv.icq) =3D=3D =
bfqq->bic &&
>> 		    bfq_serv_to_charge(async_bfqq->next_rq, async_bfqq) =
<=3D
>> 		    bfq_bfqq_budget_left(async_bfqq))
>> -			bfqq =3D bfqq->bic->bfqq[0];
>> +			bfqq =3D bfqq->bic->bfqq[0][act_idx];
>> 		else if (bfqq->waker_bfqq &&
>> 			   bfq_bfqq_busy(bfqq->waker_bfqq) &&
>> 			   bfqq->waker_bfqq->next_rq &&
>> @@ -5365,49 +5396,55 @@ static void bfq_exit_bfqq(struct bfq_data =
*bfqd, struct bfq_queue *bfqq)
>> 	bfq_release_process_ref(bfqd, bfqq);
>> }
>>=20
>> -static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
>> +static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync,
>> +			      unsigned int actuator_idx)
>> {
>> -	struct bfq_queue *bfqq =3D bic_to_bfqq(bic, is_sync);
>> +	struct bfq_queue *bfqq =3D bic_to_bfqq(bic, is_sync, =
actuator_idx);
>> 	struct bfq_data *bfqd;
>>=20
>> 	if (bfqq)
>> 		bfqd =3D bfqq->bfqd; /* NULL if scheduler already exited =
*/
>>=20
>> 	if (bfqq && bfqd) {
>> -		unsigned long flags;
>> -
>> -		spin_lock_irqsave(&bfqd->lock, flags);
>> 		bfqq->bic =3D NULL;
>> 		bfq_exit_bfqq(bfqd, bfqq);
>> -		bic_set_bfqq(bic, NULL, is_sync);
>> -		spin_unlock_irqrestore(&bfqd->lock, flags);
>> +		bic_set_bfqq(bic, NULL, is_sync, actuator_idx);
>> 	}
>> }
>>=20
>> static void bfq_exit_icq(struct io_cq *icq)
>> {
>> 	struct bfq_io_cq *bic =3D icq_to_bic(icq);
>> +	struct bfq_data *bfqd =3D bic_to_bfqd(bic);
>> +	unsigned long flags;
>> +	unsigned int act_idx;
>> +	/*
>> +	 * If bfqd and thus bfqd->num_actuators is not available any
>> +	 * longer, then cycle over all possible per-actuator bfqqs in
>> +	 * next loop. We rely on bic being zeroed on creation, and
>> +	 * therefore on its unused per-actuator fields being NULL.
>> +	 */
>> +	unsigned int num_actuators =3D BFQ_MAX_ACTUATORS;
>>=20
>> -	if (bic->stable_merge_bfqq) {
>> -		struct bfq_data *bfqd =3D bic->stable_merge_bfqq->bfqd;
>> +	/*
>> +	 * bfqd is NULL if scheduler already exited, and in that case
>> +	 * this is the last time these queues are accessed.
>> +	 */
>> +	if (bfqd) {
>> +		spin_lock_irqsave(&bfqd->lock, flags);
>> +		num_actuators =3D bfqd->num_actuators;
>> +	}
>>=20
>> -		/*
>> -		 * bfqd is NULL if scheduler already exited, and in
>> -		 * that case this is the last time bfqq is accessed.
>> -		 */
>> -		if (bfqd) {
>> -			unsigned long flags;
>> +	if (bic->stable_merge_bfqq)
>> +		bfq_put_stable_ref(bic->stable_merge_bfqq);
>>=20
>> -			spin_lock_irqsave(&bfqd->lock, flags);
>> -			bfq_put_stable_ref(bic->stable_merge_bfqq);
>> -			spin_unlock_irqrestore(&bfqd->lock, flags);
>> -		} else {
>> -			bfq_put_stable_ref(bic->stable_merge_bfqq);
>> -		}
>> +	for (act_idx =3D 0; act_idx < num_actuators; act_idx++) {
>> +		bfq_exit_icq_bfqq(bic, true, act_idx);
>> +		bfq_exit_icq_bfqq(bic, false, act_idx);
>> 	}
>>=20
>> -	bfq_exit_icq_bfqq(bic, true);
>> -	bfq_exit_icq_bfqq(bic, false);
>> +	if (bfqd)
>> +		spin_unlock_irqrestore(&bfqd->lock, flags);
>> }
>>=20
>> /*
>> @@ -5484,23 +5521,25 @@ static void bfq_check_ioprio_change(struct =
bfq_io_cq *bic, struct bio *bio)
>>=20
>> 	bic->ioprio =3D ioprio;
>>=20
>> -	bfqq =3D bic_to_bfqq(bic, false);
>> +	bfqq =3D bic_to_bfqq(bic, false, bfq_actuator_index(bfqd, bio));
>> 	if (bfqq) {
>> 		bfq_release_process_ref(bfqd, bfqq);
>> 		bfqq =3D bfq_get_queue(bfqd, bio, false, bic, true);
>> -		bic_set_bfqq(bic, bfqq, false);
>> +		bic_set_bfqq(bic, bfqq, false, bfq_actuator_index(bfqd, =
bio));
>> 	}
>>=20
>> -	bfqq =3D bic_to_bfqq(bic, true);
>> +	bfqq =3D bic_to_bfqq(bic, true, bfq_actuator_index(bfqd, bio));
>> 	if (bfqq)
>> 		bfq_set_next_ioprio_data(bfqq, bic);
>> }
>>=20
>> static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue =
*bfqq,
>> -			  struct bfq_io_cq *bic, pid_t pid, int is_sync)
>> +			  struct bfq_io_cq *bic, pid_t pid, int is_sync,
>> +			  unsigned int act_idx)
>> {
>> 	u64 now_ns =3D ktime_get_ns();
>>=20
>> +	bfqq->actuator_idx =3D act_idx;
>> 	RB_CLEAR_NODE(&bfqq->entity.rb_node);
>> 	INIT_LIST_HEAD(&bfqq->fifo);
>> 	INIT_HLIST_NODE(&bfqq->burst_list_node);
>> @@ -5753,7 +5792,7 @@ static struct bfq_queue *bfq_get_queue(struct =
bfq_data *bfqd,
>>=20
>> 	if (bfqq) {
>> 		bfq_init_bfqq(bfqd, bfqq, bic, current->pid,
>> -			      is_sync);
>> +			      is_sync, bfq_actuator_index(bfqd, bio));
>> 		bfq_init_entity(&bfqq->entity, bfqg);
>> 		bfq_log_bfqq(bfqd, bfqq, "allocated");
>> 	} else {
>> @@ -6068,7 +6107,8 @@ static bool __bfq_insert_request(struct =
bfq_data *bfqd, struct request *rq)
>> 		 * then complete the merge and redirect it to
>> 		 * new_bfqq.
>> 		 */
>> -		if (bic_to_bfqq(RQ_BIC(rq), 1) =3D=3D bfqq)
>> +		if (bic_to_bfqq(RQ_BIC(rq), true,
>> +				bfq_actuator_index(bfqd, rq->bio)) =3D=3D =
bfqq)
>> 			bfq_merge_bfqqs(bfqd, RQ_BIC(rq),
>> 					bfqq, new_bfqq);
>>=20
>> @@ -6622,7 +6662,7 @@ bfq_split_bfqq(struct bfq_io_cq *bic, struct =
bfq_queue *bfqq)
>> 		return bfqq;
>> 	}
>>=20
>> -	bic_set_bfqq(bic, NULL, 1);
>> +	bic_set_bfqq(bic, NULL, true, bfqq->actuator_idx);
>>=20
>> 	bfq_put_cooperator(bfqq);
>>=20
>> @@ -6636,7 +6676,8 @@ static struct bfq_queue =
*bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
>> 						   bool split, bool =
is_sync,
>> 						   bool *new_queue)
>> {
>> -	struct bfq_queue *bfqq =3D bic_to_bfqq(bic, is_sync);
>> +	unsigned int act_idx =3D bfq_actuator_index(bfqd, bio);
>> +	struct bfq_queue *bfqq =3D bic_to_bfqq(bic, is_sync, act_idx);
>>=20
>> 	if (likely(bfqq && bfqq !=3D &bfqd->oom_bfqq))
>> 		return bfqq;
>> @@ -6648,7 +6689,7 @@ static struct bfq_queue =
*bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
>> 		bfq_put_queue(bfqq);
>> 	bfqq =3D bfq_get_queue(bfqd, bio, is_sync, bic, split);
>>=20
>> -	bic_set_bfqq(bic, bfqq, is_sync);
>> +	bic_set_bfqq(bic, bfqq, is_sync, act_idx);
>> 	if (split && is_sync) {
>> 		if ((bic->was_in_burst_list && bfqd->large_burst) ||
>> 		    bic->saved_in_large_burst)
>> @@ -7090,8 +7131,10 @@ static int bfq_init_queue(struct request_queue =
*q, struct elevator_type *e)
>> 	 * Our fallback bfqq if bfq_find_alloc_queue() runs into OOM =
issues.
>> 	 * Grab a permanent reference to it, so that the normal code =
flow
>> 	 * will not attempt to free it.
>> +	 * Set zero as actuator index: we will pretend that
>> +	 * all I/O requests are for the same actuator.
>> 	 */
>> -	bfq_init_bfqq(bfqd, &bfqd->oom_bfqq, NULL, 1, 0);
>> +	bfq_init_bfqq(bfqd, &bfqd->oom_bfqq, NULL, 1, 0, 0);
>> 	bfqd->oom_bfqq.ref++;
>> 	bfqd->oom_bfqq.new_ioprio =3D BFQ_DEFAULT_QUEUE_IOPRIO;
>> 	bfqd->oom_bfqq.new_ioprio_class =3D IOPRIO_CLASS_BE;
>> @@ -7110,6 +7153,13 @@ static int bfq_init_queue(struct request_queue =
*q, struct elevator_type *e)
>>=20
>> 	bfqd->queue =3D q;
>>=20
>> +	/*
>> +	 * Multi-actuator support not complete yet, unconditionally
>> +	 * set to only one actuator for the moment (to keep incomplete
>> +	 * mechanisms off).
>> +	 */
>> +	bfqd->num_actuators =3D 1;
>> +
>> 	INIT_LIST_HEAD(&bfqd->dispatch);
>>=20
>> 	hrtimer_init(&bfqd->idle_slice_timer, CLOCK_MONOTONIC,
>> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
>> index 71f721670ab6..2b413ddffbb9 100644
>> --- a/block/bfq-iosched.h
>> +++ b/block/bfq-iosched.h
>> @@ -33,6 +33,14 @@
>>  */
>> #define BFQ_SOFTRT_WEIGHT_FACTOR	100
>>=20
>> +/*
>> + * Maximum number of actuators supported. This constant is used =
simply
>> + * to define the size of the static array that will contain
>> + * per-actuator data. The current value is hopefully a good upper
>> + * bound to the possible number of actuators of any actual drive.
>> + */
>> +#define BFQ_MAX_ACTUATORS 8
>> +
>> struct bfq_entity;
>>=20
>> /**
>> @@ -225,12 +233,14 @@ struct bfq_ttime {
>>  * struct bfq_queue - leaf schedulable entity.
>>  *
>>  * A bfq_queue is a leaf request queue; it can be associated with an
>> - * io_context or more, if it  is  async or shared  between  =
cooperating
>> - * processes. @cgroup holds a reference to the cgroup, to be sure =
that it
>> - * does not disappear while a bfqq still references it (mostly to =
avoid
>> - * races between request issuing and task migration followed by =
cgroup
>> - * destruction).
>> - * All the fields are protected by the queue lock of the containing =
bfqd.
>> + * io_context or more, if it is async or shared between cooperating
>> + * processes. Besides, it contains I/O requests for only one =
actuator
>> + * (an io_context is associated with a different bfq_queue for each
>> + * actuator it generates I/O for). @cgroup holds a reference to the
>> + * cgroup, to be sure that it does not disappear while a bfqq still
>> + * references it (mostly to avoid races between request issuing and
>> + * task migration followed by cgroup destruction).  All the fields =
are
>> + * protected by the queue lock of the containing bfqd.
>>  */
>> struct bfq_queue {
>> 	/* reference counter */
>> @@ -395,6 +405,9 @@ struct bfq_queue {
>> 	 * the woken queues when this queue exits.
>> 	 */
>> 	struct hlist_head woken_list;
>> +
>> +	/* index of the actuator this queue is associated with */
>> +	unsigned int actuator_idx;
>> };
>>=20
>> /**
>> @@ -403,8 +416,17 @@ struct bfq_queue {
>> struct bfq_io_cq {
>> 	/* associated io_cq structure */
>> 	struct io_cq icq; /* must be the first member */
>> -	/* array of two process queues, the sync and the async */
>> -	struct bfq_queue *bfqq[2];
>> +	/*
>> +	 * Matrix of associated process queues: first row for async
>> +	 * queues, second row sync queues. Each row contains one
>> +	 * column for each actuator. An I/O request generated by the
>> +	 * process is inserted into the queue pointed by bfqq[i][j] if
>> +	 * the request is to be served by the j-th actuator of the
>> +	 * drive, where i=3D=3D0 or i=3D=3D1, depending on whether the =
request
>> +	 * is async or sync. So there is a distinct queue for each
>> +	 * actuator.
>> +	 */
>> +	struct bfq_queue *bfqq[2][BFQ_MAX_ACTUATORS];
>> 	/* per (request_queue, blkcg) ioprio */
>> 	int ioprio;
>> #ifdef CONFIG_BFQ_GROUP_IOSCHED
>> @@ -768,6 +790,13 @@ struct bfq_data {
>> 	 */
>> 	unsigned int word_depths[2][2];
>> 	unsigned int full_depth_shift;
>> +
>> +	/*
>> +	 * Number of independent actuators. This is equal to 1 in
>> +	 * case of single-actuator drives.
>> +	 */
>> +	unsigned int num_actuators;
>> +
>> };
>>=20
>> enum bfqq_state_flags {
>> @@ -964,8 +993,10 @@ struct bfq_group {
>>=20
>> extern const int bfq_timeout;
>>=20
>> -struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync);
>> -void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, =
bool is_sync);
>> +struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync,
>> +				unsigned int actuator_idx);
>> +void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, =
bool is_sync,
>> +				unsigned int actuator_idx);
>> struct bfq_data *bic_to_bfqd(struct bfq_io_cq *bic);
>> void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue =
*bfqq);
>> void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue =
*bfqq,
>=20
> --=20
> Damien Le Moal
> Western Digital Research

