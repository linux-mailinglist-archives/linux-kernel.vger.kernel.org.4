Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11BF6223A1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 06:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiKIF5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 00:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiKIF5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 00:57:09 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3015E1EEFE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 21:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667973417; bh=q5LxJ2lKJ6N/n72Brdpysb7xQ8lsJn/yyuOCTpd/wjI=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=aZX328bEJ7+VoD3Qbz3zEa4BvMAeWz4Xa8c/Rxf0FMWW9fOi4nrTPMWV+J2Fg7iRN
         BpEHKBjCHuBulj02AQxHFLla41eE0xqx6rM9+4G5kYmFzNVvzEhv8DOssetRavkKFQ
         l0NBsbU6hXFUsjRM1JOTpkpVBjEWU+XSr+6gbPYU=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed,  9 Nov 2022 06:56:57 +0100 (CET)
X-EA-Auth: YV79CcZLIeAn9jjsZtRh2oSpwDk5kRO9LG7IYES5/OgiMa4wOBUW99yiN6t5mz0/kjEs5sY2H4luHN189iul5p2wYX63Iouf
Date:   Wed, 9 Nov 2022 11:26:52 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Sven Van Asbroeck <TheSven73@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: fieldbus: replace snprintf in show functions
 with sysfs_emit
Message-ID: <Y2tBJFSsyUzdb+eO@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The show() methods should only use sysfs_emit() when formatting values
to be returned to the user space.
Ref: Documentation/filesystems/sysfs.rst
Issue identified by coccicheck.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v2:
   1. Switch to using sysfs_emit instead of scnprintf
   2. Update patch subject and log accordingly
      Feedback from gregkh@linuxfoundation.org


 drivers/staging/fieldbus/dev_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
index 5aab734606ea..d32599f4eb44 100644
--- a/drivers/staging/fieldbus/dev_core.c
+++ b/drivers/staging/fieldbus/dev_core.c
@@ -67,10 +67,10 @@ static ssize_t card_name_show(struct device *dev, struct device_attribute *attr,
 	struct fieldbus_dev *fb = dev_get_drvdata(dev);

 	/*
-	 * card_name was provided by child driver, could potentially be long.
-	 * protect against buffer overrun.
+	 * sysfs provides PAGE_SIZE long buffer to take care of potentially
+	 * long card_name provided by child driver.
 	 */
-	return snprintf(buf, PAGE_SIZE, "%s\n", fb->card_name);
+	return sysfs_emit(buf, "%s\n", fb->card_name);
 }
 static DEVICE_ATTR_RO(card_name);

--
2.34.1



