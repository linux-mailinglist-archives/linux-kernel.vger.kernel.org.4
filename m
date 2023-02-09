Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9BC6902E8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjBIJJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjBIJJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:09:34 -0500
Received: from cstnet.cn (smtp80.cstnet.cn [159.226.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E52402682;
        Thu,  9 Feb 2023 01:09:32 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-01 (Coremail) with SMTP id qwCowAB3f89DuORjVuQzBA--.44164S2;
        Thu, 09 Feb 2023 17:09:23 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, moudy.ho@mediatek.com,
        daoyuan.huang@mediatek.com, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] media: platform: mtk-mdp3: Add missing check and free for ida_alloc
Date:   Thu,  9 Feb 2023 17:09:22 +0800
Message-Id: <20230209090922.8829-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3f89DuORjVuQzBA--.44164S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryUZFy8Kr4DAF4rKw45KFg_yoW8Gr1Upr
        WIg3y7CrW5GFnrKF4Iy3W7uF45AwnY9ayUWFsavw4xAas8WrsrGryYkasYvrykJry8Ja47
        tr4Utry3CrWYvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUjC385UUUUU==
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the check for the return value of the ida_alloc in order to avoid
NULL pointer dereference.
Moreover, free allocated "ctx->id" if mdp_m2m_open fails later in order
to avoid memory leak.

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v1 -> v2:

1. Fix the check for the ida_alloc.
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
index 5f74ea3b7a52..4785c897ee1d 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
@@ -567,6 +567,11 @@ static int mdp_m2m_open(struct file *file)
 	}
 
 	ctx->id = ida_alloc(&mdp->mdp_ida, GFP_KERNEL);
+	if (ctx->id < 0) {
+		ret = ctx->id;
+		goto err_unlock_mutex;
+	}
+
 	ctx->mdp_dev = mdp;
 
 	v4l2_fh_init(&ctx->fh, vdev);
@@ -617,6 +622,8 @@ static int mdp_m2m_open(struct file *file)
 	v4l2_fh_del(&ctx->fh);
 err_exit_fh:
 	v4l2_fh_exit(&ctx->fh);
+	ida_free(&mdp->mdp_ida, ctx->id);
+err_unlock_mutext:
 	mutex_unlock(&mdp->m2m_lock);
 err_free_ctx:
 	kfree(ctx);
-- 
2.25.1

