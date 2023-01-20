Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4757E67587D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjATPZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjATPYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:24:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705DA677B6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674228236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4q+L6Afy5JT99kRsKQKl76nPtSUdZQ/nsXSjE4NKhco=;
        b=e61L4/gJJAdSbggBSWLl9RlOmKx47/XAdzahppWXwccsCctNHcQlteg7/miOMtK92lqbzj
        +eYqYbcIThYh6Mf/gOo0gjdVHySPItiGiOZ9R1IsrEIl+peaN17DD38huGGFEnUnLQ37hI
        WTHY+4g7ruQYdKK0MoSrn5/NQsgsmf8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-xVLbElljPcO4guvFIQ8uHA-1; Fri, 20 Jan 2023 10:23:52 -0500
X-MC-Unique: xVLbElljPcO4guvFIQ8uHA-1
Received: by mail-ed1-f69.google.com with SMTP id h18-20020a056402281200b0049e5078a6c3so4105254ede.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4q+L6Afy5JT99kRsKQKl76nPtSUdZQ/nsXSjE4NKhco=;
        b=Eyr6cTyT1Yw9D/JnT3iYbKNVIzGi+VGTUlPa4GetEWXkPHLgH6otGXo6swhqX/VH4U
         j61kzMR5CfrGrpHvGCLfCAUVlI//h9qOozO+6oyKowWYSB/deWNbxwsN2m+HEHX1tE1o
         zywqbT4iDh/9RKL6ZjLsGzX7sIzqbXBFgKTFAWV6inQI7+EH5JPGnygZM6q22/1ef1VD
         qzzh0fVknYFFJoTBD+Pnt2Ror3DyJjtF5Yvt77X/RPHSf/R/jSC6LowsXYBSQj8n0Rgq
         Q1wngB+cK3QhQBecIiX7B/jlLsgmC+AfuAsDZP9XjhQsbE8h9w9f6iITiaQGiHqB+CoT
         nT5w==
X-Gm-Message-State: AFqh2kqcxmchtRHIU+9C1J8D7dZNhQJfat2uJTBi6gOJccdqsp+Jl0kF
        JZK69SuwI0nhcMkdkQIT46AfFeFsciPCU3wId8+h4v02KHgWuK5Znh4sW7P3fhqICvIx7lee9Sc
        t7q65ssg5GHMXyLM1SP7wIXuY
X-Received: by 2002:a17:907:2bdd:b0:857:b916:94c2 with SMTP id gv29-20020a1709072bdd00b00857b91694c2mr10703812ejc.35.1674228231801;
        Fri, 20 Jan 2023 07:23:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXute8wTDnxMFCRBA7qrgVSJK+iTu1iuf8iBjGopV5NeM2ayALt6GVtdz2l0sr0jHwR09YFsyQ==
X-Received: by 2002:a17:907:2bdd:b0:857:b916:94c2 with SMTP id gv29-20020a1709072bdd00b00857b91694c2mr10703792ejc.35.1674228231508;
        Fri, 20 Jan 2023 07:23:51 -0800 (PST)
Received: from localhost.localdomain (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.googlemail.com with ESMTPSA id s16-20020a1709067b9000b00872eb47f46dsm5706976ejo.19.2023.01.20.07.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:23:51 -0800 (PST)
From:   Alexander Larsson <alexl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com,
        david@fromorbit.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Alexander Larsson <alexl@redhat.com>
Subject: [PATCH v3 2/6] composefs: Add on-disk layout header
Date:   Fri, 20 Jan 2023 16:23:30 +0100
Message-Id: <19f39cabc13b646bf9084bfeacddc6599f7cd389.1674227308.git.alexl@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1674227308.git.alexl@redhat.com>
References: <cover.1674227308.git.alexl@redhat.com>
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

This header contains the on-disk layout of the composefs file format.

The basic format is a simple subperblock with a version and magic
number at the start for filetype detection. after that, a table of
inodes (indexed by inode number) data containing all the fixed-size
inode elements.

After the inodes (at offset specified in superblock) is a variable
data section that is linked to by the inodes for:
 * symlink targets,
 * backing filenames
 * xattrs
 * dirents

The goal of this file format is to be simple and efficient to decode
when mapped directly from the page cache. This allows an easy to
understand and maintain codebase.

Signed-off-by: Alexander Larsson <alexl@redhat.com>
Co-developed-by: Giuseppe Scrivano <gscrivan@redhat.com>
Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 fs/composefs/cfs.h | 172 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)
 create mode 100644 fs/composefs/cfs.h

diff --git a/fs/composefs/cfs.h b/fs/composefs/cfs.h
new file mode 100644
index 000000000000..9209b80dd6ca
--- /dev/null
+++ b/fs/composefs/cfs.h
@@ -0,0 +1,172 @@
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
+/* Descriptor file layout:
+ *
+ *  +-----------------------+
+ *  | cfs_superblock        |
+ *  |   vdata_offfset       |---|
+ *  +-----------------------|   |
+ *  | Inode table           |   |
+ *  |  N * cfs_inode_data   |   |
+ *  +-----------------------|   |
+ *  | Variable data section |<--/
+ *  | Used for:             |
+ *  |  symlink targets      |
+ *  |  backing file paths   |
+ *  |  dirents              |
+ *  |  xattrs               |
+ *  |  digests              |
+ *  +-----------------------+
+ *
+ * The superblock is at the start of the file, and the inode table
+ * directly follows it. The variable data section found via
+ * vdata_offset and all sections are 32bit aligned. All data is
+ *  little endian.
+ *
+ * The inode table is a table of fixed size cfs_inode_data elements.
+ * The filesystem inode numbers are 32bit indexes into this table.
+ * Actual file content (for regular files) is referenced by a backing
+ * file path which is looked up relative to a given base dir.
+ *
+ * All variable size data are stored in the variable data section and
+ * are referenced using cfs_vdata (64bit offset from the start of the
+ * vdata section and 32bit lengths).
+ *
+ * Directory dirent data is stored in one 32bit aligned vdata chunk,
+ * staring with a table of fixed size cfs_dirents and which is
+ * followed by a string table. The dirents reference the strings by
+ * offsets form the string table. The dirents are sorted for efficient
+ * binary search lookups.
+ *
+ * Xattrs data are stored in a 32bit aligned vdata chunk. This is
+ * a table of cfs_xattr, followed by the key/value data. The
+ * xattrs are sorted by key. Note that many inodes can reference
+ * the same xattr data.
+ */
+
+/* Current (and atm only) version of the image format. */
+#define CFS_VERSION 1
+
+#define CFS_MAGIC 0xc078629aU
+
+#define CFS_SUPERBLOCK_OFFSET 0
+#define CFS_INODE_TABLE_OFFSET sizeof(struct cfs_superblock)
+#define CFS_INODE_SIZE sizeof(struct cfs_inode_data)
+#define CFS_DIRENT_SIZE sizeof(struct cfs_dirent)
+#define CFS_XATTR_ELEM_SIZE sizeof(struct cfs_xattr_element)
+#define CFS_ROOT_INO 0
+
+/* Fits at least the root inode */
+#define CFS_DESCRIPTOR_MIN_SIZE                                                \
+	(sizeof(struct cfs_superblock) + sizeof(struct cfs_inode_data))
+
+/* More that this would overflow header size computation */
+#define CFS_MAX_DIRENTS (U32_MAX / CFS_DIRENT_SIZE - 1)
+
+#define CFS_MAX_XATTRS U16_MAX
+
+struct cfs_superblock {
+	__le32 version; /* CFS_VERSION */
+	__le32 magic; /* CFS_MAGIC */
+
+	/* Offset of the variable data section from start of file */
+	__le64 vdata_offset;
+
+	/* For future use, and makes superblock 128 bytes to align
+	 * inode table on cacheline boundary on most arches.
+	 */
+	__le32 unused[28];
+} __packed;
+
+struct cfs_vdata {
+	__le64 off; /* Offset into variable data section */
+	__le32 len;
+} __packed;
+
+struct cfs_inode_data {
+	__le32 st_mode; /* File type and mode.  */
+	__le32 st_nlink; /* Number of hard links, only for regular files.  */
+	__le32 st_uid; /* User ID of owner.  */
+	__le32 st_gid; /* Group ID of owner.  */
+	__le32 st_rdev; /* Device ID (if special file).  */
+	__le64 st_size; /* Size of file */
+	__le64 st_mtim_sec;
+	__le32 st_mtim_nsec;
+	__le64 st_ctim_sec;
+	__le32 st_ctim_nsec;
+
+	/* References to variable storage area: */
+
+	/* per-type variable data:
+	 * S_IFDIR: dirents
+	 * S_IFREG: backing file pathnem
+	 * S_IFLNLK; symlink target
+	 */
+	struct cfs_vdata variable_data;
+
+	struct cfs_vdata xattrs;
+	struct cfs_vdata digest; /* Expected fs-verity digest of backing file */
+
+	/* For future use, and makes inode_data 96 bytes which
+	 * is semi-aligned with cacheline sizes.
+	 */
+	__le32 unused[2];
+} __packed;
+
+struct cfs_dirent {
+	__le32 inode_num; /* Index in inode table */
+	__le32 name_offset; /* Offset from end of cfs_dir_header */
+	u8 name_len;
+	u8 d_type;
+	u16 _padding;
+} __packed;
+
+/* Directory entries, stored in variable data section, 32bit aligned,
+ * followed by name string table
+ */
+struct cfs_dir_header {
+	__le32 n_dirents;
+	struct cfs_dirent dirents[];
+} __packed;
+
+static inline size_t cfs_dir_header_size(size_t n_dirents)
+{
+	return sizeof(struct cfs_dir_header) + n_dirents * CFS_DIRENT_SIZE;
+}
+
+struct cfs_xattr_element {
+	__le16 key_length;
+	__le16 value_length;
+} __packed;
+
+/* Xattrs, stored in variable data section , 32bit aligned, followed
+ * by key/value table
+ */
+struct cfs_xattr_header {
+	__le16 n_attr;
+	struct cfs_xattr_element attr[0];
+} __packed;
+
+static inline size_t cfs_xattr_header_size(size_t n_element)
+{
+	return sizeof(struct cfs_xattr_header) + n_element * CFS_XATTR_ELEM_SIZE;
+}
+
+#endif
-- 
2.39.0

