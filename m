Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4143D73E2FA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjFZPPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjFZPPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:15:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC8510CA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687792463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SV8IWV12SSvXixlyQ9WwyIZL1eAGRi+kUJPZWHiwyLM=;
        b=E2GcTz/cIgYG2d/CcIdaNGke6stSOoZ1CddEIbQdNIll6rXOvGuq+D1cfGu8QpaCJHMnTT
        96Rb0VBeLgmGuK2iHOpo/1SjtzqhaJTjYLDHFRe57mjeOWKFGdnmXg6YZWWtq9JFfLM7ZN
        08ffNsyZzY7L5wvrcJmqf4D8KxsCLQc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-cx1bw_rgMnmou4J2mALVAw-1; Mon, 26 Jun 2023 11:14:19 -0400
X-MC-Unique: cx1bw_rgMnmou4J2mALVAw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92C921064B6D;
        Mon, 26 Jun 2023 15:14:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33CB91121319;
        Mon, 26 Jun 2023 15:14:05 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jinjian.song@fibocom.com, haijun.liu@mediatek.com,
        jtornosm@redhat.com
Subject: [PATCH v2] net: wwan: t7xx: Add AP CLDMA
Date:   Mon, 26 Jun 2023 17:13:58 +0200
Message-ID: <20230626151403.81058-1-jtornosm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At this moment with the current status, t7xx is not functional due to
problems like this after connection, if there is no activity:
[   57.370534] mtk_t7xx 0000:72:00.0: [PM] SAP suspend error: -110
[   57.370581] mtk_t7xx 0000:72:00.0: can't suspend
    (t7xx_pci_pm_runtime_suspend [mtk_t7xx] returned -110)
because after this, the traffic no longer works.

The complete series 'net: wwan: t7xx: fw flashing & coredump support'
was reverted because of issues with the pci implementation.
In order to have at least the modem working, it would be enough if just
the first commit of the series is re-applied:
d20ef656f994 net: wwan: t7xx: Add AP CLDMA
With that, the Application Processor would be controlled, correctly
suspended and the commented problems would be fixed (I am testing here
like this with no related issue).

This commit is independent of the others and not related to the
commented pci implementation for the new features: fw flashing and
coredump collection.

Use v2 patch version of d20ef656f994 as JinJian Song suggests.

Original text from the commit that would be re-applied:

    d20ef656f994 net: wwan: t7xx: Add AP CLDMA
    Author: Haijun Liu <haijun.liu@mediatek.com>
    Date:   Tue Aug 16 09:53:28 2022 +0530

    The t7xx device contains two Cross Layer DMA (CLDMA) interfaces to
    communicate with AP and Modem processors respectively. So far only
    MD-CLDMA was being used, this patch enables AP-CLDMA.

    Rename small Application Processor (sAP) to AP.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
V2:
 * Reuse handshake_wq for AP work.
 * Remove AP trace port tx/rx channel id.
 * Rename t7xx_md_port_conf to t7xx_port_conf.
---
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c     | 17 +++--
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h     |  2 +-
 drivers/net/wwan/t7xx/t7xx_mhccif.h        |  1 +
 drivers/net/wwan/t7xx/t7xx_modem_ops.c     | 76 +++++++++++++++++-----
 drivers/net/wwan/t7xx/t7xx_modem_ops.h     |  2 +
 drivers/net/wwan/t7xx/t7xx_port.h          |  6 +-
 drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c |  8 ++-
 drivers/net/wwan/t7xx/t7xx_port_proxy.c    | 18 ++++-
 drivers/net/wwan/t7xx/t7xx_reg.h           |  2 +-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c | 13 +++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.h |  2 +
 11 files changed, 116 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
index aec3a18d44bd..4f56d8cc0aea 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
@@ -1066,13 +1066,18 @@ static void t7xx_hw_info_init(struct cldma_ctrl *md_ctrl)
 	struct t7xx_cldma_hw *hw_info = &md_ctrl->hw_info;
 	u32 phy_ao_base, phy_pd_base;
 
-	if (md_ctrl->hif_id != CLDMA_ID_MD)
-		return;
-
-	phy_ao_base = CLDMA1_AO_BASE;
-	phy_pd_base = CLDMA1_PD_BASE;
-	hw_info->phy_interrupt_id = CLDMA1_INT;
 	hw_info->hw_mode = MODE_BIT_64;
+
+	if (md_ctrl->hif_id == CLDMA_ID_MD) {
+		phy_ao_base = CLDMA1_AO_BASE;
+		phy_pd_base = CLDMA1_PD_BASE;
+		hw_info->phy_interrupt_id = CLDMA1_INT;
+	} else {
+		phy_ao_base = CLDMA0_AO_BASE;
+		phy_pd_base = CLDMA0_PD_BASE;
+		hw_info->phy_interrupt_id = CLDMA0_INT;
+	}
+
 	hw_info->ap_ao_base = t7xx_pcie_addr_transfer(pbase->pcie_ext_reg_base,
 						      pbase->pcie_dev_reg_trsl_addr, phy_ao_base);
 	hw_info->ap_pdn_base = t7xx_pcie_addr_transfer(pbase->pcie_ext_reg_base,
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.h b/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
index 47a35e552da7..4410bac6993a 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
+++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
@@ -34,7 +34,7 @@
 /**
  * enum cldma_id - Identifiers for CLDMA HW units.
  * @CLDMA_ID_MD: Modem control channel.
- * @CLDMA_ID_AP: Application Processor control channel (not used at the moment).
+ * @CLDMA_ID_AP: Application Processor control channel.
  * @CLDMA_NUM:   Number of CLDMA HW units available.
  */
 enum cldma_id {
diff --git a/drivers/net/wwan/t7xx/t7xx_mhccif.h b/drivers/net/wwan/t7xx/t7xx_mhccif.h
index 209b386bc088..20c50dce9fc3 100644
--- a/drivers/net/wwan/t7xx/t7xx_mhccif.h
+++ b/drivers/net/wwan/t7xx/t7xx_mhccif.h
@@ -25,6 +25,7 @@
 			 D2H_INT_EXCEPTION_CLEARQ_DONE |	\
 			 D2H_INT_EXCEPTION_ALLQ_RESET |		\
 			 D2H_INT_PORT_ENUM |			\
+			 D2H_INT_ASYNC_AP_HK |			\
 			 D2H_INT_ASYNC_MD_HK)
 
 void t7xx_mhccif_mask_set(struct t7xx_pci_dev *t7xx_dev, u32 val);
diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index 7d0f5e4f0a78..24e7d491468e 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -44,6 +44,7 @@
 #include "t7xx_state_monitor.h"
 
 #define RT_ID_MD_PORT_ENUM	0
+#define RT_ID_AP_PORT_ENUM	1
 /* Modem feature query identification code - "ICCC" */
 #define MD_FEATURE_QUERY_ID	0x49434343
 
@@ -298,6 +299,7 @@ static void t7xx_md_exception(struct t7xx_modem *md, enum hif_ex_stage stage)
 	}
 
 	t7xx_cldma_exception(md->md_ctrl[CLDMA_ID_MD], stage);
+	t7xx_cldma_exception(md->md_ctrl[CLDMA_ID_AP], stage);
 
 	if (stage == HIF_EX_INIT)
 		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_EXCEPTION_ACK);
@@ -426,7 +428,7 @@ static int t7xx_parse_host_rt_data(struct t7xx_fsm_ctl *ctl, struct t7xx_sys_inf
 		if (ft_spt_st != MTK_FEATURE_MUST_BE_SUPPORTED)
 			return -EINVAL;
 
-		if (i == RT_ID_MD_PORT_ENUM)
+		if (i == RT_ID_MD_PORT_ENUM || i == RT_ID_AP_PORT_ENUM)
 			t7xx_port_enum_msg_handler(ctl->md, rt_feature->data);
 	}
 
@@ -456,12 +458,12 @@ static int t7xx_core_reset(struct t7xx_modem *md)
 	return 0;
 }
 
-static void t7xx_core_hk_handler(struct t7xx_modem *md, struct t7xx_fsm_ctl *ctl,
+static void t7xx_core_hk_handler(struct t7xx_modem *md, struct t7xx_sys_info *core_info,
+				 struct t7xx_fsm_ctl *ctl,
 				 enum t7xx_fsm_event_state event_id,
 				 enum t7xx_fsm_event_state err_detect)
 {
 	struct t7xx_fsm_event *event = NULL, *event_next;
-	struct t7xx_sys_info *core_info = &md->core_md;
 	struct device *dev = &md->t7xx_dev->pdev->dev;
 	unsigned long flags;
 	int ret;
@@ -531,19 +533,33 @@ static void t7xx_md_hk_wq(struct work_struct *work)
 	t7xx_cldma_start(md->md_ctrl[CLDMA_ID_MD]);
 	t7xx_fsm_broadcast_state(ctl, MD_STATE_WAITING_FOR_HS2);
 	md->core_md.handshake_ongoing = true;
-	t7xx_core_hk_handler(md, ctl, FSM_EVENT_MD_HS2, FSM_EVENT_MD_HS2_EXIT);
+	t7xx_core_hk_handler(md, &md->core_md, ctl, FSM_EVENT_MD_HS2, FSM_EVENT_MD_HS2_EXIT);
+}
+
+static void t7xx_ap_hk_wq(struct work_struct *work)
+{
+	struct t7xx_modem *md = container_of(work, struct t7xx_modem, ap_handshake_work);
+	struct t7xx_fsm_ctl *ctl = md->fsm_ctl;
+
+	 /* Clear the HS2 EXIT event appended in t7xx_core_reset(). */
+	t7xx_fsm_clr_event(ctl, FSM_EVENT_AP_HS2_EXIT);
+	t7xx_cldma_stop(md->md_ctrl[CLDMA_ID_AP]);
+	t7xx_cldma_switch_cfg(md->md_ctrl[CLDMA_ID_AP]);
+	t7xx_cldma_start(md->md_ctrl[CLDMA_ID_AP]);
+	md->core_ap.handshake_ongoing = true;
+	t7xx_core_hk_handler(md, &md->core_ap, ctl, FSM_EVENT_AP_HS2, FSM_EVENT_AP_HS2_EXIT);
 }
 
 void t7xx_md_event_notify(struct t7xx_modem *md, enum md_event_id evt_id)
 {
 	struct t7xx_fsm_ctl *ctl = md->fsm_ctl;
-	void __iomem *mhccif_base;
 	unsigned int int_sta;
 	unsigned long flags;
 
 	switch (evt_id) {
 	case FSM_PRE_START:
-		t7xx_mhccif_mask_clr(md->t7xx_dev, D2H_INT_PORT_ENUM);
+		t7xx_mhccif_mask_clr(md->t7xx_dev, D2H_INT_PORT_ENUM | D2H_INT_ASYNC_MD_HK |
+						   D2H_INT_ASYNC_AP_HK);
 		break;
 
 	case FSM_START:
@@ -556,16 +572,26 @@ void t7xx_md_event_notify(struct t7xx_modem *md, enum md_event_id evt_id)
 			ctl->exp_flg = true;
 			md->exp_id &= ~D2H_INT_EXCEPTION_INIT;
 			md->exp_id &= ~D2H_INT_ASYNC_MD_HK;
+			md->exp_id &= ~D2H_INT_ASYNC_AP_HK;
 		} else if (ctl->exp_flg) {
 			md->exp_id &= ~D2H_INT_ASYNC_MD_HK;
-		} else if (md->exp_id & D2H_INT_ASYNC_MD_HK) {
-			queue_work(md->handshake_wq, &md->handshake_work);
-			md->exp_id &= ~D2H_INT_ASYNC_MD_HK;
-			mhccif_base = md->t7xx_dev->base_addr.mhccif_rc_base;
-			iowrite32(D2H_INT_ASYNC_MD_HK, mhccif_base + REG_EP2RC_SW_INT_ACK);
-			t7xx_mhccif_mask_set(md->t7xx_dev, D2H_INT_ASYNC_MD_HK);
+			md->exp_id &= ~D2H_INT_ASYNC_AP_HK;
 		} else {
-			t7xx_mhccif_mask_clr(md->t7xx_dev, D2H_INT_ASYNC_MD_HK);
+			void __iomem *mhccif_base = md->t7xx_dev->base_addr.mhccif_rc_base;
+
+			if (md->exp_id & D2H_INT_ASYNC_MD_HK) {
+				queue_work(md->handshake_wq, &md->handshake_work);
+				md->exp_id &= ~D2H_INT_ASYNC_MD_HK;
+				iowrite32(D2H_INT_ASYNC_MD_HK, mhccif_base + REG_EP2RC_SW_INT_ACK);
+				t7xx_mhccif_mask_set(md->t7xx_dev, D2H_INT_ASYNC_MD_HK);
+			}
+
+			if (md->exp_id & D2H_INT_ASYNC_AP_HK) {
+				queue_work(md->handshake_wq, &md->ap_handshake_work);
+				md->exp_id &= ~D2H_INT_ASYNC_AP_HK;
+				iowrite32(D2H_INT_ASYNC_AP_HK, mhccif_base + REG_EP2RC_SW_INT_ACK);
+				t7xx_mhccif_mask_set(md->t7xx_dev, D2H_INT_ASYNC_AP_HK);
+			}
 		}
 		spin_unlock_irqrestore(&md->exp_lock, flags);
 
@@ -578,6 +604,7 @@ void t7xx_md_event_notify(struct t7xx_modem *md, enum md_event_id evt_id)
 
 	case FSM_READY:
 		t7xx_mhccif_mask_set(md->t7xx_dev, D2H_INT_ASYNC_MD_HK);
+		t7xx_mhccif_mask_set(md->t7xx_dev, D2H_INT_ASYNC_AP_HK);
 		break;
 
 	default:
@@ -629,6 +656,12 @@ static struct t7xx_modem *t7xx_md_alloc(struct t7xx_pci_dev *t7xx_dev)
 	md->core_md.feature_set[RT_ID_MD_PORT_ENUM] &= ~FEATURE_MSK;
 	md->core_md.feature_set[RT_ID_MD_PORT_ENUM] |=
 		FIELD_PREP(FEATURE_MSK, MTK_FEATURE_MUST_BE_SUPPORTED);
+
+	INIT_WORK(&md->ap_handshake_work, t7xx_ap_hk_wq);
+	md->core_ap.feature_set[RT_ID_AP_PORT_ENUM] &= ~FEATURE_MSK;
+	md->core_ap.feature_set[RT_ID_AP_PORT_ENUM] |=
+		FIELD_PREP(FEATURE_MSK, MTK_FEATURE_MUST_BE_SUPPORTED);
+
 	return md;
 }
 
@@ -640,6 +673,7 @@ int t7xx_md_reset(struct t7xx_pci_dev *t7xx_dev)
 	md->exp_id = 0;
 	t7xx_fsm_reset(md);
 	t7xx_cldma_reset(md->md_ctrl[CLDMA_ID_MD]);
+	t7xx_cldma_reset(md->md_ctrl[CLDMA_ID_AP]);
 	t7xx_port_proxy_reset(md->port_prox);
 	md->md_init_finish = true;
 	return t7xx_core_reset(md);
@@ -669,6 +703,10 @@ int t7xx_md_init(struct t7xx_pci_dev *t7xx_dev)
 	if (ret)
 		goto err_destroy_hswq;
 
+	ret = t7xx_cldma_alloc(CLDMA_ID_AP, t7xx_dev);
+	if (ret)
+		goto err_destroy_hswq;
+
 	ret = t7xx_fsm_init(md);
 	if (ret)
 		goto err_destroy_hswq;
@@ -681,12 +719,16 @@ int t7xx_md_init(struct t7xx_pci_dev *t7xx_dev)
 	if (ret)
 		goto err_uninit_ccmni;
 
-	ret = t7xx_port_proxy_init(md);
+	ret = t7xx_cldma_init(md->md_ctrl[CLDMA_ID_AP]);
 	if (ret)
 		goto err_uninit_md_cldma;
 
+	ret = t7xx_port_proxy_init(md);
+	if (ret)
+		goto err_uninit_ap_cldma;
+
 	ret = t7xx_fsm_append_cmd(md->fsm_ctl, FSM_CMD_START, 0);
-	if (ret) /* fsm_uninit flushes cmd queue */
+	if (ret) /* t7xx_fsm_uninit() flushes cmd queue */
 		goto err_uninit_proxy;
 
 	t7xx_md_sys_sw_init(t7xx_dev);
@@ -696,6 +738,9 @@ int t7xx_md_init(struct t7xx_pci_dev *t7xx_dev)
 err_uninit_proxy:
 	t7xx_port_proxy_uninit(md->port_prox);
 
+err_uninit_ap_cldma:
+	t7xx_cldma_exit(md->md_ctrl[CLDMA_ID_AP]);
+
 err_uninit_md_cldma:
 	t7xx_cldma_exit(md->md_ctrl[CLDMA_ID_MD]);
 
@@ -722,6 +767,7 @@ void t7xx_md_exit(struct t7xx_pci_dev *t7xx_dev)
 
 	t7xx_fsm_append_cmd(md->fsm_ctl, FSM_CMD_PRE_STOP, FSM_CMD_FLAG_WAIT_FOR_COMPLETION);
 	t7xx_port_proxy_uninit(md->port_prox);
+	t7xx_cldma_exit(md->md_ctrl[CLDMA_ID_AP]);
 	t7xx_cldma_exit(md->md_ctrl[CLDMA_ID_MD]);
 	t7xx_ccmni_exit(t7xx_dev);
 	t7xx_fsm_uninit(md);
diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.h b/drivers/net/wwan/t7xx/t7xx_modem_ops.h
index 7469ed636ae8..abe633cf7adc 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.h
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.h
@@ -66,10 +66,12 @@ struct t7xx_modem {
 	struct cldma_ctrl		*md_ctrl[CLDMA_NUM];
 	struct t7xx_pci_dev		*t7xx_dev;
 	struct t7xx_sys_info		core_md;
+	struct t7xx_sys_info		core_ap;
 	bool				md_init_finish;
 	bool				rgu_irq_asserted;
 	struct workqueue_struct		*handshake_wq;
 	struct work_struct		handshake_work;
+	struct work_struct		ap_handshake_work;
 	struct t7xx_fsm_ctl		*fsm_ctl;
 	struct port_proxy		*port_prox;
 	unsigned int			exp_id;
diff --git a/drivers/net/wwan/t7xx/t7xx_port.h b/drivers/net/wwan/t7xx/t7xx_port.h
index 8ea9079af997..4ae8a00a8532 100644
--- a/drivers/net/wwan/t7xx/t7xx_port.h
+++ b/drivers/net/wwan/t7xx/t7xx_port.h
@@ -36,9 +36,13 @@
 /* Channel ID and Message ID definitions.
  * The channel number consists of peer_id(15:12) , channel_id(11:0)
  * peer_id:
- * 0:reserved, 1: to sAP, 2: to MD
+ * 0:reserved, 1: to AP, 2: to MD
  */
 enum port_ch {
+	/* to AP */
+	PORT_CH_AP_CONTROL_RX = 0x1000,
+	PORT_CH_AP_CONTROL_TX = 0x1001,
+
 	/* to MD */
 	PORT_CH_CONTROL_RX = 0x2000,
 	PORT_CH_CONTROL_TX = 0x2001,
diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
index 68430b130a67..ae632ef96698 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
@@ -167,8 +167,12 @@ static int control_msg_handler(struct t7xx_port *port, struct sk_buff *skb)
 	case CTL_ID_HS2_MSG:
 		skb_pull(skb, sizeof(*ctrl_msg_h));
 
-		if (port_conf->rx_ch == PORT_CH_CONTROL_RX) {
-			ret = t7xx_fsm_append_event(ctl, FSM_EVENT_MD_HS2, skb->data,
+		if (port_conf->rx_ch == PORT_CH_CONTROL_RX ||
+		    port_conf->rx_ch == PORT_CH_AP_CONTROL_RX) {
+			int event = port_conf->rx_ch == PORT_CH_CONTROL_RX ?
+				    FSM_EVENT_MD_HS2 : FSM_EVENT_AP_HS2;
+
+			ret = t7xx_fsm_append_event(ctl, event, skb->data,
 						    le32_to_cpu(ctrl_msg_h->data_length));
 			if (ret)
 				dev_err(port->dev, "Failed to append Handshake 2 event");
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index 894b1d11b2c9..274846d39fbf 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -48,7 +48,7 @@
 	     i < (proxy)->port_count;		\
 	     i++, (p) = &(proxy)->ports[i])
 
-static const struct t7xx_port_conf t7xx_md_port_conf[] = {
+static const struct t7xx_port_conf t7xx_port_conf[] = {
 	{
 		.tx_ch = PORT_CH_UART2_TX,
 		.rx_ch = PORT_CH_UART2_RX,
@@ -89,6 +89,14 @@ static const struct t7xx_port_conf t7xx_md_port_conf[] = {
 		.path_id = CLDMA_ID_MD,
 		.ops = &ctl_port_ops,
 		.name = "t7xx_ctrl",
+	}, {
+		.tx_ch = PORT_CH_AP_CONTROL_TX,
+		.rx_ch = PORT_CH_AP_CONTROL_RX,
+		.txq_index = Q_IDX_CTRL,
+		.rxq_index = Q_IDX_CTRL,
+		.path_id = CLDMA_ID_AP,
+		.ops = &ctl_port_ops,
+		.name = "t7xx_ap_ctrl",
 	},
 };
 
@@ -428,6 +436,9 @@ static void t7xx_proxy_init_all_ports(struct t7xx_modem *md)
 		if (port_conf->tx_ch == PORT_CH_CONTROL_TX)
 			md->core_md.ctl_port = port;
 
+		if (port_conf->tx_ch == PORT_CH_AP_CONTROL_TX)
+			md->core_ap.ctl_port = port;
+
 		port->t7xx_dev = md->t7xx_dev;
 		port->dev = &md->t7xx_dev->pdev->dev;
 		spin_lock_init(&port->port_update_lock);
@@ -442,7 +453,7 @@ static void t7xx_proxy_init_all_ports(struct t7xx_modem *md)
 
 static int t7xx_proxy_alloc(struct t7xx_modem *md)
 {
-	unsigned int port_count = ARRAY_SIZE(t7xx_md_port_conf);
+	unsigned int port_count = ARRAY_SIZE(t7xx_port_conf);
 	struct device *dev = &md->t7xx_dev->pdev->dev;
 	struct port_proxy *port_prox;
 	int i;
@@ -456,7 +467,7 @@ static int t7xx_proxy_alloc(struct t7xx_modem *md)
 	port_prox->dev = dev;
 
 	for (i = 0; i < port_count; i++)
-		port_prox->ports[i].port_conf = &t7xx_md_port_conf[i];
+		port_prox->ports[i].port_conf = &t7xx_port_conf[i];
 
 	port_prox->port_count = port_count;
 	t7xx_proxy_init_all_ports(md);
@@ -481,6 +492,7 @@ int t7xx_port_proxy_init(struct t7xx_modem *md)
 	if (ret)
 		return ret;
 
+	t7xx_cldma_set_recv_skb(md->md_ctrl[CLDMA_ID_AP], t7xx_port_proxy_recv_skb);
 	t7xx_cldma_set_recv_skb(md->md_ctrl[CLDMA_ID_MD], t7xx_port_proxy_recv_skb);
 	return 0;
 }
diff --git a/drivers/net/wwan/t7xx/t7xx_reg.h b/drivers/net/wwan/t7xx/t7xx_reg.h
index 7c1b81091a0f..c41d7d094c08 100644
--- a/drivers/net/wwan/t7xx/t7xx_reg.h
+++ b/drivers/net/wwan/t7xx/t7xx_reg.h
@@ -56,7 +56,7 @@
 #define D2H_INT_RESUME_ACK			BIT(12)
 #define D2H_INT_SUSPEND_ACK_AP			BIT(13)
 #define D2H_INT_RESUME_ACK_AP			BIT(14)
-#define D2H_INT_ASYNC_SAP_HK			BIT(15)
+#define D2H_INT_ASYNC_AP_HK			BIT(15)
 #define D2H_INT_ASYNC_MD_HK			BIT(16)
 
 /* Register base */
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 0bcca08ff2bd..80edb8e75a6a 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -285,8 +285,9 @@ static int fsm_routine_starting(struct t7xx_fsm_ctl *ctl)
 	t7xx_fsm_broadcast_state(ctl, MD_STATE_WAITING_FOR_HS1);
 	t7xx_md_event_notify(md, FSM_START);
 
-	wait_event_interruptible_timeout(ctl->async_hk_wq, md->core_md.ready || ctl->exp_flg,
-					 HZ * 60);
+	wait_event_interruptible_timeout(ctl->async_hk_wq,
+					 (md->core_md.ready && md->core_ap.ready) ||
+					  ctl->exp_flg, HZ * 60);
 	dev = &md->t7xx_dev->pdev->dev;
 
 	if (ctl->exp_flg)
@@ -297,6 +298,13 @@ static int fsm_routine_starting(struct t7xx_fsm_ctl *ctl)
 		if (md->core_md.handshake_ongoing)
 			t7xx_fsm_append_event(ctl, FSM_EVENT_MD_HS2_EXIT, NULL, 0);
 
+		fsm_routine_exception(ctl, NULL, EXCEPTION_HS_TIMEOUT);
+		return -ETIMEDOUT;
+	} else if (!md->core_ap.ready) {
+		dev_err(dev, "AP handshake timeout\n");
+		if (md->core_ap.handshake_ongoing)
+			t7xx_fsm_append_event(ctl, FSM_EVENT_AP_HS2_EXIT, NULL, 0);
+
 		fsm_routine_exception(ctl, NULL, EXCEPTION_HS_TIMEOUT);
 		return -ETIMEDOUT;
 	}
@@ -335,6 +343,7 @@ static void fsm_routine_start(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command
 		return;
 	}
 
+	t7xx_cldma_hif_hw_init(md->md_ctrl[CLDMA_ID_AP]);
 	t7xx_cldma_hif_hw_init(md->md_ctrl[CLDMA_ID_MD]);
 	fsm_finish_command(ctl, cmd, fsm_routine_starting(ctl));
 }
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.h b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
index b1af0259d4c5..b6e76f3903c8 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.h
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
@@ -38,10 +38,12 @@ enum t7xx_fsm_state {
 enum t7xx_fsm_event_state {
 	FSM_EVENT_INVALID,
 	FSM_EVENT_MD_HS2,
+	FSM_EVENT_AP_HS2,
 	FSM_EVENT_MD_EX,
 	FSM_EVENT_MD_EX_REC_OK,
 	FSM_EVENT_MD_EX_PASS,
 	FSM_EVENT_MD_HS2_EXIT,
+	FSM_EVENT_AP_HS2_EXIT,
 	FSM_EVENT_MAX
 };
 
-- 
2.41.0

