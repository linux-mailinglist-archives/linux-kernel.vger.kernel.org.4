Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEF65F3C95
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 07:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiJDF4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 01:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJDF4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 01:56:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3311F9EB;
        Mon,  3 Oct 2022 22:56:35 -0700 (PDT)
Received: from lenovo.Home (unknown [39.45.148.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B9C07660225F;
        Tue,  4 Oct 2022 06:56:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664862994;
        bh=f5Z8WG3ZUTCNEZp4bLoVlduba3LPHIynOslY10NmbPU=;
        h=From:To:Cc:Subject:Date:From;
        b=eXEp/RGDrO4ptD0wWxshIrv2xLq+1oYDvfIkZsRSBI1JEUmZ/wKEcO8keYGq5tmt+
         GAM23VjYdwMQIeRqoSY+rq74gyw+Abrh35s3iUxqU0gVNmbDt0OF7AegXFkjD35UgQ
         cStYjy5awtCqAKV2vDdpuArmzT/2ObvKgrsjwpZgMfoLdc1aEaYuRyP0DccXpg/BbE
         tahmBYKdlYMgXB2+dpIe+QMod7ca0CS3d4c/qh/4TEKLYt7N0wZPtwE2j+FYoD4cxY
         ah4rZvvSqsF//AtludgcK8R/Jbj8ygTZKFaVdzeDRKK1NXSUyCdzgSQz5dPw06c73X
         UGcpUVD8vIIkQ==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: Remove the dead code
Date:   Tue,  4 Oct 2022 10:56:20 +0500
Message-Id: <20221004055620.371732-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vmallocated_buf is being checked if it is true inside the body of a
if condition which has already checked if it is true. Remove the
duplication and dead code as a result.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/spi/spi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 44e4352d948b..4c51cd4e4ab0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1057,10 +1057,7 @@ static int spi_map_buf_attrs(struct spi_controller *ctlr, struct device *dev,
 			min = min_t(size_t, desc_len,
 				    min_t(size_t, len,
 					  PAGE_SIZE - offset_in_page(buf)));
-			if (vmalloced_buf)
-				vm_page = vmalloc_to_page(buf);
-			else
-				vm_page = kmap_to_page(buf);
+			vm_page = vmalloc_to_page(buf);
 			if (!vm_page) {
 				sg_free_table(sgt);
 				return -ENOMEM;
-- 
2.30.2

