Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197C8661169
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 20:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjAGTuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 14:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjAGTus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 14:50:48 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21281482AF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 11:50:48 -0800 (PST)
Received: from fedcomp.intra.ispras.ru (unknown [46.242.14.200])
        by mail.ispras.ru (Postfix) with ESMTPSA id 8EE95419E9CE;
        Sat,  7 Jan 2023 19:50:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8EE95419E9CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1673121046;
        bh=46Om3KozLAr4Twn7WH/XwL5S4olDBoQ+x1OHtQBj8fI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRW2dSWV2eWVdP0jogGl0ihZC4AGM9yxvUG0fCqtSamboh0hoilQ6jjhxEYJMryxV
         YaEpRcsBm9L/gCSrq7TgLUEUWaYAQ/ZSGJFea2xnLqmSlWh0rKdNh4mQ4yVivK2lVV
         ZKLUR64NIHEL9M8QpdIBNAaK6L5YoDyVuXvF+MKI=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Jan Kara <jack@suse.com>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org,
        syzbot+8a5a459f324d510ea15a@syzkaller.appspotmail.com
Subject: [PATCH 1/1] udf: Fix null-ptr-deref in udf_write_fi()
Date:   Sat,  7 Jan 2023 22:50:16 +0300
Message-Id: <20230107195016.290627-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230107195016.290627-1-pchelkin@ispras.ru>
References: <20230107195016.290627-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

udf_find_entry() can return NULL or an error pointer if it fails. So we
should check its return value to avoid NULL pointer dereferencing in
udf_write_fi() (which is called from udf_delete_entry()). Also, if
udf_find_entry() returns an error pointer, it is possible that ofibh and
ocfi structs hold invalid values which can cause additional problems in
udf_write_fi().

If udf_find_entry() returns an error pointer, udf_rename() should return
with an error code. If udf_find_entry() returns NULL, ofi has probably
already been deleted.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 231473f6ddce ("udf: Return error from udf_find_entry()")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+8a5a459f324d510ea15a@syzkaller.appspotmail.com
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 fs/udf/namei.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 7c95c549dd64..6b058c6ebf93 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1170,7 +1170,12 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 
 	/* The old fid may have moved - find it again */
 	ofi = udf_find_entry(old_dir, &old_dentry->d_name, &ofibh, &ocfi);
-	udf_delete_entry(old_dir, ofi, &ofibh, &ocfi);
+	if (ofi && IS_ERR(ofi)) {
+		retval = PTR_ERR(ofi);
+		goto end_rename;
+	} else if (ofi) {
+		udf_delete_entry(old_dir, ofi, &ofibh, &ocfi);
+	}
 
 	if (new_inode) {
 		new_inode->i_ctime = current_time(new_inode);
-- 
2.34.1

