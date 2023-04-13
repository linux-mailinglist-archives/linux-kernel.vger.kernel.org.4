Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66496E05A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 05:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDMD7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 23:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMD7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 23:59:00 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214F940F4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:57:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j8so12275041pjy.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681358278; x=1683950278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YJGRTZkA5BN2qD8Z6WUNMxuaviulFYl0QBBAj8i8gIc=;
        b=XGmPAZ2RAQ9Ik5StN07HIt6NRnh/K6LU4Rz7k7zpLK/KNy2A2ErXBWQqJN/7NQQMkT
         KYvRdP2QtEJ8ux/sw6j3Pt7TtnaPILyv3+GuX55N9l7QtZ1/YgQ29x7XTSMO0VxhMajA
         boEAtNI/WRhO3eB3Sa18eQao0Py68SMxWWcqQlzPefENA25gLeVp/d4RsSe3aW4P16AW
         yN3yxW/m6BcbvyHeow9+/ilX+tlvQvFNeimSq5+2FSJpv4nbejAYFcj7phCbDjBNCGd4
         PPIx6QPbsgeJm6vk22FFbY5ogKiXPppV103Vs8GCO+bdBp5yPMWZ2Zv3s6tjqsqgisBA
         pwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681358278; x=1683950278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJGRTZkA5BN2qD8Z6WUNMxuaviulFYl0QBBAj8i8gIc=;
        b=R7gtiLganlFNeaqAGeZ1PdG1p0dYJ87PruYmhMXN+o9TMsT0pSxlQL1c1l4GeYU3J5
         WrG+eo+x04rgsSVVGL0GS6QzuBDvFtQ0GOgAgfInNxXZtj0pViApevjwLZcfIA6aX4X1
         AiE+G8Mewqr6YtQvcZYLJw0uKWDJFQdzTBQ2r9rEkuJcMcGvejmK8jRbOmvayK1KAtVF
         64LJ8eW2MGUW/xIT8Ic/NssPiKjHI6Bb9rDGaj7JcGZRJzv5XV5+MvpsJac72vnhHvj4
         ZaNXVQbRU+qjfFvJrqDYfdzfwSsUcFz3qD7bPIDFqoF9mjgp1qKiI9xfxOhR/3kR7pHB
         asiQ==
X-Gm-Message-State: AAQBX9dX76cxiKFCcb8M3S/KNFtwgE0FcrUqE1u9BDTDCCSZNhtE5DaM
        xXbn2tPa5nsC/54T8CELwkwITQ==
X-Google-Smtp-Source: AKy350buz1nbJi9w0aYjLrjuzCx8iZBAN4QoVrVRzzuA4RbJ5fv2Cy9WVoKWXwscYMK+1b1xY8oNGg==
X-Received: by 2002:a17:902:e842:b0:1a6:7570:5370 with SMTP id t2-20020a170902e84200b001a675705370mr837413plg.10.1681358277944;
        Wed, 12 Apr 2023 20:57:57 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902b08300b001a2806ae2f7sm359069plr.83.2023.04.12.20.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 20:57:57 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jefflexu@linux.alibaba.com,
        yinxin.x@bytedance.com, xiang@kernel.org,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH] erofs: explicit cast blkaddr to u64 before shift operation
Date:   Thu, 13 Apr 2023 11:57:34 +0800
Message-Id: <20230413035734.15457-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should explicitly cast @blkaddr from u32 to u64 before the shift
operation to return the larger type.

Fixes: b1c2d99b18ff ("erofs: avoid hardcoded blocksize for subpage block support")
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index aa7f9e4f86fb..6fe9a779fa91 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -35,7 +35,7 @@ void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
 		  enum erofs_kmap_type type)
 {
 	struct inode *inode = buf->inode;
-	erofs_off_t offset = blkaddr << inode->i_blkbits;
+	erofs_off_t offset = (erofs_off_t)blkaddr << inode->i_blkbits;
 	pgoff_t index = offset >> PAGE_SHIFT;
 	struct page *page = buf->page;
 	struct folio *folio;
-- 
2.20.1

