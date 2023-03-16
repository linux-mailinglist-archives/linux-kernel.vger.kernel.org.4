Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA156BD25C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjCPO2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCPO2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:28:18 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85245FE4;
        Thu, 16 Mar 2023 07:28:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z10so1024031pgr.8;
        Thu, 16 Mar 2023 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678976888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7Aqp/vCsVP1mtxvgQ+j+GMgl/fAIAsqktfz1ENdg3U=;
        b=ThLnSy636s2ceW+2BuQpxDg3BeyXPAKuTJgyCCKtBdXeM9/rA60FHrK3q8qzAZ+sGK
         0Y7T+qNAD/zcDTTVqLM4rGINJjluhEcPbROqkn2O8UkcY7mk+xt40lsfT596q2oP+1+H
         fwBBuWpmx0hwy7fiMMbwdE6i8Hj22FzaNgECKliQeFll8xRx9zCxSmq82hkHxNOD2jcE
         JKGxcMOKLdLtSFe+gfuVMjg7DFYTONxCV43Tpo7+ljzrYzPhws490Ue2cpTdNElFFNAi
         BL2GkX5Ty/t9xNOCEXPot/PJgV4D0vauMLH5/+BB0OvNI+/F2X+Cy1IzNUYX8pxdt9A2
         ssJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678976888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7Aqp/vCsVP1mtxvgQ+j+GMgl/fAIAsqktfz1ENdg3U=;
        b=aomMkPI7wuw8JEcdXTXDndsUPNoCYMcyb9dgg/EpPP76j3TwpKTnYA7RSGIqinZPAP
         l1l89XHf8SJ75ypaZfIK4iOPupnFy73iOTqiamHVnLMnJclvD+9HkEcxpCJi1EJqqx9O
         wZ+UjgIqteWj3QBicuM1gbdP2JfTs2ZDPE3cozmQL2n6r8THh/036zplk2VRWN3AysN3
         uGw3FwzwaWEkliWmGqyellzm8qVURyDZYw4IJ+aEsu7vrTKDq3cQlzDboz0wiXh+sCrQ
         Nkmt9TbTCYYz26mKN27Gi3J00hY3h9KKiLFclWpNo484wDrP4c2vbyoLlPZP3aTtMpQS
         ztrA==
X-Gm-Message-State: AO0yUKU8qpYH2xxwH0SGEaR2Ss+3abx5Kj8erII8Qh7umzmosZsEIFyh
        /HaWxNePNe8wr/p9RoGl5szo9Q5YYvFP2Q==
X-Google-Smtp-Source: AK7set+nQjrth2IsI2my79ig6nDTaUEKWSmsDA4k9pvQa+I6uQSjYSrK/+B4jTu383dd6b+/KU4Sng==
X-Received: by 2002:aa7:9681:0:b0:624:2f88:927d with SMTP id f1-20020aa79681000000b006242f88927dmr3049632pfk.27.1678976888137;
        Thu, 16 Mar 2023 07:28:08 -0700 (PDT)
Received: from c1ion.lan ([139.227.13.23])
        by smtp.gmail.com with ESMTPSA id x21-20020aa784d5000000b0062485a1675bsm5510058pfn.137.2023.03.16.07.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:28:07 -0700 (PDT)
From:   MIngyi Cong <congmingyi@gmail.com>
To:     linkinjeon@kernel.org, senozhatsky@chromium.org, sfrench@samba.org,
        tom@talpey.com
Cc:     congmingyi@gmail.com, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH v3] fs: add the tuncate check of exfat
Date:   Thu, 16 Mar 2023 22:27:53 +0800
Message-Id: <20230316142753.6628-1-congmingyi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307135740.13209-1-congmingyi@gmail.com>
References: <20230307135740.13209-1-congmingyi@gmail.com>
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

EXFAT will fill zero data in truncated range.
Fix this by adding EXFAT_SUPER_MAGIC check.

Signed-off-by: MIngyi Cong <congmingyi@gmail.com>
---
 V1 -> V2: add the truncate check of hfs and remove EXFAT_SUPER_MAGIC in magic.h
 V2 -> V3: remove the truncate  check of hfs and hfsplus 
 fs/ksmbd/smb2pdu.c         | 3 ++-
 include/uapi/linux/magic.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 0685c1c77b9f..3f2e34936b8d 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5746,7 +5746,8 @@ static int set_end_of_file_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 	 * truncate of some filesystem like FAT32 fill zero data in
 	 * truncated range.
 	 */
-	if (inode->i_sb->s_magic != MSDOS_SUPER_MAGIC) {
+	if (inode->i_sb->s_magic != MSDOS_SUPER_MAGIC ||
+		inode->i_sb->s_magic != EXFAT_SUPER_MAGIC) {
 		ksmbd_debug(SMB, "truncated to newsize %lld\n", newsize);
 		rc = ksmbd_vfs_truncate(work, fp, newsize);
 		if (rc) {
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 6325d1d0e90f..309cb3b5c5c4 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -46,6 +46,7 @@
 
 #define MSDOS_SUPER_MAGIC	0x4d44		/* MD */
 #define EXFAT_SUPER_MAGIC	0x2011BAB0
+#define HFS_SUPER_MAGIC	0x4244		/* "BD": HFS MDB (super block) */
 #define NCP_SUPER_MAGIC		0x564c		/* Guess, what 0x564c is :-) */
 #define NFS_SUPER_MAGIC		0x6969
 #define OCFS2_SUPER_MAGIC	0x7461636f
-- 
2.34.1

