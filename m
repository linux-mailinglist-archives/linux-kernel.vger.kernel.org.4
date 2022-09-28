Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD295EE2F9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbiI1RXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiI1RX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:23:29 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BFE7FE60
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:23:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a41so18175012edf.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nkSl1inMpvuvkN+Ej6lt7wMWY0ME+Ef7HkKqG5h0+Mo=;
        b=lSEubK26SLZ+QN4euhY+WZeOrkrou9JiVJYISGUO1dJWdirN+F0jbn01spSxQ2GwD2
         8d6cuNEZosm43QxgXg09MmKgp4BtVmlxKV+oxhWiHI6pyCGWDXVc3NPnSiQDXp7+pBiz
         9UeksiOxMmXZ60+2SW6Vi290gtZsk6MY3QOKNNSdDr/vmFAo0Jas7zcI7lRdCNtsRi/o
         6OI5Ba0SfqXWlprelKiHWWEpU4xZs5T4BUwQgmYla8oHWdcXdlm5QF7Yk73THqZD4cxy
         0Ag09t7MdciHkbO6Pxt0/SZBgncFIJgP9VfLSrPq1m78MHHXzanKxPb7kXoRECcenhBo
         yIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nkSl1inMpvuvkN+Ej6lt7wMWY0ME+Ef7HkKqG5h0+Mo=;
        b=y+vIqDfXwYz2jCMBVpzasOgPXGrIZbUxqu8Q+LQCNQuRcHiI8bOL9jufNKFR4GH0fK
         s8Eu23/ehD/bCPP0qYmsZt8HX6tTHrSY1RzUstQmd4Nw1BU/RUE+IW2SCG1EfBYGiiWs
         4lvYPTZaQexuYkMfAy3QE+RRKYlsy/ku+RF9q4l07IpQGsfdZBieHsgwYcfntAGb1Iy1
         ChHYjskBKg0cNvMHlKyXps7Nw13LZU4F1cRqHVple0sG/MPa14kRPVt9B2youhbzDWpY
         8lb/5uH/tIn96WlyX0sJVp5osMTDG4MmgA2RZohXKyEW2MghDWvF4ugF6H4cm6RzyL9Y
         xR/Q==
X-Gm-Message-State: ACrzQf3Q/MKkEGU6RPJEAtvtyA/VSWmbeO2kQi37ISiyIRYszipRmzc6
        VIn3DcNHbdOnF2dnQQQTlaU=
X-Google-Smtp-Source: AMsMyM6ahGQHUVH+USq5wTcfIlevhJM1p5e3nEjMiV9BjE060inFT1ykWMpII2siuIfAybtclk04jQ==
X-Received: by 2002:a05:6402:170c:b0:457:ded1:d395 with SMTP id y12-20020a056402170c00b00457ded1d395mr5631505edu.103.1664385806944;
        Wed, 28 Sep 2022 10:23:26 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-158.ip.prioritytelecom.net. [217.105.46.158])
        by smtp.gmail.com with ESMTPSA id lb6-20020a170907784600b007306a4ecc9dsm2725063ejc.18.2022.09.28.10.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 10:23:26 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com
Cc:     namcaov@gmail.com, philipp.g.hortmann@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [RFC PATCH v2 4/4] staging: vt6655: implement allocation failure handling
Date:   Wed, 28 Sep 2022 19:21:50 +0200
Message-Id: <4b88121b8b1aab63c8541c9ed9969315defb4db1.1664384503.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664384503.git.namcaov@gmail.com>
References: <cover.1664384503.git.namcaov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function device_rx_srv does not handle allocation failure very well.
Currently, it performs these steps:
        - Unmap DMA buffer and hand over the buffer to mac80211
        - Allocate and dma-map new buffer
        - If allocation fails, abort

The problem is that, it aborts while still marking the buffer as
OWNED_BY_HOST. So when this function is called again in the future, it
incorrectly perceives the same buffer as valid and dma-unmap and hand
over this buffer to mac80211 again.

Re-implement this function to do things in a different order:
        - Allocate and dma-map new buffer
        - If allocation fails, abort and give up the ownership of the
          buffer (so that the device can re-use this buffer)
        - If allocation does not fail: unmap dma buffer and hand over
          the buffer to mac80211

Thus, when the driver cannot allocate new buffer, it simply discards the
received data and re-use the current buffer.

Also split device_alloc_rx_buf() into 2 parts: allocating new buffer and
initializing the buffer, so that we can read the old buffer in between.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 33 ++++++++++++++++++----------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index c8cae6df7f51..cc952acd9825 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -132,7 +132,8 @@ static int device_init_td1_ring(struct vnt_private *priv);
 
 static int  device_rx_srv(struct vnt_private *priv, unsigned int idx);
 static int  device_tx_srv(struct vnt_private *priv, unsigned int idx);
-static bool device_alloc_rx_buf(struct vnt_private *, struct vnt_rx_desc *);
+static bool device_alloc_rx_buf(struct vnt_private *, struct vnt_rd_info *);
+static void device_init_rx_desc(struct vnt_private *priv, struct vnt_rx_desc *rd);
 static void device_free_rx_buf(struct vnt_private *priv,
 			       struct vnt_rx_desc *rd);
 static void device_init_registers(struct vnt_private *priv);
@@ -611,12 +612,13 @@ static int device_init_rd0_ring(struct vnt_private *priv)
 			goto err_free_desc;
 		}
 
-		if (!device_alloc_rx_buf(priv, desc)) {
+		if (!device_alloc_rx_buf(priv, desc->rd_info)) {
 			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
 			ret = -ENOMEM;
 			goto err_free_rd;
 		}
 
+		device_init_rx_desc(priv, desc);
 		desc->next = &priv->aRD0Ring[(i + 1) % priv->opts.rx_descs0];
 		desc->next_desc = cpu_to_le32(curr + sizeof(struct vnt_rx_desc));
 	}
@@ -657,12 +659,13 @@ static int device_init_rd1_ring(struct vnt_private *priv)
 			goto err_free_desc;
 		}
 
-		if (!device_alloc_rx_buf(priv, desc)) {
+		if (!device_alloc_rx_buf(priv, desc->rd_info)) {
 			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
 			ret = -ENOMEM;
 			goto err_free_rd;
 		}
 
+		device_init_rx_desc(priv, desc);
 		desc->next = &priv->aRD1Ring[(i + 1) % priv->opts.rx_descs1];
 		desc->next_desc = cpu_to_le32(curr + sizeof(struct vnt_rx_desc));
 	}
@@ -821,6 +824,7 @@ static void device_free_td1_ring(struct vnt_private *priv)
 static int device_rx_srv(struct vnt_private *priv, unsigned int idx)
 {
 	struct vnt_rx_desc *rd;
+	struct vnt_rd_info new_info;
 	int works = 0;
 
 	for (rd = priv->pCurrRD[idx];
@@ -832,13 +836,18 @@ static int device_rx_srv(struct vnt_private *priv, unsigned int idx)
 		if (!rd->rd_info->skb)
 			break;
 
-		vnt_receive_frame(priv, rd);
-
-		if (!device_alloc_rx_buf(priv, rd)) {
+		if (!device_alloc_rx_buf(priv, &new_info)) {
 			dev_err(&priv->pcid->dev,
 				"can not allocate rx buf\n");
+			rd->rd0.owner = OWNED_BY_NIC;
+			rd = rd->next;
 			break;
 		}
+
+		vnt_receive_frame(priv, rd);
+
+		memcpy(rd->rd_info, &new_info, sizeof(new_info));
+		device_init_rx_desc(priv, rd);
 	}
 
 	priv->pCurrRD[idx] = rd;
@@ -847,10 +856,8 @@ static int device_rx_srv(struct vnt_private *priv, unsigned int idx)
 }
 
 static bool device_alloc_rx_buf(struct vnt_private *priv,
-				struct vnt_rx_desc *rd)
+				struct vnt_rd_info *rd_info)
 {
-	struct vnt_rd_info *rd_info = rd->rd_info;
-
 	rd_info->skb = dev_alloc_skb((int)priv->rx_buf_sz);
 	if (!rd_info->skb)
 		return false;
@@ -864,15 +871,17 @@ static bool device_alloc_rx_buf(struct vnt_private *priv,
 		rd_info->skb = NULL;
 		return false;
 	}
+	return true;
+}
 
+static void device_init_rx_desc(struct vnt_private *priv, struct vnt_rx_desc *rd)
+{
 	*((unsigned int *)&rd->rd0) = 0; /* FIX cast */
 
 	rd->rd0.res_count = cpu_to_le16(priv->rx_buf_sz);
 	rd->rd0.owner = OWNED_BY_NIC;
 	rd->rd1.req_count = cpu_to_le16(priv->rx_buf_sz);
-	rd->buff_addr = cpu_to_le32(rd_info->skb_dma);
-
-	return true;
+	rd->buff_addr = cpu_to_le32(rd->rd_info->skb_dma);
 }
 
 static void device_free_rx_buf(struct vnt_private *priv,
-- 
2.25.1

