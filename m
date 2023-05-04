Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57286F739B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjEDToj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjEDTni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:43:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76159EE1;
        Thu,  4 May 2023 12:43:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04A6F63735;
        Thu,  4 May 2023 19:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4EAC433A1;
        Thu,  4 May 2023 19:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229389;
        bh=AAnMYEwkY3TX+vPDX7HdSENvhJDwCV2scrmHBehi18A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EKv5VfrPA6kFYmabpzA8QeIv6sq5XejDKnfon7k180N772lhp7Ot602OukpQiADJ3
         x2NHy6ALX5pEdduIHUULhWXDB9MT552JUWnPAnCBdbr7P6yl+nmIVakXJLkcR5k20c
         eiW1RdCNQdcse7MJ1MBEN8rX90Wcrp7wRnotkdmxkMKinNyMxtMJsiJR2+DLhjD3le
         hXEjxPY5DTI9XpRyVQzpukOK2NIMgyxzA55xovj4XgfaBpewBPlnnphrSILFJZx7pt
         caFIivCwOc+eAcZ+fVLcleOneU4GXSRxKosVYc6BAZA+48P8clOVN9dI4uOauzRfMj
         DvBSAuQGQ1X8A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yu Kuai <yukuai3@huawei.com>, Song Liu <song@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 33/59] md: fix soft lockup in status_resync
Date:   Thu,  4 May 2023 15:41:16 -0400
Message-Id: <20230504194142.3805425-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194142.3805425-1-sashal@kernel.org>
References: <20230504194142.3805425-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 13321dbb5fbcf..d479e1656ef33 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8029,16 +8029,16 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
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

