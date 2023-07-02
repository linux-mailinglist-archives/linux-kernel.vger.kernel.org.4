Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A273474517F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjGBTrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjGBTqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:46:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6301A1725;
        Sun,  2 Jul 2023 12:42:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 448B760C8D;
        Sun,  2 Jul 2023 19:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003E1C433C9;
        Sun,  2 Jul 2023 19:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326955;
        bh=vnWXRmLCpLjSipFqzdqePgmS9HSY/6b4+72z/iQwbLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sR76QgZrsdO6DzTvAtB3k/c0b+49jcBZIj/8A6kIuBSg9hfR00JzDL1cy9vEnzO9H
         NzSjv6EsUhyE3lMHz5Dx6CPcO2WLj2YcLiMu6wtBQnhmrc6+0ag24O7qNC0u5/kynl
         bVyG+TpflQ+cyLMIVp7FnKHAgdGLSSscniou3asfAbqcMjviEJ0ZAWZXak59AC+C9d
         nB5PdZxS0rX+yxw1jiwbgb0BAzRn+wLX/mvPD0ZajoFMxxCT0Iu8CSZCns1guquqRi
         3/BXVmDqarnPfQs74IUWMf3ShPLnS4D9N8NK+hF19HnmQ+cxnSfKebckDI+p4JS1pI
         CpxMekevqFmJg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yu Kuai <yukuai3@huawei.com>, Peter Neuwirth <reddunur@online.de>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 3/5] md: fix data corruption for raid456 when reshape restart while grow up
Date:   Sun,  2 Jul 2023 15:42:28 -0400
Message-Id: <20230702194230.1779535-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194230.1779535-1-sashal@kernel.org>
References: <20230702194230.1779535-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.320
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

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 873f50ece41aad5c4f788a340960c53774b5526e ]

Currently, if reshape is interrupted, echo "reshape" to sync_action will
restart reshape from scratch, for example:

echo frozen > sync_action
echo reshape > sync_action

This will corrupt data before reshape_position if the array is growing,
fix the problem by continue reshape from reshape_position.

Reported-by: Peter Neuwirth <reddunur@online.de>
Link: https://lore.kernel.org/linux-raid/e2f96772-bfbc-f43b-6da1-f520e5164536@online.de/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230512015610.821290-3-yukuai1@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 69d1501d9160e..3b9cfeda02993 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4612,11 +4612,21 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 			return -EINVAL;
 		err = mddev_lock(mddev);
 		if (!err) {
-			if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
+			if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
 				err =  -EBUSY;
-			else {
+			} else if (mddev->reshape_position == MaxSector ||
+				   mddev->pers->check_reshape == NULL ||
+				   mddev->pers->check_reshape(mddev)) {
 				clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 				err = mddev->pers->start_reshape(mddev);
+			} else {
+				/*
+				 * If reshape is still in progress, and
+				 * md_check_recovery() can continue to reshape,
+				 * don't restart reshape because data can be
+				 * corrupted for raid456.
+				 */
+				clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 			}
 			mddev_unlock(mddev);
 		}
-- 
2.39.2

