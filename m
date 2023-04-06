Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3216D9E57
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbjDFRSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239513AbjDFRS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:18:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3AC977F;
        Thu,  6 Apr 2023 10:18:21 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 725BE66031CB;
        Thu,  6 Apr 2023 18:18:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680801500;
        bh=lFOZ5esxl/tbYIcE53Cn4DHfBeM2O3R87VdL+HeZPkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DqNAB+DkL1pKNih8XoenkmU0wKLDk8DyjxEBQX7AmLSJH/EqJywyOurgpcXYtfrO+
         qg33/YtaBeISAjtp/4dM1kNpIIjialOUuTaDhukDpPrDyAwwhPoCMu6O0RV2FLmXiO
         NoEFu4vqxldA8AraNJWP9aTJuWbmhSNffr5kok0hZoNEansUfYziZyZUGHXLb9NE+g
         acQjwVJ6ZUCxXgBjveTNunoFId7TqA5T3j2m6+jfrZKZYHxOb+WjHAChxrYRiLUUFe
         o4c4CMMMXm0/dCRRM8T3uyZ69froNwKTJ/ISRgTQa64ghhBzZR6CNIEVbVsugmlhsZ
         gJJfwdqCj87gQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 3/8] regulator: fan53555: Fix wrong TCS_SLEW_MASK
Date:   Thu,  6 Apr 2023 20:18:01 +0300
Message-Id: <20230406171806.948290-4-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406171806.948290-1-cristian.ciocaltea@collabora.com>
References: <20230406171806.948290-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The support for TCS4525 regulator has been introduced with a wrong
ramp-rate mask, which has been defined as a logical expression instead
of a bit shift operation.

For clarity, fix it using GENMASK() macro.

Fixes: 914df8faa7d6 ("regulator: fan53555: Add TCS4525 DCDC support")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/regulator/fan53555.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 0754c370a21c..4d2104c3a077 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -61,7 +61,7 @@
 #define TCS_VSEL1_MODE		(1 << 6)
 
 #define TCS_SLEW_SHIFT		3
-#define TCS_SLEW_MASK		(0x3 < 3)
+#define TCS_SLEW_MASK		GENMASK(4, 3)
 
 enum fan53555_vendor {
 	FAN53526_VENDOR_FAIRCHILD = 0,
-- 
2.40.0

