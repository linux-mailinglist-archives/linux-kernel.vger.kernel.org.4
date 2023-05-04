Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FF56F6276
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 02:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjEDAtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 20:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjEDAtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 20:49:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324D21FCF;
        Wed,  3 May 2023 17:49:09 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6BBDB66056D3;
        Thu,  4 May 2023 01:49:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683161348;
        bh=fUbhCmf/dHoaIVYSRbcBKyqxRL18aThvwys52J7Sof4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XO0QnBwxs1nPLJgCIV47WtMAG8DY0dla4Prw+kZid1soRupcf5YJwSplZSQxhuvNm
         F9gXSbXjDrlkWG4X12kx5WNxxGzGSorf9hcyqgTBh6goy9aAkCh1+99XU4PXBprHRb
         S0e5W5zzAByw7+PVwf4yOYpiBe4zO8Pm1dLlQzDwrLlidTf8FyR2v1DzPV+HENRrCU
         gH0yxiktMs99Ud0YaSSSofPjN7+13dlFFp85BGPWbvP6vqacwb6+56jYxSAY1MAYmc
         +ROQ/vWzw8qj0XURF0uH5VE/kaQwG9L3nNddYty/Y8CqU1Dyamy9rsACqetaGPsDoX
         yarrPnHigK4gg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kernel@collabora.com, Alexandre Mergnat <amergnat@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 4/6] thermal/drivers/mediatek/lvts_thermal: Disable undesired interrupts
Date:   Wed,  3 May 2023 20:48:50 -0400
Message-Id: <20230504004852.627049-5-nfraprado@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504004852.627049-1-nfraprado@collabora.com>
References: <20230504004852.627049-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Out of the many interrupts supported by the hardware, the only ones of
interest to the driver currently are:
* The temperature went over the high offset threshold, for any of the
  sensors
* The temperature went below the low offset threshold, for any of the
  sensors
* The temperature went over the stage3 threshold

These are the only thresholds configured by the driver through the
OFFSETH, OFFSETL, and PROTTC registers, respectively.

The current interrupt mask in LVTS_MONINT_CONF, enables many more
interrupts, including data ready on sensors for both filtered and
immediate mode. These are not only not handled by the driver, but they
are also triggered too often, causing unneeded overhead. Disable these
unnecessary interrupts.

The meaning of each bit can be seen in the comment describing
LVTS_MONINTST in the IRQ handler.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Reworded commit and changed flag to use offset interrupts instead

 drivers/thermal/mediatek/lvts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 8449ba6ca90e..efd1e938e1c2 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -63,7 +63,7 @@
 #define LVTS_HW_FILTER				0x2
 #define LVTS_TSSEL_CONF				0x13121110
 #define LVTS_CALSCALE_CONF			0x300
-#define LVTS_MONINT_CONF			0x9FBF7BDE
+#define LVTS_MONINT_CONF			0x8300318C
 
 #define LVTS_INT_SENSOR0			0x0009001F
 #define LVTS_INT_SENSOR1			0x001203E0
-- 
2.40.1

