Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CD36EDA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjDYDEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjDYDDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:03:43 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E648A125
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 20:03:41 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51fcf5d1e44so5339369a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 20:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1682391821; x=1684983821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2rFQtrx1ty7B4r1qrgH1YW8+Ro80LU3EuWe10fYmSqI=;
        b=icSC7N2IbSVb5vnj3m+vx6C2m578OCY4Gtj7B9sDJ+ipQFiU57EQR/z3B+eamhMqCm
         +A7oKigqJ0f07DyuK/3bboKb3aYtuMVipEyi2l4234hRG+t8JDUigD/96ME5Zyf3ftZU
         Ncnd/EOSMHLrqUnpnxZoHRHFNBDG1NnyAY4/+6mBbn5CKKt7drkqHMIPue9QdazYS0sY
         tzKv7Nk2IILHgQpV2CtTjtfj3oKfdnS9ActLBy4owC+gCoYFpyqpk/saDKra0KtYEL3u
         v5jhimxnu2DZT3kEhbskh4emobOJqX+d3cp6NdZ7RlWKnGroaYVVYBVaOJi3ht+WyZLB
         07Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682391821; x=1684983821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rFQtrx1ty7B4r1qrgH1YW8+Ro80LU3EuWe10fYmSqI=;
        b=apjEBNORwtXwdoc3FzwIJ81GEbvk9y3hEwrUDxjkFWhg74VcKJoVAMw/tdQvJs9NuX
         G0/+Olyg4jW9rqDMIFoNxH+0W3Vs1+dPMpPEE+ISoOO3e19xXSDsNbfZvpQEKSx9Cw7/
         9QxhobR3CRmF75B6KrBF3/lpUrJWD5O8CHutO/cdAsblyjdCaaxMNxo9JP5dh9vEw3nE
         DGduQ7yFTLzXAAa214s+9NW2XfHSTmetWA3B0qPd8jl86fdFaNGcZF2LNodByfP8dNpa
         1AlUmL5yNNZWGdwrdpI0NIAaLqG4b91NquDStAl5NqDWWl0bGfqN3YA9F7uf1YyW1/Nv
         S+HA==
X-Gm-Message-State: AAQBX9cDZEzluslBIotUCKqqugJh1u2hXfdUZsSX/d1XTof8SNhtZO7+
        lqJh838U3vfPlfzSUn97Tf0jiQ==
X-Google-Smtp-Source: AKy350YD7zwjVfmU/nwsQ/e7xwcB4Irn5Xt8oAyNbJGifiL6xT346KHALcii8EodaLs/0vcNrznaZg==
X-Received: by 2002:a17:903:40c7:b0:1a6:9d1b:e18f with SMTP id t7-20020a17090340c700b001a69d1be18fmr14993745pld.45.1682391821332;
        Mon, 24 Apr 2023 20:03:41 -0700 (PDT)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902e90500b00199203a4fa3sm7171508pld.203.2023.04.24.20.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 20:03:40 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     torvalds@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, mszeredi@redhat.com,
        bigeasy@linutronix.de, mcgrof@kernel.org, xiubli@redhat.com,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 1/2] security: fix code style problem in security_inode_rename()
Date:   Tue, 25 Apr 2023 03:01:17 +0000
Message-Id: <20230425030118.4982-1-haifeng.xu@shopee.com>
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

Code indent should use tabs where possible

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 security/security.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/security.c b/security/security.c
index cf6cc576736f..af83d4eb4f1e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1317,8 +1317,8 @@ int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
 			   struct inode *new_dir, struct dentry *new_dentry,
 			   unsigned int flags)
 {
-        if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry)) ||
-            (d_is_positive(new_dentry) && IS_PRIVATE(d_backing_inode(new_dentry)))))
+	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry)) ||
+	    (d_is_positive(new_dentry) && IS_PRIVATE(d_backing_inode(new_dentry)))))
 		return 0;
 
 	if (flags & RENAME_EXCHANGE) {
-- 
2.25.1

