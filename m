Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9826B04BA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjCHKkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjCHKkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:40:16 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862529BE24
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:40:15 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso853159wmo.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678272014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kRt6WpwvIBdAlT9GjoYenrjmoiuuxf6pyvSRjhj1Zk8=;
        b=P22IwubSswfi5Y1ZOPXW0kJgYGFtJKeYzWgoDnpdOOvHv2DtgD34zPQITW0TFucU55
         1yHrwLoimyc90xed+aRwK+OujXY4zKkuX9uTH9tOeNmDzcBz0J09RIqej3RPHC80ELdU
         KWCM8cn5NrrJlziMXepiPu0Ah/oZFNYWdbmnb8vBtBnCutNpYIrh4Lg6i7OASn2uVJ98
         ck2caaQARl6tAJnttJN1BIdQ3pGWn77oHrU8FZS9hNxJeB0Ztbr3F3YvjcmIdOTytaci
         /1lqWG7ytz3D16u4cLi5CChi//MQCw3EVHbZBqSl7Hw7WXQtAeI27bPkmxepKd/GGmks
         2TIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678272014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRt6WpwvIBdAlT9GjoYenrjmoiuuxf6pyvSRjhj1Zk8=;
        b=ftwovdYnN/4pimGstcaZDVilZ+izsXU0TaEoxR/HHj2ZIG5TTDqlHmxP3FRivCla48
         0V4f37lJSlbOLeefVsC7g4MZMA81y+RgB0nw8gvkOxxTjdyf4rCgqvXYDHagGnbH/wZj
         Lw6xxmwRSt3dCbVLIr43aiXT9HfPfU+itJrGfj/ZErVDByElHjzn2eNWrJ+r9m7uHb5D
         bOLtDsaVq2v7VXxwDjPbjefFXLjmC+7S84ahYi2tGLY/za+JX1aG9/+y44Kwv0g2e/QG
         KltKrBeF/anR8liO0DUfIJuUuhmd7+7slxTllQSeLbADka4wzRjkisqz0uE92grdICEj
         ANbA==
X-Gm-Message-State: AO0yUKXllYisIM/pTNmF5EK8XuE7kbwjtWvmt2bHWmL0UXKpBa5K4L+p
        EDyvrzksGllaIKIrIZ6QTrGLFg==
X-Google-Smtp-Source: AK7set9dVGEfZHhUM3HA8qAwJI7yFv02IvknxgLGZkwoV/7kENikLbazTYXO4xLFyFJjDDZJUac+vQ==
X-Received: by 2002:a05:600c:4fc2:b0:3eb:37ce:4c3e with SMTP id o2-20020a05600c4fc200b003eb37ce4c3emr16327392wmq.16.1678272014061;
        Wed, 08 Mar 2023 02:40:14 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2326:fd4c:82e3:7e07])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c444700b003eb0d6f48f3sm20664135wmn.27.2023.03.08.02.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 02:40:13 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 0/9] arm64: dts: qcom: sa8775p-ride: enable relevant QUPv3 IPs
Date:   Wed,  8 Mar 2023 11:40:00 +0100
Message-Id: <20230308104009.260451-1-brgl@bgdev.pl>
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

This enables the QUPv3 interfaces that are exposed on the sa8775p-ride
board: I2C, SPI and the Bluetooth and GNSS UART ports.

v3 -> v4:
- use interconnect constants instead of magic numbers where applicable
- pad addresses in reg to 8 digits
- group pins under state nodes for UART

v2 -> v3:
- fix the interrupt number for uart12
- replace underscores with hyphens in DT node names (although make dtbs_check
  does not raise warnings about this)
- rearrange the commits so that they're more fine-grained with separate
  patches for adding nodes to dtsi and enabling them for the board

v1 -> v2:
- uart17 is the Bluetooth port, not GNSS
- add uart12 for GNSS too in that case

Bartosz Golaszewski (9):
  arm64: dts: qcom: sa8775p: add the QUPv3 #2 node
  arm64: dts: qcom: sa8775p-ride: enable QUPv3 #2
  arm64: dts: qcom: sa8775p: add the i2c18 node
  arm64: dts: qcom: sa8775p-ride: enable i2c18
  arm64: dts: qcom: sa8775p: add the spi16 node
  arm64: dts: qcom: sa8775p-ride: enable the SPI node
  arm64: dts: qcom: sa8775p: add high-speed UART nodes
  arm64: dts: qcom: sa8775p-ride: enable the GNSS UART port
  arm64: dts: qcom: sa8775p-ride: enable the BT UART port

 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 99 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi     | 87 ++++++++++++++++++++
 2 files changed, 186 insertions(+)

-- 
2.37.2

