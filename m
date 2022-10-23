Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F5860971C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 00:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJWWpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 18:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJWWpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 18:45:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1D746630;
        Sun, 23 Oct 2022 15:45:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j15so2884200wrq.3;
        Sun, 23 Oct 2022 15:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
         :subject:cc:to:from:references:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHu5lMeuagF1RCqmN7A4QnSItxym5xxnI6GF6yli2JA=;
        b=jeG+qE9fQq7upkBLV6xyHggWaHf4jrf7fl1eLreyiWyUnsZwHwfenLFvR/ja4Ewq+T
         3U1Sys4lH6HFLMMk7xi+iL5mGo57TEGmFmQKPZ10ftP3twjC2zkzuB7R/e3tpqHgiAFn
         5JZiRJ/InY/5OOq3vCTAHdv+p221YLANe3KLvvczeO8JcD/x1RnaN3EuxQMoth1OZyQI
         qMeifA1aRAX8bGnY3KalX2qyJPRgywiHVW82jD3iFJ8BEnd7kyA9lZf8A4D49WDgRrus
         309tQDXLqJuE8mHW7Nm1+0C4Gu1tkO83Cyg+bQzW5CiYmetVk2TJBvsOJ+1gW04CaH9B
         FCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
         :subject:cc:to:from:references:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LHu5lMeuagF1RCqmN7A4QnSItxym5xxnI6GF6yli2JA=;
        b=WizC2PyISMA0TXY1xDdelCWAHGFZEPtq0CtmizxOvKZi7HubumkjZVikPFkJ65jKXQ
         i3bb5Z9SnG/x2fkoeW4Z8zSXXJx7Lbct4tcuH8I/lROiFkLtaIHgY0xeA8rc94QgYdTL
         vQTMDB2cgFr1BgM3K/wHqMbvrRBibnmAlBuEfj5guQ7+aRjkkqOvolZ/Cd3yKG6KoirW
         GATOpcUKWabDtWCVScjCEOcimzxlQ1SmyEDfcLjZ/QAcsg79Q3zUoDJGHmr0h3uWnSPk
         6K1narSE8JD0yIoxNvgtoZl+np59S2VJwtX0eRADHfY21OW94+UBZUruL+3qkK5LennY
         U55Q==
X-Gm-Message-State: ACrzQf0eCQHxAbdqU3S4tMLv1Vn5YcsL1NdeAf+6t+5E4hEVxmRBOp8W
        DuSXS3sxzzyxreJUY9zlOAk=
X-Google-Smtp-Source: AMsMyM7xwMl57ho7nBPWI6OP/1BjwzSS2Cab9FPh3Wn9b1pmtcuIBEXJWsGJT3frmoCpa1rgMfmFDQ==
X-Received: by 2002:a5d:4484:0:b0:236:574f:2536 with SMTP id j4-20020a5d4484000000b00236574f2536mr8613315wrq.7.1666565130213;
        Sun, 23 Oct 2022 15:45:30 -0700 (PDT)
Received: from localhost (188.28.3.213.threembb.co.uk. [188.28.3.213])
        by smtp.gmail.com with ESMTPSA id bj19-20020a0560001e1300b002238ea5750csm9257365wrb.72.2022.10.23.15.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 15:45:29 -0700 (PDT)
References: <20221023145653.177234-1-aidanmacdonald.0x0@gmail.com>
 <20221023145653.177234-2-aidanmacdonald.0x0@gmail.com>
 <TAP7KR.18SEZOBW3THM2@crapouillou.net>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, zhouyu@wanyeetech.com,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] clk: ingenic: Make PLL clock "od" field optional
In-reply-to: <TAP7KR.18SEZOBW3THM2@crapouillou.net>
Date:   Sun, 23 Oct 2022 23:45:28 +0100
Message-ID: <FdF2cloQKfcDjZeA3AGn61Yfkecl2tgV@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul Cercueil <paul@crapouillou.net> writes:

> Hi Aidan,
>
> Le dim. 23 oct. 2022 =C3=A0 15:56:49 +0100, Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
>> Add support for defining PLL clocks with od_bits =3D 0, meaning that
>> OD is fixed to 1 and there is no OD field in the register.
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>>  drivers/clk/ingenic/cgu.c | 28 +++++++++++++++++++---------
>>  drivers/clk/ingenic/cgu.h |  3 ++-
>>  2 files changed, 21 insertions(+), 10 deletions(-)
>> diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
>> index 861c50d6cb24..7dc2e2567d53 100644
>> --- a/drivers/clk/ingenic/cgu.c
>> +++ b/drivers/clk/ingenic/cgu.c
>> @@ -96,8 +96,11 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned l=
ong
>> parent_rate)
>>  	m +=3D pll_info->m_offset;
>>  	n =3D (ctl >> pll_info->n_shift) & GENMASK(pll_info->n_bits - 1, 0);
>>  	n +=3D pll_info->n_offset;
>> -	od_enc =3D ctl >> pll_info->od_shift;
>> -	od_enc &=3D GENMASK(pll_info->od_bits - 1, 0);
>> +
>> +	if (pll_info->od_bits > 0) {
>> +		od_enc =3D ctl >> pll_info->od_shift;
>> +		od_enc &=3D GENMASK(pll_info->od_bits - 1, 0);
>> +	}
>>  	if (pll_info->bypass_bit >=3D 0) {
>>  		ctl =3D readl(cgu->base + pll_info->bypass_reg);
>> @@ -108,12 +111,17 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned
>> long parent_rate)
>>  			return parent_rate;
>>  	}
>> -	for (od =3D 0; od < pll_info->od_max; od++) {
>> -		if (pll_info->od_encoding[od] =3D=3D od_enc)
>> -			break;
>> +	if (pll_info->od_bits > 0) {
>> +		for (od =3D 0; od < pll_info->od_max; od++) {
>> +			if (pll_info->od_encoding[od] =3D=3D od_enc)
>> +				break;
>> +		}
>> +		BUG_ON(od =3D=3D pll_info->od_max);
>> +		od++;
>> +	} else {
>> +		/* OD is fixed to 1 if no OD field is present. */
>> +		od =3D 1;
>>  	}
>> -	BUG_ON(od =3D=3D pll_info->od_max);
>> -	od++;
>
> I think if pll_info->od_max is 0 you get the same result without modifyin=
g this
> code. You just need to modify the BUG_ON() to only trigger if pll_info->o=
d_max > 0.
>
> Cheers,
> -Paul
>

Yeah, you're right, that's simpler. Thanks,
Aidan

>>  	return div_u64((u64)parent_rate * m * pll_info->rate_multiplier,
>>  		n * od);
>> @@ -215,8 +223,10 @@ ingenic_pll_set_rate(struct clk_hw *hw, unsigned lo=
ng
>> req_rate,
>>  	ctl &=3D ~(GENMASK(pll_info->n_bits - 1, 0) << pll_info->n_shift);
>>  	ctl |=3D (n - pll_info->n_offset) << pll_info->n_shift;
>> -	ctl &=3D ~(GENMASK(pll_info->od_bits - 1, 0) << pll_info->od_shift);
>> -	ctl |=3D pll_info->od_encoding[od - 1] << pll_info->od_shift;
>> +	if (pll_info->od_bits > 0) {
>> +		ctl &=3D ~(GENMASK(pll_info->od_bits - 1, 0) << pll_info->od_shift);
>> +		ctl |=3D pll_info->od_encoding[od - 1] << pll_info->od_shift;
>> +	}
>>  	writel(ctl, cgu->base + pll_info->reg);
>> diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
>> index 147b7df0d657..567142b584bb 100644
>> --- a/drivers/clk/ingenic/cgu.h
>> +++ b/drivers/clk/ingenic/cgu.h
>> @@ -33,7 +33,8 @@
>>   * @od_shift: the number of bits to shift the post-VCO divider value by=
 (ie.
>>   *            the index of the lowest bit of the post-VCO divider value=
 in
>>   *            the PLL's control register)
>> - * @od_bits: the size of the post-VCO divider field in bits
>> + * @od_bits: the size of the post-VCO divider field in bits, or 0 if no
>> + *	     OD field exists (then the OD is fixed to 1)
>>   * @od_max: the maximum post-VCO divider value
>>   * @od_encoding: a pointer to an array mapping post-VCO divider values =
to
>>   *               their encoded values in the PLL control register, or -=
1 for
>> --
>> 2.38.1
>>
