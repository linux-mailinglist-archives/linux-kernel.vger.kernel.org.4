Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346546C51FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjCVRPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjCVRO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:14:58 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944C164866
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:14:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id cn12so30218190edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505296;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwlxfJdJWd/C2Uy2mVEIXe3Fs4cv7HuOigtW0ECLJNU=;
        b=i/1NL3llpeN22VO2qWLkFXGR6pObJ6tWsek5bEwsmDVHmQLn5Bl2gl3f5JOxYQpx9L
         PzMLlJs45OcXRoVi0YrU9Q7rUAGSrw+XzQS9FeF4ivB4UgR0UheN/NJOeroUlmhrEGs6
         UTa1TjlPO1vv0eQTdCNgVgyjACRMD1FUmlixrfk2ejtsYiFG35/eqmz1iR5C/eee8ZVe
         FmrhxRhSNMfWNRUzoDtyJofLnSRSb0e9c5iQ56OtYXDonfMm3XYZ+TfJpCUh42f2DUjV
         DcgzVNigo5S1YI19l/y7SM8TuD5Dh0iHehCksJrLK4d7NmVZNJH0YFy87ZRTuA0nqYpS
         mzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505296;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YwlxfJdJWd/C2Uy2mVEIXe3Fs4cv7HuOigtW0ECLJNU=;
        b=uUUizCqTHcwyJEd487tRHgQgFeGYkHXAa3r072de9jld8raPc3jQ64tv6TWHeV2bWQ
         1Ngk+9MEts9HHUouvh/qWPIhOonGf+iEOn1cG/BHzPSnpyrc6U9yC4FY+3LnlMHICHTU
         Os1z8Hty1luYnE7NdDgpmwRcZwQvwer6BKBzxDo1gUuMfa2syZO78NA3F+2DHPZXIvk5
         ALeRCXIjbuAciK8PQjoSFxaSVfSiqWS1gaqvTAn7IMnTa1bQ7lnEAtEJOXz9ovsLnB2o
         avjfXt06kFqzNRIiN/nSS1yCe9LMdsCXJeyiQjs+bsyU3NCOS5WQ3jHF69pkRsY+2Wa5
         mPSQ==
X-Gm-Message-State: AO0yUKXrTQYjVI3v9xDWzguiTEhyuHlhcUzp3Xr5xdo1jLbczbtFRtDK
        leKcJD2nhHjqHgvP3zCdTG0=
X-Google-Smtp-Source: AK7set9/cS06/DZEfO6BPPK1A8WvSG8vShlu49d5pGRPlgSTiBTdrQ73fnb+l0dMwb3YbMfoIHAUDA==
X-Received: by 2002:a17:906:7485:b0:8b1:2614:dea6 with SMTP id e5-20020a170906748500b008b12614dea6mr7099804ejl.1.1679505296127;
        Wed, 22 Mar 2023 10:14:56 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id z3-20020a170906434300b008d427df3245sm7513015ejm.58.2023.03.22.10.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:14:55 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:14:53 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] staging: rtl8192e: Replace macro skb_tail_pointer_rsl
 with standard function
Message-ID: <6885112850b48c0f9ff16655f7d9efe085ccc001.1679504314.git.philipp.g.hortmann@gmail.com>
References: <cover.1679504314.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1679504314.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro skb_tail_pointer_rsl with function skb_tail_pointer to
increase readablility.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1->V2: Changed subject line to be without “f.”
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

