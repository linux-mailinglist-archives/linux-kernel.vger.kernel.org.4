Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3C8648940
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiLITzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLITzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:55:04 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE546B9BA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 11:55:03 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so9214882pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 11:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FL5Mxmv7ODIlEDZq/8j08cewsGW36kitXNchLqx6+8U=;
        b=WZNOVqrirVQquuq60VScBrJ9NWVTKDlyjoEaTbQrtRksRVT1MUBEQ3OTRZilvuQ4go
         fvxyqsqAScKUNpdHI3KgQpr/RHi1kYBi3gDU6VKh3OWBr85C1hPSXGNrN7j3ZRf8JgbU
         nKuQCyz6cdeN33osi+dFwf9HbblL85TZ0NHJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FL5Mxmv7ODIlEDZq/8j08cewsGW36kitXNchLqx6+8U=;
        b=TPrHW8x+iK7Wru2gUhQoxWzfX7mYCSZ6/Qby/uUE1LadJoBdjTa0VSpYSMaQtNOndT
         1SBGWkjHHAQXV/Cv3xupO8xLK7/cbnqtfBbvUjtKWbUTTc7pX6Uhudo9tGIEQd331U/R
         yVEUE8VFs+U7CQDsBIDG3Cruk1FbE9sZ1XQGu3Xe1CpbO0le0ex0EIgrIvrd7LaIyNyd
         8Sfgp5Dw3Lh3Gkl35s83EHIU833MPNiiWJmqw/MYwcrofbzvFP9yA8n6KEhh44Q2/kf7
         t4JO9NGHwnTj02M59t9XqCtYDat5zXmJ/LMKuVFcQez/xRoIl2KWAOf56PxpQyVT08eD
         +OOA==
X-Gm-Message-State: ANoB5pnjQK7rBUayrCE95+/xRyiVkPus89yhik2VX1aCEfl62qsxLrNL
        JZJm1miZskEdMj9bGYwZqbxDJg==
X-Google-Smtp-Source: AA0mqf5asVjHxvpOsLGmbpn+1ehHUFGL8UqVz3KSDp9PpxJTP+NzFakLHud+RnA5SPJotq2DRBXvGA==
X-Received: by 2002:a17:902:c755:b0:189:47a8:e9d0 with SMTP id q21-20020a170902c75500b0018947a8e9d0mr6031152plq.51.1670615702700;
        Fri, 09 Dec 2022 11:55:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b00189b2b8dbedsm1700025plh.228.2022.12.09.11.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:55:02 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] LoadPin: Ignore the "contents" argument of the LSM hooks
Date:   Fri,  9 Dec 2022 11:54:57 -0800
Message-Id: <20221209195453.never.494-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2557; h=from:subject:message-id; bh=NyOSzyqOU/AeDA19RQqsUCPh2wuwt80QQlxHAZKpzlQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjk5KRVmj58M+uOtoVMJjwqOPNQu3ZJm3uKzSmoSaE 9ojdx/iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY5OSkQAKCRCJcvTf3G3AJsOJD/ 9HuKsTrjjMu5QnYHndlcOvspNVUNRW2WhEBINIAVk3mT7hVZNFliJNdlq8RpE9DJ1/KpuXF5qbLxcx spB1nyAReOpOOPUUssIfanBqxdY0mkSihWYz/2krtoM7jy/AmfiAgI/9FIDnJ9W9nUUZRmOkPKqPmL udvZVmZ4Nkseq73j1ZZYf4NDEVkgroW6eUJrHsDJDD55+FtBqQghQPWT5U3JMF0LZnzIlZ40ePAk/y 5rLEHt89Ap/D5zoG91dzkoIhv5oxb5q9FY/HM7veRosMUm8X7uARyxCMFRSoze3e0j4vC1O4oSO31J 9B54Er/8NFp9FmZg0Zxnta/acigU1ggJ3Lz721rqzKg3bTZppChpQDb8q7fdq45Yk/Q9LrWjSof1fA pSoRTuQnuI1J/QVRT2x8wymE1J5r3p52aFQdD0YwyStKNttnoiX3kztUmFA+pLY4H6zKcjixOhmp+B bphi6ox/XT4tL9FvlU/gGmoBuLE8wsq9Fdiy+CzjEzYY1SNWLoRFFd72S66sMMNwUNtxnYh/8CAXk3 4ky8CgrRnCHlKEiWhB5xPbE4aFr3I5X+FrUji0qcT5yegWw/YLxRWa6sMCs3pnAw04AcuBY9OgqnKR iI21OozT62OGA/o+xR0Vk3RTNSIt903EbfkD+NYtVf8D+No3mWUdoqAOrxVg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LoadPin only enforces the read-only origin of kernel file reads. Whether
or not it was a partial read isn't important. Remove the overly
conservative checks so that things like partial firmware reads will
succeed (i.e. reading a firmware header).

Fixes: 2039bda1fa8d ("LSM: Add "contents" flag to kernel_read_file hook")
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/loadpin/loadpin.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index de41621f4998..110a5ab2b46b 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -122,21 +122,11 @@ static void loadpin_sb_free_security(struct super_block *mnt_sb)
 	}
 }
 
-static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
-			     bool contents)
+static int loadpin_check(struct file *file, enum kernel_read_file_id id)
 {
 	struct super_block *load_root;
 	const char *origin = kernel_read_file_id_str(id);
 
-	/*
-	 * If we will not know that we'll be seeing the full contents
-	 * then we cannot trust a load will be complete and unchanged
-	 * off disk. Treat all contents=false hooks as if there were
-	 * no associated file struct.
-	 */
-	if (!contents)
-		file = NULL;
-
 	/* If the file id is excluded, ignore the pinning. */
 	if ((unsigned int)id < ARRAY_SIZE(ignore_read_file_id) &&
 	    ignore_read_file_id[id]) {
@@ -192,9 +182,25 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
 	return 0;
 }
 
+static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
+			     bool contents)
+{
+	/*
+	 * LoadPin only cares about the _origin_ of a file, not its
+	 * contents, so we can ignore the "are full contents available"
+	 * argument here.
+	 */
+	return loadpin_check(file, id);
+}
+
 static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
 {
-	return loadpin_read_file(NULL, (enum kernel_read_file_id) id, contents);
+	/*
+	 * LoadPin only cares about the _origin_ of a file, not its
+	 * contents, so a NULL file is passed, and we can ignore the
+	 * state of "contents".
+	 */
+	return loadpin_check(NULL, (enum kernel_read_file_id) id);
 }
 
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
-- 
2.34.1

