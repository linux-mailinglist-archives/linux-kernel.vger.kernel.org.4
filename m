Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53795738EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjFUS1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjFUS0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:26:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DB21BD7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:26:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3112c11fdc9so4287100f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687371985; x=1689963985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZoPiuKyiNxA5Jm5ZMWEJ6HMm0QfTiaA8bIFviBXOuA=;
        b=BGRlcdZCyKur3g15bwV1zzi6jmOTAm2u3A5RtfTRJ9cWrTSiNVLGm2zcn7T7U360Pd
         NZZ6R006ZtnKytneWPK9hSOfLGCEc7yjJdLqlpXvvs/EP4t3GyWVKavkPIfj25NxqMsH
         oOWlcCV08FgSzUCBjngx+crQrWN+YJpA2+61RdKBRCJoTUpHgVDyoTYxNuoOO9M0bsn1
         BcojsUgvUu/hlzHstQDAjI4FW2kQ6ej8Qzy8c0DlLsL6DvGzYc0tkDIU+bn3NkFDXf/o
         Z5OzOY/Wdftotx3GO4L9NhmhBgBaMlvSIto7ubaLN0wbZgBQeL5JBOYxmH0+4Kw4vF6n
         tiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687371985; x=1689963985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZoPiuKyiNxA5Jm5ZMWEJ6HMm0QfTiaA8bIFviBXOuA=;
        b=i3D/Vo2MYsyiUNEbseC3NdZxAqTyMZ188u8JmasBBVFErlelLDTyfHtg+lmSKoLX/j
         bvBLvFMAjZcFzVDaaxPX3xjmQ5IINRiGDtTe4UlWQgXGizo7WzfdzKdJZiW4BiTFGa7o
         xiXqB1EchPl+gbv8F81p7uqibS02U3IYKS2H79UrUpDrh3yKkTL23xQzw6mYpKgE3yZO
         YQnb9LvVHYuN7gu2jsdYWSJ5gknYRZDgc55xUbKY9u8bues7icIY12nVaH7NuEdM5iEl
         xIo2iliNqY9edlNuvWQpLFGHlS8eJ+CWJw8L3MeImgfpHlgxnXglVUeh6S+weNADRWvL
         Jc9w==
X-Gm-Message-State: AC+VfDxVWp2fNjvVvtWECOtApkMgdV8tPBpvoPKEwhIH2Bw6xtHm7Hl6
        eGN2eBNqJbys8NtA6b2YGtjrkQ==
X-Google-Smtp-Source: ACHHUZ70e5zIRUrmJgK3zmYPAKNHMLaVmb4nhFe+8NJBgYkcZYUKvCg6KkRIQg+xwJMHYPvOlSoGiA==
X-Received: by 2002:a5d:63c5:0:b0:30a:efd2:c170 with SMTP id c5-20020a5d63c5000000b0030aefd2c170mr10726903wrw.37.1687371985426;
        Wed, 21 Jun 2023 11:26:25 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id z13-20020adff74d000000b0030af15d7e41sm5176994wrp.4.2023.06.21.11.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:26:24 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next 10/12] net: stmmac: replace the int_snapshot_en field with a flag
Date:   Wed, 21 Jun 2023 20:25:56 +0200
Message-Id: <20230621182558.544417-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621182558.544417-1-brgl@bgdev.pl>
References: <20230621182558.544417-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Drop the boolean field of the plat_stmmacenet_data structure in favor of a
simple bitfield flag.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c     | 10 +++++-----
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c |  2 +-
 include/linux/stmmac.h                                |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index a3d0da4e9e91..f194a905d04f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -329,7 +329,7 @@ static int intel_crosststamp(ktime_t *device,
 	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
 		return -EBUSY;
 
-	priv->plat->int_snapshot_en = 1;
+	priv->plat->flags |= STMMAC_FLAG_INT_SNAPSHOT_EN;
 
 	mutex_lock(&priv->aux_ts_lock);
 	/* Enable Internal snapshot trigger */
@@ -350,7 +350,7 @@ static int intel_crosststamp(ktime_t *device,
 		break;
 	default:
 		mutex_unlock(&priv->aux_ts_lock);
-		priv->plat->int_snapshot_en = 0;
+		priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 		return -EINVAL;
 	}
 	writel(acr_value, ptpaddr + PTP_ACR);
@@ -376,7 +376,7 @@ static int intel_crosststamp(ktime_t *device,
 	if (!wait_event_interruptible_timeout(priv->tstamp_busy_wait,
 					      stmmac_cross_ts_isr(priv),
 					      HZ / 100)) {
-		priv->plat->int_snapshot_en = 0;
+		priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 		return -ETIMEDOUT;
 	}
 
@@ -395,7 +395,7 @@ static int intel_crosststamp(ktime_t *device,
 	}
 
 	system->cycles *= intel_priv->crossts_adj;
-	priv->plat->int_snapshot_en = 0;
+	priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 
 	return 0;
 }
@@ -609,7 +609,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	plat->ext_snapshot_num = AUX_SNAPSHOT0;
 
 	plat->crosststamp = intel_crosststamp;
-	plat->int_snapshot_en = 0;
+	priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 
 	/* Setup MSI vector offset specific to Intel mGbE controller */
 	plat->msi_mac_vec = 29;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index afd81aac6644..fa2c3ba7e9fe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -180,7 +180,7 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
 	u64 ptp_time;
 	int i;
 
-	if (priv->plat->int_snapshot_en) {
+	if (priv->plat->flags & STMMAC_FLAG_INT_SNAPSHOT_EN) {
 		wake_up(&priv->tstamp_busy_wait);
 		return;
 	}
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 0a77e8b05d3a..47708ddd57fd 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -213,6 +213,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_VLAN_FAIL_Q_EN		BIT(6)
 #define STMMAC_FLAG_MULTI_MSI_EN		BIT(7)
 #define STMMAC_FLAG_EXT_SNAPSHOT_EN		BIT(8)
+#define STMMAC_FLAG_INT_SNAPSHOT_EN		BIT(9)
 
 struct plat_stmmacenet_data {
 	int bus_id;
@@ -286,7 +287,6 @@ struct plat_stmmacenet_data {
 	struct pci_dev *pdev;
 	int int_snapshot_num;
 	int ext_snapshot_num;
-	bool int_snapshot_en;
 	int msi_mac_vec;
 	int msi_wol_vec;
 	int msi_lpi_vec;
-- 
2.39.2

