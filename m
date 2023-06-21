Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94684738109
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjFUKEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjFUKC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:02:57 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932BA1735;
        Wed, 21 Jun 2023 03:02:35 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6687466137bso1969102b3a.0;
        Wed, 21 Jun 2023 03:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687341755; x=1689933755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XII37cuECDAtqNJTeApeoUVvXXF7qk7OpOMIakMjX9M=;
        b=AfoW9fBtbDjYFCx8wQPiVUQIDpBNJuCOPVecVYv1PW3WXClCY1mZfEiQ+/n/DdEG7a
         aLlCiR3BofCVCZEMGEyP19pH0jWW5ue4E6b/M0cZ1oOeRinKWI9DZpeA5RNFuZN/wnXp
         zeLeKB+Y8uVX2dyDZ2VBjlBLRK5fEOlFoCIPwJYRDeoC5emsM8qioMEvrPbuBpvVvzB4
         k9mxzKI8+6WO6KJdvpMgHloB77xLs3tlsccP8AAw34PK5GeSztVOx+KLrbZCncOb+mx7
         Q7mMhBbmRVoHVS72Doq7KG9wh9lGuDL6M/DOuZBkkNciKl4hdvoOjFga6UmHcd91k1WB
         8/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687341755; x=1689933755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XII37cuECDAtqNJTeApeoUVvXXF7qk7OpOMIakMjX9M=;
        b=eiQa+tSnxdSBCZJsBMdxt3emRwvClXu9w04DToztEthaugS0w8nLhHIWpTR52K44N1
         oC6O8NWEc+elGTNAUeqJDFaYrejOCcDBiI3oSeCZWZH1JjZUgO9fIIgSk/xhfgvVM4Ka
         e73BGS2Na5zA/utgv8w0+anMBWofh6paKbFI0chmxtntZt5MDV+TUlCxNsa1rqLcgLgu
         fewn3jxBTAfjpfm4+Lef3E4ONxuGi7tW0zQlP2kia57pHxJcFVmVRYRBMThzshXganrf
         aeY5vhdIa2uSklhjch8yfPvTnrjDkwxlo0ta0DtkKZ1FrsXdfdJSzQhx9cQXQmS8vPLK
         3H5Q==
X-Gm-Message-State: AC+VfDzpbwR7/k4Piai2mEyRpZun/cZtOqx8yMHqB0Mniv3k7mGtsc0C
        xXSRj9gcA3SfJgCFeQORILQ=
X-Google-Smtp-Source: ACHHUZ71igVjieiOVBe5OwNpXvYpBFSLtJ5Ic42R4PB4l+Nj4RpItw2e41Xdz0NOOcWIk6G9fv5gBQ==
X-Received: by 2002:a05:6a20:7484:b0:122:2e70:daa2 with SMTP id p4-20020a056a20748400b001222e70daa2mr5561998pzd.4.1687341754854;
        Wed, 21 Jun 2023 03:02:34 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e254-4eda-2716-05ea-20f5-b048.emome-ip6.hinet.net. [2001:b400:e254:4eda:2716:5ea:20f5:b048])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78742000000b0064f46570bb7sm2611196pfo.167.2023.06.21.03.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:02:34 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V8 12/23] mmc: sdhci-uhs2: skip signal_voltage_switch()
Date:   Wed, 21 Jun 2023 18:01:40 +0800
Message-Id: <20230621100151.6329-13-victorshihgli@gmail.com>
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

For UHS2, the signal voltage is supplied by vdd2 which is already 1.8v,
so no voltage switch required.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index fc37a34629c2..92fb69b7e209 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -142,6 +142,27 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, un
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
@@ -150,6 +171,9 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, un
 
 static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 {
+	host->mmc_host_ops.start_signal_voltage_switch =
+		sdhci_uhs2_start_signal_voltage_switch;
+
 	return 0;
 }
 
-- 
2.25.1

