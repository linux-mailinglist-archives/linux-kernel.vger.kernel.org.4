Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F59629DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbiKOPfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiKOPf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:35:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BC5E033;
        Tue, 15 Nov 2022 07:35:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D435AB81999;
        Tue, 15 Nov 2022 15:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DFAC433D6;
        Tue, 15 Nov 2022 15:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668526525;
        bh=Kk6YE6r7+pV85S3KUOQG/FfC1eR+wtQ/SfWrFF0Vwo0=;
        h=Date:From:To:Cc:Subject:From;
        b=TS9/0fFZ//65FVU5AEZsNoQzTvjEDGLEiFolQK6eKm5ThlnM6G28vQ32n/lC2loKY
         cMQ/4EQMA2lGumG0hh0M0sAnLjGeFA/3SWL6vaD+nthfLXE8FvkZ+UsCN9bXnZz1xv
         w7kH227NwrCeyzkLF19cS7UX78V6B3j3QKNZ1tdKpVQu7T8ODjGanq4InZfPt0pFVz
         26QbEOIzq/R3Bx075GNflt8yl27iwRpItzU+bzccWPxIcuIgKMfFhqmuoJ981K07dl
         JLBDMt95hvQKVsoQhByILWrmm39ATKLDX6oL7/9AQtdLbF7Q5kcJiVAOOdjqlz7xIL
         w67nE3xmB2BMA==
Date:   Tue, 15 Nov 2022 09:35:10 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] ksmbd: replace one-element arrays with flexible-array
 members
Message-ID: <Y3OxronfaPYv9qGP@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element arrays with flexible-array
members in multiple structs in fs/ksmbd/smb_common.h and one in
fs/ksmbd/smb2pdu.h.

Important to mention is that doing a build before/after this patch results
in no binary output differences.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE routines
on memcpy() and help us make progress towards globally enabling
-fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/242
Link: https://github.com/KSPP/linux/issues/79
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/ksmbd/smb2pdu.c    |  4 ++--
 fs/ksmbd/smb2pdu.h    |  2 +-
 fs/ksmbd/smb_common.h | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 9306e10753f9..ae7a3b000c61 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -3438,7 +3438,7 @@ static int smb2_populate_readdir_entry(struct ksmbd_conn *conn, int info_level,
 		goto free_conv_name;
 	}
 
-	struct_sz = readdir_info_level_struct_sz(info_level) - 1 + conv_len;
+	struct_sz = readdir_info_level_struct_sz(info_level) + conv_len;
 	next_entry_offset = ALIGN(struct_sz, KSMBD_DIR_INFO_ALIGNMENT);
 	d_info->last_entry_off_align = next_entry_offset - struct_sz;
 
@@ -3690,7 +3690,7 @@ static int reserve_populate_dentry(struct ksmbd_dir_info *d_info,
 		return -EOPNOTSUPP;
 
 	conv_len = (d_info->name_len + 1) * 2;
-	next_entry_offset = ALIGN(struct_sz - 1 + conv_len,
+	next_entry_offset = ALIGN(struct_sz + conv_len,
 				  KSMBD_DIR_INFO_ALIGNMENT);
 
 	if (next_entry_offset > d_info->out_buf_len) {
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index 092fdd3f8750..aa5dbe54f5a1 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -443,7 +443,7 @@ struct smb2_posix_info {
 	/* SidBuffer contain two sids (UNIX user sid(16), UNIX group sid(16)) */
 	u8 SidBuffer[32];
 	__le32 name_len;
-	u8 name[1];
+	u8 name[];
 	/*
 	 * var sized owner SID
 	 * var sized group SID
diff --git a/fs/ksmbd/smb_common.h b/fs/ksmbd/smb_common.h
index 318c16fa81da..e663ab9ea759 100644
--- a/fs/ksmbd/smb_common.h
+++ b/fs/ksmbd/smb_common.h
@@ -277,14 +277,14 @@ struct file_directory_info {
 	__le64 AllocationSize;
 	__le32 ExtFileAttributes;
 	__le32 FileNameLength;
-	char FileName[1];
+	char FileName[];
 } __packed;   /* level 0x101 FF resp data */
 
 struct file_names_info {
 	__le32 NextEntryOffset;
 	__u32 FileIndex;
 	__le32 FileNameLength;
-	char FileName[1];
+	char FileName[];
 } __packed;   /* level 0xc FF resp data */
 
 struct file_full_directory_info {
@@ -299,7 +299,7 @@ struct file_full_directory_info {
 	__le32 ExtFileAttributes;
 	__le32 FileNameLength;
 	__le32 EaSize;
-	char FileName[1];
+	char FileName[];
 } __packed; /* level 0x102 FF resp */
 
 struct file_both_directory_info {
@@ -317,7 +317,7 @@ struct file_both_directory_info {
 	__u8   ShortNameLength;
 	__u8   Reserved;
 	__u8   ShortName[24];
-	char FileName[1];
+	char FileName[];
 } __packed; /* level 0x104 FFrsp data */
 
 struct file_id_both_directory_info {
@@ -337,7 +337,7 @@ struct file_id_both_directory_info {
 	__u8   ShortName[24];
 	__le16 Reserved2;
 	__le64 UniqueId;
-	char FileName[1];
+	char FileName[];
 } __packed;
 
 struct file_id_full_dir_info {
@@ -354,7 +354,7 @@ struct file_id_full_dir_info {
 	__le32 EaSize; /* EA size */
 	__le32 Reserved;
 	__le64 UniqueId; /* inode num - le since Samba puts ino in low 32 bit*/
-	char FileName[1];
+	char FileName[];
 } __packed; /* level 0x105 FF rsp data */
 
 struct smb_version_values {
-- 
2.34.1

