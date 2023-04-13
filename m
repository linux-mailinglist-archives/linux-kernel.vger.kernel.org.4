Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3C46E074F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjDMHD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMHD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:03:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4A64C3D;
        Thu, 13 Apr 2023 00:03:55 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7890:9d79:409d:b354])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5178A6603206;
        Thu, 13 Apr 2023 08:03:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681369433;
        bh=gqkR/A4hNaQu1Et9+WleKx6wTMCeG+gaXQPSwT4fAe8=;
        h=From:To:Cc:Subject:Date:From;
        b=mf8TE0H9D2km2vIYP0BrRdoMf5E2u9LfwCBagqA5nVm5tXZe92bQ9PzqG8DiN8MZX
         Ka8dSuzfL9Et3iL3ZZny1ZAOrj4Tn79xM136gEQbZwQVTlpsW+C7D37r7iC5OC6V8b
         kelvdb0TueF8IQPwTtKwSv7HZITsMS9fbDsoZLfzDm8aCcjfWurvw2znLJLggf1kRL
         S9jdYkWJq0cwdFmbK+sR1raoboDO5ArMmIxW6Oy8XwKk2haJsc5HRPUsE1D/eHAzPR
         k4an7DeeqyhewQv7kQWYuAr7SzO4mGDi7+GvRTXM6Nh8eSANyDVDvhGny8g6vQnzKe
         OLzyOcJLxhgNg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, m.szyprowski@samsung.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] media: verisilicon: Fix crash when probing encoder
Date:   Thu, 13 Apr 2023 09:03:44 +0200
Message-Id: <20230413070344.34803-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ctx->vpu_dst_fmt is no more initialized before calling hantro_try_fmt()
so assigne it to vpu_fmt led to crash the kernel.
Like for decoder case use 'fmt' as vpu format for encoder and clean up
the code.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: db6f68b51e5c ("media: verisilicon: Do not set context src/dst formats in reset functions")
---
 drivers/media/platform/verisilicon/hantro_v4l2.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 8f1414085f47..51f528f36241 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -293,13 +293,11 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
 		pix_mp->pixelformat = fmt->fourcc;
 	}
 
+	vpu_fmt = fmt;
+
 	if (coded) {
 		pix_mp->num_planes = 1;
-		vpu_fmt = fmt;
-	} else if (ctx->is_encoder) {
-		vpu_fmt = ctx->vpu_dst_fmt;
-	} else {
-		vpu_fmt = fmt;
+	} else if (!ctx->is_encoder) {
 		/*
 		 * Width/height on the CAPTURE end of a decoder are ignored and
 		 * replaced by the OUTPUT ones.
-- 
2.34.1

