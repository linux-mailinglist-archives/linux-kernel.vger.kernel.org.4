Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E432E65918C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 21:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiL2Ufe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 15:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiL2Ufb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 15:35:31 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF018165B2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:35:29 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id l29so21008216edj.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJ0vsxZ2j/mSTsParV8sg8HGss9ZN16HDZndrHxCm10=;
        b=aBWswfkIICpvY7s6aMwL0txlEgLYF1QYDq0EDHpuhnWEjz3tqGver/CSRR+7yDEQAn
         /OXmzEI2G5su1G+Q7j7ag/vEwzKCrVqhE+VtjBHW4RKcIA2JPMNLyEMJ0PNqtbn5zyut
         SkOf5M4pV0kZUEyEo/3/Vx3qKQxzBwqY/TEcGXMXHCyj0G4UKOCWOvBYnkjAAEo8nD+8
         BA8q26xIF1DjRA3zEpRf9fphrPyW2AXoGsZpQG3ZB77blW2UoeMoCEf8fboB3jgtIWn1
         kJbSWXHgbtqox4PwOw35Pl+iHeq+vQdgBbos0r1ldTax6DxODwRHj+GM0+aDnTb0OvxB
         Lulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJ0vsxZ2j/mSTsParV8sg8HGss9ZN16HDZndrHxCm10=;
        b=uy+Q1My2ldW4A81LJ5882w/ALHZqSMJlboVgp0Ujly53I8k5qrFuzB/h/iS71aR2uA
         jzAgcHfXkxq636ZibZkL9g/MZBK/bRtkzGNW4Ht/M6zKkyuczYicifj1F30W3S4Y8NRV
         PKdZwB5FQgeBUeXYwGaWAWeKA+5v57O3AD233TZpXUJh/ioa5SjpDsXLKsQ9vqSLJMHs
         snr2gpyF11Ui1GH4wuCtWyXVIDH06Ty35mrcKZv2w4Z6eZHaHY5vdvHfeIz3dSEYz5Sd
         oQLT4vlMNBGfthD3nBGyqksYDSfKMmdCjO0T/v91CfkGKFD8+vtlZCjV89UPCN2IMenS
         q8qQ==
X-Gm-Message-State: AFqh2kqXG7zhM2YphnpY40s7o0KD0hmViIY16BHVkX26P5X4CeVb7xHX
        MS0nbuPYWdzi6DuvGnQgPtOSuv2nwo/ID1SK
X-Google-Smtp-Source: AMrXdXuX0GUa4pypP1LFdinIBu7VI+0fQmOuYTZp/Gg9kJia8gz23qAWpO5P9mvZetYDZ4EPHXHknw==
X-Received: by 2002:a05:6402:4006:b0:479:1fab:430f with SMTP id d6-20020a056402400600b004791fab430fmr25756343eda.39.1672346128153;
        Thu, 29 Dec 2022 12:35:28 -0800 (PST)
Received: from [192.168.100.233] (mob-109-118-160-216.net.vodafone.it. [109.118.160.216])
        by smtp.gmail.com with ESMTPSA id cw14-20020a056402228e00b00463bc1ddc76sm8537766edb.28.2022.12.29.12.35.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Dec 2022 12:35:27 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V12 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <71738b57-ecd0-f95c-9c42-b7686c3232b6@opensource.wdc.com>
Date:   Thu, 29 Dec 2022 21:35:24 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Glen Valante <glen.valante@linaro.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4E630E41-A744-4264-85C8-4A7D226A9F1C@linaro.org>
References: <20221222152157.61789-1-paolo.valente@linaro.org>
 <20221222152157.61789-2-paolo.valente@linaro.org>
 <71738b57-ecd0-f95c-9c42-b7686c3232b6@opensource.wdc.com>
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



> Il giorno 27 dic 2022, alle ore 02:37, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>=20
> On 12/23/22 00:21, Paolo Valente wrote:
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
>=20
> One styles nit below.
>=20
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>=20
>> @@ -690,14 +700,25 @@ static void bfq_limit_depth(blk_opf_t opf, =
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
>> +		struct bfq_queue *bfqq;
>> +
>> +		if (bic)
>> +			bfqq =3D bic_to_bfqq(bic, op_is_sync(opf), =
act_idx);
>> +		else
>> +			break;
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
>=20
> You could reverse the if condition to make this cleaner, or even =
better,
> include the bic test in the for loop:
>=20
> for (act_idx =3D 0; bic && act_idx < bfqd->num_actuators; act_idx++) {
> 	struct bfq_queue *bfqq;
>=20
> 	/*
> 	 * Does queue (or any parent entity) exceed number of
> 	 * requests that should be available to it? Heavily
> 	 * limit depth so that it cannot consume more
> 	 * available requests and thus starve other entities.
> 	 */
> 	bfqq =3D bic_to_bfqq(bic, op_is_sync(opf), act_idx);
> 	if (bfqq && bfqq_request_over_limit(bfqq, limit)) {
> 		depth =3D 1;
> 		break;
> 	}
> }
>=20

Done, thanks for this improvement.

Sending a V13, with all patches tagged as reviewed.

Thanks,
Paolo

>=20
> --=20
> Damien Le Moal
> Western Digital Research

