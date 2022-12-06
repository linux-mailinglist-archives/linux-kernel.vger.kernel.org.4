Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3628264492A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbiLFQ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbiLFQ1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:27:04 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A646A2A26F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 08:27:02 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c17so12479020edj.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 08:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wNGJip1HKswY03rIn0qBN8lLPIUP/zhuY/3XSL3+9g=;
        b=fD9i3S/OyqKgyk6wKHC5lzP9djQhREEu8RWPUcbxw52GfNQLvBWJQ2exlnhkwuoVnX
         ODkWJs+9ZWGaBloc8GriItGzcaI9kv3Z/q+2DI/CJMYugkcY1zWshHDkRo0S4P/RZYbW
         wf5B8rZVQ/HWB8udR2tLK/r+3aLCWsd7vxNQkvMgtI7i9LORQdAYFj9cIBg3e1NGVMk1
         iaOU3W7MHb4WyYmeLs33v5BVQAtHv3yXz+7Qza0Jv3nJIIuSTckNPxetmLdAxjpqMStb
         odVj/IxjrwRsJ4/7ouN/+kIuqnSl2MD5eoPuVC15uX55/xRRlu+SGTdO40R7hXK46DKV
         adyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wNGJip1HKswY03rIn0qBN8lLPIUP/zhuY/3XSL3+9g=;
        b=h/Bcf5mjgNwnYbyD/Ws7Jnkwt7yxQw6Y6Dq3/A1dtRUO1UXR3Z7HroM0qRK4f4BeSe
         4vJ31fzWJdrGp5wRY7KyHfRyf/WRMhitQL4PqOxZlz3f1p0IfEpAudYsIFjkIKvKtal8
         f8G0fZY6gHC8vDSREdN6eVp5C8WBaacHTV+2byKXskuStKZae/5JQNFUjjMOjyV5IY0O
         k+uV2jcgIXtiZPUdGUBTAAR9mvhAZ+MkXr6pw5rdUmDrp3tETPUQ16mK10eTSCftHtRx
         t9kSQPSpI1MkgZzwh/9PxVMFPkxWbE5Z7VM3K8l6iKivm7AayMil5z8SD3ysgxlefkTJ
         U1YQ==
X-Gm-Message-State: ANoB5pkzVxe3VtM8gI6JRz6+iphz6kWBR/FlN38QbebLOnkFvYflYkp2
        S5imacHIKpYW/nTcndPuz1UhxA==
X-Google-Smtp-Source: AA0mqf5O5cZ8jGnB/77uzy3JBRtagKZAZO2TV80r76TGZfG4XbsIH3Cz4RphZQYm70T/1MMOHro6Lw==
X-Received: by 2002:a50:c314:0:b0:46c:4850:a192 with SMTP id a20-20020a50c314000000b0046c4850a192mr15141650edb.65.1670344021185;
        Tue, 06 Dec 2022 08:27:01 -0800 (PST)
Received: from mbp-di-paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id d18-20020a50fb12000000b004588ef795easm1164055edq.34.2022.12.06.08.27.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 08:27:00 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V7 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <5f8aa1f6-c0d1-d6b9-f01d-f9a65cdeadb6@opensource.wdc.com>
Date:   Tue, 6 Dec 2022 17:26:59 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Glen Valante <glen.valante@linaro.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <50017876-ED45-44E7-A2F9-90BB8178D129@linaro.org>
References: <20221206081551.28257-1-paolo.valente@linaro.org>
 <20221206081551.28257-2-paolo.valente@linaro.org>
 <5f8aa1f6-c0d1-d6b9-f01d-f9a65cdeadb6@opensource.wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 6 dic 2022, alle ore 09:53, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>=20
> [...]
>> 	return bfqg;
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 7ea427817f7f..127aeecaf903 100644
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
>=20
> See below. But here, you could add:
>=20
> 	if (!bic)
> 		return NULL;
>=20
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
> You could return NULL in bic_to_bfqq() if bic is NULL. That would =
avoid
> this cludge.

Actually, this would improve code here, but it would entail the above
(useless) control for all the other invocations :(

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
>=20
> Given that you repeat this pattern a lot, might be worth having a =
wrapper
> like:
>=20
> static inline struct bfq_queue *bio_to_bfqq(struct bfq_io_cq *bic,
> 					    struct bio *bio)
> {
> 	return bic_to_bfqq(bic, op_is_sync(bio->bi_opf),
> 			   bfq_actuator_index(bfqd, bio));
> }
>=20
> The code would be less verbose while still being clear.

Actually this (exact) pattern is used only twice.  I'm thinking of
some more general wrapper, but each different combination seems to
have its own extra cost.  Any suggestion is more than welcome.
Meanwhile, I'll send a V8 to keep this going.

As usual, in my V8 I'll apply all of your other suggestions.

Thanks,
Paolo

[...]=
