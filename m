Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3265FED72
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiJNLsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJNLsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:48:07 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C90188AA0;
        Fri, 14 Oct 2022 04:47:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id f140so4692185pfa.1;
        Fri, 14 Oct 2022 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FsmUpiAlASHehR9dRBEnfUXc1GjY31312bVgt+7nS4=;
        b=d+d0JVuXcP42Yigqd+NsPx4in8cB6xLfuziarpfznn7QUHnG3Zt6VRtiGr+PnCles/
         LAFXD6CknblJv5HDIklXyp/5MKiUDwk4JBYtpNzSwpuKHkowhv95sTJnwrbO1uoBPrMf
         N27BfQsCgC1oXIbgyU9rDbifDeRPPMGus4AL08Aw79zibStj1LulNSDWmJoNE5IP62fP
         W2bDJW7OwIMuwXQv/YyWQL7a5aOSmDg9hJFxZ14OmAa9t8TUROyVrWu6LIw0PB3Hgz8o
         jK+PvweLdWo7YiJTrGOcTRvC8n29Ds/wpW9nly1eoncQ0bi5p5UntrzGmeWO1w9emZ4b
         Jibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FsmUpiAlASHehR9dRBEnfUXc1GjY31312bVgt+7nS4=;
        b=XDRUs2Eu04ofL+laUIuxoFGOGXkPTBLNoJEUq/d47lXIqx3ObU4cUrvZKzWyib/knf
         vBewrlTuYwFO3mY92zIYa2btkNXlLo2jTSK+H+nLcyK9SnysTNzEjR2xP6kCIg9sSWUO
         bvLo1OkdcXfD/y4BnvlAKtxT5LtHHm/WG7WjkrJBnaz4kM40Py5Fum4yC++u6jwu80VI
         HwHH62uBaF0qTW7yGTLQKhLe0rNxw/nAN2UufGYk+B4FOuB631S62m23lJQfL0EuKbLB
         qpuNQEvdD9kdiCa5/CHTzch3NfAEP8L75pXxbleWv+u4NXgkR0gMCmxJHYlW0ZR3JOmz
         Ts3A==
X-Gm-Message-State: ACrzQf0BaiwlnSFUpnKnBHGbA5UL7GzeuU8Ko11TYH78yTmeNZxq3DwF
        16cK03n7I1GXaT/cTfr2yYs=
X-Google-Smtp-Source: AMsMyM7zICqIjaDqcXwdUoGJZB+cx6l7orxMr1jzktjBFsLSUEi1hPQhVLIfeEiy8GcyzMbWuFBbQQ==
X-Received: by 2002:a05:6a00:2181:b0:51b:560b:dd30 with SMTP id h1-20020a056a00218100b0051b560bdd30mr4818999pfi.44.1665748067870;
        Fri, 14 Oct 2022 04:47:47 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-2aaa-c1aa-06c8-0e68-c5ee.emome-ip6.hinet.net. [2001:b400:e282:2aaa:c1aa:6c8:e68:c5ee])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b001746f66244asm1606678plg.18.2022.10.14.04.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:47:47 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 13/26] mmc: sdhci-uhs2: skip signal_voltage_switch()
Date:   Fri, 14 Oct 2022 19:45:48 +0800
Message-Id: <20221014114601.15594-14-victor.shih@genesyslogic.com.tw>
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

