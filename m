Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4BE6AA8BA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 09:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjCDIgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 03:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDIgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 03:36:10 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDD21BAC7;
        Sat,  4 Mar 2023 00:36:08 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso8409718pjr.5;
        Sat, 04 Mar 2023 00:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677918968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CLEGwvh2qYbgB4rTOKx78eSVSdlKxGUFU7IahmTi8kg=;
        b=cZBLUpvgd39BJ8BGY4K2n3nc2VIGwsmFeaaVmw3xM/zCu1Hgj6mxNav9wjBE6qHN2x
         hHRBmc3SrcEPPTgV514Vy6oZjVvKT/9L5Dc/z3wlrFNxCRpAHtZT0WnBsZb71ATuFcml
         vf/sbRwVg6PhncP9Zno6bYObazplHotdGedjFtfvvliMhWdpGic6foFrefeTZi3hNPcu
         EkEidmuBcMHK4DM2FT3Kp6NJYL1rqqxbmi57yovKHzMLylc6LKDy+C5CRdYWyWHFYpUJ
         ohbBb1YHNIY6STz5/Pbe1Fy0F1EWricmFqUSyDtsiB/F0H4BBjQxnMhIB+f9/BQN1bzd
         3ITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677918968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLEGwvh2qYbgB4rTOKx78eSVSdlKxGUFU7IahmTi8kg=;
        b=V/WQsXRK0Vy2D+ocUlTnfcvny18gIKXMKhbYviAdVKpkxTD1E7vKKuIHiizZaex2TO
         Gr+GXtlhO7M/DiIZ/iZEuQcsjA5VtZLs6imEG/7gixwHIs3mKowWDDyZ9RoS4BVvqLqp
         d7+DS5EJKCWGRV7BGMoawuf2igKGX1QJTZeOCELgoZ/WwC5kBhJyfEiDp4wcCDO9FpOV
         M+vsRjq66E7/DpV4yNep9+kHLX8uAZGWyxE+TMQVKWYk7KfkuxFSK/ngvW9BotKlx4qe
         bTpob1/QLfw2nTaU2MgJGaZWVWrTYC3bFkdwa6kDQm0G4PCG4CKWYf9FyMbPIKu7Gzjs
         QBBg==
X-Gm-Message-State: AO0yUKVp/thVR0IVNe1m04zHaZsGS4gXv10QKhDR/iowQa9vSeSLy20a
        y4FMEH9fsN2ZMlo9sDN57qc=
X-Google-Smtp-Source: AK7set/xUMSOQt3Jg4JgzeijVRwsTzvD9rCjv1wKIwRnRSgfekzhcYusGk/nKtvHei5uGo+2dG/9zA==
X-Received: by 2002:a17:902:d4cd:b0:19a:70f9:affb with SMTP id o13-20020a170902d4cd00b0019a70f9affbmr5885752plg.2.1677918967926;
        Sat, 04 Mar 2023 00:36:07 -0800 (PST)
Received: from c1ion.lan ([139.227.13.23])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b0019e866acda5sm2869103plh.9.2023.03.04.00.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 00:36:07 -0800 (PST)
From:   MIngyi Cong <congmingyi@gmail.com>
To:     linkinjeon@kernel.org, senozhatsky@chromium.org, sfrench@samba.org,
        hyc.lee@gmail.com
Cc:     congmingyi@gmail.com, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH] fs: add the tuncate check of exfat and hfsplus
Date:   Sat,  4 Mar 2023 16:35:59 +0800
Message-Id: <20230304083559.172398-1-congmingyi@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mingyi Cong <congmingyi@gmail.com>

EXFAT and HFSPLUS will fill zero data in truncated range.
Fix this by adding *_SUPER_MAGIC check.

Signed-off-by: Mingyi Cong <congmingyi@gmail.com>
---
 fs/ksmbd/smb2pdu.c         | 4 +++-
 include/uapi/linux/magic.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index ac029dfd2..10ab929ad 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5738,7 +5738,9 @@ static int set_end_of_file_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 	 * truncate of some filesystem like FAT32 fill zero data in
 	 * truncated range.
 	 */
-	if (inode->i_sb->s_magic != MSDOS_SUPER_MAGIC) {
+	if (inode->i_sb->s_magic != MSDOS_SUPER_MAGIC ||
+		inode->i_sb->s_magic != EXFAT_SUPER_MAGIC ||
+		inode->i_sb->s_magic != HFSPLUS_SUPER_MAGIC) {
 		ksmbd_debug(SMB, "filename : %s truncated to newsize %lld\n",
 			    fp->filename, newsize);
 		rc = ksmbd_vfs_truncate(work, fp, newsize);
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 35687dcb1..687b7f584 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -43,6 +43,8 @@
 #define MINIX3_SUPER_MAGIC	0x4d5a		/* minix v3 fs, 60 char names */
 
 #define MSDOS_SUPER_MAGIC	0x4d44		/* MD */
+#define EXFAT_SUPER_MAGIC	0x2011BAB0UL		/* EXFAT */
+#define HFSPLUS_SUPER_MAGIC	0x482b		/* HFSPLUS */
 #define NCP_SUPER_MAGIC		0x564c		/* Guess, what 0x564c is :-) */
 #define NFS_SUPER_MAGIC		0x6969
 #define OCFS2_SUPER_MAGIC	0x7461636f
-- 
2.34.1

