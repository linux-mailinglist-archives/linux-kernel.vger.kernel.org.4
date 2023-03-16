Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D2D6BD275
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjCPOgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCPOgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:36:16 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C8EE3BF;
        Thu, 16 Mar 2023 07:36:15 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so1667506pjp.1;
        Thu, 16 Mar 2023 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678977375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5S9yam8E0yc9SuJ7yNknLaYjD0yQwuVUoXiwUMDyx8=;
        b=TObbh32HkmIQ6Z1Ln0lm1/+Iw0cOFUwf1YqA5eqmOcSOPSDPK4hQjHGI5uZah3xAZl
         IVvctf11Ktt6s0poWKuf8PDUXYM+S1R2nBabIqHVvoBZKKDYJiBo6bGah0/PMfBW4WBe
         IsvpcafZpYxjpiA1VZd4CZSn4gLYX2B4CPDR/sPeSDo15HDvHTgRyUjK7C/TzUgHrS30
         yD0o/Jq/HNPXK8hS2HOwDOrIqUfWyjNvMQpdUkSOJqLTx2GFFSApeKAFgCWqm+2Q3G3i
         9O9CSulW80/LvxHBCy89Lb7hxlnYoMQd/7hvApO36Wvxh66rkeR6JVYHCpxwUPlBMbFi
         fQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678977375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5S9yam8E0yc9SuJ7yNknLaYjD0yQwuVUoXiwUMDyx8=;
        b=pnv+4AX2wrHn9W/6Hz0JIuyv/s3i5IYyE6ERyaJchcSNrOURbiw8N6H3kVH2jD2Prj
         uqjwTg9MQK9fYz/pRiXbrfE1WFLhS/4nrcUD0zzGkAKdbXkM0PGWme+6rowZAZP1PY6c
         a117XHthVxhTodOJYdac63jrW2qVw4Iz54NSX5VrnPGQD7sJc3V4JfYqcP7631YQaIE9
         TrIKvH5jNYgx0kI5O2iiucUPBds5deZzbjsXVRVCg6xYmO8Z8ag5lihfUBMqESxgI83n
         VpAm0rgETAFyC98ewygxQS+eCex+6B3yHUz8N15o+tCDJOIga5WvTGcZo8TVeo7jl5Uj
         arZA==
X-Gm-Message-State: AO0yUKXrLPwto0WyWNBNEkRh3XLzmwFYk5Q8X4n+1MiaivzLz6zKzTVC
        MNE7FbmNiGCT+Wo3uv0fS/Y=
X-Google-Smtp-Source: AK7set9/BHGkdAw8o1Cv7koO/h1NyzpaxYr9qQcM1OLRNTB2NF7cD3mEFwx87vASTm67DuJXggtuBg==
X-Received: by 2002:a17:90b:388f:b0:23e:f867:e0b with SMTP id mu15-20020a17090b388f00b0023ef8670e0bmr3979057pjb.49.1678977374858;
        Thu, 16 Mar 2023 07:36:14 -0700 (PDT)
Received: from c1ion.lan ([139.227.13.23])
        by smtp.gmail.com with ESMTPSA id bt7-20020a17090af00700b0023440af7aafsm3262689pjb.9.2023.03.16.07.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:36:14 -0700 (PDT)
From:   MIngyi Cong <congmingyi@gmail.com>
To:     linkinjeon@kernel.org, senozhatsky@chromium.org, sfrench@samba.org,
        tom@talpey.com
Cc:     congmingyi@gmail.com, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH v3] fs: add the tuncate check of exfat
Date:   Thu, 16 Mar 2023 22:35:02 +0800
Message-Id: <20230316143502.7059-1-congmingyi@gmail.com>
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

