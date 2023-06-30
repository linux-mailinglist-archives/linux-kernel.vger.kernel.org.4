Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D697434FE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjF3G3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjF3G3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:29:14 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BEC2D63;
        Thu, 29 Jun 2023 23:29:12 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U2CKL5013754;
        Thu, 29 Jun 2023 23:29:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=3tSr+RNlu5c90zTQc8RZlZQwxk7z8fDmjfhvkyvZtmg=;
 b=WZufsuGzXqO2UZG+pns4T7sybniUtqqPNA+vpXX2EPlEmHpgbjuXhHnLM3jYQA4f12Gd
 gOQ1zrBz4xM6hO26Q8kK1GU5k9dV60/BH6A6FYFfVx26PQwG06Fi3KtNH+ubRSVtgpyY
 Az8WoOEbEVzFCF0O2VGgZhN0zXqKR0TRZ822qbmIauIIa00LmqRwNFfI5BDrdW8JJ8iX
 o9GwXqR9O9uw6JphART1Y7q/BZev8E2BYJ6u+IKHdYARZmitYr8l0ht2YX73f0wBcj1y
 Nv5tWU47XJ6mj0YEAhQry6a/F/rq3YduzF1Lrzs0F3W4sYpuEJAeWgAHvXRLYRtQxqH7 rA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rhp2egqtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 23:29:06 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Jun
 2023 23:29:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 29 Jun 2023 23:29:04 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id A18DA3F70A0;
        Thu, 29 Jun 2023 23:29:00 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <davem@davemloft.net>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>, <jerinj@marvell.com>,
        <sbhatta@marvell.com>
Subject: [net Patch 4/4] octeontx2-af: Reset MAC features in FLR
Date:   Fri, 30 Jun 2023 11:58:45 +0530
Message-ID: <20230630062845.26606-5-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230630062845.26606-1-hkelam@marvell.com>
References: <20230630062845.26606-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: IiLcnRNf5rLh6oCtiVsWLutJi6KmFFrF
X-Proofpoint-GUID: IiLcnRNf5rLh6oCtiVsWLutJi6KmFFrF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_03,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AF driver configures MAC features like internal loopback and PFC upon
receiving the request from PF and its VF netdev. But these
features are not getting reset in FLR.  This patch fixes the issue by
resetting the same.

Fixes: 23999b30ae67 ("octeontx2-af: Enable or disable CGX internal loopback")
Fixes: 1121f6b02e7a ("octeontx2-af: Priority flow control configuration support")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 26 ++++++++++++++--
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |  2 ++
 .../marvell/octeontx2/af/lmac_common.h        |  3 ++
 .../net/ethernet/marvell/octeontx2/af/rpm.c   | 30 +++++++++++++++++--
 .../net/ethernet/marvell/octeontx2/af/rpm.h   |  2 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  1 +
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 18 +++++++++++
 8 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index f4bdca662d61..592037f4e55b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -537,14 +537,15 @@ static u32 cgx_get_lmac_fifo_len(void *cgxd, int lmac_id)
 int cgx_lmac_internal_loopback(void *cgxd, int lmac_id, bool enable)
 {
 	struct cgx *cgx = cgxd;
-	u8 lmac_type;
+	struct lmac *lmac;
 	u64 cfg;
 
 	if (!is_lmac_valid(cgx, lmac_id))
 		return -ENODEV;
 
-	lmac_type = cgx->mac_ops->get_lmac_type(cgx, lmac_id);
-	if (lmac_type == LMAC_MODE_SGMII || lmac_type == LMAC_MODE_QSGMII) {
+	lmac = lmac_pdata(lmac_id, cgx);
+	if (lmac->lmac_type == LMAC_MODE_SGMII ||
+	    lmac->lmac_type == LMAC_MODE_QSGMII) {
 		cfg = cgx_read(cgx, lmac_id, CGXX_GMP_PCS_MRX_CTL);
 		if (enable)
 			cfg |= CGXX_GMP_PCS_MRX_CTL_LBK;
@@ -1563,6 +1564,23 @@ int cgx_lmac_linkup_start(void *cgxd)
 	return 0;
 }
 
+int cgx_lmac_reset(void *cgxd, int lmac_id, u8 pf_req_flr)
+{
+	struct cgx *cgx = cgxd;
+	u64 cfg;
+
+	if (!is_lmac_valid(cgx, lmac_id))
+		return -ENODEV;
+
+	/* Resetting PFC related CSRs */
+	cfg = 0xff;
+	cgx_write(cgxd, lmac_id, CGXX_CMRX_RX_LOGL_XON, cfg);
+
+	if (pf_req_flr)
+		cgx_lmac_internal_loopback(cgxd, lmac_id, false);
+	return 0;
+}
+
 static int cgx_configure_interrupt(struct cgx *cgx, struct lmac *lmac,
 				   int cnt, bool req_free)
 {
@@ -1682,6 +1700,7 @@ static int cgx_lmac_init(struct cgx *cgx)
 		cgx->lmac_idmap[lmac->lmac_id] = lmac;
 		set_bit(lmac->lmac_id, &cgx->lmac_bmap);
 		cgx->mac_ops->mac_pause_frm_config(cgx, lmac->lmac_id, true);
+		lmac->lmac_type = cgx->mac_ops->get_lmac_type(cgx, lmac->lmac_id);
 	}
 
 	return cgx_lmac_verify_fwi_version(cgx);
@@ -1778,6 +1797,7 @@ static struct mac_ops	cgx_mac_ops    = {
 	.mac_tx_enable =		cgx_lmac_tx_enable,
 	.pfc_config =                   cgx_lmac_pfc_config,
 	.mac_get_pfc_frm_cfg   =        cgx_lmac_get_pfc_frm_cfg,
+	.mac_reset   =			cgx_lmac_reset,
 };
 
 static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
index 5a20d93004c7..574114179688 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
@@ -35,6 +35,7 @@
 #define CGXX_CMRX_INT_ENA_W1S		0x058
 #define CGXX_CMRX_RX_ID_MAP		0x060
 #define CGXX_CMRX_RX_STAT0		0x070
+#define CGXX_CMRX_RX_LOGL_XON		0x100
 #define CGXX_CMRX_RX_LMACS		0x128
 #define CGXX_CMRX_RX_DMAC_CTL0		(0x1F8 + mac_ops->csr_offset)
 #define CGX_DMAC_CTL0_CAM_ENABLE	BIT_ULL(3)
@@ -181,4 +182,5 @@ int cgx_lmac_get_pfc_frm_cfg(void *cgxd, int lmac_id, u8 *tx_pause,
 			     u8 *rx_pause);
 int verify_lmac_fc_cfg(void *cgxd, int lmac_id, u8 tx_pause, u8 rx_pause,
 		       int pfvf_idx);
+int cgx_lmac_reset(void *cgxd, int lmac_id, u8 pf_req_flr);
 #endif /* CGX_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
index 39aaf0e4467d..0b4cba03f2e8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
@@ -24,6 +24,7 @@
  * @cgx:		parent cgx port
  * @mcast_filters_count:  Number of multicast filters installed
  * @lmac_id:		lmac port id
+ * @lmac_type:	        lmac type like SGMII/XAUI
  * @cmd_pend:		flag set before new command is started
  *			flag cleared after command response is received
  * @name:		lmac port name
@@ -43,6 +44,7 @@ struct lmac {
 	struct cgx *cgx;
 	u8 mcast_filters_count;
 	u8 lmac_id;
+	u8 lmac_type;
 	bool cmd_pend;
 	char *name;
 };
@@ -125,6 +127,7 @@ struct mac_ops {
 
 	int                     (*mac_get_pfc_frm_cfg)(void *cgxd, int lmac_id,
 						       u8 *tx_pause, u8 *rx_pause);
+	int			(*mac_reset)(void *cgxd, int lmac_id, u8 pf_req_flr);
 
 	/* FEC stats */
 	int			(*get_fec_stats)(void *cgxd, int lmac_id,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index a433f92c51ea..b4fcb20c3f4f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -37,6 +37,7 @@ static struct mac_ops		rpm_mac_ops   = {
 	.mac_tx_enable =		rpm_lmac_tx_enable,
 	.pfc_config =                   rpm_lmac_pfc_config,
 	.mac_get_pfc_frm_cfg   =        rpm_lmac_get_pfc_frm_cfg,
+	.mac_reset   =			rpm_lmac_reset,
 };
 
 static struct mac_ops		rpm2_mac_ops   = {
@@ -68,6 +69,7 @@ static struct mac_ops		rpm2_mac_ops   = {
 	.mac_tx_enable =		rpm_lmac_tx_enable,
 	.pfc_config =                   rpm_lmac_pfc_config,
 	.mac_get_pfc_frm_cfg   =        rpm_lmac_get_pfc_frm_cfg,
+	.mac_reset   =			rpm_lmac_reset,
 };
 
 bool is_dev_rpm2(void *rpmd)
@@ -537,14 +539,15 @@ u32 rpm2_get_lmac_fifo_len(void *rpmd, int lmac_id)
 int rpm_lmac_internal_loopback(void *rpmd, int lmac_id, bool enable)
 {
 	rpm_t *rpm = rpmd;
-	u8 lmac_type;
+	struct lmac *lmac;
 	u64 cfg;
 
 	if (!is_lmac_valid(rpm, lmac_id))
 		return -ENODEV;
-	lmac_type = rpm->mac_ops->get_lmac_type(rpm, lmac_id);
 
-	if (lmac_type == LMAC_MODE_QSGMII || lmac_type == LMAC_MODE_SGMII) {
+	lmac = lmac_pdata(lmac_id, rpm);
+	if (lmac->lmac_type == LMAC_MODE_QSGMII ||
+	    lmac->lmac_type == LMAC_MODE_SGMII) {
 		dev_err(&rpm->pdev->dev, "loopback not supported for LPC mode\n");
 		return 0;
 	}
@@ -713,3 +716,24 @@ int rpm_get_fec_stats(void *rpmd, int lmac_id, struct cgx_fec_stats_rsp *rsp)
 
 	return 0;
 }
+
+int rpm_lmac_reset(void *rpmd, int lmac_id, u8 pf_req_flr)
+{
+	u64 rx_logl_xon, cfg;
+	rpm_t *rpm = rpmd;
+
+	if (!is_lmac_valid(rpm, lmac_id))
+		return -ENODEV;
+
+	/* Resetting PFC related CSRs */
+	rx_logl_xon = is_dev_rpm2(rpm) ? RPM2_CMRX_RX_LOGL_XON :
+					 RPMX_CMRX_RX_LOGL_XON;
+	cfg = 0xff;
+
+	rpm_write(rpm, lmac_id, rx_logl_xon, cfg);
+
+	if (pf_req_flr)
+		rpm_lmac_internal_loopback(rpm, lmac_id, false);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
index be294eebab26..b79cfbc6f877 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
@@ -74,6 +74,7 @@
 #define RPMX_MTI_MAC100X_CL01_PAUSE_QUANTA              0x80A8
 #define RPMX_MTI_MAC100X_CL89_PAUSE_QUANTA		0x8108
 #define RPM_DEFAULT_PAUSE_TIME                          0x7FF
+#define RPMX_CMRX_RX_LOGL_XON				0x4100
 
 #define RPMX_MTI_MAC100X_XIF_MODE		        0x8100
 #define RPMX_ONESTEP_ENABLE				BIT_ULL(5)
@@ -132,4 +133,5 @@ int rpm_lmac_get_pfc_frm_cfg(void *rpmd, int lmac_id, u8 *tx_pause,
 int rpm2_get_nr_lmacs(void *rpmd);
 bool is_dev_rpm2(void *rpmd);
 int rpm_get_fec_stats(void *cgxd, int lmac_id, struct cgx_fec_stats_rsp *rsp);
+int rpm_lmac_reset(void *rpmd, int lmac_id, u8 pf_req_flr);
 #endif /* RPM_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 0069e60afa3b..8dbc35c481f6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2629,6 +2629,7 @@ static void __rvu_flr_handler(struct rvu *rvu, u16 pcifunc)
 	 * Since LF is detached use LF number as -1.
 	 */
 	rvu_npc_free_mcam_entries(rvu, pcifunc, -1);
+	rvu_mac_reset(rvu, pcifunc);
 
 	mutex_unlock(&rvu->flr_lock);
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index d4b8d4546de2..e8e65fd7888d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -895,6 +895,7 @@ int rvu_cgx_config_tx(void *cgxd, int lmac_id, bool enable);
 int rvu_cgx_prio_flow_ctrl_cfg(struct rvu *rvu, u16 pcifunc, u8 tx_pause, u8 rx_pause,
 			       u16 pfc_en);
 int rvu_cgx_cfg_pause_frm(struct rvu *rvu, u16 pcifunc, u8 tx_pause, u8 rx_pause);
+void rvu_mac_reset(struct rvu *rvu, u16 pcifunc);
 u32 rvu_cgx_get_lmac_fifolen(struct rvu *rvu, int cgx, int lmac);
 int npc_get_nixlf_mcam_index(struct npc_mcam *mcam, u16 pcifunc, int nixlf,
 			     int type);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 48611e603228..4b8559ac0404 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -1250,3 +1250,21 @@ int rvu_mbox_handler_cgx_prio_flow_ctrl_cfg(struct rvu *rvu,
 	mac_ops->mac_get_pfc_frm_cfg(cgxd, lmac_id, &rsp->tx_pause, &rsp->rx_pause);
 	return err;
 }
+
+void rvu_mac_reset(struct rvu *rvu, u16 pcifunc)
+{
+	int pf = rvu_get_pf(pcifunc);
+	struct mac_ops *mac_ops;
+	struct cgx *cgxd;
+	u8 cgx, lmac;
+
+	if (!is_pf_cgxmapped(rvu, pf))
+		return;
+
+	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx, &lmac);
+	cgxd = rvu_cgx_pdata(cgx, rvu);
+	mac_ops = get_mac_ops(cgxd);
+
+	if (mac_ops->mac_reset(cgxd, lmac, !is_vf(pcifunc)))
+		dev_err(rvu->dev, "Failed to reset MAC\n");
+}
-- 
2.17.1

