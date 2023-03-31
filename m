Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF106D1E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjCaK6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjCaK5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:57:07 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EB61F796;
        Fri, 31 Mar 2023 03:56:48 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so24961322pjb.4;
        Fri, 31 Mar 2023 03:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680260208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+epQ2fJqKm8pKG4mkhGCfxfL0+iUltjeegx/M8nHNZM=;
        b=F/2D6JivO4dtadMidG0Cg3NGecqcU8zbFYmHvudTJRUP4hteyz4mksmwrkMh9Xqxfl
         5vG9+GAyEkr5CknMcLJJP00E0GRZKJVRnGV6PS4bXhcrr2i6BBq8dlydMrHjcYL4TCSE
         TEIOOknwPG2sin07P87DoYHViZi6UfvF78/PiMMK5KA934jJuCTYR9b887Q8ayZa5ylQ
         6Xf5fMQguNNzaEVLYgmAFODe95M4hOhqDQ09F/1Vlth4+3UWROYd0UPiKxAwESjUrDCf
         TuKAEgWFNDX07NM0nvRmT0+fUlofXdFQerJDFSQ9nvc4/0Mssa6wmgFqA+S1qtA2ccxh
         DGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680260208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+epQ2fJqKm8pKG4mkhGCfxfL0+iUltjeegx/M8nHNZM=;
        b=QvBSeLGw90Y3kQ+BS/VVBwuAg2RW1FhiEEjNV72Uvjpqp3qvzCooVzcQrif5cpk5Li
         r1pSAdowIlQEjkiYBmpo4VUpp9w/oW+XK5vlHE42vO/T4xajOPu+r31TCNgjFOsS5WPq
         U2mYhsxtCsU2S0hHDU5V2gO7jZugP4UVgke7AKYGMf/qoQ+zb6VIKYHYE8so76jZdXUI
         HPbClmwm5xFi0afaCjeLEU07FAqWVo8GKolLfT7tDukKYKoaOoXTEqaEMykWqNiSEbL9
         RjtQERQ0JUrY0Q2NAICNkQG40pQqzg11PCSiqZYTiIkZqy5Tl8xQsZM5Ygnmiy3sthNC
         8QLg==
X-Gm-Message-State: AAQBX9frfUqCJS3KLUeffe5QZmFYBIK4FV8dL1cYs4KakfiI9ifhN6Ev
        C2vpq1AsLCdD6sOzZSHoSzQFbXm7wK8=
X-Google-Smtp-Source: AKy350ZPNrsIOCt4+wghNpWtnD27MEu4a6dpbZSg2CTGKJkH/7eX4n1Jo87MZvSipgVaGC2NSG9jRw==
X-Received: by 2002:a17:902:d2d2:b0:1a0:6ed9:f9d0 with SMTP id n18-20020a170902d2d200b001a06ed9f9d0mr34107427plc.68.1680260208454;
        Fri, 31 Mar 2023 03:56:48 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e25c-983f-c7ff-3efd-77d9-6c16.emome-ip6.hinet.net. [2001:b400:e25c:983f:c7ff:3efd:77d9:6c16])
        by smtp.gmail.com with ESMTPSA id f19-20020a170902e99300b0019acd3151d0sm1287665plb.114.2023.03.31.03.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 03:56:48 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V7 16/23] mmc: sdhci-uhs2: add clock operations
Date:   Fri, 31 Mar 2023 18:55:39 +0800
Message-Id: <20230331105546.13607-17-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/mmc/host/sdhci-uhs2.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index e2972be1889f..71ac76065886 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/iopoll.h>
 #include <linux/bitfield.h>
+#include <linux/ktime.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -328,6 +329,37 @@ static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
-- 
2.25.1

