Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003DB63C546
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiK2Qg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbiK2QgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:36:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CA55DB94
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:36:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00F16B8167C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 16:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3F6C433D7;
        Tue, 29 Nov 2022 16:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669739772;
        bh=FJV1S73SW2NjSjVVRTEYHknyVYkTqRLDNdBjhJdxKd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rx5zoWiT7UjBAwvJ9mL7z2rhlretxV8nmTj3yjPW2bu0a+xL04WmDHozhVFIB/3CE
         der71B/JGgA8M2n6BpCU5Z+ifuilKwycZDKkty6n20UBYVKtI3ov/woqytf0aQt9zl
         UQae/4qKOSl5abNpA2QhUQwubilNf3NLz564YrnRPJsble1If4GSN9AvqCtUlztvVC
         oiwk+R0cRclHXK0XnoZmtyCfgp2kvRDy6tW9l2p7bLltc6R9U542kML7D83s2zwwcD
         QR2xlDJIfVYffBX5J7KPFbnicHppWTia5U8gVwL1kIy4yqsKHmNzgdJzhQWcwIdcWd
         iCcacvQVdRKpA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 2/2] firmware: stratix10-svc: fix error handle while alloc/add device failed
Date:   Tue, 29 Nov 2022 10:36:02 -0600
Message-Id: <20221129163602.462369-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221129163602.462369-1-dinguyen@kernel.org>
References: <20221129163602.462369-1-dinguyen@kernel.org>
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

If add device "stratix10-rsu" failed in stratix10_svc_drv_probe(),
the 'svc_fifo' and 'genpool' need be freed in the error path.

If allocate or add device "intel-fcs" failed in stratix10_svc_drv_probe(),
the device "stratix10-rsu" need be unregistered in the error path.

Fixes: e6281c26674e ("firmware: stratix10-svc: Add support for FCS")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/firmware/stratix10-svc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 1a5640b3ab42..bde1f543f529 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1202,19 +1202,20 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	ret = platform_device_add(svc->stratix10_svc_rsu);
 	if (ret) {
 		platform_device_put(svc->stratix10_svc_rsu);
-		return ret;
+		goto err_free_kfifo;
 	}
 
 	svc->intel_svc_fcs = platform_device_alloc(INTEL_FCS, 1);
 	if (!svc->intel_svc_fcs) {
 		dev_err(dev, "failed to allocate %s device\n", INTEL_FCS);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_unregister_dev;
 	}
 
 	ret = platform_device_add(svc->intel_svc_fcs);
 	if (ret) {
 		platform_device_put(svc->intel_svc_fcs);
-		return ret;
+		goto err_unregister_dev;
 	}
 
 	dev_set_drvdata(dev, svc);
@@ -1223,6 +1224,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_unregister_dev:
+	platform_device_unregister(svc->stratix10_svc_rsu);
 err_free_kfifo:
 	kfifo_free(&controller->svc_fifo);
 err_destroy_pool:
-- 
2.25.1

