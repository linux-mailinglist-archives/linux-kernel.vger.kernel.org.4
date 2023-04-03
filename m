Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE806D3B12
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 02:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjDCAXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 20:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDCAXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 20:23:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D996EB2;
        Sun,  2 Apr 2023 17:23:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4105CB81058;
        Mon,  3 Apr 2023 00:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D112C433EF;
        Mon,  3 Apr 2023 00:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680481394;
        bh=xmEFhZDNo4dBvIzk569bzeQQAOjzCn0luUdNYrzsjyg=;
        h=From:Date:Subject:To:Cc:From;
        b=SRYT6OR8Osk/pIeNqlxHvSaMKuPUhZn6Buc9JWHezPrPk2qiz/KcaBPK0vXcfwd5g
         y9qCWfk/4mp6MookP0mKNGDw1uisjrErOwZqyaafX8jP6HKF4kJsJR43GT1w8ZSp3s
         0gGgghTxOZw4jx2vLwLpjtOkTKbU1eUmQOhtpJWqDV/pfRbcTobXls0ybwuKvxSVKo
         8ci/oa8ycsJA+BftNvlecpWHwwkqHmMDvWRwBElXrWN+znvfsRb3/VNqGJSaykg3cN
         o62KSlyweTB2rjOJ9TGgR6g909J2eMytx+yQXsS+k+4mrGlaiNgrWv7DAta4VvNyht
         p5s6bTFPFUsiw==
From:   Eric Van Hensbergen <ericvh@kernel.org>
Date:   Mon, 03 Apr 2023 00:22:53 +0000
Subject: [PATCH v2] fs/9p: Rework cache modes and add new options to
 Documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230401-ericvh-dev-rework-cache-options-v2-1-e1c94704cf83@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFwcKmQC/42OSwqDMBCGryJZd9qYiJSueg9xkcdogiWRiaQW8
 e6N9gJlVt/wvzaWkDwm9qg2Rph98jEUEJeKGafCiOBtYSa4kLzhNRS5yQ4sZiB8R5rAKOMQ4rw
 UawJh2lbeNSrRcFZStEoImlQw7sj52W9DJAi4LodiJhz8em7o+sLOpyXS55yU6+P7f3uuoZywU
 lltrZTqOSEFfF0jjazf9/0L+pzWuPEAAAA=
To:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs@lists.linux.dev
Cc:     v9fs-developer@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=25401; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=xmEFhZDNo4dBvIzk569bzeQQAOjzCn0luUdNYrzsjyg=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBkKhxxJoeylnwiBaDfF98zr+9xm4CzPLLY2zMpM
 witWwM+eqqJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZCoccQAKCRCI/9X7Sl//
 mMGqD/4zg5+WzfaBMZ85fHM9MWh4M8KkF9xO9dHHhmT0vXbco1j9dCRUN64Aw6F6Ren0t6tOA1Y
 kD3UFzk+u5hH9MzFPrniXAPe2hpX9YPBCZJtSas4IQb2C5UR99sfFVHF7+LnUikLGdI2hZf1HeN
 ZyVZltNWhxIG4tNKpgsVL9U9BHlff3cxDZzwXvMkQ0Qp3Ldl0yaqolk4cbJ/5ZbVPjwRq86jCe2
 9HLobkBjzTSefV0XlAEmeG5+CBCVGCwfadlMCiYYwhjD7R3LIGRXtVKbBXDOjamyOVwlmWS0Dnn
 4IcB/u6dhYItLYIWl590IsuFa/21t0zHnJfGgF0qeahWd+DapPconM51mcqYARRlaByYuc+uOaV
 DzQ1S6UnkpCO4Wl3ywetChssXVXjverKd4JbfA0gup1dRcR80wqxYknPeivqPkhx97bzyt2opqD
 mqOKQ2bAjzPpGC7PoUCSEPVKy9rFlvNvRRpcr3RPveVxNM/XnzQ/INGcaOMhnWfatl/qg0JfqlZ
 JCxw9B6sZjBGfCk765L5WwtOBvz6+jVmaN9nVKmI+FCkcRWAkv42ULAv5YORBkA/JWrBQc7bTun
 cBcGnGfJ/4Ib1ffzQh9Ww9BlPTid9kpDGKPWjwQjEEk/q9enMb4bhFLrCYhfZ6aF1CCurIfdUPN
 TMHi/+KhHWU2Rgg==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch cache modes to a bit-mask and use legacy
cache names as shortcuts.  Update documentation to
include information on both shortcuts and bitmasks.

This patch also fixes missing guards related to fscache.

Update the documentation for new mount flags
and cache modes.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
Changes in v2:
- fix format issues in Documentation as Reported by Randy Dunlap <rdunlap@infradead.org>
- fix unused variable warnings when FSCACHE isn't enabled as Reported-by: kernel test robot <lkp@intel.com> 
- Link to v1: https://lore.kernel.org/r/20230401-ericvh-dev-rework-cache-options-v1-1-12d3adbdd33a@kernel.org
---
 Documentation/filesystems/9p.rst | 50 ++++++++++++++++++++++--------
 fs/9p/cache.h                    |  3 +-
 fs/9p/fid.h                      |  4 +--
 fs/9p/v9fs.c                     | 34 +++++++-------------
 fs/9p/v9fs.h                     | 67 ++++++++++++++++++++++++++--------------
 fs/9p/vfs_addr.c                 | 28 ++++++++++-------
 fs/9p/vfs_file.c                 | 10 +++---
 fs/9p/vfs_inode.c                | 34 +++++++++++++-------
 fs/9p/vfs_inode_dotl.c           | 26 +++++++++-------
 fs/9p/vfs_super.c                |  4 +--
 10 files changed, 153 insertions(+), 107 deletions(-)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index 0e800b8f73cc..1b5f0cc3e4ca 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -78,19 +78,39 @@ Options
   		offering several exported file systems.
 
   cache=mode	specifies a caching policy.  By default, no caches are used.
-
-                        none
-				default no cache policy, metadata and data
-                                alike are synchronous.
-			loose
-				no attempts are made at consistency,
-                                intended for exclusive, read-only mounts
-                        fscache
-				use FS-Cache for a persistent, read-only
-				cache backend.
-                        mmap
-				minimal cache that is only used for read-write
-                                mmap.  Northing else is cached, like cache=none
+		The mode can be specified as a bitmask or by using one of the
+		prexisting common 'shortcuts'.
+		The bitmask is described below: (unspecified bits are reserved)
+
+			==========  ====================================================
+			0b00000000  all caches disabled, mmap disabled
+			0b00000001  file caches enabled
+			0b00000010  meta-data caches enabled
+			0b00000100  writeback behavior (as opposed to writethrough)
+			0b00001000  loose caches (no explicit consistency with server)
+			0b10000000  fscache enabled for persistent caching
+			==========  ====================================================
+
+		The current shortcuts and their associated bitmask are:
+
+			=========   ====================================================
+			none        0b00000000 (no caching)
+			readahead   0b00000001 (only read-ahead file caching)
+			mmap        0b00000101 (read-ahead + writeback file cache)
+			loose       0b00001111 (non-coherent file and meta-data caches)
+			fscache     0b10001111 (persistent loose cache)
+			=========   ====================================================
+
+		NOTE: only these shortcuts are tested modes of operation at the
+		moment, so using other combinations of bit-patterns is not
+		known to work.  Work on better cache support is in progress.
+
+		IMPORTANT: loose caches (and by extension at the moment fscache)
+		do not necessarily validate cached values on the server.  In other
+		words changes on the server are not guaranteed to be reflected
+		on the client system.  Only use this mode of operation if you
+		have an exclusive mount and the server will modify the filesystem
+		underneath you.
 
   debug=n	specifies debug level.  The debug level is a bitmask.
 
@@ -137,6 +157,10 @@ Options
   		This can be used to share devices/named pipes/sockets between
 		hosts.  This functionality will be expanded in later versions.
 
+  directio	bypass page cache on all read/write operations
+
+  ignoreqv	ignore qid.version==0 as a marker to ignore cache
+
   noxattr	do not offer xattr functions on this mount.
 
   access	there are four access modes.
diff --git a/fs/9p/cache.h b/fs/9p/cache.h
index 1923affcdc62..ee1b6b06a2fd 100644
--- a/fs/9p/cache.h
+++ b/fs/9p/cache.h
@@ -8,9 +8,8 @@
 #ifndef _9P_CACHE_H
 #define _9P_CACHE_H
 
-#include <linux/fscache.h>
-
 #ifdef CONFIG_9P_FSCACHE
+#include <linux/fscache.h>
 
 extern int v9fs_cache_session_get_cookie(struct v9fs_session_info *v9ses,
 					  const char *dev_name);
diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 11576e1364bf..0c51889a60b3 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -56,11 +56,9 @@ static inline void v9fs_fid_add_modes(struct p9_fid *fid, int s_flags,
 	   ((fid->qid.version == 0) && !(s_flags & V9FS_IGNORE_QV)) ||
 	   (s_flags & V9FS_DIRECT_IO) || (f_flags & O_DIRECT)) {
 		fid->mode |= P9L_DIRECT; /* no read or write cache */
-	} else if ((s_cache < CACHE_WRITEBACK) ||
+	} else if ((!(s_cache & CACHE_WRITEBACK)) ||
 				(f_flags & O_DSYNC) | (s_flags & V9FS_SYNC)) {
 		fid->mode |= P9L_NOWRITECACHE;
-	} else if (s_cache == CACHE_LOOSE) {
-		fid->mode |= P9L_LOOSE; /* noncoherent cache */
 	}
 }
 #endif
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 43d3806150a9..c7f774fe398f 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -66,40 +66,30 @@ static const match_table_t tokens = {
 	{Opt_err, NULL}
 };
 
-static const char *const v9fs_cache_modes[nr__p9_cache_modes] = {
-	[CACHE_NONE]		= "none",
-	[CACHE_READAHEAD]	= "readahead",
-	[CACHE_WRITEBACK]	= "writeback",
-	[CACHE_MMAP]		= "mmap",
-	[CACHE_LOOSE]		= "loose",
-	[CACHE_FSCACHE]		= "fscache",
-};
-
 /* Interpret mount options for cache mode */
 static int get_cache_mode(char *s)
 {
 	int version = -EINVAL;
 
 	if (!strcmp(s, "loose")) {
-		version = CACHE_LOOSE;
+		version = CACHE_SC_LOOSE;
 		p9_debug(P9_DEBUG_9P, "Cache mode: loose\n");
 	} else if (!strcmp(s, "fscache")) {
-		version = CACHE_FSCACHE;
+		version = CACHE_SC_FSCACHE;
 		p9_debug(P9_DEBUG_9P, "Cache mode: fscache\n");
 	} else if (!strcmp(s, "mmap")) {
-		version = CACHE_MMAP;
+		version = CACHE_SC_MMAP;
 		p9_debug(P9_DEBUG_9P, "Cache mode: mmap\n");
-	} else if (!strcmp(s, "writeback")) {
-		version = CACHE_WRITEBACK;
-		p9_debug(P9_DEBUG_9P, "Cache mode: writeback\n");
 	} else if (!strcmp(s, "readahead")) {
-		version = CACHE_READAHEAD;
+		version = CACHE_SC_READAHEAD;
 		p9_debug(P9_DEBUG_9P, "Cache mode: readahead\n");
 	} else if (!strcmp(s, "none")) {
-		version = CACHE_NONE;
+		version = CACHE_SC_NONE;
 		p9_debug(P9_DEBUG_9P, "Cache mode: none\n");
-	} else
-		pr_info("Unknown Cache mode %s\n", s);
+	} else if (kstrtoint(s, 0, &version) != 0) {
+		version = -EINVAL;
+		pr_info("Unknown Cache mode or invalid value %s\n", s);
+	}
 	return version;
 }
 
@@ -127,9 +117,9 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 	if (v9ses->nodev)
 		seq_puts(m, ",nodevmap");
 	if (v9ses->cache)
-		seq_printf(m, ",cache=%s", v9fs_cache_modes[v9ses->cache]);
+		seq_printf(m, ",cache=%x", v9ses->cache);
 #ifdef CONFIG_9P_FSCACHE
-	if (v9ses->cachetag && v9ses->cache == CACHE_FSCACHE)
+	if (v9ses->cachetag && (v9ses->cache & CACHE_FSCACHE))
 		seq_printf(m, ",cachetag=%s", v9ses->cachetag);
 #endif
 
@@ -481,7 +471,7 @@ struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
 
 #ifdef CONFIG_9P_FSCACHE
 	/* register the session for caching */
-	if (v9ses->cache == CACHE_FSCACHE) {
+	if (v9ses->cache & CACHE_FSCACHE) {
 		rc = v9fs_cache_session_get_cookie(v9ses, dev_name);
 		if (rc < 0)
 			goto err_clnt;
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 999cdbcbfed9..06a2514f0d88 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -31,35 +31,54 @@
 #define V9FS_ACL_MASK V9FS_POSIX_ACL
 
 enum p9_session_flags {
-	V9FS_PROTO_2000U	= 0x01,
-	V9FS_PROTO_2000L	= 0x02,
-	V9FS_ACCESS_SINGLE	= 0x04,
-	V9FS_ACCESS_USER	= 0x08,
-	V9FS_ACCESS_CLIENT	= 0x10,
-	V9FS_POSIX_ACL		= 0x20,
-	V9FS_NO_XATTR		= 0x40,
-	V9FS_IGNORE_QV		= 0x80, /* ignore qid.version for cache hints */
-	V9FS_DIRECT_IO		= 0x100,
-	V9FS_SYNC		= 0x200
+	V9FS_PROTO_2000U    = 0x01,
+	V9FS_PROTO_2000L    = 0x02,
+	V9FS_ACCESS_SINGLE  = 0x04,
+	V9FS_ACCESS_USER    = 0x08,
+	V9FS_ACCESS_CLIENT  = 0x10,
+	V9FS_POSIX_ACL      = 0x20,
+	V9FS_NO_XATTR       = 0x40,
+	V9FS_IGNORE_QV      = 0x80, /* ignore qid.version for cache hints */
+	V9FS_DIRECT_IO      = 0x100,
+	V9FS_SYNC           = 0x200
 };
 
-/* possible values of ->cache */
 /**
- * enum p9_cache_modes - user specified cache preferences
- * @CACHE_NONE: do not cache data, dentries, or directory contents (default)
- * @CACHE_LOOSE: cache data, dentries, and directory contents w/no consistency
+ * enum p9_cache_shortcuts - human readable cache preferences
+ * @CACHE_SC_NONE: disable all caches
+ * @CACHE_SC_READAHEAD: only provide caching for readahead
+ * @CACHE_SC_MMAP: provide caching to enable mmap
+ * @CACHE_SC_LOOSE: non-coherent caching for files and meta data
+ * @CACHE_SC_FSCACHE: persistent non-coherent caching for files and meta-data
  *
- * eventually support loose, tight, time, session, default always none
  */
 
-enum p9_cache_modes {
-	CACHE_NONE,
-	CACHE_READAHEAD,
-	CACHE_WRITEBACK,
-	CACHE_MMAP,
-	CACHE_LOOSE,
-	CACHE_FSCACHE,
-	nr__p9_cache_modes
+enum p9_cache_shortcuts {
+	CACHE_SC_NONE       = 0b00000000,
+	CACHE_SC_READAHEAD  = 0b00000001,
+	CACHE_SC_MMAP       = 0b00000101,
+	CACHE_SC_LOOSE      = 0b00001111,
+	CACHE_SC_FSCACHE    = 0b10001111,
+};
+
+/**
+ * enum p9_cache_bits - possible values of ->cache
+ * @CACHE_NONE: caches disabled
+ * @CACHE_FILE: file caching (open to close)
+ * @CACHE_META: meta-data and directory caching
+ * @CACHE_WRITEBACK: write-back caching for files
+ * @CACHE_LOOSE: don't check cache consistency
+ * @CACHE_FSCACHE: local persistent caches
+ *
+ */
+
+enum p9_cache_bits {
+	CACHE_NONE          = 0b00000000,
+	CACHE_FILE          = 0b00000001,
+	CACHE_META          = 0b00000010,
+	CACHE_WRITEBACK     = 0b00000100,
+	CACHE_LOOSE         = 0b00001000,
+	CACHE_FSCACHE       = 0b10000000,
 };
 
 /**
@@ -68,7 +87,7 @@ enum p9_cache_modes {
  * @nodev: set to 1 to disable device mapping
  * @debug: debug level
  * @afid: authentication handle
- * @cache: cache mode of type &p9_cache_modes
+ * @cache: cache mode of type &p9_cache_bits
  * @cachetag: the tag of the cache associated with this session
  * @fscache: session cookie associated with FS-Cache
  * @uname: string user name to mount hierarchy as
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 211165430a8a..9239a049f736 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -115,8 +115,6 @@ const struct netfs_request_ops v9fs_req_ops = {
 
 static bool v9fs_release_folio(struct folio *folio, gfp_t gfp)
 {
-	struct inode *inode = folio_inode(folio);
-
 	if (folio_test_private(folio))
 		return false;
 #ifdef CONFIG_9P_FSCACHE
@@ -125,8 +123,8 @@ static bool v9fs_release_folio(struct folio *folio, gfp_t gfp)
 			return false;
 		folio_wait_fscache(folio);
 	}
+	fscache_note_page_release(v9fs_inode_cookie(V9FS_I(folio_inode(folio))));
 #endif
-	fscache_note_page_release(v9fs_inode_cookie(V9FS_I(inode)));
 	return true;
 }
 
@@ -136,6 +134,7 @@ static void v9fs_invalidate_folio(struct folio *folio, size_t offset,
 	folio_wait_fscache(folio);
 }
 
+#ifdef CONFIG_9P_FSCACHE
 static void v9fs_write_to_cache_done(void *priv, ssize_t transferred_or_error,
 				     bool was_async)
 {
@@ -149,18 +148,19 @@ static void v9fs_write_to_cache_done(void *priv, ssize_t transferred_or_error,
 				   i_size_read(&v9inode->netfs.inode), 0);
 	}
 }
+#endif
 
 static int v9fs_vfs_write_folio_locked(struct folio *folio)
 {
 	struct inode *inode = folio_inode(folio);
-	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct fscache_cookie *cookie = v9fs_inode_cookie(v9inode);
 	loff_t start = folio_pos(folio);
 	loff_t i_size = i_size_read(inode);
 	struct iov_iter from;
 	size_t len = folio_size(folio);
 	struct p9_fid *writeback_fid;
 	int err;
+	struct v9fs_inode __maybe_unused *v9inode = V9FS_I(inode);
+	struct fscache_cookie __maybe_unused *cookie = v9fs_inode_cookie(v9inode);
 
 	if (start >= i_size)
 		return 0; /* Simultaneous truncation occurred */
@@ -181,15 +181,17 @@ static int v9fs_vfs_write_folio_locked(struct folio *folio)
 
 	p9_client_write(writeback_fid, start, &from, &err);
 
+#ifdef CONFIG_9P_FSCACHE
 	if (err == 0 &&
-	    fscache_cookie_enabled(cookie) &&
-	    test_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags)) {
+		fscache_cookie_enabled(cookie) &&
+		test_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags)) {
 		folio_start_fscache(folio);
 		fscache_write_to_cache(v9fs_inode_cookie(v9inode),
-				       folio_mapping(folio), start, len, i_size,
-				       v9fs_write_to_cache_done, v9inode,
-				       true);
+					folio_mapping(folio), start, len, i_size,
+					v9fs_write_to_cache_done, v9inode,
+					true);
 	}
+#endif
 
 	folio_end_writeback(folio);
 	p9_fid_put(writeback_fid);
@@ -300,7 +302,6 @@ static int v9fs_write_end(struct file *filp, struct address_space *mapping,
 	loff_t last_pos = pos + copied;
 	struct folio *folio = page_folio(subpage);
 	struct inode *inode = mapping->host;
-	struct v9fs_inode *v9inode = V9FS_I(inode);
 
 	p9_debug(P9_DEBUG_VFS, "filp %p, mapping %p\n", filp, mapping);
 
@@ -320,7 +321,10 @@ static int v9fs_write_end(struct file *filp, struct address_space *mapping,
 	if (last_pos > inode->i_size) {
 		inode_add_bytes(inode, last_pos - inode->i_size);
 		i_size_write(inode, last_pos);
-		fscache_update_cookie(v9fs_inode_cookie(v9inode), NULL, &last_pos);
+#ifdef CONFIG_9P_FSCACHE
+		fscache_update_cookie(v9fs_inode_cookie(V9FS_I(inode)), NULL,
+			&last_pos);
+#endif
 	}
 	folio_mark_dirty(folio);
 out:
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 9f1d464bc1b5..07a67ac37ce2 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -41,13 +41,11 @@ static const struct vm_operations_struct v9fs_mmap_file_vm_ops;
 int v9fs_file_open(struct inode *inode, struct file *file)
 {
 	int err;
-	struct v9fs_inode *v9inode;
 	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid;
 	int omode;
 
 	p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, file);
-	v9inode = V9FS_I(inode);
 	v9ses = v9fs_inode2v9ses(inode);
 	if (v9fs_proto_dotl(v9ses))
 		omode = v9fs_open_to_dotl_flags(file->f_flags);
@@ -60,7 +58,7 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 		if (IS_ERR(fid))
 			return PTR_ERR(fid);
 
-		if ((v9ses->cache >= CACHE_WRITEBACK) && (omode & P9_OWRITE)) {
+		if ((v9ses->cache & CACHE_WRITEBACK) && (omode & P9_OWRITE)) {
 			int writeback_omode = (omode & ~P9_OWRITE) | P9_ORDWR;
 
 			p9_debug(P9_DEBUG_CACHE, "write-only file with writeback enabled, try opening O_RDWR\n");
@@ -85,8 +83,8 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 	}
 
 #ifdef CONFIG_9P_FSCACHE
-	if (v9ses->cache == CACHE_FSCACHE)
-		fscache_use_cookie(v9fs_inode_cookie(v9inode),
+	if (v9ses->cache & CACHE_FSCACHE)
+		fscache_use_cookie(v9fs_inode_cookie(V9FS_I(inode)),
 				   file->f_mode & FMODE_WRITE);
 #endif
 	v9fs_fid_add_modes(fid, v9ses->flags, v9ses->cache, file->f_flags);
@@ -485,7 +483,7 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	p9_debug(P9_DEBUG_MMAP, "filp :%p\n", filp);
 
-	if (v9ses->cache < CACHE_MMAP) {
+	if (!(v9ses->cache & CACHE_WRITEBACK)) {
 		p9_debug(P9_DEBUG_CACHE, "(no mmap mode)");
 		if (vma->vm_flags & VM_MAYSHARE)
 			return -ENODEV;
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index fb5e5c0e41e4..54dfe4f10f43 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -371,17 +371,23 @@ struct inode *v9fs_get_inode(struct super_block *sb, umode_t mode, dev_t rdev)
  */
 void v9fs_evict_inode(struct inode *inode)
 {
-	struct v9fs_inode *v9inode = V9FS_I(inode);
-	__le32 version;
+	struct v9fs_inode __maybe_unused *v9inode = V9FS_I(inode);
+	__le32 __maybe_unused version;
 
 	truncate_inode_pages_final(&inode->i_data);
+
+#ifdef CONFIG_9P_FSCACHE
 	version = cpu_to_le32(v9inode->qid.version);
 	fscache_clear_inode_writeback(v9fs_inode_cookie(v9inode), inode,
 				      &version);
+#endif
+
 	clear_inode(inode);
 	filemap_fdatawrite(&inode->i_data);
 
+#ifdef CONFIG_9P_FSCACHE
 	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
+#endif
 }
 
 static int v9fs_test_inode(struct inode *inode, void *data)
@@ -761,7 +767,7 @@ struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
 		inode = NULL;
 	else if (IS_ERR(fid))
 		inode = ERR_CAST(fid);
-	else if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
+	else if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
 		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
 	else
 		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
@@ -790,7 +796,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 {
 	int err;
 	u32 perm;
-	struct v9fs_inode *v9inode;
+	struct v9fs_inode __maybe_unused *v9inode;
 	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid;
 	struct dentry *res = NULL;
@@ -816,7 +822,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	perm = unixmode2p9mode(v9ses, mode);
 	p9_omode = v9fs_uflags2omode(flags, v9fs_proto_dotu(v9ses));
 
-	if ((v9ses->cache >= CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)) {
+	if ((v9ses->cache & CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)) {
 		p9_omode = (p9_omode & !P9_OWRITE) | P9_ORDWR;
 		p9_debug(P9_DEBUG_CACHE,
 			"write-only file with writeback enabled, creating w/ O_RDWR\n");
@@ -835,9 +841,11 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		goto error;
 
 	file->private_data = fid;
-	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
+#ifdef CONFIG_9P_FSCACHE
+	if (v9ses->cache & CACHE_FSCACHE)
 		fscache_use_cookie(v9fs_inode_cookie(v9inode),
 				   file->f_mode & FMODE_WRITE);
+#endif
 
 	v9fs_fid_add_modes(fid, v9ses->flags, v9ses->cache, file->f_flags);
 	v9fs_open_fid_add(inode, &fid);
@@ -1008,10 +1016,10 @@ v9fs_vfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
 	v9ses = v9fs_dentry2v9ses(dentry);
-	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
+	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
 		generic_fillattr(&nop_mnt_idmap, inode, stat);
 		return 0;
-	} else if (v9ses->cache >= CACHE_WRITEBACK) {
+	} else if (v9ses->cache & CACHE_WRITEBACK) {
 		if (S_ISREG(inode->i_mode)) {
 			int retval = filemap_fdatawrite(inode->i_mapping);
 
@@ -1050,7 +1058,6 @@ static int v9fs_vfs_setattr(struct mnt_idmap *idmap,
 {
 	int retval, use_dentry = 0;
 	struct inode *inode = d_inode(dentry);
-	struct v9fs_inode *v9inode = V9FS_I(inode);
 	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid = NULL;
 	struct p9_wstat wstat;
@@ -1115,8 +1122,13 @@ static int v9fs_vfs_setattr(struct mnt_idmap *idmap,
 		truncate_setsize(inode, iattr->ia_size);
 		truncate_pagecache(inode, iattr->ia_size);
 
-		if (v9ses->cache == CACHE_FSCACHE)
+#ifdef CONFIG_9P_FSCACHE
+		if (v9ses->cache & CACHE_FSCACHE) {
+			struct v9fs_inode *v9inode = V9FS_I(inode);
+
 			fscache_resize_cookie(v9fs_inode_cookie(v9inode), iattr->ia_size);
+		}
+#endif
 	}
 
 	v9fs_invalidate_inode_attr(inode);
@@ -1400,7 +1412,7 @@ int v9fs_refresh_inode(struct p9_fid *fid, struct inode *inode)
 	 * We don't want to refresh inode->i_size,
 	 * because we may have cached data
 	 */
-	flags = (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) ?
+	flags = (v9ses->cache & CACHE_LOOSE) ?
 		V9FS_STAT2INODE_KEEP_ISIZE : 0;
 	v9fs_stat2inode(st, inode, inode->i_sb, flags);
 out:
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 4b9488cb7a56..f9371b5b70ea 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -287,7 +287,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 		goto out;
 	}
 
-	if ((v9ses->cache >= CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)) {
+	if ((v9ses->cache & CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)) {
 		p9_omode = (p9_omode & !P9_OWRITE) | P9_ORDWR;
 		p9_debug(P9_DEBUG_CACHE,
 			"write-only file with writeback enabled, creating w/ O_RDWR\n");
@@ -325,7 +325,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 		goto out;
 	file->private_data = ofid;
 #ifdef CONFIG_9P_FSCACHE
-	if (v9ses->cache == CACHE_FSCACHE) {
+	if (v9ses->cache & CACHE_FSCACHE) {
 		struct v9fs_inode *v9inode = V9FS_I(inode);
 		fscache_use_cookie(v9fs_inode_cookie(v9inode),
 				   file->f_mode & FMODE_WRITE);
@@ -403,7 +403,7 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 	}
 
 	/* instantiate inode and assign the unopened fid to the dentry */
-	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
+	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
 		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
@@ -451,7 +451,7 @@ v9fs_vfs_getattr_dotl(struct mnt_idmap *idmap,
 
 	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
 	v9ses = v9fs_dentry2v9ses(dentry);
-	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
+	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
 		generic_fillattr(&nop_mnt_idmap, inode, stat);
 		return 0;
 	} else if (v9ses->cache) {
@@ -538,8 +538,7 @@ int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
 {
 	int retval, use_dentry = 0;
 	struct inode *inode = d_inode(dentry);
-	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct v9fs_session_info *v9ses;
+	struct v9fs_session_info __maybe_unused *v9ses;
 	struct p9_fid *fid = NULL;
 	struct p9_iattr_dotl p9attr = {
 		.uid = INVALID_UID,
@@ -603,8 +602,11 @@ int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
 		truncate_setsize(inode, iattr->ia_size);
 		truncate_pagecache(inode, iattr->ia_size);
 
-		if (v9ses->cache == CACHE_FSCACHE)
-			fscache_resize_cookie(v9fs_inode_cookie(v9inode), iattr->ia_size);
+#ifdef CONFIG_9P_FSCACHE
+		if (v9ses->cache & CACHE_FSCACHE)
+			fscache_resize_cookie(v9fs_inode_cookie(V9FS_I(inode)),
+				iattr->ia_size);
+#endif
 	}
 
 	v9fs_invalidate_inode_attr(inode);
@@ -732,7 +734,7 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 	}
 
 	v9fs_invalidate_inode_attr(dir);
-	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
+	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
 		/* Now walk from the parent so we can get an unopened fid. */
 		fid = p9_client_walk(dfid, 1, &name, 1);
 		if (IS_ERR(fid)) {
@@ -809,7 +811,7 @@ v9fs_vfs_link_dotl(struct dentry *old_dentry, struct inode *dir,
 	}
 
 	v9fs_invalidate_inode_attr(dir);
-	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
+	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
 		/* Get the latest stat info from server. */
 		struct p9_fid *fid;
 
@@ -886,7 +888,7 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 	}
 
 	/* instantiate inode and assign the unopened fid to the dentry */
-	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
+	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
 		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
@@ -971,7 +973,7 @@ int v9fs_refresh_inode_dotl(struct p9_fid *fid, struct inode *inode)
 	 * We don't want to refresh inode->i_size,
 	 * because we may have cached data
 	 */
-	flags = (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) ?
+	flags = (v9ses->cache & CACHE_LOOSE) ?
 		V9FS_STAT2INODE_KEEP_ISIZE : 0;
 	v9fs_stat2inode_dotl(st, inode, flags);
 out:
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index af83b39e340c..c6cbc666a4c1 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -136,7 +136,7 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 	if (retval)
 		goto release_sb;
 
-	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
+	if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
 		sb->s_d_op = &v9fs_cached_dentry_operations;
 	else
 		sb->s_d_op = &v9fs_dentry_operations;
@@ -277,7 +277,7 @@ static int v9fs_drop_inode(struct inode *inode)
 	struct v9fs_session_info *v9ses;
 
 	v9ses = v9fs_inode2v9ses(inode);
-	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
+	if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
 		return generic_drop_inode(inode);
 	/*
 	 * in case of non cached mode always drop the

---
base-commit: 1543b4c5071c54d76aad7a7a26a6e43082269b0c
change-id: 20230401-ericvh-dev-rework-cache-options-2c6638bea240

Best regards,
-- 
Eric Van Hensbergen <ericvh@kernel.org>

