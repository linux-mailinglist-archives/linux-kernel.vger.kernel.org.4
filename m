Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E326BF149
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCQS7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjCQS7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:59:46 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D958722A06;
        Fri, 17 Mar 2023 11:59:18 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id k17so2731550iob.1;
        Fri, 17 Mar 2023 11:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679079539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mC3uYKgiNvme9yguGm1vx6TgKupkEU1KgGa6kF0Cyu4=;
        b=CyAgC8y7Rh7e3A4y2CMKhg4C3iwLid1G0M51d4YGqPj9vGEA0M7DaynuMX547rZEnu
         XWFlvnumuaIQ9gYYjjLEYb4RVbI5HzIX0RrF40XLjtgkuk+V1JspqEoOkw9zTyMmEYB7
         /9MV4+QeojLQcQalT5lKFTh/OFUZiptRTR4FDRqHYfvfaKVvysBpbD52a0LMbo5yLVKq
         QVJu3eB9ftB4bJOakxOGR2691sCncCxPEfqAH7YRb2bycjV5JQ1krie3Td9Cgv4+ToRn
         ZM79z9kFjWLR/6JLc3BhONhWE9aaA5FJVfeyq3Ct9pAGaa7mqAFJKAsyOagpAFOpnU4A
         Vzsg==
X-Gm-Message-State: AO0yUKXs6sSRw0QioLwJKYPqfT7eSTP9gTMsdj7+bpVPcY/etmV3UCiv
        GEZPj3MjRTq5CJLbdvOQoA==
X-Google-Smtp-Source: AK7set8Q6Oi+5SArEQHTumkQimGVtMiGjBRHY4EXfKv9y66wALDCpNc6M+Qhn3u29tT+pkIB7zg9gQ==
X-Received: by 2002:a05:6602:20c4:b0:714:a25:2f91 with SMTP id 4-20020a05660220c400b007140a252f91mr328619ioz.8.1679079538731;
        Fri, 17 Mar 2023 11:58:58 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id h22-20020a056638339600b00374bf3b62a0sm909564jav.99.2023.03.17.11.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 11:58:58 -0700 (PDT)
Received: (nullmailer pid 2625267 invoked by uid 1000);
        Fri, 17 Mar 2023 18:58:56 -0000
Date:   Fri, 17 Mar 2023 13:58:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Sean Wang <sean.wang@mediatek.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-mips@vger.kernel.org, erkin.bozoglu@xeront.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Andy Teng <andy.teng@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        William Dean <williamsukatube@gmail.com>,
        devicetree@vger.kernel.org, Sean Wang <sean.wang@kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Hui Liu <hui.liu@mediatek.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        DENG Qingfang <dqfext@gmail.com>
Subject: Re: [PATCH v2 16/21] dt-bindings: pinctrl: mediatek: fix pinmux
 header location
Message-ID: <167907953495.2625182.8408163490047037852.robh@kernel.org>
References: <20230313205921.35342-1-arinc.unal@arinc9.com>
 <20230313205921.35342-17-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230313205921.35342-17-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Mar 2023 23:59:16 +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Fix the location of the pinmux header files mentioned on the schemas.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml  | 2 +-
>  .../devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml  | 2 +-
>  .../devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml  | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

