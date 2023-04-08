Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255D56DB883
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 05:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjDHDOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 23:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDHDOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 23:14:33 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71937CC01;
        Fri,  7 Apr 2023 20:14:32 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 73so109780qkg.1;
        Fri, 07 Apr 2023 20:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680923670; x=1683515670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMTKJDQ8CdgEq5oydLbuNOEjnz2pC0DL2nvx8nYSz/g=;
        b=Q48jvsiIcW6+33OEw+8Rq2By/0rqAJXsy0pbv5Ivxlezjf2NnrQr5WO9WV+cxoLcY4
         P4kvSheOQQeR0uxecCxHXF+4BBRhAOXGI4WkJvpj5P7NfRHT9rW3MJ8D6DuRWfDCLkXR
         AFXPr5fol0nMe116ZVgI6KN3Rfqc2Pq1dm9gSnEsJN/j6UYohxHtO902BVIzNVuFdVNC
         /6lGFGdZ6rb2LdPUgWznZV/BfG818fKJT4SRzSLMRP0ZWiwsm080D2I4WjAiFqki9T3g
         LJb/wdZ3AiTLkMiuSZDD6T/DVSEAPKUcD9BfAUZz4xCW8GxKZ/LqMV60r7GQGYdLknPi
         4QXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680923670; x=1683515670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMTKJDQ8CdgEq5oydLbuNOEjnz2pC0DL2nvx8nYSz/g=;
        b=ruf/yy/pbXr61cmIM5PT0RnR72FjHDipnF0OmLR0RnMXBQeRcjsNl7d69Pg3IsIp76
         zGiD8m59t/F24rf5CDuCIf5jgt7ZmMerVilhvjLCD4Tmo2yQIotYwxdZ12ir1+gbZfkz
         F9sUecURz3QVba7xQ+r7c3cJ7cxxUq0pWp4Vv3Dtmt6eqNCAaR29xc/yVgm71rxBzYD3
         dzevwZw8zZnOL29WJVztgRtj7wz5Qcbh1s7kBVgeLGnKoIw3J5U8FDxuwie34AMuvMKm
         dmiN9vsaETJhRvCSaWa+BM6yVQXPjjVZasQK34p4MD9oLxYXmwkw/7iNJRdBpdb4a/SE
         8JFg==
X-Gm-Message-State: AAQBX9c9+wI8wpu943P3VwyjOuADwmuNOY1wGrIRofD5khKhDdT1Vvcs
        XTKtsSjk3hvlR/XvWknkA5N1lTs5m5hnD//Udgw=
X-Google-Smtp-Source: AKy350Z3AtOV3Hj8e2V0+G3cXlcE2CUJYghvIUSBZ5M8j+IP946o3xKT9Fp538mrEE70dVq7aSFML1TYV1nrT8gDZvc=
X-Received: by 2002:a05:620a:1981:b0:74a:5c5:944 with SMTP id
 bm1-20020a05620a198100b0074a05c50944mr1150949qkb.4.1680923670462; Fri, 07 Apr
 2023 20:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230406203103.3011503-1-krzysztof.kozlowski@linaro.org> <20230406203530.3012191-7-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406203530.3012191-7-krzysztof.kozlowski@linaro.org>
From:   Aleksandr Mezin <mezin.alexander@gmail.com>
Date:   Sat, 8 Apr 2023 06:14:19 +0300
Message-ID: <CADnvcfKwHJ=dOFH1+DsDfn6Y5k6xdzA7QR1uVDv1afwCsiso3w@mail.gmail.com>
Subject: Re: [PATCH 48/68] hwmon: nzxt: constify pointers to hwmon_channel_info
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oded Gabbay <ogabbay@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Marius Zachmann <mail@mariuszachmann.de>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Rudolf Marek <r.marek@assembler.cz>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonas Malaco <jonas@protocubo.io>,
        Derek John Clark <derekjohn.clark@gmail.com>,
        =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= 
        <samsagax@gmail.com>, Iwona Winiarska <iwona.winiarska@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Walle <michael@walle.cc>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Agathe Porte <agathe.porte@nokia.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Robert Marko <robert.marko@sartura.hr>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        patches@opensource.cirrus.com, openbmc@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 11:37=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> -static const struct hwmon_channel_info *nzxt_smart2_channel_info[] =3D {
> +static const struct hwmon_channel_info * const nzxt_smart2_channel_info[=
] =3D {

In the rest of nzxt-smart2.c there are spaces only before "*", not on
both sides (and there are a few "*const" already). Would be nice to
keep it consistent. The same seems to be true for nzxt-kraken2.c
(although I'm not a maintainer)
