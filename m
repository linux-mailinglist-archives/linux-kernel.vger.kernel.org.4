Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3466B74223E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjF2IcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjF2Iay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:30:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230022733
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:30:51 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b7f223994fso3523315ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688027450; x=1690619450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sQtoyriN4YYQEmPoScMjRZhWgO3u3DHPKL9H+7yd4ag=;
        b=bhYiZhEYMXPEQmlagzmx8BkE8mTZrMu9plkEvpagqvFG45XJflWMpwO4WZdRhWgGOb
         m3B84AN3plYpEf36mpfaIZamaiTARQpjp7abLyO6kCjlDdMfOOXh/uPvP0AsffZccxdQ
         SB0GrqNYTWuSvdIY8YVzu4Qb4sttJafkebdkecMCGszD4TQ5FC+R7S3nGZHlCPulr/mp
         QjXK0QKEgCE2laWeLFZl+phSnMRrQF6MP5C9jDSC5wD+BsbDoCTlgNUgbZQpM62eJ0QB
         r1XGwVbjCM/OX46f7gYa8I6yU1SoV0hu2jzDro5hoU8kVa2V0ydGfSGZKhql2aFNIPAw
         Jshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688027450; x=1690619450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQtoyriN4YYQEmPoScMjRZhWgO3u3DHPKL9H+7yd4ag=;
        b=Cw3rdv5cBciTj6kGri0cD+/qtjEh7t8vAS+DEJKoV70LzEDfaWv4zsKSqZ6dwA+Op4
         hjtPCD4s2vnhH5SqUfxaYjJ+HpZ5Eq+4R4S7oBYBrz1WshU4yqRvSJW0Vyh74d+eZcgh
         DVmSMJKIZF56YdqZTyXAhqUGfio34WOk3B8ScmewEGfD9NEofhlIopXyTI2KGwjuWM7t
         1SXLf+cxzX5IJ8W38n7pI5Ty49FWVK/ekKP93FNSPE9gyLujR7xfoebUQRBDuu7zvhBX
         BGkajOiKzJqBt8OG9WSqEsMUqhkk3FJBUQWwzpO6qYuW8dUcUBFhXS4L86H3DAhNmIxG
         ioZQ==
X-Gm-Message-State: ABy/qLYYXsOOtJiSCdDInDEe4rfBvrE2PSfqovteac9ErAxYB/tUGZhk
        PGjNcI7UfZSy/2u0inupCRM=
X-Google-Smtp-Source: APBJJlHMgc0hCPFKyNQNfgbDVxaFS6OSks11zv8bFXQ9kEqtMV8eh276rLldNh4SHiTuXGNCOAUYhw==
X-Received: by 2002:a17:903:451:b0:1b8:4b87:20dc with SMTP id iw17-20020a170903045100b001b84b8720dcmr2620093plb.37.1688027450373;
        Thu, 29 Jun 2023 01:30:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b001a072aedec7sm8728140plg.75.2023.06.29.01.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 01:30:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>,
        Phillip Potter <phil@philpotter.co.uk>,
        Hannes Reinecke <hare@suse.de>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH] cdrom/gdrom: Fix build error
Date:   Thu, 29 Jun 2023 01:30:47 -0700
Message-Id: <20230629083047.3487172-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7ae24fcee992 ("cdrom: remove the unused mode argument to
cdrom_release") was supposed to remove an unused argument from
cdrom_release(). but instead removed a used argument from
cdrom_open(). This results in the following build error.

drivers/cdrom/gdrom.c: In function 'gdrom_bdops_open':
drivers/cdrom/gdrom.c:484:15: error: too few arguments to function 'cdrom_open'

drivers/cdrom/gdrom.c: In function 'gdrom_bdops_release':
drivers/cdrom/gdrom.c:492:35: error: 'mode' undeclared

Fix it up.

Fixes: 7ae24fcee992 ("cdrom: remove the unused mode argument to cdrom_release")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Phillip Potter <phil@philpotter.co.uk>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
My apologies for the noise if this has already been submitted.
If so I didn't find it. Also apologies for the wide distribution,
but the file doesn't seem to have a maintainer and I have no idea
who would/should apply the patch.

 drivers/cdrom/gdrom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 3a46e27479ff..d668b174ace9 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -481,7 +481,7 @@ static int gdrom_bdops_open(struct gendisk *disk, blk_mode_t mode)
 	disk_check_media_change(disk);
 
 	mutex_lock(&gdrom_mutex);
-	ret = cdrom_open(gd.cd_info);
+	ret = cdrom_open(gd.cd_info, mode);
 	mutex_unlock(&gdrom_mutex);
 	return ret;
 }
@@ -489,7 +489,7 @@ static int gdrom_bdops_open(struct gendisk *disk, blk_mode_t mode)
 static void gdrom_bdops_release(struct gendisk *disk)
 {
 	mutex_lock(&gdrom_mutex);
-	cdrom_release(gd.cd_info, mode);
+	cdrom_release(gd.cd_info);
 	mutex_unlock(&gdrom_mutex);
 }
 
-- 
2.39.2

