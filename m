Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A6066AA4A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 09:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjANI6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 03:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjANI60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 03:58:26 -0500
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EE05BBC
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 00:58:25 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id GcMoplIKCnvraGcMopwaX6; Sat, 14 Jan 2023 09:58:24 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 14 Jan 2023 09:58:24 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: [PATCH v2] cifs: Use kstrtobool() instead of strtobool()
Date:   Sat, 14 Jan 2023 09:58:15 +0100
Message-Id: <b4cb5ccc96332ca81d6732b3063942186614eaa6.1673686651.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
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

Changes in v2:
  - synch with latest -next.

[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/cifs/cifs_debug.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
index 56b23def4c95..612f0bb284c9 100644
--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -8,6 +8,7 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <linux/uaccess.h>
@@ -787,7 +788,7 @@ static ssize_t cifsFYI_proc_write(struct file *file, const char __user *buffer,
 	rc = get_user(c[0], buffer);
 	if (rc)
 		return rc;
-	if (strtobool(c, &bv) == 0)
+	if (kstrtobool(c, &bv) == 0)
 		cifsFYI = bv;
 	else if ((c[0] > '1') && (c[0] <= '9'))
 		cifsFYI = (int) (c[0] - '0'); /* see cifs_debug.h for meanings */
@@ -947,7 +948,7 @@ static ssize_t cifs_security_flags_proc_write(struct file *file,
 
 	if (count < 3) {
 		/* single char or single char followed by null */
-		if (strtobool(flags_string, &bv) == 0) {
+		if (kstrtobool(flags_string, &bv) == 0) {
 			global_secflags = bv ? CIFSSEC_MAX : CIFSSEC_DEF;
 			return count;
 		} else if (!isdigit(flags_string[0])) {
-- 
2.34.1

