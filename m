Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A2F64B1D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbiLMJDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbiLMJCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:02:07 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF01FAD1;
        Tue, 13 Dec 2022 01:02:00 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 21so1740872pfw.4;
        Tue, 13 Dec 2022 01:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqZSgcKwJJk5QRdmUrwY0usQ3tz0YwjuFkwc55K8IKE=;
        b=gDyc93MYWGkYbl+NO1mcFFz1hHZMl8T0IxucPzZ3kkccFA8fY+jXaJID6yKyMH1PrX
         6y5galtEGg7Ev+x2ETQISEiUXZxAIqcwhADltX+H89gOYKoQB4O10T2sF3cHVgDcD5Ml
         IPz8UWo+EuPClNuFIBA7TtHnrO10YVjiv7Yl8+CSqRk3ttalJDSe65/5/dnneGJlH+Kw
         fWy/J/+znhux+Yf8bKdp+mYhWQ28hgOGPUTxGLRW/o3N2DymA7aaQwTvkhLXP8gSTgb7
         j9N0dzeuV/xOxabT6VaWPEQW04JImVJkkqMhStDHWI3vLdLcX6PtYovggYZynTLSNjwt
         hq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqZSgcKwJJk5QRdmUrwY0usQ3tz0YwjuFkwc55K8IKE=;
        b=BzPOqsaAQN9vc94Lq+wlNZAqSGuEvum/U0IpfO9ZQVPBGb9niVc8yW6Q16A/VaJnb7
         sLsZA7Ak07JamGngpwdoinzsqUWGJwmLImIygv80iWELnM+ESLa6CftZYMrujEcw6hsQ
         dVJZ72duSc8+2JhmTMYK0LJM4PEI/kCObDkm/XpNm2y2juKJkMDNxp0mASvvrK8WB30E
         KbtCXjY6tOazluwwVSic737pYQJ9kEsfWEPW6vxcp7nAAQ3/4eQJaPHZ2zDTrDnGk01e
         0eCm8huXvQbBD16DOFv2wLnmJ3lEx1r/FqrrfeNVczbrypePMqxAtIPNGDlFmQ2AxIFE
         DAXw==
X-Gm-Message-State: ANoB5plk9Q6+P32g++uTZzFLdhp5BhgKpjU8MLpytAixKVnch0HrTODl
        3ocQlSXTCRXerVVr8NcIJCQ=
X-Google-Smtp-Source: AA0mqf73oRHYSZMbB/PzwZygcO08HIwkBGMVEJktsFGvWDeM9KoDCbOg7B9G142mHClvxvN2ikumNA==
X-Received: by 2002:a62:1402:0:b0:577:d422:70bf with SMTP id 2-20020a621402000000b00577d42270bfmr20631892pfu.13.1670922119974;
        Tue, 13 Dec 2022 01:01:59 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2dc-5c03-264b-f684-a8c9-21ae.emome-ip6.hinet.net. [2001:b400:e2dc:5c03:264b:f684:a8c9:21ae])
        by smtp.gmail.com with ESMTPSA id 81-20020a621954000000b0056b9ec7e2desm7141682pfz.125.2022.12.13.01.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 01:01:59 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V6 16/24] mmc: sdhci-uhs2: add clock operations
Date:   Tue, 13 Dec 2022 17:00:39 +0800
Message-Id: <20221213090047.3805-17-victor.shih@genesyslogic.com.tw>
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

This is a sdhci version of mmc's uhs2_[enable|disable]_clk operations.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 52587025d5e3..c7e411fa0a6e 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/iopoll.h>
 #include <linux/bitfield.h>
+#include <linux/ktime.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -329,6 +330,37 @@ int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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

