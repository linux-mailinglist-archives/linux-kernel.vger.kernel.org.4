Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944205FDDC6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJMP5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiJMP4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:56:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1E9F5CED
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:56:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4CBBB81D51
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 15:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F364C433B5;
        Thu, 13 Oct 2022 15:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665676596;
        bh=GWAsMCzrsIUK4JqlUZTcZflB2YUEVAu+pDYdJDx8/Tw=;
        h=From:To:Cc:Subject:Date:From;
        b=nsVW+GFj8U/jt+iF+40/ZOlxP4jVxowrnSiIFCF/n8o+pRVcTJE296rppf5ti3Zbg
         mA+Goa8VSohxc4Cilcu5J1XyQVJE+c5IKLMoFL/7l/HNTUnhJ3zUL6vt3mpKu+kd6Y
         HsoPf3ttdMBM1gmjYllxUaw6fyQIC/F9XL5lp4ZQPwYaEtCtBtNsTjuUlw1vIkmxvu
         9aZLKVwedcAPj7EAUwWaaNavarac6Hx/iQIxqigVsa7hfm2nsF0mCkUis48+HUiltN
         73yAoFt+RZi3beqyArg9bTzeJ1Y1GJAMF/NQttBW5Gkw1GX/HP5K51mEK4icCD1q3r
         uysUaXPS0G4fw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to invalidate dcc->f2fs_issue_discard in error path
Date:   Thu, 13 Oct 2022 23:56:28 +0800
Message-Id: <20221013155628.434671-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, latter f2fs_stop_discard_thread() may access invalid
dcc->f2fs_issue_discard.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 460048f3c850..cf5f534aa887 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2026,8 +2026,10 @@ int f2fs_start_discard_thread(struct f2fs_sb_info *sbi)
 
 	dcc->f2fs_issue_discard = kthread_run(issue_discard_thread, sbi,
 				"f2fs_discard-%u:%u", MAJOR(dev), MINOR(dev));
-	if (IS_ERR(dcc->f2fs_issue_discard))
+	if (IS_ERR(dcc->f2fs_issue_discard)) {
 		err = PTR_ERR(dcc->f2fs_issue_discard);
+		dcc->f2fs_issue_discard = NULL;
+	}
 
 	return err;
 }
-- 
2.25.1

