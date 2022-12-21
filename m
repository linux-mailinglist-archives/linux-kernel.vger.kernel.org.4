Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C03652F85
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbiLUKcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiLUKam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:30:42 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3EE83
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 02:30:39 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id vv4so35806891ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 02:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjvJRQIdCdV8yoJ43xfdfjH/MiEQ7j354lDaOzKqIs0=;
        b=IjfAOC6tCgGjsFhMyJghmv6WwLaHCfdYPbrupetldsJgQrxHRbw78h4wOlxrpaBCif
         FTx5gODrnqh8avB0XW5lzJJX2ic7ypHCu7BBRMOJbn4zWeWoaP4s9nDBqHv/V3J8CHMC
         ybk991vV5sGjWkUS4uO0H9+ChrIt/BQ2OMosnZwoLCQAU5txFR0HYsJLVBEhBiL2+9QM
         a6aMJxTBOq4FL0UX5AwpRjsnN2wFlHFAK4J40XS9rUSEM4R+25VW9M/9gDpGwh3Uf8es
         5tWq6hn40GirDmCjrt++hYkD27gM0kK9r4lP95oB9/ZphtKO0EzDvBaPrxA/6ZtSlCEP
         yBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjvJRQIdCdV8yoJ43xfdfjH/MiEQ7j354lDaOzKqIs0=;
        b=yEoZF+AVOiune9ODZuxR1/F0YsPw5+RLdnzop9hQJmH1VxtevXj2DGCHXB2N7O2xba
         YNT5PVuqOQU6koa8HFoWCePtl9o+rkASMO9AT7Z6HE0is+nxsm4C+DuoJ3kOw2Fsf3yV
         BnEjHTF4YkKYpZ12n/+Vh8KKelDrHCP/IRXCk/ojH74A1Kiu+trJH/703VlN6pHXkugn
         X+YWkGPdRXDnB0nwpZmx6iADmVQE/P4ecWkCaMI+PjfDB+w/9BE9HcrXQHPVEMzqpADc
         0NAwGdb2zyhKEiPQRGqGb60SD48yJw3RuoGKUJgH8hv/Ifu1cBkcEE1gp1psxd+MebPS
         0rqw==
X-Gm-Message-State: AFqh2kqRRcF4Q2VyZHmaVB69OXNDLZNOqyebit3b8j5S5f1d142fi1oG
        JQ0184ORkileBcKyhAkUwLW5kA==
X-Google-Smtp-Source: AMrXdXsydh44E6pcwFbWHFitspGVthr1eKSul48dqf8/CcezZNU1z2AoIdqOmymRoNdyLgq5X47I9A==
X-Received: by 2002:a17:906:8447:b0:7c8:9f04:ae7e with SMTP id e7-20020a170906844700b007c89f04ae7emr4278221ejy.22.1671618637560;
        Wed, 21 Dec 2022 02:30:37 -0800 (PST)
Received: from mbp-di-paolo.station (net-93-70-85-0.cust.vodafonedsl.it. [93.70.85.0])
        by smtp.gmail.com with ESMTPSA id g25-20020a170906539900b00738795e7d9bsm6919482ejo.2.2022.12.21.02.30.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Dec 2022 02:30:37 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V10 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <3E955C95-3912-46D0-A48C-9709F094FD0D@linaro.org>
Date:   Wed, 21 Dec 2022 11:30:35 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Glen Valante <glen.valante@linaro.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <918DD21A-0099-4EF9-955B-CAED2A3F8947@linaro.org>
References: <20221209094442.36896-1-paolo.valente@linaro.org>
 <20221209094442.36896-2-paolo.valente@linaro.org>
 <cd41583b-ef11-a3b7-1e39-c4a224050c7d@opensource.wdc.com>
 <60582F89-8020-4468-80FE-BC52202D1129@linaro.org>
 <eb58939f-567e-c0c1-bafb-383f18f3d58e@opensource.wdc.com>
 <3E955C95-3912-46D0-A48C-9709F094FD0D@linaro.org>
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



> Il giorno 21 dic 2022, alle ore 11:13, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 21 dic 2022, alle ore 01:50, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>>=20
>> On 2022/12/20 22:10, Paolo Valente wrote:
>>>>> -	/*
>>>>> -	 * Does queue (or any parent entity) exceed number of requests =
that
>>>>> -	 * should be available to it? Heavily limit depth so that it =
cannot
>>>>> -	 * consume more available requests and thus starve other =
entities.
>>>>> -	 */
>>>>> -	if (bfqq && bfqq_request_over_limit(bfqq, limit))
>>>>> -		depth =3D 1;
>>>>> +	for (act_idx =3D 0; act_idx < bfqd->num_actuators; act_idx++) {
>>>>> +		struct bfq_queue *bfqq =3D
>>>>> +			bic ? bic_to_bfqq(bic, op_is_sync(opf), act_idx) =
: NULL;
>>>>=20
>>>> Commented already: why not add a "if (!bfqq) return NULL;" in
>>>> bic_to_bfqq() ?
>>>=20
>>> You have probably missed my reply on this.  The problem is that your
>>> proposal would improve code (only) here, but it would entail the =
above
>>> control for all the other invocations, for which it is useless :(
>>=20
>> But then you have *a lot* of "if (bfqd)" tests that are useless =
elsewhere since
>> bic_to_bfqq() never returns NULL.
>>=20
>=20
> I'm probably misunderstanding your point, sorry.  Could you point me
> to one of the places where there is the useless control that would go
> away if we add your proposed control inside bic_to_bfqq?

You had already done that in a following email, sorry.  I have replied
to that email of yours.

Thanks,
Paolo

