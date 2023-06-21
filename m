Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EDE738162
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjFUKQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjFUKQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:16:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5936519B6;
        Wed, 21 Jun 2023 03:16:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE374614F7;
        Wed, 21 Jun 2023 10:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4068DC433C9;
        Wed, 21 Jun 2023 10:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687342579;
        bh=fI73SiBO6xUlZ6yV48DEr6cjU7NZbUlp7BYYrDl0vJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tb4AeXeCjM4ZKM2XUG2d8z1OEeVQ1xnZlhY05Q0tcBoMi34DP3HWvrQjdJT5daLrP
         o5ffbra6/Fu1YC+4/12840hYNfZCBTp/8nqI4VOUwnAcgFLn0lwEXbIJ6rAOTdTPpg
         3oA2tpJ0C1ebFLaR+sdaupVtXzKreRTk82ZyUrdHLstb1zsY5skriBYwaTFyRHyQk5
         X5ajMTk3OJIxe70WpKOONlkcpE6dMSEFjaJJ6yCmClIS4fwsql3PIM6aIC64eT2bRa
         CtNXkMZoIgDY1osi7JPNAU0XW7l/Y33aHHDZAO9R2HVhHDr9IYuXr6iYCT+gOwI1bL
         mIHw+sZhLFnsA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 3/6] tty_audit: invert the condition in tty_audit_log()
Date:   Wed, 21 Jun 2023 12:16:08 +0200
Message-ID: <20230621101611.10580-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621101611.10580-1-jirislaby@kernel.org>
References: <20230621101611.10580-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we cannot obtain an audit buffer in tty_audit_log(), simply return
from the function. Apart this is mostly preferred in the kernel, it
allows to merge the split audit string while still keeping it readable.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_audit.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index 43f34465b9df..c6c27acad2ad 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -66,20 +66,20 @@ static void tty_audit_log(const char *description, dev_t dev,
 	uid_t uid = from_kuid(&init_user_ns, task_uid(current));
 	uid_t loginuid = from_kuid(&init_user_ns, audit_get_loginuid(current));
 	unsigned int sessionid = audit_get_sessionid(current);
+	char name[TASK_COMM_LEN];
 
 	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_TTY);
-	if (ab) {
-		char name[TASK_COMM_LEN];
-
-		audit_log_format(ab, "%s pid=%u uid=%u auid=%u ses=%u major=%d"
-				 " minor=%d comm=", description, pid, uid,
-				 loginuid, sessionid, MAJOR(dev), MINOR(dev));
-		get_task_comm(name, current);
-		audit_log_untrustedstring(ab, name);
-		audit_log_format(ab, " data=");
-		audit_log_n_hex(ab, data, size);
-		audit_log_end(ab);
-	}
+	if (!ab)
+		return;
+
+	audit_log_format(ab, "%s pid=%u uid=%u auid=%u ses=%u major=%d minor=%d comm=",
+			 description, pid, uid, loginuid, sessionid,
+			 MAJOR(dev), MINOR(dev));
+	get_task_comm(name, current);
+	audit_log_untrustedstring(ab, name);
+	audit_log_format(ab, " data=");
+	audit_log_n_hex(ab, data, size);
+	audit_log_end(ab);
 }
 
 /*
-- 
2.41.0

