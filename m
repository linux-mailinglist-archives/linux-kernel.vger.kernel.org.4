Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723CB669CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjAMPqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjAMPpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:45:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AE881C2A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673624113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wkj3gh9U52LVu/Pu7gKRVoj8JWMn17zGrdPPiVQNVN4=;
        b=H99+U1zKjHOo26LYdHQy8w+KBejOR2AX6QPES62O5nzINUhJzu1Hzv6vJG4NnoFCe4hbku
        6Nzk7MKtN/1GuumGi3fDJpWUp+53Rb+PwYsPVi5BecKYrFbFOhRTeX1nHDwrThfYk135kD
        eNnh1FJaXSQ1J8+BGt4uAg0OVg9U1Z0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-655-XpMooGMbMCCDS8MLcuhGCg-1; Fri, 13 Jan 2023 10:35:11 -0500
X-MC-Unique: XpMooGMbMCCDS8MLcuhGCg-1
Received: by mail-lf1-f70.google.com with SMTP id v19-20020ac25933000000b004b55ec28779so8443806lfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:35:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkj3gh9U52LVu/Pu7gKRVoj8JWMn17zGrdPPiVQNVN4=;
        b=e1r1yzCzkgiKAtVM440vR7/C7dS0t/0IWJaSjwxFP1/tCubY6JqGY4HEfej1lPC3V1
         HlcTwzwBRy1HDf/0M12i5LcD67D5xBUiberQ7gd6KLWTkyepYKKeMIfnCPmLUJ+Myjzb
         4072j6+8BjeD+kESHleSqOjt9x9q1JKRzWW87UhmjZqRMkAFDR5B89QrkZVgPjK39TnU
         lp0+g3XwatOhT2Jk90HeUTSCWjWs77G1wZRXkOYG+bvS6UleP60ZWiEQyYRN40zY/YbF
         RrkmVckNTVNKbG6nGf3SoEAbNuZiHbutCkLgfShAo+oAlUIWNreg4obH2lxtjgczRrY8
         4IOw==
X-Gm-Message-State: AFqh2kpQUQktQiLubds02VygSlmuMMWeX15ha/ptA0MGZiT4PEYlzxJC
        sXiAhqv9/bv3eBZRn5cG/mSzV8MHi2L0zyjBJMc0r4xAFVFl3nwsoWVHR9xezEhkA4tCHonlNln
        hTIholMZu7thNiyOqQ5aTqrZ0
X-Received: by 2002:a05:651c:1604:b0:281:d50:f3f4 with SMTP id f4-20020a05651c160400b002810d50f3f4mr8967788ljq.28.1673624109552;
        Fri, 13 Jan 2023 07:35:09 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvzrLaIp6gLp/ZPfBIFjfkiZ+8VX+feW6BV35DMwpzNK5YUoaa1mc9C5aaUL5+CikG/bK+ldw==
X-Received: by 2002:a05:651c:1604:b0:281:d50:f3f4 with SMTP id f4-20020a05651c160400b002810d50f3f4mr8967782ljq.28.1673624109356;
        Fri, 13 Jan 2023 07:35:09 -0800 (PST)
Received: from localhost.localdomain (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.googlemail.com with ESMTPSA id p20-20020a2e9a94000000b00289bb528b8dsm725473lji.49.2023.01.13.07.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:35:08 -0800 (PST)
From:   Alexander Larsson <alexl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com,
        Alexander Larsson <alexl@redhat.com>
Subject: [PATCH v2 2/6] composefs: Add on-disk layout
Date:   Fri, 13 Jan 2023 16:33:55 +0100
Message-Id: <819f49676080b05c1e87bff785849f0cc375d245.1673623253.git.alexl@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673623253.git.alexl@redhat.com>
References: <cover.1673623253.git.alexl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the on-disk layout header file of composefs.

Signed-off-by: Alexander Larsson <alexl@redhat.com>
Co-developed-by: Giuseppe Scrivano <gscrivan@redhat.com>
Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 fs/composefs/cfs.h | 203 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 203 insertions(+)
 create mode 100644 fs/composefs/cfs.h

diff --git a/fs/composefs/cfs.h b/fs/composefs/cfs.h
new file mode 100644
index 000000000000..658df728e366
--- /dev/null
+++ b/fs/composefs/cfs.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * composefs
+ *
+ * Copyright (C) 2021 Giuseppe Scrivano
+ * Copyright (C) 2022 Alexander Larsson
+ *
+ * This file is released under the GPL.
+ */
+
+#ifndef _CFS_H
+#define _CFS_H
+
+#include <asm/byteorder.h>
+#include <crypto/sha2.h>
+#include <linux/fs.h>
+#include <linux/stat.h>
+#include <linux/types.h>
+
+#define CFS_VERSION 1
+
+#define CFS_MAGIC 0xc078629aU
+
+#define CFS_MAX_DIR_CHUNK_SIZE 4096
+#define CFS_MAX_XATTRS_SIZE 4096
+
+static inline int cfs_digest_from_payload(const char *payload, size_t payload_len,
+					  u8 digest_out[SHA256_DIGEST_SIZE])
+{
+	const char *p, *end;
+	u8 last_digit = 0;
+	int digit = 0;
+	size_t n_nibbles = 0;
+
+	/* This handles payloads (i.e. path names) that are "essentially" a
+	 * digest as the digest (if the DIGEST_FROM_PAYLOAD flag is set). The
+	 * "essential" part means that we ignore hierarchical structure as well
+	 * as any extension. So, for example "ef/deadbeef.file" would match the
+	 * (too short) digest "efdeadbeef".
+	 *
+	 * This allows images to avoid storing both the digest and the pathname,
+	 * yet work with pre-existing object store formats of various kinds.
+	 */
+
+	end = payload + payload_len;
+	for (p = payload; p != end; p++) {
+		/* Skip subdir structure */
+		if (*p == '/')
+			continue;
+
+		/* Break at (and ignore) extension */
+		if (*p == '.')
+			break;
+
+		if (n_nibbles == SHA256_DIGEST_SIZE * 2)
+			return -EINVAL; /* Too long */
+
+		digit = hex_to_bin(*p);
+		if (digit == -1)
+			return -EINVAL; /* Not hex digit */
+
+		n_nibbles++;
+		if ((n_nibbles % 2) == 0)
+			digest_out[n_nibbles / 2 - 1] = (last_digit << 4) | digit;
+		last_digit = digit;
+	}
+
+	if (n_nibbles != SHA256_DIGEST_SIZE * 2)
+		return -EINVAL; /* Too short */
+
+	return 0;
+}
+
+struct cfs_vdata_s {
+	u64 off;
+	u32 len;
+} __packed;
+
+struct cfs_header_s {
+	u8 version;
+	u8 unused1;
+	u16 unused2;
+
+	u32 magic;
+	u64 data_offset;
+	u64 root_inode;
+
+	u64 unused3[2];
+} __packed;
+
+enum cfs_inode_flags {
+	CFS_INODE_FLAGS_NONE = 0,
+	CFS_INODE_FLAGS_PAYLOAD = 1 << 0,
+	CFS_INODE_FLAGS_MODE = 1 << 1,
+	CFS_INODE_FLAGS_NLINK = 1 << 2,
+	CFS_INODE_FLAGS_UIDGID = 1 << 3,
+	CFS_INODE_FLAGS_RDEV = 1 << 4,
+	CFS_INODE_FLAGS_TIMES = 1 << 5,
+	CFS_INODE_FLAGS_TIMES_NSEC = 1 << 6,
+	CFS_INODE_FLAGS_LOW_SIZE = 1 << 7, /* Low 32bit of st_size */
+	CFS_INODE_FLAGS_HIGH_SIZE = 1 << 8, /* High 32bit of st_size */
+	CFS_INODE_FLAGS_XATTRS = 1 << 9,
+	CFS_INODE_FLAGS_DIGEST = 1 << 10, /* fs-verity sha256 digest */
+	CFS_INODE_FLAGS_DIGEST_FROM_PAYLOAD = 1 << 11, /* Compute digest from payload */
+};
+
+#define CFS_INODE_FLAG_CHECK(_flag, _name)                                     \
+	(((_flag) & (CFS_INODE_FLAGS_##_name)) != 0)
+#define CFS_INODE_FLAG_CHECK_SIZE(_flag, _name, _size)                         \
+	(CFS_INODE_FLAG_CHECK(_flag, _name) ? (_size) : 0)
+
+#define CFS_INODE_DEFAULT_MODE 0100644
+#define CFS_INODE_DEFAULT_NLINK 1
+#define CFS_INODE_DEFAULT_NLINK_DIR 2
+#define CFS_INODE_DEFAULT_UIDGID 0
+#define CFS_INODE_DEFAULT_RDEV 0
+#define CFS_INODE_DEFAULT_TIMES 0
+
+struct cfs_inode_s {
+	u32 flags;
+
+	/* Optional data: (selected by flags) */
+
+	/* This is the size of the type specific data that comes directly after
+	 * the inode in the file. Of this type:
+	 *
+	 * directory: cfs_dir_s
+	 * regular file: the backing filename
+	 * symlink: the target link
+	 *
+	 * Canonically payload_length is 0 for empty dir/file/symlink.
+	 */
+	u32 payload_length;
+
+	u32 st_mode; /* File type and mode.  */
+	u32 st_nlink; /* Number of hard links, only for regular files.  */
+	u32 st_uid; /* User ID of owner.  */
+	u32 st_gid; /* Group ID of owner.  */
+	u32 st_rdev; /* Device ID (if special file).  */
+	u64 st_size; /* Size of file, only used for regular files */
+
+	struct cfs_vdata_s xattrs; /* ref to variable data */
+
+	u8 digest[SHA256_DIGEST_SIZE]; /* fs-verity digest */
+
+	struct timespec64 st_mtim; /* Time of last modification.  */
+	struct timespec64 st_ctim; /* Time of last status change.  */
+};
+
+static inline u32 cfs_inode_encoded_size(u32 flags)
+{
+	return sizeof(u32) /* flags */ +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, PAYLOAD, sizeof(u32)) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, MODE, sizeof(u32)) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, NLINK, sizeof(u32)) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, UIDGID, sizeof(u32) + sizeof(u32)) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, RDEV, sizeof(u32)) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, TIMES, sizeof(u64) * 2) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, TIMES_NSEC, sizeof(u32) * 2) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, LOW_SIZE, sizeof(u32)) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, HIGH_SIZE, sizeof(u32)) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, XATTRS, sizeof(u64) + sizeof(u32)) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, DIGEST, SHA256_DIGEST_SIZE);
+}
+
+struct cfs_dentry_s {
+	/* Index of struct cfs_inode_s */
+	u64 inode_index;
+	u8 d_type;
+	u8 name_len;
+	u16 name_offset;
+} __packed;
+
+struct cfs_dir_chunk_s {
+	u16 n_dentries;
+	u16 chunk_size;
+	u64 chunk_offset;
+} __packed;
+
+struct cfs_dir_s {
+	u32 n_chunks;
+	struct cfs_dir_chunk_s chunks[];
+} __packed;
+
+#define cfs_dir_size(_n_chunks)                                                \
+	(sizeof(struct cfs_dir_s) + (_n_chunks) * sizeof(struct cfs_dir_chunk_s))
+
+/* xattr representation.  */
+struct cfs_xattr_element_s {
+	u16 key_length;
+	u16 value_length;
+} __packed;
+
+struct cfs_xattr_header_s {
+	u16 n_attr;
+	struct cfs_xattr_element_s attr[0];
+} __packed;
+
+#define cfs_xattr_header_size(_n_element)                                      \
+	(sizeof(struct cfs_xattr_header_s) +                                   \
+	 (_n_element) * sizeof(struct cfs_xattr_element_s))
+
+#endif
-- 
2.39.0

