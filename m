Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC7560E2DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiJZOJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiJZOJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:09:54 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8447495FF;
        Wed, 26 Oct 2022 07:09:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bp11so25985763wrb.9;
        Wed, 26 Oct 2022 07:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A0A5lCHNs+XemKP+wCfeNjxojYMmlZBo7aDpwOfQPqo=;
        b=JZgMKUonOdMuCuKZDP+3URj+3v2wDIoYv5Pa2BVRXlYZFfVz6cKn1NLTmMjkiinWr3
         uLdRkqt9kU061ia+Ljg1/I/bjJe923cnr6bJixLiIeQV098o4sr5q/3XWAIIsulm4m42
         UCUcm/WO5pZzDCLauz1F99+LicIxhzQyKgtA2UYDLds1j1FGxc8bnsb+V9thGgLtTccJ
         IyeCMjtZ510gu9ij//HRqBV13ZQrdqKnwFyfGl2uY2fLnzxsXj4iXrLvNFSa3okysGat
         a3JvYgKMy0cglLNtQrIDwGn+doGZ9qkwY7Njx9/g+DiFE1gOBHNETfu7hrwRxxP2uyzV
         KKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0A5lCHNs+XemKP+wCfeNjxojYMmlZBo7aDpwOfQPqo=;
        b=JmW1Gri49+uPjG0hTB49jZyrFCwssibHxT/A3Ou11CISIF/A6W2k4tQflUEA98uuVd
         b+sNrjPqy3mrmNUY8eM3W+0CB9cZG00+rg1l+pdU40kxcBGWqxNM2MlYilmYAYTNvbww
         zoV1Vqz9aHei5xkO2rXPvCT9YOwu6NM+/HRwjogoU6bYzGZoMjI6SUxr4x3rHuWUYoAv
         DjpYzluEKsV5UMptdSjDxBzjQ1zaPjNtWg3/+bzaia4+/YRM7tctTXdUMO9bMiLpAZTF
         NmMjNc/wDa+oE24W9E0J0/JHdku8H45sf2zKPNExSJzIIo48RgkQXoFKvwD67kqxfY6x
         p5kQ==
X-Gm-Message-State: ACrzQf1YARWPCF485klS5JdmXPO1MRoTsF04Ku2R6i6MrB8yGMzd0aLb
        JmH9XCuT5DMQr5Gn5m5gk1a1SpMn6YTOzlXh
X-Google-Smtp-Source: AMsMyM5e2I3HYFKRA91Hd0GiA/4DA0e6uH64qo8Oyp9bN6TLPAWiiS/WrO04T101hFNzUeY8ZCKTpw==
X-Received: by 2002:adf:e7c7:0:b0:236:6994:a0b4 with SMTP id e7-20020adfe7c7000000b002366994a0b4mr13855199wrn.610.1666793390286;
        Wed, 26 Oct 2022 07:09:50 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c15cc00b003c6cd82596esm1794363wmf.43.2022.10.26.07.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:09:49 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bus: fsl-mc: fsl-mc-allocator: remove variable free_count
Date:   Wed, 26 Oct 2022 15:09:49 +0100
Message-Id: <20221026140949.3242258-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable free_count is just being incremented and it's never used
anywhere else. The variable and the increment are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/bus/fsl-mc/fsl-mc-allocator.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index dced427ca8ba..f1351237a9d5 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -557,12 +557,9 @@ static void fsl_mc_cleanup_resource_pool(struct fsl_mc_device *mc_bus_dev,
 	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_bus_dev);
 	struct fsl_mc_resource_pool *res_pool =
 					&mc_bus->resource_pools[pool_type];
-	int free_count = 0;
 
-	list_for_each_entry_safe(resource, next, &res_pool->free_list, node) {
-		free_count++;
+	list_for_each_entry_safe(resource, next, &res_pool->free_list, node)
 		devm_kfree(&mc_bus_dev->dev, resource);
-	}
 }
 
 void fsl_mc_cleanup_all_resource_pools(struct fsl_mc_device *mc_bus_dev)
-- 
2.37.3

