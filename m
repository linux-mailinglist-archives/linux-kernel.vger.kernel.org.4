Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217636B60D2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCKVDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCKVDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:03:13 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9F9222E4;
        Sat, 11 Mar 2023 13:03:12 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ek18so3075020edb.6;
        Sat, 11 Mar 2023 13:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678568590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJFf8GLtxWXihMug6P0OGoX7CTL7k0wwiBVKeyB4Rpo=;
        b=pT9GDSN4DyEtHNbHsKZm+0xijlTsTvbU5bIPzBadlF8tLIGLblNyzLF4VXQ5dN+1oa
         02KI9Pn8XbTyDnI8AiRekzeA6P7tcsqysl4FxqJI5Jgtv/j8ItblEFdxVnlu54pNyDzI
         83gLA8eoM0Sq8GzdHd/ogzYcPvjE2IMcJ+H1qt91TXwL6K8oAQEoluoIpDI3rSd8PyOc
         WG236kfMedjpEUs/ovKGbEJZVCyuXzPNUisPfHjJShXO3TgDDTdiy+uRcM3QGSdMvD+4
         VKmda1fshPzwDmkAkuA3fGsMg3b/1zrwzvnoc/Wpk0Ha3L8ybVW7WxZGOaYnrLQUu/al
         5JNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678568590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJFf8GLtxWXihMug6P0OGoX7CTL7k0wwiBVKeyB4Rpo=;
        b=feI05ue4Z2HoPhbLGoVZrUMDRufrxr5/TA/1UXz84RrCzXBWIWj4GJwdglKBEALBHB
         1NLiFeXc1AFIIrYTZ8BnVM9inddeV20tLZ5bPJjGQfzvSuB1kE+eTDjjXVCdH/ZYNIzj
         Q5S2A3rXVv33KMgUHnXuU7WZH3WcWTStoLrR6dihaGQOEX0vNDjmhCctyC7ZVlrWZyOp
         LFPUigJ2nIYN+wjr+IpZY4Jb+zOGf/6UQ1caXO4qqB75zBeK2NckveMXM/V+rwT21sAI
         0aCIVu2J0q31Q4UOhdD+9Xlk++cPVDM4APf6dtEG1yCQhE4LNkUqgkl+O9mGz3z2ILB9
         SXag==
X-Gm-Message-State: AO0yUKUsZdm9QXBOa3kvoz0COpC3TWIAkycyjYE2mf/W3VP4tCNz3Q0c
        20v7YeoVyV+KaWq6TK/+n0h3kNOUvdB7AImfFFk=
X-Google-Smtp-Source: AK7set+nsdI6U8Akb2Epvh5TLqA4QBXyUOxE40/FSbMxrjd9iHwvD/RJEhXoH5zYK9ZKzGCHNnhGvBPHX4D8aOQhPFs=
X-Received: by 2002:a17:906:a1c5:b0:8f0:147b:be2 with SMTP id
 bx5-20020a170906a1c500b008f0147b0be2mr14063306ejb.4.1678568590629; Sat, 11
 Mar 2023 13:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org> <20230310222857.315629-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230310222857.315629-3-krzysztof.kozlowski@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Mar 2023 22:02:59 +0100
Message-ID: <CAFBinCCZAjbuE-1hgJSUoW=GNT80Y7xReNW2D84H7YJ=yHVPxw@mail.gmail.com>
Subject: Re: [PATCH 03/16] spi: meson-spicc: Drop of_match_ptr for ID table
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
>   drivers/spi/spi-meson-spicc.c:949:34: error: =E2=80=98meson_spicc_of_ma=
tch=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
