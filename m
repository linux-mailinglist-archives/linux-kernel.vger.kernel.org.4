Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139CC70534C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjEPQMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEPQMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:12:09 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2574C7EDA
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:11:56 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GFMCag029111;
        Tue, 16 May 2023 11:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=F8xUGENuEwEs7uQzjquZ4RM9syPSnoMdIovl2nu8iKw=;
 b=o2MZWLqy3qc74JOMWbKy7yOMuDXIAs11ei9hLRcKY8cgm/a8/ANlQN4Y+x9PUXujnlu1
 juAPiR9SmSDWvtSZVPOLT9FIft3Icxy+9Kpm4fJ7lwfak68xG7/8xgTderubFN2qyhsn
 zHEiADNjfCvSSz351qHQ43iWUmv7Zahi/Bfa1L7qsgP5r0z2q0B1o9cPJUNAFI76cAIY
 Rc8QrwbQruxKhaxyesAnfitFEHuV66DqvWGGdfxcj1nTJAd5n4/c31B3gGgXb2gD3knV
 gVfjAgLb9TW7wC7irCj8SZBHYU+WYtz2WHIksle1SijAbM8H8evlx9TtQVU2UAMX5IIx lg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qj6ymvnvm-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:08:00 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 16 May
 2023 11:07:57 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 16 May 2023 11:07:57 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.66])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0231615A2;
        Tue, 16 May 2023 16:07:56 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 4/5] debugfs: Move debugfs_create_str() export to correct location
Date:   Tue, 16 May 2023 17:07:52 +0100
Message-ID: <20230516160753.32317-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230516160753.32317-1-rf@opensource.cirrus.com>
References: <20230516160753.32317-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: x9izteXP3epPZGvRq7go-RI4rY2GAPCt
X-Proofpoint-ORIG-GUID: x9izteXP3epPZGvRq7go-RI4rY2GAPCt
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

Move the EXPORT_SYMBOL_GPL for debugfs_create_str() to where it should be,
immediately after the function it refers to.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 fs/debugfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 77794871f26d..d3892d01a8b4 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -902,7 +902,6 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(debugfs_create_str);
 
 static ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
 				      size_t count, loff_t *ppos)
@@ -957,6 +956,7 @@ void debugfs_create_str(const char *name, umode_t mode,
 	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_str,
 				   &fops_str_ro, &fops_str_wo);
 }
+EXPORT_SYMBOL_GPL(debugfs_create_str);
 
 static ssize_t read_file_blob(struct file *file, char __user *user_buf,
 			      size_t count, loff_t *ppos)
-- 
2.30.2

