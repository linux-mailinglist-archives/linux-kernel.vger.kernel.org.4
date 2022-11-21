Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0999D632910
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiKUQLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiKUQLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:11:17 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0578AD2358
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:11:17 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id q96-20020a17090a1b6900b00218b8f9035cso2541439pjq.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nrfq658ppsV6A0UxvigWf4GUIKl2kFHfMPKNsHA6hzo=;
        b=nhv+nzMIswF6089c7r9+/04T0AJi4Jfd7Bb2/+Ib6+Sb+/j3IevYn7Pp+nzWADYMFS
         2cTVOiPLxr54Z6YJm9NWdX5nVJrzkQbUMiLjlw+c2F6JASSK7u4WupuK1TZ2ps6uPb7b
         rM7QvLGw6gV8uexiptIPbkhFpDnSZOTS+r6M3S0TNvDxSS7fl6H2IJGgtLHnCdeC+hwn
         nkUJXZi3/WkjQlLcmLXZebh7qKlXcDglKNdI1VOYM5hpJMr9DJzpt3WmNVfpJolfKehk
         FJaEKSEEfUe0e1NAg3lWUSVYdHo5k96MWSf2fE+Hqn+EehUD8wBWnRqpjwSAvvot2Qwv
         +XIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nrfq658ppsV6A0UxvigWf4GUIKl2kFHfMPKNsHA6hzo=;
        b=haJscGj0M0h7aN61fCEZLOR+/eknoOAIIW+j7TeOukfDjpLFmvYGKRasFf3he+LqME
         haRyKWbCmR+LpobAAqE+5h3KGa5gPkXjHLxFk5+3z31KrX0FWPNut/NEpeDT5y6ZuyDr
         LBWiaUR+ua57tCwVgCD0qHZPIFQf0WqeqHatjzq47cosDnEgxyr7jCJgksEqvlM5XSuK
         HBqYJ79pjz5v/iGc7lQvUDVIJbkfbcALn6bes0fy68TtW6QXWqHneHsCLrT/+KN2QGwM
         ZXfrblRJv0s5GjitKUkHi5NknGOWM17UJhN2nok44anPM+iCKZbaMai9r00ZyaAFl7aP
         Xv4Q==
X-Gm-Message-State: ANoB5pkh9esqGXq4EiapSzDn+K5vXljnjMB6jJ2XgCASKD0gCwFwBl/q
        KPOAYlpx/lMytzlD/pDQ+fc=
X-Google-Smtp-Source: AA0mqf6odYdNtQXeCRJPdgRlCySo6MJP81hhMJ/kpY0g4kwJ4SJvJUt6sTA8XeKHBBB31N8K5Cio3Q==
X-Received: by 2002:a17:903:2109:b0:186:8d7b:377e with SMTP id o9-20020a170903210900b001868d7b377emr259918ple.19.1669047076526;
        Mon, 21 Nov 2022 08:11:16 -0800 (PST)
Received: from VirtualBox.. ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id x15-20020a63fe4f000000b00434272fe870sm7774571pgj.88.2022.11.21.08.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 08:11:15 -0800 (PST)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: [PATCH] f2fs: continuous counting for 'issued' in __issue_discard_cmd_orderly()
Date:   Tue, 22 Nov 2022 00:11:01 +0800
Message-Id: <20221121161101.72847-1-Yuwei.Guan@zeekrlife.com>
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
 fs/f2fs/segment.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8b0b76550578..b0157bf392fb 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1379,8 +1379,8 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
 	return 0;
 }
 
-static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
-					struct discard_policy *dpolicy)
+static int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
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
@@ -1433,10 +1432,10 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 
 	mutex_unlock(&dcc->cmd_lock);
 
-	if (!issued && io_interrupted)
-		issued = -1;
+	if (!(*issued) && io_interrupted)
+		*issued = -1;
 
-	return issued;
+	return *issued;
 }
 static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
 					struct discard_policy *dpolicy);
@@ -1465,7 +1464,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 			break;
 
 		if (i + 1 < dcc->max_ordered_discard && dpolicy->ordered)
-			return __issue_discard_cmd_orderly(sbi, dpolicy);
+			return __issue_discard_cmd_orderly(sbi, dpolicy, &issued);
 
 		pend_list = &dcc->pend_list[i];
 
-- 
2.34.1

