Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5696ECB43
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjDXLZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXLZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:25:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FA610E;
        Mon, 24 Apr 2023 04:25:30 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3EB56660316A;
        Mon, 24 Apr 2023 12:25:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682335528;
        bh=l0uXiEnDZ2ULACJcoCCIgBv1dIqJ+NUHoS3OdWQeveo=;
        h=From:To:Cc:Subject:Date:From;
        b=BvfsqqiMm8jbd0sTjSdeqVJq2WscjqOufL6ldhQNMPq/IFRv3V+uGO+J0LB0x92YY
         UvEdoIIwRmtXEA/X5uKhFBwe4B8K6goiDdMCzV/IcDOxnRk41tt2hhZEcLXgzq4gDF
         bwuToe7UO1H8DrEyGuZhNtigOcL2FJm75QRDLWWEK3HF1unX/jr1RmX1bh6FFaxraB
         MSh+cax2jkB5tIh+WdWl3ULAQxwsYcRzX8jilBUA1rjSDQHaQMlX8/yxveO+rsDiTP
         //J//4YWsVahKBjY7sO+kgSYmgiFaiM7gkK2WLknKTe6oryx2UB5erpkZ62s1FQTx0
         9JCKd2XNLxR4w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 0/4] MT8195 Acer Tomato - devicetrees Part 3
Date:   Mon, 24 Apr 2023 13:25:19 +0200
Message-Id: <20230424112523.1436926-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - Dropped tomato-r1 PCIe0 enablement
 - dp-intf aliases addition transferred to mt8195.dtsi
 - Changed thermal zones names and critical trip point temperatures
   for Linux to initiate thermal shutdown before HW protection kick-in.

This series adds support for the WiFi card on PCI-Express,
eDP (internal) and DP (external) displays and adds thermal
configuration for the "extra" thermistors present on Cherry boards.

All Cherry Chromebooks now have working display and wireless
connectivity!

At this point, the only missing component is vcodec decoders, but
that's to be done in mt8195.dtsi, globally, not machine specific.
Please note that in this series the eDP panel was put on aux-bus,
hence this depends on the series introducing support for it [1]
in the mtk-dp driver.

[1]: https://lore.kernel.org/lkml/20230404104800.301150-1-angelogioacchino.delregno@collabora.com/

AngeloGioacchino Del Regno (4):
  arm64: dts: mediatek: cherry: Add platform thermal configuration
  arm64: dts: mediatek: mt8195: Assign dp-intf aliases
  arm64: dts: mediatek: cherry: Configure eDP and internal display
  arm64: dts: mediatek: cherry: Enable PCI-Express ports for WiFi

 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 162 ++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |   2 +
 2 files changed, 164 insertions(+)

-- 
2.40.0

