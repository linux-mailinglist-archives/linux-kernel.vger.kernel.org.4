Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B90870AA70
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjETS2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjETS1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:27:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39748199A;
        Sat, 20 May 2023 11:26:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB2CA616F1;
        Sat, 20 May 2023 18:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605BCC4339B;
        Sat, 20 May 2023 18:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684607069;
        bh=GBeSLJIX8UIkYb9sZu6S8yqG1JK98fV0232YBA07j4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EFh/Kbszm96xgUdbRDHFw5OGvgsvg4pgz8iGNJsF0nezdld224cc276XqeUcNxUC/
         E3nHLQoV2imDh3BaD4TBnlH3UMO9ELzSWnc7ryHlCW/Yez7Libw0DbPBUbO720JtRh
         Jo1/IqRBPCuVYAhAcXr2p3Y72n8hPv8qtP/89DR6M7uyp2hhRjN+BxlN00eumymJZ0
         4A8tvkziVW4KxQU6HjZLGAukDIvI7l/gmguc+A0Fe0XSstl74HO4citXH1+FD8NKrZ
         +Cgzqpp15wfk60YFn0Lx01y6Vg0j5d0x15HHOW72qGl+KDJ+8qibh0o1ldDXRFcVik
         ArZDyiI0ko/wQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: [PATCH AUTOSEL 4.19 5/5] nbd: Fix debugfs_create_dir error checking
Date:   Sat, 20 May 2023 14:24:09 -0400
Message-Id: <20230520182412.860973-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520182412.860973-1-sashal@kernel.org>
References: <20230520182412.860973-1-sashal@kernel.org>
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
index cc66983e8b6ab..28024248a7b53 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1547,7 +1547,7 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
 		return -EIO;
 
 	dir = debugfs_create_dir(nbd_name(nbd), nbd_dbg_dir);
-	if (!dir) {
+	if (IS_ERR(dir)) {
 		dev_err(nbd_to_dev(nbd), "Failed to create debugfs dir for '%s'\n",
 			nbd_name(nbd));
 		return -EIO;
@@ -1573,7 +1573,7 @@ static int nbd_dbg_init(void)
 	struct dentry *dbg_dir;
 
 	dbg_dir = debugfs_create_dir("nbd", NULL);
-	if (!dbg_dir)
+	if (IS_ERR(dbg_dir))
 		return -EIO;
 
 	nbd_dbg_dir = dbg_dir;
-- 
2.39.2

