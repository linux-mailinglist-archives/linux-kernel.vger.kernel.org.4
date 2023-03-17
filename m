Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E9D6BF119
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCQSyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCQSyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:54:05 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887E59013;
        Fri, 17 Mar 2023 11:54:03 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id s4so2704928ioj.11;
        Fri, 17 Mar 2023 11:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679079243;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNSHz0dzaPcGaUhlIQ9DFb3eNhyN85VR7QYislCiJVQ=;
        b=cqQAuLyUOQuo65JmSkqVZ/Vr2Pkb2Iup09ibiiCD3TZEZnoZjOlNy0zijcl4hQZilB
         e036pqpA5UkTOwSJxnvtvF8Fuewsj4LuZxADyl1WMNRiQS20Lx4008GoNaGQYE0tFuOd
         NfAn5PYBYDeT8ZapTYCnlzlOQzxgHnhvUvNlpShFy+4bB0n+2V1nyBkqwLp2M3K1RlcR
         ROw2BFrFhD0fq7Y1Bf3As26ybm7AO17Rglh6X/utkEo/pA2fVLbkwJVIu6zdppfdtMjR
         DRdSjbAtqxaReVLulYWIRiWbAWAERNSYTQIboQGB390pA8EB5lC2voR0gqqBV/0Li+Us
         P7KQ==
X-Gm-Message-State: AO0yUKVgBmEwiqNr76Gwk+Oeq5i6n7wCZJql+WZgJmzJ5lcbdb5Vekjq
        m1drzzCeeh6xxoGKh1rQFA==
X-Google-Smtp-Source: AK7set/gD0bGTFLwn5DkoYxx6k8UNj0sDqJd4mHH7QgY1nqHumy8NlPpI/IcSPxvF032BSb1iUq40A==
X-Received: by 2002:a6b:e406:0:b0:74e:3b0f:4498 with SMTP id u6-20020a6be406000000b0074e3b0f4498mr400547iog.7.1679079242821;
        Fri, 17 Mar 2023 11:54:02 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id b44-20020a0295af000000b004035b26b6d8sm912267jai.2.2023.03.17.11.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 11:54:02 -0700 (PDT)
Received: (nullmailer pid 2618097 invoked by uid 1000);
        Fri, 17 Mar 2023 18:54:00 -0000
Date:   Fri, 17 Mar 2023 13:54:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, DENG Qingfang <dqfext@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        erkin.bozoglu@xeront.com, William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
Subject: Re: [PATCH v2 06/21] dt-bindings: pinctrl: ralink: move
 additionalProperties to top
Message-ID: <167907923981.2618031.9946159444970518703.robh@kernel.org>
References: <20230313205921.35342-1-arinc.unal@arinc9.com>
 <20230313205921.35342-7-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230313205921.35342-7-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Mar 2023 23:59:06 +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Move additionalProperties to the top. It's easier to read than after a long
> indented section.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml | 7 +++----
>  .../devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml | 7 +++----
>  .../devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml | 7 +++----
>  .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml | 7 +++----
>  .../devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml | 7 +++----
>  5 files changed, 15 insertions(+), 20 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

