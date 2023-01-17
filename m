Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACD666E3D5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjAQQlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjAQQkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:40:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783BB4391E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:40:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 226A1B81912
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF940C433D2;
        Tue, 17 Jan 2023 16:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673973645;
        bh=ohNhLcl7ZBCy0V6fiGxWso45p6IUpH/KOpa3C6RXoBg=;
        h=From:To:Cc:Subject:Date:From;
        b=TpU/QZ32VeI8KvA2OJecBkRuIvtNvdTw+O8YkNOUsCok6Ec8t+OhV9jgvMvOnPMBF
         N41Jw1o8ynSX894bApmI8CzW95zktQk/WT6SzKn8rPIeAmKFYpwn20H477CnzHj436
         2sQwdPbAy1Lxtab7DIewHHKjLHCzruc6GmbQq6VASN0h0TQbTZdkXV1T7aMkFw+ydW
         QDTQVG3e88ypCmMifnj5eXnQbSVJRGVQS0S2dldmrBNhcfNm2PmtSSYBe85AGfYW0n
         8E8/je+cVxfM/ir0QyAr8msWXnUOjbB45bXJPLhmbzWzLTJacSbHjq3HMgchsLiMSq
         EGwi0DFjXcaFg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Richard Clark <richard.xnu.clark@gmail.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: fix enum type for gcc-13
Date:   Tue, 17 Jan 2023 17:40:35 +0100
Message-Id: <20230117164041.1207412-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

In gcc-13, the WORK_STRUCT_WQ_DATA_MASK constant is a signed 64-bit
type on 32-bit architectures because the enum definition has both
negative numbers and numbers above LONG_MAX in it:

kernel/workqueue.c: In function 'get_work_pwq':
kernel/workqueue.c:709:24: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  709 |                 return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
      |                        ^
kernel/workqueue.c: In function 'get_work_pool':
kernel/workqueue.c:737:25: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  737 |                 return ((struct pool_workqueue *)
      |                         ^
kernel/workqueue.c: In function 'get_work_pool_id':
kernel/workqueue.c:759:25: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  759 |                 return ((struct pool_workqueue *)
      |                         ^

Change the enum definition to ensure all values can fit into
the range of 'unsigned long' on all architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/workqueue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index ac551b8ee7d9..fba8d0154a1e 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -83,7 +83,7 @@ enum {
 
 	/* convenience constants */
 	WORK_STRUCT_FLAG_MASK	= (1UL << WORK_STRUCT_FLAG_BITS) - 1,
-	WORK_STRUCT_WQ_DATA_MASK = ~WORK_STRUCT_FLAG_MASK,
+	WORK_STRUCT_WQ_DATA_MASK = (unsigned long)~WORK_STRUCT_FLAG_MASK,
 	WORK_STRUCT_NO_POOL	= (unsigned long)WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT,
 
 	/* bit mask for work_busy() return values */
-- 
2.39.0

