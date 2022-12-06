Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE64643DF6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiLFIAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiLFIAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:00:30 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD4217583
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:00:28 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i15so10955077edf.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 00:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep5DwQubDegymOyENqeDtmNucgK1obqpX2IeGsm5/9E=;
        b=G/PhRItAnRXVFsLh+fcpOARTY6iJ2HnFhVRKBx0D0zeonK5sRBJa1RyGWLkd1By2XC
         +NkUwwyqBHUgpOmIM3VbsoOI+xuCh0R9wENHUlfxz12A+49E/zI+KxxoGjcAd7U4+1IK
         lpGaMfL8JCaN0LhCSTelxLQdKiJTzj9z2nEKMruIbZCEEwCwiN5lkaX2LmbjXhdQ8P0y
         BlxpulTpQiOFOD2iOxsEk+Rpe+xskhHlR2m+86fKHE/otTkEcMxee0yjeRaAHyDWhfs2
         k0HxEPZa+Qr0Fb5qek2/+Ool5sj4UNnz+7yvV5VzW95mHsazB4mleWWQMgR/NjOJGJlQ
         fSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ep5DwQubDegymOyENqeDtmNucgK1obqpX2IeGsm5/9E=;
        b=pXO0DT1ONlPIcuY4Lbn0SSIE4BNI+0F57a22lsq5nbsKakCKdlzvPTax4rmqF3ygVG
         JR0+szZYtFTLFRRPo68c208qrg1Qefv2GJ+0tXz3PZtmKL1nTLFhfDFDfX6z0iug4Q6e
         tIKVyhg0mtiF3MX9AoedETGdDUCgjOC+ufMgYk0YB2GCwtOYxBiEg1sn8OJgmSwTKVt+
         1CMdJ7/S6sgqDWV5hOm3JTHpDnTzFp7XHV5emhZuYOmRjSCAKx3PAdaRh79tCozZV/5A
         tzpgQt6Gn1/yTUbW8LHN7kKtXYWE0BSteyrArqSmhh2qT8j0mXT72Nz6Ve6E4Tom7FQT
         t8hw==
X-Gm-Message-State: ANoB5pkAjyOt27oDZttzo/tNksK44y4sUSkVoE/Bd7ToKTpLEZLE5aJK
        FfTaa6Ot930paxAsB7bSTPqr4A==
X-Google-Smtp-Source: AA0mqf5c6Hc1ac1Itcq09k7TTOKGYU1QiwkRuw3Vn378c8ftuGgeVyGWWdqI6tta0kV3ZnRJwBYsag==
X-Received: by 2002:a05:6402:4c2:b0:46c:d5a8:b0ac with SMTP id n2-20020a05640204c200b0046cd5a8b0acmr5294383edw.226.1670313626564;
        Tue, 06 Dec 2022 00:00:26 -0800 (PST)
Received: from mbp-di-paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id my48-20020a1709065a7000b007c0d64c1886sm3784586ejc.33.2022.12.06.00.00.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:00:26 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V6 4/8] block, bfq: turn bfqq_data into an array in
 bfq_io_cq
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <3ec70cff-f1bc-1a45-a4db-10bb1d0e6266@opensource.wdc.com>
Date:   Tue, 6 Dec 2022 09:00:22 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Gabriele Felici <felicigb@gmail.com>,
        Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9548A61A-7DEA-4FB2-85AE-0B75417B4B9E@linaro.org>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-5-paolo.valente@linaro.org>
 <3ec70cff-f1bc-1a45-a4db-10bb1d0e6266@opensource.wdc.com>
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



> Il giorno 21 nov 2022, alle ore 01:39, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
...
>>=20
>> 			bfqq =3D bfq_split_bfqq(bic, bfqq);
>> 			split =3D true;
>> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
>> index f2e8ab91951c..e27897d66a0f 100644
>> --- a/block/bfq-iosched.h
>> +++ b/block/bfq-iosched.h
>> @@ -416,7 +416,7 @@ struct bfq_queue {
>> struct bfq_iocq_bfqq_data {
>> 	/*
>> 	 * Snapshot of the has_short_time flag before merging; taken
>> -	 * to remember its value while the queue is merged, so as to
>> +	 * to remember its values while the queue is merged, so as to
>> 	 * be able to restore it in case of split.
>> 	 */
>> 	bool saved_has_short_ttime;
>> @@ -430,7 +430,7 @@ struct bfq_iocq_bfqq_data {
>> 	u64 saved_tot_idle_time;
>>=20
>> 	/*
>> -	 * Same purpose as the previous fields for the value of the
>> +	 * Same purpose as the previous fields for the values of the
>> 	 * field keeping the queue's belonging to a large burst
>> 	 */
>> 	bool saved_in_large_burst;
>> @@ -493,8 +493,12 @@ struct bfq_io_cq {
>> 	uint64_t blkcg_serial_nr; /* the current blkcg serial */
>> #endif
>>=20
>> -	/* persistent data for associated synchronous process queue */
>> -	struct bfq_iocq_bfqq_data bfqq_data;
>> +	/*
>> +	 * Persistent data for associated synchronous process queues
>> +	 * (one queue per actuator, see field bfqq above). In
>> +	 * particular, each of these queues may undergo a merge.
>> +	 */
>> +	struct bfq_iocq_bfqq_data bfqq_data[BFQ_MAX_ACTUATORS];
>=20
> I wonder if packing this together with struct bfq_queue would be =
cleaner.
> That would avoid the 2 arrays you have in this struct. Something like =
this:
>=20
> struct bfq_queue_data {
> 	struct bfq_queue 	*bfqq[2];
> 	struct bfq_iocq_bfqq_data iocq_data;
> }
>=20
> struct bfq_io_cq {
> 	...
> 	struct bfq_queue_data bfqqd[BFQ_MAX_ACTUATORS];
> 	...
> }
>=20
> Thinking aloud here. That may actually make the code more complicated.

I see your point, but, yes, this change would entail one more
indirection when accessing queues from io contexts.

Apart from this, I have applied all of your other suggestions here.

Thanks,
Paolo

>=20
>>=20
>> 	unsigned int requests;	/* Number of requests this process has =
in flight */
>> };
>=20
> --=20
> Damien Le Moal
> Western Digital Research

