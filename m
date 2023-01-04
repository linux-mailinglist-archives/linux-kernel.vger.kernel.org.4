Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D38765D2EC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbjADMkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbjADMkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:40:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC686101DA
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 04:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672835957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HT6SGP2i78kW2gUupMImNqxz+qH6nvN5AI03QdfPR8A=;
        b=L97IF2TRR/9Qgi503PlURXpeTfJpo0vpojSVqp5pfiWFGagGJ2IGaysdy5EC3n6n9fNsVw
        qITyfXG+bOwEoNrQufjpDwoQ+MMO1NPelP58hrkHVaW5QIkCoRQXOyUTet/Uy23TJdxYw8
        KM6KFDilvlo9UiEXUFdkFjn3FXOerVA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-124-WviMSk1iM7uXS-s-Z-brcw-1; Wed, 04 Jan 2023 07:39:15 -0500
X-MC-Unique: WviMSk1iM7uXS-s-Z-brcw-1
Received: by mail-pg1-f198.google.com with SMTP id 191-20020a6306c8000000b0049699771579so13061451pgg.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 04:39:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HT6SGP2i78kW2gUupMImNqxz+qH6nvN5AI03QdfPR8A=;
        b=UgjOp9CuAC5boHXBzYu4ZmpKABUwD3a7Yw+kFHUfqk00lrfm0zWW0q5lSNBKZndwxD
         qGDYvfq1oap1VgSFPArCN8rI/zym2q9sICUsskGP7Oj4SFxOaQw5cC0njw2Zos1WtXOP
         OhtisiI93q4bgzgiuxCduVM6gmgKty7NIIh7BDj9Rp+fwIqMtcI3E/5AG035At5ZjAyx
         jgBEDd44Tmt2ndKKZYV8gCgIqsF2ktATjQhvi5YNCN/bO1o32y+nHJLl1o/QqZWfSiNM
         z+DEbI84H48tj06Yf3CYbnaamvvxa9fX2HbFXDeHdYdhYHf/D+NWiwgwQ0lmpnLi6A2g
         1vSQ==
X-Gm-Message-State: AFqh2kpPv+5v7hO94Q5kLVmXaeYoxNUF2IwaRl3yiXOkNbhO8lEfqpsg
        9144zcwqHBwF7s0+grCb6GEQJALwuOIrylBYColuzjUDzG8mIAu4iD4WDlwATidvVTtFa8iUipk
        bbuq1ZtH7/I4rHnGWG/YdEkY0
X-Received: by 2002:a62:1b85:0:b0:576:450d:6e68 with SMTP id b127-20020a621b85000000b00576450d6e68mr44274767pfb.27.1672835954977;
        Wed, 04 Jan 2023 04:39:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuS+56hyDv4XiZSPomeGZ+6oZdoxwahD5jgKiXMmSvgP6DBwRwRh4MgdTAmN+0r/VSrpMEl4A==
X-Received: by 2002:a62:1b85:0:b0:576:450d:6e68 with SMTP id b127-20020a621b85000000b00576450d6e68mr44274751pfb.27.1672835954684;
        Wed, 04 Jan 2023 04:39:14 -0800 (PST)
Received: from localhost.localdomain ([240d:1a:c0d:9f00:ca6:1aff:fead:cef4])
        by smtp.gmail.com with ESMTPSA id y188-20020a6264c5000000b00580e3917af7sm19352828pfb.117.2023.01.04.04.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 04:39:14 -0800 (PST)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     almaz.alexandrovich@paragon-software.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH] fs/ntfs3: Fix error handling in ntfs_new_inode()
Date:   Wed,  4 Jan 2023 21:39:02 +0900
Message-Id: <20230104123902.978084-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When memory allocation for mi->mrec fails, ntfs_new_inode() calls
iput().  iput() calls ni_write_inode() indirectly, it references
uninitialized mi->mrec, and this causes the kernel crash.  This patch
fixes the issue by making the inode bad before calling iput().

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 fs/ntfs3/fsntfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 567563771bf8..7b93f2aeb6f6 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1683,6 +1683,7 @@ struct ntfs_inode *ntfs_new_inode(struct ntfs_sb_info *sbi, CLST rno, bool dir)
 
 out:
 	if (err) {
+		_ntfs_bad_inode(inode);
 		iput(inode);
 		ni = ERR_PTR(err);
 	}
-- 
2.39.0

