Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CFD63C545
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbiK2QgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbiK2QgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:36:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68CE697E5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:36:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A762B816BF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 16:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68385C433D6;
        Tue, 29 Nov 2022 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669739772;
        bh=XEJdCEdAAXPGW69UsV4pHOCIbF31aUsqhM+l+I8Eo6w=;
        h=From:To:Cc:Subject:Date:From;
        b=bRL2syn7n3vxcXFEkGirUFy02FH8wldby2m6SAFhSmnMWz7qVPIyjGg4nA6944Xmf
         rJbL7JYo3DHyauXLkRK7UhycxG2Sw2RRe2Ptc1oI5eQR8f6/iiZ6pSOP23NTh90rKD
         SdxU2ax6bRjuTTV5Rq6N23mRPAjzgZlKiJ6krDcALLcqOKr/hZwhsj5TwMco1FHOkx
         /t0zwonY2YacElW+30qH7Epdkjwum+ropXjNuEkUXV+PA4NAv/RKk2JrsXs+b/jrwD
         Qvhhz8FPTLAk+EKIP8sCPNUW9PKuasgzzMNn8tajIdFdDgY7I8xLRGCfPF/CdaHi1w
         eJi+d154FU1rA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 1/2] firmware: stratix10-svc: add missing gen_pool_destroy() in stratix10_svc_drv_probe()
Date:   Tue, 29 Nov 2022 10:36:01 -0600
Message-Id: <20221129163602.462369-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

In error path in stratix10_svc_drv_probe(), gen_pool_destroy() should be called
to destroy the memory pool that created by svc_create_memory_pool().

Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/firmware/stratix10-svc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index b4081f4d88a3..1a5640b3ab42 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1138,13 +1138,17 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 
 	/* allocate service controller and supporting channel */
 	controller = devm_kzalloc(dev, sizeof(*controller), GFP_KERNEL);
-	if (!controller)
-		return -ENOMEM;
+	if (!controller) {
+		ret = -ENOMEM;
+		goto err_destroy_pool;
+	}
 
 	chans = devm_kmalloc_array(dev, SVC_NUM_CHANNEL,
 				   sizeof(*chans), GFP_KERNEL | __GFP_ZERO);
-	if (!chans)
-		return -ENOMEM;
+	if (!chans) {
+		ret = -ENOMEM;
+		goto err_destroy_pool;
+	}
 
 	controller->dev = dev;
 	controller->num_chans = SVC_NUM_CHANNEL;
@@ -1159,7 +1163,7 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	ret = kfifo_alloc(&controller->svc_fifo, fifo_size, GFP_KERNEL);
 	if (ret) {
 		dev_err(dev, "failed to allocate FIFO\n");
-		return ret;
+		goto err_destroy_pool;
 	}
 	spin_lock_init(&controller->svc_fifo_lock);
 
@@ -1221,6 +1225,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 
 err_free_kfifo:
 	kfifo_free(&controller->svc_fifo);
+err_destroy_pool:
+	gen_pool_destroy(genpool);
 	return ret;
 }
 
-- 
2.25.1

