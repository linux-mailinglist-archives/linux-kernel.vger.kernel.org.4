Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9679D649428
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 13:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiLKMTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 07:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKMTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 07:19:18 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20815101E4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 04:19:17 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w26so776601pfj.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 04:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2gPtb0kZX78YC1crT8EvCgaAOrm2u8F10CNCRPyKjDs=;
        b=qrIcVpUzXvWXYO3UhPLOnorH/Eu/FHJejqP7uivXntXh0txXkSUgUup7nNojEoAKCa
         EmCWI3H16krYpIW2w2JWRS7C1LzuS7hcv9S3p34ufjZEexlyIOEWrWFKSZjqscfzEaa7
         hz5CVyjz1PHWYOWPxtN+nmHDD0dW1SeWi/DcYir/6H4rhDNT3KkV3ZxeToSkxi9S8VG3
         8xb/mCU4fr1rNTrr52nEuGoNCqRHtp3bDZMDSCvA9MR/COJKTGIBRdZuBWt0rkukMBSf
         NLer25MBEjP0hrAmNKg6xavme1lWhZ1MAEMOt8NigV8ARg9BxQ02Jcx8r2bvQML8/WFV
         ncMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2gPtb0kZX78YC1crT8EvCgaAOrm2u8F10CNCRPyKjDs=;
        b=sEmLX/QpAOKgo+eRidslqXzKB56meVMAkbecHH0dHqDITZLUd3Y5nqI+l5rp+hkTWP
         M6o786j7E4iYvrPdR0+KytjBIeyuXjWBrxTrLxTPA1cxnkxhsugP4FQLUhZVnN4LajlF
         XbUnLL/X9z5Z6CpAfMf9WqlEtiAjc/Sw3n3uIhvOcWfRo/Vl58473O8XNAut0N9SCZPD
         uw2TlfA1biqvVdVaDK77wSHPGQDKrDWbSp5vv+n301/eDunbfMFtuTt9fsxXIh8O6Xj4
         RAq72zRXPYSuV4KMhA3a8UaSWJEgyiDkdkmU4H5HQkSoTYzEfZaXZBadX53pK01OHGwt
         Vpkg==
X-Gm-Message-State: ANoB5pn2tscZtmpJoksQRqiymZt7HFJr9/Et5TXfnkBpshBX8kxF7a/w
        RHx3BMMdH4nvSWN4ErLIfuFCwIPVsRh0qg==
X-Google-Smtp-Source: AA0mqf4vuuM+wRcWw8X2rkwWqijFrj/G0xljLe1/XMy+uhyQPu5NxN2mrGYn/do9HVRXVBE6izGVRw==
X-Received: by 2002:aa7:9050:0:b0:56d:67d7:1eb2 with SMTP id n16-20020aa79050000000b0056d67d71eb2mr12565044pfo.19.1670761156574;
        Sun, 11 Dec 2022 04:19:16 -0800 (PST)
Received: from VirtualBox.. ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id k145-20020a628497000000b00578199ea5afsm2472838pfd.9.2022.12.11.04.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 04:19:16 -0800 (PST)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: [PATCH v2] f2fs: continuous counting for 'issued' in  __issue_discard_cmd_orderly()
Date:   Sun, 11 Dec 2022 20:18:52 +0800
Message-Id: <20221211121852.112127-1-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the 'dcc->discard_granularity' and 'dcc->max_ordered_discard' can be set
at the user space, and if the 'dcc->max_ordered_discard' is set larger than
'dcc->discard_granularity' in DPOLICY_BG mode, or it's a volume device,
discard_granularity can be tuned to 1 in f2fs_tuning_parameters(),
it will may send more requests than the number of 'dpolicy->max_requests'
in issue_discard_thread().

This patch will fix the issue.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 fs/f2fs/segment.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a9099a754dd2..908b9a9bd82d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1379,8 +1379,8 @@ static void __queue_discard_cmd(struct f2fs_sb_info *sbi,
 	mutex_unlock(&SM_I(sbi)->dcc_info->cmd_lock);
 }
 
-static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
-					struct discard_policy *dpolicy)
+static void __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
+					struct discard_policy *dpolicy, int *issued)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
@@ -1388,7 +1388,6 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 	struct discard_cmd *dc;
 	struct blk_plug plug;
 	unsigned int pos = dcc->next_pos;
-	unsigned int issued = 0;
 	bool io_interrupted = false;
 
 	mutex_lock(&dcc->cmd_lock);
@@ -1415,9 +1414,9 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 		}
 
 		dcc->next_pos = dc->lstart + dc->len;
-		err = __submit_discard_cmd(sbi, dpolicy, dc, &issued);
+		err = __submit_discard_cmd(sbi, dpolicy, dc, issued);
 
-		if (issued >= dpolicy->max_requests)
+		if (*issued >= dpolicy->max_requests)
 			break;
 next:
 		node = rb_next(&dc->rb_node);
@@ -1433,10 +1432,8 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 
 	mutex_unlock(&dcc->cmd_lock);
 
-	if (!issued && io_interrupted)
-		issued = -1;
-
-	return issued;
+	if (!(*issued) && io_interrupted)
+		*issued = -1;
 }
 static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
 					struct discard_policy *dpolicy);
@@ -1464,8 +1461,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 		if (i + 1 < dpolicy->granularity)
 			break;
 
-		if (i + 1 < dcc->max_ordered_discard && dpolicy->ordered)
-			return __issue_discard_cmd_orderly(sbi, dpolicy);
+		if (i + 1 < dcc->max_ordered_discard && dpolicy->ordered) {
+			__issue_discard_cmd_orderly(sbi, dpolicy, &issued);
+			return issued;
+		}
 
 		pend_list = &dcc->pend_list[i];
 
-- 
2.34.1

