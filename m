Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9A5621F58
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKHWat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKHWa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:30:27 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF19A21A4;
        Tue,  8 Nov 2022 14:30:13 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so17864096fac.1;
        Tue, 08 Nov 2022 14:30:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EIyu2ScaB3AbxUJeW+TW/jRCR8cvhLIs+eO6qwh9G40=;
        b=P8XlboiwnUurHAMOyeikQaRC5CJ4M8kL+K/8obGiuJPAe2wJ7Ez8W422laA/K7knyJ
         J75/QXoeUImcyB0SqjfoxmZ+lhVtJCcri3HAMv36/IKh7MTZ+B5zli6cik6BLKZCWk6i
         ICHraCDo05J/F5c/LiooaR8SJy+VSJXbRl2c6fwvgjQuHO/tQCQ+yK3fqqFxoInKVqxv
         ZCYyTeI2+ap+ktkRFR572eKlF4Wue4FyshpvYv8BLaAgK0LndKdSHFxQivcx8Vnj7Nbm
         OWG7dLp/o5CB3SN6OHA2ZcoqL2j5+Q1/DtM+ftjlh+GFn8jmMmntqJlJppLfMnL8lK9M
         +SdA==
X-Gm-Message-State: ACrzQf0CYcLfnyq9/FUvzcnZffwl1IsFBD7CYs3V1xtVorxmrJiCm9qY
        Scpaiu/J9aUDyEPmu11eF4KUf9X9iw==
X-Google-Smtp-Source: AMsMyM4ErTAiEBhhWUnCfkse1uPFXHKxuqvHukpK8jfMZpw4aZEAx3TQfjnc7l2d+tka0EwpvviWtQ==
X-Received: by 2002:a05:6870:15d0:b0:13c:2aa5:d967 with SMTP id k16-20020a05687015d000b0013c2aa5d967mr34222286oad.143.1667946612838;
        Tue, 08 Nov 2022 14:30:12 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 89-20020a9d0c62000000b00661946468c6sm4574509otr.31.2022.11.08.14.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 14:30:12 -0800 (PST)
Received: (nullmailer pid 4095486 invoked by uid 1000);
        Tue, 08 Nov 2022 22:30:08 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>, linux-rtc@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-leds@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20221005-mt6357-support-v4-2-5d2bb58e6087@baylibre.com>
References: <20221005-mt6357-support-v4-0-5d2bb58e6087@baylibre.com>
 <20221005-mt6357-support-v4-2-5d2bb58e6087@baylibre.com>
Message-Id: <166794645623.4092225.9597102589319285416.robh@kernel.org>
Subject: Re: [PATCH v4 2/9] dt-bindings: rtc: mediatek: convert MT6397 rtc
 documentation
Date:   Tue, 08 Nov 2022 16:30:08 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 08 Nov 2022 19:43:37 +0100, Alexandre Mergnat wrote:
> - Convert rtc/rtc-mt6397.txt to rtc/mt6397-rtc.yaml
> - Add mediatek,mt6357-rtc compatible.
> - Add maintainer
> - Remove the .txt binding file
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt   |  2 +-
>  .../bindings/rtc/mediatek,mt6397-rtc.yaml          | 40 ++++++++++++++++++++++
>  .../devicetree/bindings/rtc/rtc-mt6397.txt         | 31 -----------------
>  3 files changed, 41 insertions(+), 32 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.example.dtb:0:0: /example-0/pmic: failed to match any schema with compatible: ['mediatek,mt6397']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

