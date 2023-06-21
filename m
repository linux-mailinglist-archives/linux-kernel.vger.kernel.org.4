Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56DE738199
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjFUKE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjFUKC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:02:57 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AFF1991;
        Wed, 21 Jun 2023 03:02:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6682909acadso2165307b3a.3;
        Wed, 21 Jun 2023 03:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687341757; x=1689933757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAr+kUaGzD9vhrOw8vEKFjOqsxNqVeLEZMQfwfP5Jgg=;
        b=EebrulnHLRg6iYul0cI4+lRKz7U1O7+1TwbhxSirqSzz1NPYsT9482WLhlc1gciQln
         fxKW4WOPU+ZnIsQDL0FCBWwbYCrFI7LRs4wU9rBu2kSKsLZrl3QobTRvR7ciYY/5tJOu
         y7MN8dD4RI9xJ+572iTSRlm8v1TBGThhmiWdoCQipykyttQi7VyQ841n1dVyQdlWjLWa
         55sTHfkTP+lRwrAoB1zLLn+naQM9OhF37ae9yoFiO1DcJvzCX3M57VokWym4XjG1c/vy
         2550nj68BoRCmMeNp33sTmr0I6NfwBoTUKvpOMYUc1DG6o2hd3O61rCVIe93LQKvWXaR
         BYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687341757; x=1689933757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAr+kUaGzD9vhrOw8vEKFjOqsxNqVeLEZMQfwfP5Jgg=;
        b=JtaBlVWGcW1vzgOz9qmlaBShIWdHyq+iChZnFG3x346yjw5sNjYBGBSR5zeG+BE1bA
         NO46cIHRCVXPhl/Le3pUrrH/TfvyN3LofJjVmd0e63WPJtX7R7eexByED+tn4iR6+V47
         gRlEyTrIOEdV37kZZTwVLkXPGSTgplTDRyfCn5KyhJT+vscbTJo8ecE5chJdh9OFoFgz
         HcvZysdlrl1y7BjXSNUMAZ6UxtDhxcGgvheys6IDX3M05bGnMxw+9DNiZ+iSIeunbm+7
         mQhM8CraziL9ip9DOyO2iNXIr050jW+4IyLrk34XBEI0j2g6AhgKZ/SMlku6USMzN2r4
         kfKA==
X-Gm-Message-State: AC+VfDyYRsf5cBtKmnzrDSS3gsUOEH39nOjQc51pNthOX+W1FMONpRIu
        m4y14GLhQJAJRcAMqyqVqIvcbjJP+Becgg==
X-Google-Smtp-Source: ACHHUZ623kvtgcma/OR2t8KVtsMY1bHsUgKeYNDkk/T/ZArbXLL5TkrkUDOcIiRgJru72BmUkMvDjQ==
X-Received: by 2002:a05:6a00:244f:b0:63b:5c82:e209 with SMTP id d15-20020a056a00244f00b0063b5c82e209mr9237222pfj.10.1687341757555;
        Wed, 21 Jun 2023 03:02:37 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e254-4eda-2716-05ea-20f5-b048.emome-ip6.hinet.net. [2001:b400:e254:4eda:2716:5ea:20f5:b048])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78742000000b0064f46570bb7sm2611196pfo.167.2023.06.21.03.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:02:37 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V8 13/23] mmc: sdhci-uhs2: add set_timeout()
Date:   Wed, 21 Jun 2023 18:01:41 +0800
Message-Id: <20230621100151.6329-14-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230621100151.6329-1-victorshihgli@gmail.com>
References: <20230621100151.6329-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This is a UHS-II version of sdhci's set_timeout() operation.

Updates in V8:
 - Initialization be combined with declaration and realigned
   in sdhci_calc_timeout_uhs2().
 - Forward declare struct mmc_command in sdhci_uhs2.h.

updates in V6:
 - Use GENMASK() and FIELD_PREP() in some case.
 - Use sdhci_uhs2_mode() to simplify code.
 - Remove unnecessary functions.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 72 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  2 +
 2 files changed, 74 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 92fb69b7e209..d519e6ce6199 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/iopoll.h>
+#include <linux/bitfield.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -142,6 +143,77 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, un
 	}
 }
 
+static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res, u8 *dead_lock)
+{
+	/* timeout in us */
+	unsigned int dead_lock_timeout = 1 * 1000 * 1000;
+	unsigned int cmd_res_timeout = 5 * 1000;
+	unsigned int current_timeout;
+	u8 count;
+
+	/*
+	 * Figure out needed cycles.
+	 * We do this in steps in order to fit inside a 32 bit int.
+	 * The first step is the minimum timeout, which will have a
+	 * minimum resolution of 6 bits:
+	 * (1) 2^13*1000 > 2^22,
+	 * (2) host->timeout_clk < 2^16
+	 *     =>
+	 *     (1) / (2) > 2^6
+	 */
+	count = 0;
+	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
+	while (current_timeout < cmd_res_timeout) {
+		count++;
+		current_timeout <<= 1;
+		if (count >= 0xF)
+			break;
+	}
+
+	if (count >= 0xF) {
+		DBG("%s: Too large timeout 0x%x requested for CMD_RES!\n",
+		    mmc_hostname(host->mmc), count);
+		count = 0xE;
+	}
+	*cmd_res = count;
+
+	count = 0;
+	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
+	while (current_timeout < dead_lock_timeout) {
+		count++;
+		current_timeout <<= 1;
+		if (count >= 0xF)
+			break;
+	}
+
+	if (count >= 0xF) {
+		DBG("%s: Too large timeout 0x%x requested for DEADLOCK!\n",
+		    mmc_hostname(host->mmc), count);
+		count = 0xE;
+	}
+	*dead_lock = count;
+
+	return count;
+}
+
+static void __sdhci_uhs2_set_timeout(struct sdhci_host *host)
+{
+	u8 cmd_res, dead_lock;
+
+	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
+	cmd_res |= FIELD_PREP(SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK, dead_lock);
+	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
+}
+
+void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	__sdhci_set_timeout(host, cmd);
+
+	if (sdhci_uhs2_mode(host))
+		__sdhci_uhs2_set_timeout(host);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
+
 /*****************************************************************************\
  *                                                                           *
  * MMC callbacks                                                             *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 8253d50f7852..ccf4e1834c2d 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -175,9 +175,11 @@
 #define SDHCI_UHS2_VENDOR_PTR			0xE8
 
 struct sdhci_host;
+struct mmc_command;
 
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
 bool sdhci_uhs2_mode(struct sdhci_host *host);
 void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
+void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 
 #endif /* __SDHCI_UHS2_H */
-- 
2.25.1

