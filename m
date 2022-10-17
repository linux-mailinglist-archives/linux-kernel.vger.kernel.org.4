Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696E9600A19
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiJQJOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiJQJNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:13:24 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F1D24F2D;
        Mon, 17 Oct 2022 02:13:01 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso12359492pjq.1;
        Mon, 17 Oct 2022 02:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FsmUpiAlASHehR9dRBEnfUXc1GjY31312bVgt+7nS4=;
        b=iZcgqmIw+hJ38Xc0pJ6p3DX+9pAxYaI6mMC7VvV0Mrj22TGnB5MX9+/dAMz9wseDHK
         xCvtZFsC296jva3Ge174oRs0AZ91o2L1jU1m2pIR9CBZy0vYvJN6QdJKiEPd5OvsYYax
         GLCSmlAt/rRjt9A2J1XpKSEP6XTI65QRPfapin1tnHqhkuZ1VY0VwJynU78yl3+ksspw
         JVACtTAXbbUC0K7N07AY0me7yCsTNMDPjJBrc4KtZGfuRYYOIEaQWtDzsWS1bztzXkC/
         wK/5zuZLPRtIvQ2v7iHu7uX29Mq0XEBT5ND4hd/Bc2Q3SN0Yo3n0gcA4uuqjXCm5XVGO
         cRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FsmUpiAlASHehR9dRBEnfUXc1GjY31312bVgt+7nS4=;
        b=uDeBCNCzBpmtAwfbblF5fjslpxMNGyQ3ahscAvHPrcLTYjN6Z74yoa/4PcYErFRfE2
         Ya/tfXxS/x160ZczPQD2DLTqhS2hUlgqYKTmI5OrYWY7S+Um7xStqsBpyx9KYJfN9ULs
         wDYFZfnGByBFUXCMgUwH/h3Mu/6YO2pTEoNTTp6yo6KgjsItCCAMqQlTYtDwkVz63agF
         KqyTl+ySwFtD1ElJdqm0frvWfiej7MlRdXFrb9WbZJW1YagnlKM7W3yu8UagNlMK0k46
         KYZ7u6cXFnG83Ued2o88kTlXxK04kmjk4G2ySwsOJl0zPiKwZnpBXjzJsFdhEXIDo/x5
         DxFA==
X-Gm-Message-State: ACrzQf1fN6H6dnJ96ZWXAR0FAN/qUBJNx3Bt7hWH6SlCQ2WQUAZz5rEK
        iQXVSIAUAeY/EOLApyDjujQ=
X-Google-Smtp-Source: AMsMyM7CqO6ympWNutv3zAM1NDzmNIc8wHZBzJ0S7kYDw6W+MXF80KmhNTRRm8QaxPFWiKSZRl2zhQ==
X-Received: by 2002:a17:902:d48d:b0:183:1d43:fd34 with SMTP id c13-20020a170902d48d00b001831d43fd34mr11272746plg.46.1665997969769;
        Mon, 17 Oct 2022 02:12:49 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-4ca3-4989-34c1-7890.emome-ip6.hinet.net. [2001:b400:e258:8c34:4ca3:4989:34c1:7890])
        by smtp.gmail.com with ESMTPSA id t22-20020a170902b21600b0017f75bc7a61sm6091996plr.166.2022.10.17.02.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:12:49 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 13/26] mmc: sdhci-uhs2: skip signal_voltage_switch()
Date:   Mon, 17 Oct 2022 17:11:40 +0800
Message-Id: <20221017091153.454873-14-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221017091153.454873-1-victor.shih@genesyslogic.com.tw>
References: <20221017091153.454873-1-victor.shih@genesyslogic.com.tw>
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

For UHS2, the signal voltage is supplied by vdd2 which is already 1.8v,
so no voltage switch required.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 896a1c8e55cf..4dc3e904d7d2 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -196,6 +196,27 @@ void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
 
+/*****************************************************************************\
+ *                                                                           *
+ * MMC callbacks                                                             *
+ *                                                                           *
+\*****************************************************************************/
+
+static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *mmc,
+						  struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	/*
+	 * For UHS2, the signal voltage is supplied by vdd2 which is
+	 * already 1.8v so no voltage switch required.
+	 */
+	if (sdhci_uhs2_mode(host))
+		return 0;
+
+	return sdhci_start_signal_voltage_switch(mmc, ios);
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
@@ -204,6 +225,9 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
 
 static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 {
+	host->mmc_host_ops.start_signal_voltage_switch =
+		sdhci_uhs2_start_signal_voltage_switch;
+
 	return 0;
 }
 
-- 
2.25.1

