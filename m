Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04377643E13
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiLFIGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiLFIGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:06:21 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D478E1A239
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:06:19 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id x22so4200371ejs.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 00:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WREkliTy5mKN95PO7CCRKu7uAiwzQByQOjsmLLqGSUk=;
        b=FcYIfA4oDY0Xrp9+BVodN0TnxnoeZNMiucN64P+B71Dwa+8z7/KdULapBL8xlVEyJj
         FVyAI6QqTsCQN5+kU/HcQGVfiS2i0y68CGlWYvlj+dixJBFnPwTB9tivISc9FhgYrAU3
         cra9hdDGN/7Mm+6BfUWpBGBzFsg6tTXtymbiCuuXLwPcuNoPir0zMf6VppjEZdYqkPAV
         1f+qwT26AM81FdxrPBsiAuqRm5YsOTQf4+Z//A+hBLjZWkHwh6R8gQc6L5T4nZN63Brg
         2Gsjn6iulp5XblFZ/rEsOy/YhDHicfpVYrsgGDZ7kRKFFd/jE5D8TPAHLjb/eRhjIkXj
         eXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WREkliTy5mKN95PO7CCRKu7uAiwzQByQOjsmLLqGSUk=;
        b=B1E+uRP3m0RaLIELKxDFbRdZvnuhCQYLrzTzwqZYRGBBw/p70n7j+nEes4zbkCKWXW
         QJgOUq6w/ljgmK5atkFuHhXdxOoHkkAzqSqtOPjNhHaTSokL+2QwBy3WVtNR1UFKWDaa
         KXL08cPFtM+KQ3oNAxm++Mg5jEQJf3vy/u/843G12oaAM0HnaVEjwoJtBLifUb9KJ0Uy
         KNxpAFkgKs1WNDhs1EAcjwlRlmlaqvGDBMaXnv/6PCad+Cd0dtJ+GjNsb7CBWA8lEwvL
         +lQbIiVdAJcu2wgvMjrQBZK2XN2lNRynkU4baOboftymKIDDPUtq6mg9Ggjc3DWsGYYz
         FRgg==
X-Gm-Message-State: ANoB5pnOzJ1rPBgvatAZFZ8ZFg3j5gaV43wZPY8HEVGnSHUF5o4IgJ2/
        638PbnqF4sS+2mP6+TqGQ5CfCQ==
X-Google-Smtp-Source: AA0mqf73JHOqGpDUGg53WdcvLu5gaWuskxVybe/qoyzm5gAWoEgUzmCFA+XztP0plDSe8ha2gmOHiw==
X-Received: by 2002:a17:906:7b96:b0:7c1:bb5:f29c with SMTP id s22-20020a1709067b9600b007c10bb5f29cmr1221263ejo.58.1670313978383;
        Tue, 06 Dec 2022 00:06:18 -0800 (PST)
Received: from mbp-di-paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id vs19-20020a170907139300b007bee745759bsm7084366ejb.20.2022.12.06.00.06.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:06:18 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V6 6/8] block, bfq: retrieve independent access ranges
 from request queue
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <5d062001-2fff-35e5-d951-a61b510727d9@opensource.wdc.com>
Date:   Tue, 6 Dec 2022 09:06:17 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, arie.vanderhoeven@seagate.com,
        rory.c.chen@seagate.com, Federico Gavioli <f.gavioli97@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C45BCC6-D9AB-4C70-92E2-1B54AB4A2090@linaro.org>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-7-paolo.valente@linaro.org>
 <5d062001-2fff-35e5-d951-a61b510727d9@opensource.wdc.com>
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



> Il giorno 21 nov 2022, alle ore 02:01, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>=20

...

>=20
>> }
>>=20
>> static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
>> @@ -7144,6 +7159,8 @@ static int bfq_init_queue(struct request_queue =
*q, struct elevator_type *e)
>> {
>> 	struct bfq_data *bfqd;
>> 	struct elevator_queue *eq;
>> +	unsigned int i;
>> +	struct blk_independent_access_ranges *ia_ranges =3D =
q->disk->ia_ranges;
>>=20
>> 	eq =3D elevator_alloc(q, e);
>> 	if (!eq)
>> @@ -7187,10 +7204,31 @@ static int bfq_init_queue(struct =
request_queue *q, struct elevator_type *e)
>> 	bfqd->queue =3D q;
>>=20
>> 	/*
>> -	 * Multi-actuator support not complete yet, default to single
>> -	 * actuator for the moment.
>> +	 * If the disk supports multiple actuators, we copy the =
independent
>> +	 * access ranges from the request queue structure.
>> 	 */
>> -	bfqd->num_actuators =3D 1;
>> +	spin_lock_irq(&q->queue_lock);
>> +	if (ia_ranges) {
>> +		/*
>> +		 * Check if the disk ia_ranges size exceeds the current =
bfq
>> +		 * actuator limit.
>> +		 */
>> +		if (ia_ranges->nr_ia_ranges > BFQ_MAX_ACTUATORS) {
>> +			pr_crit("nr_ia_ranges higher than act limit: =
iars=3D%d, max=3D%d.\n",
>> +				ia_ranges->nr_ia_ranges, =
BFQ_MAX_ACTUATORS);
>> +			pr_crit("Falling back to single actuator =
mode.\n");
>> +			bfqd->num_actuators =3D 0;
>> +		} else {
>> +			bfqd->num_actuators =3D ia_ranges->nr_ia_ranges;
>> +
>> +			for (i =3D 0; i < bfqd->num_actuators; i++)
>> +				bfqd->ia_ranges[i] =3D =
ia_ranges->ia_range[i];
>> +		}
>> +	} else {
>> +		bfqd->num_actuators =3D 0;
>=20
> That is very weird. The default should be 1 actuator.
> ia_ranges->nr_ia_ranges is 0 when the disk does not provide any range
> information, meaning it is a regular disk with a single actuator.

Actually, IIUC this assignment to 0 seems to be done exactly when you
say that it should be done, i.e., when the disk does not provide any
range information (ia_ranges is NULL). Am I missing something else?

Once again, all other suggestions applied. I'm about to submit a V7.

Thanks,
Paolo

