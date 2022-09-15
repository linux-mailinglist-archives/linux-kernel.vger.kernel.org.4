Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25DD5BA1D0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 22:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiIOUaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 16:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiIOUaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 16:30:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758BB3A160
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:30:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dv25so44658743ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Z8Qqwdo2MtVcZqXTy6aDXip/9KzF6Sq0fneVcEjjyRo=;
        b=L8Pucizs8ljkp8vk9wz/6AX3QAnAzERGaTZXN5Xtzt+Oksh3TboL9cp4Vdco/JnJ9m
         LlbMhu9CG4cmzLfCsNDj8OrF9eNx38/9YfccvNpA1nePgGyYrOdvAHXy4FrEMgki96ys
         fx70mupblp/elgVIYQmkTn80xwdSw1AUWalxe2CZV3+4YbLvoCEl2I41smd5f7ep1Als
         UNGlaP4Frt60oAyqTO8YZx1dxXIKKHfK9snJwxlEaMWUxQUNPYrj5JRKkZ60imoybskD
         GF1Z7u47PKSJJZ0ZcOonx7myW1AWh/89bwaPa4SJJ7Eg3vO+fQwaALIDh4epEm8+mYNd
         aBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Z8Qqwdo2MtVcZqXTy6aDXip/9KzF6Sq0fneVcEjjyRo=;
        b=afCkgsMy8dz8ECoIr2n1lPXybh6GKH2YTgAie8SW+4u3llJZ/rjseUqVRD0J7p8nsu
         6ZypsrnloTkVfNNuBNVBWxhRfT0Sd9symoZEMbLoGunpclQxs4Ygs4V655boq8FIO9We
         k170ZExZGL72oTC9K6Os2dBLvn+9ae6w0FN0NjI4HiD9nrjS8VBWVdLIsMn4LyrmBshI
         PkpdJRshmDaKnm9OpEzZsnYzRp+FkmdEwTs/TAd5gWrgiWgLaGWAhKal06n/YMoZaIwl
         PKMS6n3kgDj5Ov/xoLGLSGFTdSjyOPcMkkYzIVU4oLv4+Qdn1gyw/z8HpCb9Jp2eeWac
         fdJA==
X-Gm-Message-State: ACrzQf3rDaMBpjfzOvVXzNQ1Tdyy0Q74ogNLXeNP3X888x+UxFo9iPUQ
        6ENE/X5QbiuZBaZ5NnnQM1s=
X-Google-Smtp-Source: AMsMyM7V0C4G80Zc+gWypxx7ogIGlXVCzN3I+LiRymGBanw+Tl/rnn6iqK8FtO+uaoYijBl7RYVOFA==
X-Received: by 2002:a17:907:320c:b0:77b:6f08:9870 with SMTP id xg12-20020a170907320c00b0077b6f089870mr1108419ejb.249.1663273799106;
        Thu, 15 Sep 2022 13:29:59 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-43.ip.prioritytelecom.net. [217.105.46.43])
        by smtp.gmail.com with ESMTPSA id ci25-20020a170906c35900b0072b3406e9c2sm9607295ejb.95.2022.09.15.13.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 13:29:58 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     namcaov@gmail.com, philipp.g.hortmann@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [RFC PATCH 4/5] staging: vt6655: change device_alloc_rx_buf's argument
Date:   Thu, 15 Sep 2022 22:29:35 +0200
Message-Id: <40d72f6fdc3394a0bba15753d4f3b103bbc8332e.1663273218.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663273218.git.namcaov@gmail.com>
References: <cover.1663273218.git.namcaov@gmail.com>
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

The function device_alloc_rx_buf takes struct vnt_rx_desc as 1 argument,
but only accesses the member rd_info of this struct. Change this
argument to struct vnt_rd_info instead.

This is preparation to implement correct out-of-memory error handling.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 27fe28156257..ca6c4266f010 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -132,7 +132,7 @@ static int device_init_td1_ring(struct vnt_private *priv);
 
 static int  device_rx_srv(struct vnt_private *priv, unsigned int idx);
 static int  device_tx_srv(struct vnt_private *priv, unsigned int idx);
-static bool device_alloc_rx_buf(struct vnt_private *, struct vnt_rx_desc *);
+static bool device_alloc_rx_buf(struct vnt_private *, struct vnt_rd_info *);
 static void device_init_rx_desc(struct vnt_private *priv, struct vnt_rx_desc *rd);
 static void device_free_rx_buf(struct vnt_private *priv,
 			       struct vnt_rx_desc *rd);
@@ -612,7 +612,7 @@ static int device_init_rd0_ring(struct vnt_private *priv)
 			goto err_free_desc;
 		}
 
-		if (!device_alloc_rx_buf(priv, desc)) {
+		if (!device_alloc_rx_buf(priv, desc->rd_info)) {
 			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
 			ret = -ENOMEM;
 			goto err_free_rd;
@@ -660,7 +660,7 @@ static int device_init_rd1_ring(struct vnt_private *priv)
 			goto err_free_desc;
 		}
 
-		if (!device_alloc_rx_buf(priv, desc)) {
+		if (!device_alloc_rx_buf(priv, desc->rd_info)) {
 			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
 			ret = -ENOMEM;
 			goto err_free_rd;
@@ -839,7 +839,7 @@ static int device_rx_srv(struct vnt_private *priv, unsigned int idx)
 
 		vnt_receive_frame(priv, rd);
 
-		if (!device_alloc_rx_buf(priv, rd)) {
+		if (!device_alloc_rx_buf(priv, rd->rd_info)) {
 			dev_err(&priv->pcid->dev,
 				"can not allocate rx buf\n");
 			break;
@@ -856,10 +856,8 @@ static int device_rx_srv(struct vnt_private *priv, unsigned int idx)
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
-- 
2.25.1

