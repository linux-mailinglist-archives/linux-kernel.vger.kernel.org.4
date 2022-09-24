Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBAC5E8AC4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 11:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiIXJ3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 05:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiIXJ3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 05:29:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D04A13A07B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 02:29:05 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MZNrM1hNpzHthT;
        Sat, 24 Sep 2022 17:24:19 +0800 (CST)
Received: from huawei.com (10.67.175.83) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 24 Sep
 2022 17:29:02 +0800
From:   ruanjinjie <ruanjinjie@huawei.com>
To:     <bskeggs@redhat.com>, <kherbst@redhat.com>, <lyude@redhat.com>,
        <airlied@linux.ie>, <linux-kernel@vger.kernel.org>,
        <daniel@ffwll.ch>, <jani.nikula@intel.com>, <airlied@redhat.com>,
        <tzimmermann@suse.de>, <hverkuil-cisco@xs4all.nl>,
        <greenfoo@u92.eu>, <seanpaul@chromium.org>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] drm/nouveau/disp: fix cast removes address space of expression warnings
Date:   Sat, 24 Sep 2022 17:25:16 +0800
Message-ID: <20220924092516.10007-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When build Linux kernel with 'make C=2', encounter the following warnings:

./drivers/gpu/drm/nouveau/dispnv50/disp.c:134:34: warning: cast removes address space '__iomem' of expression
./drivers/gpu/drm/nouveau/dispnv50/disp.c:197:34: warning: cast removes address space '__iomem' of expression

The data type of dmac->_push.mem.object.map.ptr is 'void __iomem *', but
converted to 'u32 *' directly and cause above warnings, now
recover their data types to fix these warnings.

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 33c97d510999..aa94f8e284dd 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -131,7 +131,7 @@ nv50_dmac_kick(struct nvif_push *push)
 {
 	struct nv50_dmac *dmac = container_of(push, typeof(*dmac), _push);
 
-	dmac->cur = push->cur - (u32 *)dmac->_push.mem.object.map.ptr;
+	dmac->cur = push->cur - (u32 __iomem *)dmac->_push.mem.object.map.ptr;
 	if (dmac->put != dmac->cur) {
 		/* Push buffer fetches are not coherent with BAR1, we need to ensure
 		 * writes have been flushed right through to VRAM before writing PUT.
@@ -194,7 +194,7 @@ nv50_dmac_wait(struct nvif_push *push, u32 size)
 	if (WARN_ON(size > dmac->max))
 		return -EINVAL;
 
-	dmac->cur = push->cur - (u32 *)dmac->_push.mem.object.map.ptr;
+	dmac->cur = push->cur - (u32 __iomem *)dmac->_push.mem.object.map.ptr;
 	if (dmac->cur + size >= dmac->max) {
 		int ret = nv50_dmac_wind(dmac);
 		if (ret)
-- 
2.25.1

