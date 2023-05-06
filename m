Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0144C6F91F6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 14:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjEFMYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 08:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjEFMYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 08:24:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3044914E7F;
        Sat,  6 May 2023 05:24:30 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f19afc4fbfso27836935e9.2;
        Sat, 06 May 2023 05:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683375868; x=1685967868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXMu9XhyUgA5r3iTebqKjw72HhkdRp9Ey4llH49+JM0=;
        b=W2b+Ywaawz6z8MAH/a2AOjPLUJ6jWy9pL6gIUHhAcxhI19CGysYfookylTFfB+/mui
         5ykH+LAnxZPJWrGhVFZw+Re4s4Tvg027+Ev7WYMhFRr0K+1ca/+27ajTlMKd6skKIJIz
         kVA2zagn7v6Z621aP7eJynCz8VYNDOiFCPABHCQM5hj6A5u5rUU4YVQ2asQnMh7kq0Oh
         NNIfTzfLTnXez6+qIvT4RhTRmShQlZ9Q7ACJD+v0VQ6j3N/gfJTW+sG9zykqt0RqyRct
         kk0+kbPEgplbEtt2g8xaBx2l0UZqMFtZoT5URpLz7AC0Mv3NvKCJ+0MUss4QBvYEgCeq
         nSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683375868; x=1685967868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXMu9XhyUgA5r3iTebqKjw72HhkdRp9Ey4llH49+JM0=;
        b=lNOno/WqEFKJip0Bg9h/WBMQZLrhdWpY78yLW2GItxo8zhJ5c9w6w1riAkOm+3t6ak
         QnssmdsPYHI2nj+ASHfD0Jp0q32IncOwMQC2s1iyRxPySzMsNXlwuzBFeNorfVVyVuCj
         mSVCFmFSn+Up7FH7z+hBOD5rgagbcVDz30EbWgFo/lUVg8ZnyEGuLVdwiFKDRmcF97e/
         2MNT/leynMai863HMBiKvStxkQ8SVRMIM1823XhfxQyKQcXqbERUqbZK2LZ4TnTTPpEb
         9fbXwPuzEbNeCDTku0A1PIbGEuB3airIxnpU8y/08+ntWI7BAb8aaCpJ/ZhETr0NFDz+
         1Xcw==
X-Gm-Message-State: AC+VfDy7Lan0T895PhWQCsKW03H69SA6gzKychk30vB0l2jr5+2mZgcs
        YGGu3H/thb51FjNsyaQ+JNY=
X-Google-Smtp-Source: ACHHUZ7lL8EH4fH1fY3FNvefzXrML8HRfgPHvYaPc2W9+3uw2WRmJW+RavMeJGer3IydXL41cytAxw==
X-Received: by 2002:a7b:c30d:0:b0:3f1:745d:821 with SMTP id k13-20020a7bc30d000000b003f1745d0821mr3149884wmj.23.1683375868405;
        Sat, 06 May 2023 05:24:28 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id y24-20020a05600c365800b003f31da39b62sm10680788wmq.18.2023.05.06.05.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 05:24:28 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Fabian Frederick <fabf@skynet.be>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tim Gardner <tim.gardner@canonical.com>,
        kernel test robot <lkp@intel.com>,
        Ron Economos <re@w6rz.net>,
        Nathan Chancellor <nathan@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] jffs2: reduce stack usage in jffs2_build_xattr_subsystem()
Date:   Sat,  6 May 2023 06:56:12 +0200
Message-Id: <20230506045612.16616-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabian Frederick <fabf@skynet.be>

Use kcalloc() for allocation/flush of 128 pointers table to
reduce stack usage.

Function now returns -ENOMEM or 0 on success.

stackusage
Before:
./fs/jffs2/xattr.c:775  jffs2_build_xattr_subsystem     1208
dynamic,bounded

After:
./fs/jffs2/xattr.c:775  jffs2_build_xattr_subsystem     192
dynamic,bounded

Also update definition when CONFIG_JFFS2_FS_XATTR is not enabled

Tested with an MTD mount point and some user set/getfattr.

Many current target on OpenWRT also suffer from a compilation warning
(that become an error with CONFIG_WERROR) with the following output:

fs/jffs2/xattr.c: In function 'jffs2_build_xattr_subsystem':
fs/jffs2/xattr.c:887:1: error: the frame size of 1088 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
  887 | }
      | ^

Using dynamic allocation fix this compilation warning.

Fixes: c9f700f840bd ("[JFFS2][XATTR] using 'delete marker' for xdatum/xref deletion")
Reported-by: Tim Gardner <tim.gardner@canonical.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Ron Economos <re@w6rz.net>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Fabian Frederick <fabf@skynet.be>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/jffs2/build.c |  5 ++++-
 fs/jffs2/xattr.c | 13 +++++++++----
 fs/jffs2/xattr.h |  4 ++--
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/jffs2/build.c b/fs/jffs2/build.c
index 837cd55fd4c5..6ae9d6fefb86 100644
--- a/fs/jffs2/build.c
+++ b/fs/jffs2/build.c
@@ -211,7 +211,10 @@ static int jffs2_build_filesystem(struct jffs2_sb_info *c)
 		ic->scan_dents = NULL;
 		cond_resched();
 	}
-	jffs2_build_xattr_subsystem(c);
+	ret = jffs2_build_xattr_subsystem(c);
+	if (ret)
+		goto exit;
+
 	c->flags &= ~JFFS2_SB_FLAG_BUILDING;
 
 	dbg_fsbuild("FS build complete\n");
diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index aa4048a27f31..3b6bdc9a49e1 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -772,10 +772,10 @@ void jffs2_clear_xattr_subsystem(struct jffs2_sb_info *c)
 }
 
 #define XREF_TMPHASH_SIZE	(128)
-void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
+int jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
 {
 	struct jffs2_xattr_ref *ref, *_ref;
-	struct jffs2_xattr_ref *xref_tmphash[XREF_TMPHASH_SIZE];
+	struct jffs2_xattr_ref **xref_tmphash;
 	struct jffs2_xattr_datum *xd, *_xd;
 	struct jffs2_inode_cache *ic;
 	struct jffs2_raw_node_ref *raw;
@@ -784,9 +784,12 @@ void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
 
 	BUG_ON(!(c->flags & JFFS2_SB_FLAG_BUILDING));
 
+	xref_tmphash = kcalloc(XREF_TMPHASH_SIZE,
+			       sizeof(struct jffs2_xattr_ref *), GFP_KERNEL);
+	if (!xref_tmphash)
+		return -ENOMEM;
+
 	/* Phase.1 : Merge same xref */
-	for (i=0; i < XREF_TMPHASH_SIZE; i++)
-		xref_tmphash[i] = NULL;
 	for (ref=c->xref_temp; ref; ref=_ref) {
 		struct jffs2_xattr_ref *tmp;
 
@@ -884,6 +887,8 @@ void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
 		     "%u of xref (%u dead, %u orphan) found.\n",
 		     xdatum_count, xdatum_unchecked_count, xdatum_orphan_count,
 		     xref_count, xref_dead_count, xref_orphan_count);
+	kfree(xref_tmphash);
+	return 0;
 }
 
 struct jffs2_xattr_datum *jffs2_setup_xattr_datum(struct jffs2_sb_info *c,
diff --git a/fs/jffs2/xattr.h b/fs/jffs2/xattr.h
index 720007b2fd65..1b5030a3349d 100644
--- a/fs/jffs2/xattr.h
+++ b/fs/jffs2/xattr.h
@@ -71,7 +71,7 @@ static inline int is_xattr_ref_dead(struct jffs2_xattr_ref *ref)
 #ifdef CONFIG_JFFS2_FS_XATTR
 
 extern void jffs2_init_xattr_subsystem(struct jffs2_sb_info *c);
-extern void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c);
+extern int jffs2_build_xattr_subsystem(struct jffs2_sb_info *c);
 extern void jffs2_clear_xattr_subsystem(struct jffs2_sb_info *c);
 
 extern struct jffs2_xattr_datum *jffs2_setup_xattr_datum(struct jffs2_sb_info *c,
@@ -103,7 +103,7 @@ extern ssize_t jffs2_listxattr(struct dentry *, char *, size_t);
 #else
 
 #define jffs2_init_xattr_subsystem(c)
-#define jffs2_build_xattr_subsystem(c)
+#define jffs2_build_xattr_subsystem(c)		(0)
 #define jffs2_clear_xattr_subsystem(c)
 
 #define jffs2_xattr_do_crccheck_inode(c, ic)
-- 
2.39.2

