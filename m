Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949E372CE20
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjFLS26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbjFLS2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:28:38 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C632950;
        Mon, 12 Jun 2023 11:28:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51870e2dc48so190449a12.1;
        Mon, 12 Jun 2023 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686594486; x=1689186486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4agcRs13sbq0fH6nM511QGzLPmuFdZA0cppyFltK+ps=;
        b=VkkQGM9ZGvbJWrYQfpqn7L4k1h2dVUd/QoFfSAOnwXq1NTAWfNLA3YHD5IxwQ92QCA
         A9ggeOYq2NycUNAKSOu5nBuvFvtL9R0CG33IOp/m5zsGRpPGzfyrgBrQUCYPFKu6VvNb
         xKNPNR6FW8aXs844q/tb+nWHXh/0+WFrJHj8AaCVH3O6afT1XeHx9ClTFZtS6DJZsCz6
         9/TL553Qr7Tf4XGCUfuGag5kTVokRLN7X8IeuroC/x57w2lOlcHOM+r70jdTgmQSTvVr
         uW4E67rNyYhxZVU8D7vyoRkPZ4e/U0AMzC08n0lj55BFmbM6CZMiUVq3XrlETAFAcIl6
         M17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594486; x=1689186486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4agcRs13sbq0fH6nM511QGzLPmuFdZA0cppyFltK+ps=;
        b=TThbtxg//lmbTMDUEAiZa+yoQFIwSH3Of2z8eTB/fNKFpzBY3oJgy+GSNHRvLUDew5
         BgSKEmRG83I5az9FYlIGA52+w9ye6+NGl9G2Jt2NyPFgG7lPBKlH1M8E0ANeP2eDNGle
         fuzQPb6uAAz5A2RYN37X8ribk4M5hBDeZ6ViDoBNZ09VaZsbrYL4UIv48TUOe2vIW9fm
         mpA4ucwXDFl4+d0krXDjuhXqxpBfLHnT1jJ7H/7QeZQMW177+8XcZhOr1KErIV8CYJRD
         83O5Df3lXj+zmeCxYGbXgdLKPGNhsCnFD0xdX+bIoFyrRG2QKQUfxToxmPybL4sEIxZf
         YS4g==
X-Gm-Message-State: AC+VfDzIsvr1dTFeGZPxHvbrOG07vau+RAf524t2vUOqzMH3z89Jd18m
        E1UFHcK88N806wAsXZfERLgp9wHw6J4QcI1T
X-Google-Smtp-Source: ACHHUZ60yZJ9QPJzqKwozXYJ/sqa9Zy/f+rn7T6IW6OI+RSRCBLxL2MW5KoChkvUBMzrAVZixMKaqQ==
X-Received: by 2002:a17:907:7249:b0:973:dd5b:4072 with SMTP id ds9-20020a170907724900b00973dd5b4072mr8579667ejc.53.1686594485690;
        Mon, 12 Jun 2023 11:28:05 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id v26-20020a170906489a00b0097d7924b4edsm4012765ejq.168.2023.06.12.11.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:28:05 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Add D1/T113s thermal sensor controller support
Date:   Mon, 12 Jun 2023 20:28:03 +0200
Message-ID: <3232828.aeNJFYEL58@jernej-laptop>
In-Reply-To: <13282074.uLZWGnKmhe@jernej-laptop>
References: <20230610203549.1127334-1-bigunclemax@gmail.com>
 <13282074.uLZWGnKmhe@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 12. junij 2023 ob 20:22:43 CEST je Jernej =C5=A0krabec napi=
sal(a):
> Dne sobota, 10. junij 2023 ob 22:35:41 CEST je Maksim Kiselev napisal(a):
> > This series adds support for Allwinner D1/T113s thermal sensor controll=
er.
> > THIS controller is similar to the one on H6, but with only one sensor a=
nd
> > uses a different scale and offset values.
> >=20
> > v2:
> > - Fixed SoB tag
>=20
> It doesn't seems you fixed that.

Sorry, too many revisions in short time. Wait until discussion is finished.

Best regards,
Jernej
>=20
> > - Moved binding patch before driver changes
> >=20
> > v1:
> > - Initial version
> >=20
> > Maxim Kiselev (3):
> >   dt-bindings: thermal: sun8i: Add binding for D1/T113s THS controller
> >   thermal: sun8i: Add D1/T113s THS controller support
> >   riscv: dts: allwinner: d1: Add thermal sensor and thermal zone
> >=20
> >  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 20 +++++++++++++-
> >  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 26 +++++++++++++++++++
> >  drivers/thermal/sun8i_thermal.c               | 13 ++++++++++
> >  3 files changed, 58 insertions(+), 1 deletion(-)
> >=20
> >=20
>=20
>=20
>=20
>=20
>=20




