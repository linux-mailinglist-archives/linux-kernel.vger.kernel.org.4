Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5DA604357
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiJSLel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiJSLds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:33:48 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DD21BFBAB;
        Wed, 19 Oct 2022 04:10:39 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id c24so16898367pls.9;
        Wed, 19 Oct 2022 04:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5ky6yRKLirOgAuzcb87q4FCsZ9Aux469YNihh1WRPk=;
        b=iXRFA7qEfFAfzgmBvvMPwliDoIlagdKb4PC0VsGa2vgpXhDtX84NoFo6yF9TA0MstH
         O01aL6VBbT7tLYge4L8mCFwqj3HL7VuP3czVhfg7I78hSAXgTDKT36GYSzJyAbrIEN0p
         vpNJ9N8oAuG3b+5mHEYzplSQNJiS7MlZeL1w0jaLJGp6tRZqRtWQcHZQVLDXJvUMPvCG
         4PPau1aqE0fUKOQzzO3RzrwsiHHO9J3xuN17sofMeMvv8+WcPzEgJcpvq620CcMvrUTt
         gIros+x2D6RxQEcu3DMr8Kgc5Qb7i6YxZ7aUjufNObrbOU7XuRQIN8fSVvfBXUugGs/y
         QY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5ky6yRKLirOgAuzcb87q4FCsZ9Aux469YNihh1WRPk=;
        b=4IUlTBYS0VQlMYOJtKHa7P+/d0aVkm7USjqcQ0/EKs0mz5/Fe2oma0XFK6NKxXysLn
         5+LthFu4WsXt4heSTbsMdfJyN7tZ3KjkjscYM/D0rA3VbDQ2PPVpKxVXO1dSTNxx0pl2
         SvcbefwRk8AbxJ0JKHNHhYvrA8Q6uSnEJNBcX1aoDSw10LNJ1rz3cCmYS1V3ZP8gHRIC
         Ad974W9jghySP5UuiSCx1FNeAtSxBnMAFG4xjcqX9TKQKBxRP/MkV2M3cvpmCDao/kBF
         piXoX4cf+GOsHddq68KC69JLz35eqJcPYNzi/YYKMAF+j8CeXdK9/Eyed/gCNtoEOoJO
         oGKA==
X-Gm-Message-State: ACrzQf1yjLj8YTPrhOB2lcyw9vDvmnWOZ/lsz9JOfZ9YWVELx3Rp/P86
        RpSngj1dwt0W02Jmt5f0tkE=
X-Google-Smtp-Source: AMsMyM4XNT8t/KeJqI1wqyZMtjSwlf+Hvn9OyZaF2KR4gFe3XSGOxWbqdnxZsFOkB6z0fcyOeW0e8g==
X-Received: by 2002:a17:90b:1d0d:b0:20d:5c1c:5fbb with SMTP id on13-20020a17090b1d0d00b0020d5c1c5fbbmr44728934pjb.196.1666177660438;
        Wed, 19 Oct 2022 04:07:40 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-821b-9613-557f-bd8d.emome-ip6.hinet.net. [2001:b400:e258:8c34:821b:9613:557f:bd8d])
        by smtp.gmail.com with ESMTPSA id cc11-20020a17090af10b00b0020dc318a43esm8696225pjb.25.2022.10.19.04.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:07:40 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 14/26] mmc: sdhci-uhs2: add set_timeout()
Date:   Wed, 19 Oct 2022 19:06:35 +0800
Message-Id: <20221019110647.11076-15-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

This is a UHS-II version of sdhci's set_timeout() operation.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 85 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  1 +
 2 files changed, 86 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 4dc3e904d7d2..2b90e5308764 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -196,6 +196,91 @@ void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
 
+static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res,
+				  u8 *dead_lock)
+{
+	u8 count;
+	unsigned int cmd_res_timeout, dead_lock_timeout, current_timeout;
+
+	/*
+	 * If the host controller provides us with an incorrect timeout
+	 * value, just skip the check and use 0xE.  The hardware may take
+	 * longer to time out, but that's much better than having a too-short
+	 * timeout value.
+	 */
+	if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL) {
+		*cmd_res = 0xE;
+		*dead_lock = 0xE;
+		return 0xE;
+	}
+
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
+	cmd_res |= dead_lock << SDHCI_UHS2_TIMER_CTRL_DEADLOCK_SHIFT;
+	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
+}
+
+void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	__sdhci_set_timeout(host, cmd);
+
+	if (host->mmc->flags & MMC_UHS2_SUPPORT)
+		__sdhci_uhs2_set_timeout(host);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
+
 /*****************************************************************************\
  *                                                                           *
  * MMC callbacks                                                             *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 3179915f7f79..5ea235b14108 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -215,5 +215,6 @@ bool sdhci_uhs2_mode(struct sdhci_host *host);
 void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
 			  unsigned short vdd);
+void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 
 #endif /* __SDHCI_UHS2_H */
-- 
2.25.1

