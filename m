Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4991A5F4C59
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 01:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiJDXER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 19:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJDXEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 19:04:13 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5534686A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 16:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664924651; x=1696460651;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v4s6NV/hADvozFkmz+C/nTHXi6Ts1mPph0yf5xcB9X4=;
  b=VBlS22QSJUhLl0Ixlbce87ayT0rG7erq3e3GZ7X0LOhP8oLhIrrLnus7
   chzk48Zb0TsuG8nIaqg/YyQrGnOA5eSv94RDpMJxSwyYV9ZiOb4r6c1JU
   cY6d+s+nsp0SX72zMbdsxKU021GxXRzdHXnKzXVV3UdNtfKdi/sQHVn2Q
   qiDavrN4UWE+yjBDbcQfL199uS0XR0z6FimmERnFErrYWFgy7hQL/BLCy
   GcY2cVR+FbkXeJMUPyDWh6Zs7itNa5S3SQAJDQBSFCjj+tzkC91gvCVp0
   g5MZNd+WrL4B1fQpfMvaZK1GFwXgehJZ/+D4OjPJBtHstkpAUng1JfDzZ
   A==;
X-IronPort-AV: E=Sophos;i="5.95,158,1661788800"; 
   d="scan'208";a="211344972"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 07:04:11 +0800
IronPort-SDR: Frlsx8L3/Nq8pF0/7hVyn7pYdwTFKvqY/P7PJsSzatcXpqUNAUVmEyMqsF6blebJ2bUgMLtzle
 dkQ6WT2/nlOnJS090CDFJyF+SsjMpivCCy0p6x9BvqCSQI5TpbFxo5we/63L/19KmcDIGbF1vg
 w3puXZN6xRWeI2ghyru8CoWgGNgf4cTFWTWnC4hCC/mULqV3WXmGcX7cAbwKT6FftpsRs9AMPO
 QkRBFxlVxAK4aLMUGIgmh8i0lT5yvt3mJi5HdEBaiSDsoqg0lDrSJAhZbA353PrWiDHfhEI3hN
 IxO6cuDpUk4ICU074Vt+DoRl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 15:23:59 -0700
IronPort-SDR: geshxYK8lyDlajuKVhvFy2NFhcrNWh1j/fGlXlhruoMWNJrYitzzoWmCw7ZxygW5BdvxmMR55c
 Tbj36ppKDhByf5LxPe1VcUSwtxMFQslH9xG99I/VLppNMcjQRqjlsrflkwf/GrG1bqe47aIzC+
 MOrFHPcxUPTqKNdaWQvZArxpV96fPMtHeIYxFL5ZAyEdVzpsrmEzyk4uX2JGxlo+xKFzK5/USc
 jeBv4KXcwaM5uSO+AxfXksVOPLsgdBea56hj75ZEx9Z6sC03yjSMlLAqzcTH/Cfturk7+FL0qV
 lKg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 16:04:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MhtYk6clWz1RwtC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 16:04:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664924647; x=1667516648; bh=v4s6NV/hADvozFkmz+C/nTHXi6Ts1mPph0y
        f5xcB9X4=; b=NkiYufQYEEwfxDM+Iexsr6i7AVM0ufKuINAABC3kXUUiMuhUbKS
        uQYB0E/9tz07yVSiyPPq3g3IyaAlU01nI3A8860hL1m+e5SxJrE3ad98eNP5CSEw
        zTM54r/n4ZasdRIe3C6S5IZpgfePKFE52ErptPCx6ElWEnoRZhifsNLwzR8VoXwb
        HS/9tUvR2/ElAKY1cC5cMCp2nRZKnDAvbLz09ofV/QgfBWuKYH3Gb3yM8t+hIOCb
        rqGzgML2nm3WcOIYNqawdW/qT7UE+5ZuYRNP6X+g2o3F+cSFcNcLpdTrX80FRsO7
        ACmtM51ujQuSCXHzg4+Yo2MsdI15zh8+Jzg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id E3gJx1tKISTX for <linux-kernel@vger.kernel.org>;
        Tue,  4 Oct 2022 16:04:07 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MhtYd2Fdkz1RvLy;
        Tue,  4 Oct 2022 16:04:05 -0700 (PDT)
Message-ID: <d3b3fff8-9eb2-9174-8872-67adb77788f8@opensource.wdc.com>
Date:   Wed, 5 Oct 2022 08:04:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH V3 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Gabriele Felici <felicigb@gmail.com>
References: <20221004094010.80090-1-paolo.valente@linaro.org>
 <20221004094010.80090-2-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221004094010.80090-2-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/22 18:40, Paolo Valente wrote:
> Multi-actuator drives appear as a single device to the I/O subsystem [1=
].

Not necessarilly. Multi-lun scsi model will show up as multiple drives
with one actuator each.

> Yet they address commands to different actuators internally, as a
> function of Logical Block Addressing (LBAs). A given sector is
> reachable by only one of the actuators. For example, Seagate=E2=80=99s =
Serial
> Advanced Technology Attachment (SATA) version contains two actuators
> and maps the lower half of the SATA LBA space to the lower actuator
> and the upper half to the upper actuator.
>=20
> Evidently, to fully utilize actuators, no actuator must be left idle
> or underutilized while there is pending I/O for it. The block layer
> must somehow control the load of each actuator individually. This
> commit lays the ground for allowing BFQ to provide such a per-actuator
> control.
>=20
> BFQ associates an I/O-request sync bfq_queue with each process doing
> synchronous I/O, or with a group of processes, in case of queue
> merging. Then BFQ serves one bfq_queue at a time. While in service, a
> bfq_queue is emptied in request-position order. Yet the same process,
> or group of processes, may generate I/O for different actuators. In
> this case, different streams of I/O (each for a different actuator)
> get all inserted into the same sync bfq_queue. So there is basically
> no individual control on when each stream is served, i.e., on when the
> I/O requests of the stream are picked from the bfq_queue and
> dispatched to the drive.
>=20
> This commit enables BFQ to control the service of each actuator
> individually for synchronous I/O, by simply splitting each sync
> bfq_queue into N queues, one for each actuator. In other words, a sync
> bfq_queue is now associated to a pair (process, actuator). As a
> consequence of this split, the per-queue proportional-share policy
> implemented by BFQ will guarantee that the sync I/O generated for each
> actuator, by each process, receives its fair share of service.
>=20
> This is just a preparatory patch. If the I/O of the same process
> happens to be sent to different queues, then each of these queues may
> undergo queue merging. To handle this event, the bfq_io_cq data
> structure must be properly extended. In addition, stable merging must
> be disabled to avoid loss of control on individual actuators. Finally,
> also async queues must be split. These issues are described in detail
> and addressed in next commits. As for this commit, although multiple
> per-process bfq_queues are provided, the I/O of each process or group
> of processes is still sent to only one queue, regardless of the
> actuator the I/O is for. The forwarding to distinct bfq_queues will be
> enabled after addressing the above issues.
>=20
> [1] https://www.linaro.org/blog/budget-fair-queueing-bfq-linux-io-sched=
uler-optimizations-for-multi-actuator-sata-hard-drives/
>=20
> Signed-off-by: Gabriele Felici <felicigb@gmail.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-cgroup.c  |  95 +++++++++++++++++--------------
>  block/bfq-iosched.c | 135 +++++++++++++++++++++++++++-----------------
>  block/bfq-iosched.h |  38 +++++++++----
>  3 files changed, 164 insertions(+), 104 deletions(-)
>=20
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 30b15a9a47c4..a745dd9d658e 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -705,6 +705,48 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct b=
fq_queue *bfqq,
>  	bfq_put_queue(bfqq);
>  }
> =20
> +static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
> +			       struct bfq_queue *sync_bfqq,
> +			       struct bfq_io_cq *bic,
> +			       struct bfq_group *bfqg,
> +			       unsigned int act_idx)
> +{
> +	if (!sync_bfqq->new_bfqq && !bfq_bfqq_coop(sync_bfqq)) {
> +		/* We are the only user of this bfqq, just move it */
> +		if (sync_bfqq->entity.sched_data !=3D &bfqg->sched_data)
> +			bfq_bfqq_move(bfqd, sync_bfqq, bfqg);
> +	} else {
> +		struct bfq_queue *bfqq;
> +
> +		/*
> +		 * The queue was merged to a different queue. Check
> +		 * that the merge chain still belongs to the same
> +		 * cgroup.
> +		 */
> +		for (bfqq =3D sync_bfqq; bfqq; bfqq =3D bfqq->new_bfqq)
> +			if (bfqq->entity.sched_data !=3D
> +			    &bfqg->sched_data)
> +				break;
> +		if (bfqq) {
> +			/*
> +			 * Some queue changed cgroup so the merge is
> +			 * not valid anymore. We cannot easily just
> +			 * cancel the merge (by clearing new_bfqq) as
> +			 * there may be other processes using this
> +			 * queue and holding refs to all queues below
> +			 * sync_bfqq->new_bfqq. Similarly if the merge
> +			 * already happened, we need to detach from
> +			 * bfqq now so that we cannot merge bio to a
> +			 * request from the old cgroup.
> +			 */
> +			bfq_put_cooperator(sync_bfqq);
> +			bfq_release_process_ref(bfqd, sync_bfqq);
> +			bic_set_bfqq(bic, NULL, 1, act_idx);
> +		}
> +	}
> +}
> +
> +
>  /**
>   * __bfq_bic_change_cgroup - move @bic to @bfqg.
>   * @bfqd: the queue descriptor.
> @@ -719,53 +761,24 @@ static void *__bfq_bic_change_cgroup(struct bfq_d=
ata *bfqd,
>  				     struct bfq_io_cq *bic,
>  				     struct bfq_group *bfqg)
>  {
> -	struct bfq_queue *async_bfqq =3D bic_to_bfqq(bic, 0);
> -	struct bfq_queue *sync_bfqq =3D bic_to_bfqq(bic, 1);
>  	struct bfq_entity *entity;
> +	unsigned int act_idx;
> =20
> -	if (async_bfqq) {
> -		entity =3D &async_bfqq->entity;
> -
> -		if (entity->sched_data !=3D &bfqg->sched_data) {
> -			bic_set_bfqq(bic, NULL, 0);
> -			bfq_release_process_ref(bfqd, async_bfqq);
> -		}
> -	}
> +	for (act_idx =3D 0; act_idx < BFQ_NUM_ACTUATORS; act_idx++) {

Why loop over all BFQ_NUM_ACTUATORS actuators even though this patch
itself is not enough to support multiple actuators ?
You then have patch 5 changing this macro to BFQ_MAX_ACTUATORS and then
patch 6 finally introducing a nr_ia_range bfq field to indicate the
effective number of actuators.

Why not:
1) introduce BFQ_MAX_ACTUATORS in this patch and define the bfqq field
using it
2) introduce a nr_actuators field defaultint to 1 for now and use that as
the upper bound for actuator earch loop

That would be 100% consistent with the current code (no change in
practice) and avoid all the code churn you have in the following patches.

> +		struct bfq_queue *async_bfqq =3D bic_to_bfqq(bic, 0, act_idx);
> +		struct bfq_queue *sync_bfqq =3D bic_to_bfqq(bic, 1, act_idx);
> =20
> -	if (sync_bfqq) {
> -		if (!sync_bfqq->new_bfqq && !bfq_bfqq_coop(sync_bfqq)) {
> -			/* We are the only user of this bfqq, just move it */
> -			if (sync_bfqq->entity.sched_data !=3D &bfqg->sched_data)
> -				bfq_bfqq_move(bfqd, sync_bfqq, bfqg);
> -		} else {
> -			struct bfq_queue *bfqq;
> +		if (async_bfqq) {
> +			entity =3D &async_bfqq->entity;
> =20
> -			/*
> -			 * The queue was merged to a different queue. Check
> -			 * that the merge chain still belongs to the same
> -			 * cgroup.
> -			 */
> -			for (bfqq =3D sync_bfqq; bfqq; bfqq =3D bfqq->new_bfqq)
> -				if (bfqq->entity.sched_data !=3D
> -				    &bfqg->sched_data)
> -					break;
> -			if (bfqq) {
> -				/*
> -				 * Some queue changed cgroup so the merge is
> -				 * not valid anymore. We cannot easily just
> -				 * cancel the merge (by clearing new_bfqq) as
> -				 * there may be other processes using this
> -				 * queue and holding refs to all queues below
> -				 * sync_bfqq->new_bfqq. Similarly if the merge
> -				 * already happened, we need to detach from
> -				 * bfqq now so that we cannot merge bio to a
> -				 * request from the old cgroup.
> -				 */
> -				bfq_put_cooperator(sync_bfqq);
> -				bfq_release_process_ref(bfqd, sync_bfqq);
> -				bic_set_bfqq(bic, NULL, 1);
> +			if (entity->sched_data !=3D &bfqg->sched_data) {
> +				bic_set_bfqq(bic, NULL, 0, act_idx);
> +				bfq_release_process_ref(bfqd, async_bfqq);
>  			}
>  		}
> +
> +		if (sync_bfqq)
> +			bfq_sync_bfqq_move(bfqd, sync_bfqq, bic, bfqg, act_idx);
>  	}
> =20
>  	return bfqg;
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index c740b41fe0a4..c2485b599d87 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -377,14 +377,19 @@ static const unsigned long bfq_late_stable_mergin=
g =3D 600;
>  #define RQ_BIC(rq)		((struct bfq_io_cq *)((rq)->elv.priv[0]))
>  #define RQ_BFQQ(rq)		((rq)->elv.priv[1])
> =20
> -struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync)
> +struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic,
> +			      bool is_sync,
> +			      unsigned int actuator_idx)
>  {
> -	return bic->bfqq[is_sync];
> +	return bic->bfqq[is_sync][actuator_idx];
>  }
> =20
>  static void bfq_put_stable_ref(struct bfq_queue *bfqq);
> =20
> -void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool =
is_sync)
> +void bic_set_bfqq(struct bfq_io_cq *bic,
> +		  struct bfq_queue *bfqq,
> +		  bool is_sync,
> +		  unsigned int actuator_idx)
>  {
>  	/*
>  	 * If bfqq !=3D NULL, then a non-stable queue merge between
> @@ -399,7 +404,7 @@ void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq=
_queue *bfqq, bool is_sync)
>  	 * we cancel the stable merge if
>  	 * bic->stable_merge_bfqq =3D=3D bfqq.
>  	 */
> -	bic->bfqq[is_sync] =3D bfqq;
> +	bic->bfqq[is_sync][actuator_idx] =3D bfqq;
> =20
>  	if (bfqq && bic->stable_merge_bfqq =3D=3D bfqq) {
>  		/*
> @@ -672,9 +677,9 @@ static void bfq_limit_depth(blk_opf_t opf, struct b=
lk_mq_alloc_data *data)
>  {
>  	struct bfq_data *bfqd =3D data->q->elevator->elevator_data;
>  	struct bfq_io_cq *bic =3D bfq_bic_lookup(data->q);
> -	struct bfq_queue *bfqq =3D bic ? bic_to_bfqq(bic, op_is_sync(opf)) : =
NULL;
>  	int depth;
>  	unsigned limit =3D data->q->nr_requests;
> +	unsigned int act_idx;
> =20
>  	/* Sync reads have full depth available */
>  	if (op_is_sync(opf) && !op_is_write(opf)) {
> @@ -684,14 +689,21 @@ static void bfq_limit_depth(blk_opf_t opf, struct=
 blk_mq_alloc_data *data)
>  		limit =3D (limit * depth) >> bfqd->full_depth_shift;
>  	}
> =20
> -	/*
> -	 * Does queue (or any parent entity) exceed number of requests that
> -	 * should be available to it? Heavily limit depth so that it cannot
> -	 * consume more available requests and thus starve other entities.
> -	 */
> -	if (bfqq && bfqq_request_over_limit(bfqq, limit))
> -		depth =3D 1;
> +	for (act_idx =3D 0; act_idx < BFQ_NUM_ACTUATORS; act_idx++) {
> +		struct bfq_queue *bfqq =3D
> +			bic ? bic_to_bfqq(bic, op_is_sync(opf), act_idx) : NULL;
> =20
> +		/*
> +		 * Does queue (or any parent entity) exceed number of
> +		 * requests that should be available to it? Heavily
> +		 * limit depth so that it cannot consume more
> +		 * available requests and thus starve other entities.
> +		 */
> +		if (bfqq && bfqq_request_over_limit(bfqq, limit)) {
> +			depth =3D 1;
> +			break;
> +		}
> +	}
>  	bfq_log(bfqd, "[%s] wr_busy %d sync %d depth %u",
>  		__func__, bfqd->wr_busy_queues, op_is_sync(opf), depth);
>  	if (depth)
> @@ -2142,7 +2154,7 @@ static void bfq_check_waker(struct bfq_data *bfqd=
, struct bfq_queue *bfqq,
>  	 * We reset waker detection logic also if too much time has passed
>   	 * since the first detection. If wakeups are rare, pointless idling
>  	 * doesn't hurt throughput that much. The condition below makes sure
> -	 * we do not uselessly idle blocking waker in more than 1/64 cases.=20
> +	 * we do not uselessly idle blocking waker in more than 1/64 cases.
>  	 */
>  	if (bfqd->last_completed_rq_bfqq !=3D
>  	    bfqq->tentative_waker_bfqq ||
> @@ -2454,6 +2466,16 @@ static void bfq_remove_request(struct request_qu=
eue *q,
> =20
>  }
> =20
> +/* get the index of the actuator that will serve bio */
> +static unsigned int bfq_actuator_index(struct bfq_data *bfqd, struct b=
io *bio)
> +{
> +	/*
> +	 * Multi-actuator support not complete yet, so always return 0
> +	 * for the moment.
> +	 */
> +	return 0;
> +}
> +
>  static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
>  		unsigned int nr_segs)
>  {
> @@ -2478,7 +2500,8 @@ static bool bfq_bio_merge(struct request_queue *q=
, struct bio *bio,
>  		 */
>  		bfq_bic_update_cgroup(bic, bio);
> =20
> -		bfqd->bio_bfqq =3D bic_to_bfqq(bic, op_is_sync(bio->bi_opf));
> +		bfqd->bio_bfqq =3D bic_to_bfqq(bic, op_is_sync(bio->bi_opf),
> +					     bfq_actuator_index(bfqd, bio));
>  	} else {
>  		bfqd->bio_bfqq =3D NULL;
>  	}
> @@ -3174,7 +3197,7 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq=
_io_cq *bic,
>  	/*
>  	 * Merge queues (that is, let bic redirect its requests to new_bfqq)
>  	 */
> -	bic_set_bfqq(bic, new_bfqq, 1);
> +	bic_set_bfqq(bic, new_bfqq, 1, bfqq->actuator_idx);
>  	bfq_mark_bfqq_coop(new_bfqq);
>  	/*
>  	 * new_bfqq now belongs to at least two bics (it is a shared queue):
> @@ -4808,11 +4831,12 @@ static struct bfq_queue *bfq_select_queue(struc=
t bfq_data *bfqd)
>  	 */
>  	if (bfq_bfqq_wait_request(bfqq) ||
>  	    (bfqq->dispatched !=3D 0 && bfq_better_to_idle(bfqq))) {
> +		unsigned int act_idx =3D bfqq->actuator_idx;
>  		struct bfq_queue *async_bfqq =3D
> -			bfqq->bic && bfqq->bic->bfqq[0] &&
> -			bfq_bfqq_busy(bfqq->bic->bfqq[0]) &&
> -			bfqq->bic->bfqq[0]->next_rq ?
> -			bfqq->bic->bfqq[0] : NULL;
> +			bfqq->bic && bfqq->bic->bfqq[0][act_idx] &&
> +			bfq_bfqq_busy(bfqq->bic->bfqq[0][act_idx]) &&
> +			bfqq->bic->bfqq[0][act_idx]->next_rq ?
> +			bfqq->bic->bfqq[0][act_idx] : NULL;
>  		struct bfq_queue *blocked_bfqq =3D
>  			!hlist_empty(&bfqq->woken_list) ?
>  			container_of(bfqq->woken_list.first,
> @@ -4904,7 +4928,7 @@ static struct bfq_queue *bfq_select_queue(struct =
bfq_data *bfqd)
>  		    icq_to_bic(async_bfqq->next_rq->elv.icq) =3D=3D bfqq->bic &&
>  		    bfq_serv_to_charge(async_bfqq->next_rq, async_bfqq) <=3D
>  		    bfq_bfqq_budget_left(async_bfqq))
> -			bfqq =3D bfqq->bic->bfqq[0];
> +			bfqq =3D bfqq->bic->bfqq[0][act_idx];
>  		else if (bfqq->waker_bfqq &&
>  			   bfq_bfqq_busy(bfqq->waker_bfqq) &&
>  			   bfqq->waker_bfqq->next_rq &&
> @@ -5367,49 +5391,47 @@ static void bfq_exit_bfqq(struct bfq_data *bfqd=
, struct bfq_queue *bfqq)
>  	bfq_release_process_ref(bfqd, bfqq);
>  }
> =20
> -static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
> +static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic,
> +			      bool is_sync,
> +			      unsigned int actuator_idx)
>  {
> -	struct bfq_queue *bfqq =3D bic_to_bfqq(bic, is_sync);
> +	struct bfq_queue *bfqq =3D bic_to_bfqq(bic, is_sync, actuator_idx);
>  	struct bfq_data *bfqd;
> =20
>  	if (bfqq)
>  		bfqd =3D bfqq->bfqd; /* NULL if scheduler already exited */
> =20
>  	if (bfqq && bfqd) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&bfqd->lock, flags);
>  		bfqq->bic =3D NULL;
>  		bfq_exit_bfqq(bfqd, bfqq);
> -		bic_set_bfqq(bic, NULL, is_sync);
> -		spin_unlock_irqrestore(&bfqd->lock, flags);
> +		bic_set_bfqq(bic, NULL, is_sync, actuator_idx);
>  	}
>  }
> =20
>  static void bfq_exit_icq(struct io_cq *icq)
>  {
>  	struct bfq_io_cq *bic =3D icq_to_bic(icq);
> +	struct bfq_data *bfqd =3D bic_to_bfqd(bic);
> +	unsigned long flags;
> +	unsigned int act_idx;
> =20
> -	if (bic->stable_merge_bfqq) {
> -		struct bfq_data *bfqd =3D bic->stable_merge_bfqq->bfqd;
> -
> -		/*
> -		 * bfqd is NULL if scheduler already exited, and in
> -		 * that case this is the last time bfqq is accessed.
> -		 */
> -		if (bfqd) {
> -			unsigned long flags;
> +	/*
> +	 * bfqd is NULL if scheduler already exited, and in that case
> +	 * this is the last time these queues are accessed.
> +	 */
> +	if (bfqd)
> +		spin_lock_irqsave(&bfqd->lock, flags);
> =20
> -			spin_lock_irqsave(&bfqd->lock, flags);
> -			bfq_put_stable_ref(bic->stable_merge_bfqq);
> -			spin_unlock_irqrestore(&bfqd->lock, flags);
> -		} else {
> +	for (act_idx =3D 0; act_idx < BFQ_NUM_ACTUATORS; act_idx++) {
> +		if (bic->stable_merge_bfqq)
>  			bfq_put_stable_ref(bic->stable_merge_bfqq);
> -		}
> +
> +		bfq_exit_icq_bfqq(bic, true, act_idx);
> +		bfq_exit_icq_bfqq(bic, false, act_idx);
>  	}
> =20
> -	bfq_exit_icq_bfqq(bic, true);
> -	bfq_exit_icq_bfqq(bic, false);
> +	if (bfqd)
> +		spin_unlock_irqrestore(&bfqd->lock, flags);
>  }
> =20
>  /*
> @@ -5486,23 +5508,25 @@ static void bfq_check_ioprio_change(struct bfq_=
io_cq *bic, struct bio *bio)
> =20
>  	bic->ioprio =3D ioprio;
> =20
> -	bfqq =3D bic_to_bfqq(bic, false);
> +	bfqq =3D bic_to_bfqq(bic, false, bfq_actuator_index(bfqd, bio));
>  	if (bfqq) {
>  		bfq_release_process_ref(bfqd, bfqq);
>  		bfqq =3D bfq_get_queue(bfqd, bio, false, bic, true);
> -		bic_set_bfqq(bic, bfqq, false);
> +		bic_set_bfqq(bic, bfqq, false, bfq_actuator_index(bfqd, bio));
>  	}
> =20
> -	bfqq =3D bic_to_bfqq(bic, true);
> +	bfqq =3D bic_to_bfqq(bic, true, bfq_actuator_index(bfqd, bio));
>  	if (bfqq)
>  		bfq_set_next_ioprio_data(bfqq, bic);
>  }
> =20
>  static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfq=
q,
> -			  struct bfq_io_cq *bic, pid_t pid, int is_sync)
> +			  struct bfq_io_cq *bic, pid_t pid, int is_sync,
> +			  unsigned int act_idx)
>  {
>  	u64 now_ns =3D ktime_get_ns();
> =20
> +	bfqq->actuator_idx =3D act_idx;
>  	RB_CLEAR_NODE(&bfqq->entity.rb_node);
>  	INIT_LIST_HEAD(&bfqq->fifo);
>  	INIT_HLIST_NODE(&bfqq->burst_list_node);
> @@ -5741,6 +5765,7 @@ static struct bfq_queue *bfq_get_queue(struct bfq=
_data *bfqd,
>  	struct bfq_group *bfqg;
> =20
>  	bfqg =3D bfq_bio_bfqg(bfqd, bio);
> +
>  	if (!is_sync) {
>  		async_bfqq =3D bfq_async_queue_prio(bfqd, bfqg, ioprio_class,
>  						  ioprio);
> @@ -5755,7 +5780,7 @@ static struct bfq_queue *bfq_get_queue(struct bfq=
_data *bfqd,
> =20
>  	if (bfqq) {
>  		bfq_init_bfqq(bfqd, bfqq, bic, current->pid,
> -			      is_sync);
> +			      is_sync, bfq_actuator_index(bfqd, bio));
>  		bfq_init_entity(&bfqq->entity, bfqg);
>  		bfq_log_bfqq(bfqd, bfqq, "allocated");
>  	} else {
> @@ -6070,7 +6095,8 @@ static bool __bfq_insert_request(struct bfq_data =
*bfqd, struct request *rq)
>  		 * then complete the merge and redirect it to
>  		 * new_bfqq.
>  		 */
> -		if (bic_to_bfqq(RQ_BIC(rq), 1) =3D=3D bfqq)
> +		if (bic_to_bfqq(RQ_BIC(rq), 1,
> +				bfq_actuator_index(bfqd, rq->bio)) =3D=3D bfqq)
>  			bfq_merge_bfqqs(bfqd, RQ_BIC(rq),
>  					bfqq, new_bfqq);
> =20
> @@ -6624,7 +6650,7 @@ bfq_split_bfqq(struct bfq_io_cq *bic, struct bfq_=
queue *bfqq)
>  		return bfqq;
>  	}
> =20
> -	bic_set_bfqq(bic, NULL, 1);
> +	bic_set_bfqq(bic, NULL, 1, bfqq->actuator_idx);
> =20
>  	bfq_put_cooperator(bfqq);
> =20
> @@ -6638,7 +6664,8 @@ static struct bfq_queue *bfq_get_bfqq_handle_spli=
t(struct bfq_data *bfqd,
>  						   bool split, bool is_sync,
>  						   bool *new_queue)
>  {
> -	struct bfq_queue *bfqq =3D bic_to_bfqq(bic, is_sync);
> +	unsigned int act_idx =3D bfq_actuator_index(bfqd, bio);
> +	struct bfq_queue *bfqq =3D bic_to_bfqq(bic, is_sync, act_idx);
> =20
>  	if (likely(bfqq && bfqq !=3D &bfqd->oom_bfqq))
>  		return bfqq;
> @@ -6650,7 +6677,7 @@ static struct bfq_queue *bfq_get_bfqq_handle_spli=
t(struct bfq_data *bfqd,
>  		bfq_put_queue(bfqq);
>  	bfqq =3D bfq_get_queue(bfqd, bio, is_sync, bic, split);
> =20
> -	bic_set_bfqq(bic, bfqq, is_sync);
> +	bic_set_bfqq(bic, bfqq, is_sync, act_idx);
>  	if (split && is_sync) {
>  		if ((bic->was_in_burst_list && bfqd->large_burst) ||
>  		    bic->saved_in_large_burst)
> @@ -7092,8 +7119,10 @@ static int bfq_init_queue(struct request_queue *=
q, struct elevator_type *e)
>  	 * Our fallback bfqq if bfq_find_alloc_queue() runs into OOM issues.
>  	 * Grab a permanent reference to it, so that the normal code flow
>  	 * will not attempt to free it.
> +	 * Set zero as actuator index: we will pretend that
> +	 * all I/O requests are for the same actuator.
>  	 */
> -	bfq_init_bfqq(bfqd, &bfqd->oom_bfqq, NULL, 1, 0);
> +	bfq_init_bfqq(bfqd, &bfqd->oom_bfqq, NULL, 1, 0, 0);
>  	bfqd->oom_bfqq.ref++;
>  	bfqd->oom_bfqq.new_ioprio =3D BFQ_DEFAULT_QUEUE_IOPRIO;
>  	bfqd->oom_bfqq.new_ioprio_class =3D IOPRIO_CLASS_BE;
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index ad8e513d7e87..8b5225a9e080 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -33,6 +33,8 @@
>   */
>  #define BFQ_SOFTRT_WEIGHT_FACTOR	100
> =20
> +#define BFQ_NUM_ACTUATORS 2
> +
>  struct bfq_entity;
> =20
>  /**
> @@ -225,12 +227,14 @@ struct bfq_ttime {
>   * struct bfq_queue - leaf schedulable entity.
>   *
>   * A bfq_queue is a leaf request queue; it can be associated with an
> - * io_context or more, if it  is  async or shared  between  cooperatin=
g
> - * processes. @cgroup holds a reference to the cgroup, to be sure that=
 it
> - * does not disappear while a bfqq still references it (mostly to avoi=
d
> - * races between request issuing and task migration followed by cgroup
> - * destruction).
> - * All the fields are protected by the queue lock of the containing bf=
qd.
> + * io_context or more, if it is async or shared between cooperating
> + * processes. Besides, it contains I/O requests for only one actuator
> + * (an io_context is associated with a different bfq_queue for each
> + * actuator it generates I/O for). @cgroup holds a reference to the
> + * cgroup, to be sure that it does not disappear while a bfqq still
> + * references it (mostly to avoid races between request issuing and
> + * task migration followed by cgroup destruction).  All the fields are
> + * protected by the queue lock of the containing bfqd.
>   */
>  struct bfq_queue {
>  	/* reference counter */
> @@ -399,6 +403,9 @@ struct bfq_queue {
>  	 * the woken queues when this queue exits.
>  	 */
>  	struct hlist_head woken_list;
> +
> +	/* index of the actuator this queue is associated with */
> +	unsigned int actuator_idx;
>  };
> =20
>  /**
> @@ -407,8 +414,17 @@ struct bfq_queue {
>  struct bfq_io_cq {
>  	/* associated io_cq structure */
>  	struct io_cq icq; /* must be the first member */
> -	/* array of two process queues, the sync and the async */
> -	struct bfq_queue *bfqq[2];
> +	/*
> +	 * Matrix of associated process queues: first row for async
> +	 * queues, second row sync queues. Each row contains one
> +	 * column for each actuator. An I/O request generated by the
> +	 * process is inserted into the queue pointed by bfqq[i][j] if
> +	 * the request is to be served by the j-th actuator of the
> +	 * drive, where i=3D=3D0 or i=3D=3D1, depending on whether the reques=
t
> +	 * is async or sync. So there is a distinct queue for each
> +	 * actuator.
> +	 */
> +	struct bfq_queue *bfqq[2][BFQ_NUM_ACTUATORS];
>  	/* per (request_queue, blkcg) ioprio */
>  	int ioprio;
>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
> @@ -968,8 +984,10 @@ struct bfq_group {
> =20
>  extern const int bfq_timeout;
> =20
> -struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync);
> -void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool =
is_sync);
> +struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync,
> +				unsigned int actuator_idx);
> +void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool =
is_sync,
> +				unsigned int actuator_idx);
>  struct bfq_data *bic_to_bfqd(struct bfq_io_cq *bic);
>  void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bf=
qq);
>  void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfq=
q,

--=20
Damien Le Moal
Western Digital Research

