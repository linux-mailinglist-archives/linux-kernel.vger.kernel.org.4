Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9516E3F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjDQGCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjDQGCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:02:52 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9382D53
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:02:50 -0700 (PDT)
Received: from dd-virtual-machine.localdomain ([60.247.94.10])
        (user=U202112190@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33H618GE027391-33H618GF027391
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 17 Apr 2023 14:01:10 +0800
From:   Hongqi Chen <U202112190@hust.edu.cn>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Alan Cox <alan@linux.intel.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Hongqi Chen <U202112190@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: gma500: psb_drv: add missing unwind goto 
Date:   Mon, 17 Apr 2023 14:01:05 +0800
Message-Id: <20230417060105.16411-1-U202112190@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: U202112190@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports that missing unwind goto in psb_driver_load().
drivers/gpu/drm/gma500/psb_drv.c:350 psb_driver_load() warn: missing
unwind goto?

psb_driver_unload() and psb_driver_load() exist in correspondence, 
and psb_driver_unload() should be executed when the psb_do_init() 
fails to initialize.

Fixes: 5c49fd3aa0ab ("gma500: Add the core DRM files and headers")
Signed-off-by: Hongqi Chen <U202112190@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/gpu/drm/gma500/psb_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index cd9c73f5a64a..b5a276342129 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -347,7 +347,7 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 
 	ret = psb_do_init(dev);
 	if (ret)
-		return ret;
+		goto out_err;
 
 	/* Add stolen memory to SGX MMU */
 	ret = psb_mmu_insert_pfn_sequence(psb_mmu_get_default_pd(dev_priv->mmu),
-- 
2.25.1

