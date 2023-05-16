Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DEF705340
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjEPQJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjEPQJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:09:09 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920BA9EEF
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:08:34 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GFMLXM013969;
        Tue, 16 May 2023 11:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=T2DH6/H5m8Qazyq8fWgGGTIxlN/LEAb7+hM6ytoAYMY=;
 b=jaYJo2OZNJaOaQrzjITNXQW+77MenPnRLDgfl4yJSF1ZEy4lESaGCIij26mkBdeoOcL3
 jw8dqXTMd/lPIbf+go/3Tw4kfuwPUpiEi3CUuWdr7qE48C6GbsPVj7I/LpzW/H/mQfiV
 JRLbofGTer24W/7Kmh6ZfEaJn/3fQQsREwv5Yj+/1qGlLebFTH6Va+4FT/GEwLNWJb6J
 EuwwV65XH+BYiYBsGU2ANWfdS0WlbmdCp28sszGEpVvdbDfMOdYs5coM+wBmh8uJ3vN/
 NT5cldcZCzXw+akmOEt3X8xBudYqH8jlySboURtFo9S2zwdxv8rfVBfqEcuAffOypIAd OQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qj7y14epn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:07:58 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 16 May
 2023 11:07:56 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 16 May 2023 11:07:56 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.66])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 15B7211A8;
        Tue, 16 May 2023 16:07:56 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/5] debugfs: Prevent NULL dereference reading from string property
Date:   Tue, 16 May 2023 17:07:49 +0100
Message-ID: <20230516160753.32317-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230516160753.32317-1-rf@opensource.cirrus.com>
References: <20230516160753.32317-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: F3BY0PdYc71JIRmuN6TytsC3HzMbVf3f
X-Proofpoint-ORIG-GUID: F3BY0PdYc71JIRmuN6TytsC3HzMbVf3f
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

Check in debugfs_read_file_str() if the string pointer is NULL.

It is perfectly reasonable that a driver may wish to export a string
to debugfs that can have the value NULL to indicate empty/unused/ignore.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 fs/debugfs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 1f971c880dde..2c085ab4e800 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -878,6 +878,9 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
 		return ret;
 
 	str = *(char **)file->private_data;
+	if (!str)
+		return simple_read_from_buffer(user_buf, count, ppos, "\n", 1);
+
 	len = strlen(str) + 1;
 	copy = kmalloc(len, GFP_KERNEL);
 	if (!copy) {
-- 
2.30.2

