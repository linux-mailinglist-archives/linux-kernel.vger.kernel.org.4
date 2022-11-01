Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0196153EE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiKAVP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiKAVPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:15:31 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20541EEFA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:15:16 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id pyanoKD2rsfCIpybKoWfJO; Tue, 01 Nov 2022 22:15:15 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 01 Nov 2022 22:15:15 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        greybus-dev@lists.linaro.org
Subject: [PATCH 11/30] greybus: svc: Use kstrtobool() instead of strtobool()
Date:   Tue,  1 Nov 2022 22:13:59 +0100
Message-Id: <ebf1e6988a53a455990230a37cf759ee542ea7ec.1667336095.git.christophe.jaillet@wanadoo.fr>
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

[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
---
 drivers/greybus/svc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/greybus/svc.c b/drivers/greybus/svc.c
index 56d2b44d6fef..16cced80867a 100644
--- a/drivers/greybus/svc.c
+++ b/drivers/greybus/svc.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/debugfs.h>
+#include <linux/kstrtox.h>
 #include <linux/workqueue.h>
 #include <linux/greybus.h>
 
@@ -83,7 +84,7 @@ static ssize_t watchdog_store(struct device *dev,
 	int retval;
 	bool user_request;
 
-	retval = strtobool(buf, &user_request);
+	retval = kstrtobool(buf, &user_request);
 	if (retval)
 		return retval;
 
-- 
2.34.1

