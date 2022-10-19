Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8597F60435A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiJSLeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiJSLd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:33:56 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3ECFAA4C;
        Wed, 19 Oct 2022 04:10:45 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id f140so16904137pfa.1;
        Wed, 19 Oct 2022 04:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FsmUpiAlASHehR9dRBEnfUXc1GjY31312bVgt+7nS4=;
        b=VXWxXjMFUr59/gootxs0ePLUNBQKEq5+heNQr4N+Sj/65OofQ527xu3ZJTETYGe0hN
         G7js+eRTv/wdwbeJjsmYRLmMi22mzx48BzB+lw0M4C5EBaP4KQX5/OpQV1C+XHkUnFOu
         g4yUwiaoqfAqV7yPKoFONH5/K28kj6alMpMfbIA1wDMix47cQYxHIdKCbWEUxM9iiTYz
         SOLWylklHmVqKaCzFPRLSfOHQqI9kFU07XKHXgaDfdOePLMiQMhbQvBta5J98sKB7xWB
         ZYxwVooG1UflzEPavKth3OaxWj1TQcImYRMfKLGb8TLOZZqCKINHHN5Di7z+h4AZVHOr
         XGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FsmUpiAlASHehR9dRBEnfUXc1GjY31312bVgt+7nS4=;
        b=q0RzxSwfPvWt2OOO0yQwfkCrLSh8VBhxviq+EyqdnS5fSecA9KNc03cbSyR7m3Fqkt
         L0c3EVr6OJ/6vMuI8YqaCCtLlL1ceU68cZ/BTDc6qWJa4eu1T72k5dguM/Td6e4EMsCM
         QUSC0ZPDRhoitQ6ycerkH04A5SIu1ZmUvN+DE/TbW8aUBgZxMkPURc2jW8IPIv3uF0ML
         3U/4DRFmWDF8BqO1UaBDbg46FtGLRbW+2VAVF23k0jhEClrLiN17WnpLoJ/VjNUW/lKr
         2eW6iqJfLoZIGVMYlSPQ3TCBocIsTAsbhS4HE/8upksT6JsSo9/n7iJnt6S36DBlz+Cs
         InOg==
X-Gm-Message-State: ACrzQf1eXtEWDqkBPepOGjXmG1uNYH8nPnT3gItfoIDVU8Ba8wEGLgq8
        Rvwz033q4ydr10i2rpn4vjuo584HKR0=
X-Google-Smtp-Source: AMsMyM65qY9xE+qSn1DWHRdZTu7vE4K4AxBKYBy3RCca3rreedL00S9K51QDN1f8w5mCXxaRKRX1VQ==
X-Received: by 2002:a05:6a00:2906:b0:52a:bc7f:f801 with SMTP id cg6-20020a056a00290600b0052abc7ff801mr8214231pfb.49.1666177656870;
        Wed, 19 Oct 2022 04:07:36 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-821b-9613-557f-bd8d.emome-ip6.hinet.net. [2001:b400:e258:8c34:821b:9613:557f:bd8d])
        by smtp.gmail.com with ESMTPSA id cc11-20020a17090af10b00b0020dc318a43esm8696225pjb.25.2022.10.19.04.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:07:36 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 13/26] mmc: sdhci-uhs2: skip signal_voltage_switch()
Date:   Wed, 19 Oct 2022 19:06:34 +0800
Message-Id: <20221019110647.11076-14-victor.shih@genesyslogic.com.tw>
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

