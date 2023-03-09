Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069286B1D55
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCIIH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCIIHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:07:52 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1893560AA6;
        Thu,  9 Mar 2023 00:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GBhsZ
        n4FOlfbUQ/o+x7Y5z0f+XdjB+IJXqUnC3AEJ0c=; b=kDXK5W+/uqDgszSXdY2Bv
        uHFmyJKBAZ0nZtmCUha6dUUxl+7OI6y5VNllmhatkvWE5MT2X3f/r7/wxnktP09h
        LJD1IlXf3Qjlfc4/LzQsiAUj1GIi7b8YChd58v+BjfRX4jArxTtBo/KGKCivjxEG
        GGDwiCe+oay8DHYn7p8NPY=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wAXH1_NkwlkiA3MCg--.23314S2;
        Thu, 09 Mar 2023 16:07:41 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work
Date:   Thu,  9 Mar 2023 16:07:39 +0800
Message-Id: <20230309080739.3714610-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXH1_NkwlkiA3MCg--.23314S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurW3trWkGFy3uw4DAryUAwb_yoW3Cwb_ua
        48ZryxCFWUGF1IyF15KF4rZrW8Kw1rXws2qFnaqF93X3sruFsFg34jvrZ8Jw1xWr1UtF9x
        Aw4fXayrJr48XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRK9NVJUUUUU==
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiGhYtU1aEEgvXMQABse
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In btsdio_probe, &data->work was bound with btsdio_work.In
btsdio_send_frame, it was started by schedule_work.

If we call btsdio_remove with an unfinished job, there may
be a race condition and cause UAF bug on hdev.

Fixes: ddbaf13e3609 ("[Bluetooth] Add generic driver for Bluetooth SDIO devices")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/bluetooth/btsdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 795be33f2892..02893600db39 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -354,6 +354,7 @@ static void btsdio_remove(struct sdio_func *func)
 
 	BT_DBG("func %p", func);
 
+	cancel_work_sync(&data->work);
 	if (!data)
 		return;
 
-- 
2.25.1

