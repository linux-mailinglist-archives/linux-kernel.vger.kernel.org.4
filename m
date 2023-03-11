Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E7B6B60D5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjCKVD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCKVDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:03:25 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603F537724;
        Sat, 11 Mar 2023 13:03:23 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cy23so34098192edb.12;
        Sat, 11 Mar 2023 13:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678568602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9P7IEAkLy7BcZ65gozk6soUzL4XB53L7ciN8vl0VU/0=;
        b=Mj3NdSmV6a2J+F31S5HW2+G4vNN8mcI76hOLn6I1zFjdXWXC/WZRnhOdQ1QHDp4//Y
         tWsqEHcpJ0vL77yH+bJmT9dUvyUbvpvIm2aGBWddYvljUxFx37/4Ir01a2r5j3FG+Bhi
         wAEft83BiQMHNOJfG/hyrFS3cnfWaJUrYXWxKBWLuIZ+wMhQVdU3dZMEd/Ii2PJ+Bj4v
         w/qom/IQr+gHPL7notTLZLEK+H/qF1i0KERixOqwYAciKCbfmAwHSId9JhJeXMUMlv9w
         TAROnkKZlozadKj+LmMDlngzBKq/PLKyjjV1jm7EnL6izYCIHRwb8tXc2U1lCqjM6lhf
         VMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678568602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9P7IEAkLy7BcZ65gozk6soUzL4XB53L7ciN8vl0VU/0=;
        b=BkyUB++mypT6/3WGDSjEgDIkVv5KtYkjvuZi+HeqaCFHZZVxS+hf5kOVkvR2saFn02
         pYIYsPNC8mg1hjTX79ru7Nlwi1EPIj3HUOTEjWQ2frk+86eETyWORzqBpzLpa169q8mi
         EasPDWQuIe/D1BUs1m2Ya3ZeUTugogMNCkbfGl3EqvIAtthoWOgbr3he1ojNznlN2rUF
         +mfiilTo4vEKY8FHk+yk3eWraDaO4XBz2eFTe97GT0QJjGQNlktz4HGUC8V2YPILR6re
         d7PPkhxQBOxtlSY6o5ZZZtFL08AS+4EEp66lNfVQGUvS86x0vbnpNVQY7IH+78mmIV/n
         JgvA==
X-Gm-Message-State: AO0yUKWcU58NkrBfPSk1vj/4FDVk02cGz+7vYtSXhD2C/fybjGLLRazn
        dOcTsbgQIotADFCZgKy/QY6YNz8rPBmLE4UJqFw=
X-Google-Smtp-Source: AK7set8br7hTajHtR5jJ8JEX+gep6ksiKRlkfXEKJA4TcVnIPNqBQgZ3QlWHqwp9ET29p8c4umTLPKrNN3dT4z5U9yA=
X-Received: by 2002:a17:906:f47:b0:87b:db55:4887 with SMTP id
 h7-20020a1709060f4700b0087bdb554887mr14138887ejj.4.1678568601780; Sat, 11 Mar
 2023 13:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org> <20230310222857.315629-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230310222857.315629-4-krzysztof.kozlowski@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Mar 2023 22:03:10 +0100
Message-ID: <CAFBinCBG90jOdKPubEZvOFXf5B=Ra+HxH6JTTdVn-L1cbWjNYA@mail.gmail.com>
Subject: Re: [PATCH 04/16] spi: meson-spifc: Drop of_match_ptr for ID table
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 11:29=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).
>
>   drivers/spi/spi-meson-spifc.c:434:34: error: =E2=80=98meson_spifc_dt_ma=
tch=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
