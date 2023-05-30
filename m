Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2E4716E36
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjE3Tzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjE3Tze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:55:34 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E346129;
        Tue, 30 May 2023 12:55:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5148ebc4b89so7126707a12.3;
        Tue, 30 May 2023 12:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685476527; x=1688068527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JosYzEY1lGmppLDev48gkCgWxDTfd3euZCE7PWnGECE=;
        b=JRMxSf2z2l5ohNt0RMgYCYxWjbyqpDdm1OrbpPj43wHx4EBfg1PjnEt9XDhLl9nwIS
         jMOsDOPB6K3tKj7imM/7qXNSCr69jY0ngoXTrHdI6pn3ItphR4sLe2+POS3Mw/Mltmey
         1f7/+oTEhumsfTLYumWWb26roMeyb+JoxfysZ2q0nm/GHAhZfp7KoKR/l7PdLZ0j30hn
         +dDsVpOAc0kCrbrGIcjGUlbkIZMLjN3zjdwQX8zsflGGMjEQYfyjIaTvTocfKaPY8wSe
         Z97RtyYlmM4r1mpbMSm/x0TCIzz/d2I8tatGJSZU9h2ylaZ9w4Ii3bLPRUM49TlQOwHL
         HdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685476527; x=1688068527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JosYzEY1lGmppLDev48gkCgWxDTfd3euZCE7PWnGECE=;
        b=fnDZRDfeNkTcI4xVYeDdjAw0YN7jhaE+1h+Med4B7zr4A3kfvnhi5v7Rn8D2k0IOqb
         XAw7LKDoded5l5omucaDKrwHLZ5NADcqu5qFAAyQ8J5vxWxFOI/cjZ98oONtcgrqCJMz
         KC6air92v3TTLdJTOO1qadHGeETIz+zbHyoc8QpHUOdpffw25M6Psy9b/zj8ebedJLbY
         a7d54x1zDp6vnhGjMuppQ3HM/0IwqB2PGa3WkPQJSoQ0PMdHRbRTQI8dEKfuhEFxNSKt
         RpvnNkdLD0jJ2YlvYJ5UjZphFBJBJ7KXfabIH/inWFvRxou3i6lF64Fvp2dr8LIdnR1s
         y5yg==
X-Gm-Message-State: AC+VfDwn2DYKGwA5dyVl3CS97o43LYtDveHCWIsBSwdaO4o4hzbkTdzo
        09om3f58uJBmWJ1rLsH9DC7zyYnWCfv9G/MUXVc=
X-Google-Smtp-Source: ACHHUZ4P8r71ifJ+3o1ntKGm5WKvUQG9mQEAudtmzYAquTKx6MuMQE9ysPL3S5YD6wpSRL7NZm6o//GZQRb4UWb/U9Y=
X-Received: by 2002:a17:907:318d:b0:961:69a2:c8d6 with SMTP id
 xe13-20020a170907318d00b0096169a2c8d6mr3858560ejb.69.1685476527225; Tue, 30
 May 2023 12:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230517133309.9874-1-ddrokosov@sberdevices.ru>
 <20230517133309.9874-6-ddrokosov@sberdevices.ru> <CAFBinCC3kQ9Nz3R2W-Qj9tbPJfS8JsB_4AkmPgS6xpQ96DBy2w@mail.gmail.com>
 <20230522130033.a47vlybocme66rev@CAB-WSD-L081021> <CAFBinCAk9+Km3BssA8d8nc_Z_GbhY87FD3qQRpZ2k7ChKt7TBg@mail.gmail.com>
 <20230530-illusive-pushpin-1e35d0a50e0d@wendy> <20230530160334.z6sclbmqccs6ju4y@CAB-WSD-L081021>
In-Reply-To: <20230530160334.z6sclbmqccs6ju4y@CAB-WSD-L081021>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 30 May 2023 21:55:16 +0200
Message-ID: <CAFBinCCZcT=7BZsgXDjzbcqAZpEkKYZRBDRwDX1poWZHa9Hxdg@mail.gmail.com>
Subject: Re: [PATCH v15 5/6] dt-bindings: clock: meson: add A1 Peripherals
 clock controller bindings
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     Conor Dooley <conor.dooley@microchip.com>, jbrunet@baylibre.com,
        krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        khilman@baylibre.com, jian.hu@amlogic.com, kernel@sberdevices.ru,
        rockosov@gmail.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 30, 2023 at 6:03=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
[...]
> > If I am understanding correctly, this series implements the child
> > controller and a parent, which is unimplemented, provides the child wit=
h
> > sys_pll_div16.
> > The thing I am missing is whether the child controller has some outputs
> > that depend on this sys_pll_div16 input & whether those are documented
> > in this series. Regardless, you should be able to add more output clock=
s
> > without compatibility issues.
Conor, the short answer is yes, the "gen_sel" mux (see patch 6/6 from
this series, which is then part of a clock tree that's an output of
the peripheral clock controller) uses sys_pll_div16 as input.
Dmitry goes into more details below.

[...]
> As for new input clock connections, such as the cpu_clock
> (sys_pll_div16), these are handled by clock muxing abstraction, allowing
> CCF to find the clock object by fw.name and returning -ENOENT if the
> connection is missing without breaking any CCF flow. It happens in the
> kernel function clk_core_fill_parent_index()
> https://elixir.bootlin.com/linux/latest/source/drivers/clk/clk.c#L424
> Despite not having the connection for the new input in the old Device
> Tree version, this will not break kernel boot flow and workflow, and the
> new clock object just would not be utilized.
>
> Based on the presented arguments, I fully agree with Jerome's position.
> We can add new connections and objects in new driver versions, but their
> removal is prohibited.
>
> If it's alright with you, I would prefer to keep the Peripherals and PLL
> clock driver and their bindings as they are, and continue with the CPU
> and Audio clock controllers in a separate patch series. Would that be
> feasible for you?
To me this sounds good!


Best regards,
Martin
