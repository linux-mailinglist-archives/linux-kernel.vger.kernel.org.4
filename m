Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A59C64B1C6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbiLMJDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbiLMJCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:02:04 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A79E09E;
        Tue, 13 Dec 2022 01:01:51 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id js9so2714832pjb.2;
        Tue, 13 Dec 2022 01:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1PHj1yKWIH44nR4fbTVq49MHfutRoM7zbX96DEQIj4=;
        b=ZAF9Ih4N1XWyBi7TVZ1sHgmxbPJOy+0mfDevrgZooL6PHNWz78STohjQWhoT36egFk
         dgnrSW2zVKbr+Xlpqhokd8AwE396nXsXs1EaIUdWMdON+sNvOjSGYwA3ueF+2otjLoYR
         oSbmvIOht6qgsnPE/A4llqRZT6hh9jvHWsIgBTKjJxw/7oemqrkbF37B/Y/tfsI6kMzG
         5Z7CQQyJTiJ3GRXxac9SZVImHpoo2vHbwuCJBo00CFI3uFxL21rQ3uSYiVPZpD9LrcCB
         jTjLTHZRNyQ7RoU/uTdzrlks3lVCNWOB0i2IPb5JXrSj+FQM3FYTDtaZFWxsJ3cP6nvc
         Sr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1PHj1yKWIH44nR4fbTVq49MHfutRoM7zbX96DEQIj4=;
        b=Zdr5aC+c6Q7DKDYvju8R7fmN6rwSoAihvzV1/ilkNewzbfUS5ZekeQx2HS/iyE1VZ2
         dy1IhhkBOLARCVE/kbMFyZuM1BKJB1o/z0iFPH4XVO+mXfAxSL03PELLdUTZCpNRotqV
         0dXva8dGmQlt3GiOJG2oIApKL5hSsGb+YH9bLwKSdMnBC7pf58z/SjFkK3EG3RIZTtr+
         652IdcrLvWYmD/qJoG+A/QN20/uj+9ajaRgue1ChlUl79hU36lRy0Ucbek0oYOtUQynf
         URdO0EIoh4sFHKXHkVS1ozPbnzvPM1EJwyMV6U0pvVB0FimtJPszDAyOCSmqlgsHS8se
         06Cw==
X-Gm-Message-State: ANoB5pln8v8HNT+bVekSQ8jh4+9k/Mv43QgUoPf8y7t0Fm6hLSCSXpYb
        /AGcGtxXRbpSbhJZ/do8GLE=
X-Google-Smtp-Source: AA0mqf7ioxy5Dl7bfyIEskJ0iphL1vpgxaafCE7+r8AI4URjMlTWR0Fvq5jiGVCsaqwbF3GIeyHRRQ==
X-Received: by 2002:a05:6a20:9c89:b0:9d:efbf:7876 with SMTP id mj9-20020a056a209c8900b0009defbf7876mr23428798pzb.43.1670922110574;
        Tue, 13 Dec 2022 01:01:50 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2dc-5c03-264b-f684-a8c9-21ae.emome-ip6.hinet.net. [2001:b400:e2dc:5c03:264b:f684:a8c9:21ae])
        by smtp.gmail.com with ESMTPSA id 81-20020a621954000000b0056b9ec7e2desm7141682pfz.125.2022.12.13.01.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 01:01:49 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V6 13/24] mmc: sdhci-uhs2: add set_timeout()
Date:   Tue, 13 Dec 2022 17:00:36 +0800
Message-Id: <20221213090047.3805-14-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a UHS-II version of sdhci's set_timeout() operation.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 72 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  1 +
 2 files changed, 73 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 2342c05c4cdb..00b1b69b49ea 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/iopoll.h>
+#include <linux/bitfield.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -141,6 +142,77 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
 	}
 }
 
+static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res, u8 *dead_lock)
+{
+	u8 count;
+	unsigned int cmd_res_timeout, dead_lock_timeout, current_timeout;
+	/* timeout in us */
+	cmd_res_timeout = 5 * 1000;
+	dead_lock_timeout = 1 * 1000 * 1000;
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
index 03b9f6675cdc..a58ef19c08aa 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -177,5 +177,6 @@ struct sdhci_host;
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
 bool sdhci_uhs2_mode(struct sdhci_host *host);
 void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
+void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 
 #endif /* __SDHCI_UHS2_H */
-- 
2.25.1

