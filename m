Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6EB71FA0A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjFBGZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjFBGZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:25:08 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E88EB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 23:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=6nGHV3Tzd+ueExjxQGldi1rcP9sIpx+z7TiCsn2/rGU=; b=d4QLPBiQIVud1K/5SgqaiQUF2Q
        18Re8MstSV22J2FAaZrY+k+k2ArGgVz+BQS65FEHVpTCmS0WCHrYbGC+EgtYAkJQqe2zisp8QzkxR
        s205XdbCugs+LNgayuocbd75VlgFnW7gpLMAEdZzUuV8k6yGG89qTDJRdputSO7Oaz+WARiSlkdp0
        4ny91JSwtuE0+vpZbHq1txJZfELwo8uP4II+LgMPJHBJy4lYG/IafhJxxC/jvF6yYF6TvgPHAU1jL
        ZCFAJ4MHbRAWTlb641zpCU5EY5vdhlfvbKNx1/8VKuWz2b/VEEWa6IaajoK2zpS2BjQpe3Yaxtsc3
        rUEEScyQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1q4yDg-000Etu-JH; Fri, 02 Jun 2023 08:25:04 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1q4yDg-000Nkl-BR; Fri, 02 Jun 2023 08:25:04 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     krzysztof.kozlowski@linaro.org, conor@kernel.org, lee@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v3 2/2] mfd: stpmic1: add pmic poweroff via sys-off handler
Date:   Fri,  2 Jun 2023 08:24:26 +0200
Message-Id: <20230602062426.3947116-2-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230602062426.3947116-1-sean@geanix.com>
References: <20230602062426.3947116-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26925/Thu Jun  1 09:27:46 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_register_sys_off_handler() that allows to register multiple
power-off handlers.
This will allow boards using the stpmic1 to power-off.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes since v1:
 - Removed superfluous function

Changes since v2:
 - Removed the devicetree option to turn the power-off functionality on and off.

 drivers/mfd/stpmic1.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
index 4c9b18d9dec8..9c7d1c3b8dfd 100644
--- a/drivers/mfd/stpmic1.c
+++ b/drivers/mfd/stpmic1.c
@@ -7,6 +7,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/stpmic1.h>
 #include <linux/module.h>
+#include <linux/reboot.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -117,6 +118,16 @@ static const struct regmap_irq_chip stpmic1_regmap_irq_chip = {
 	.num_irqs = ARRAY_SIZE(stpmic1_irqs),
 };
 
+static int stpmic1_power_off(struct sys_off_data *data)
+{
+	struct stpmic1 *ddata = data->cb_data;
+
+	regmap_update_bits(ddata->regmap, MAIN_CR,
+			   SOFTWARE_SWITCH_OFF, SOFTWARE_SWITCH_OFF);
+
+	return NOTIFY_DONE;
+}
+
 static int stpmic1_probe(struct i2c_client *i2c)
 {
 	struct stpmic1 *ddata;
@@ -159,6 +170,16 @@ static int stpmic1_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
+	ret = devm_register_sys_off_handler(ddata->dev,
+					    SYS_OFF_MODE_POWER_OFF,
+					    SYS_OFF_PRIO_DEFAULT,
+					    stpmic1_power_off,
+					    ddata);
+	if (ret) {
+		dev_err(ddata->dev, "failed to register sys-off handler: %d\n", ret);
+		return ret;
+	}
+
 	return devm_of_platform_populate(dev);
 }
 
-- 
2.40.0

