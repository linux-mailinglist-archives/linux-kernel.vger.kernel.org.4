Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0D85B4F8E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 17:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiIKPGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 11:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIKPGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 11:06:38 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAF92E6A9;
        Sun, 11 Sep 2022 08:06:37 -0700 (PDT)
Received: from localhost.localdomain (unknown [93.175.11.123])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6B40340737A7;
        Sun, 11 Sep 2022 15:06:32 +0000 (UTC)
From:   Vadim Shakirov <shakirov@ispras.ru>
To:     reiserfs-devel@vger.kernel.org
Cc:     Vadim@vger.kernel.org, Shakirov@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Shakirov Vadim <shakirov@ispras.ru>
Subject: [PATCH] reiserfs: added check in case of bad disk in search_by_entry_key
Date:   Sun, 11 Sep 2022 18:05:51 +0300
Message-Id: <20220911150551.34520-1-shakirov@ispras.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0>
References: <0>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Shakirov

Syzkaller has detected a bug in the search_by_entry_key function when the disk is bad.
For example, when we mount a disk using the search_by_key function, we are looking for an item_head that describes the .privroot directory. On the correct disk, either the desired position will be found, or the position following the desired element will be returned (since the key by which we are looking for may have an offset greater than that of the sought item_head), and using PATH_LAST_POSITION(path)-- the desired element is found.

But in the case of a bad disk, it may happen the item_head of the stat-file of the directory exists, but the item_head itself of the directory file does not exist. In this case, after ITEM_NOT_FOUND is returned from searh_by_key and PATH_LAST_POSITION(path)-- is executed, the location will point to the item_head of the stat file in this directory - dir_id and object_id will match, and the offset of the stat file is 0. And then we will treat the item_head of the stat file as if it were the item_head of a directory.

Signed-off-by: Shakirov Vadim <shakirov@ispras.ru>
---
 fs/reiserfs/namei.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 1594687582f0..c6db8db6a391 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -133,6 +133,12 @@ int search_by_entry_key(struct super_block *sb, const struct cpu_key *key,
 		}
 		PATH_LAST_POSITION(path)--;
 
+		if (!is_direntry_le_ih(tp_item_head(path)) ||
+		    COMP_SHORT_KEYS(&(tp_item_head(path))->ih_key, key)) {
+			pathrelse(path);
+			return IO_ERROR;
+		}
+
 	case ITEM_FOUND:
 		break;
 
-- 
2.25.1

