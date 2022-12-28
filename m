Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD816571A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiL1Bim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiL1Bie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:38:34 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB111F4;
        Tue, 27 Dec 2022 17:38:34 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NhZ14523Lz5PkHg;
        Wed, 28 Dec 2022 09:38:32 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl2.zte.com.cn with SMTP id 2BS1cRF9022734;
        Wed, 28 Dec 2022 09:38:27 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 28 Dec 2022 09:38:27 +0800 (CST)
Date:   Wed, 28 Dec 2022 09:38:27 +0800 (CST)
X-Zmail-TransId: 2b0363ab9e13ffffffff85849134
X-Mailer: Zmail v1.0
Message-ID: <202212280938279799834@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <code@tyhicks.com>
Cc:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <ecryptfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGVjcnlwdGZzOiBtYWluOiB1c2Ugc3Ryc2NweSgpIHRvIGluc3RlYWQgb2Ygc3RybmNweSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2BS1cRF9022734
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63AB9E18.000 by FangMail milter!
X-FangMail-Envelope: 1672191512/4NhZ14523Lz5PkHg/63AB9E18.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63AB9E18.000/4NhZ14523Lz5PkHg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL-terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 fs/ecryptfs/main.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 2dc927ba067f..007bed5ddf6e 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -296,9 +296,8 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 			cipher_name_dst =
 				mount_crypt_stat->
 				global_default_cipher_name;
-			strncpy(cipher_name_dst, cipher_name_src,
-				ECRYPTFS_MAX_CIPHER_NAME_SIZE);
-			cipher_name_dst[ECRYPTFS_MAX_CIPHER_NAME_SIZE] = '\0';
+			strscpy(cipher_name_dst, cipher_name_src,
+				ECRYPTFS_MAX_CIPHER_NAME_SIZE + 1);
 			cipher_name_set = 1;
 			break;
 		case ecryptfs_opt_ecryptfs_key_bytes:
@@ -328,9 +327,7 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 			fnek_src = args[0].from;
 			fnek_dst =
 				mount_crypt_stat->global_default_fnek_sig;
-			strncpy(fnek_dst, fnek_src, ECRYPTFS_SIG_SIZE_HEX);
-			mount_crypt_stat->global_default_fnek_sig[
-				ECRYPTFS_SIG_SIZE_HEX] = '\0';
+			strscpy(fnek_dst, fnek_src, ECRYPTFS_SIG_SIZE_HEX + 1);
 			rc = ecryptfs_add_global_auth_tok(
 				mount_crypt_stat,
 				mount_crypt_stat->global_default_fnek_sig,
@@ -350,10 +347,8 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 			fn_cipher_name_src = args[0].from;
 			fn_cipher_name_dst =
 				mount_crypt_stat->global_default_fn_cipher_name;
-			strncpy(fn_cipher_name_dst, fn_cipher_name_src,
-				ECRYPTFS_MAX_CIPHER_NAME_SIZE);
-			mount_crypt_stat->global_default_fn_cipher_name[
-				ECRYPTFS_MAX_CIPHER_NAME_SIZE] = '\0';
+			strscpy(fn_cipher_name_dst, fn_cipher_name_src,
+				ECRYPTFS_MAX_CIPHER_NAME_SIZE + 1);
 			fn_cipher_name_set = 1;
 			break;
 		case ecryptfs_opt_fn_cipher_key_bytes:
-- 
2.15.2
