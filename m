Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD016F1EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 21:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346622AbjD1TyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 15:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346615AbjD1TyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 15:54:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85595559D;
        Fri, 28 Apr 2023 12:54:10 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [194.36.25.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3748066032CF;
        Fri, 28 Apr 2023 20:54:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682711649;
        bh=qCAjiE5j9EjfpbQvxb5vblMTGK9ocfii2bzneXSlr5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCdTxO1YUgbH2MXRuUFjFat6l8VH4JlcIQNNP7JvLgUsLMqXuwf5riMEs2ft1YUzz
         J9XiS/YcfFVAqGdeT7ZA4WL7Q3QnWuSPyuTPlh5vqs9a6kPWXHYJctllEpavb9ugb2
         7egpM9O0ucEl0Zc87wWz5OUdvrcHzuYW1yWfRs0Z0kAGPwxqLTbkPQRXxZ8KSKTEYq
         l0T9jfzXlTz7CAwoLHxKlMHe12aD+cZl0VFt5cIVA7ZMzgPq7i8YibUzBdt7zLhNue
         c7NqizvXgwhZpt5pRPCjiJkhm7+ymTZpWka7YPEnvUh9VscGpJYp3m0KBJEyveXvnO
         mtnDE2mMC2d6Q==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 3/3] thermal/drivers/mediatek/lvts_thermal: Disable undesired interrupts
Date:   Fri, 28 Apr 2023 15:53:47 -0400
Message-Id: <20230428195347.3832687-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428195347.3832687-1-nfraprado@collabora.com>
References: <20230428195347.3832687-1-nfraprado@collabora.com>
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
* The temperature went over the hot threshold, for any of the sensors
* The temperature went over the hot to normal threshold, for any of the
  sensors
* The temperature went over the stage3 threshold

These are the only thresholds configured by the driver through the
HTHRE, H2NTHRE, and PROTTC registers, respectively.

The current interrupt mask in LVTS_MONINT_CONF, enables many more
interrupts, including offset detection and data ready on sensors for
both filtered and immediate mode. These are not only not handled by the
driver, but they are also triggered too often, causing unneeded
overhead. Disable these unnecessary interrupts.

The meaning of each bit can be seen in the comment describing
LVTS_MONINTST in the IRQ handler.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 drivers/thermal/mediatek/lvts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 29d10eaa8dfc..300ce22a7471 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -63,7 +63,7 @@
 #define LVTS_HW_FILTER				0x2
 #define LVTS_TSSEL_CONF				0x13121110
 #define LVTS_CALSCALE_CONF			0x300
-#define LVTS_MONINT_CONF			0x9FBF7BDE
+#define LVTS_MONINT_CONF			0x84804A52
 
 #define LVTS_INT_SENSOR0			0x0009001F
 #define LVTS_INT_SENSOR1			0x001203E0
-- 
2.40.0

