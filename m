Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892886E3C00
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 22:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjDPU4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 16:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPU4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 16:56:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C022133;
        Sun, 16 Apr 2023 13:56:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ud9so58968891ejc.7;
        Sun, 16 Apr 2023 13:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1681678608; x=1684270608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WS1S2J47m9oZfeWP6yf02N4PR4c/sbbG9OpnnKVNb0=;
        b=Y1MtgDTM9NDmIpajiqJlE+6DdkvMLOoVa3VmvdAft4qxVRnLve++ZydABxkHv8okQs
         lNdimhxM1p+SzvXifOHGHG0RxMapoI1z00KvMeXjDXsFhN+mJmMSRPIwcTNq+188RkNL
         w8y42mUxpWfiaOKBd6/x+4Vvm6ONnANnO80FXhOpioMXcOvkqMj2gPhEg6VPOxJxpleF
         h9/JIntF3/Ml8569J/WDwrEtlxvV7WAypD48jWo+HNbZXSjTAw/9Ue2uG/zSnQvbrP7i
         jy1EX3IzlOb4ECnd5O0c6MdrUbRX2ZO13DQMTQl2y6yqL23SqjPnN/piGBwGtr3Ft67e
         8sSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681678608; x=1684270608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WS1S2J47m9oZfeWP6yf02N4PR4c/sbbG9OpnnKVNb0=;
        b=l01DzcdUHFoUpyvW/Cmsw5+JmtNvyITT51BWUeeqris84ihVIruesBii9aR8+Zc3e2
         sUzYavYMzHLZZNyC3/gwMRZ23+0R7ucBcGaBRxm/eAgNRXZpRXGgMbN1hxfuXGJd/XgB
         N4Wa8CpGLUtqd1ecnWsCLZ4DHLiLa5r3wZUFY1+pjxNKO6xxCd4JCrjpJXiVMlal2hXM
         QkWaTDWsTh4qSEhP4u7ykd53S9Cm58jMqZJ5g43oe/sJJhd23n8MrSOtCZtdwoL+II05
         0Dre1bCkekHUQvl7s0i3V6+wVRhmyDgwqvgLUum4OTZxrLo5YPDZ8qjUUdfb1XcWVol/
         g/Jw==
X-Gm-Message-State: AAQBX9foKiqJN7wZuj8K8Q7pGv7Y5bEIsfs6lArBAp0gLxWctpzmZfMr
        lFUtIo2Bfluy72/bJAnCsd14p/hENIFeYJhbBhs=
X-Google-Smtp-Source: AKy350aAl7oqe1ri0rb5+ehDUovVW9O7EQwAqt1kFQNqQPClScpqKDS+kcHcWi9AGVPNc7cnTNruAr0Rv5/TYwEPLuE=
X-Received: by 2002:a17:907:590:b0:94f:3338:2431 with SMTP id
 vw16-20020a170907059000b0094f33382431mr3499453ejb.32.1681678608156; Sun, 16
 Apr 2023 13:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230414152423.19842-1-ddrokosov@sberdevices.ru> <20230414152423.19842-5-ddrokosov@sberdevices.ru>
In-Reply-To: <20230414152423.19842-5-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 16 Apr 2023 22:56:36 +0200
Message-ID: <CAFBinCDyUBWd-V0mDy_edzH=3JM5SAuX=vtT4MG9Fb62Rcv=mA@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] usb: dwc3-meson-g12a: support OTG switch
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        mturquette@baylibre.com, vkoul@kernel.org, kishon@kernel.org,
        hminas@synopsys.com, Thinh.Nguyen@synopsys.com,
        yue.wang@amlogic.com, hanjie.lin@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-phy@lists.infradead.org
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

On Fri, Apr 14, 2023 at 5:24=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
[...]
>  static const struct dwc3_meson_g12a_drvdata a1_drvdata =3D {
> -       .otg_switch_supported =3D false,
> +       .otg_switch_supported =3D true,
it would be great if you could also follow up with a patch that
removes otg_switch_supported.
A1 was the only variant that needed it and after this patch it's just dead =
code.


Best regards,
Martin
