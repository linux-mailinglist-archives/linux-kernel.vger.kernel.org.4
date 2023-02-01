Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E4E6868B0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjBAOnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjBAOnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:43:12 -0500
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6052E82E;
        Wed,  1 Feb 2023 06:43:03 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 75799BFC6C;
        Wed,  1 Feb 2023 15:34:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1675262091; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=jpzkr24nHKJp5IYEK48VP/WYJnaAAqAY3mtPMKQ4JTk=;
        b=EyhNDpImLtYrLnSp9RszhmfZjgngLI5STcz8zOdrh17GinHCp5YJE3zgtszbPSiQnpAnae
        xNdr4zrlZ0mKxAUaBUSqQJuGlTP2/pCqfbrB5/hovHvR+PojO5PttjnGFIcnjJ31qp23nr
        KdZlZTyJbhqvHE24LaQGzhdy4qYwLM4nxNYHAe/PUIY61wf7idcvDamcz4jI6virl51pHY
        jpdHe8kKUEDGJjPiRr0KhLIL4GZhloH23lwsCEaQ1ykSVM7YcpFDTIMNYXmkKDs1IVwsqR
        A9x7BKDpE/1rj0AeNSB3yW+hOWuKYYiBQdV0CGzRcpIomE9IBP6lCZc8K2iNeA==
From:   Frieder Schrempf <frieder@fris.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 0/7] Enable backup switch mode on RTCs via devicetree
Date:   Wed,  1 Feb 2023 15:34:22 +0100
Message-Id: <20230201143431.863784-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Some RTC devices like the RV3028 have BSM disabled as factory default.
This makes the RTC quite useless if it is expected to preserve the
time on hardware that has a battery-buffered supply for the RTC.

Let boards that have a buffered supply for the RTC force the BSM to the
desired value via devicetree by setting the 'backup-switch-mode' property.

That way the RTC on the boards work as one would expect them to do without
any per-board intervention through userspace tools to enable BSM.

Frieder Schrempf (7):
  dt-bindings: rtc: Move RV3028 to separate binding file
  dt-bindings: rtc: Add backup-switch-mode property
  dt-bindings: rtc: microcrystal,rv3032: Add backup-switch-mode property
  rtc: Move BSM defines to separate header for DT usage
  rtc: class: Support setting backup switch mode from devicetree
  arm64: dts: imx8mm-kontron: Remove useless trickle-diode-disable from
    RTC node
  arm64: dts: imx8mm-kontron: Enable backup switch mode for RTC on OSM-S
    module

 .../bindings/rtc/microcrystal,rv3028.yaml     | 60 +++++++++++++++++++
 .../devicetree/bindings/rtc/rtc.yaml          |  7 +++
 .../devicetree/bindings/rtc/trivial-rtc.yaml  |  2 -
 .../dts/freescale/imx8mm-kontron-osm-s.dtsi   |  3 +-
 drivers/rtc/class.c                           | 14 +++++
 include/dt-bindings/rtc/rtc.h                 | 11 ++++
 include/uapi/linux/rtc.h                      |  6 +-
 7 files changed, 95 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
 create mode 100644 include/dt-bindings/rtc/rtc.h

-- 
2.39.1
