Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799105EB9FC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 07:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiI0FsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 01:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiI0FsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 01:48:18 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19077CB6A;
        Mon, 26 Sep 2022 22:48:17 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fs14so8246996pjb.5;
        Mon, 26 Sep 2022 22:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=7J08lJx+XncUAcnTIUuRjmZ5LZ59+jI5T4gbCu+R9no=;
        b=SAp7Mv46u2dFHrnVeh7EMtbdEsrvHEI1UQ61XLVWwiHnvxnQYNkovLl+wl9IkYK59Q
         6+CPWUVJq8wPXDTatTRwyWygmy6QLMFXcCVi8PLXIBzLH4Af+X04biLzRhkWsVy/e3FQ
         vZdQ7g4HHeO/Re6XPyaZLU5eZGIoRlpcfKHIKDh8rWLgwCIgJBP1Z2gjZQvWHLJJS+zg
         VsORcznJbDVfvYPG6tgK1RyvM6pEbdepvs0rd+9kjz3RSsO31u9RkGmAd429D+J+DHxD
         eSQLiLFL9FfN7nlGkM0NKv0RP2b2iB96XMzTUtQrgEddSpAcg5km4NtQUHeBzMAXnJkb
         xebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7J08lJx+XncUAcnTIUuRjmZ5LZ59+jI5T4gbCu+R9no=;
        b=gWo5hMHt8O0WJMEg8/LnW0WGjr0YUccq9X66sIBsxWfsvS5LyippMeaVir2Gs1kDyo
         IFRAimvYK4eB6DtHDej/rzJ33l3iIsIbhszPdHy9Lm7pQ8wF/sM7B1vvLXTO1FW71wLV
         7I0NNLzjSC31LgvGXlcTHakRwyduk1UccmjTo7NB+Yjcm2a/cz+3bz13Fjs3DzSaTKvC
         htK2Ko49rMLDb5734XpS7d44nLTWk2UcrMsl9tJL9zHTIYlm8u3Inj8RKYe68eEsN6Qy
         tjdWwKvtIczTJJiucW8zFO8zGfDCHDIuruFncc3iCaM9tl5UxOXTFRlyofsrHt4ZQ9Rz
         4LRg==
X-Gm-Message-State: ACrzQf15vPY9RTp5tttReWF/6ET7/ff9tdbZxr3Sielwb2Ajcgt5juwU
        g0akFPy8PXiTiR5XUyBzstkNjTJXoc3+yHvX37clLg==
X-Google-Smtp-Source: AMsMyM7EAxzbtn39KWWsoLEV9NRezEfCnq0IfiGNQQi8abh1gCkBF8yzRQ2j5/LPv2Z+7XqOcjnPlQ==
X-Received: by 2002:a17:90b:4a50:b0:203:1204:5bc4 with SMTP id lb16-20020a17090b4a5000b0020312045bc4mr2681816pjb.79.1664257697163;
        Mon, 26 Sep 2022 22:48:17 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m12-20020a633f0c000000b0043bf861008fsm514647pga.90.2022.09.26.22.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 22:48:16 -0700 (PDT)
From:   zhangsongyi.cegl@gmail.com
X-Google-Original-From: zhang.songyi@zte.com.cn
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhang songyi <zhang.songyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] scsi: pmcraid: Convert to use sysfs_emit() APIs
Date:   Tue, 27 Sep 2022 05:48:08 +0000
Message-Id: <20220927054808.256965-1-zhang.songyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhang songyi <zhang.songyi@zte.com.cn>

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the value
to be returned to user space.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 drivers/scsi/pmcraid.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 836ddc476764..057d6172d643 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -3493,7 +3493,7 @@ static ssize_t pmcraid_show_log_level(
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct pmcraid_instance *pinstance =
 		(struct pmcraid_instance *)shost->hostdata;
-	return snprintf(buf, PAGE_SIZE, "%d\n", pinstance->current_log_level);
+	return sysfs_emit(buf, "%d\n", pinstance->current_log_level);
 }
 
 /**
@@ -3554,7 +3554,7 @@ static ssize_t pmcraid_show_drv_version(
 	char *buf
 )
 {
-	return snprintf(buf, PAGE_SIZE, "version: %s\n",
+	return sysfs_emit(buf, "version: %s\n",
 			PMCRAID_DRIVER_VERSION);
 }
 
@@ -3588,7 +3588,7 @@ static ssize_t pmcraid_show_adapter_id(
 		pinstance->pdev->devfn;
 	u32 aen_group = pmcraid_event_family.id;
 
-	return snprintf(buf, PAGE_SIZE,
+	return sysfs_emit(buf,
 			"adapter id: %d\nminor: %d\naen group: %d\n",
 			adapter_id, MINOR(pinstance->cdev.dev), aen_group);
 }
-- 
2.25.1


