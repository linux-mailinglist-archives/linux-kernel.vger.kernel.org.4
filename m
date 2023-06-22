Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC12D7397F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjFVHOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjFVHN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:13:59 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5196D2114
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:13:32 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bd6d9d7da35so6690043276.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687418008; x=1690010008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hUliAdRg79tlWj+30+5hplBBl2Cn5f+HdXYzO27t9Y=;
        b=qNTC3gVZpm0/wi/DY6m/7JNtvsprwFjWaPoY8aeSbKo0pMQXRDBkgabwphkyv/1K+y
         5PeYwsVJqamo2kgb8swMIM8kdB04eZ3zFfjcR+d7gTbhEzNV52DsGDzh5/+9btRyNc9z
         SgWzSz9aPPqENgcDFQ8/fijEJ/MOSyttcDiW1goTd71QluBODXI9yNQazLUlEDxJ/HF3
         FMRGxu0B5hQVRZ+wgbDohOMcixsY6AUio8dtnd3eYw60DqI8oqVuiW3fM5xAccbLoIS3
         1edJelu136TtGxYPzp2+uv8DZqfU/X6KocG3w1tzDL9Fs57Kgt9r7YepgKmOxlI+05Xf
         jx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687418008; x=1690010008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hUliAdRg79tlWj+30+5hplBBl2Cn5f+HdXYzO27t9Y=;
        b=geFIcngNIBLv14bAe+ZPu5BBdLxvubAcDactF6Fxrzrq6dlLQOJDA0Xci2+0trn1J5
         XICoB2NqHM87OBs9aYLUEhFONsFOUvgGr4Ax8j6T0Te2IynDAuLQOFdzcBThx/r+KIN0
         dESIxf/L13RomO+Wx6XDXTvdqV9hbuyRdSLbmiSl0OASVcbQSWtwg+HgcEVtCUZZSlv1
         Lk3afVPekmIOtynhI6LZbC/lJnE38HEyOrf+EXNqxGZ5mrG6/OQu5xKYqrERv1j2GhLl
         8/WPMKrfmLWpKQ8ww0PqOOxYib/24f23wmvQZN2Qj1H0m3UmBS22FSMR+eqL9uJqdgwG
         u2DQ==
X-Gm-Message-State: AC+VfDz78wSbNmwul6h9ueewUQ3Ff12Vt2HOMG/XIIA03WH964WZuSHs
        EA14D8EyuLfnc0+LqFf2BafLFZLR4cqw4S+m9gdRBQ==
X-Google-Smtp-Source: ACHHUZ7m1xfekhso1XZxAYhTE6sJ6yX2vzQVSru2a5Y/qiFLulxLEFszMWFPoi6fKq16FfYcBUHXuV+K1Ti/DAseeI4=
X-Received: by 2002:a25:e617:0:b0:be4:d7a9:31ff with SMTP id
 d23-20020a25e617000000b00be4d7a931ffmr13516285ybh.35.1687418008582; Thu, 22
 Jun 2023 00:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230621213115.113266-1-nick.hawkins@hpe.com>
In-Reply-To: <20230621213115.113266-1-nick.hawkins@hpe.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Jun 2023 09:13:17 +0200
Message-ID: <CACRpkdazmeFHagwkJ3s6BHRBgFoLPbj8AVnPL2f+vTi9K46Kcg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] ARM: Add GPIO support
To:     nick.hawkins@hpe.com, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Cc:     verdun@hpe.com, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:35=E2=80=AFPM <nick.hawkins@hpe.com> wrote:

> The gxp-fan-ctrl driver in HWMON no longer will report fan presence
> or fan failure states as these GPIOs providing this information will be
> consumed by the host. It will be the hosts function to keep track of
> fan presence and status.

I understand the approach such that you have also constructed a
userspace cooling daemon that will consume the fan and GPIO
information to drive the hardware monitoring and that is what you
mean when you say "the host" will do it.

This is a *bad idea*.

While I can't stop you since these are indeed userspace interfaces we
provide, I urge you to look into my earlier proposal to use a thermal
zone to manage the cooling inside the kernel and get rid of all that
custom userspace.

The kernel has all that is needed to regulate the thermal zone with
PID and on/off regulation. It will work even if the userspace crashes
completely, which is what you want. The code is reviewed by a large
community and very well tested.

I think I showed this example before from
arch/arm/boot/dts/gemini-dlink-dns-313.dts:

        thermal-zones {
                chassis-thermal {
                        /* Poll every 20 seconds */
                        polling-delay =3D <20000>;
                        /* Poll every 2nd second when cooling */
                        polling-delay-passive =3D <2000>;

                        thermal-sensors =3D <&g751>;

                        /* Tripping points from the fan.script in the rootf=
s */
                        trips {
                                chassis_alert0: chassis-alert0 {
                                        /* At 43 degrees turn on low speed =
*/
                                        temperature =3D <43000>;
                                        hysteresis =3D <3000>;
                                        type =3D "active";
                                };
                                chassis_alert1: chassis-alert1 {
                                        /* At 47 degrees turn on high speed=
 */
                                        temperature =3D <47000>;
                                        hysteresis =3D <3000>;
                                        type =3D "active";
                                };
                                chassis_crit: chassis-crit {
                                        /* Just shut down at 60 degrees */
                                        temperature =3D <60000>;
                                        hysteresis =3D <2000>;
                                        type =3D "critical";
                                };
                        };

                        cooling-maps {
                                map0 {
                                        trip =3D <&chassis_alert0>;
                                        cooling-device =3D <&fan0 1 1>;
                                };
                                map1 {
                                        trip =3D <&chassis_alert1>;
                                        cooling-device =3D <&fan0 2 2>;
                                };
                        };
                };
        };

This uses a thermal sensor and a fan with two speeds.

Adding a "presence" GPIO to the thermal zone core to enable and
disable it which is what your use case needs should be pretty trivial.

Yours,
Linus Walleij
