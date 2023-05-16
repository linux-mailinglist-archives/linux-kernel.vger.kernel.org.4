Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C279070533F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjEPQJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjEPQI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:08:58 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3303493FC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:08:32 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GFMCah029111;
        Tue, 16 May 2023 11:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=NFIjHQw+dqpTNYvDnYxYQW3RAgGogay2/AQ3zCJQwvE=;
 b=ldwvqhDoaNVW8CPDVufWunIGvcwqF/CleVU+kYz0BKU1WRds8BiJyGJD46ryuoHqidxK
 L0eDUrRqVhYtccuhW2M7blL4ezPA610EEFbrqanxcR/+HnqDc/jTF563nGzwxwzdsnKf
 cnn/6tyeBnXr433shXDC54hs3bqVGyE11Uj52v9/ToL14fYwLXuzMIkw916QsyK5XwQF
 VglVDybjJJ0E33CeKriTyz7JGKSALpkR0r1zuCCy3TKdgRPRzKr7sg/O0r7waus/s4HC
 bQhMhfFgaIzJh+Yk9hLpJv9CwyUMjKwxEH9PKYIkrWxy3DSmVhPOrnpHPUgexhyf54hP eA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qj6ymvnvm-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:08:00 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 16 May
 2023 11:07:57 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 May 2023 11:07:57 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.66])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 50D16B38;
        Tue, 16 May 2023 16:07:57 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 5/5] debugfs: Add debugfs_create_const_str()
Date:   Tue, 16 May 2023 17:07:53 +0100
Message-ID: <20230516160753.32317-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230516160753.32317-1-rf@opensource.cirrus.com>
References: <20230516160753.32317-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: rzWXC6kM24RH8ev80R6c-1h1eGlYdk9q
X-Proofpoint-ORIG-GUID: rzWXC6kM24RH8ev80R6c-1h1eGlYdk9q
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wrapper for debugfs_create_str() that takes a const char **.

It's never nice to have to cast a const pointer to a non-const to be
able to pass it to an API. It always looks suspicious and it is relying
on "knowing" that it's safe. A function that explicitly takes a const
pointer is creating a contract that a const pointer is safe.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/linux/debugfs.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index ea2d919fd9c7..2723690aedd1 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -401,4 +401,31 @@ static inline void debugfs_create_xul(const char *name, umode_t mode,
 		debugfs_create_x64(name, mode, parent, (u64 *)value);
 }
 
+/**
+ * debugfs_create_const_str - create a debugfs file that is used to read a string value
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is %NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @value: a pointer to the variable that the file should read from.
+ *         The const char* pointer must not change, except from NULL to
+ *         non-NULL.
+ *
+ * This function creates a file in debugfs with the given name that
+ * contains the value of the variable @value.
+ *
+ * The const char* pointed to by @value must not change after calling this
+ * function EXCEPT that it may change from NULL to non-NULL. This is to
+ * prevent the file read from accessing a stale pointer. A change from
+ * NULL to non-NULL is the only safe change, because the read will
+ * instantaneously see either NULL or the valid pointer.
+ */
+static inline void debugfs_create_const_str(const char *name, umode_t mode,
+					    struct dentry *parent,
+					    const char **value)
+{
+	debugfs_create_str(name, mode & ~0222, parent, (char **)value);
+}
+
 #endif
-- 
2.30.2

