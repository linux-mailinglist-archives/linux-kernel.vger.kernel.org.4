Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655DA66AA60
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 10:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjANJWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 04:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjANJWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 04:22:09 -0500
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BD45BBB
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:22:08 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id GcjlpZA1MpxjIGcjlpgpeF; Sat, 14 Jan 2023 10:22:07 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 14 Jan 2023 10:22:07 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org, russell.h.weight@intel.com,
        mcgrof@kernel.org, tianfei.zhang@intel.com,
        shaozhengchao@huawei.com, colin.i.king@gmail.com, error27@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] test_firmware: Use kstrtobool() instead of strtobool()
Date:   Sat, 14 Jan 2023 10:22:03 +0100
Message-Id: <34f04735d20e0138695dd4070651bd860a36b81c.1673688120.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
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
This patch was already sent as a part of a serie ([1]) that axed all usages
of strtobool().
Most of the patches have been merged in -next.

I synch'ed with latest -next and re-send the remaining ones as individual
patches.

Note that the first version was sent to no-one, only mailing lists,
because "get_maintainer.pl --nogit-fallback" returns an empty list.

Changes in v2:
  - No change

[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
---
 lib/test_firmware.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index e207bc08820d..3632cf62c812 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/delay.h>
+#include <linux/kstrtox.h>
 #include <linux/kthread.h>
 #include <linux/vmalloc.h>
 #include <linux/efi_embedded_fw.h>
@@ -358,7 +359,7 @@ static int test_dev_config_update_bool(const char *buf, size_t size,
 	int ret;
 
 	mutex_lock(&test_fw_mutex);
-	if (strtobool(buf, cfg) < 0)
+	if (kstrtobool(buf, cfg) < 0)
 		ret = -EINVAL;
 	else
 		ret = size;
-- 
2.34.1

