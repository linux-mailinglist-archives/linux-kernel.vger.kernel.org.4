Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7432B6B7DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCMQnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCMQn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:43:28 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BB7E1ADCB;
        Mon, 13 Mar 2023 09:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=39Xf9
        ZCAokng5zx5EHKJyi5I1FpmWCObH+80VGR+3Fc=; b=LL9L3M7H5q7z1LfesmT5d
        Jndz0co5jyxSDfOI+ndvIM/i6L40TEpdFpRsSjU8ejx8cwNGjWBhThLin4sWgGm3
        1WWO/gQcro/fPCU/u3xDhdlykezjStMlT5r4b6+X+IxgMi+MTyv+0Iro70ipT8NM
        7OkpwqCRIGd97RIVoFlBdo=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g3-0 (Coremail) with SMTP id _____wDn7yNtUg9kfkYUAA--.18807S2;
        Tue, 14 Mar 2023 00:42:21 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     ezequiel@vanguardiasur.com.ar
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v2] media: rkvdec: fix use after free bug in rkvdec_remove
Date:   Tue, 14 Mar 2023 00:42:20 +0800
Message-Id: <20230313164220.3753961-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDn7yNtUg9kfkYUAA--.18807S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4kWFWrZF4rKr45ury8Krg_yoW8Gw4Upr
        W3ta45Cay5JF4UKFnrtr4xZa4rGryUKFykKr9rXa43ZryfJFnrJ3sYyF1UCFWxXrZ3Z3y3
        CFyYqw1rXw4qyrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziID73UUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXA8xU1Xl56P-uQAAsD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rkvdec_probe, rkvdec->watchdog_work is bound with
rkvdec_watchdog_func. Then rkvdec_vp9_run may
be called to start the work.

If we remove the module which will call rkvdec_remove
 to make cleanup, there may be a unfinished work.
 The possible sequence is as follows, which will
 cause a typical UAF bug.

Fix it by canceling the work before cleanup in rkvdec_remove.

CPU0                  CPU1

                    |rkvdec_watchdog_func
rkvdec_remove       |
 rkvdec_v4l2_cleanup|
  v4l2_m2m_release  |
    kfree(m2m_dev); |
                    |
                    | v4l2_m2m_get_curr_priv
                    |   m2m_dev->curr_ctx //use

Fixes: cd33c830448b ("media: rkvdec: Add the rkvdec driver")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
v2:
- use cancel_delayed_work_sync instead of cancel_delayed_work suggested Hans Verkuil
---
 drivers/staging/media/rkvdec/rkvdec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 7bab7586918c..82806f198074 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -1066,6 +1066,8 @@ static int rkvdec_remove(struct platform_device *pdev)
 {
 	struct rkvdec_dev *rkvdec = platform_get_drvdata(pdev);
 
+	cancel_delayed_work_sync(&rkvdec->watchdog_work);
+
 	rkvdec_v4l2_cleanup(rkvdec);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.25.1

