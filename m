Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB165BA1D2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 22:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiIOUa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 16:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiIOUaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 16:30:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0D03ED53
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:30:01 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so44644486ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EUHm5YwqUsut8vOCDG8gUqHimnptxihIuTZPupLKd+w=;
        b=oIsRIL7UHb5uy1H8a7ihPHy/irgQmUeLrHpYfS62aKWb2o/bCxHIE9WPyF8VzZdomb
         wZ5KoUxZNkcXT2QeXaqZKZ+UJlRUPHNxXRHIwzInSaLL0KI3q/mb7mF8Z5wRRiuV5eUD
         D7FCoOdc8jROfJuLlV5uA+KgtIKNXa/dn5oYXNR8k1XsXq/ZYW4ZQ1YluyGJgVUU6ZJ3
         po+mLGWVk5f2/6hZPL5pt9a2MpaMx7E9cm6+2gapZfsFfEN8NF0cPQlq9zb2Mqgrbfry
         nhajo4cRNX5XDG196iI3bxK/LIyKBJXZobuOuf2jd+wYuWih9l+HDqxOwQmD3VE7Dub4
         7Dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EUHm5YwqUsut8vOCDG8gUqHimnptxihIuTZPupLKd+w=;
        b=d0Mmz3bqOiRhgAwRd+KprQtvOMiVovbQgPQCBhpvH7KHzMZZZBC+UepB4weZm0XYsh
         0wE6cBQkuBUGNj5W0EtkgrYbyFgd3b2wxVbWlqpZO5NkRrVNjMfF2UB4E0UTei+2FY7y
         I6n0YuI3Be9fgY3kpC3ErS3old1kHc1Yyv7dnWk9BaDNZlc/r88P8UGR+ssgwYPPMJeH
         jI+DxRqj4S/I7tknw3XDTzt4rc3Is3PEd4GFxbmH/Hda+UuWaXMHha5ftEEKO87bbgsl
         zMuU35cAnYfKKp4nHqmPfrutagX/I5NikxeKKh8udIMKoY3FvRLSCLbZhQIg9lj3T3JT
         xKmA==
X-Gm-Message-State: ACrzQf2zAJd/D4ZhlaAnIs4TCGTOGtoq8sbtLDOZuQ9nui9cbRkbFB8B
        /ijSrNj6+/vJ+ZMYU859mn0=
X-Google-Smtp-Source: AMsMyM6s9925GGiS4XIQLJDs2LHEhvI9/OQ12/6LogfvtbqAUEhF5PB9+dgHAJ5gZamzhCHPYFc0tA==
X-Received: by 2002:a17:906:ef90:b0:77c:7227:705 with SMTP id ze16-20020a170906ef9000b0077c72270705mr1117401ejb.565.1663273799789;
        Thu, 15 Sep 2022 13:29:59 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-43.ip.prioritytelecom.net. [217.105.46.43])
        by smtp.gmail.com with ESMTPSA id ci25-20020a170906c35900b0072b3406e9c2sm9607295ejb.95.2022.09.15.13.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 13:29:59 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     namcaov@gmail.com, philipp.g.hortmann@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [RFC PATCH 5/5] staging: vt6655: implement allocation failure handling
Date:   Thu, 15 Sep 2022 22:29:36 +0200
Message-Id: <dd63998765f1ea1bf507a94c2d49317b36b5f32c.1663273218.git.namcaov@gmail.com>
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

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index ca6c4266f010..8ae4ecca2ee3 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -826,6 +826,7 @@ static void device_free_td1_ring(struct vnt_private *priv)
 static int device_rx_srv(struct vnt_private *priv, unsigned int idx)
 {
 	struct vnt_rx_desc *rd;
+	struct vnt_rd_info new_info;
 	int works = 0;
 
 	for (rd = priv->pCurrRD[idx];
@@ -837,16 +838,18 @@ static int device_rx_srv(struct vnt_private *priv, unsigned int idx)
 		if (!rd->rd_info->skb)
 			break;
 
-		vnt_receive_frame(priv, rd);
-
-		if (!device_alloc_rx_buf(priv, rd->rd_info)) {
+		if (!device_alloc_rx_buf(priv, &new_info)) {
 			dev_err(&priv->pcid->dev,
 				"can not allocate rx buf\n");
+			rd->rd0.owner = OWNED_BY_NIC;
 			break;
-		} else {
-			device_init_rx_desc(priv, rd);
 		}
 
+		vnt_receive_frame(priv, rd);
+
+		memcpy(rd->rd_info, &new_info, sizeof(new_info));
+		device_init_rx_desc(priv, rd);
+
 		rd->rd0.owner = OWNED_BY_NIC;
 	}
 
-- 
2.25.1

