Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5B661E318
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiKFPqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiKFPqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:46:19 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF96DD2F1
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 07:46:17 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id b2so24375613eja.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 07:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IESrdIGOIZAm+SZQoTxRhJ5XsZQ5NE5GBRmcNiJagyU=;
        b=F2cbbEOvg/pHLRp+l7YZGXVwAhe6m49SvHaqxvpPII2/ZU/hnCFzeTyOcT4rjzfRjC
         5Sufm6GvLr1SU6ugGLBIobRlxXsGPdKq5Fo/7HTy3oThl7o0HsUnCy7zv19liqqVz/LQ
         tt9CiBfEZIVR/6fuKdwAXIIj3lK2g8XuAqIYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IESrdIGOIZAm+SZQoTxRhJ5XsZQ5NE5GBRmcNiJagyU=;
        b=P/BO10KE5K8wPAnNTthJUvL4/z5boebfXcmBmXfqFRpzwkVGubbVu6rEA2VLZvj58k
         snWz4YzOHogGDiCC8nNKXu4T37Ixy2SgW/ygbhuXZgxlnYmYCYIsdMcspfi/3z6FQD4/
         9L7vS+5pTgiXscETxcX5nLp1Uxf8+vWhi63c7QgFWAu0UsRAD+4qMc7J/4x6M9f2ubRS
         Mk7FvrDxXgBb8VCcYCnJdZOIpNISa4CWZs5sArR7bZk2jX+rGSKch+2iILLXZXDcAPUP
         f701MT9BAmf6fpuEnIkOVaAz85OiRVjXJOnyagC+/l52otkiNfXEEAO5YaQpscTt7Ekf
         KHKg==
X-Gm-Message-State: ACrzQf1lY2c0xeU+QGEvmbhf8lHOFtstp8iKy539HwcGJ/A8wQto1jB8
        ioBh04Bo6AQKvnpyxhO4hzT66aucMSPvig==
X-Google-Smtp-Source: AA0mqf4NwJutTjNjlc5CwEQu295TG49ixdJix/uHZHyLRtAfyvfT3OC1G/evCQM4vJFh4EtZwHv6yQ==
X-Received: by 2002:a17:906:99c1:b0:6fe:b01d:134 with SMTP id s1-20020a17090699c100b006feb01d0134mr8027170ejn.598.1667749576127;
        Sun, 06 Nov 2022 07:46:16 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-232-76-31.retail.telecomitalia.it. [95.232.76.31])
        by smtp.gmail.com with ESMTPSA id kz20-20020a17090777d400b00772061034dbsm2204139ejc.182.2022.11.06.07.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 07:46:15 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang He <windhl@126.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v3 1/2] clk: ti: add of_ti_clk_register() helper
Date:   Sun,  6 Nov 2022 16:46:11 +0100
Message-Id: <20221106154612.3474940-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ti_clk_register() function is always called with the parameter of
type struct device set to NULL, since the functions from which it is
called always have a parameter of type struct device_node. Adding this
helper will allow you to register a TI clock to the common clock
framework by taking advantage of the facilities provided by the
struct device_node type.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/clk/ti/clk.c   | 30 ++++++++++++++++++++++++++++++
 drivers/clk/ti/clock.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 1dc2f15fb75b..e29b5c7c0dc8 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -560,6 +560,36 @@ int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con)
 	return 0;
 }
 
+/**
+ * of_ti_clk_register - register a TI clock to the common clock framework
+ * @node: device node for the clock
+ * @hw: hardware clock handle
+ * @con: connection ID for this clock
+ *
+ * Registers a TI clock to the common clock framework, and adds a clock
+ * alias for it. Returns a handle to the registered clock if successful,
+ * ERR_PTR value in failure.
+ */
+struct clk *of_ti_clk_register(struct device_node *node, struct clk_hw *hw,
+			       const char *con)
+{
+	struct clk *clk;
+	int ret;
+
+	ret = of_clk_hw_register(node, hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	clk = hw->clk;
+	ret = ti_clk_add_alias(NULL, clk, con);
+	if (ret) {
+		clk_unregister(clk);
+		return ERR_PTR(ret);
+	}
+
+	return clk;
+}
+
 /**
  * ti_clk_register - register a TI clock to the common clock framework
  * @dev: device for this clock
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 37ab53339a9b..a75fcf775de0 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -199,6 +199,8 @@ extern const struct omap_clkctrl_data dm816_clkctrl_data[];
 
 typedef void (*ti_of_clk_init_cb_t)(void *, struct device_node *);
 
+struct clk *of_ti_clk_register(struct device_node *node, struct clk_hw *hw,
+			       const char *con);
 struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
 			    const char *con);
 struct clk *ti_clk_register_omap_hw(struct device *dev, struct clk_hw *hw,
-- 
2.32.0

