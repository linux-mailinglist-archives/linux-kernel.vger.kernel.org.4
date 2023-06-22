Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCC57397F1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjFVHM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjFVHMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:12:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AC11BDC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:12:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 412236177C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E64C433CA;
        Thu, 22 Jun 2023 07:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687417963;
        bh=FrHV/aMYkgKJL7vYPTB/f+fAorcu5w2trEwg00r+1/4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=vKpzyF7M/taaUfr2eUVeK3zXkQjzykKdEkWrEcsha2+UlziELuyNE4/zglr33vT9N
         Y4tkpP4zPLnXYjJ1PkW8TLIAeY+7hpfrfT0n7x2oTj9KY2fCZ/uxh6x+Btc2WQuB1l
         9JUpyXeSnvSEzzEnvDpHcDo24Z/SGrHnf5o99Om6P09EsRKEQ6qtOnf4fyd3GSS+67
         1txDZVSIMZEnmLp+WKywCg2S43ZmSDYMrEzizxjQgSHIcPlQFJZPZZctYi5wMmz8R6
         Hqu1k/NfB0kvyrkMpHYUOaiShwSL7UxA40mgAXz7OhGMcyvcmCb1CEw+hdiiIwtOgk
         bF02r3o/cFXqA==
Date:   Thu, 22 Jun 2023 00:12:42 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: compress tmp files given extension
Message-ID: <ZJP0aoy03Vx2Q2K1@google.com>
References: <20230606203645.3926651-1-jaegeuk@kernel.org>
 <ZIjqKHDUmN6u9pXa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIjqKHDUmN6u9pXa@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
  Change log from v2:
   - fix parameters

  Change log from v1:
   - refactor to allow abc.ext.dontcare only

 fs/f2fs/namei.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 3e35eb7dbb8f..80806ce1289f 100644
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
+		if (is_extension_exist(name, extlist[i], true, false))
 			break;
 	f2fs_up_read(&sbi->sb_lock);
 	if (i < (cold_count + hot_count))
@@ -156,12 +160,12 @@ static void set_compress_new_inode(struct f2fs_sb_info *sbi, struct inode *dir,
 
 	/* Don't compress unallowed extension. */
 	for (i = 0; i < noext_cnt; i++)
-		if (is_extension_exist(name, noext[i], false))
+		if (is_extension_exist(name, noext[i], true, false))
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

