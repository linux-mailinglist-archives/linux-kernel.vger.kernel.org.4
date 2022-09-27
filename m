Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457165EB7E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiI0CpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiI0CpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:45:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7625FA8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2B2F61542
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D85EC433C1;
        Tue, 27 Sep 2022 02:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664246698;
        bh=aPhM8cKTA6dQyU1256UxQ8auvOKzd7pI92C/A1V002w=;
        h=From:To:Cc:Subject:Date:From;
        b=gROzKsyyApUtzhal/gNoSsvkKuujY+kBdBam7IqAejbwerNBpTgYvEnrEDjUfmEoS
         CRMStTLNKnrCiV5Uj+wLtUhoHla+01DcXbX03OC+ZSIPzLT9J/AJuQc2y5vsqmeWq+
         nY5TC7CkhV+UWai7etPhigeXGJTBlAXhoFoSfcocgjfL/8nqstAXiz9KJz1ZMK0EY/
         omGgkLTQkcDdAL+jBTYFsqMwPuwmn9953vW1r9sxB0gv7Xs94a5nXvL6W0UTu222TE
         nhUy/bidsVYermqW9gwLxLyYuc4DaIS584R7P+zQLG1G/t3nCfnlNXQStK+DQPQnAM
         /fUhK/U28wMPQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: introduce cp_status sysfs entry
Date:   Tue, 27 Sep 2022 10:44:47 +0800
Message-Id: <20220927024447.2547950-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new sysfs entry named cp_status, it can output
checkpoint flags in real time.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 24 ++++++++++++++++++++++++
 fs/f2fs/sysfs.c                         |  8 ++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 083ac2d63eef..483639fb727b 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -466,6 +466,30 @@ Description:	Show status of f2fs superblock in real time.
 		0x4000 SBI_IS_FREEZING       freefs is in process
 		====== ===================== =================================
 
+What:		/sys/fs/f2fs/<disk>/stat/cp_status
+Date:		September 2022
+Contact:	"Chao Yu" <chao.yu@oppo.com>
+Description:	Show status of f2fs checkpoint in real time.
+
+		=============================== ==============================
+		cp flag				value
+		CP_UMOUNT_FLAG			0x00000001
+		CP_ORPHAN_PRESENT_FLAG		0x00000002
+		CP_COMPACT_SUM_FLAG		0x00000004
+		CP_ERROR_FLAG			0x00000008
+		CP_FSCK_FLAG			0x00000010
+		CP_FASTBOOT_FLAG		0x00000020
+		CP_CRC_RECOVERY_FLAG		0x00000040
+		CP_NAT_BITS_FLAG		0x00000080
+		CP_TRIMMED_FLAG			0x00000100
+		CP_NOCRC_RECOVERY_FLAG		0x00000200
+		CP_LARGE_NAT_BITMAP_FLAG	0x00000400
+		CP_QUOTA_NEED_FSCK_FLAG		0x00000800
+		CP_DISABLED_FLAG		0x00001000
+		CP_DISABLED_QUICK_FLAG		0x00002000
+		CP_RESIZEFS_FLAG		0x00004000
+		=============================== ==============================
+
 What:		/sys/fs/f2fs/<disk>/ckpt_thread_ioprio
 Date:		January 2021
 Contact:	"Daeho Jeong" <daehojeong@google.com>
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 39ebf0ad133a..df27afd71ef4 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -128,6 +128,12 @@ static ssize_t sb_status_show(struct f2fs_attr *a,
 	return sprintf(buf, "%lx\n", sbi->s_flag);
 }
 
+static ssize_t cp_status_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	return sprintf(buf, "%x\n", le32_to_cpu(F2FS_CKPT(sbi)->ckpt_flags));
+}
+
 static ssize_t pending_discard_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
@@ -1029,8 +1035,10 @@ static struct attribute *f2fs_feat_attrs[] = {
 ATTRIBUTE_GROUPS(f2fs_feat);
 
 F2FS_GENERAL_RO_ATTR(sb_status);
+F2FS_GENERAL_RO_ATTR(cp_status);
 static struct attribute *f2fs_stat_attrs[] = {
 	ATTR_LIST(sb_status),
+	ATTR_LIST(cp_status),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs_stat);
-- 
2.25.1

