Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4DF679665
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjAXLP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbjAXLPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:15:55 -0500
X-Greylist: delayed 901 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Jan 2023 03:15:48 PST
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21813E63F;
        Tue, 24 Jan 2023 03:15:47 -0800 (PST)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1674557437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aD4/h9d4fdnCay6mck+bYpcLc26YjKd4Wc2Mq5yvcbU=;
        b=kAotjoS+d+k9Lh4ogAm7MW/ZgGTPfW79NNEjl8gEv4rnxU/Xb1Tddt+3YMXPUpPLwKXfkp
        VIA3w+ahpW5+XvvAn9oBzTGPzL1W85NiQ2RV3HqLVZQ9dr4Tj3Wbs0hV29GgzJPafPdfkS
        +JftDJcFoxCQE3Duax3BwNwr1Wvfpoo=
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: [PATCH] smackfs: Added check catlen
Date:   Tue, 24 Jan 2023 13:50:37 +0300
Message-Id: <20230124105037.23108-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  If the catlen is 0, the memory for the netlbl_lsm_catmap
  structure must be allocated anyway, otherwise the check of
  such rules is not completed correctly.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 security/smack/smackfs.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 4b58526450d4..d45f4395a6ce 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -830,7 +830,7 @@ static int smk_open_cipso(struct inode *inode, struct file *file)
 static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos, int format)
 {
-	struct netlbl_lsm_catmap *old_cat;
+	struct netlbl_lsm_catmap *old_cat, *new_cat = NULL;
 	struct smack_known *skp;
 	struct netlbl_lsm_secattr ncats;
 	char mapcatset[SMK_CIPSOLEN];
@@ -917,8 +917,19 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 
 		smack_catset_bit(cat, mapcatset);
 	}
-
-	rc = smk_netlbl_mls(maplevel, mapcatset, &ncats, SMK_CIPSOLEN);
+	ncats.flags = 0;
+	if (catlen == 0) {
+		ncats.attr.mls.cat = NULL;
+		ncats.attr.mls.lvl = maplevel;
+		new_cat = netlbl_catmap_alloc(GFP_ATOMIC);
+		if (new_cat)
+			new_cat->next = ncats.attr.mls.cat;
+		ncats.attr.mls.cat = new_cat;
+		skp->smk_netlabel.flags &= ~(1U << 3);
+		rc = 0;
+	} else {
+		rc = smk_netlbl_mls(maplevel, mapcatset, &ncats, SMK_CIPSOLEN);
+	}
 	if (rc >= 0) {
 		old_cat = skp->smk_netlabel.attr.mls.cat;
 		skp->smk_netlabel.attr.mls.cat = ncats.attr.mls.cat;
-- 
2.25.1

