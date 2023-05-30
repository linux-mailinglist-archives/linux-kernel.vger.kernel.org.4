Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016C3715915
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjE3IyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjE3IyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:54:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B579BE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:54:16 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso28505905e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685436855; x=1688028855;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7lmsQK6BFMTI9A/AzX7inZ2KLuLrjwLxSMKshDdVAw=;
        b=d5VHr4Q3mnwFyczW2+cOhPVcS8zLr+Uy1M3lKD7AV1NGmclkBewr7gwqfynffNAqXI
         RgpcGJCv84vbz0vqmd9ynf+2Z+gIs8SerbZROVyjUyMYcPToroo+l6eJAYsWd05tuY+1
         aD3XHXjg6Vdg6XvlmVVhB7ZtjQGxbThcA1Wftmc18S4vA2zKgx/hqO47iZtczU7o3QnN
         3xLu31JHtiL0m+UoR4veG50gvlrZFjPsGjc0gfPZ+Ur+tW55NqBF1B3tWeGpZaG6C0Ck
         Um4Otp0dfkZNuLiGvG2kqwxlSHtKrRHyTGNFjI5ZdVwdv0ngeT1ciN0Ww/mCJ4QM4X91
         lZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685436855; x=1688028855;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w7lmsQK6BFMTI9A/AzX7inZ2KLuLrjwLxSMKshDdVAw=;
        b=EKRPdfGMehxF2Jwy4lU2CXW1e5b5fvWyGYR/Fat9labYBz/PhNxFwWlPUoFey3gwjS
         way/+UhRugKNuLkhePiC3Yib1XGCWkZLHy14CX5GdKdKvwC4wkd3CsrvKg9SauHvLjhO
         +GXggfT2ZzypXTvrKhRvE4DnvU0orfkEEqZ6b1k5ZqFRdjIwIn5sgCxPK2le3FjIS4sk
         zGAOVF/rxePt62hf8LAE2nDXew/21iljDdbOOoQbKFdeHs3dtrEyTR78ZvoNwpKXy30N
         KtRj/Yv1g2spxd1v77A3/33nLbnw/f7oKTGzqyt94M3oow/gBGnAKPCghEFFwBiESOKh
         tjow==
X-Gm-Message-State: AC+VfDyMNmZfosPO1eCUDyx/7zhIFLAgi1I2I8IMTiMDPNCRDJnqXp/l
        dtMG5YeB+MTrfGvSJU303L3ZBQ==
X-Google-Smtp-Source: ACHHUZ5mdSXtRsWTAxAyhV2X4/AylNnjsOFA9svEkXVzAwvQUy/dmnSGfVdc7r4UWCqxmxDp8+4lKg==
X-Received: by 2002:a5d:534f:0:b0:30a:e5da:272d with SMTP id t15-20020a5d534f000000b0030ae5da272dmr1094379wrv.0.1685436854955;
        Tue, 30 May 2023 01:54:14 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c16-20020a5d4f10000000b002fda1b12a0bsm2573457wru.2.2023.05.30.01.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 01:54:14 -0700 (PDT)
References: <20230517133309.9874-1-ddrokosov@sberdevices.ru>
 <20230517133309.9874-7-ddrokosov@sberdevices.ru>
 <CAFBinCBs7-9CvfQLxLoG5=FjmSK+S5eGsLXOAyQN9kNOg2q-2g@mail.gmail.com>
 <20230522133212.fcxgsml4hmvj65bb@CAB-WSD-L081021>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     neil.armstrong@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v15 6/6] clk: meson: a1: add Amlogic A1 Peripherals
 clock controller driver
Date:   Tue, 30 May 2023 10:32:57 +0200
In-reply-to: <20230522133212.fcxgsml4hmvj65bb@CAB-WSD-L081021>
Message-ID: <1jr0qy42tn.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 22 May 2023 at 16:32, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrot=
e:

> Hello Martin,
>
> Thank you so much for the review, I really appreciate it!
> Please find my comments below.
>
> On Fri, May 19, 2023 at 11:03:54PM +0200, Martin Blumenstingl wrote:
>> Hi Dmitry,
>>=20
>> On Wed, May 17, 2023 at 3:33=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberde=
vices.ru> wrote:
>> [...]
>> > +static struct clk_regmap sys_b_sel =3D {
>> > +       .data =3D &(struct clk_regmap_mux_data){
>> > +               .offset =3D SYS_CLK_CTRL0,
>> > +               .mask =3D 0x7,
>> > +               .shift =3D 26,
>> > +               .table =3D mux_table_sys,
>> > +       },
>> > +       .hw.init =3D &(struct clk_init_data){
>> > +               .name =3D "sys_b_sel",
>> > +               .ops =3D &clk_regmap_mux_ro_ops,
>> the sys_*_sel muxes and sys_*_gate are _ro...
>>=20
>> > +               .parent_data =3D sys_parents,
>> > +               .num_parents =3D ARRAY_SIZE(sys_parents),
>> > +       },
>> > +};
>> > +
>> > +static struct clk_regmap sys_b_div =3D {
>> > +       .data =3D &(struct clk_regmap_div_data){
>> > +               .offset =3D SYS_CLK_CTRL0,
>> > +               .shift =3D 16,
>> > +               .width =3D 10,
>> > +       },
>> > +       .hw.init =3D &(struct clk_init_data){
>> > +               .name =3D "sys_b_div",
>> > +               .ops =3D &clk_regmap_divider_ops,
>> ...but the sys_*_div aren't
>> Is this on purpose? If it is: why can the divider be changed at
>> runtime but the mux can't?
>>=20
>
> Ah, that's a good catch. Since the system clock is set up by the BootROM
> code, all sys_* dividers and gates should be read-only. I'll make sure
> to change that in the next version.
>
>> [...]
>> > +/*
>> > + * the index 2 is sys_pll_div16, it will be implemented in the CPU cl=
ock driver,
>> We need to add the "sys_pll_div16" input to the dt-bindings since they
>> should always describe the hardware (regardless of what the driver
>> implements currently).
>> I'm not sure how to manage this while we don't have the CPU clock
>> driver ready yet but I'm sure Rob or Krzysztof will be able to help us
>> here.
>>=20
>
> I've shared my thoughts about it in the bindings thread. Please take a
> look.
>
>> > + * the index 4 is the clock measurement source, it's not supported yet
>> I suspect that this comes from the clock measurer IP block and if so
>> the dt-bindings should probably describe this input. But again, we'd
>> need to keep it optional for now since our clock measurer driver
>> doesn't even implement a clock controller.
>>=20
>
> Indeed, this is a similar situation to what we have with the inputs and
> clocks of the CPU and Audio clock controllers. It seems like there is
> only one option here: we should mark it with a TODO tag...
>
>> [...]
>> > +static struct clk_regmap pwm_a_sel =3D {
>> > +       .data =3D &(struct clk_regmap_mux_data){
>> > +               .offset =3D PWM_CLK_AB_CTRL,
>> > +               .mask =3D 0x1,
>> > +               .shift =3D 9,
>> > +       },
>> > +       .hw.init =3D &(struct clk_init_data){
>> > +               .name =3D "pwm_a_sel",
>> > +               .ops =3D &clk_regmap_mux_ops,
>> > +               .parent_data =3D pwm_abcd_parents,
>> > +               .num_parents =3D ARRAY_SIZE(pwm_abcd_parents),
>> > +               /* For more information, please refer to rtc clock */
>> > +               .flags =3D CLK_SET_RATE_NO_REPARENT,
>> As mentioned in [0] we'll work with Heiner to see if we can improve
>> the decision making process of the PWM controller driver so that we
>> can just have .flags =3D 0 here.
>> This applies to all other occurrences of the same comment about the rtc =
clock.
>
> Sure, I'll make the change in v16. In my opinion, we should remove the
> CLK_SET_RATE_NO_REPARENT flag from all RTC related clock objects,
> including PWM, regardless of the outcome of the Heiner discussion. Based
> on our IRC talk, the decision has more pros than cons -
> https://libera.irclog.whitequark.org/linux-amlogic/2023-05-18

The clock scheme of PWM could indeed be handled like audio is but it
not strictly required.

In audio we have a limited number of PLLs (root sources). There is a lot
more consummers than there is root sources. If the root sources rate is
not carefully chosen to statisfy all needs, we could end in a situation
where we can't satisfy all consummers or we must glitch the source to do
so.

For the PWM, I think (but I'm not 100% sure) that the main clock controller
provides a source for each PWM. No risk of race there. That is why AML
decided to completly ignore the clock element in the PWM IP, because
they can do almost everything with what is in the main controller ... Still
ignoring those part is wrong

For the RTC, If you want/need to handle external RTCs, I don't think you
have much of a choice. If both the internal and external *report* the
same rate, CCF can't really know if one is best. It will just pick one,
no necessarily the one you want. I don't really see a way around manual
selection for this.

