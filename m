Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0292B6AE4FE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjCGPhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjCGPh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:37:29 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43EC78093C;
        Tue,  7 Mar 2023 07:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=iL0BA
        0gE4EmKLeYtSSOEBUD0N390Hz2s7HW1XrquUFw=; b=BoNuXBr1Y5eer5pvkhVcA
        LBwFwIfMzogGFEbGCTI3atjdmrC+c8i6c9Tg3NtyRAn03LR/7oYbEcqQmu9OTR1a
        y/gwPpVN+o065CVRdYkm63SH66BpRDmFFzYAbKIY5oFKM036X4cZ8apvSf5rG2KP
        G5xpPkfbuL5wCD1RUNi/t0=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wD3LifPWQdkZzrLCQ--.14702S2;
        Tue, 07 Mar 2023 23:35:43 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     ezequiel@vanguardiasur.com.ar
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] media: hantro: fix use after free bug in hantro_release due to race condition
Date:   Tue,  7 Mar 2023 23:35:42 +0800
Message-Id: <20230307153542.1178065-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3LifPWQdkZzrLCQ--.14702S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wry3Xw4kJw47Jr4rWr4kZwb_yoW8GF13pF
        W7GrW7CrWjqF42gFnrJw409ayrCa4YgFW3Wrsru343AF9xtrnrGrW0y3W8AF9rtrZ3ZF45
        XF48KrWrX39FvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi-eOJUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXBErU1Xl52W07wAAsc
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hantro_probe, vpu->watchdog_work is bound with
hantro_watchdog. Then hantro_end_prepare_run may
be called to start the work.

If we close the file or remove the module which will
call hantro_release and hantro_remove to make cleanup,
there may be a unfinished work. The possible sequence
is as follows, which will cause a typical UAF bug.

The same thing will happen in hantro_release, and use
ctx after freeing it.

Fix it by canceling the work before cleanup in hantro_release.

CPU0                  CPU1

                    |hantro_watchdog
hantro_remove     |
  v4l2_m2m_release  |
    kfree(m2m_dev); |
                    |
                    | v4l2_m2m_get_curr_priv
                    |   m2m_dev->curr_ctx //use

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index b0aeedae7b65..cf00ccaa7829 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -601,6 +601,7 @@ static int hantro_release(struct file *filp)
 	 * No need for extra locking because this was the last reference
 	 * to this file.
 	 */
+	cancel_delayed_work(&vpu->watchdog_work);
 	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
 	v4l2_fh_del(&ctx->fh);
 	v4l2_fh_exit(&ctx->fh);
-- 
2.25.1

