Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D739471593F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjE3I6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjE3I6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:58:50 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91555BE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:58:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso28564555e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685437127; x=1688029127;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYHWRwPC1PyqtJzsHAhzg3QWrxaLFpon/Y0AWZagYyc=;
        b=qi6erHOYwJy39owpmZLKdUawt774nCiCm9mIrk6TReP6vQJg/Q2jdlQ+vXtOvCpM72
         2xuzz2FSYWAU/bJThNKAT4zmJ1UtF37p4PZbmXSlcx4Bi4MBGRjrpkIfS/3IP9eVTDvc
         s2wPs3c66zwvFPjuTk3dBwUtbr2sujASo8sChoFw9Iu16QIJ0XhOi959OqfaoHr22vxw
         e/UH6ZAQFBqEa1URrY7Uktz9B7NpKk8CR9DcDR5NW737V1YQ+t/6big3a+OwtX2s0x2u
         vNEqNZzcBfLWiWu2v/RRU2lmOOUP6wR+s5VmXE7vAO6+momkWMH3iGrjNZYRUo7PRMVj
         WBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685437127; x=1688029127;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kYHWRwPC1PyqtJzsHAhzg3QWrxaLFpon/Y0AWZagYyc=;
        b=YzG4vqW3KTA2fwF9X7Yw7jmOAjZBFja8+HTmdeHFzv5QddCXXee7dm3CIYReNHLsgD
         IdeJrLbliAecowlnEF8DgVc1DI4Es0jkvaxPE2A6Th14vBiXeirQsyp/fS5S/9GVx7D+
         S1OJ41EniRocfRRAeorkHiM3pgPKNgOkHPoh5MC551phfbzmTlVZSe6SYUw1j3ZOXUj1
         XqmVH04qecjEShGJ/MQvdR1US2sCBZojzvqeIehQlSwVc4VJS7QrNIuC58G7z+MJOs8C
         lCoRJ/g148HvCHHLGQRYALnKSD+rdwVjtRZ+XzhfoBlH+KcDcYMEWfaSJ1C9+CO9sjHl
         i0Wg==
X-Gm-Message-State: AC+VfDyr4VZrGJQM7yBhOMh79ThFnMFTbczuE3NQ3Yp2VW4Kklj1Exp8
        qF0se9N6ujNc7wTUnxq04fFWng==
X-Google-Smtp-Source: ACHHUZ5V7jGuiisz0DRb9gePOQ50QMdG/I22ele4GLTmzVxV/38WaqdHuh5m1Ym1QLZTD6CqULqb4Q==
X-Received: by 2002:a7b:ca59:0:b0:3f6:a81:eb52 with SMTP id m25-20020a7bca59000000b003f60a81eb52mr1027741wml.21.1685437127075;
        Tue, 30 May 2023 01:58:47 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c290700b003f42d8dd7ffsm16724062wmd.19.2023.05.30.01.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 01:58:46 -0700 (PDT)
References: <20230517133309.9874-1-ddrokosov@sberdevices.ru>
 <20230517133309.9874-6-ddrokosov@sberdevices.ru>
 <CAFBinCC3kQ9Nz3R2W-Qj9tbPJfS8JsB_4AkmPgS6xpQ96DBy2w@mail.gmail.com>
 <20230522130033.a47vlybocme66rev@CAB-WSD-L081021>
 <CAFBinCAk9+Km3BssA8d8nc_Z_GbhY87FD3qQRpZ2k7ChKt7TBg@mail.gmail.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Conor Dooley <conor.dooley@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     neil.armstrong@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, khilman@baylibre.com,
        jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v15 5/6] dt-bindings: clock: meson: add A1 Peripherals
 clock controller bindings
Date:   Tue, 30 May 2023 10:56:52 +0200
In-reply-to: <CAFBinCAk9+Km3BssA8d8nc_Z_GbhY87FD3qQRpZ2k7ChKt7TBg@mail.gmail.com>
Message-ID: <1jmt1m42m1.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 29 May 2023 at 22:38, Martin Blumenstingl <martin.blumenstingl@googl=
email.com> wrote:

> Hi Dmitry,
>
> On Mon, May 22, 2023 at 3:00=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdev=
ices.ru> wrote:
> [...]
>> > This IP block has at least one additional input called "sys_pll_div16".
>> > My understanding is that the "sys_pll_div16" clock is generated by the
>> > CPU clock controller. Support for the CPU clock controller
>> > (dt-bindings and a driver) will be added at a later time by Dmitry.
>> > How can we manage incrementally implementing the clock controllers?
>> > From a hardware perspective the "sys_pll_div16" input is mandatory.
>> > How to manage this in the .dts patches then (for example: does this
>> > mean that Dmitry can only add the clock controller to the .dts when
>> > all clock controller bindings have been implemented - or is there
>> > another way)?
>>
>> You're absolutely right: currently, not all inputs are supported because
>> the CPU clock controller isn't ready yet =E2=80=93 I'm working on it at =
the
>> moment.
>>
>> I understand your concerns about bindings and schema description, but
>> there is an issue to be considered. I'm developing the entire clock
>> controller A1 subsystem incrementally in three stages: peripherals and
>> PLL, CPU, and Audio. This is because the CPU can operate at a static
>> frequency and voltage, and the board boots normally without the CPU
>> clock controller, thermal sensor, and OPP table. Audio is also
>> important, but it's optional. On the other hand, without setting up the
>> peripherals and PLL controllers, the board won't function because
>> they're fundamental.
> I understand your approach and I like it (without that incremental
> approach you would probably be looking at a series with 15-20
> patches).
>
> Maybe the dt-binding maintainers have a suggestion for us here?
> Let me try to summarize the issue in a few bullet points:
> - There's (at least) four clock controllers on the Amlogic A1 SoC
> - Some of these clock controllers take the outputs of another clock
> controller as inputs
> - In this series patch the peripheral clock controller has an input
> called "sys_pll_div16"
> - The clock controller which provides the "sys_pll_div16" clock is not
> implemented yet (my understanding is that implementing it and adding
> it to this series is not easy: it would add even more patches that
> need to be reviewed and in general it's a tricky clock controller to
> implement as it manages the CPU clocks)

IMO, if you just add another const later on, it is fine. I would not make
any existing DT invalid as a result. The problem would be if you removed
an entry

That's my understanding at least

>
>> Right now, we're in the first stage of the plan. Unfortunately, I can't
>> disclose the exact names and number of clock bindings for the CPU and
>> Audio, as they're still in development and only exist in my head or
>> draft versions.
>>
>> If possible, I'd prefer to provide the new bindings and connections once
>> all the appropriate drivers are finalized.
> Question to Conor and Krzysztof (assuming you read my summary above):
> Is it fine that Dmitry adds additional inputs to the peripheral clock
> controller binding in later patches?
> If not: how can we proceed in case we need to add them now (the
> dt-binding example is the easy part for me as we can just make up a
> phandle like &sys_pll_div16_clk and use that - but this can't work
> when Dmitry tries to add the clock controller to meson-a1.dtsi)
>
> PS: Dmitry is trying to get this series into Linux 6.5. As far as I
> remember the common clock maintainers don't take pull requests with
> new features after -rc6 (which is in less than two weeks).
> So time is getting a bit short and for me this is the very last
> outstanding question. If you say that it's fine to add clocks later on
> this will immediately get my Reviewed-by.
>
>
> Best regards,
> Martin

