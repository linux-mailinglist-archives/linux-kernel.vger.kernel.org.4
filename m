Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AC873B4E5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjFWKLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjFWKKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:10:07 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C8130D0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:09:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31110aea814so519649f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514941; x=1690106941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NBfwHB1m61Ki4N8NOLCZ9xwyv+VdQ6tisfULtxIs/U=;
        b=Xqqbvtrr+T9ovr4Km5D6kknfBFx6z/ui+26AR/uvCaZDO5tZ2BHzg23OcbtvFmQxJA
         khtEcnOMUracH2du55BSB+PBuJgO58h4V9QNIm9OF5LJ8lzA1VflejtvXldY43WbgOyn
         v1zRm1fr9Xg7lvG6/y54PO0CHT1jao9H5W7y1nxJCSLNUP/p3Su2owknd4hsegO9lY0v
         LDCSlE0HqvuWhnHw4t3cgrHDvvhw8V+DIc6IGGUJYwZNZgmGXmArKo/z9YRMHAiTL1zZ
         /3VrgsrRoUdMpVuM26ElMyqjvCRWMLx1Wg0sldoq4lMZ76rdxl35xVooqWFJq1KE9pge
         aCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514941; x=1690106941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NBfwHB1m61Ki4N8NOLCZ9xwyv+VdQ6tisfULtxIs/U=;
        b=SPzXKYCHW9okxGKCkVT9AZc9pYvT46XwGfaHAhQq1HQp2oPK3luOr/OyvMSPmafltK
         3QdGIQNs0yJn/BxuvVH9uMLUeJ0sBAuBWKYpDlCVUsx9Hsc9PWFxx3A8qbD5FEFd1SpX
         iE04torf6qNePbSaPicrbpaV6Dy93+eJMWBm7m+IsVXwiOgpi6nrK435/aMctU2sIJa2
         DaV8LZmjY+czaW+cExj14fhPzvI61eW2iG2FXj/hZ9i/OWlMnsECOJO8nB8N5yB1efHD
         sdOKriIusx/S4XuKdX1gVS1FNNTBTDSa2mZ6H4zmI3JUBIKRdq8ces/xg8gRibJnexWs
         kCmA==
X-Gm-Message-State: AC+VfDzKWC42j1To4gjmpXmSjKIUDPJSynikiSoV6NiXweSoMuBpveQ8
        Efhq7j5rNvvmLI4yifZ3VNaYNw==
X-Google-Smtp-Source: ACHHUZ4jGiHCI/24toYXjMRszi1Z4t4BmSblfrJoj1P7yOD2TuNfNlTHgWcbZAhlld3yStKWzQs8wg==
X-Received: by 2002:a05:6000:14d:b0:311:143c:7bd1 with SMTP id r13-20020a056000014d00b00311143c7bd1mr17192221wrx.49.1687514941665;
        Fri, 23 Jun 2023 03:09:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id k18-20020adfe8d2000000b0030ae3a6be4asm9278100wrn.72.2023.06.23.03.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:09:01 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next v2 09/12] net: stmmac: replace the ext_snapshot_en field with a flag
Date:   Fri, 23 Jun 2023 12:08:42 +0200
Message-Id: <20230623100845.114085-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623100845.114085-1-brgl@bgdev.pl>
References: <20230623100845.114085-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c     | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c      | 5 ++++-
 include/linux/stmmac.h                                | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index d8bcf9452197..a3d0da4e9e91 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -326,7 +326,7 @@ static int intel_crosststamp(ktime_t *device,
 	/* Both internal crosstimestamping and external triggered event
 	 * timestamping cannot be run concurrently.
 	 */
-	if (priv->plat->ext_snapshot_en)
+	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
 		return -EBUSY;
 
 	priv->plat->int_snapshot_en = 1;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 8b50f03056b7..afd81aac6644 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -195,7 +195,7 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
 	 */
 	ts_status = readl(priv->ioaddr + GMAC_TIMESTAMP_STATUS);
 
-	if (!priv->plat->ext_snapshot_en)
+	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
 		return;
 
 	num_snapshot = (ts_status & GMAC_TIMESTAMP_ATSNS_MASK) >>
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index b4388ca8d211..3d7825cb30bb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -192,7 +192,10 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 		write_unlock_irqrestore(&priv->ptp_lock, flags);
 		break;
 	case PTP_CLK_REQ_EXTTS:
-		priv->plat->ext_snapshot_en = on;
+		if (on)
+			priv->plat->flags |= STMMAC_FLAG_EXT_SNAPSHOT_EN;
+		else
+			priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
 		mutex_lock(&priv->aux_ts_lock);
 		acr_value = readl(ptpaddr + PTP_ACR);
 		acr_value &= ~PTP_ACR_MASK;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 3365b8071686..0a77e8b05d3a 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -212,6 +212,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP	BIT(5)
 #define STMMAC_FLAG_VLAN_FAIL_Q_EN		BIT(6)
 #define STMMAC_FLAG_MULTI_MSI_EN		BIT(7)
+#define STMMAC_FLAG_EXT_SNAPSHOT_EN		BIT(8)
 
 struct plat_stmmacenet_data {
 	int bus_id;
@@ -286,7 +287,6 @@ struct plat_stmmacenet_data {
 	int int_snapshot_num;
 	int ext_snapshot_num;
 	bool int_snapshot_en;
-	bool ext_snapshot_en;
 	int msi_mac_vec;
 	int msi_wol_vec;
 	int msi_lpi_vec;
-- 
2.39.2

