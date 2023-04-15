Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F277F6E2E61
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 04:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjDOCCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 22:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDOCCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 22:02:33 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DD84C22;
        Fri, 14 Apr 2023 19:02:32 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54f80e173ecso1839317b3.0;
        Fri, 14 Apr 2023 19:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681524151; x=1684116151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yc9UZCD0Thr43ELkRCLRaL1wv9oH/Wsg9/Asqvkeq74=;
        b=hNGwWzo5Q3ABHTH1/bHqV8wpeBC3BY9+vFkyLdS4ysjfkGBg6ARqQpLmQg1XhKE1Ad
         zUwgNg8vej6GzQrU6bA9rvRCr44iwfrn4XiTzg1kGWZs4qx5y84vbEtjfE92HzchF8w0
         hA5O4Gq54yfu9WUKASvDGDkA462iFUKT0c7dKuHOB58FaJ5bJTgfk6AyuH4LJJs+SFgR
         6luAkQA4k55mwFk20RsSXL1jTnUdgtchEXVqRBljUK/Yp5I6PY+CN6QHbjqhJlESiD2P
         a+QmioUIc1vwj2HrWdwf+IbK/vFCXim9p3Fhiygk6KCM5ir7BO4HapVs/4Lt3XKWF2wy
         3DDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681524151; x=1684116151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yc9UZCD0Thr43ELkRCLRaL1wv9oH/Wsg9/Asqvkeq74=;
        b=Bm1JT0u51ZFfJ1y7fjikiRxSGxNvg6oiDw/rv/bc5OP+MUSjf/WiE5TrvwcEC/wmCe
         qlDAjT4KO6nBAhdiB5kPQV3HRIYJsnCqaFUZ22a6uKBY1mY7zhwH9H4f+8wNgBhcGrKe
         aGd8uGCXu+LZqLSu6sK7qPyt2ICrePFXNxbH/DfVwVfim8UuTI2ws5lYT8Ktfpmti+8d
         Hye7YBCtIPGtK/s5Xe+IuCDsFRSVb5YUsJQoKjyXZTx/IHhzu2TWpHNNVoeohCvUbsJS
         V2mpcAD1tcVczIOQpm92kb6g9WW43qRUZOEFWdXzLlSkehmQ3HBuZouIfnrDHYpVmGij
         JtMQ==
X-Gm-Message-State: AAQBX9dE7slCrAU+oxNGJXGHPDI5LQHe4Pas4/alkYJO1NkXBeQrbbP/
        4g6AzOX36ugh5YJZt2DIGFs=
X-Google-Smtp-Source: AKy350YkXBNOHfyjGAwIFs2cRWfuozknDP+ROfbjnUSQ1sGSCBEZQcfRRlX4kPEaEMsAtRkuwZ6/iA==
X-Received: by 2002:a81:e10:0:b0:54f:a9e4:e79 with SMTP id 16-20020a810e10000000b0054fa9e40e79mr3803040ywo.2.1681524151546;
        Fri, 14 Apr 2023 19:02:31 -0700 (PDT)
Received: from JOEL-DESKTOP.. ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id 68-20020a810a47000000b00545a081847fsm1593607ywk.15.2023.04.14.19.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 19:02:31 -0700 (PDT)
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
To:     Caleb Connolly <caleb@connolly.tech>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jeff LaBundy <jeff@labundy.com>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH v3 0/5] Add support for Focaltech FTS Touchscreen
Date:   Fri, 14 Apr 2023 21:02:17 -0500
Message-Id: <20230415020222.216232-1-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:(Suggested by Krzysztof Kozlowski and Konrad Dybcio)
--------------
- dts: removed the invalid "input-enable" property
- dts: replace interrupts with interrupts-extended
- dts: removed redundant dma configuration
- dts: reorder pinctrl and pinctrl-names
- bindings: moved unevaluatedProperties after required
- bindings: make interrupts a required property (new change from my end)
- bindings: update example based on dts changes

I have made the interrupts a required property in the bindings as the driver
will not function without an interrupt. Because of this new change, I have not
picked up the reviewed by tag of Krzysztof Kozlowski for the bindings.

Changes in v2:
--------------
1. dt-bindings changes (Suggested by Krzysztof Kozlowski)
	- changed file name from focaltech,fts.yaml to focaltech,fts5452.yaml
	- removed focaltech,max-touch-number property, handled in driver now
	- removed touchscreen-* properties and used unevaluatedProperties: false
	instead of additionalProperties: false
	- fixed the example dts node name to be generic
	
2. FTS Touchscreen driver changes (Suggested by Markuss Broks and Jeff LaBundy)
	- removed repeated license terms since SPDX tag is used
	- includes are now sorted
	- added the missing input_mt_sync_frame when reporting touch
	- focaltech,max-touch-number is no longer read from dts and instead
	specified in the driver as compatible data.
	- removed redundant __set_bits
	- input_mt_init_slots is now called after the axes are defined
	- irq handler now returns IRQ_NONE when there is an i2c error
	- other minor fixes and refactoring as suggested
	- renamed driver filename from focaltech_fts.c to focaltech_fts5452.c
	(Suggested by Krzysztof Kozlowski)
	
3. dts changes (Suggested by Krzysztof Kozlowski)
	- use generic touchscreen nodes
	- removed focaltech,max-touch-number property
	- irq type was specified wrongly for Poco F1 in v1. Changed the irq
	type to IRQ_TYPE_EDGE_FALLING as that is correct.

Some Clarifications on v1 comments:
-----------------------------------
1. Jeff LaBundy suggested I could read chip id with the following:
	__be16 val;
	regmap_raw_read(data->regmap, FTS_REG_CHIP_ID_H, &val, sizeof(val));
But this is not possible because FTS_REG_CHIP_ID_H and FTS_REG_CHIP_ID_L
are not continuous register, therefore reading it together as 16-bit values
will not work. So I went with what Markuss Broks suggested:
	regmap_read(data->regmap, FTS_REG_CHIP_ID_L, &id);
        regmap_read(data->regmap, FTS_REG_CHIP_ID_H, &val);
        id |= val << 8;

2. As Markuss Broks suggested, I tried to cast the buffer to struct, but 
unfortunately was not able to successfully do it. The buffer layout is 
weirdly split into 4 bits and 12 bits at someplaces which makes it hard 
to cast into a struct. For example, we can note
	type = buf[base + 3] >> 6
	x = ((buf[base + 3] & 0x0F) << 8) + (buf[base + 4] & 0xFF);
Here at buffer index 3, the first two bits (>>6) are used for denoting
event type. The next two bits are not used. But the last 4 bits (&0x0F)
of buffer[3] are added with buffer index 4 to get the x position. 
I don't know how to handle these when casting to a struct. I tried
experimenting with bitfields in struct, but to no avail. So I am sticking
with my initial implementation for now.

Kindly let me know if any further improvements are needed. Thanks.

The Focaltech FTS driver supports several variants of focaltech
touchscreens found in ~2018 era smartphones including variants found on
the PocoPhone F1 and the SHIFT6mq which are already present in mainline.
This driver is loosely based on the original driver from Focaltech and
the patches submitted by Caleb Connolly previously[1] but has been
simplified and largely reworked.

[1] https://patchwork.kernel.org/project/linux-input/patch/20220123173650.290349-3-caleb@connolly.tech/

Joel Selvaraj (5):
  dt-bindings: input: touchscreen: add focaltech,fts5452 touchscreen
  Input: add driver for Focaltech FTS touchscreen
  arm64: dts: qcom: sdm845-xiaomi-beryllium-common: add touchscreen
    related nodes
  arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg: introduce support for
    fts touchscreen
  arm64: dts: qcom: sdm845-shift-axolotl: update focaltech touchscreen
    properties

 .../input/touchscreen/focaltech,fts5452.yaml  |  71 +++
 MAINTAINERS                                   |   8 +
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    |  18 +-
 .../qcom/sdm845-xiaomi-beryllium-common.dtsi  |  37 ++
 .../dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts |  21 +
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/focaltech_fts5452.c | 432 ++++++++++++++++++
 8 files changed, 590 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/focaltech,fts5452.yaml
 create mode 100644 drivers/input/touchscreen/focaltech_fts5452.c

-- 
2.40.0

