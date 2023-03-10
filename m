Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3006B556E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjCJXRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjCJXRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:17:22 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD29DBF9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:17:20 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id BA2C1604ED;
        Sat, 11 Mar 2023 00:17:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678490239; bh=nvunfcIWUaJ/7/0R+SRfAitNiWYZ4FLBFMx5o+htaEU=;
        h=From:To:Cc:Subject:Date:From;
        b=KFVl/NzMgokwdO4pMzYRRm+0gI3nw/au2FviTPaZeVZyq4+hDf6cgZCjG8wc3h25Z
         FvVctAr0KxcL6LyP5Mw5WvqkPkowXrW8ddXwHcNs1M6ffpRLOgTkHVKfyQxn5kyHqT
         ppJkOzLuHDWEI4LL2sL94Sva6kizjODe2WTAu8w76N2Pf1hHB0sDznYgC8hEDcrPsN
         mcgYSdx5T3KwCCEkQtg7x99D+WAlbI5TDbDVaPQ9YYmURZSix9a3k8nY9QefCy6AX2
         JrKXpe3g4IrkJLJ1yPg7T/ZRE8Ja13X5dMTyHUpXjBCT3sSk3UmEwAMMgKKhOhVtm+
         IttjcIYwJHpqg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5C_uzbNxrnOr; Sat, 11 Mar 2023 00:17:15 +0100 (CET)
Received: by domac.alu.hr (Postfix, from userid 1014)
        id 62197604EF; Sat, 11 Mar 2023 00:17:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678490235; bh=nvunfcIWUaJ/7/0R+SRfAitNiWYZ4FLBFMx5o+htaEU=;
        h=From:To:Cc:Subject:Date:From;
        b=E3ld26OfsLzs2wCYu2sBxmQuIutnRmao8WTtdG7b09W6GlN68HE7cjhwiVIPGHDr8
         OCm6BXLy/RgFqSQo8jhsD03dPeRmyKIbYtfPx0tjZ/W2luvfPE/TxE3sLNr9cl6ksc
         5Wc8IU17kzZVkGqpRe2pd+oG2zqfYWH0V9b6blLgvTMZHnXMSUGc+ZGqA14jnzQrP2
         KV58e6ozh5khopaRr6br/cwntZ4JT7I/g+Ly4QWzj+QWMNogU4P7oS61CQCPuJoeCS
         kxKS9U58+VmSHWNBrINU8U3aU+ktVfoqqAmty/NXCp9Lunu+zh3sBgUVSnoaDd2YhY
         0ohCV6ptJkIlg==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Paul Moore <paul@paul-moore.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v1 1/2] LSM: add a release() hook for the clean exit cleanup of the LSM modules
Date:   Sat, 11 Mar 2023 00:11:08 +0100
Message-Id: <20230310231107.10954-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        PP_MIME_FAKE_ASCII_TEXT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LSM modules, namely integrity, do not have a clean way to deallocate
resources allocated in the init() hook or later in their lifetime. The
resources are destroyed on kernel shutdown in an undefined order.

This will allow a .release member per LSM module and calling proper
destructors in a well-behaved order.

Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Christian Göttsche <cgzones@googlemail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Cc: Frederick Lawler <fred@cloudflare.com>

---
 include/linux/lsm_hooks.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 6e156d2acffc..d5a6ab9b5eb2 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1724,6 +1724,7 @@ struct lsm_info {
 	unsigned long flags;	/* Optional: flags describing LSM */
 	int *enabled;		/* Optional: controlled by CONFIG_LSM */
 	int (*init)(void);	/* Required. */
+	int (*release)(void);	/* Release associated resources */
 	struct lsm_blob_sizes *blobs; /* Optional: for blob sharing. */
 };
 

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

---
 include/linux/lsm_hooks.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 0a5ba81f7367..db3e57e7738b 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1724,6 +1724,7 @@ struct lsm_info {
 	unsigned long flags;	/* Optional: flags describing LSM */
 	int *enabled;		/* Optional: controlled by CONFIG_LSM */
 	int (*init)(void);	/* Required. */
+	int (*release)(void);	/* Release associated resources */
 	struct lsm_blob_sizes *blobs; /* Optional: for blob sharing. */
 };
 
-- 
2.30.2

