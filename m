Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443666BF913
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCRIvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCRIvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:51:06 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FA3738B71;
        Sat, 18 Mar 2023 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=e2K1s
        tAkZBMfErG++SlUbeC1nvxtK/csvq7dYD3khQM=; b=Hxi1LaVS7kkXBX976oXwz
        lsAa8grThqsAxqUd4OYG2nAnEsrz6Ls380AAlXWuiXQ3W9nD1hDa+FboyhjxEyFv
        jp2iXh+Wdn+hXuuMHxfw5dyO1BYtIDbZ7GCmx0gng0XfZBlTD60itjQL4aI9QeeY
        aKKdJUaH3sG0pES1qQeoBk=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wBnb8dQexVkv0urAQ--.15549S2;
        Sat, 18 Mar 2023 16:50:25 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     mchehab@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, tasos@tasossah.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] media: saa7134: fix use after free bug in saa7134_finidev  due to race condition
Date:   Sat, 18 Mar 2023 16:50:23 +0800
Message-Id: <20230318085023.832510-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBnb8dQexVkv0urAQ--.15549S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFy5Zr1xAw4fWrW5Aw4fKrg_yoW5GF4DpF
        WUtF93Aw1UJr4UJa1xXa1UCFySgrZ5XFy3Wasru34Fgr15Gay8Jr1Yq34UKF9xJrsrZa43
        Kr18urnrJrykuaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziaiiDUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiGhc2U1aEEnbMxwAAsV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In saa7134_initdev, it will call saa7134_hwinit1. There are three
function invoking here: saa7134_video_init1, saa7134_ts_init1 
and saa7134_vbi_init1.

All of them will init a timer with same function. Take 
saa7134_video_init1 as an example. It'll bound &dev->video_q.timeout
with saa7134_buffer_timeout.

In buffer_activate, the timer funtcion is started.

If we remove the module or device which will call saa7134_finidev
to make cleanup, there may be a unfinished work. The
possible sequence is as follows, which will cause a
typical UAF bug.

Fix it by canceling the timer works accordingly before cleanup in 
saa7134_finidev.

CPU0                  CPU1

                    |saa7134_buffer_timeout
saa7134_finidev     |
  kfree(dev);       |
                    |
                    | saa7134_buffer_next
                    | //use dev

Fixes: 1e7126b4a86a ("media: saa7134: Convert timers to use timer_setup()")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/media/pci/saa7134/saa7134-ts.c    | 1 +
 drivers/media/pci/saa7134/saa7134-vbi.c   | 1 +
 drivers/media/pci/saa7134/saa7134-video.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/media/pci/saa7134/saa7134-ts.c b/drivers/media/pci/saa7134/saa7134-ts.c
index 6a5053126237..437dbe5e75e2 100644
--- a/drivers/media/pci/saa7134/saa7134-ts.c
+++ b/drivers/media/pci/saa7134/saa7134-ts.c
@@ -300,6 +300,7 @@ int saa7134_ts_start(struct saa7134_dev *dev)
 
 int saa7134_ts_fini(struct saa7134_dev *dev)
 {
+	del_timer_sync(&dev->ts_q.timeout);
 	saa7134_pgtable_free(dev->pci, &dev->ts_q.pt);
 	return 0;
 }
diff --git a/drivers/media/pci/saa7134/saa7134-vbi.c b/drivers/media/pci/saa7134/saa7134-vbi.c
index 3f0b0933eed6..3e773690468b 100644
--- a/drivers/media/pci/saa7134/saa7134-vbi.c
+++ b/drivers/media/pci/saa7134/saa7134-vbi.c
@@ -185,6 +185,7 @@ int saa7134_vbi_init1(struct saa7134_dev *dev)
 int saa7134_vbi_fini(struct saa7134_dev *dev)
 {
 	/* nothing */
+	del_timer_sync(&dev->vbi_q.timeout);
 	return 0;
 }
 
diff --git a/drivers/media/pci/saa7134/saa7134-video.c b/drivers/media/pci/saa7134/saa7134-video.c
index 4d8974c9fcc9..29124756a62b 100644
--- a/drivers/media/pci/saa7134/saa7134-video.c
+++ b/drivers/media/pci/saa7134/saa7134-video.c
@@ -2146,6 +2146,7 @@ int saa7134_video_init1(struct saa7134_dev *dev)
 
 void saa7134_video_fini(struct saa7134_dev *dev)
 {
+	del_timer_sync(&dev->video_q.timeout);
 	/* free stuff */
 	saa7134_pgtable_free(dev->pci, &dev->video_q.pt);
 	saa7134_pgtable_free(dev->pci, &dev->vbi_q.pt);
-- 
2.25.1

