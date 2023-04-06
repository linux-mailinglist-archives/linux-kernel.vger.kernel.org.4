Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB9B6DA1B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbjDFTml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237472AbjDFTm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:42:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AAAA245;
        Thu,  6 Apr 2023 12:42:21 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 81D2866031ED;
        Thu,  6 Apr 2023 20:42:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680810140;
        bh=3rBxNv391K3rouaSGtWY3Lj00PK9hBEW9sLwGyEnlTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUXiqy5XrwJiWDpluiGuRSuDuPcb2xZLn6UTsz5p1jUmRonWnMEBji9XPm6hGS0Nu
         bCatyGmEkkJTjWin7L5ipoW694UikATPzvbvBaEY3BeR4mxb0Xor5s+EOjFwDApodX
         D7EG+UkH7xFKFEuSRD2mYgFRh1dR2NEIy3jQoYvW0S4L21BFvl6gWZCoTeJa7QU8us
         4qjppkApegQMDfF2oSHdJQAgNT3BYYPLfMUP2xGLwIYvzKquDf9fkXSVr1c/vWe8Ai
         qjHnT4eqyp7bvuW1g1NiSCV0r1qeazVzlQtPbucscHhSlqHZ24t+9XPw6fhw4V6jV/
         lcoqXnRCFwA8Q==
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
Subject: [PATCH v3 6/8] regulator: fan53555: Improve vsel_mask computation
Date:   Thu,  6 Apr 2023 22:41:56 +0300
Message-Id: <20230406194158.963352-7-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406194158.963352-1-cristian.ciocaltea@collabora.com>
References: <20230406194158.963352-1-cristian.ciocaltea@collabora.com>
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

In preparation for introducing support for additional regulators which
do not use the maximum number of voltage selectors available for a given
mask, improve the mask computation formula by using fls().

Note fls() requires the bitops header, hence include it explicitly and
drop bits.h which is already pulled by bitops.h.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/regulator/fan53555.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 181e5eb00e7a..39c9c29f4ff6 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -8,7 +8,7 @@
 // Copyright (c) 2012 Marvell Technology Ltd.
 // Yunfan Zhang <yfzhang@marvell.com>
 
-#include <linux/bits.h>
+#include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -486,7 +486,7 @@ static int fan53555_regulator_register(struct fan53555_device_info *di,
 	rdesc->min_uV = di->vsel_min;
 	rdesc->uV_step = di->vsel_step;
 	rdesc->vsel_reg = di->vol_reg;
-	rdesc->vsel_mask = di->vsel_count - 1;
+	rdesc->vsel_mask = BIT(fls(di->vsel_count - 1)) - 1;
 	rdesc->ramp_reg = di->slew_reg;
 	rdesc->ramp_mask = di->slew_mask;
 	rdesc->ramp_delay_table = di->ramp_delay_table;
-- 
2.40.0

