Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F4F6F365A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjEASx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjEASxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:53:51 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38932CD;
        Mon,  1 May 2023 11:53:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-959a3e2dd27so569398366b.3;
        Mon, 01 May 2023 11:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682967228; x=1685559228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcrbAaVz/Tew1epI5hk6Zr7SXYmQTuJNk5UFWlXr0Sk=;
        b=EuyNEUTQVGJioLsniNIIE3aZTgwqVP/VX3T0BP1C7JgtGSW5tYccF5sOrNVy50rRc9
         UYr3RQa8+spA0343UOjCUngKLpa9hV4yXyG69ErqdjokdsX8Lq6nFJOl3JFiwlGKTdp4
         X1jvYgX8Nzdul4ZpzEFDgC07PSffHDumX/nIEXx4X6xDlvQlnN/E1B71zowrwZ9faJUN
         KLZhHPzH2/NSRQ8sNJ3u+2iOJ0I3kBOINlSvUZIM44eLI1AP9h7nw9D4NVasMVkkM5ty
         MU+m1RZOTT2Mv/8KtW6avwQBL5EXRuyw8D81v/K+RGfMh7kCorD/xFErCXkJ7TQClXVn
         1cvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682967229; x=1685559229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcrbAaVz/Tew1epI5hk6Zr7SXYmQTuJNk5UFWlXr0Sk=;
        b=Xq5yIimUumz9+awBnW3DhLin4yJaTagUj7/GX7ye8cV5ts5Ze4YwYT5TdU+qCKm13W
         BQW0nw+Pv915jzBYwkt6nIuLiRTpUeolURN+NAtcL6GyUJy41tjY0kjUfXS7HZ9ivdM5
         qDDU0qSDzOCFFkdgHMAAHCBTfC+YU2/d7YC5q83tOtdjwlBepiWXQRTYU7zT6eM1MhyB
         oTe1Kf8osNbneiYLnAprgzen7nN0phPd9ZqcdpifhowOobWgsFc5iTK2gWzJiGP0sDe4
         Pj+9Mu+euV2ux/+8+tCkNrP+eRKx9CWrU//srhZegdKBMW2uNML+tMWWCK5BRs1rcPhe
         rV+Q==
X-Gm-Message-State: AC+VfDxPCS5zPXP7YHzH7vw6ZLDse66bH4KBM68fxH/QJjJBw2hU7HyB
        KBsrNA2wKhnIfgU5YzJ6luBCnn14ZQpPEs8GD/4=
X-Google-Smtp-Source: ACHHUZ6mtjreyWHLSNSD2jgcn1qzmjbZFHCHL843OHuaKtI4fNDPB8ShYp157YYZP0vIZZDDiShr2V/kTjkyaQNrr7g=
X-Received: by 2002:a17:907:7fa7:b0:94f:3bf7:dacf with SMTP id
 qk39-20020a1709077fa700b0094f3bf7dacfmr15786481ejc.71.1682967228713; Mon, 01
 May 2023 11:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230426095805.15338-1-ddrokosov@sberdevices.ru> <20230426095805.15338-5-ddrokosov@sberdevices.ru>
In-Reply-To: <20230426095805.15338-5-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 1 May 2023 20:53:37 +0200
Message-ID: <CAFBinCD2FKHsOiHyEDSLmTt2CE_5rUNXgyE4og=XS4Vf1ht5hg@mail.gmail.com>
Subject: Re: [PATCH v14 4/6] clk: meson: a1: add Amlogic A1 PLL clock
 controller driver
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 11:58=E2=80=AFAM Dmitry Rokosov
<ddrokosov@sberdevices.ru> wrote:
>
> Introduce PLL clock controller for Amlogic A1 SoC family.
> The clock unit is an APB slave module that is designed for generating all
> of the internal and system clocks.
> The SoC uses an external 24MHz crystal; there are 4 internal PLLs:
> SYS_PLL/HIFI_PLL/USB_PLL/(FIXPLL), these PLLs generate 27 clock sources.
>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
