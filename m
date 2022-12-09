Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5158D64803F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLIJkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLIJkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:40:42 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA373537CE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:40:39 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gh17so10199438ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 01:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKKLCBzLV8/46B+QgkzgYyULA0ZCO/PFX9LWayGP/FA=;
        b=c+lvXxGrRJc2H+S2Lis4tyDqevkpQZr6osuTT7i245BKBT0JQjdgy+Byy2obnWWZpM
         ricTRLwZV71ZTgwA0ZXZ1pZnHRrtgA+uruncx4YyMYOKHEX8Fg3HGsXczNUKvanbP37G
         Grb3acFtI/+A8M6SzlNqASbrIXQ/QuyxS9rc9KeWPODETABVJP+VFG1NdBkbhnV650v2
         MVI5Q81oHaUDi8hqcyuh+2gNjys9A1u219rzbGEkmHgDg9gzbaSp4v4U5Z5yaspTWM4E
         UeFZ8Z3r7V9ytr6vhnxqdJRfaXEyLKqnGbH2kBCWZBx+oMbxUUY5ZpiOnpX711Xq7BBf
         Cxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKKLCBzLV8/46B+QgkzgYyULA0ZCO/PFX9LWayGP/FA=;
        b=cLbQN17bEF31znL6hVMe8sZ+rw7hra/YkyNCNXiJxFSCTJ88f2s/zsWFwd+GV7OQcI
         fb4w1VjMi+YdZZ2p45cX7ZPAmiZdzV1QPnxY/WM7enNmP4QD67dUi6lMxV3DgJF4R7+A
         d6YObCB4P9P5sGnHrmxP0wp+MfODB0Wkx/E+IZYWJRGkerl5EH0bb4M4xaRIpyfyPOee
         TXl8yCCvdxXW/LecfwUeKGaApqAMwzzJCGU04A0YjbIUQdXQhH7c4SZIAJuFBdcGfpkL
         FRX5bkK0p3vVrYx/0J+4a58/VmU8393xy2MBZN8phTopssYm+6AmR53Vfy3290CaqBOg
         Xbtw==
X-Gm-Message-State: ANoB5plVRV8C3nW23MV6ocB3oY3Tu6qG2yFmqhxE54ETN8GJQ3wsH57F
        sF6tNgsPyUVcE3iB5AkUmkt/jg==
X-Google-Smtp-Source: AA0mqf6EI9XikAHq5TezGX9KT5vIUxGEjx/Gk21eI7m7wrsKkUCQnOpiXSVZaDM27TMo0cJLNd9GaA==
X-Received: by 2002:a17:906:79d8:b0:7bd:6372:fdb4 with SMTP id m24-20020a17090679d800b007bd6372fdb4mr6764320ejo.41.1670578838442;
        Fri, 09 Dec 2022 01:40:38 -0800 (PST)
Received: from mbp-di-paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id a15-20020a056402168f00b004642b35f89esm192957edv.9.2022.12.09.01.40.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2022 01:40:37 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V9 7/8] block, bfq: inject I/O to underutilized actuators
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <2678a347-188a-1f2a-27ec-67e7caa38175@opensource.wdc.com>
Date:   Fri, 9 Dec 2022 10:40:36 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Glen Valante <glen.valante@linaro.org>,
        Davide Zini <davidezini2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC3919CC-437C-46E9-A399-C4C2B5C16792@linaro.org>
References: <20221208104351.35038-1-paolo.valente@linaro.org>
 <20221208104351.35038-8-paolo.valente@linaro.org>
 <2678a347-188a-1f2a-27ec-67e7caa38175@opensource.wdc.com>
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



> Il giorno 9 dic 2022, alle ore 02:46, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>=20
> On 12/8/22 19:43, Paolo Valente wrote:
>> From: Davide Zini <davidezini2@gmail.com>
>>=20
>> The main service scheme of BFQ for sync I/O is serving one sync
>> bfq_queue at a time, for a while. In particular, BFQ enforces this
>> scheme when it deems the latter necessary to boost throughput or
>> to preserve service guarantees. Unfortunately, when BFQ enforces
>> this policy, only one actuator at a time gets served for a while,
>> because each bfq_queue contains I/O only for one actuator. The
>> other actuators may remain underutilized.
>>=20
>> Actually, BFQ may serve (inject) extra I/O, taken from other
>> bfq_queues, in parallel with that of the in-service queue. This
>> injection mechanism may provide the ground for dealing also with
>> the above actuator-underutilization problem. Yet BFQ does not take
>> the actuator load into account when choosing which queue to pick
>> extra I/O from. In addition, BFQ may happen to inject extra I/O
>> only when the in-service queue is temporarily empty.
>>=20
>> In view of these facts, this commit extends the
>> injection mechanism in such a way that the latter:
>> (1) takes into account also the actuator load;
>> (2) checks such a load on each dispatch, and injects I/O for an
>>    underutilized actuator, if there is one and there is I/O for it.
>>=20
>> To perform the check in (2), this commit introduces a load
>> threshold, currently set to 4.  A linear scan of each actuator is
>> performed, until an actuator is found for which the following two
>> conditions hold: the load of the actuator is below the threshold,
>> and there is at least one non-in-service queue that contains I/O
>> for that actuator. If such a pair (actuator, queue) is found, then
>> the head request of that queue is returned for dispatch, instead
>> of the head request of the in-service queue.
>>=20
>> We have set the threshold, empirically, to the minimum possible
>> value for which an actuator is fully utilized, or close to be
>> fully utilized. By doing so, injected I/O 'steals' as few
>> drive-queue slots as possibile to the in-service queue. This
>> reduces as much as possible the probability that the service of
>> I/O from the in-service bfq_queue gets delayed because of slot
>> exhaustion, i.e., because all the slots of the drive queue are
>> filled with I/O injected from other queues (NCQ provides for 32
>> slots).
>>=20
>> This new mechanism also counters actuator underutilization in the
>> case of asymmetric configurations of bfq_queues. Namely if there
>> are few bfq_queues containing I/O for some actuators and many
>> bfq_queues containing I/O for other actuators. Or if the
>> bfq_queues containing I/O for some actuators have lower weights
>> than the other bfq_queues.
>>=20
>> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>> Signed-off-by: Davide Zini <davidezini2@gmail.com>
>=20
> [...]
>=20
>> @@ -4792,22 +4799,69 @@ bfq_choose_bfqq_for_injection(struct bfq_data =
*bfqd)
>> 			else
>> 				limit =3D in_serv_bfqq->inject_limit;
>>=20
>> -			if (bfqd->rq_in_driver < limit) {
>> +			if (bfqd->tot_rq_in_driver < limit) {
>> 				bfqd->rqs_injected =3D true;
>> 				return bfqq;
>> 			}
>> 		}
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static struct bfq_queue *
>> +bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd, int idx)
>> +{
>> +	struct bfq_queue *bfqq =3D NULL;
>=20
> I do not think that you need the NULL initialization here.
>=20
>> +
>> +	if (bfqd->in_service_queue &&
>> +	    bfqd->in_service_queue->actuator_idx =3D=3D idx)
>> +		return bfqd->in_service_queue;
>> +
>> +	list_for_each_entry(bfqq, &bfqd->active_list[idx], bfqq_list) {
>> +		if (!RB_EMPTY_ROOT(&bfqq->sort_list) &&
>> +			bfq_serv_to_charge(bfqq->next_rq, bfqq) <=3D
>> +				bfq_bfqq_budget_left(bfqq)) {
>> +			return bfqq;
>> +		}
>> +	}
>>=20
>> 	return NULL;
>> }
>=20
> Otherwise looks OK.
>=20
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Hi Damien,
I've applied your recommendations in this and the other replies of
yours.  I'm about to send a V10.

Thank you very much for checking this code and helping me improve it,
Paolo

>=20
> --=20
> Damien Le Moal
> Western Digital Research

