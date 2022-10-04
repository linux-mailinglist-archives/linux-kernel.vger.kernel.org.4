Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FE75F4C98
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 01:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiJDXYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 19:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiJDXYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 19:24:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A025A178
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 16:24:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 148BC61556
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 23:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F4AC433C1;
        Tue,  4 Oct 2022 23:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664925857;
        bh=4dNwl/oKIInY2ft6O5UhG5DaEMyEvyl1spox55vQTzs=;
        h=From:To:Cc:Subject:Date:From;
        b=U84KTFZy4/gKty+sJsUi7cvRqaQC+s7b9kArcTKKUBPEy5Xp2GN38iysSo6Zdy1Oc
         DzeIYFnbfMYmTCW9GF8KGpPOoJRwJ0boGIJveUabqXyTcV26W4epB+FYz2Bd4Z+R9Y
         FPFUHyJlnLhEwIddo/QrqXFFyTkLjpDR9o27GMDtThTuvGlf0qoRTW4awCulB6VESK
         glH/EQZjRWIfq776yAfmcGpdnxtjPYMdJ2maYHsSSLB9m3LhUvIVMD1tSWmZ34WHCn
         5Jy8l2gOn8FgXZz8V0OY+aREDyxxHQyQ/+qrzMxnsZaFju3t3OfpDa+wlgGvVF79B0
         uqGCzZ+pDIW3w==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, ntfs3@lists.linux.dev,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH -next v2 1/2] fs/ntfs3: Don't use uni1 uninitialized in ntfs_d_compare()
Date:   Tue,  4 Oct 2022 16:23:58 -0700
Message-Id: <20221004232359.285685-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

  fs/ntfs3/namei.c:445:7: error: variable 'uni1' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
                  if (toupper(c1) != toupper(c2)) {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
  ./include/linux/ctype.h:64:20: note: expanded from macro 'toupper'
  #define toupper(c) __toupper(c)
                    ^
  fs/ntfs3/namei.c:487:12: note: uninitialized use occurs here
          __putname(uni1);
                    ^~~~
  ./include/linux/fs.h:2789:65: note: expanded from macro '__putname'
  #define __putname(name)         kmem_cache_free(names_cachep, (void *)(name))
                                                                        ^~~~
  fs/ntfs3/namei.c:445:3: note: remove the 'if' if its condition is always false
                  if (toupper(c1) != toupper(c2)) {
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  fs/ntfs3/namei.c:434:7: error: variable 'uni1' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
                  if (!lm--) {
                      ^~~~~
  fs/ntfs3/namei.c:487:12: note: uninitialized use occurs here
          __putname(uni1);
                    ^~~~
  ./include/linux/fs.h:2789:65: note: expanded from macro '__putname'
  #define __putname(name)         kmem_cache_free(names_cachep, (void *)(name))
                                                                        ^~~~
  fs/ntfs3/namei.c:434:3: note: remove the 'if' if its condition is always false
                  if (!lm--) {
                  ^~~~~~~~~~~~
  fs/ntfs3/namei.c:430:22: note: initialize the variable 'uni1' to silence this warning
          struct cpu_str *uni1, *uni2;
                              ^
                              = NULL
  2 errors generated.

There is no point in calling __putname() in these particular error
paths, as there has been no corresponding __getname() call yet. Just
return directly in these blocks to clear up the warning.

Fixes: a3a956c78efa ("fs/ntfs3: Add option "nocase"")
Link: https://github.com/ClangBuiltLinux/linux/issues/1729
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

v2:
    * Pick up Nick's reviewed-by tag.
v1: https://lore.kernel.org/20221004144145.1345772-1-nathan@kernel.org/

 fs/ntfs3/namei.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 315763eb05ff..5d3a6ce3f05f 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -431,10 +431,8 @@ static int ntfs_d_compare(const struct dentry *dentry, unsigned int len1,
 
 	/* First try fast implementation. */
 	for (;;) {
-		if (!lm--) {
-			ret = len1 == len2 ? 0 : 1;
-			goto out;
-		}
+		if (!lm--)
+			return len1 == len2 ? 0 : 1;
 
 		if ((c1 = *n1++) == (c2 = *n2++))
 			continue;
@@ -442,10 +440,8 @@ static int ntfs_d_compare(const struct dentry *dentry, unsigned int len1,
 		if (c1 >= 0x80 || c2 >= 0x80)
 			break;
 
-		if (toupper(c1) != toupper(c2)) {
-			ret = 1;
-			goto out;
-		}
+		if (toupper(c1) != toupper(c2))
+			return 1;
 	}
 
 	/*

base-commit: d45da67caedacd500879de5e649360cc70777af7
-- 
2.37.3

