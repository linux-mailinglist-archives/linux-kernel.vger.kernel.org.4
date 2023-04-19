Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4546E73FD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjDSH1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjDSH1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:27:53 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A557A88
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:27:48 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b73203e0aso14180128b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1681889268; x=1684481268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSoHVlZS36edCYjU/v/RuuwOO4uL+FEpJ+Bh/7CgMHo=;
        b=FunZNdOtmCdb8makcm5N4dCGZq0Ujrm0Ao0FiH8HYK2cw5V6ehNUkJ9Mlrvjxb4Bqf
         OCVRK827rDA9/2X1G62L0Y6pKmnwYPGsIno4UCDmNmetu2UtA1RJRwbQ9D/0RhIKhNTB
         cUR2IEOb9k94mV9lDgy73bF9jLMAz++SBRbWbk657njW9M3QVMI0Pa6vn4/iciR3JOwL
         4DHOlvZayBbO57GdHouJPd+oODUKgWpeP9BkmbpvEGsnnmzEdqSoHGKfIIdf1jwYAV89
         c6SdwK06LotXS3gYIQ8Qa0N9Yza+dNmsEjrikXJNFDqQJl+VW5YwrQ3AdqEEaV8sXgqv
         g8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681889268; x=1684481268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSoHVlZS36edCYjU/v/RuuwOO4uL+FEpJ+Bh/7CgMHo=;
        b=TWdnAQoN0k8kVgk7b0DVfY/5BI+pVq1EjXmZQy4suxwOgY6vSHxbZ3ljLIkt2eIDrs
         F8j3m6MOUaoCyzsBNoFLPFQxUnUi+gFCkNHyRAn4nVsHFZlIZdR15+41KlLWMJuMBBWn
         QN8DEtoMACSRi7UVe5VARynvOfbwBdgSQmsTkzMDa/kQp8f5lB5f2lmTIjQtw1Id/3gv
         +jvpVsS0/4grr7uwd/XpYOfTYkKhfoRu2zbo0YMjyMVpotLIBNlHow77wrN4vKIfNrdZ
         GWnGhiT1yVCLVm8uA3UVKgRoKR3iiL389jXT7w4MwRK5rN4qdx/d8O6eYjdkT01oxNt0
         ReEQ==
X-Gm-Message-State: AAQBX9c5Aotzm3dP3AOr1B1dRz60n4Y45C2vm1GPCk4uaACnaRMSmU7d
        l8GdBCtt17pATXKgSLdf2x2NPoV+oPLK8P8bsxZ0nQ==
X-Google-Smtp-Source: AKy350bTm31lpb8UyGijbHK6avlBhqzZVGNzJcNxNvoJ5rPHpg3wANW9I7Dk4XyUFqcWtv800WyMNQ==
X-Received: by 2002:a17:902:d2cb:b0:1a6:3def:5ff6 with SMTP id n11-20020a170902d2cb00b001a63def5ff6mr1835136plc.4.1681889268302;
        Wed, 19 Apr 2023 00:27:48 -0700 (PDT)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902eb4500b0019abd4ddbf2sm10762587pli.179.2023.04.19.00.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 00:27:47 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     viro@zeniv.linux.org.uk
Cc:     bigeasy@linutronix.de, mcgrof@kernel.org, mszeredi@redhat.com,
        xiubli@redhat.com, linux-kernel@vger.kernel.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 1/2] vfs: remove unused d_backing_dentry() function
Date:   Wed, 19 Apr 2023 07:27:35 +0000
Message-Id: <20230419072736.172593-1-haifeng.xu@shopee.com>
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

d_backing_dentry() isn't used by anyone, so remove it.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 include/linux/dcache.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 6b351e009f59..13023c7211d6 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -545,21 +545,6 @@ static inline struct inode *d_backing_inode(const struct dentry *upper)
 	return inode;
 }
 
-/**
- * d_backing_dentry - Get upper or lower dentry we should be using
- * @upper: The upper layer
- *
- * This is the helper that should be used to get the dentry of the inode that
- * will be used if this dentry were opened as a file.  It may be the upper
- * dentry or it may be a lower dentry pinned by the upper.
- *
- * Normal filesystems should not use this to access their own dentries.
- */
-static inline struct dentry *d_backing_dentry(struct dentry *upper)
-{
-	return upper;
-}
-
 /**
  * d_real - Return the real dentry
  * @dentry: the dentry to query
-- 
2.25.1

