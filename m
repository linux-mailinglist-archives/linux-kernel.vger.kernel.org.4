Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E76574CE54
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjGJH1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjGJH1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:27:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55920127;
        Mon, 10 Jul 2023 00:27:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-991ef0b464cso1039155866b.0;
        Mon, 10 Jul 2023 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688974036; x=1691566036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12SwgujBvNm5u6+5Cu/MHnSp3kLy9fw9popJaOP4K9Q=;
        b=PJQD/wf5Fs/m/YMEnq5E9JP76DgiHcJ1H7b+cbPxL5uR+FHrHl7b4GCPqrkiapTaRC
         J/Y/Th0wXawHmwDoBFij1OoWYzF6j8Bv/gI8QDaIer+GsUpOBrYSI+7A814pohqJpp7O
         68R+i8cwuv5DbppV/y0qmOCYjxUT3nebMb/lBmtcQjqr3v2tnZAko7Zqj8lQMUs3TegK
         1VsQcskWZohLsVDbytT6haoN9l2xD7nDIJixSTDmHGlxay46ExVAif/l9PWikv3CRem8
         6axXdNPzp+hZT+XetQgTzlrEtmgbAaHxI2+LDMloQM6pyn2HfY0su1IbRfLVdq4RBc3Q
         AQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688974036; x=1691566036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12SwgujBvNm5u6+5Cu/MHnSp3kLy9fw9popJaOP4K9Q=;
        b=Eyenw6r58JP6ZCYPxcTLdffTHwZkqafPV8wWd8/4+Za4MXdthoWpc9pH86Jc8ugCuY
         FjkBw2hZAZNjtARJ05gaVuG0MMkV/lIC9FKa1wsyN1qq/3v5DOJxr5w55QTm7d+r3r7G
         krqK3ZOJVglReX2jXep7Zl03iE8z0xH8C4p5QoAYDrgMnNt3RSeOlwJNWEHDf9A1EobJ
         jcmRRGYSZWwhoWXIRc1Jn+yxBDzJGL45sYNZgDny+0D8um6kuqCULOuZVkrktGFqlstE
         81z2Kr5wMaRc+TQb2Qaq/aL2TVJuZdX8R1h7pm/+lV3o8aHI+LWO2pezjbzOThWANjWs
         +4XA==
X-Gm-Message-State: ABy/qLanE6dTwGH37C44oMrfJeZPJx/9rRu1YG6EVfjOGdgEX/W0YWV6
        j//d0FB/WpTOkeBnVMDq8vBFAHoehByiV43FIuQ=
X-Google-Smtp-Source: APBJJlELkCEdlXye8US5g/6R435+/ePCacMKC+8upB0zYkVGAIV+dy+ir9Yfy3SW1NAV08Y/UbPfQrhop57vhspWmxA=
X-Received: by 2002:a17:907:6d1f:b0:993:22a2:9234 with SMTP id
 sa31-20020a1709076d1f00b0099322a29234mr19989579ejc.31.1688974035627; Mon, 10
 Jul 2023 00:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230710042812.2007928-1-huqiang.qin@amlogic.com>
In-Reply-To: <20230710042812.2007928-1-huqiang.qin@amlogic.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 Jul 2023 10:26:39 +0300
Message-ID: <CAHp75VcEUre4RVAoMO0Tg1uRdeOBr-ZLeX9ppNx+Nc0ZdSrtiA@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] Add pinctrl driver support for Amlogic C3 SoCs
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 7:28=E2=80=AFAM Huqiang Qin <huqiang.qin@amlogic.co=
m> wrote:
>
> This patch adds pinctrl driver support for Amloigc C3 SoC (C308L and C302=
X)

Neither here, nor in the patch I see the changelog. Can you elaborate, plea=
se?

--=20
With Best Regards,
Andy Shevchenko
