Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7048F62D427
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbiKQHdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239367AbiKQHdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:33:08 -0500
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E38EA6DCFC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:33:06 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-03 (Coremail) with SMTP id rQCowAD3_8Or43VjaDtaCQ--.57293S2;
        Thu, 17 Nov 2022 15:33:00 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nicholas.kazlauskas@amd.com, roman.li@amd.com,
        aurabindo.pillai@amd.com, Jerry.Zuo@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] drm/amd/display: rewrite the check for mods
Date:   Thu, 17 Nov 2022 15:32:58 +0800
Message-Id: <20221117073258.21214-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAD3_8Or43VjaDtaCQ--.57293S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW5Cr45Kr1kWr1UWF4fGrg_yoW8GF1Dpr
        4xGF1DX34vva1Iqa4UAF1rZFWa9a4xGrWjkrWUCw1qqw15trZ8WryYkF9Ygrs7WFW8u343
        tFy7J3y7ZF1qvF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
        6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUq38
        nUUUUU=
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the *mods is NULL, it should be better to return error immediately,
rather than continue with redundant operations.

Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index e6854f7270a6..05efc76b2226 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -638,11 +638,14 @@ static int get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_ty
 		return 0;
 
 	*mods = kmalloc(capacity * sizeof(uint64_t), GFP_KERNEL);
+	if (!*mods)
+		return -ENOMEM;
+
 
 	if (plane_type == DRM_PLANE_TYPE_CURSOR) {
 		add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
 		add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
-		return *mods ? 0 : -ENOMEM;
+		return 0;
 	}
 
 	switch (adev->family) {
@@ -671,9 +674,6 @@ static int get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_ty
 	/* INVALID marks the end of the list. */
 	add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
 
-	if (!*mods)
-		return -ENOMEM;
-
 	return 0;
 }
 
-- 
2.25.1

