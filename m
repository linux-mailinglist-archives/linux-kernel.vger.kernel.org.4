Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE7172EEF4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjFMWOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFMWOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D76819A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32A8762012
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A08C433C0;
        Tue, 13 Jun 2023 22:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686694442;
        bh=BZl5RDaB9YV1iJvxCsTqdhiHN3w4NKnznFWhk6lWK64=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=oMfpyYEFVO6AHKQIpvThjeYITqASC7I2oMkJEzAx148ZcahRXmyp9nq2pbbPoOWPC
         K7Ex7mibuR6zWV4NbpcKJspZ27YbONbG8hdPzTpbloUMHJgD9Kf7vE6iuUa82ZOlvX
         S3cFv4t3Vjm75v2Dk675nc3diiFVXMqH5lbnVxxgtD5g4qv9sJ1jJth7vzAK+RT3kD
         cqmBb5OMWly5oT2v1/X/9++vQnyFGj3bT14lzOpsW5GzgojMqkHQfChPmMrdm6eiue
         QWJVeop+uS+qmBA0XXIc+NQAhIbPtzhMDGzaI2cHIOnXUw9nEBSjrdRK1PKcN+d2mm
         9qeKSU+W0QE4Q==
Date:   Tue, 13 Jun 2023 15:14:00 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: compress tmp files given extension
Message-ID: <ZIjqKHDUmN6u9pXa@google.com>
References: <20230606203645.3926651-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606203645.3926651-1-jaegeuk@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's compress tmp files for the given extension list.

This patch does not change the previous behavior, but allow the cases as below.

Extention example: "ext"

- abc.ext : allow
- abc.ext.abc : allow
- abc.extm : not allow

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 Change log from v1:
  - refactor to allow abc.ext.dontcare only

 fs/f2fs/namei.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 3e35eb7dbb8f..49573ef4115d 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -23,7 +23,7 @@
 #include <trace/events/f2fs.h>
 
 static inline bool is_extension_exist(const unsigned char *s, const char *sub,
-						bool tmp_ext)
+						bool tmp_ext, bool tmp_dot)
 {
 	size_t slen = strlen(s);
 	size_t sublen = strlen(sub);
@@ -49,8 +49,12 @@ static inline bool is_extension_exist(const unsigned char *s, const char *sub,
 	for (i = 1; i < slen - sublen; i++) {
 		if (s[i] != '.')
 			continue;
-		if (!strncasecmp(s + i + 1, sub, sublen))
-			return true;
+		if (!strncasecmp(s + i + 1, sub, sublen)) {
+			if (!tmp_dot)
+				return true;
+			if (i == slen - sublen - 1 || s[i + 1 + sublen] == '.')
+				return true;
+		}
 	}
 
 	return false;
@@ -148,7 +152,7 @@ static void set_compress_new_inode(struct f2fs_sb_info *sbi, struct inode *dir,
 	cold_count = le32_to_cpu(sbi->raw_super->extension_count);
 	hot_count = sbi->raw_super->hot_ext_count;
 	for (i = cold_count; i < cold_count + hot_count; i++)
-		if (is_extension_exist(name, extlist[i], false))
+		if (is_extension_exist(name, extlist[i], false, false))
 			break;
 	f2fs_up_read(&sbi->sb_lock);
 	if (i < (cold_count + hot_count))
@@ -156,12 +160,12 @@ static void set_compress_new_inode(struct f2fs_sb_info *sbi, struct inode *dir,
 
 	/* Don't compress unallowed extension. */
 	for (i = 0; i < noext_cnt; i++)
-		if (is_extension_exist(name, noext[i], false))
+		if (is_extension_exist(name, noext[i], false, false))
 			return;
 
 	/* Compress wanting extension. */
 	for (i = 0; i < ext_cnt; i++) {
-		if (is_extension_exist(name, ext[i], false)) {
+		if (is_extension_exist(name, ext[i], true, true)) {
 			set_compress_context(inode);
 			return;
 		}
@@ -189,7 +193,7 @@ static void set_file_temperature(struct f2fs_sb_info *sbi, struct inode *inode,
 	cold_count = le32_to_cpu(sbi->raw_super->extension_count);
 	hot_count = sbi->raw_super->hot_ext_count;
 	for (i = 0; i < cold_count + hot_count; i++)
-		if (is_extension_exist(name, extlist[i], true))
+		if (is_extension_exist(name, extlist[i], true, false))
 			break;
 	f2fs_up_read(&sbi->sb_lock);
 
-- 
2.41.0.162.gfafddb0af9-goog

