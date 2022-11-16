Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A802062C35E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiKPQD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiKPQDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:03:19 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE9651C01;
        Wed, 16 Nov 2022 08:03:17 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1322d768ba7so20579058fac.5;
        Wed, 16 Nov 2022 08:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GFur9ztajNJgyC/h1WU/MLh+XU5LTzLRomeO0X20AEM=;
        b=nAdYWgu6ksaQGxmZLQFkwfjolPuBZ7h+7Qjy+RGp7YW4fdB+l9la2fjNrTSPFTM3Ox
         hffAH4WeZJnW80YnkMqa6bBg8xITtdpgqSRplGkIYAlZnQ6zrsWvRuCRf3a3l2lV6rYy
         slEMig4m76eyXS/mgL8aJuvlPjPyu1qW3H/uiscDkBewiO7k6XmYZbMJibi1kt0KFWzC
         Plmua8VsHFcWIH0z/KHSxECdg4Zr2RFoRrhCXL6o6GnTEtWHNSsygRUkBVAcY0Om6UDf
         oET7HoN6XuTJs1yXeVNgTs7pixu93cleyDBhO7ZzZiCxVcRRJ7xo+xIx6v59Wja9fzm7
         8c7A==
X-Gm-Message-State: ANoB5plset6OgEQjCViql+3+SgVap61xyZmNPy/NVAJv1aJbJOVXwNcw
        0ecUCGr9r/pCYOr2r/ftJw==
X-Google-Smtp-Source: AA0mqf5XdhzHlaYo1ZV4BEyVQHRU/bRF0T8tEBEf7/gwzL9OR8nfhFXlbYyBvHSwysBdzNF8BwK8yQ==
X-Received: by 2002:a05:6870:f10f:b0:137:5344:7776 with SMTP id k15-20020a056870f10f00b0013753447776mr2013082oac.208.1668614596948;
        Wed, 16 Nov 2022 08:03:16 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n19-20020a9d7413000000b0066cb9069e0bsm6863694otk.42.2022.11.16.08.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 08:03:16 -0800 (PST)
Received: (nullmailer pid 158015 invoked by uid 1000);
        Wed, 16 Nov 2022 16:03:18 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     linux-input@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>,
        Fabien Parent <fabien.parent@linaro.org>,
        linux-leds@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Flora Fu <flora.fu@mediatek.com>, Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen Zhong <chen.zhong@mediatek.com>
In-Reply-To: <20221005-mt6357-support-v5-5-8210d955dd3d@baylibre.com>
References: <20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com>
 <20221005-mt6357-support-v5-5-8210d955dd3d@baylibre.com>
Message-Id: <166861435469.151514.16192567175686360100.robh@kernel.org>
Subject: Re: [PATCH v5 05/10] dt-bindings: mfd: mediatek: Add bindings for MT6357 PMIC
Date:   Wed, 16 Nov 2022 10:03:18 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Nov 2022 13:32:59 +0100, Alexandre Mergnat wrote:
> Currently, almost all MT63XX PMIC are documented mfd/mt6397.txt.
> Unfortunately, the PMICs haven't always similar HW sub-features.
> To have a better human readable schema, I chose to make one PMIC schema
> to match the exact HW capabilities instead of convert mt6397.txt to
> mediatek,mt63xx.yaml and put a bunch of properties behind
> "if contain ... then ..."
> 
> - add interrupt property
> - change property refs to match with new yaml documentation
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  .../devicetree/bindings/mfd/mediatek,mt6357.yaml   | 105 +++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml references a file that doesn't exist: Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml: Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

