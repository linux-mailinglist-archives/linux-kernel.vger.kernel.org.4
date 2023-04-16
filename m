Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B546E35FE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 10:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjDPIKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 04:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjDPIKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 04:10:18 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C25198C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 01:10:17 -0700 (PDT)
Received: from liber-MS-7D42.. ([10.12.190.56])
        (user=gangecen@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33G89Eu5003804-33G89Eu6003804
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 16 Apr 2023 16:09:20 +0800
From:   Gencen Gan <gangecen@hust.edu.cn>
To:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gan Gecen <gangecen@hust.edu.cn>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Cheng Ziqiu <chengziqiu@hust.edu.cn>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PING PATCH] drm/pl111: fix drm and dev leak when irq request failed.
Date:   Sun, 16 Apr 2023 16:09:07 +0800
Message-Id: <20230416080907.3895808-1-gangecen@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: gangecen@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Reviewed-by: Cheng Ziqiu <chengziqiu@hust.edu.cn>
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
