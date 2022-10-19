Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FFD604348
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiJSLdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiJSLdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:33:16 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAA88305F;
        Wed, 19 Oct 2022 04:09:54 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so16435539pjf.5;
        Wed, 19 Oct 2022 04:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTXOWmjLDmmd0AthIyoirfTIKVO51onpGqfIS2mHoBI=;
        b=o01ykx0o1Uau/DvacEVzay+sQisMbr+3E4LrPwBMPTBHNUK4YkC5zpihdyUtqS+iFG
         Kf2wNnLTvzcG/UDPdKyn6w0oAamUa2Uo3sdYTjEDOZW7psheNyvoKFIyr6G2bJ6ywcuE
         uOCZeV6RUL5umefz72sBmguQ+KLac1u0l3lK3fjtH+AioIVXZ2p8LRIi4qvSUVDynbd+
         tpMDDSzPRdVtV/ESOaKYG3TFLciCgfHMTIi4gWbm1CG8qYdaHRbe6Ww3w//+ahntdodI
         lAAkyZ0e5BF3UeT7tjnSJ8iEG0CSPyQPiKyWPWyWLhPWG3EQvo1aXKAzJR81pg7uIg44
         e/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTXOWmjLDmmd0AthIyoirfTIKVO51onpGqfIS2mHoBI=;
        b=aT23C+f0/TdLCmbeRR6TBBcHSF33i0flp4Uqq3yzXeCgBEIRwCE3f1SaRtfRfsa//o
         8lWNfgU0I2unjBo9oA3G15Y/Nq43b9shawo4QwVFLYWdLJcSwadZwlHT2ExYXif4b1cQ
         /Lt0BpgJvvI2g8vrwlkWM0nFPd+92Hlvncf6rymDhyB8b0r6Tm7c9+Z3TleSk2TCMbGw
         /fUlb3GAJBs+SaKCI/TjJ6od8wEhJ7HZ50NCCwg5+Q8RvDB6vlVRthvMU2nIB8SLcoay
         ggLwD3KhMy3RiNDE9OZZAEm3nT/G+KEB9yNe42KaD0oLX0Kro85PmIg/DZAneScJoZ3d
         bFuQ==
X-Gm-Message-State: ACrzQf04uyIcJBNRW3sbh5Ej74niVzpd4yQ2ZfoChCjQ2e1Ws7dlDTUE
        0yR5XksaZyaEy4sqJkTBdto=
X-Google-Smtp-Source: AMsMyM5kXFjPWyFzKNI305oBPjqPqncVM9X1ODqQMP8fhIYDHVrI8M25gR+z934LSq+I0nuuc1hTCA==
X-Received: by 2002:a17:902:d486:b0:181:33f0:f60b with SMTP id c6-20020a170902d48600b0018133f0f60bmr7979575plg.174.1666177669450;
        Wed, 19 Oct 2022 04:07:49 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-821b-9613-557f-bd8d.emome-ip6.hinet.net. [2001:b400:e258:8c34:821b:9613:557f:bd8d])
        by smtp.gmail.com with ESMTPSA id cc11-20020a17090af10b00b0020dc318a43esm8696225pjb.25.2022.10.19.04.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:07:49 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 17/26] mmc: sdhci-uhs2: add clock operations
Date:   Wed, 19 Oct 2022 19:06:38 +0800
Message-Id: <20221019110647.11076-18-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
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
index 9ceae552c323..afaca5d96938 100644
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
@@ -560,6 +592,10 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 
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

