Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FA770533E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjEPQJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbjEPQIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:08:50 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB8BA27F
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:08:31 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GFMCaf029111;
        Tue, 16 May 2023 11:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=+MDWXt5D6nc/s9cRAPjbV0EysPuWW1pUM4Nf/uIC2MA=;
 b=Rmr3LlMw/YzMnqh5fHSrsIYUIu3t91HB1bUpUMYOn/G+MCLGiFjiny3G9qkMthTeFwrh
 tMdvfd4OPFjixYQ+Oh/vTWM1C62ungDPRVe6eWBHQUAavqi0FpEJ+LqClY7mzy4xNiD9
 p3ONybZbxk8bErJhFUYzCTwMWJ9jvjJCSP9y2ORT/Kyk3yY/z/Th4gGV9O5QryF+Z3zS
 qVIjk1T82+YIYwdWaKNQxUvc1nthJQKVsWQwhzQjCi65sm9bv4+GZLc37NQNuBF4gL5N
 wqtPlt2ofc3BAV93ApkKpu3GZI9EX1+tctQwL76CKKIfjV2mZUHMfyVqxGAey+9ThpBu 0w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qj6ymvnvm-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:07:59 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 16 May
 2023 11:07:56 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 16 May 2023 11:07:56 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.66])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AC99111A8;
        Tue, 16 May 2023 16:07:56 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 3/5] debugfs: Update debugfs_create_str() kerneldoc to warn about pointer race
Date:   Tue, 16 May 2023 17:07:51 +0100
Message-ID: <20230516160753.32317-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230516160753.32317-1-rf@opensource.cirrus.com>
References: <20230516160753.32317-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Of7ZDDsEtC4tmVWJr_igdUJqwZdbJ2F7
X-Proofpoint-ORIG-GUID: Of7ZDDsEtC4tmVWJr_igdUJqwZdbJ2F7
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

Add a warning to the debugfs_create_str() kerneldoc that the char * pointer
value must not change after the function returns, because of a race with
debugfs_read_file_str() accessing the pointer.

The only safe case is a change from NULL to non-NULL because in that case
debugfs_read_file_str() will see either the NULL or the valid pointer.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 fs/debugfs/file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 0c039a3d9a42..77794871f26d 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -938,11 +938,18 @@ static const struct file_operations fops_str_wo = {
  *          directory dentry if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
- *         from.
+ *         from. The char* pointer must not change, except from NULL to
+ *         non-NULL.
  *
  * This function creates a file in debugfs with the given name that
  * contains the value of the variable @value.  If the @mode variable is so
  * set, it can be read from, and written to.
+ *
+ * The char* pointed to by @value must not change after calling this
+ * function EXCEPT that it may change from NULL to non-NULL. This is to
+ * prevent the file read from accessing a stale pointer. A change from
+ * NULL to non-NULL is the only safe change, because the read will
+ * instantaneously see either NULL or the valid pointer.
  */
 void debugfs_create_str(const char *name, umode_t mode,
 			struct dentry *parent, char **value)
-- 
2.30.2

