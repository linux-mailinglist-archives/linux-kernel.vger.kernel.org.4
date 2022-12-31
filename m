Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA7765A2FE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 07:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiLaGsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 01:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiLaGsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 01:48:01 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C19E62E8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 22:48:00 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id ge16so20751985pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 22:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kb9J7dPaRynZPu5+c9xlMF5tdxQzDyaE+gemfbwmSQY=;
        b=bqF8TvBxfkdv5GZOn0eWPHscG3Ro5Y4OAhNIOI6YAvwDjaI1ZoYcPR8tc7u09vO8wm
         zLN/pZ/okC0e1ZTitMcp8TTo8dwpzbXjAYfkj3NJHINSv0wByf5TfwvZt4kn0tDI2H52
         xXcFguxIpvCGCQ9jUJwglQXbfltZVKqUS4w/EelwCr9PYRle8niZbf1v/y5tfGQpsePP
         vTBf70dTK/ffjRt2jtjD4wrg5kCvMJ0SBa1BcVMPtWuRmlkFzv7oqzws6Hdy1j6d9wnN
         UPyD4kxSIVS7Nsao7c3h2nsvzQy4PKSjtQWW/O2MGZGFkWpYC++Ouha7nquWBYz7sv/T
         jMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kb9J7dPaRynZPu5+c9xlMF5tdxQzDyaE+gemfbwmSQY=;
        b=Q3SGehaL9/9BpySeRb+tkJR0PFLGqqzLlnHmWTvgt4KHYMGeVdgqyCsCUFkJvl64HZ
         gIdrtQlpLPt6UYKu2ZmlMiPJJdyalvlTTI2gFDGuVUSHGN8O/2R1hIn4EzLaB0GM2O9Z
         OuokOWnrRg8/JBv5h+BtpRdDBx2EwIyPO0CFNszXkPAiTFPo4CTSQCEr7tTzEJqfYcWP
         zhcCTu6GcyrppIhDe66/QY/Vbt3FLaAehRAxe4I3YZ8aJ45v8Ji540yjCAtzUMUijTTM
         herHRVV6hgS7fvJDLJKJVhl3WYyXeoGXI0AVO1qnidjaw/+496PNexW3mwTIM6mITx2V
         +oLQ==
X-Gm-Message-State: AFqh2kr/ttr11TsScCIuyxPIEDsRG65dlSOd9p0Uw+miS4Xvp9PQBTfR
        HOfzssfEqGPy1QVvF4TYiwbTmTYciAVc+g==
X-Google-Smtp-Source: AMrXdXtt9y+30QLp6+vjuMD3Wsz7naGUqYulcZcnfCVcqONLYK7faeglVa+v4rtffzaakdbewmAeMg==
X-Received: by 2002:a05:6a20:9596:b0:a3:ca9a:ff82 with SMTP id iu22-20020a056a20959600b000a3ca9aff82mr41204077pzb.61.1672469279632;
        Fri, 30 Dec 2022 22:47:59 -0800 (PST)
Received: from localhost.localdomain (kayle.snu.ac.kr. [147.46.126.79])
        by smtp.gmail.com with ESMTPSA id b19-20020a17090a489300b00218bedf8739sm14033207pjh.17.2022.12.30.22.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 22:47:59 -0800 (PST)
From:   Yoochan Lee <yoochan1026@gmail.com>
To:     axboe@kernel.dk
Cc:     hare@suse.de, linux-kernel@vger.kernel.org,
        Yoochan Lee <yoochan1026@gmail.com>
Subject: [PATCH] cdrom: gdrom: Fix use-after-free in gdrom_open()
Date:   Sat, 31 Dec 2022 15:47:54 +0900
Message-Id: <20221231064754.2044518-1-yoochan1026@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A race condition may occur if the user physically removes the
gdrom device while calling open().

This is a race condition between gdrom_preparedisk_cmd() function and
the remove_gdrom() function, which may lead to Use-After-Free.

Therefore, add a refcount check to remove_gdrom() function
to free the "gdrom_unit" structure after the device is close()d.

---------------CPU 0--------------------CPU 1-----------------
         gdrom_open()         |      remove_gdrom()
   gdrom_preparedisk_cmd()    |
--------------------------------------------------------------
                              |     kfree(gd.cd_info); — (1)
gdrom_packetcommand(          |
gd.cd_info,                   |
spin_command); — (2)          |

Signed-off-by: Yoochan Lee <yoochan1026@gmail.com>
---
 drivers/cdrom/gdrom.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index ceded5772aac..f392370a16a3 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -102,6 +102,7 @@ static struct gdrom_unit {
 	struct gdromtoc *toc;
 	struct request_queue *gdrom_rq;
 	struct blk_mq_tag_set tag_set;
+	struct kref refcnt;
 } gd;
 
 struct gdrom_id {
@@ -120,6 +121,19 @@ static int gdrom_packetcommand(struct cdrom_device_info *cd_info,
 	struct packet_command *command);
 static int gdrom_hardreset(struct cdrom_device_info *cd_info);
 
+static void delete_gdrom(struct kref *kref)
+{
+	blk_mq_free_tag_set(&gd.tag_set);
+	free_irq(HW_EVENT_GDROM_CMD, &gd);
+	free_irq(HW_EVENT_GDROM_DMA, &gd);
+	del_gendisk(gd.disk);
+	if (gdrom_major)
+		unregister_blkdev(gdrom_major, GDROM_DEV_NAME);
+	unregister_cdrom(gd.cd_info);
+	kfree(gd.cd_info);
+	kfree(gd.toc);
+}
+
 static bool gdrom_is_busy(void)
 {
 	return (__raw_readb(GDROM_ALTSTATUS_REG) & 0x80) != 0;
@@ -353,6 +367,7 @@ static int gdrom_get_last_session(struct cdrom_device_info *cd_info,
 
 static int gdrom_open(struct cdrom_device_info *cd_info, int purpose)
 {
+	kref_get(&gd.refcnt);
 	/* spin up the disk */
 	return gdrom_preparedisk_cmd();
 }
@@ -360,6 +375,7 @@ static int gdrom_open(struct cdrom_device_info *cd_info, int purpose)
 /* this function is required even if empty */
 static void gdrom_release(struct cdrom_device_info *cd_info)
 {
+	kref_put(&gd.refcnt, delete_gdrom);
 }
 
 static int gdrom_drivestatus(struct cdrom_device_info *cd_info, int ignore)
@@ -808,7 +824,7 @@ static int probe_gdrom(struct platform_device *devptr)
 	err = add_disk(gd.disk);
 	if (err)
 		goto probe_fail_add_disk;
-
+	kref_init(&gd.refcnt);
 	return 0;
 
 probe_fail_add_disk:
@@ -831,16 +847,7 @@ static int probe_gdrom(struct platform_device *devptr)
 
 static int remove_gdrom(struct platform_device *devptr)
 {
-	blk_mq_free_tag_set(&gd.tag_set);
-	free_irq(HW_EVENT_GDROM_CMD, &gd);
-	free_irq(HW_EVENT_GDROM_DMA, &gd);
-	del_gendisk(gd.disk);
-	if (gdrom_major)
-		unregister_blkdev(gdrom_major, GDROM_DEV_NAME);
-	unregister_cdrom(gd.cd_info);
-	kfree(gd.cd_info);
-	kfree(gd.toc);
-
+	kref_put(&gd.refcnt, delete_gdrom);
 	return 0;
 }
 
-- 
2.39.0

