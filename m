Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAA460B768
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiJXTXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbiJXTVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:21:55 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA4C74E1B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:57:23 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso7194132pjc.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4yDlVPTic37KZH9AxC8wwe58VczX65vPPEZffD7EQE=;
        b=M3glaN3KH7v0Fj2TVX/4rEpKIqio36DUJjjhUWq3EPd2n2k/0Wvh02RurfIdEzV+9M
         eqcD/iUxn2JpiQDZOvX04A+jwTMsRrIANx1MRiQUV29n9kQ7J2AobjK/cvv/YRt4F8TJ
         Q0m4E4bXsFTCCwhixA4Dgy+lEpaZb3laJvH4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4yDlVPTic37KZH9AxC8wwe58VczX65vPPEZffD7EQE=;
        b=MIJj3fAJ03KEQjvUh7Us6kB9iNxyNIt9O24OnzWXGSCDUvBfKUDW7kGZlW9zaZDIqd
         ARNR7JDsQQhFNGpHEVnd/VRz4rLO+xOuE4TIwsrHQYJUQH23AJxR4Tokx8Xv7Nf/jIi+
         TWgnLlQosrpHCzsNMn+EYZKCQ+5SzR+GmwHiSccCHLjFX7UbPK7yH49LkWmm3Yc0uD8Z
         O/DuunoDN+L4YOsgPSk3jYlMuPBcuosSNj67CvAQFZaLfyqiZkXBT3ONXmwb7MLnSOVo
         U0HrOxIvmL8hHH456Ge0aVVUgFPRiQ1HPQ9WGLZV1PPawFReZG5uFj2MSZeDBJjVGJjT
         ygzg==
X-Gm-Message-State: ACrzQf2ue06nqp73iG64lRQPMtAIINVkijzIVtYA5sq92QIUW7AOwsrF
        Un/bQGHrHSS71STD+/LILZP/4w==
X-Google-Smtp-Source: AMsMyM6ny+LJ0qluFB3FlBn0XusNLAlRcF+64cHrIlzkiXcZYyKZQ4gXt6vO1NIgvPzupD8Xwm8dXg==
X-Received: by 2002:a17:90b:3d8e:b0:213:c01:b8bb with SMTP id pq14-20020a17090b3d8e00b002130c01b8bbmr7616310pjb.68.1666634189383;
        Mon, 24 Oct 2022 10:56:29 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:808b:e2f6:edcf:ccb0])
        by smtp.gmail.com with UTF8SMTPSA id r24-20020aa79638000000b0056bab544100sm80142pfg.197.2022.10.24.10.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 10:56:28 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Faiz Abbas <faiz_abbas@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 6/7] mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
Date:   Mon, 24 Oct 2022 10:55:00 -0700
Message-Id: <20221024105229.v3.6.I35ca9d6220ba48304438b992a76647ca8e5b126f@changeid>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221024175501.2265400-1-briannorris@chromium.org>
References: <20221024175501.2265400-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 [[ NOTE: this is completely untested by the author, but included solely
    because, as noted in commit df57d73276b8 ("mmc: sdhci-pci: Fix
    SDHCI_RESET_ALL for CQHCI for Intel GLK-based controllers"), "other
    drivers using CQHCI might benefit from a similar change, if they
    also have CQHCI reset by SDHCI_RESET_ALL." We've now seen the same
    bug on at least MSM, Arasan, and Intel hardware. ]]

SDHCI_RESET_ALL resets will reset the hardware CQE state, but we aren't
tracking that properly in software. When out of sync, we may trigger
various timeouts.

It's not typical to perform resets while CQE is enabled, but this may
occur in some suspend or error recovery scenarios.

Include this fix by way of the new sdhci_and_cqhci_reset() helper.

Fixes: f545702b74f9 ("mmc: sdhci_am654: Add Support for Command Queuing Engine to J721E")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v3:
 - Use new SDHCI+CQHCI helper

 drivers/mmc/host/sdhci_am654.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 8f1023480e12..6a282c7a221e 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -15,6 +15,7 @@
 #include <linux/sys_soc.h>
 
 #include "cqhci.h"
+#include "sdhci-cqhci.h"
 #include "sdhci-pltfm.h"
 
 /* CTL_CFG Registers */
@@ -378,7 +379,7 @@ static void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 
-	sdhci_reset(host, mask);
+	sdhci_and_cqhci_reset(host, mask);
 
 	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST) {
 		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
-- 
2.38.0.135.g90850a2211-goog

