Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B068F6CC060
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjC1NOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjC1NOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:14:01 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D161B458;
        Tue, 28 Mar 2023 06:13:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u10so11585846plz.7;
        Tue, 28 Mar 2023 06:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680009222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9vHjCxIjnbJV+D1kIkkgMWfWHa4MSx5Br+Gi/URJXY=;
        b=eASSDHDI/SwtNuH2zZQNURqNiP7TcxCqqOkwEvoTB6VPh9yCsDi9eQEKB9qSwZfiDu
         t0Y5pp5a2WtAajKUVBiP/OlefYDH67ApHEbkGXEQfYUGBYQp4GzVUahT6aDH+fEcIXaL
         WMrLt9Fn9XdseCjBzzwD9hJzCS4CDIrfRC+VSr+XNyV47h+nr6atYaSYXAdIp+b3bMYc
         LED3SlaUpvBhOqTFdPLPCIoyFvGaC32Uucl0Vw6WnSBgPQMlRTrDBI/U79Fy5niKwx0A
         rMQIqv38gwFYIgkJHhHYej3w+0S2wFG73gsZacVfm1qoilllZ9Wc/hvkfuPMPIBgzwWM
         91zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680009222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9vHjCxIjnbJV+D1kIkkgMWfWHa4MSx5Br+Gi/URJXY=;
        b=67DOu8IhfxkeUBX4hxC7/dtGRszeRLVhM0gUw9s7i5KGGuwj3k0v4Yt2dqtKkq3bX+
         jXxFzySs/q97efkWqQaDLlkyNqOr622iCyNPytCoLmQzJITa7e9JKFch0ZBMX8K2KZJo
         yJGhjZig6M48ju2t44jei6q0HWclug0NskKkGvS2OZHpQAz3EtEQAFU9JNBlh4Ln1yJO
         CaEGtsc750FAajIDY/6YTz2sL82YB4rvc5VtNkQwDBQFoeizC/TirzG6SmrUNRYZV3IF
         WpPhDiRGwsGf4l02uaupliioHLSyUf7+AzxQ8rAUge/LvtJbk7vmpaPwn389ptIqb4Hz
         1WcQ==
X-Gm-Message-State: AAQBX9eatHT7/WccnjLARSBImYVO6DUUEY3Yxt5IBqKXKngMk60r44fw
        t0W4GAPcatMjz/7bg0DFHy4x2x2xZeK9eQ==
X-Google-Smtp-Source: AKy350aJ+T+hdHviafYXKpyM3dcU1QV3g25fUqBprPiMOv0XbIa3xlXVbCVQ9jrzJvjk6a8A6Fj1iA==
X-Received: by 2002:a17:903:886:b0:1a1:bcaa:aaea with SMTP id kt6-20020a170903088600b001a1bcaaaaeamr14617060plb.3.1680009221761;
        Tue, 28 Mar 2023 06:13:41 -0700 (PDT)
Received: from c1ion.lan ([139.227.13.23])
        by smtp.gmail.com with ESMTPSA id io20-20020a17090312d400b001a1faeac240sm10642646plb.186.2023.03.28.06.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:13:41 -0700 (PDT)
From:   Mingyi Cong <congmingyi@gmail.com>
To:     linkinjeon@kernel.org, senozhatsky@chromium.org, sfrench@samba.org,
        tom@talpey.com
Cc:     congmingyi@gmail.com, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH v3] fs: add the tuncate check of exfat
Date:   Tue, 28 Mar 2023 21:13:34 +0800
Message-Id: <20230328131334.5572-1-congmingyi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKYAXd8GzB_onCcs=2aZs0MGTy_7oGhECEdr+rcdVS+Jf2C5xQ@mail.gmail.com>
References: <CAKYAXd8GzB_onCcs=2aZs0MGTy_7oGhECEdr+rcdVS+Jf2C5xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: MIngyi Cong <congmingyi@gmail.com>

EXFAT will fill zero data in truncated range.
Fix this by adding EXFAT_SUPER_MAGIC check.

Signed-off-by: MIngyi Cong <congmingyi@gmail.com>
---
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

