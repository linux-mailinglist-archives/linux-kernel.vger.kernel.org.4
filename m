Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E7C717DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjEaLRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbjEaLRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:17:34 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B435F135;
        Wed, 31 May 2023 04:17:32 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d247a023aso3843991b3a.2;
        Wed, 31 May 2023 04:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685531852; x=1688123852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqCO0zG8sg4sud8a/zg7+AbJ/Mka1xuDjw890KKydlg=;
        b=nsMryPQVRfzMORrX9K4nt7H70UHnEGHTCwD9vBp0dciYv3aDQ5yxxhtJB/kQ8S2AQ6
         YOR9tjOAvlqsxagRCX4ms102lNe4NBjEpKQX2RN/wxnbdo10tLne9a6yVDGVyxMqHaTD
         CuBnmZehhGuXe0UtThrjZq7qLomnNvCFaVWq741C9nRKGQi2lpepBlBmrNIqmdkb59i+
         8g88cYZp6E3GypvSEuXzzL9fbOwCJc6IFMYqRRihzTFlRlHfegyy6hwArLdxCS8jOJJD
         hT9wYjZp+uBLgxsSv2ACSapIdkI2Hm3I/wkbPKUrUS1SnkFJYAvnn71nfkxzjt1mRRvf
         HWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685531852; x=1688123852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqCO0zG8sg4sud8a/zg7+AbJ/Mka1xuDjw890KKydlg=;
        b=PTLtFabC0TKHcoloKQ3MgYYTqteyFRfnBwfSkO1QU23KaV935URCp1qjxiBTDg8HUT
         LrXXPJw6i9ZUhntZnwI7JasJuQ0XJwnIeEBUSco37cRFmy3Tfg2B93ibPHvrUQArT0cP
         rALuV40DtmAk6a++BMDXtuHdMHAZzCKMXcR+v4SMVoT3zv68L5w+REeWxXeJWW18Iz57
         O/TCTPzKhYg9nfrrmD7O54FuuQL+CWiwZcyvYRNnG+cFDJFaizHT0+zHVGI2AG1n52dT
         IR9W5cI7TltKrUA+FDmPMsH3A7L3VphAwe7k5sQ468+DbqTKJVbRY+Cirrl7wQ1IPPZF
         oFlQ==
X-Gm-Message-State: AC+VfDxmrTna48yRDY5j8YII8bkf2NpZy8/HU8YBgA6P02TpIuBylyfR
        JALNQt0wc/IpwABDmhZCvmo=
X-Google-Smtp-Source: ACHHUZ4XFjGuKVUzASt7wWuPjFdyIe36gKGd7yJ//CVXOEWoBvru5Asqr3/e/tTNBHyFtjnxURMOLw==
X-Received: by 2002:a17:902:f54b:b0:1b0:5425:2165 with SMTP id h11-20020a170902f54b00b001b054252165mr4891687plf.29.1685531852102;
        Wed, 31 May 2023 04:17:32 -0700 (PDT)
Received: from localhost.localdomain (111-82-252-250.emome-ip.hinet.net. [111.82.252.250])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903231100b001b0aec3ed59sm1076588plh.256.2023.05.31.04.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 04:17:31 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V4 3/4] mmc: sdhci: Add VDD2 definition for power control register
Date:   Wed, 31 May 2023 19:15:17 +0800
Message-Id: <20230531111518.396868-4-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230531111518.396868-1-victorshihgli@gmail.com>
References: <20230531111518.396868-1-victorshihgli@gmail.com>
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

Add new definition for VDD2 - UHS2 or PCIe/NVMe.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f4f2085c274c..140a0c20d4f2 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -100,6 +100,14 @@
 #define  SDHCI_POWER_300	0x0C
 #define  SDHCI_POWER_330	0x0E
 
+/*
+ * VDD2 - UHS2 or PCIe/NVMe
+ * VDD2 power on/off and voltage select
+ */
+#define SDHCI_VDD2_POWER_ON	0x10
+#define SDHCI_VDD2_POWER_120	0x80
+#define SDHCI_VDD2_POWER_180	0xA0
+
 #define SDHCI_BLOCK_GAP_CONTROL	0x2A
 
 #define SDHCI_WAKE_UP_CONTROL	0x2B
-- 
2.25.1

