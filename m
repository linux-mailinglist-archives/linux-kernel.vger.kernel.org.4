Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDAF5B828C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiINIA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiINIAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:00:55 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A978843630
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:00:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bj12so32742398ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ClOaIflSPN+EHb9vV2FObYh9sbBKXYrJn4XGyHako4I=;
        b=DuxKq9X8f7EtBnShnHW9QhzVWmL8R9tWGjwF21nCS+etUptXKVZ80rAk+KH6ine0um
         mqvcQs6ImwsBHwQ8+jjpxURYM02D+4/HD67bf5CEjQu1Qyy+JR1gwAW5+bS40Zc+kNBI
         ER7dxmHcjxnMGC7cAuMBJg6+RDAK02QixVqHq3S2trTMoy8x0s/lmyLavUnrcMcoeqLx
         y7bbKrIssse1HwHcUfQXoX4gxjxxN5mixWN4JQAqdZewSlcqO+fUtaSO5h3qyGpNjhu1
         ijbN6QAaDZQtImTJAZdg/wwktEyEWvAmp4IavGj/bHB+0VkoIT5h/9AX9Rwv1DPjFKXU
         iBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ClOaIflSPN+EHb9vV2FObYh9sbBKXYrJn4XGyHako4I=;
        b=l2F2dzh/U90RSS3HBKs7q4SeWYKrGPWnxsFoPOLT7CMj7Zw4lmLUXPRly+lQQvmKoV
         ppDhywcF1QF50+sRhsFolGUnScrjImco9CTm98+DcUOibkVm6cxAggehyCtpPmTV+Wmc
         4tB1xVmOZDVUsujhwpnvTilWhylZdOyHG6ZauB7NNVAchrePHuRr8oKVRNK3VWDKzHM+
         w6p7N3kkh+qLpCfsQZLXunE5RCiIHG9+/kWbIJcr6gbq+EY5QpymBrZL77rnJtV5FP4a
         yP3+nLRzbugO/VLD3uzIKVBz9lCI1QG6vz1PwptXNNQn4MezQYK0QfKAFPvX2wsL8soN
         4R5g==
X-Gm-Message-State: ACgBeo2z5/APnoc1vHvbxtlLjAdRhiTzPLY0CURR9JdjxcmIyi9NqJHF
        xwfCkolhw6ADe0tKNpWdLjndtKKKWkw=
X-Google-Smtp-Source: AA6agR7RwM8Cf6fWyc3kALgFYZIsA5cGHcTYPnwokFN43rs+hAaKYgHPA2Y04TaTLGHX+YIsHAeWsg==
X-Received: by 2002:a17:906:8448:b0:77b:e6d0:58a5 with SMTP id e8-20020a170906844800b0077be6d058a5mr12699837ejy.347.1663142453123;
        Wed, 14 Sep 2022 01:00:53 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-43.ip.prioritytelecom.net. [217.105.46.43])
        by smtp.gmail.com with ESMTPSA id lb22-20020a170907785600b0073bdf71995dsm1373120ejc.139.2022.09.14.01.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 01:00:52 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     namcaov@gmail.com, philipp.g.hortmann@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: vt6655: replace spin_lock_irqsave with spin_lock
Date:   Wed, 14 Sep 2022 10:00:17 +0200
Message-Id: <20220914080016.67951-1-namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vt6655 driver, there is a single interrupt handler: vnt_interrupt(),
and it does not take the spinlock. The interrupt handler only schedules
a workqueue, and the spinlock is taken in this workqueue. Thus, there is
no need to use spin_lock_irqsave, as the spinlock is never taken by an
interrupt. Replace spin_lock_irqsave (and spin_unlock_irqsave) with
spin_lock (and spin_unlock).

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/vt6655/card.c        |  5 ++--
 drivers/staging/vt6655/channel.c     |  6 ++---
 drivers/staging/vt6655/device_main.c | 38 +++++++++++-----------------
 3 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index c680925b9c92..3d2873874886 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -540,9 +540,8 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 {
 	union vnt_phy_field_swap phy;
 	unsigned char byTxRate, byRsvTime;      /* For OFDM */
-	unsigned long flags;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock(&priv->lock);
 
 	/* Set to Page1 */
 	VT6655_MAC_SELECT_PAGE1(priv->port_offset);
@@ -645,7 +644,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 	/* Set to Page0 */
 	VT6655_MAC_SELECT_PAGE0(priv->port_offset);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock(&priv->lock);
 }
 
 void CARDvUpdateBasicTopRate(struct vnt_private *priv)
diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index 4122875ebcaa..160ed640875d 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -111,9 +111,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 	bb_software_reset(priv);
 
 	if (priv->local_id > REV_ID_VT3253_B1) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&priv->lock, flags);
+		spin_lock(&priv->lock);
 
 		/* set HW default power register */
 		VT6655_MAC_SELECT_PAGE1(priv->port_offset);
@@ -123,7 +121,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWROFDM);
 		VT6655_MAC_SELECT_PAGE0(priv->port_offset);
 
-		spin_unlock_irqrestore(&priv->lock, flags);
+		spin_unlock(&priv->lock);
 	}
 
 	if (priv->byBBType == BB_TYPE_11B)
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 04d737012cef..ea9560996eda 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -260,7 +260,6 @@ static void vt6655_mac_dis_barker_preamble_md(void __iomem *iobase)
 
 static void device_init_registers(struct vnt_private *priv)
 {
-	unsigned long flags;
 	unsigned int ii;
 	unsigned char byValue;
 	unsigned char byCCKPwrdBm = 0;
@@ -289,11 +288,11 @@ static void device_init_registers(struct vnt_private *priv)
 	/* Get Local ID */
 	priv->local_id = ioread8(priv->port_offset + MAC_REG_LOCALID);
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock(&priv->lock);
 
 	SROMvReadAllContents(priv->port_offset, priv->abyEEPROM);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock(&priv->lock);
 
 	/* Get Channel range */
 	priv->byMinChannel = 1;
@@ -1093,7 +1092,6 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 	int             max_count = 0;
 	u32 mib_counter;
 	u32 isr;
-	unsigned long flags;
 
 	isr = ioread32(priv->port_offset + MAC_REG_ISR);
 
@@ -1105,7 +1103,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 		return;
 	}
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock(&priv->lock);
 
 	/* Read low level stats */
 	mib_counter = ioread32(priv->port_offset + MAC_REG_MIBCNTR);
@@ -1190,7 +1188,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 			break;
 	}
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock(&priv->lock);
 }
 
 static void vnt_interrupt_work(struct work_struct *work)
@@ -1220,9 +1218,8 @@ static int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct vnt_tx_desc *head_td;
 	u32 dma_idx;
-	unsigned long flags;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock(&priv->lock);
 
 	if (ieee80211_is_data(hdr->frame_control))
 		dma_idx = TYPE_AC0DMA;
@@ -1230,7 +1227,7 @@ static int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 		dma_idx = TYPE_TXDMA0;
 
 	if (AVAIL_TD(priv, dma_idx) < 1) {
-		spin_unlock_irqrestore(&priv->lock, flags);
+		spin_unlock(&priv->lock);
 		ieee80211_stop_queues(priv->hw);
 		return -ENOMEM;
 	}
@@ -1246,11 +1243,11 @@ static int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 
 	priv->apCurrTD[dma_idx] = head_td->next;
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock(&priv->lock);
 
 	vnt_generate_fifo_header(priv, dma_idx, head_td, skb);
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock(&priv->lock);
 
 	priv->bPWBitOn = false;
 
@@ -1272,7 +1269,7 @@ static int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 
 	priv->iTDUsed[dma_idx]++;
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock(&priv->lock);
 
 	return 0;
 }
@@ -1468,13 +1465,11 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 	priv->current_aid = vif->cfg.aid;
 
 	if (changed & BSS_CHANGED_BSSID && conf->bssid) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&priv->lock, flags);
+		spin_lock(&priv->lock);
 
 		vt6655_mac_write_bssid_addr(priv->port_offset, conf->bssid);
 
-		spin_unlock_irqrestore(&priv->lock, flags);
+		spin_unlock(&priv->lock);
 	}
 
 	if (changed & BSS_CHANGED_BASIC_RATES) {
@@ -1581,9 +1576,7 @@ static void vnt_configure(struct ieee80211_hw *hw,
 
 	if (changed_flags & FIF_ALLMULTI) {
 		if (*total_flags & FIF_ALLMULTI) {
-			unsigned long flags;
-
-			spin_lock_irqsave(&priv->lock, flags);
+			spin_lock(&priv->lock);
 
 			if (priv->mc_list_count > 2) {
 				VT6655_MAC_SELECT_PAGE1(priv->port_offset);
@@ -1603,7 +1596,7 @@ static void vnt_configure(struct ieee80211_hw *hw,
 				VT6655_MAC_SELECT_PAGE0(priv->port_offset);
 			}
 
-			spin_unlock_irqrestore(&priv->lock, flags);
+			spin_unlock(&priv->lock);
 
 			rx_mode |= RCR_MULTICAST | RCR_BROADCAST;
 		} else {
@@ -1830,13 +1823,12 @@ vt6655_probe(struct pci_dev *pcid, const struct pci_device_id *ent)
 static int __maybe_unused vt6655_suspend(struct device *dev_d)
 {
 	struct vnt_private *priv = dev_get_drvdata(dev_d);
-	unsigned long flags;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock(&priv->lock);
 
 	MACbShutdown(priv);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock(&priv->lock);
 
 	return 0;
 }
-- 
2.25.1

