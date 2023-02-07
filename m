Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7FF68D2E5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBGJdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjBGJds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:33:48 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121F220D02
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:33:45 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so752558wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 01:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=8PxGYDQ7050hUgTLYscGuzXllbJKzPjPKyLOB6Wlrjo=;
        b=nseoynKl6Jy2ScxAfRj0HrX7qUwIqGb7zjc0T/2N+jzmisGjIBhcZe8qX/r3oVew9m
         mgJL4de/kMuVjooR8M1HCLyjb/2XN8Q8rSyM5d8ZD/Zd1uBdBDXsdPvhGppXPdc2a9ad
         QH4TAJDrSM0nmaOc4bDruO2gCEe3gjaJNv/2dOik3H51S9XcFV2w+7gLFrQFpGX9Ypmk
         ahPzZsZyUToaSmcOF/lIPrU5fYksdDze985GVR4bEw0NVhHgfpr8GSAhqIvXBUWIeEnz
         ACl01bAYJz5NUWcKdW4XrxzPSkFvr8T8spCFCRcy5LufICxWpWBGq1Husqvlsu9b4TW3
         D85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PxGYDQ7050hUgTLYscGuzXllbJKzPjPKyLOB6Wlrjo=;
        b=XYyNrLpwxFvthW18/cJjZHXFb0WvxBpYb5ZsUPudigOM4VyVMNXIOy3rCrJMoPSBhM
         HnFrJKPdwGIF4Y3tGjuQyBZPiE+cl7w5tDQbddnHyjcEHO3R879IUze2qh4zZRfjvScX
         KhWmA9m/jDMd/XM+p8gOkTTm6hT0cAf9JoFlAf4WHniMOnn0eSt0/T9tGIuv5iFeMmha
         Z+/SLUV2/vWftUjKRtDZukxoKA3CBX6/Q7OP0s3CccmuAXQVk6w0bopWXYOFW9k7niMi
         8VAXSesJI/tbkknZgBSkB5JnBPa37yf7bsf+RW2MUR2/gZ50jkt1TUEOc67vyRHe8/fx
         yMfg==
X-Gm-Message-State: AO0yUKU0ZACXbkun+3TsxknKOnYYYTGcDlh0uGfWrZ+kyXUbUVkaR3Ow
        +emn7y2MUeQmjffkfuhm1Gb4kg==
X-Google-Smtp-Source: AK7set9PZDReFALR1aMtqwOzve4hwOZf9PGErxwjDd/BKVseEzEILgyBlESqGUn3B5zmiP3nYCTErA==
X-Received: by 2002:a05:600c:1817:b0:3df:e54a:4ac5 with SMTP id n23-20020a05600c181700b003dfe54a4ac5mr2468276wmp.27.1675762423657;
        Tue, 07 Feb 2023 01:33:43 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c450600b003dc433bb5e1sm14240200wmo.9.2023.02.07.01.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 01:33:43 -0800 (PST)
References: <20230206153449.596326-1-jbrunet@baylibre.com>
 <20230206153449.596326-3-jbrunet@baylibre.com>
 <167571334291.1212116.1869881432057405431.robh@kernel.org>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 2/7] ASoC: dt-bindings: meson: convert axg tdm
 formatters to schema
Date:   Tue, 07 Feb 2023 10:29:51 +0100
In-reply-to: <167571334291.1212116.1869881432057405431.robh@kernel.org>
Message-ID: <1j7cwt3jm1.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 06 Feb 2023 at 13:59, Rob Herring <robh@kernel.org> wrote:

> On Mon, 06 Feb 2023 16:34:44 +0100, Jerome Brunet wrote:
>> Convert the DT binding documentation for the Amlogic tdm formatters to
>> schema.
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  .../sound/amlogic,axg-tdm-formatters.txt      | 36 --------
>>  .../sound/amlogic,axg-tdm-formatters.yaml     | 88 +++++++++++++++++++
>>  2 files changed, 88 insertions(+), 36 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
>>  create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml
>> 
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> ./Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml:
> Unable to find schema file matching $id:
> http://devicetree.org/schemas/sound/component-common.yaml

This is a false error because the bot does not have the patch applied
by Mark from v1 here [0]

[0]: https://lore.kernel.org/all/167543616131.928818.17902040818579023398.b4-ty@kernel.org/

> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.example.dtb:
> audio-controller@500: False schema does not allow {'compatible':
> ['amlogic,g12a-tdmout'], 'reg': [[1280, 64]], 'resets': [[4294967295, 12]],
> 'clocks': [[4294967295, 35], [4294967295, 127], [4294967295, 120],
> [4294967295, 134], [4294967295, 134]], 'clock-names': ['pclk', 'sclk',
> 'sclk_sel', 'lrclk', 'lrclk_sel'], '$nodename': ['audio-controller@500']}
> 	From schema:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230206153449.596326-3-jbrunet@baylibre.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.

