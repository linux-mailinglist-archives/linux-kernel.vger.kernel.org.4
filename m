Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CF26656BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbjAKJBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbjAKJBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:01:13 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7FE21B4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:01:10 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso14653034pjl.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hH22MjJlonlUf3pw4amhoXJiwGBol6P2BAt5F7FxeN8=;
        b=bLYd9enpioScpAW9rVN2QjpJg/ygZyBphwjbIv39uvf7AxXiErdnD1z+W04o9CVAUz
         +V9gGs2G0CT4y0/w6MX8huwuHAUcdKVjAh3HSuzY2ldS8NmN3w20TKjMWU1ykamz7siY
         V9BmwSOLKFkImwQmNeS0OKqyB8fNpVrvPgBR2M1FDnytf14DkpGC9LR6GhFkXnQy4qdu
         Q32L2/lRfwxbzBsge82CYbRr5xKflUCrLLQqnYGfxJ9C13BXXVO2Gq4zWoYJRRcMXgMY
         4HjX2aGMifcysGmNsFFRfBDI+Q9CZ2ap3Q7CpqpD4tWvdjyfZMTrAi43DYc1puLuw0RS
         KeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hH22MjJlonlUf3pw4amhoXJiwGBol6P2BAt5F7FxeN8=;
        b=ac972WfW4pYmZ6o2vpO9in2qt9HTdo9TlJGoW25TGLy+mHqPZwnvot9g75abFHJ7/4
         ScWolTkAUW+sl5LVdH+XalceValabItJktxzKkZbbSwbarm8f/l+WrJ0SpCKy3wdbPDn
         8Lsgnka3Tr16C4wjhBsqGDpqD7lKszuPnEA+nuPIp1ubq2TxeHKtX/P91tEdsqlkHp88
         hCoajFm79A/EVeZST1zmCzSVbzTF7b0k9jkHD7+uu1B6Yi0tQ4irxLsdvKDJyNRvqfO7
         dZJoaYluythEpOtchlJBEA+jdNoupv/9aAh4ZlfQFB5SPg/PimdvXqEdx4uDTq5EjOWa
         RCtA==
X-Gm-Message-State: AFqh2kr35QtI9S+yzjARZ77pE1juVmxsR413N3S0dxI6xGbYdEZZZYdm
        I4jXaYY1RkcIOJ/037nBz1Oml51Zqp4KgQ5f
X-Google-Smtp-Source: AMrXdXtf5UnKZ0rosBIS1PUESD95GZoICBs/0NwqG7g45YcyK3qfrmsMkWjNt3DirJMTQrsnpsJeyw==
X-Received: by 2002:a17:902:ef8e:b0:193:2bed:3325 with SMTP id iz14-20020a170902ef8e00b001932bed3325mr1910709plb.15.1673427670466;
        Wed, 11 Jan 2023 01:01:10 -0800 (PST)
Received: from bai-Lenovo-Product.tsinghua.edu.cn ([166.111.139.145])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902b19500b00189e1522982sm9549749plr.168.2023.01.11.01.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 01:01:10 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     almaz.alexandrovich@paragon-software.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: ntfs3: Fix a possible null-pointer dereference in ni_clear()
Date:   Wed, 11 Jan 2023 16:59:43 +0800
Message-Id: <20230111085943.1127-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a previous commit c1006bd13146, ni->mi.mrec in ni_write_inode() 
could be NULL, and thus a NULL check is added for this variable.

However, in the same call stack, ni->mi.mrec can be also dereferenced 
in ni_clear():

ntfs_evict_inode(inode)
  ni_write_inode(inode, ...)
    ni = ntfs_i(inode);
    is_rec_inuse(ni->mi.mrec) -> Add a NULL check by previous commit
  ni_clear(ntfs_i(inode))
    is_rec_inuse(ni->mi.mrec) -> No check

Thus, a possible null-pointer dereference may exist in ni_clear().
To fix it, a NULL check is added in this function.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index f1df52dfab74..046ec4179d75 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -102,7 +102,7 @@ void ni_clear(struct ntfs_inode *ni)
 {
 	struct rb_node *node;
 
-	if (!ni->vfs_inode.i_nlink && is_rec_inuse(ni->mi.mrec))
+	if (!ni->vfs_inode.i_nlink && ni->mi.mrec && is_rec_inuse(ni->mi.mrec))
 		ni_delete_all(ni);
 
 	al_destroy(ni);
-- 
2.34.1

