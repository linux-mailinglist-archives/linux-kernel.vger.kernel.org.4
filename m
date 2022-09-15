Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11AA5BA1D1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 22:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiIOUaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 16:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiIOUaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 16:30:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCB936854
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:29:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y8so21745307edc.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=y9AZ5yPTroiJBvhJDLo/B5BMwojZlFfEWtDm17F1H2o=;
        b=gKcrXG508Y7GGiISvf6xps0gJw1MiLbJWci8tBoN0NFKZiy8RXXR15fxug2/MvscW/
         aays0JHzdQ3vwG2L1+KMSarkqy+WhO8hMV9HNU2XtTkIPszTtrXid4LObO7uJhdW2A83
         tseJQ6jPcvB6F9cqpLy1UFYF337eBlQ4DcatUaoSKBjs3kIxsMv2OWxQq5nUvkp+/gkW
         YMm1xFQFFRbcgbi/VRHqYA2FQh0DS+CWl07E+8JlaN94wi9IEa+6ctV7Yq+m1PgKrG+p
         SHkoRG9wvsJvpTBONXQ68u8bvDEDtOQrKu91c642tK1GpDz1OkXsLkvbx1+ikGKFEuvc
         ZiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=y9AZ5yPTroiJBvhJDLo/B5BMwojZlFfEWtDm17F1H2o=;
        b=4TKpChdlNVno0lvSyPrQZChtUq/NMiJVNZZipEmgxr/CD2GzEUiyFH3U6JYquzP4UK
         c7AtXp9zUVC3p8OJuoiO/D0HLYIeeJeYzF82f+64+WsEDQ5aL6kZ+oZwD9kNxXwqfeer
         NLzfKJCUhcPuc5Vc+krp/qxdWF8HItm6L5SCTgBGavsxIvDZoFsGeEah/XbNkG4kSOqv
         3qRrVZYHH5Pyl4AVxpD+ZmSA4fHu/J4xHl4Upa+choSEQIJ/PFOIfCsPVkXF4U7AdQ8C
         GhsjIGSmSyan4L5YISlk0NKyN0y13DHSPL018QKQDZdFBpQm1WinGsCvkYbfPd3Ihpvb
         cBAA==
X-Gm-Message-State: ACrzQf08HloSKnPTrTnKTW9qQLd/nv4+0RzhSKsxJI78K3pivY1a7s9l
        WGfKilZVRvWMM5VHctzg6J+s8xs62P8=
X-Google-Smtp-Source: AMsMyM7JmiuWn67fftEFKkqPS8BNP2/xzQh97SQlBr9HtoIthWNMA3iryF30oADtYmNKay/PmC0nfA==
X-Received: by 2002:a05:6402:28ca:b0:43b:5235:f325 with SMTP id ef10-20020a05640228ca00b0043b5235f325mr1323816edb.320.1663273798405;
        Thu, 15 Sep 2022 13:29:58 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-43.ip.prioritytelecom.net. [217.105.46.43])
        by smtp.gmail.com with ESMTPSA id ci25-20020a170906c35900b0072b3406e9c2sm9607295ejb.95.2022.09.15.13.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 13:29:58 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     namcaov@gmail.com, philipp.g.hortmann@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [RFC PATCH 3/5] staging: vt6655: split device_alloc_rx_buf
Date:   Thu, 15 Sep 2022 22:29:34 +0200
Message-Id: <311eaa7dabe12d0baeb0af6f85c2b43b20b230a3.1663273218.git.namcaov@gmail.com>
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

The function device_alloc_rx_buf does 2 things: allocating rx buffer
and initializing the rx descriptor's values. Split this function into
two, with each does one job.

This split is preparation for implementing correct out-of-memory error
handling.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 79325a693857..27fe28156257 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -133,6 +133,7 @@ static int device_init_td1_ring(struct vnt_private *priv);
 static int  device_rx_srv(struct vnt_private *priv, unsigned int idx);
 static int  device_tx_srv(struct vnt_private *priv, unsigned int idx);
 static bool device_alloc_rx_buf(struct vnt_private *, struct vnt_rx_desc *);
+static void device_init_rx_desc(struct vnt_private *priv, struct vnt_rx_desc *rd);
 static void device_free_rx_buf(struct vnt_private *priv,
 			       struct vnt_rx_desc *rd);
 static void device_init_registers(struct vnt_private *priv);
@@ -615,6 +616,8 @@ static int device_init_rd0_ring(struct vnt_private *priv)
 			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
 			ret = -ENOMEM;
 			goto err_free_rd;
+		} else {
+			device_init_rx_desc(priv, desc);
 		}
 
 		desc->next = &priv->aRD0Ring[(i + 1) % priv->opts.rx_descs0];
@@ -661,6 +664,8 @@ static int device_init_rd1_ring(struct vnt_private *priv)
 			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
 			ret = -ENOMEM;
 			goto err_free_rd;
+		} else {
+			device_init_rx_desc(priv, desc);
 		}
 
 		desc->next = &priv->aRD1Ring[(i + 1) % priv->opts.rx_descs1];
@@ -838,7 +843,10 @@ static int device_rx_srv(struct vnt_private *priv, unsigned int idx)
 			dev_err(&priv->pcid->dev,
 				"can not allocate rx buf\n");
 			break;
+		} else {
+			device_init_rx_desc(priv, rd);
 		}
+
 		rd->rd0.owner = OWNED_BY_NIC;
 	}
 
@@ -865,15 +873,17 @@ static bool device_alloc_rx_buf(struct vnt_private *priv,
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

