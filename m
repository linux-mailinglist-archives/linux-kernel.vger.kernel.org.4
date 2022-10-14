Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C8D5FED85
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiJNLtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJNLsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:48:25 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1601CB52D;
        Fri, 14 Oct 2022 04:48:07 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r18so4074117pgr.12;
        Fri, 14 Oct 2022 04:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tA2UmIKVuRoeoJ0BqAsA6/5RpJhUljcvAx2HKfeYlvY=;
        b=ih7cLkAObA9C6mGyIvmkOuvT53+5XipO52PKE7ofDKCWG0swT4QZuMN+u+UDCTlDJF
         zoTM7W2bOYzqPD/o/MiASgseCHySJaS4+svOjNp8F+b0vjOGEFDnacnbe1zp3FJfO5+i
         nWGAM6zlkk/aRLKmO0lT1Q67NqFvRp//ZoGORcdgBMhUCxuCbVdZdA9RBP5eANqef46G
         D4b9x0xme+T8c9VyYT4o8Xvv8Pv1ghJatSBTcsUPGqdAm6v/exL1s5vdC3ituiddiZIp
         Rzn5MhJucytQjUAQzwLF18/TQC67yuy072p714bU6L2RjHwZbKB+FVhaITEG8x0tuUc3
         vrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tA2UmIKVuRoeoJ0BqAsA6/5RpJhUljcvAx2HKfeYlvY=;
        b=IU7iYD0MQgpy+/EYLb1lqdQXOfWohVOUziUxhoXSCZOCTMBOIw238ewHx1puGhh6bX
         odAqZ5YivoglbQt39FWOhRRDd/+iN0yijVtE4zADX4WM0jh14iojC4TLXeDrhLGaQvNL
         b+5JG3y3aGddSg/vOZr2ufy+Slae+zai42zxB8JjMhcQ6ErfJbLifXrAIuO/zWVEFX7f
         qyNX2S+oC2Erm0zbQo23x4JMJlZgfMYVx0NcL9xgRJc//mn0GwFQ3q9w+ueOwqM59zKJ
         X85FCZevuFLzCeT5UGfE+h+SuacX2IyGaZqeLGsH71R7tthRS8EHRgIyQFwMtnHGPDQ2
         Op/w==
X-Gm-Message-State: ACrzQf3Kw8iy+Wv/yvb1IbKtzElArsZ7I1LDtuQciNGYzPx7qyTLehbO
        2FQAY6RcikZ8BWnd6TOeELU=
X-Google-Smtp-Source: AMsMyM4eTL8wKOCEk8VhxC3oqvhHYBJIxhHMb0yMVKR+Z5x1YDEXvy29Prnl9vSTg0LKhRCJEiA6gA==
X-Received: by 2002:a65:6cc8:0:b0:3fe:2b89:cc00 with SMTP id g8-20020a656cc8000000b003fe2b89cc00mr4242674pgw.599.1665748080242;
        Fri, 14 Oct 2022 04:48:00 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-2aaa-c1aa-06c8-0e68-c5ee.emome-ip6.hinet.net. [2001:b400:e282:2aaa:c1aa:6c8:e68:c5ee])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b001746f66244asm1606678plg.18.2022.10.14.04.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:47:59 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 17/26] mmc: sdhci-uhs2: add clock operations
Date:   Fri, 14 Oct 2022 19:45:52 +0800
Message-Id: <20221014114601.15594-18-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
References: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
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

This is a sdhci version of mmc's uhs2_[enable|disable]_clk operations.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 145508918486..3f3665d7990c 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/ktime.h>
 #include <linux/module.h>
 
 #include "sdhci.h"
@@ -403,6 +404,37 @@ int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	return 0;
 }
 
+static int sdhci_uhs2_disable_clk(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+	clk &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	return 0;
+}
+
+static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	u32 val;
+	/* 20ms */
+	int timeout_us = 20000;
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	if (read_poll_timeout_atomic(sdhci_readw, val, (val & SDHCI_CLOCK_INT_STABLE),
+				     10, timeout_us, true, host, SDHCI_CLOCK_CONTROL)) {
+		pr_err("%s: Internal clock never stabilised.\n", mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		return 1;
+	}
+	return 0;
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
@@ -564,6 +596,10 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 
 	if (!host->mmc_host_ops.uhs2_detect_init)
 		host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
+	if (!host->mmc_host_ops.uhs2_disable_clk)
+		host->mmc_host_ops.uhs2_disable_clk = sdhci_uhs2_disable_clk;
+	if (!host->mmc_host_ops.uhs2_enable_clk)
+		host->mmc_host_ops.uhs2_enable_clk = sdhci_uhs2_enable_clk;
 
 	return 0;
 }
-- 
2.25.1

