Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7506F1702
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345896AbjD1Lqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjD1Lqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:46:50 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE34C527E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=MNil8LLz7Ox6rqRyom3f5t42db/SNzYEqHrz9Y8QZII=; b=mP741+E1WrkAiZS3Stw8tt8u26
        HVBNwJtjecABGkdZFrWmSejTqgTF0YYATszT15ldXbSKWfY8swgcL+0UbIPta82rPK2y5FC3QfInZ
        aCM+Fuk10Wa9qLL+HBx/78eIHPYsiEVAbwPB3PhAvd9yMdZDVbznpX8ukAtJbu2AucP3O2DVKkPuA
        aA9G68YbYWldXk8G1jvBZU1CKPmGDhWPhzO6v79Qlwa72DJ6KTp6lVgzEuZ9elEEB+9cpV56T5w1k
        4MsJ1JWrZC63dJj57fVuknrBLKqdP7o4MBKSxuWwlTlnNsuAINqbOMwE/LAb9nws9Lir0KpF2DgMf
        Ik/6bH1w==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1psMHV-000Ldm-0C; Fri, 28 Apr 2023 13:28:53 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1psMHU-00021I-OB; Fri, 28 Apr 2023 13:28:52 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Lee Jones <lee@kernel.org>
Cc:     p.paillet@st.com, Sean Nyekjaer <sean@geanix.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mfd: stpmic1: add pmic poweroff via sys-off handler
Date:   Fri, 28 Apr 2023 13:28:46 +0200
Message-Id: <20230428112847.2146348-2-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428112847.2146348-1-sean@geanix.com>
References: <20230428112847.2146348-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26890/Fri Apr 28 09:22:55 2023)
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

This can be enabled by adding "st,pmic-poweroff" to device-tree.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/mfd/stpmic1.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
index 4c9b18d9dec8..c628141eb03c 100644
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
@@ -117,6 +118,33 @@ static const struct regmap_irq_chip stpmic1_regmap_irq_chip = {
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
+static int stpmic1_power_off_prepare_init(struct stpmic1 *ddata)
+{
+	int ret;
+
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
+	return 0;
+}
+
 static int stpmic1_probe(struct i2c_client *i2c)
 {
 	struct stpmic1 *ddata;
@@ -159,6 +187,12 @@ static int stpmic1_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
+	if (of_property_read_bool(i2c->dev.of_node,  "st,pmic-poweroff")) {
+		ret = stpmic1_power_off_prepare_init(ddata);
+		if (ret)
+			return ret;
+	}
+
 	return devm_of_platform_populate(dev);
 }
 
-- 
2.40.0

