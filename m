Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939076D1060
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjC3U4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjC3U4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:56:14 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABC5BDE9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:56:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c18so19307341ple.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680209768;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bk3AJcU0Vx2dUlJVSwRSD2rFIMPkaNP8pt8iHwIyw/I=;
        b=DxOkvfgyGlyZIdctyMoucrRwTgAvwdnFKYHtd6iQSv64o0bLznsU+3yzLh4wHENo5c
         12ynOk18zhZ0y95L2CbIDmbZ8i1k1/QpkV5T+HTRG1mTjVQe4JbSFYLZJjc4p0aK4gNA
         E6eS/ma0+SXAXwlAZkZYsYt325r2yj3PyANVjP+xrTTGesU5N/N0pB5EAtDYO2wU0vL7
         3ZjsPG/j9FxQp/xq1Hd1rrY8bdlANwqVnbNEmgU8g5yzpN0E54kxWlPi8scFowwBX/y+
         s6uKf6ztIucMnzTvdHXCrArvCd40ZLKLpCVtN72XC/258aNlybIufSvn1PhRRkWj1QHP
         tfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680209768;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bk3AJcU0Vx2dUlJVSwRSD2rFIMPkaNP8pt8iHwIyw/I=;
        b=cUS35huy/M8QbitAzngRvD8i4G63+T0jl3WURCGK8glwVVD6IgEdWmZpACWS/Oe692
         YVyOglwVwqzrrobJwzKDwKFutyqIalWnHOob7Niw4FnwVhRCY737GVAeKBg5MmGS6ZSv
         ClBD9an2tMr/q5aPdS4LvJaMxSCCDEeYgQde1nk0RPH+ClB+62MZZ0D3EP8uy9+yeYrU
         cacXnFKFB2WRVUDsUiR1MCS/gSS2PFgpWofP8nusx5F3okg0KZuf5btFlq8nxOI7Vrkb
         fYMhanTgoPai8dg1iBujaEL8FQozZ+vPrBrr1cTrg7OJEqAlFFq7Bm/0Aqce7yqhH8v4
         OVBg==
X-Gm-Message-State: AAQBX9d2ERApEKELt+qQflNyN+wqDKpJcdAuqWOKvOC1/w10Pk4SSv3c
        Yy0eLna1chmp1XSV9VQj65CKlA==
X-Google-Smtp-Source: AKy350YUmLiSO/0zx78yxuNvIBq/d2XMWROc3sNsblZMXAHe6u6xTxhKGFofc2ryyJ1Tl2KTks3vBw==
X-Received: by 2002:a17:903:708:b0:1a1:bfe8:4fae with SMTP id kk8-20020a170903070800b001a1bfe84faemr22003294plb.43.1680209768644;
        Thu, 30 Mar 2023 13:56:08 -0700 (PDT)
Received: from localhost (63-228-113-140.tukw.qwest.net. [63.228.113.140])
        by smtp.gmail.com with ESMTPSA id d19-20020a170902b71300b00198d7b52eefsm128062pls.257.2023.03.30.13.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 13:56:08 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Bernhard =?utf-8?Q?Rosenkr=C3=A4n?= =?utf-8?Q?zer?= 
        <bero@baylibre.com>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 00/17] Improve the MT8365 SoC and EVK board support
In-Reply-To: <CAFGrd9p7oPvhZ8KL40XYfNi2CAdEd8BZWrXPqfcqu7DTSSg4Kw@mail.gmail.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
 <7h8rffyu9x.fsf@baylibre.com>
 <CAFGrd9p7oPvhZ8KL40XYfNi2CAdEd8BZWrXPqfcqu7DTSSg4Kw@mail.gmail.com>
Date:   Thu, 30 Mar 2023 13:56:07 -0700
Message-ID: <7h1ql6yn4o.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Mergnat <amergnat@baylibre.com> writes:

> Le jeu. 30 mars 2023 =C3=A0 02:09, Kevin Hilman <khilman@baylibre.com> a =
=C3=A9crit :
>>
>> Alexandre Mergnat <amergnat@baylibre.com> writes:
>>
>> > This commits are based on the Fabien Parent <fparent@baylibre.com> wor=
k.
>> >
>> > The purpose of this series is to add the following HWs / IPs support f=
or
>> > the mt8365-evk board:
>> > - Watchdog
>> > - Power Management Integrated Circuit "PMIC" wrapper
>> >   - MT6357 PMIC
>> > - MultiMediaCard "MMC" & Secure Digital "SD" controller
>> > - USB controller
>> > - Ethernet MAC controller
>> >
>> > Add CPU Freq & IDLE support for this board.
>> >
>> > This series depends to another one which add support for MT8365 SoC and
>> > EVK board [1].
>>
>> It seems to depend on more than that series.  In order to test this, I
>> tried applying this series on top of Bero's minimal support (now in
>> linux-next), and it does not apply cleanly.
>>
>> Could you please list all the dependencies that are not yet upstream.
>
> Hi Kevin,
> You're right, it also depend to
> https://lore.kernel.org/all/20221122-mt8365-i2c-support-v6-0-e1009c8afd53=
@baylibre.com/

Nope. Something else is missing too.  I tried this series on top of
Bero's series + i2c series and still doesn't apply cleanly.  Look like
some pinctrl stuff is also missing[1].

Kevin

[1]
 Link: https://lore.kernel.org/r/20230203-evk-board-support-v3-0-0003e80e00=
95@baylibre.com
 Base: base-commit 555b3a55823ec063129de4403899203febb58788 not known, igno=
ring
 Base: not specified
       git am /ssd/work/tmp/b4.mbx
Applying: dt-bindings: watchdog: mediatek,mtk-wdt: add mt8365
Applying: dt-bindings: pinctrl: mediatek,mt8365-pinctrl: add drive strength=
 property
error: Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.ya=
ml: does not exist in index
Patch failed at 0002 dt-bindings: pinctrl: mediatek,mt8365-pinctrl: add dri=
ve strength property


