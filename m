Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6A55FE3A0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJMVA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiJMVAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:00:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4D35E306
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:00:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3562f0fb5a7so27861407b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/bUd8aKPH80AhGjW+++xUOpyDvX0kb5YuI9G+Oh1VW8=;
        b=Ump8uOis3JBmRWnAOLZHobNzJx2Li8xG9bd9NKtG4i6CMt5Rh1Yd7lTxDszAvk3Edd
         QZYdxBYgtg3/d4Zy/sQLh7uUzkzpqBf68G19QKg6grUhU7380+5lmV6MP7YR0xw6KNY9
         fIHuavZYQc9f45UNc+JTrLvMG7qBR8m5mX8tgDy2lt7MQim3VmDXXQQuHk8T84G6FVQH
         ecc+Axgs04dVYxO4xc5iQYGii4BJ3uGa0NrgCNs4OxdBvzdAlGwaQQ6htxXGNaqznGPZ
         JZxRey1d0IeHMLiw+uC06q6sYFAXbm33JLYbMzZbA0VpIKJ5oM72FdKlknkqUscOT/Zi
         W9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/bUd8aKPH80AhGjW+++xUOpyDvX0kb5YuI9G+Oh1VW8=;
        b=K7GRAzdgh2A8HD1sw2ICuQSB0asiR1XBBu2lftQI8pqQar+NOzIexip4tNDYrJrgfN
         2tcNhBcRnDIG6ocDNis1mutZ844KLlahQ/Sq4OBTlRsjKAVLDcIQYW04IVEDS07Sje5w
         TCAgsn1dOpVkhjVxBBrsNCT7y6HpryftSmCeaz/PsMAkGHJclCZ6GQYC8OBXKhWC8hv5
         O7Yk8gIk3gWv21mEPEcWDF43NQWT4h9ZijCiHxlfP/YvBWYkcP9htB8K3Oe94KTwh1Hx
         THATL6mDlicdySuFNn3baxaXSHfPjb04cjPRB5l5qL7LNRbjW17GFut/OD00ms07CcwM
         /PcA==
X-Gm-Message-State: ACrzQf16SjjfuKwKQPF5VkVWvDJvsyLQ+kZtP1bgPhENIoyuUqJaLhyC
        N0AWgoVD8EEa1IPCHOfzsIvERLQ=
X-Google-Smtp-Source: AMsMyM5rjCOZkY2UjSc3mVAWtSHXgFM6Tx/9iDX/1by0I51wPhLztvW5wIcgFsgGa3/iHoq07ZtMxHc=
X-Received: from ptf16.nyc.corp.google.com ([2620:0:1003:314:397e:65e9:dc1c:f5cd])
 (user=ptf job=sendgmr) by 2002:a25:254a:0:b0:6bc:d8a1:939c with SMTP id
 l71-20020a25254a000000b006bcd8a1939cmr1782359ybl.438.1665694822583; Thu, 13
 Oct 2022 14:00:22 -0700 (PDT)
Date:   Thu, 13 Oct 2022 17:00:17 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221013210017.3751025-1-ptf@google.com>
Subject: [PATCH v3] mmc: sdhci-pci-core: Disable ES for ASUS BIOS on Jasper Lake
From:   Patrick Thompson <ptf@google.com>
To:     Linux MMC Development <linux-mmc@vger.kernel.org>
Cc:     Sangwhan Moon <sxm@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Patrick Thompson <ptf@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhanced Strobe (ES) does not work correctly on the ASUS 1100 series of
devices. Jasper Lake eMMCs (pci_id 8086:4dc4) are supposed to support
ES. There are also two system families under the series, thus this is
being scoped to the ASUS BIOS.

The failing ES prevents the installer from writing to disk. Falling back
to HS400 without ES fixes the issue.

Signed-off-by: Patrick Thompson <ptf@google.com>

Fixes: 315e3bd7ac19 ("mmc: sdhci-pci: Add support for Intel JSL")

---

Changes in v3:
* Remove redundant MMC_CAP2_HS400 selection

Changes in v2:
* Only disable ES instead of CQE in its entirety.
* Target Jasper Lake (JSL)
* Target ASUS BIOS instead of specific system family

 drivers/mmc/host/sdhci-pci-core.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 169b84761041..34ea1acbb3cc 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -914,6 +914,12 @@ static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
 		dmi_match(DMI_SYS_VENDOR, "IRBIS"));
 }
 
+static bool jsl_broken_hs400es(struct sdhci_pci_slot *slot)
+{
+	return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_JSL_EMMC &&
+			dmi_match(DMI_BIOS_VENDOR, "ASUSTeK COMPUTER INC.");
+}
+
 static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
 {
 	int ret = byt_emmc_probe_slot(slot);
@@ -922,9 +928,11 @@ static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
 		slot->host->mmc->caps2 |= MMC_CAP2_CQE;
 
 	if (slot->chip->pdev->device != PCI_DEVICE_ID_INTEL_GLK_EMMC) {
-		slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
-		slot->host->mmc_host_ops.hs400_enhanced_strobe =
-						intel_hs400_enhanced_strobe;
+		if (!jsl_broken_hs400es(slot)) {
+			slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
+			slot->host->mmc_host_ops.hs400_enhanced_strobe =
+							intel_hs400_enhanced_strobe;
+		}
 		slot->host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
 	}
 
-- 
2.38.0.413.g74048e4d9e-goog

