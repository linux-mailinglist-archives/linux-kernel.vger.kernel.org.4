Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB5A60E93D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiJZTnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbiJZTmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:42:43 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEC4CD5F2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:42:29 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9so4971789pll.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdKdi7U4SmFj0opqdWI8W6jamLQm1HEBWFpXKlflndY=;
        b=SWTE6P9QNXY1Z9Rs2EGlY2N1EtdUHngKz+3tEaOqDETcbCRxqr5XVtVo+tzidBfnly
         rdUMvhgihdoOVRoThHw1Lqo55HesJYQqRoXpK+SsSHkWsd22be5pn11cdJr9iYT7Nptg
         k1K/YF78Bo9W5QKKZOPDz7epnyS4bNuYrDNDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdKdi7U4SmFj0opqdWI8W6jamLQm1HEBWFpXKlflndY=;
        b=Rhi5JkwKFxmM/em/Lvxf+QGluPSSCWHwl5/xbN9MwVvudKnc7PxCQzGHZSYEMjXcR6
         7QNFF+9ahsTMbV+61dQ2HrVSX119qQO638AY/nRycUu1KYSWs9uGfeQyH/LDYH7jBclg
         7+AfnixKGXoYK5pQg6qZJWOMrIe0HtigcK61/lNomjVJNIqiK9I1z/A7DPEdcCDQT9zB
         Vp505lVvL8JaqVDoYdzdAMRgTzVZULO+aEa60eDf0umFUjxQ4Y9MVqmVHkKoNgP2xfib
         3wYnYnVc4KMmAi47PDbyv00CCo08vlV0DCqbDX0XnH2PhyzGQKa774RcAuFUehlutKfp
         oFpQ==
X-Gm-Message-State: ACrzQf0uSeQoRnZVd3qLRwLzpsu2j2TbNhGjuVUgc/mB0GaqbSeu+5ez
        8FqRPW9krSl7kYez1j6oII8Rgw==
X-Google-Smtp-Source: AMsMyM5hyd4eCNYOvaxSEKcBE2XsLoSrLSAhoCKCB+/WuE/WdlJli7RvnWKlc0gcAvx3yJnIiWlTwg==
X-Received: by 2002:a17:903:22cb:b0:186:a8ae:d0ff with SMTP id y11-20020a17090322cb00b00186a8aed0ffmr17416652plg.71.1666813348867;
        Wed, 26 Oct 2022 12:42:28 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:c9e3:74f3:6b2b:135])
        by smtp.gmail.com with UTF8SMTPSA id h11-20020a170902f2cb00b001837463f654sm3245037plc.251.2022.10.26.12.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 12:42:28 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Al Cooper <alcooperx@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Brian Norris <briannorris@chromium.org>, stable@vger.kernel.org
Subject: [PATCH v4 1/7] mmc: cqhci: Provide helper for resetting both SDHCI and CQHCI
Date:   Wed, 26 Oct 2022 12:42:03 -0700
Message-Id: <20221026124150.v4.1.Ie85faa09432bfe1b0890d8c24ff95e17f3097317@changeid>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221026194209.3758834-1-briannorris@chromium.org>
References: <20221026194209.3758834-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several SDHCI drivers need to deactivate command queueing in their reset
hook (see sdhci_cqhci_reset() / sdhci-pci-core.c, for example), and
several more are coming.

Those reset implementations have some small subtleties (e.g., ordering
of initialization of SDHCI vs. CQHCI might leave us resetting with a
NULL ->cqe_private), and are often identical across different host
drivers.

We also don't want to force a dependency between SDHCI and CQHCI, or
vice versa; non-SDHCI drivers use CQHCI, and SDHCI drivers might support
command queueing through some other means.

So, implement a small helper, to avoid repeating the same mistakes in
different drivers. Simply stick it in a header, because it's so small it
doesn't deserve its own module right now, and inlining to each driver is
pretty reasonable.

This is marked for -stable, as it is an important prerequisite patch for
several SDHCI controller bugfixes that follow.

Cc: <stable@vger.kernel.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Changes in v4:
 - Whitespace fixup
 - Add Adrian's Ack

Changes in v3:
 - New in v3 (replacing a simple 'cqe_private == NULL' patch in v2)

 drivers/mmc/host/sdhci-cqhci.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-cqhci.h

diff --git a/drivers/mmc/host/sdhci-cqhci.h b/drivers/mmc/host/sdhci-cqhci.h
new file mode 100644
index 000000000000..cf8e7ba71bbd
--- /dev/null
+++ b/drivers/mmc/host/sdhci-cqhci.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2022 The Chromium OS Authors
+ *
+ * Support that applies to the combination of SDHCI and CQHCI, while not
+ * expressing a dependency between the two modules.
+ */
+
+#ifndef __MMC_HOST_SDHCI_CQHCI_H__
+#define __MMC_HOST_SDHCI_CQHCI_H__
+
+#include "cqhci.h"
+#include "sdhci.h"
+
+static inline void sdhci_and_cqhci_reset(struct sdhci_host *host, u8 mask)
+{
+	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL) &&
+	    host->mmc->cqe_private)
+		cqhci_deactivate(host->mmc);
+
+	sdhci_reset(host, mask);
+}
+
+#endif /* __MMC_HOST_SDHCI_CQHCI_H__ */
-- 
2.38.0.135.g90850a2211-goog

