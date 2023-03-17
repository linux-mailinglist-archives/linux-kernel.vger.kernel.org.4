Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2036BF184
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCQTNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjCQTNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:13:36 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B11C3E1E6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:13:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z21so24299036edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679080408; x=1681672408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WdvGLimWlyViKT5AvlOeO6Wk+zSpkACpdO1SpV6s/lw=;
        b=Ye4AH+lF1JQ9QT7C2JKPCwHf5ic80KnDEqxrGQnMgHjrORQW3VFRHZxeNxHtPzGp0w
         kTSaapUvLzFiD2G8yIFQk5fEn0bx6WX2A1FBJ2FpaAkgyFhhTacaCEqZTZkK9460HClj
         kKJBgqaRpFynMAYZ7u59x5Hv2Y7NBjGtM5z+RMtp5ryWkzTUY/wtniOZ3zlXkQaDtQR7
         M6CayalS9qvppGw/ACjtCA77UIkdL1mviKXgUGQ3ggXKlFvxtqNfDr3wvsB51RJBjqSJ
         0pRO/VATExCVwb0NedhFlCOKQ5RdGK1B7nsoT25ccWF5Eh2FmoDNEZ+tLVbLxuyp05IA
         2T0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679080408; x=1681672408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdvGLimWlyViKT5AvlOeO6Wk+zSpkACpdO1SpV6s/lw=;
        b=sjHt61NQ8sodityRVdLobxaoMug+28MTkiyOH7AuPGo1fRHFbU6AFEYsUsmi/zRfGP
         1LfNE233SoHg1Cj/gPYwSAnXFPpy9MmmztvJEcFOD14ffYRp/EOCezvBIxifFJ/YyFOZ
         OgjLgxR2MaFZa4T/kn2pD2xVfNDH6eWEP9R0FaCNeN7EIk3JFTMedPilU7axiwO04T3a
         2DjVKpJ3o3MKHeuYCj3BSA2WoMIp/4hJ72PP/afc/nmwrB/oafSbNqzNB1aFgFgmMk2q
         NDAZM8OLt2t4h+OWVd/6cVWgdTJHBMsELQPwnZHvNctWkO+94fQWZYOENFoEPySvY17u
         RXHw==
X-Gm-Message-State: AO0yUKWoi+ha3iQBnWxw8paPtxT6Yjx8vATZd3EtPZFpojjZEicBNIam
        BIexo7U4zch+CzDNlikgpoZ/AYBYCAk=
X-Google-Smtp-Source: AK7set/I5Le01T4EAEssvXbcwKWxRM238msATyMDuN0QaQJuBVuN/ijQ2S1LDBg1bPmh7Mm/TvuREQ==
X-Received: by 2002:a17:906:213:b0:931:5145:c51f with SMTP id 19-20020a170906021300b009315145c51fmr4773605ejd.4.1679080407988;
        Fri, 17 Mar 2023 12:13:27 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id d1-20020a50cd41000000b004af720b855fsm1448742edj.82.2023.03.17.12.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 12:13:27 -0700 (PDT)
Date:   Fri, 17 Mar 2023 20:13:25 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] staging: rtl8192e: Replace macro skb_tail_pointer_rsl
 with standard f.
Message-ID: <f8c55bd613470a80ae9f45f908be84c0ffb6ebdb.1679077522.git.philipp.g.hortmann@gmail.com>
References: <cover.1679077522.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679077522.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro skb_tail_pointer_rsl with function skb_tail_pointer to
increase readablility.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h            | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 47feb4248d25..2ec47c367c5f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1653,7 +1653,7 @@ static short _rtl92e_alloc_rx_ring(struct net_device *dev)
 			priv->rx_buf[rx_queue_idx][i] = skb;
 			mapping = (dma_addr_t *)skb->cb;
 			*mapping = dma_map_single(&priv->pdev->dev,
-						  skb_tail_pointer_rsl(skb),
+						  skb_tail_pointer(skb),
 						  priv->rxbuffersize, DMA_FROM_DEVICE);
 			if (dma_mapping_error(&priv->pdev->dev, *mapping)) {
 				dev_kfree_skb_any(skb);
@@ -1909,7 +1909,7 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 		priv->rx_buf[rx_queue_idx][priv->rx_idx[rx_queue_idx]] =
 								 skb;
 		*((dma_addr_t *)skb->cb) = dma_map_single(&priv->pdev->dev,
-							  skb_tail_pointer_rsl(skb),
+							  skb_tail_pointer(skb),
 							  priv->rxbuffersize, DMA_FROM_DEVICE);
 		if (dma_mapping_error(&priv->pdev->dev, *((dma_addr_t *)skb->cb))) {
 			dev_kfree_skb_any(skb);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 8e5e29ce8f0d..cb904fc4f574 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -62,8 +62,6 @@
 #define IW_CUSTOM_MAX	256	/* In bytes */
 #endif
 
-#define skb_tail_pointer_rsl(skb) skb_tail_pointer(skb)
-
 #define queue_delayed_work_rsl(x, y, z) queue_delayed_work(x, y, z)
 #define INIT_DELAYED_WORK_RSL(x, y, z) INIT_DELAYED_WORK(x, y)
 
-- 
2.39.2

