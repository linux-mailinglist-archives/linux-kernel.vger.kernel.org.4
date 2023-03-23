Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF0B6C6959
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjCWNRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjCWNRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:17:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6145B1CAD0;
        Thu, 23 Mar 2023 06:17:14 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:94d9:3023:d284:f7ca])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EAB6366003AC;
        Thu, 23 Mar 2023 13:17:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679577432;
        bh=k3pBI43jV9sj+/C08t+/IGaYJb3nAScopZL9mcMnChk=;
        h=From:To:Cc:Subject:Date:From;
        b=Hj1qOVlvySoUESeEAdmE7f/6bM8aPgWLQJrpQfkoKTfCRpoNYltwB+ZYhhRTRXdiM
         6D9MVLliT3DG2k3YENkj/dq5D5a+HlwAhJTKoZ3nfuhDOasfJ4Um6bGaC3Jt/PyhJt
         EclS2G0S//IyCJopff9PwTbJS8CloW7FK9aQdOxWTD0lEs6OqFJaZQpQq8tRr0Kc6N
         4URdFc2wYN43a4zTtZcdo1icqSG9j9BOnhfArMELTdMKrW3ZOtmkFs7nMJLAVdQMxh
         kP8hK+azdiIOi4ypYqV6qGW6OAf0CkZ04+75o7Fa9ipwYHKWgYXnRcN87ZPCxucLpz
         zvRDGg2inxh+g==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, elfring@users.sourceforge.net
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] media: verisilicon: Simplify error handling in tile_buffer_reallocate()
Date:   Thu, 23 Mar 2023 14:17:04 +0100
Message-Id: <20230323131704.414281-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework allocation errors cases handling to simply it
by removing useless tests.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reported-by: Markus Elfring <elfring@users.sourceforge.net>
---
 .../media/platform/verisilicon/hantro_hevc.c  | 23 ++++++++-----------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_hevc.c b/drivers/media/platform/verisilicon/hantro_hevc.c
index 9383fb7081f6..2c14330bc562 100644
--- a/drivers/media/platform/verisilicon/hantro_hevc.c
+++ b/drivers/media/platform/verisilicon/hantro_hevc.c
@@ -109,7 +109,7 @@ static int tile_buffer_reallocate(struct hantro_ctx *ctx)
 						       &hevc_dec->tile_filter.dma,
 						       GFP_KERNEL);
 	if (!hevc_dec->tile_filter.cpu)
-		goto err_free_tile_buffers;
+		return -ENOMEM;
 	hevc_dec->tile_filter.size = size;
 
 	size = (VERT_SAO_RAM_SIZE * height64 * (num_tile_cols - 1) * ctx->bit_depth) / 8;
@@ -125,31 +125,26 @@ static int tile_buffer_reallocate(struct hantro_ctx *ctx)
 						    &hevc_dec->tile_bsd.dma,
 						    GFP_KERNEL);
 	if (!hevc_dec->tile_bsd.cpu)
-		goto err_free_tile_buffers;
+		goto err_free_sao_buffers;
 	hevc_dec->tile_bsd.size = size;
 
 	hevc_dec->num_tile_cols_allocated = num_tile_cols;
 
 	return 0;
 
-err_free_tile_buffers:
-	if (hevc_dec->tile_filter.cpu)
-		dma_free_coherent(vpu->dev, hevc_dec->tile_filter.size,
-				  hevc_dec->tile_filter.cpu,
-				  hevc_dec->tile_filter.dma);
-	hevc_dec->tile_filter.cpu = NULL;
-
+err_free_sao_buffers:
 	if (hevc_dec->tile_sao.cpu)
 		dma_free_coherent(vpu->dev, hevc_dec->tile_sao.size,
 				  hevc_dec->tile_sao.cpu,
 				  hevc_dec->tile_sao.dma);
 	hevc_dec->tile_sao.cpu = NULL;
 
-	if (hevc_dec->tile_bsd.cpu)
-		dma_free_coherent(vpu->dev, hevc_dec->tile_bsd.size,
-				  hevc_dec->tile_bsd.cpu,
-				  hevc_dec->tile_bsd.dma);
-	hevc_dec->tile_bsd.cpu = NULL;
+err_free_tile_buffers:
+	if (hevc_dec->tile_filter.cpu)
+		dma_free_coherent(vpu->dev, hevc_dec->tile_filter.size,
+				  hevc_dec->tile_filter.cpu,
+				  hevc_dec->tile_filter.dma);
+	hevc_dec->tile_filter.cpu = NULL;
 
 	return -ENOMEM;
 }
-- 
2.34.1

