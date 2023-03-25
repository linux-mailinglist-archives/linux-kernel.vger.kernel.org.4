Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844116C8B79
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjCYGKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjCYGKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:10:19 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6291A95C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:09:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VeZn9WA_1679724594;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VeZn9WA_1679724594)
          by smtp.aliyun-inc.com;
          Sat, 25 Mar 2023 14:09:55 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] erofs-utils: tests: enhance erofs/019
Date:   Sat, 25 Mar 2023 14:09:54 +0800
Message-Id: <20230325060954.63062-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test xattr in following cases:

- multiple inline xattrs for one single file
- multiple share xattrs for one single file
- mixed inline and share xattrs for one single file
- name/value field of xattr crosses block boundary

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---

This is used to test the refactoring on xattr on kernel side[1].

This patch relies on the "-b #blocksize" feature, and thus it needs to
be rebased to "-b experimental" branch of erofs-utils.

[1] https://lore.kernel.org/all/20230323000949.57608-1-jefflexu@linux.alibaba.com/

---
 tests/erofs/019 | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/tests/erofs/019 b/tests/erofs/019
index dac2ae3..f733516 100755
--- a/tests/erofs/019
+++ b/tests/erofs/019
@@ -15,6 +15,11 @@ cleanup()
 	rm -rf $tmp.*
 }
 
+generate_random()
+{
+	head -20 /dev/urandom | base64 -w0 | head -c $1
+}
+
 _require_erofs
 
 # remove previous $seqres.full before test
@@ -37,18 +42,37 @@ rm -rf $localdir
 mkdir -p $localdir
 
 # set random xattrs
-cp -nR ../ $localdir
-dirs=`ls $localdir`
-for d in $dirs; do
-	key=`head -20 /dev/urandom | cksum | cut -f1 -d " "`
-	val="0s"`head -3 /dev/urandom | base64 -w0`
-	setfattr -n user.$key -v $val $localdir/$d
-done
 
+# file1: multiple inline xattrs
+touch $localdir/file1
+setfattr -n user.p$(generate_random 16) -v $(generate_random 16) $localdir/file1
+# inline xattr (large name/value crossing block boundary)
+setfattr -n user.p$(generate_random 249) -v $(generate_random 1024) $localdir/file1
+
+# file2: multiple share xattrs
+s_key_1=$(generate_random 16)
+s_key_2=$(generate_random 16)
+s_val=$(generate_random 16)
+
+touch $localdir/file2
+setfattr -n user.s$s_key_1 -v $s_val $localdir/file2
+setfattr -n user.s$s_key_2 -v $s_val $localdir/file2
+
+# file3: mixed inline and share xattrs
+touch $localdir/file3
+setfattr -n user.p$(generate_random 16) -v $(generate_random 16) $localdir/file3
+setfattr -n user.s$s_key_1 -v $s_val $localdir/file3
+
+# file4: share xattr
+touch $localdir/file4
+setfattr -n user.s$s_key_2 -v $s_val $localdir/file4
+
+MKFS_OPTIONS="$MKFS_OPTIONS -b1024 -x1"
 _scratch_mkfs $localdir >> $seqres.full 2>&1 || _fail "failed to mkfs"
 _scratch_mount 2>>$seqres.full
 
 # check xattrs
+dirs=`ls $localdir`
 for d in $dirs; do
 	xattr1=`getfattr --absolute-names -d $localdir/$d | tail -n+2`
 	xattr2=`getfattr --absolute-names -d $SCRATCH_MNT/$d | tail -n+2`
-- 
1.8.3.1

