Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95621650D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiLSOZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiLSOZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:25:45 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74452FACF;
        Mon, 19 Dec 2022 06:25:35 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJ9PoMS009678;
        Mon, 19 Dec 2022 06:25:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=WT4NfijVvAyDAew7cjYlvKxAfrdUBj8fv5owla86UN0=;
 b=XzWssM40X/os2wxsvNzF4rJFjw6a90LQJffbvrHrUrkXMnUwcAt5oyA9jlhjVE135Ur3
 VTRqdZlpszfzStYcSHbxnPJt9puTa74AhqUEO/x/54NYqa2r2QngJNgYk4h8YPBhQACR
 Y/a1Bu6kvTVKeIZJUbENnbtDT1NizYuyK1A2BL3kyxeLm9y+Wc9D8imYVxSXJ8CDsCgp
 /rOoHsoy9qzjpPr6gbUB8Gvs51G0cDGf/E47m/OkNpWJEPi2tgYEMT58DurvJ1QvTj1z
 s5VkpmE1HMMmV/LP0QKNfxkgyOq2mWZElLjPiGVpY7s5j+pdx8M0K3a6Tvm+6NKFB+qD Jg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3mjnans1v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 06:25:31 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Dec
 2022 06:25:30 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 19 Dec 2022 06:25:30 -0800
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id D876D3F7041;
        Mon, 19 Dec 2022 06:25:29 -0800 (PST)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH 4/5] drivers: mmc: sdhci: Add option to configure sdhci timeout
Date:   Mon, 19 Dec 2022 06:24:17 -0800
Message-ID: <20221219142418.27949-5-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221219142418.27949-1-pmalgujar@marvell.com>
References: <20221219142418.27949-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: HFaYfyYpVStyMqdEgoBzeGHMUxNElPik
X-Proofpoint-ORIG-GUID: HFaYfyYpVStyMqdEgoBzeGHMUxNElPik
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jayanthi Annadurai <jannadurai@marvell.com>

Add config option to choose the sdhci timeout in seconds.

Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/mmc/host/Kconfig | 8 ++++++++
 drivers/mmc/host/sdhci.c | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index b5b2ae0bb4625bdb9d17acdbb1887c9caa3a1f32..ab48f2bc4cff73d1aad8d7da542d761cf0346d9f 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1132,3 +1132,11 @@ config MMC_LITEX
 	  module will be called litex_mmc.
 
 	  If unsure, say N.
+
+config MMC_SDHCI_TIMEOUT
+	int
+	default 1 if MMC_SDHCI_CADENCE
+	default 10
+	depends on MMC_SDHCI
+	help
+	  Default timeout value for command and data.
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f3af1bd0f7b955272fbd8b034ecb591860b89aed..e9bc24258746834ec9c8f13fe24456587a2b758d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1707,7 +1707,8 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	else if (!cmd->data && cmd->busy_timeout > 9000)
 		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
 	else
-		timeout += 10 * HZ;
+		timeout += CONFIG_MMC_SDHCI_TIMEOUT * HZ;
+
 	sdhci_mod_timer(host, cmd->mrq, timeout);
 
 	if (host->use_external_dma)
-- 
2.17.1

