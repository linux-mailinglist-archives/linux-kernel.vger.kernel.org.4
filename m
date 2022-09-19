Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DB45BD5D2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiISUrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiISUrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:47:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C703B4A13E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:47:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y5-20020a25bb85000000b006af8f244604so309697ybg.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=2VpmpPOU+YCJvEpT9wllRVbdFOmf6SySHisIVkYbNR0=;
        b=MxyLPkp2cx9Vw+U01IHnp/7KzFjf8iDt42l5C5qhNipvJtbzOZdY/CD1C5Ri8FU959
         HgennBpDerr8NkeAK6dgLRMAiXSac7nW9cV2FVMkgu7z6dA7yNPCuypWrRC1mqSoabQa
         +pkzbuvKjhI/eXROIrF7HzTk+e5N/6YRR42ZAw71GbKee8ZoKq4rWE9BwCYhtRGud4vH
         2v5EYGC8KSLoHHUIQUB+Vf77IsP5REgjrVFUYHSV2dkRtZbWaHt8Yfw6loWcU0YsnzDh
         l5ARnKQthRj+lxzrQ0OTpepwFztBsLl3GVTKdwgXW+r+b5FsHXM28W017Cpi2uy0g1QL
         CEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=2VpmpPOU+YCJvEpT9wllRVbdFOmf6SySHisIVkYbNR0=;
        b=mpiR50Fd85L5Ad4HYFU94MkadYGkD+3UvjlbEka6Dr2ytCcB1xjW2vIQzDDaxhmcqA
         Rva67W1/Y4IGFiNjPpkZD2LmO3rWPGwaYglLIJlc994iRLyuTHOCqER+2wg9ASXGHRgv
         Qc0gRB/PlQ4hL9ZOhTsX0Gn42ntYt7hkt6yFSVWFSYNwtAqyd4lUvRGtH0tk8BfX2Wq3
         Dg/88N7BE0tx5TVcFK6EhWCc0lKDfiYVIlkdQH/24NEokv6KTSYlKrkTaMOI7yuMS7yZ
         cXURP9fOMih3nR0cHveewhqJaPyINCJYmIWO/BkDcl1hrnHyL6GJ3A1utQtFTa+mkPTK
         dr5g==
X-Gm-Message-State: ACrzQf27OXpfOKrRl6sY2oRclKbXpgWcmT5HGDUWQhmCWoIwzfQpjRSP
        ytYZBtD0UTL7L5URBOnHhE3/58k=
X-Google-Smtp-Source: AMsMyM68ZevqarY5r0B78474DGXHr/QLHL34TGinEO0JyK3r+IWQFGYuoeDk4/W10gTO87K+htZuJgo=
X-Received: from ptf16.nyc.corp.google.com ([2620:0:1003:314:fa14:2d2d:5271:3002])
 (user=ptf job=sendgmr) by 2002:a81:155:0:b0:345:7ab3:5a18 with SMTP id
 82-20020a810155000000b003457ab35a18mr15774365ywb.228.1663620431974; Mon, 19
 Sep 2022 13:47:11 -0700 (PDT)
Date:   Mon, 19 Sep 2022 16:46:51 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220919204651.1517899-1-ptf@google.com>
Subject: [PATCH v2] mmc: sdhci-pci-core: Disable ES for ASUS BIOS on Jasper Lake
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

---

Changes in v2:
V1->V2:
* Only disable ES instead of CQE in its entirety.
* Target Jasper Lake (JSL)
* Target ASUS BIOS instead of specific system family

 drivers/mmc/host/sdhci-pci-core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 622b7de96c7f..42406f76f65c 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -893,6 +893,12 @@ static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
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
@@ -901,9 +907,13 @@ static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
 		slot->host->mmc->caps2 |= MMC_CAP2_CQE;
 
 	if (slot->chip->pdev->device != PCI_DEVICE_ID_INTEL_GLK_EMMC) {
-		slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
-		slot->host->mmc_host_ops.hs400_enhanced_strobe =
-						intel_hs400_enhanced_strobe;
+		if (jsl_broken_hs400es(slot)) {
+			slot->host->mmc->caps2 |= MMC_CAP2_HS400;
+		} else {
+			slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
+			slot->host->mmc_host_ops.hs400_enhanced_strobe =
+							intel_hs400_enhanced_strobe;
+		}
 		slot->host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
 	}
 
-- 
2.37.3.968.ga6b4b080e4-goog

