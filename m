Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343506E7400
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjDSH2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjDSH2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:28:02 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315EB7A87
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:27:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a6f0d8cdfeso13842005ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1681889272; x=1684481272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bD/SvEkfhf+lVwF/ikMxaAtATUdOMTpwagzMnJrn3YE=;
        b=iRYzVjWclaREWqyJvQkvfResoHZcSCSPO7asLuN4ys0u4MNm8hMoIyc7WTcS+9UigZ
         HF3y5Va2WpldD/F7sXNF3xsXHSl5LakN3XG8QjdPk2qE2CI3IGp2etkWTq6Yio/kMQgc
         edgTJ6tT4adPzwVtrS1ZFut8uGFn7AEZI9BNeocs8sHm0QjhAM+L37W5lCgnFz6LuKpw
         t3buqzv9dakHh9POeb1ZMfYq8ydMKWgfg02FG4lINEbfBv08ZP1RntdnY/36JR4DhJ+I
         DtSjYNtdX7NO5bb5FHVJUxAYp1MasNqiWbXBPHDapHAh1qO+qPrqKB/mfazCw9qxTE0a
         6ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681889272; x=1684481272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bD/SvEkfhf+lVwF/ikMxaAtATUdOMTpwagzMnJrn3YE=;
        b=NAo7lk7oleKf1jFtElSjIdgU78FkACJBCuqGpNzLRB3D9zUxtDrFHx8IUFL6j+4Wnp
         YS4A1buUuhdgcQSVzPZua7iBrxyyaL//yOZ8alcTmzK9vMUSn+Y+4r0eduxOVczgk+Qn
         WOe+4hDlZY0B6Jjl/GgzJt8IbwKqVHIl1tXLmYBKgk5NlxraD2iIUDobJAt5qOSR+t7x
         UNkrNpu4VHkHfhr6SfkUpnyBGh+z4Xt+XxAFaq0wM0m+KrBrrHid+JN+Sjtq1TOAyrFy
         PYsNJSQVWCUtViVXcOYBd8c7sNrk3W0ZD6Z6MFypfr2BAOujPo6CywO2Om2IcbHzmMuf
         GzUw==
X-Gm-Message-State: AAQBX9cXqgrBSd2+yOP/FU7RKCNpzW+5jkU1dxITSMoyBLR6LxP+ETr2
        6fnfumim9zAQhEiZ8AUGeYWhXw==
X-Google-Smtp-Source: AKy350YCr2jblDnngZ/tnwDmsUWu4GqzhoY4TYEXUrENPvDWVt4YeUyj55NN5WEV42prQIs/IU08DQ==
X-Received: by 2002:a17:903:1c5:b0:1a6:a1ec:53a3 with SMTP id e5-20020a17090301c500b001a6a1ec53a3mr5926551plh.3.1681889272613;
        Wed, 19 Apr 2023 00:27:52 -0700 (PDT)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902eb4500b0019abd4ddbf2sm10762587pli.179.2023.04.19.00.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 00:27:52 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     viro@zeniv.linux.org.uk
Cc:     bigeasy@linutronix.de, mcgrof@kernel.org, mszeredi@redhat.com,
        xiubli@redhat.com, linux-kernel@vger.kernel.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 2/2] vfs: clean up d_backing_inode() function
Date:   Wed, 19 Apr 2023 07:27:36 +0000
Message-Id: <20230419072736.172593-2-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using an extra variable to record the inode is unnecessary, return it
directly.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 include/linux/dcache.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 13023c7211d6..97324b6434e5 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -540,9 +540,7 @@ static inline struct inode *d_inode_rcu(const struct dentry *dentry)
  */
 static inline struct inode *d_backing_inode(const struct dentry *upper)
 {
-	struct inode *inode = upper->d_inode;
-
-	return inode;
+	return upper->d_inode;
 }
 
 /**
-- 
2.25.1

