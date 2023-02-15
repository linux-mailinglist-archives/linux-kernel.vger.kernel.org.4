Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F166978FF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbjBOJaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbjBOJaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:30:06 -0500
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA70E93F7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:30:05 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id SE71pmycJOJaFSE71pRCYM; Wed, 15 Feb 2023 10:30:04 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 15 Feb 2023 10:30:04 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] firmware: turris-mox-rwtm: Fix an error handling path in mox_get_board_info()
Date:   Wed, 15 Feb 2023 10:30:02 +0100
Message-Id: <fb3a73fd378582bf02e6c5eeabb61d3a3662cbdc.1676453328.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_for_completion_timeout() returns 0 if timed out, and positive (at
least 1, or number of jiffies left till timeout) if completed.

In case of timeout, return -ETIMEDOUT.

Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

v2:
   - Fix some other wait_for_completion_timeout() calls

---
 drivers/firmware/turris-mox-rwtm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index 6ea5789a89e2..d6fc37ba897d 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -200,8 +200,8 @@ static int mox_get_board_info(struct mox_rwtm *rwtm)
 		return ret;
 
 	ret = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
-	if (ret < 0)
-		return ret;
+	if (ret == 0)
+		return -ETIMEDOUT;
 
 	ret = mox_get_status(MBOX_CMD_BOARD_INFO, reply->retval);
 	if (ret == -ENODATA) {
@@ -236,8 +236,8 @@ static int mox_get_board_info(struct mox_rwtm *rwtm)
 		return ret;
 
 	ret = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
-	if (ret < 0)
-		return ret;
+	if (ret == 0)
+		return -ETIMEDOUT;
 
 	ret = mox_get_status(MBOX_CMD_ECDSA_PUB_KEY, reply->retval);
 	if (ret == -ENODATA) {
@@ -275,8 +275,8 @@ static int check_get_random_support(struct mox_rwtm *rwtm)
 		return ret;
 
 	ret = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
-	if (ret < 0)
-		return ret;
+	if (ret == 0)
+		return -ETIMEDOUT;
 
 	return mox_get_status(MBOX_CMD_GET_RANDOM, rwtm->reply.retval);
 }
-- 
2.34.1

