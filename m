Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F156AE5BD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjCGQCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjCGQBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:01:34 -0500
Received: from m12.mail.163.com (m12.mail.163.com [123.126.96.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F29B897B4A;
        Tue,  7 Mar 2023 07:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sUgc1
        Ip6cph68cI1VgRBJ11BMagx1vc6BYllZnRAv3w=; b=WyvczoL1xuThhrxy0sLmV
        ggpzJmFx998EVhMmDw2cJPLllv24/k9rLP7GuUMxht55hhronISquD/Y8c6it3Rg
        SKBPLmkQ8XE4ETluHitderHr0BXJ3wTO4y6pJq7tFS/KWvYZDGhn3VXlAfdwX521
        UQGOFWcpxw5ptqZeV4vQDU=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by smtp20 (Coremail) with SMTP id H91pCgDnsbZHWwdkkSMIGw--.40718S2;
        Tue, 07 Mar 2023 23:41:59 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     ezequiel@vanguardiasur.com.ar
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] media: hantro: fix use after free bug in hantro_remove due to race condition
Date:   Tue,  7 Mar 2023 23:41:57 +0800
Message-Id: <20230307154157.1184826-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: H91pCgDnsbZHWwdkkSMIGw--.40718S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wry3Xw4kJw47Jr4rWr4kZwb_yoW8GF4rpF
        W7trW3CrWjqr42gFn7Jw409ayrCa4agF4xWrZruw13AF9xtr9rGry0y3W8AF98JrZ3ZFWa
        qF48Kr48X3y2vFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziID73UUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXBErU1Xl52W08AABsC
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index b0aeedae7b65..80bd856a4da9 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -1099,6 +1099,7 @@ static int hantro_remove(struct platform_device *pdev)
 
 	v4l2_info(&vpu->v4l2_dev, "Removing %s\n", pdev->name);
 
+	cancel_delayed_work(&vpu->watchdog_work);
 	media_device_unregister(&vpu->mdev);
 	hantro_remove_dec_func(vpu);
 	hantro_remove_enc_func(vpu);
-- 
2.25.1

