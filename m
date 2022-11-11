Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B5362564A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiKKJML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiKKJMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:12:01 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4DE43861
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:12:00 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VUWiU45_1668157914;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VUWiU45_1668157914)
          by smtp.aliyun-inc.com;
          Fri, 11 Nov 2022 17:11:58 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     bskeggs@redhat.com
Cc:     kherbst@redhat.com, lyude@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 5/5] drm/nouveau/gr/tu102: Remove the unused function tu102_gr_load()
Date:   Fri, 11 Nov 2022 17:11:30 +0800
Message-Id: <20221111091130.57178-5-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20221111091130.57178-1-jiapeng.chong@linux.alibaba.com>
References: <20221111091130.57178-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function tu102_gr_load() is defined in the tu102.c file, but
not called elsewhere, so remove this unused function.

drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c:210:1: warning: no
previous prototype for ‘tu102_gr_load’.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3020
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
index 3b6c8100a242..a7775aa18541 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
@@ -206,19 +206,6 @@ tu102_gr_av_to_init_veid(struct nvkm_blob *blob, struct gf100_gr_pack **ppack)
 	return gk20a_gr_av_to_init_(blob, 64, 0x00100000, ppack);
 }
 
-int
-tu102_gr_load(struct gf100_gr *gr, int ver, const struct gf100_gr_fwif *fwif)
-{
-	int ret;
-
-	ret = gm200_gr_load(gr, ver, fwif);
-	if (ret)
-		return ret;
-
-	return gk20a_gr_load_net(gr, "gr/", "sw_veid_bundle_init", ver, tu102_gr_av_to_init_veid,
-				 &gr->bundle_veid);
-}
-
 static const struct gf100_gr_fwif
 tu102_gr_fwif[] = {
 	{  0, gm200_gr_load, &tu102_gr, &gp108_gr_fecs_acr, &gp108_gr_gpccs_acr },
-- 
2.20.1.7.g153144c

