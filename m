Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED626DCA5E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjDJSG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDJSGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:06:25 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10DB1BD6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 11:06:11 -0700 (PDT)
Received: from liber-MS-7D42.. ([10.12.190.56])
        (user=gangecen@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33AI4Qur017616-33AI4Qus017616
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Apr 2023 02:04:31 +0800
From:   Gencen Gan <gangecen@hust.edu.cn>
To:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gan Gecen <gangecen@hust.edu.cn>
Cc:     hust-os-kernel-patches@googlegroups.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/pl111: fix drm and dev leak when irq request failed.
Date:   Tue, 11 Apr 2023 02:03:07 +0800
Message-Id: <20230410180307.3563501-1-gangecen@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: gangecen@hust.edu.cn
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gan Gecen <gangecen@hust.edu.cn>

Smatch reports:
	pl111_amba_probe() warn: missing unwind goto?

Code segment for dev_put is:
	dev_put:
		drm_dev_put(drm);
		of_reserved_mem_device_release(dev);

When err happened, jumping to dev_put will release
drm and dev resources allocated or initialized 
before. But after devm_request_irq() failed, it
returns directly without releasing drm and dev, 
which may cause memory leak.

Fixes: 3f9d6bccff6c ("drm/pl111: fix drm and dev leak when irq request failed")
Signed-off-by: Gan Gecen <gangecen@hust.edu.cn>
---
 drivers/gpu/drm/pl111/pl111_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 00deba0b7271..52945f7e0aef 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -297,7 +297,7 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 			       variant->name, priv);
 	if (ret != 0) {
 		dev_err(dev, "%s failed irq %d\n", __func__, ret);
-		return ret;
+		goto dev_put;
 	}
 
 	ret = pl111_modeset_init(drm);
-- 
2.34.1
