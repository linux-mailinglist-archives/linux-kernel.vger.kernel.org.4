Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279486B7C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjCMPmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCMPmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:42:08 -0400
Received: from m12.mail.163.com (m12.mail.163.com [123.126.96.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5057D53724;
        Mon, 13 Mar 2023 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=NMeHq
        c9vEtUERKAOCOKjGmVkf5YkMepOMEfhtaswEhc=; b=em7N6x0m+8FcZgIVUSuhU
        HnWkEZhrTFz+w29FDBYiesKxWe2N5jlOOVn09DuSUMytcqnF4H1qqS7iWTZ5evNM
        OwyRpJDpK7FBbt97Eu24mZFq9vEpchwN3RErZboGOkViLFU8wIG1YCIW6ydh/G1E
        YBdeRU+aC1FoaJB0JglJ9M=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by smtp19 (Coremail) with SMTP id R9xpCgD3_rItRA9kgCPoHQ--.36544S2;
        Mon, 13 Mar 2023 23:41:33 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     ezequiel@vanguardiasur.com.ar
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        hverkuil@xs4all.nl, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v3] media: hantro: fix use after free bug in hantro_remove  due to race condition
Date:   Mon, 13 Mar 2023 23:41:32 +0800
Message-Id: <20230313154132.3684181-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: R9xpCgD3_rItRA9kgCPoHQ--.36544S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wry3Xw4kJw47Jr4rWr4kZwb_yoW8Cw1DpF
        W3G3y5KrWjqr47KFn7tay09ayfCasFqF4jgrZruw13JF9xtr9rurySyF48AF98JrZ3ZF4a
        vF4jqrW8Z3y2vFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziaZXrUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBzgsxU2I0XntM5AADs-
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
there may be an unfinished work. The possible sequence
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
v3:
- use cancel_delayed_work_sync instead of cancel_delayed_work and add it to
hantro_release suggested by Hans Verkuil

v2:
- move the cancel-work-related code to hantro_remove suggested by Hans Verkuil
---
 drivers/media/platform/verisilicon/hantro_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index b0aeedae7b65..86a4c0fa8c7d 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -597,6 +597,7 @@ static int hantro_release(struct file *filp)
 	struct hantro_ctx *ctx =
 		container_of(filp->private_data, struct hantro_ctx, fh);
 
+	cancel_delayed_work_sync(&ctx->dev->watchdog_work);
 	/*
 	 * No need for extra locking because this was the last reference
 	 * to this file.
@@ -1099,6 +1100,7 @@ static int hantro_remove(struct platform_device *pdev)
 
 	v4l2_info(&vpu->v4l2_dev, "Removing %s\n", pdev->name);
 
+	cancel_delayed_work_sync(&vpu->watchdog_work);
 	media_device_unregister(&vpu->mdev);
 	hantro_remove_dec_func(vpu);
 	hantro_remove_enc_func(vpu);
-- 
2.25.1

