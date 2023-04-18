Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D016E66F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjDROTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjDROS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:18:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF93F146C5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:18:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-504ecbfddd5so4636372a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681827525; x=1684419525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zST2ogY5xFX7piRNXStlaVQvyezkCUdzLc+A/+WCH/0=;
        b=Mison/D9qO8cX3MKF9BO8D99s/3fvPtGb7uQOULjQ58TigK+IZh4ewSKnxLKzrYPyw
         YdCN9qUpLQgTd92ENadYxAVjONyB/iFfxHmt3/L0Zz7jRFSYo6lwCeteQvXQWf9P6cxK
         ouL+D/1itTMyEpUW20FCHfecexCuF33n0c4Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681827525; x=1684419525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zST2ogY5xFX7piRNXStlaVQvyezkCUdzLc+A/+WCH/0=;
        b=OG+FEwfsyim89H+48COwc95xzFp/T4oxtgCTmm6bw+qXWynIop5sG/uDCLco+ezRhX
         SerXfLEbqNN13X+AJ09bQ8o91up7R0ek6oKviZ+qnfJx5NbQHjypZ/KkX3Q2PeRp5Ohn
         NmGqCw4FO0Z8BWv7DVbEolQi2sWMak36vxfupRvNRoRyOxNuASFlb12GCXgS9FPtxH9Q
         ug9/vWYVzxQ+Bdb79DV78jlDSHI2zlLc5S9qVmKg1GegtjkJuImGLSmyOLjMwCV2pvqy
         GDytJLzKvJlG+o136lGCPf/ZKOHJCLktlCBM/jgHbE7p+Oumz4Oz4YjD74RTZSy6QmLt
         AYVg==
X-Gm-Message-State: AAQBX9f6jnib6uLsq1UE3xXgAWsTK/92pgnvRysiP2EmsqMJwTA2IsPb
        JV6A9MRDi3lxetdytoyJu85sR5PqgiSxh1xjYD27Iw==
X-Google-Smtp-Source: AKy350Yi5+lmw88stx0Ox8TcqDMQybP0sDeFzMyGmhnip9DT9F/WQQSAEJM6GA+ugN5suh6QN/hvHg==
X-Received: by 2002:aa7:cf05:0:b0:4fc:3777:f630 with SMTP id a5-20020aa7cf05000000b004fc3777f630mr2384607edy.0.1681827525603;
        Tue, 18 Apr 2023 07:18:45 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id x8-20020aa7d388000000b00506b83ef9e2sm1294403edq.13.2023.04.18.07.18.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 07:18:44 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f16fd9bc0dso20723925e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:18:44 -0700 (PDT)
X-Received: by 2002:adf:e803:0:b0:2fa:d7ac:6462 with SMTP id
 o3-20020adfe803000000b002fad7ac6462mr485497wrm.11.1681827524446; Tue, 18 Apr
 2023 07:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230418124953.3170028-1-fshao@chromium.org> <20230418124953.3170028-2-fshao@chromium.org>
In-Reply-To: <20230418124953.3170028-2-fshao@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 18 Apr 2023 07:18:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V8ZN3969RrPu2-zZYoEE=LDxpi8K_E8EziiDpGOSsq1w@mail.gmail.com>
Message-ID: <CAD=FV=V8ZN3969RrPu2-zZYoEE=LDxpi8K_E8EziiDpGOSsq1w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: input: goodix: Add powered-in-suspend property
To:     Fei Shao <fshao@chromium.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 18, 2023 at 5:50=E2=80=AFAM Fei Shao <fshao@chromium.org> wrote=
:
>
> We observed that on Chromebook device Steelix, if Goodix GT7375P
> touchscreen is powered in suspend (because, for example, it connects to
> an always-on regulator) and with the reset GPIO asserted, it will
> introduce about 14mW power leakage.
>
> This property is used to indicate that the touchscreen is powered in
> suspend. If it's set, the driver will stop asserting the reset GPIO in
> power-down, and it will do it in power-up instead to ensure that the
> state is always reset after resuming.
>
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
>
>  Documentation/devicetree/bindings/input/goodix,gt7375p.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml =
b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> index ce18d7dadae2..942acb286d77 100644
> --- a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> +++ b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> @@ -43,6 +43,12 @@ properties:
>        itself as long as it allows the main board to make signals compati=
ble
>        with what the touchscreen is expecting for its IO rails.
>
> +  powered-in-suspend:
> +    description:
> +      This indicates that the touchscreen is powered in suspend, so the =
driver
> +      will not assert the reset GPIO in power-down to prevent power leak=
age.
> +    type: boolean

This seems OK to me. The overall idea is that if we ever turn off the
power to the touchscreen we have to assert reset (active low) before
doing so, but we don't want to hold reset if we're not actually going
to turn the power off because it causes the touchscreen to go into a
high power state. This gets complicated if the power rail is always-on
or shared with another device.

Alternatives I could think of:

1. In the OS, monitor the regulator and see when it's about to go off
and then assert reset. This is what I tried to do in previous patches
but it got too messy in Linux. It also wasn't perfect since it's
(theoretically) possible for a regulator to turn off outside of the
scope of the OS (some PMICs will auto turn off rails when the main
processor says it's off).

2. In the OS, peek to see if our regulator is marked "always on". This
doesn't handle the shared rail case, of course. Also, regulators that
are "always on" from the OS perspective could still (theoretically)
get turned off at suspend time by the PMIC.

3. Don't even hook up the reset line and just leave the touchscreen
out of reset all the time. This has the disadvantage that we can't
reset the touchscreen if it gets into a bad state, which could be even
more important if the touchscreen is on an always-on or shared rail.


Given the above, the solution in ${SUBJECT} patch seems reasonable.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
