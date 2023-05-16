Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99428704F75
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjEPNiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjEPNiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:38:03 -0400
X-Greylist: delayed 912 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 06:38:00 PDT
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0408CA;
        Tue, 16 May 2023 06:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=4OVpla0e3KhLB8EpKpRBFad9oNXZVOLCvEDNQKceCdM=; b=A2eVFsVZ6ivdKi28ZHruVlSUvr
        Clze0kziSRRWxUPjXgwdYnsXE5o1eqBSuVISLnamRXVKO4z3sA94HdgVWzWI0sR3Fex31thzrq8dh
        YoCLPCZEOwkjmv+QWeo1zm1cjiYs1OYMLxeJxoGKasUKq2vK6SZVFiwP0Kx0WjetLmywLvL+stiHN
        OWWoVKXqxXhDFnF/31wvqstuAV6DNPOGpcq9U53a8cuLXk4fIr7M2SGht95/dTpSLcfn+rGwCjK4S
        brApjDiqxYtcusrs/abErYAQ4wLHx4Dts3dXW4z8nbyvDJylRoALO4EKiti8DN59ZQ5Zox2WCFhgx
        z+5kMeLw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1pyuda-000AJ6-EB; Tue, 16 May 2023 15:22:46 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1pyuda-000NS5-5w; Tue, 16 May 2023 15:22:46 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     robh+dt@kernel.org, Lee Jones <lee@kernel.org>
Cc:     devicetree@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] mfd: stpmic1: add pmic poweroff via sys-off handler
Date:   Tue, 16 May 2023 15:22:23 +0200
Message-Id: <20230516132225.3012541-2-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230516132225.3012541-1-sean@geanix.com>
References: <20230516132225.3012541-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26908/Tue May 16 09:24:20 2023)
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
Changes since v1:
 - Removed superfluous function

 drivers/mfd/stpmic1.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
index 4c9b18d9dec8..5b82cd37d57a 100644
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
@@ -159,6 +170,18 @@ static int stpmic1_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
+	if (of_property_read_bool(i2c->dev.of_node,  "st,pmic-poweroff")) {
+		ret = devm_register_sys_off_handler(ddata->dev,
+						    SYS_OFF_MODE_POWER_OFF,
+						    SYS_OFF_PRIO_DEFAULT,
+						    stpmic1_power_off,
+						    ddata);
+		if (ret) {
+			dev_err(ddata->dev, "failed to register sys-off handler: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return devm_of_platform_populate(dev);
 }
 
-- 
2.40.0

