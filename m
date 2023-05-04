Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4959E6F7436
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjEDTtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjEDTsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:48:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E5411DAF;
        Thu,  4 May 2023 12:45:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2421636FB;
        Thu,  4 May 2023 19:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD2BC433A1;
        Thu,  4 May 2023 19:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229530;
        bh=khNk1lUsb57j593iQyjy2LDFxUQFL4haW1278EmDDok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iU+bX8Go7PiWtemDjeCbwPgu5Tp71HDxVbQ0twTSxQQKmtjwGnMlBbf0LfVP0Pybw
         H27CVoLxzTOtvLspIOx9Tb+crM8Fv3vVOk1m28d9zgCmjFIAQcG+9tmShfSxfUEn+n
         1+Qy8vSlzVvysyMiXLQDZ/7PN/dn88Iy5NoRoNC6+3hCHmR3iUVAi7caTWUCaZ4r/9
         KqrZx1oiCdwiWgUo7ocJaqR1YDtJPRmNG6tRLYJGSNPJYlQKO6AUDMwYsvz9g1EkT6
         +pmABo1Ao/bh7MTXD8NXSNpdlw8Ngt1KleL5ai2TJNtsMc7EyYiWkZu61UN/DLjM9Z
         YFv0mIDXJvFpw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yu Kuai <yukuai3@huawei.com>, Song Liu <song@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 30/53] md: fix soft lockup in status_resync
Date:   Thu,  4 May 2023 15:43:50 -0400
Message-Id: <20230504194413.3806354-30-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194413.3806354-1-sashal@kernel.org>
References: <20230504194413.3806354-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 6efddf1e32e2a264694766ca485a4f5e04ee82a7 ]

status_resync() will calculate 'curr_resync - recovery_active' to show
user a progress bar like following:

[============>........]  resync = 61.4%

'curr_resync' and 'recovery_active' is updated in md_do_sync(), and
status_resync() can read them concurrently, hence it's possible that
'curr_resync - recovery_active' can overflow to a huge number. In this
case status_resync() will be stuck in the loop to print a large amount
of '=', which will end up soft lockup.

Fix the problem by setting 'resync' to MD_RESYNC_ACTIVE in this case,
this way resync in progress will be reported to user.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230310073855.1337560-3-yukuai1@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index beab84f0c585c..6b2ba49203b37 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8019,16 +8019,16 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
 	} else if (resync > max_sectors) {
 		resync = max_sectors;
 	} else {
-		resync -= atomic_read(&mddev->recovery_active);
-		if (resync < MD_RESYNC_ACTIVE) {
-			/*
-			 * Resync has started, but the subtraction has
-			 * yielded one of the special values. Force it
-			 * to active to ensure the status reports an
-			 * active resync.
-			 */
+		res = atomic_read(&mddev->recovery_active);
+		/*
+		 * Resync has started, but the subtraction has overflowed or
+		 * yielded one of the special values. Force it to active to
+		 * ensure the status reports an active resync.
+		 */
+		if (resync < res || resync - res < MD_RESYNC_ACTIVE)
 			resync = MD_RESYNC_ACTIVE;
-		}
+		else
+			resync -= res;
 	}
 
 	if (resync == MD_RESYNC_NONE) {
-- 
2.39.2

