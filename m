Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F5364B1C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbiLMJDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbiLMJCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:02:04 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B26FD0B;
        Tue, 13 Dec 2022 01:01:47 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 124so1775654pfy.0;
        Tue, 13 Dec 2022 01:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=infOJYAuY6NmVdfocqokUhNUb9UCZ9ojC/z55HJcvas=;
        b=Lnku68LJeyCc6DpE9eI2IZL7Ilekiby90qbRRR7Gpri22Fwd0J8AwJS2lx2iBFhqBH
         OH3ByCj9HPZ/SuBj5s/sSWgN96hkBAeP8dKXze5ptC28RRJf74CbdQqkOtbHAfWgmYFu
         5s78L6qY56pJNotAMI7fBsBdW3te++9/M31Bvo9G9NnsxNRYi6P0m5jtBRJhwJCwW5Tv
         fRrIgE6mnDtK5bBWXxTTNGPVhxHmQc/eDRYggOh8azTWSnS6npHFy/MrEf5LSkrVDH31
         GZz+lNr7gaGCTpBRg5FW94sSXiQstyuD37lrI6q6sLpOxyF+aTpvRv0bZZ91Fy8vMGlB
         Np7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=infOJYAuY6NmVdfocqokUhNUb9UCZ9ojC/z55HJcvas=;
        b=tfE5q0SQErcR4exlSfSmndPfYMwB/MHha0tnZibroXfA3TXnoCBkl8GJkxbFgHPJCQ
         ZQKq2IjV88dxknpB5MtjCEe4gEYO/A52oU5Rro4KlmYn8krd79PdH+Kn9CtWLDbWCvKv
         XCmNMFy09xqXH8VtG+FEsa3r2Voj+TWFLX3n5hiz2UzlDnLQ+iuaIDVVZl+frJ7Xylcn
         9jzZfwwqq4vldmhNk/NZiK5GnL9MnHh7m+K0de8CshA6Iv/kSNWmRLf/DCxfF2bjw9mn
         3rE11EcEa9VweNJDHKvhNq5NaUha/pFZvijtpBYBhLrFHSybeCU2c+IAsmuk5TXRuEnq
         hIEQ==
X-Gm-Message-State: ANoB5pmMW8KS9AUXnqhCrEc3NmC9lQrEJFzX176uHZnY4N1PaJzaRXV2
        fkoXT2xqhgLvjlTUaa/G1zQ4vjFxdgnTQw==
X-Google-Smtp-Source: AA0mqf5T2VWEScXGJKaV+QlWPmv1BRz8sVStqaNxxxTqp6xdSOypxNDIgo/hCA9wyyYZHtpFynGBHg==
X-Received: by 2002:a05:6a00:2787:b0:578:8864:7b24 with SMTP id bd7-20020a056a00278700b0057888647b24mr6416821pfb.12.1670922107172;
        Tue, 13 Dec 2022 01:01:47 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2dc-5c03-264b-f684-a8c9-21ae.emome-ip6.hinet.net. [2001:b400:e2dc:5c03:264b:f684:a8c9:21ae])
        by smtp.gmail.com with ESMTPSA id 81-20020a621954000000b0056b9ec7e2desm7141682pfz.125.2022.12.13.01.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 01:01:46 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V6 12/24] mmc: sdhci-uhs2: skip signal_voltage_switch()
Date:   Tue, 13 Dec 2022 17:00:35 +0800
Message-Id: <20221213090047.3805-13-victor.shih@genesyslogic.com.tw>
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

For UHS2, the signal voltage is supplied by vdd2 which is already 1.8v,
so no voltage switch required.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 780491781613..2342c05c4cdb 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -141,6 +141,27 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
 	}
 }
 
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
@@ -149,6 +170,9 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
 
 static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 {
+	host->mmc_host_ops.start_signal_voltage_switch =
+		sdhci_uhs2_start_signal_voltage_switch;
+
 	return 0;
 }
 
-- 
2.25.1

