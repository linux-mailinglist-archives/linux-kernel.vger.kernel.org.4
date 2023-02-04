Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDC768ABD9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 19:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjBDSeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 13:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDSd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 13:33:59 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA84F74A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 10:33:58 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id bd15so5844694pfb.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 10:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tjMR7K3b5Kxbe/ecjD43xajTi+1Ciwse0JLkSMzManQ=;
        b=gP51lVE2s5bzt77ug4Jirt2sJ9KLq+2knjVg1vT6QkeQIv2jntI19xpKL/A3y5RIw4
         d1kDPxMQ5SJQihGsgSYiK74m9k41HQubx6Dzs3JIuQxjFGSzzx1Z1SK3npORpmHhViG9
         /hERkahCWqjLzZl7c6EgyDR9uQsfzpRCWAG2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjMR7K3b5Kxbe/ecjD43xajTi+1Ciwse0JLkSMzManQ=;
        b=g5WSch2g0CxK2IIcALXTJyWg7vtJYQ2scl/V5LcV8691nwvba9IKXeZvdnqmoBzs3N
         obIYDXXM3Ghb3XnEVg7ksq/Q3Akc7qBdteK4tMG2dQ/lp5K2KuqQo/ga4G/P/URAQuah
         OiEH27jszmaZ6ix28CKBMWhBusEwk80lrCShiiKiDEbWtWqmczlYneGINU3SiKUiu4Ez
         CbbAlHX+O5BiW+ZOH7ifnBXJBxot6N9CldAaECGswK5HMN7AXbbXJ+dOnXgfwkB1myEP
         eNarRtCBy7o/y1+Khe8sH9R5Ad0qUrwJFNNUjn2bt6wLnJqLKsn7hKBBHleOc6d8aP21
         g1Nw==
X-Gm-Message-State: AO0yUKW4Gb4Yx1h9S8jQhdh8g/GhFB6MjsYMSI3W8D6sa1dIHL4Da42b
        Ex3NvY+9qzoDEncgYCzp/P/DWg==
X-Google-Smtp-Source: AK7set8Qy5ag0uw+C9t6p3KRMHFijC6yFjKLeaQsLbXKQJmtOfAue0KNa9fzYbjtw8f2q/9qK3HYDA==
X-Received: by 2002:a05:6a00:148c:b0:581:a8dc:8f95 with SMTP id v12-20020a056a00148c00b00581a8dc8f95mr17393606pfu.12.1675535637924;
        Sat, 04 Feb 2023 10:33:57 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y2-20020a62b502000000b00581013fcbe1sm3989425pfe.159.2023.02.04.10.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 10:33:57 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Dave Kleikamp <shaggy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        jfs-discussion@lists.sourceforge.net,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] jfs: Use unsigned variable for length calculations
Date:   Sat,  4 Feb 2023 10:33:56 -0800
Message-Id: <20230204183355.never.877-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2035; h=from:subject:message-id; bh=qy5amV+9oAJHi2pDUUi24oStp3zhT4GjDgSO9ZjwQdU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj3qUUOW+2sqiSqcPAuwBFQkx8VdagSv/Qd2WPhMrE HjNLesWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY96lFAAKCRCJcvTf3G3AJixHEA CovqX7WYT0FI5nLrmHV0oGrrFq8qD+SHE4oPNnWJnePRPVv/EbJwv5fMT8jgaWtxELd9wpHutI+U4q pDF0T4YA+mYNfJGubGMqbQ80tScS7U0SmJbwO1cTrNnM0qmMnzL1GNU0XYkIDRKUxXWtNIC2N/xnlx UyHOmSe7SflhrX9QiE7tFa7iE6G64K8hNmLzfy+nwoXuL5jbXfCPD3jgoOHt2+hmMlnwqI1GUfc9ek r/SH0QpT+OQB3QmhF7RCfZp57oIRdACC6cLp/nEhCU5QzCXJ/ghcyyUWHgehooi26dwgqDTVYQjM79 XpWmmVwn5lo3vtLnmPT85KAngV5qL0MxXS2TCC3vHuN0475+AteeBQcNbHztiRORt6JU+Vjt3YNosw XDM4MozD/ai55b+39+hCsQMsIqt+CW6FGL0zrHnSk7URkJpKv3c8gPylElAEyw/p1k3aKmOPx0+31z SKA1wOozEqSdOVyuEX3NARcM5caw7hxLSDVDGLOfjG5w35jaGYTMgFr2GE+12kEhq5zFaJilus6kxB mesYgiQfbApr15ZqLtUor3hqhopQYNHRWMqSa74rWCRX9gzP5sDAPooAEUz83XCv6ezOCf2X1bXWpg u7J34GxPPVu6l6Pm0rdKep5B5koJSctyA6Vva2PSbpZ533x09x5wb7UmPk8g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid confusing the compiler about possible negative sizes, switch
"ssize" which can never be negative from int to u32.  Seen with GCC 13:

../fs/jfs/namei.c: In function 'jfs_symlink': ../include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' pointer overflow between offset 0 and size [-2147483648, -1]
[-Warray-bounds=]
   57 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
...
../fs/jfs/namei.c:950:17: note: in expansion of macro 'memcpy'
  950 |                 memcpy(ip->i_link, name, ssize);
      |                 ^~~~~~

Cc: Dave Kleikamp <shaggy@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: jfs-discussion@lists.sourceforge.net
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/jfs/namei.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index b29d68b5eec5..494b9f4043cf 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -876,7 +876,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
 	tid_t tid;
 	ino_t ino = 0;
 	struct component_name dname;
-	int ssize;		/* source pathname size */
+	u32 ssize;		/* source pathname size */
 	struct btstack btstack;
 	struct inode *ip = d_inode(dentry);
 	s64 xlen = 0;
@@ -957,7 +957,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
 		if (ssize > sizeof (JFS_IP(ip)->i_inline))
 			JFS_IP(ip)->mode2 &= ~INLINEEA;
 
-		jfs_info("jfs_symlink: fast symlink added  ssize:%d name:%s ",
+		jfs_info("jfs_symlink: fast symlink added  ssize:%u name:%s ",
 			 ssize, name);
 	}
 	/*
@@ -987,7 +987,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
 		ip->i_size = ssize - 1;
 		while (ssize) {
 			/* This is kind of silly since PATH_MAX == 4K */
-			int copy_size = min(ssize, PSIZE);
+			u32 copy_size = min_t(u32, ssize, PSIZE);
 
 			mp = get_metapage(ip, xaddr, PSIZE, 1);
 
-- 
2.34.1

