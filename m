Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EFD7187AD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjEaQor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 12:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEaQop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA52512C
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685551438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lgJIynadENNI5JgTITr0Ybs6dLu+mfBH2z5xrDQ5GuE=;
        b=VP9M1XVA7o75uASbyp/rD+SxfhqSeQtUPFHTjCXtMHn8WiV83N6+unueuYq+YUoZMV4217
        R2D94xU6FygmGLoeaa+mrSKFb6U2Z24xR6HVAHYA6YgFhgFt7t5rpYtoRNed9aSMa0Bh+h
        UPa+NIONFP+8VSkoheCSG6ICursh6kA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-g35xBTJyM4uG0YSLv_CZbA-1; Wed, 31 May 2023 12:43:57 -0400
X-MC-Unique: g35xBTJyM4uG0YSLv_CZbA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-53ba38cf091so699338a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685551436; x=1688143436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgJIynadENNI5JgTITr0Ybs6dLu+mfBH2z5xrDQ5GuE=;
        b=ihmUXwj1UYG8D1gL/KCSLVFKQfI35bnFAo5Jo97HwclV0iV65Yf8+eGunAVfQ3mT8B
         2FifRVBA3lLKty0bRlqq1S39q4xXF52rYXKa2asCaqBi926cQTUy7GFYQyY7zEZxElJ3
         zcfKOkMTBkcKPH+jWaD2AEnQP5rMsnvYR46cl3k+HjlrxOulKkPXCMQ5N0XNBcyt0KOO
         ZX3tRdDQLXiQW7tgM5cRbg1OnsyAEGIY0TDzhaLwsxWBXanLeY2RB4JqE94IxGuI9sJp
         nwQthPX0cP0GfclVUAds9Yji5aE1WpwKAHoAnQRm1UYZZ9yNmWMUoTqZVmnO9vVwhv+v
         YmiA==
X-Gm-Message-State: AC+VfDwTDJfOFMZwCZEv6+VRJy/76mQ2ymO4D+pp1/qqA6wtpuc8Wbng
        qGSa7f6Ji8FzYXuBnKlw/U32g7nhQOULBfhShVJe/zvjb7SjPSJvVb8X+Ip7+Qr3nToDnqwPW25
        dUmhrid9C6vdWiZYxlWAzz5TqRwmQsASr
X-Received: by 2002:a17:903:1d0:b0:1ae:6947:e63b with SMTP id e16-20020a17090301d000b001ae6947e63bmr6467056plh.16.1685551436508;
        Wed, 31 May 2023 09:43:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7E8PuLFTLBPGRmNCPh/iK1sSxImI98JXVOJn/SUh70PxBGeJVa7PyQkqWJAjeXQSFddH31tQ==
X-Received: by 2002:a17:903:1d0:b0:1ae:6947:e63b with SMTP id e16-20020a17090301d000b001ae6947e63bmr6467038plh.16.1685551436129;
        Wed, 31 May 2023 09:43:56 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:c0d:9f00:ca6:1aff:fead:cef4])
        by smtp.gmail.com with ESMTPSA id ik8-20020a170902ab0800b001ae0152d280sm1608192plb.193.2023.05.31.09.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 09:43:55 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH] scsi: sr: Fix a potential uninit-value in sr_get_events()
Date:   Thu,  1 Jun 2023 01:43:46 +0900
Message-Id: <20230531164346.118438-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN found the following issue:

 BUG: KMSAN: uninit-value in sr_check_events+0x365/0x1460
  sr_check_events+0x365/0x1460
  cdrom_check_events+0x66/0x170
  sr_block_check_events+0xf2/0x130
  disk_check_events+0xec/0x900
  bdev_check_media_change+0x2a6/0x7d0
  sr_block_open+0x154/0x320
  blkdev_get_whole+0xa8/0x6c0
  blkdev_get_by_dev+0x50f/0x1200
  blkdev_open+0x215/0x430
  do_dentry_open+0xfbd/0x19a0
  vfs_open+0x7b/0xa0
  path_openat+0x4a54/0x5b40
  do_filp_open+0x24d/0x660
  do_sys_openat2+0x1f0/0x910
  __x64_sys_openat+0x2b4/0x330
  do_syscall_64+0x41/0xc0
  entry_SYSCALL_64_after_hwframe+0x63/0xcd

 Local variable sshdr.i created at:
  sr_check_events+0x131/0x1460
  cdrom_check_events+0x66/0x170

sr_get_events() can access uninitialized local variable sshdr when
scsi_execute_cmd() returns error.  This patch fixes the issue by
checking the result before accessing sshdr.

Fixes: 93aae17af117 ("sr: implement sr_check_events()")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 drivers/scsi/sr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 12869e6d4ebd..86b43c069a44 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -177,10 +177,13 @@ static unsigned int sr_get_events(struct scsi_device *sdev)
 
 	result = scsi_execute_cmd(sdev, cmd, REQ_OP_DRV_IN, buf, sizeof(buf),
 				  SR_TIMEOUT, MAX_RETRIES, &exec_args);
+	if (result)
+		return 0;
+
 	if (scsi_sense_valid(&sshdr) && sshdr.sense_key == UNIT_ATTENTION)
 		return DISK_EVENT_MEDIA_CHANGE;
 
-	if (result || be16_to_cpu(eh->data_len) < sizeof(*med))
+	if (be16_to_cpu(eh->data_len) < sizeof(*med))
 		return 0;
 
 	if (eh->nea || eh->notification_class != 0x4)
-- 
2.39.0

