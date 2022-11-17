Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDCF62D4BE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbiKQIJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239427AbiKQIJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:09:35 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B312EF5D;
        Thu, 17 Nov 2022 00:09:34 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id n21so3092549ejb.9;
        Thu, 17 Nov 2022 00:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mHrJvt3/b8ocan2zs8qQMEVGwjMHNUAgBUCFjsp+mQU=;
        b=q6Ltg4dpREcxyfJavgtB+RA8ZfmfQ4JEzspKSga1zTZpdWBtTYw/PrLDcopwEV4FGj
         Drbc6DGQUUqRlEupRZftUgDSNNO0DiOChwpvDEsESsjp56RYErBOtTjZ07giHSgHlMqs
         HxuKwhVq2oEcccxRdT4Snia3+LYhHHhWrF/Lx4weg0Yurn/T3t9JQvT6CeHP6CX3aep0
         xa4nVjllgJM7Ul47b+3VEQc6QkEBK2to9TFzcls4jlikhE+MplV5jAbsTtBMk6maIbue
         cvy+e6Mz+gFiVf2tqOkBNQ3wEKrgQLWvg9gwpAfvP5cEd7ZCacNP8bJCmA8bEeEgGAdU
         hOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHrJvt3/b8ocan2zs8qQMEVGwjMHNUAgBUCFjsp+mQU=;
        b=UiJKP4htdEklEyjCcLjn96Y/CsRnV69NycoAw8lF5P5aI8y7oWrxZfrGSmhDH6hkkd
         IAZnCwwREd6G87jNk6qVVcDFARCCEQne8KHP7ZpEaZ+XSb34/0y8NdW3SNJNmesgVnni
         Zg9F60+S351QO1AUj70+eCieG+lhoY+yG7FbMtDG9gGYg7OqAA88vthjngCiccHu+iHe
         xtsC7RlsCSrBa2o/erii1Nz1Paa4BfvnLqA6d0OSDTyMcY7sLrjqtHFmqNX3ke/iZLWU
         wVmVJQg08DlKJPG9aPl4OP2L98NsSgOI+4ZyXWChiJ7UX1w4OJgPE1CJi013gFaOMXKD
         9LWg==
X-Gm-Message-State: ANoB5plNT6QP9KM4pkZp4DjxIX0iT+rk9zX5/KSY5V3NfuaJ0ZX3iHze
        MqIhCUZ38Mo05fwnf5dZ2p4=
X-Google-Smtp-Source: AA0mqf7qvFJyguNi0DLyioIgn6dzOu97NdlD5KPXZuhgSEiaIfKNodRZtnNM2FPzVVDdtjO9XRwNUg==
X-Received: by 2002:a17:907:9190:b0:78a:52bb:d904 with SMTP id bp16-20020a170907919000b0078a52bbd904mr1159731ejb.630.1668672572594;
        Thu, 17 Nov 2022 00:09:32 -0800 (PST)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id la18-20020a170907781200b00770880dfc4fsm42192ejc.29.2022.11.17.00.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 00:09:32 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] AD74115
Date:   Thu, 17 Nov 2022 10:09:14 +0200
Message-Id: <20221117080916.411766-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD74115H is a single-channel, software-configurable, input and
output device for industrial control applications. The AD74115H
provides a wide range of use cases, integrated on a single chip.

These use cases include analog output, analog input, digital output,
digital input, resistance temperature detector (RTD), and thermocouple
measurement capability. The AD74115H also has an integrated HART modem.

A serial peripheral interface (SPI) is used to handle all communications
to the device, including communications with the HART modem. The digital
input and digital outputs can be accessed via the SPI or the
general-purpose input and output (GPIO) pins to support higher
speed data rates.

The device features a 16-bit, sigma-delta analog-to-digital converter
(ADC) and a 14-bit digital-to-analog converter (DAC).
The AD74115H contains a high accuracy 2.5 V on-chip reference that can
be used as the DAC and ADC reference.

V2 -> V3:
 * dt-bindings: remove address and size cells specifiers
 * dt-bindings: additionalProperties -> unevaluatedProperties
 * dt-bindings: remove pipe where not needed
 * dt-bindings: use required for adi,digital-input-sink-range-high: true
 * do not uselessly store poll time
 * fix ad74115_adc_gain capitalization
 * inline ad74115_channels_map[st->ch_func] access
 * keep consistent table naming
 * remove aldo1v8 regulator
 * spell out low-power
 * split up resistance offset and scale into separate function
 * use adc_rdy name for irq
 * use microvolt for conv2 range
 * use unsigned int for ad74115_adc_conv_mul
 * use unsigned int for ad74115_adc_gain
 * wrap module_driver call less

V1 -> V2:
 * dt-bindings: add spi peripheral allOf
 * dt-bindings: remove cs-gpios
 * dt-bindings: remove refin supply from example
 * dt-bindings: remove status
 * sort includes
 * ad74115_parse_fw_prop -> ad74115_apply_fw_prop
 * ad74115_setup_{comp,}_gc -> ad74115_setup_{comp,}_gpio_chip
 * gpiod_get_optional -> devm_gpiod_get_optional
 * add support for reset-gpios
 * add support for running without an interrupt
 * fix comma after terminating member
 * fix order of rate and range masks
 * fix reset pin wait time and out of reset time
 * fix rtd mode reading
 * pass chan spec only where needed
 * remove -en suffix
 * remove default 0 values
 * remove diag support
 * remove unecessary prop storage
 * reorder switch cases to match enum
 * set burnout enable bit based on burnout current
 * set default value for props
 * simplify dac hart slew usage
 * simplify prop value validation
 * use bool for 4 wire rtd mode
 * use bool for burnout current polarity
 * use bool for dac sc current limit
 * use bool for debounce mode
 * use bool for din sink range
 * use bool for din threshold mode
 * use devm_regulator_bulk_get_enable
 * use IIO_VAL_FRACTIONAL for resistance offset
 * use struct assignment for gpiochip
 * warn on empty prop mask

Cosmin Tanislav (2):
  dt-bindings: iio: addac: add AD74115
  iio: addac: add AD74115 driver

 .../bindings/iio/addac/adi,ad74115.yaml       |  373 ++++
 MAINTAINERS                                   |    8 +
 drivers/iio/addac/Kconfig                     |   14 +
 drivers/iio/addac/Makefile                    |    1 +
 drivers/iio/addac/ad74115.c                   | 1947 +++++++++++++++++
 5 files changed, 2343 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
 create mode 100644 drivers/iio/addac/ad74115.c

-- 
2.38.1

