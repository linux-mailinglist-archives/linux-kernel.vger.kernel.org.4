Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458A4673A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjASNjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjASNjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:39:12 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C36148A3A;
        Thu, 19 Jan 2023 05:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wZnguLYFHx/nkdscInTbXfSlsq7FjSguDdlCNRKnzBw=; b=XicZjbPhRQCftEw6C0ulux3+3Q
        /7XEYhsGvVsTGkhvq8KI+QJiiiTtFOfLCqIsTw0z1LMfudM+KZkBrw4iX2PHXOnvSBE46SM1lDmqO
        X8wzj2XCbiBM+3J3wUbXun/RqGwx88cW7X9nzse1wYa5RMwB6XcTJ2OTQeDF6xNwbcYozB6s6dFvK
        221GgG6W+UxloSROcn/RTISqqsRwO/BhPMX/nOMR1UdLWe2w1bsk7XVcLJ7Z5+RwY23GnywXF/IqL
        b2hDLYHuHZp3ziuh3TRsJMcnowUTDFmz1ATTL/qZq6zgSh3pZL1rfWl8Fgijf4DizxXcRbUoE0fOn
        2qkzdqcQ==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1pIV8G-0016bd-DX; Thu, 19 Jan 2023 15:39:08 +0200
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 1/4] arm64: tegra: Mark host1x as dma-coherent on Tegra194/234
Date:   Thu, 19 Jan 2023 15:38:58 +0200
Message-Id: <20230119133901.1892413-1-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Ensure appropriate configuration is done to make the host1x device
and context devices DMA coherent by adding the dma-coherent flag.

Fixes: b35f5b53a87b ("arm64: tegra: Add context isolation domains on Tegra234")
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 1 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 4afcbd60e144..d8169920b33b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1918,6 +1918,7 @@ host1x@13e00000 {
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_HOST1XDMAR &emc>;
 			interconnect-names = "dma-mem";
 			iommus = <&smmu TEGRA194_SID_HOST1X>;
+			dma-coherent;
 
 			/* Context isolation domains */
 			iommu-map = <0 &smmu TEGRA194_SID_HOST1X_CTX0 1>,
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index eaf05ee9acd1..77ceed615b7f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -571,6 +571,7 @@ host1x@13e00000 {
 			interconnects = <&mc TEGRA234_MEMORY_CLIENT_HOST1XDMAR &emc>;
 			interconnect-names = "dma-mem";
 			iommus = <&smmu_niso1 TEGRA234_SID_HOST1X>;
+			dma-coherent;
 
 			/* Context isolation domains */
 			iommu-map = <0 &smmu_niso0 TEGRA234_SID_HOST1X_CTX0 1>,
-- 
2.39.0

