Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACDA6AB64F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 07:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjCFG2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 01:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCFG2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 01:28:12 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FD90A5C4;
        Sun,  5 Mar 2023 22:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=y+5KY
        JiUtormz/jrT3bvfPhN0fTpLqDXBrS1X7+kgf8=; b=QRs+RFmtFj29262cuJfm3
        qnUZvbSvRH5p6riP5bN+xrPl5/Efefk8ywOtw3yP/shz+JFzx8TE0l5IMN0biQWP
        nZ0/AsSiiMaWawwXCZA5n+Rnl/rsVmZf9/O3Jp1DaBa85YLdVaa7MBHtWcEBLg51
        drWq+xyBTDn5UEEEL2ADkA=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wBHf_OahwVk540ZCQ--.40472S2;
        Mon, 06 Mar 2023 14:26:34 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     mchehab@kernel.org
Cc:     bin.liu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [RESEND PATCH] media: mtk-jpeg: Fix use after free bug due to uncanceled work
Date:   Mon,  6 Mar 2023 14:26:33 +0800
Message-Id: <20230306062633.200427-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHf_OahwVk540ZCQ--.40472S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF17uw15Jr4xtw4xCFy7trb_yoW8Xry7pr
        ZxK3yDCrWUWrs0qr1UJ3WUAF1rCw1rKa1xWr17uw4Iv3y3Jrs7JryFya48tFWIyF92k3Wr
        Jr10q3s7GrWDZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi-6pkUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBzgIqU2I0Xi19SAAAsl
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
and mtk_jpeg_enc_device_run may be called to start the
work.
If we remove the module which will call mtk_jpeg_remove
to make cleanup, there may be a unfinished work. The
possible sequence is as follows, which will cause a
typical UAF bug.

Fix it by canceling the work before cleanup in the mtk_jpeg_remove

CPU0                  CPU1

                    |mtk_jpeg_job_timeout_work
mtk_jpeg_remove     |
  v4l2_m2m_release  |
    kfree(m2m_dev); |
                    |
                    | v4l2_m2m_get_curr_priv
                    |   m2m_dev->curr_ctx //use

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 969516a940ba..364513e7897e 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1793,7 +1793,7 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
 static int mtk_jpeg_remove(struct platform_device *pdev)
 {
 	struct mtk_jpeg_dev *jpeg = platform_get_drvdata(pdev);
-
+	cancel_delayed_work(&jpeg->job_timeout_work);
 	pm_runtime_disable(&pdev->dev);
 	video_unregister_device(jpeg->vdev);
 	v4l2_m2m_release(jpeg->m2m_dev);
-- 
2.25.1

