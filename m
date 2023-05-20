Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D5870AA76
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjETS2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjETS1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:27:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C0FE56;
        Sat, 20 May 2023 11:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C865B60F92;
        Sat, 20 May 2023 18:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF89C4331F;
        Sat, 20 May 2023 18:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684607085;
        bh=vJMFvbfb1riHt08Qatx5dIhEfYslvuhQrxIlacgSUL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=un3sGc1U61ctJ29V/iAJwB+RzcsWnWJhi1hrbhsJq79NtTEzF41M4RzMBqWd6xd2k
         SdEqTOGTL9hOqd04X+SbyYK4ocbVba9IIQhsBgvnBdBEUvnSNoqxzd0+3iicC3a0ot
         iAjx+ofsC6z6ZNQ8uANwMWIrLQKKGaMc2uGBrgA53fC0GfCVG6ewtgwDaUdn9juMGl
         mzv8hp5E/EE2Y9unLAkz3z45aTpI/W0CnZYwAqDMlyH6u3J+QTyJimuooqfJMBqXVp
         xDC4UPT+n5tFgmXbpmjgRnV8My9rUISQKP5b2WC9nZ1drwrUaD37IVDLLZAUbVNQjx
         /nTgBajrZTszw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: [PATCH AUTOSEL 4.14 4/4] nbd: Fix debugfs_create_dir error checking
Date:   Sat, 20 May 2023 14:24:29 -0400
Message-Id: <20230520182432.866012-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520182432.866012-1-sashal@kernel.org>
References: <20230520182432.866012-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index f01b8860ba143..eb2ca7f6ab3ab 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1531,7 +1531,7 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
 		return -EIO;
 
 	dir = debugfs_create_dir(nbd_name(nbd), nbd_dbg_dir);
-	if (!dir) {
+	if (IS_ERR(dir)) {
 		dev_err(nbd_to_dev(nbd), "Failed to create debugfs dir for '%s'\n",
 			nbd_name(nbd));
 		return -EIO;
@@ -1557,7 +1557,7 @@ static int nbd_dbg_init(void)
 	struct dentry *dbg_dir;
 
 	dbg_dir = debugfs_create_dir("nbd", NULL);
-	if (!dbg_dir)
+	if (IS_ERR(dbg_dir))
 		return -EIO;
 
 	nbd_dbg_dir = dbg_dir;
-- 
2.39.2

