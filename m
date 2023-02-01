Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12CC686A03
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjBAPV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjBAPVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:21:23 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AD15253
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:21:17 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so1732888wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=87tvueRd2jMJ3I0zmFC1ExMPpE2u2ENBfUILZoyxQTw=;
        b=lk6Z1f/dTiXfiWKLliINNJnni4OHlyqmAvr/jR936PbaXeiCk14SDsO8QLDXIEhOUQ
         U6nhqwrYndkpETIiYi/SHMZP+8ivpMgcL0dTsREKAXiLMXr4y/o/VLYlcsFI/tivxm+i
         DSb53kh2mOgPf55zKCoAaAGVLkd/GgHHbiJXx2YoQPqLdYenN2zeEfO1w6j/wohQC5YB
         EAgROM0VnDAvqB6RtmljoNqSwPKauS1dtbgDJOHpr99amWi15M/9uIzelOtByfMVtgYX
         PNpB5KAq1I/WgFffRKZfA77sG6kH3hM5Rfch9Z0NzRiLm4xi3wCp5YmTuHC/TnnISL8A
         NYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87tvueRd2jMJ3I0zmFC1ExMPpE2u2ENBfUILZoyxQTw=;
        b=XCzslvgMmERfCyzRiEYMdLPy35lQKWi/t0RKD+PTGwrJ2df9Z+ZmJSZaL+NAxp9VwD
         S5ERCubUQxueyKLOgXBCKuAaTtfxMu/evcVOGqhPYguB7QFAqcmHPyrjJbjdnWhh85dx
         FVOI5gG2fSfM+ZMMcSXGybsqTb7/UOcNsrOU8GCOtqSu6Z/4wJvtGt+yKFV98j3l9GuZ
         30P6VlanWk9EbkWqBtMlkFHky15JIGrOyZhjLkKxX0yROWr9Yvzbb6wAUfwPHy2dHVst
         UxXauvQWI0nxivFZk6VaPuuMm5ZIspacUURX69tC7zMEji7RywrqPib37hYEs7Rzak9o
         TsjA==
X-Gm-Message-State: AO0yUKWnKV7+60iMlei3j0G7U0uy5f+NgYYGfdR0XrZFHK8D+MVUG170
        jLOGBXzi1J0SZxlJnZSDYQoaIQ==
X-Google-Smtp-Source: AK7set8DA60s1ZaHq4wltMareWdZQqQaP1m3qNr/7luxj+0055vEF0R7zqjgLFyvlToBICe4bCI1Lw==
X-Received: by 2002:a7b:ce94:0:b0:3dc:43a0:83bb with SMTP id q20-20020a7bce94000000b003dc43a083bbmr2582411wmj.3.1675264876040;
        Wed, 01 Feb 2023 07:21:16 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d64:a4e6:40a8:8e69])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c42d300b003dc53217e07sm1893120wme.16.2023.02.01.07.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:21:15 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 0/5] arm64: qcom: add initial support for qcom sa8775p-ride
Date:   Wed,  1 Feb 2023 16:20:33 +0100
Message-Id: <20230201152038.203387-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This iteration contains a fixed DTS and all not already applied DT bindings
patches (with tags collected).

v2 -> v3:
- reorder properties (reg always first, etc.)
- tweak node names
- remove properties filled in by the firmware

v1 -> v2:
- lots of improvements all around the place to make the dts pass dtbs_check
  (with some additional patches fixing bugs in existing dt bindings),
  make dtbs W=1 and checkpatch.pl
- move board-specific properties to the board .dts file
- ordered top-level nodes alphabetically and sub-nodes by the reg property
- fixed licensing
- set #address-cells and #size-cells to <2> in the soc node and update sub-nodes

Bartosz Golaszewski (5):
  dt-bindings: firmware: qcom,scm: add qcom,scm-sa8775p compatible
  dt-bindings: mailbox: qcom-ipcc: document the sa8775p platform
  dt-bindings: watchdog: qcom-wdt: add qcom,apss-wdt-sa8775p compatible
  dt-bindings: arm: qcom: add the sa8775p-ride board
  arm64: dts: qcom: add initial support for qcom sa8775p-ride

 .../devicetree/bindings/arm/qcom.yaml         |   7 +
 .../bindings/firmware/qcom,scm.yaml           |   1 +
 .../bindings/mailbox/qcom-ipcc.yaml           |   1 +
 .../bindings/watchdog/qcom-wdt.yaml           |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts     |  47 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 812 ++++++++++++++++++
 7 files changed, 870 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-ride.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sa8775p.dtsi

-- 
2.37.2

