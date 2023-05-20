Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040EC70AA59
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjETS17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjETS1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:27:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF011737;
        Sat, 20 May 2023 11:26:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8404660EFA;
        Sat, 20 May 2023 18:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132D0C433D2;
        Sat, 20 May 2023 18:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684607048;
        bh=uqeMKbUWEZLVKRiEYY5Fm2A3dW4g8dNMtC9yu+37mfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g5Wkx5nlRImR/MAvWpqo8GeobX961iZFN/aGuMzlqIpZx4+djtbZGnKZxC6dJbF+r
         Jyt5mL4EhjXLsmy/6D4h88RKUB307Bi/I62/896rBh12BMpbtun4DM42FKIFXd5s5A
         ljZOKClQoIvbQDr+3Mad4MPFHkGApenomoeXQd4/Yt6QV31N/DRi3v2FqQcjRm5+Bo
         gK2Ywg+DWbpUaije1o5EoIeuR21Lset3qfiXXJN6NzLg21CPY3YWL70xeNuAJj/sF/
         K5Meyo0Rm8XJDumfHzle2CCHsnJJmzzz9f5GunA1KRyieyud7nnIW1MKECmjgutPAJ
         7wV3ydTT/kFzA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: [PATCH AUTOSEL 5.4 5/5] nbd: Fix debugfs_create_dir error checking
Date:   Sat, 20 May 2023 14:23:47 -0400
Message-Id: <20230520182352.856378-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520182352.856378-1-sashal@kernel.org>
References: <20230520182352.856378-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

[ Upstream commit 4913cfcf014c95f0437db2df1734472fd3e15098 ]

The debugfs_create_dir function returns ERR_PTR in case of error, and the
only correct way to check if an error occurred is 'IS_ERR' inline function.
This patch will replace the null-comparison with IS_ERR.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Link: https://lore.kernel.org/r/20230512130533.98709-1-ivan.orlov0322@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 610dc6a36a9de..218aa7e419700 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1609,7 +1609,7 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
 		return -EIO;
 
 	dir = debugfs_create_dir(nbd_name(nbd), nbd_dbg_dir);
-	if (!dir) {
+	if (IS_ERR(dir)) {
 		dev_err(nbd_to_dev(nbd), "Failed to create debugfs dir for '%s'\n",
 			nbd_name(nbd));
 		return -EIO;
@@ -1635,7 +1635,7 @@ static int nbd_dbg_init(void)
 	struct dentry *dbg_dir;
 
 	dbg_dir = debugfs_create_dir("nbd", NULL);
-	if (!dbg_dir)
+	if (IS_ERR(dbg_dir))
 		return -EIO;
 
 	nbd_dbg_dir = dbg_dir;
-- 
2.39.2

