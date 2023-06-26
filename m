Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5FE73D615
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 05:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjFZDEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 23:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjFZDEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 23:04:42 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FE931AC;
        Sun, 25 Jun 2023 20:04:39 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35Q347nlC022441, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35Q347nlC022441
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 26 Jun 2023 11:04:07 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 26 Jun 2023 11:04:30 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 26 Jun 2023 11:04:29 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Mon, 26 Jun 2023 11:04:29 +0800
From:   Jyan Chou <jyanchou@realtek.com>
To:     <adrian.hunter@intel.com>, <jh80.chung@samsung.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jyanchou@realtek.com>
Subject: [PATCH] [PATCH 01/1] Add CMDQ feqture to Synopsys IP
Date:   Mon, 26 Jun 2023 11:04:26 +0800
Message-ID: <20230626030426.19275-1-jyanchou@realtek.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMDQ feature is introduced to eMMC standard in v5.1, which can be used to
improve performance. We add the mmc driver for the Synopsys
DesignWare mmc host controller with cmdq support.

Signed-off-by: Jyan Chou <jyanchou@realtek.com>
---
 v1 to v2 change:
1. Add CQHCI call back function patch to solve DMA limitation problem
2. Fix the build warnings
---
 drivers/mmc/host/cqhci-core.c |  5 +++++
 drivers/mmc/host/cqhci.h      |  2 ++
 drivers/mmc/host/dw_mmc_cqe.c | 16 ++++++----------
 drivers/mmc/host/dw_mmc_cqe.h |  2 +-
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index b3d7d6d8d654..4d6fb228a21e 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -516,6 +516,11 @@ static int cqhci_prep_tran_desc(struct mmc_request *mrq,
 
 	desc = get_trans_desc(cq_host, tag);
 
+	if (cq_host->ops->setup_tran_desc) {
+		cq_host->ops->setup_tran_desc(data, cq_host, desc, sg_count);
+		return 0;
+	}
+
 	for_each_sg(data->sg, sg, sg_count, i) {
 		addr = sg_dma_address(sg);
 		len = sg_dma_len(sg);
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index ba9387ed90eb..a3e56da6189d 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -286,6 +286,8 @@ struct cqhci_host_ops {
 				 u64 *data);
 	void (*pre_enable)(struct mmc_host *mmc);
 	void (*post_disable)(struct mmc_host *mmc);
+	void (*setup_tran_desc)(struct mmc_data *data,
+		struct cqhci_host *cq_host, u8 *desc, int sg_count);
 #ifdef CONFIG_MMC_CRYPTO
 	int (*program_key)(struct cqhci_host *cq_host,
 			   const union cqhci_crypto_cfg_entry *cfg, int slot);
diff --git a/drivers/mmc/host/dw_mmc_cqe.c b/drivers/mmc/host/dw_mmc_cqe.c
index c50a6c71a362..7c7246d13c0d 100644
--- a/drivers/mmc/host/dw_mmc_cqe.c
+++ b/drivers/mmc/host/dw_mmc_cqe.c
@@ -94,7 +94,6 @@ static int dw_mci_cqe_req_show(struct seq_file *s, void *v)
 
 	return 0;
 }
-DEFINE_SHOW_ATTRIBUTE(dw_mci_cqe_req);
 #endif /* defined(CONFIG_DEBUG_FS) */
 
 static int dw_mci_cqe_regs_show(struct dw_mci *host,
@@ -279,13 +278,10 @@ static void dw_mci_cqe_read_rsp(struct dw_mci *host, struct mmc_command *cmd, u3
 			if (drv_data && drv_data->shift_rsp) {
 				drv_data->shift_rsp(host, cmd, cmd->resp);
 			} else {
-				/*R2 long response*/
-				u32 rsp_tmp[4];
-
-				rsp_tmp[3] = mci_readl(host, RESP01_R);
-				rsp_tmp[2] = mci_readl(host, RESP23_R);
-				rsp_tmp[1] = mci_readl(host, RESP45_R);
-				rsp_tmp[0] = mci_readl(host, RESP67_R);
+				cmd->resp[3] = mci_readl(host, RESP01_R);
+				cmd->resp[2] = mci_readl(host, RESP23_R);
+				cmd->resp[1] = mci_readl(host, RESP45_R);
+				cmd->resp[0] = mci_readl(host, RESP67_R);
 			}
 		} else {
 			/*Short response*/
@@ -580,7 +576,7 @@ static void dw_mci_cqe_prepare_desc32(struct dw_mci *host, struct mmc_data *data
 
 			/*Last descriptor*/
 			if (i == host->dma_nents - 1 && remain_blk_cnt == cur_blk_cnt)
-				tmp_val |= END(0x1);
+				tmp_val |= LAST(0x1);
 
 			desc_base[0] =  tmp_val;
 			desc_base[1] =  dma_addr;
@@ -766,7 +762,7 @@ static void dw_mci_cqe_err_handle(struct dw_mci *host, struct mmc_command *cmd)
 					if (err == -DW_MCI_NOT_READY)
 						dev_err(host->dev, "status check failed, err = %d, status = 0x%x\n",
 							err, status);
-						break;
+					break;
 				}
 			} else {
 				break;
diff --git a/drivers/mmc/host/dw_mmc_cqe.h b/drivers/mmc/host/dw_mmc_cqe.h
index ef52b67aceb6..fa609017c4cb 100644
--- a/drivers/mmc/host/dw_mmc_cqe.h
+++ b/drivers/mmc/host/dw_mmc_cqe.h
@@ -318,7 +318,7 @@ enum dw_mci_cookie {
 #define SDMMC_PLL_USABLE			BIT(0)
 
 #define VALID(x)			((x & 1) << 0)
-#define END(x)				((x & 1) << 1)
+#define LAST(x)				((x & 1) << 1)
 #define INT(x)				((x & 1) << 2)
 #define ACT(x)				((x & 0x7) << 3)
 #define DAT_LENGTH(x)			((x & 0xFFFF) << 16)
-- 
2.40.1

