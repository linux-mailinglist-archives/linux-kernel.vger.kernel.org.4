Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ACC6BD29D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjCPOpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCPOp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:45:28 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0376B113E5;
        Thu, 16 Mar 2023 07:45:25 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id k15so293379pgt.10;
        Thu, 16 Mar 2023 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678977925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5S9yam8E0yc9SuJ7yNknLaYjD0yQwuVUoXiwUMDyx8=;
        b=Z2F06eYXq5d+2HeYSQGUg7z43Xm/I5qZcvLTI6VFCb5aCcMjT0E9uEs1z3lzGnfkzp
         o8S3GiXJRQkO0+p9fC75Pl26ZIhvCwKhsxrnW+mO07ZUNDrbByvfd8gpND23GFkJ31Pc
         edqo8fjxwB6GxswXpj3L52vg4+mk3Rh48+vaJPKWqYXM5IHwb2qgjsW5s4a2Vhtwiky4
         JPPfWbGzAxrtilpcaQzPe6fNc0W5zAm9ZS7uPcBZyzygQrBq50iWycR34yoKBvZYC1nE
         vhEwKFJd4cp/xSf0IlKEXuH/6vqtbfkGjUzJ5UNx9+0Yof/T5s4tc2Np67IZC0k+oGXR
         19NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678977925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5S9yam8E0yc9SuJ7yNknLaYjD0yQwuVUoXiwUMDyx8=;
        b=0MOPfy+HhavfJ3tJGO1MaVEKAH9x6ADVP8YzIPZMGVEfYwpS6//bRM/8o4ldgLji4D
         OLRQP3s8CBTISuDVM3Ag2pGAzANMUQnR3yeVQs4pqWQUEWBIn6cWd13zIFsvqN2UeTCN
         VaI4g5jf6bvPcawMIDuw2z89/yeYX4JZ1yn/HHlTEh9aS4uzDlBXyXoRG8sMkupNIzyX
         oSpR5Qf2WHkadhl/JLbUVOEIFyllxR5AbOSq9J23RqNfr5+XINVpi07PvNmX11K31bcv
         a6uCtDf3P/6wwMwxTmdk42CQG9TaaqAfWSofZKzLeT2CVDqT0QoaD9K6k1PxIvfPRCUM
         UbzQ==
X-Gm-Message-State: AO0yUKWjQhBrGsPfEgR+7DaVdd47vcsMEadAU7T90NMrr47ISRd8+QDL
        mj8S8H1mdlBVDrbSklYbgvU=
X-Google-Smtp-Source: AK7set8IxOrl3onJPkC6BfWLMgm2uKRqmxa2/FvQhwZWA6kSSVX/qfbRHCQAN9ukZCE51Vmew3u1gg==
X-Received: by 2002:aa7:8f08:0:b0:5d7:637a:abcf with SMTP id x8-20020aa78f08000000b005d7637aabcfmr3074363pfr.32.1678977925322;
        Thu, 16 Mar 2023 07:45:25 -0700 (PDT)
Received: from c1ion.lan ([139.227.13.23])
        by smtp.gmail.com with ESMTPSA id l22-20020a62be16000000b0058bacd6c4e8sm5503701pff.207.2023.03.16.07.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:45:24 -0700 (PDT)
From:   MIngyi Cong <congmingyi@gmail.com>
To:     linkinjeon@kernel.org, senozhatsky@chromium.org, sfrench@samba.org,
        tom@talpey.com
Cc:     congmingyi@gmail.com, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH v3] fs: add the tuncate check of exfat
Date:   Thu, 16 Mar 2023 22:45:17 +0800
Message-Id: <20230316144517.7355-1-congmingyi@gmail.com>
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
 V2 -> V3: remove the truncate check of hfs and hfsplus
 fs/ksmbd/smb2pdu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
-- 
2.34.1

