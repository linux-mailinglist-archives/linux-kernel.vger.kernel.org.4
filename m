Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF4C643E09
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiLFIEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiLFIEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:04:50 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF3F18352
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:04:48 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id gh17so4238967ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 00:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHwTX8uUU8wyVwOtLeOordYupKzPY3lgNz4rBQLwQcw=;
        b=WOWC3EhjrE2daVz0rtjp6qGuCK1OI/pdZYCfKao3Q+gKPArwVUzl6fClo/33jwSPTG
         XTKG4NoXXT2rK7orvGeSA0xCiOhSxSgABexR55+iJfEXp3HCN7bBEk7OWvOUlif6qyIG
         Z0XL451AJ455HgraXKnEisqOmGhccx4VPxLYMorw7HXBGIbHDNQmU+XyGXwq1PKvrUgH
         zpUPn+yj1G7IhoCEsTlm8hwaTW0Ne+MVmXdH+VxpVBBBkZP7Zs/SS7zYqpYLPGyny/Ve
         YE093oGE1ZdyyepjrN1aSnOT0K/WV7DFzP1aALZI6uNvphsXQxz7Kfz++mdSuiYvWKvP
         yDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHwTX8uUU8wyVwOtLeOordYupKzPY3lgNz4rBQLwQcw=;
        b=fmCH5fe+gccXKyL3c9cUuJHm9cjhhusBEzNBZtkl26hUa3hx4C7YGwblN+AVDUmiw4
         bfZ5EdRtThjMV0uClUd6n03SJ9z8DnWEcDw+h3VWmDWa1fSsSA676Bus5Ai0KoUm4Cbr
         T7m6J2my2JzvQebc0IUKB1ZGq7D4gA19lrhuPBF5ZVBo4xTrD63ws36n7sDfeq9LK8YP
         qMaEouViICHRBrFXBRqoOWvb9o29VS9YlnXwvICZwAUFRXVmIitZ9+INIQIT9zpW3rLY
         x5j/QnKqLb+9K2Im3OvguBGKld3wpkvYPVM5ZiAwWy50ghDY+Ez7A2ZB84oJ4MvZkAPF
         V2Gw==
X-Gm-Message-State: ANoB5plThW4ChI+2KkzBVrKjhVQEbp3i3CXeVXYyPtHUAXaHH5xXhZq1
        iv33HBH87AXjVCZGhoskpjI9pA==
X-Google-Smtp-Source: AA0mqf5eKOUcnsRQb5eI/O/2xwha/y658G5r2OQrayi3ABflIJ+lFtMCMagIuT9Ab9VKoPmuLcDj2A==
X-Received: by 2002:a17:906:ce2b:b0:7c0:cc7e:c783 with SMTP id sd11-20020a170906ce2b00b007c0cc7ec783mr12875736ejb.133.1670313886945;
        Tue, 06 Dec 2022 00:04:46 -0800 (PST)
Received: from mbp-di-paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id k11-20020a17090632cb00b007c0b6e1c7fdsm5633665ejk.104.2022.12.06.00.04.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:04:46 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V6 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <14cea0aa-2f0b-117a-4568-c80ca0513eec@opensource.wdc.com>
Date:   Tue, 6 Dec 2022 09:04:45 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EEFE8587-7834-4686-B3C3-E2375668E680@linaro.org>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-2-paolo.valente@linaro.org>
 <14cea0aa-2f0b-117a-4568-c80ca0513eec@opensource.wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Il giorno 21 nov 2022, alle ore 01:18, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
...

> That said, creating 2 helpers
> bic_to_async_bfqq() and bic_to_sync_bfqq() without that second =
argument
> would make the code more readable and less error prone I think.
>=20

I'm not sure yet about this, because, in some other place, the function =
is invoked like this

bic_to_bfqq(bic, is_sync, act_idx);

where is_sync is a bool.  With your proposal, we would lose the
wrapper and have to turn the above line into an if/else. =20

So, if ok for you, I'd leave this further change for a second time, as
it is somehow unrelated with the main goal of this patch.


...

>>=20
>> 	if (bfqq && bic->stable_merge_bfqq =3D=3D bfqq) {
>> 		/*
>> @@ -672,9 +677,9 @@ static void bfq_limit_depth(blk_opf_t opf, struct =
blk_mq_alloc_data *data)
>> {
>> 	struct bfq_data *bfqd =3D data->q->elevator->elevator_data;
>> 	struct bfq_io_cq *bic =3D bfq_bic_lookup(data->q);
>> -	struct bfq_queue *bfqq =3D bic ? bic_to_bfqq(bic, =
op_is_sync(opf)) : NULL;
>=20
> Given that you are repeating this same pattern many times, the test =
for
> bic !=3D NULL should go into the bic_to_bfqq() helper.

Actually, this would improve code here, but it would entail a useless =
control
for all the other invocations :(

As for your other replies, I have applied all the other suggestions in
this reply of yours.

Thanks,
Paolo


