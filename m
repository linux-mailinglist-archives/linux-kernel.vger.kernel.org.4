Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D0A6B7BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjCMPUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCMPUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:20:50 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4A996A9CB;
        Mon, 13 Mar 2023 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=jjdVo
        n27HVaeWyXFa+2Rsj/EZI2JFX24oQ2Zjq7vPjQ=; b=eP3bEBdNCsNCFPY0XLrSk
        IHGlJn6GKeRmGFcPM1H1IcOmUYhCT5qoNUeBX0DuNRsESKyAGmG/v1cY3w/lwVBv
        BMN/e0tRqW0l3V+QbLmmgMK+J4OfUgih+VyadGKl4X99Dpw1ExZCIp4O019Op48U
        gn8aocpBtm2Sk8umT0bhIs=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wBnXnLvPg9kF8INAA--.4430S2;
        Mon, 13 Mar 2023 23:19:12 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     ezequiel@vanguardiasur.com.ar
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        hverkuil@xs4all.nl, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v2] media: hantro: fix use after free bug in hantro_remove  due to race condition
Date:   Mon, 13 Mar 2023 23:19:09 +0800
Message-Id: <20230313151909.3658925-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBnXnLvPg9kF8INAA--.4430S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFy5uFWUJrWktw17XrWkWFg_yoW8GrWDpF
        W7KFWakrWjqF47KFn7J3y09ayrCa42gF4xWrZruw13ZF9xtr9rWry0y3WUAas8JrZavFW3
        ZF48Jr4rXay2vFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi-eOJUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiGhQxU1aEEjcWiQAAsE
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

If we remove the module which will call hantro_remove
to make cleanup, there may be an unfinished work.
The possible sequence is as follows, which will
cause a typical UAF bug.

Fix it by canceling the work before cleanup in hantro_remove.

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
v2:
- move the cancel-work-related code to hantro_remove suggested by Hans Verkuil
---
 drivers/media/platform/verisilicon/hantro_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index b0aeedae7b65..496024b21b51 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -1099,6 +1099,7 @@ static int hantro_remove(struct platform_device *pdev)
 
 	v4l2_info(&vpu->v4l2_dev, "Removing %s\n", pdev->name);
 
+	cancel_delayed_work_sync(&vpu->watchdog_work);
 	media_device_unregister(&vpu->mdev);
 	hantro_remove_dec_func(vpu);
 	hantro_remove_enc_func(vpu);
-- 
2.25.1

