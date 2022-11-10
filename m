Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A88B623A42
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiKJDNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiKJDNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:13:20 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541CD1EEE8;
        Wed,  9 Nov 2022 19:13:19 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u6so414011plq.12;
        Wed, 09 Nov 2022 19:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ImFeFDYsXMyLunch28/Ff8jR4Jwu5RmwIqBQ6vLGVc0=;
        b=dRaz9vRVAYvShoIJ09oknHoIh+W1Y7xjhgNT5ylWjuT9QyXtFvwK1zOckMEx3K0vGS
         9jH4bqTLLa1QvUGiASffucoR2Rz+a1B6U4r3Ls1jA+gLrdaHN1K2hLIIk9V1sjyU83d0
         9qGLIKyl8WxBM9fGmNsoO3RenC0qUsRorrY2MCH2MOCAwzZKTrt+Z85Xep9N6PRFk4Jx
         XY22NKFo+Ep1XW9xuFOk6fRJnZBH2B0PzIdzJNbbwVe1i9ciQ90lRAjuSMmSw0zb6KtK
         cxxpWmA6Yih5fhvsST0RnnAWz3V7idyMsNsiKGqVFkdG8COD1AP1GB4x6rG/y65u34jT
         bYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImFeFDYsXMyLunch28/Ff8jR4Jwu5RmwIqBQ6vLGVc0=;
        b=LOpvhcN+xd9YTL7oCKJLLCGKiclkuXI7Sjs0KhjKLjmkLRXZ34yXCxQXFbieFOyB8N
         S5F+ik+ND95FMzzOmbLp+VMr822ZdzstawgMxP+gQyE3IEZzLyqwyTypgBKySoIwfbqX
         rWXkwNprlgudztNrev5iK2F6PR5aTPqymGzK6LSYF0ZjtLXQgzhAJd/UQLC2E69BqObF
         F+jlGkxjg0ZkEkAUPt33pclvQRhLMEWI2j2K5vxJBV9WIistrMqCUGGTrIXUIcLeNmqn
         WMl0MWXE1xOmc1qPcJEXTOSgsjM7EIUuzNUUZv1S8LVwE8iHp+BQ69ZCEAmvEg62IC67
         nsLg==
X-Gm-Message-State: ACrzQf0UKkHS1QSf8CDP+oiCzzcxvpNgkLklD98MEL8/uOhmMrn9baOE
        0d7r/0gjOY6DqozTQPpxWow=
X-Google-Smtp-Source: AMsMyM4aNdMU5619CiFduYOvGSrpKG9czPIbjGu7rIUwd9KyD/fe2nOmjQvAwlJ4hmRiktCKyUke2w==
X-Received: by 2002:a17:90a:e606:b0:212:f100:22e3 with SMTP id j6-20020a17090ae60600b00212f10022e3mr83094466pjy.83.1668049998899;
        Wed, 09 Nov 2022 19:13:18 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id u7-20020a63ef07000000b004393c5a8006sm8179466pgh.75.2022.11.09.19.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 19:13:18 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ceph: Fix NULL vs IS_ERR checking in ceph_getattr
Date:   Thu, 10 Nov 2022 07:13:10 +0400
Message-Id: <20221110031311.1629288-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.37.3.671.ge2130fe6da78.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ceph_lookup_inode() function return error pointers on error
instead of NULL.
Use IS_ERR() to check the return value to fix this.

Fixes: aa87052dd965 ("ceph: fix incorrectly showing the .snap size for stat")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 fs/ceph/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 4af5e55abc15..bad9eeb6a1a5 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2492,7 +2492,7 @@ int ceph_getattr(struct user_namespace *mnt_userns, const struct path *path,
 			struct inode *parent;
 
 			parent = ceph_lookup_inode(sb, ceph_ino(inode));
-			if (!parent)
+			if (IS_ERR(parent))
 				return PTR_ERR(parent);
 
 			pci = ceph_inode(parent);
-- 
2.37.3.671.ge2130fe6da78.dirty

