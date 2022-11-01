Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0F8615416
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiKAVRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiKAVQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:16:07 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D298D1EC73
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:15:31 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id pyanoKD2rsfCIpybZoWfLb; Tue, 01 Nov 2022 22:15:30 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 01 Nov 2022 22:15:30 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-s390@vger.kernel.org
Subject: [PATCH 26/30] s390/ipl: Use kstrtobool() instead of strtobool()
Date:   Tue,  1 Nov 2022 22:14:14 +0100
Message-Id: <7766dac5969021bf7432e8c4f038db8afc996b8a.1667336095.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strtobool() is the same as kstrtobool().
However, the latter is more used within the kernel.

In order to remove strtobool() and slightly simplify kstrtox.h, switch to
the other function name.

While at it, include the corresponding header file (<linux/kstrtox.h>)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is part of a serie that axes all usages of strtobool().
Each patch can be applied independently from the other ones.

The last patch of the serie removes the definition of strtobool().

You may not be in copy of the cover letter. So, if needed, it is available
at [1].


This patch has NOT been compile tested.


[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
---
 arch/s390/kernel/ipl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 325cbf69ebbd..cdd575d7a91a 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/kstrtox.h>
 #include <linux/panic_notifier.h>
 #include <linux/reboot.h>
 #include <linux/ctype.h>
@@ -779,7 +780,7 @@ static ssize_t reipl_fcp_clear_store(struct kobject *kobj,
 				     struct kobj_attribute *attr,
 				     const char *buf, size_t len)
 {
-	if (strtobool(buf, &reipl_fcp_clear) < 0)
+	if (kstrtobool(buf, &reipl_fcp_clear) < 0)
 		return -EINVAL;
 	return len;
 }
@@ -899,7 +900,7 @@ static ssize_t reipl_nvme_clear_store(struct kobject *kobj,
 				      struct kobj_attribute *attr,
 				      const char *buf, size_t len)
 {
-	if (strtobool(buf, &reipl_nvme_clear) < 0)
+	if (kstrtobool(buf, &reipl_nvme_clear) < 0)
 		return -EINVAL;
 	return len;
 }
@@ -952,7 +953,7 @@ static ssize_t reipl_ccw_clear_store(struct kobject *kobj,
 				     struct kobj_attribute *attr,
 				     const char *buf, size_t len)
 {
-	if (strtobool(buf, &reipl_ccw_clear) < 0)
+	if (kstrtobool(buf, &reipl_ccw_clear) < 0)
 		return -EINVAL;
 	return len;
 }
-- 
2.34.1

