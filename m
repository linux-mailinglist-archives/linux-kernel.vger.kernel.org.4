Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9AA688C79
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 02:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBCBYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 20:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjBCBYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 20:24:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED0B84B64;
        Thu,  2 Feb 2023 17:24:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FBA3B810EE;
        Fri,  3 Feb 2023 01:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D815C433EF;
        Fri,  3 Feb 2023 01:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675387474;
        bh=IscsXZpj+h2AU0j+vLsryYQTUgOMPPGd5Jv1285ZrJk=;
        h=Date:From:To:Cc:Subject:From;
        b=QHKJhVUiPYk/zx3KeJ5KOmbtERStOiApOlVI2w8X9mB474wJY93F25VmERJ1N2mjC
         IzzAx4B80n6Joo+E9878meSE+QVA3miCcbWn9baxFmZQyXEOLwtB8MCmgKcm7JOHmT
         ZkjIuQ2cuM9hMe+6ZNZu1zAUV/jdwHi8/2ZtzJkccYEc8LHpseYYo2BcwGQxGK6SHF
         OBxC8TwD1aQgYpLmDx07lyS9jSZJFYnvW06gYJs8AJLh9PQMxbiEoibGRwgIxFJEtn
         UIn8n2KUQiBfNqadGk62a9bWHOV9ZeydUEA2VYnEdCBr0PKCV0fhnKHyAURdnez9xy
         mZ/TyOnl8yEYA==
Date:   Thu, 2 Feb 2023 19:24:50 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] xfs: Replace one-element arrays with flexible-array
 members
Message-ID: <Y9xiYmVLRIKdpJcC@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element arrays with flexible-array
members in structures xfs_attr_leaf_name_local and
xfs_attr_leaf_name_remote.

The only binary differences reported after the changes are all like
these:

fs/xfs/libxfs/xfs_attr_leaf.o
_@@ -435,7 +435,7 @@
      3b8:      movzbl 0x2(%rbx),%eax
      3bc:      rol    $0x8,%bp
      3c0:      movzwl %bp,%ebp
-     3c3:      lea    0x2(%rax,%rbp,1),%ebx
+     3c3:      lea    0x3(%rax,%rbp,1),%ebx
      3c7:      call   3cc <xfs_attr_leaf_entsize+0x8c>
                        3c8: R_X86_64_PLT32     __tsan_func_exit-0x4
      3cc:      or     $0x3,%ebx
_@@ -454,7 +454,7 @@
      3ea:      movzbl 0x8(%rbx),%ebx
      3ee:      call   3f3 <xfs_attr_leaf_entsize+0xb3>
                        3ef: R_X86_64_PLT32     __tsan_func_exit-0x4
-     3f3:      add    $0xa,%ebx
+     3f3:      add    $0xb,%ebx
      3f6:      or     $0x3,%ebx
      3f9:      add    $0x1,%ebx
      3fc:      mov    %ebx,%eax

similar changes in fs/xfs/scrub/attr.o and fs/xfs/xfs.o object files.

And the reason for this is because of the round_up() macro called in
functions xfs_attr_leaf_entsize_remote() and xfs_attr_leaf_entsize_local(),
which is compensanting for the one-byte reduction in size (due to the
flex-array transformation) of structures xfs_attr_leaf_name_remote and
xfs_attr_leaf_name_local. So, sizes remain the same before and after
changes.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/251
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/xfs/libxfs/xfs_da_format.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 25e2841084e1..e1e62ebb0c44 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -620,14 +620,14 @@ typedef struct xfs_attr_leaf_entry {	/* sorted on key, not name */
 typedef struct xfs_attr_leaf_name_local {
 	__be16	valuelen;		/* number of bytes in value */
 	__u8	namelen;		/* length of name bytes */
-	__u8	nameval[1];		/* name/value bytes */
+	__u8	nameval[];		/* name/value bytes */
 } xfs_attr_leaf_name_local_t;
 
 typedef struct xfs_attr_leaf_name_remote {
 	__be32	valueblk;		/* block number of value bytes */
 	__be32	valuelen;		/* number of bytes in value */
 	__u8	namelen;		/* length of name bytes */
-	__u8	name[1];		/* name bytes */
+	__u8	name[];			/* name bytes */
 } xfs_attr_leaf_name_remote_t;
 
 typedef struct xfs_attr_leafblock {
@@ -747,13 +747,13 @@ xfs_attr3_leaf_name_local(xfs_attr_leafblock_t *leafp, int idx)
  */
 static inline int xfs_attr_leaf_entsize_remote(int nlen)
 {
-	return round_up(sizeof(struct xfs_attr_leaf_name_remote) - 1 +
+	return round_up(sizeof(struct xfs_attr_leaf_name_remote) +
 			nlen, XFS_ATTR_LEAF_NAME_ALIGN);
 }
 
 static inline int xfs_attr_leaf_entsize_local(int nlen, int vlen)
 {
-	return round_up(sizeof(struct xfs_attr_leaf_name_local) - 1 +
+	return round_up(sizeof(struct xfs_attr_leaf_name_local) +
 			nlen + vlen, XFS_ATTR_LEAF_NAME_ALIGN);
 }
 
-- 
2.34.1

