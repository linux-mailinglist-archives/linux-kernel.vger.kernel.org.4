Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA19605EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJTLaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJTLaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:30:12 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A67E108DC6;
        Thu, 20 Oct 2022 04:30:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y4so1165772plb.2;
        Thu, 20 Oct 2022 04:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oxkGsht8Um+eQ+AA7QKGJnPL5aBRWvNYoBIpMYroGm4=;
        b=jZtD2P3GIVjFPZkSUmowjCEhkSQTvPcvND+AfjIb6qweRdwnG03O+zmnmEYQ5osRtL
         teoCIB2sLgezbRp+C2Qfv/12yC4p3fYkTT8MzqaK6FfKbdFyGWC/AT6liTuG3gMn+iVm
         JdpVOvZvxPN2DvTAMpe9vU+/PxU/+TcPKRj7LSE8/ojly6rBd0ggiVjAh/OPEa6EGayd
         n0XPjUozMyNbzMpdiwJGBdHNUul1c5rO8wWDcxZEj5RbIiFri2LHODT0twLn+XOYdIrg
         ytADM1bsY2IkS0QHbct0LkFcd7kEi/JNwXf1aZx/EZ7GrEBe7EWIcy03G6J4ECChl43a
         77Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxkGsht8Um+eQ+AA7QKGJnPL5aBRWvNYoBIpMYroGm4=;
        b=hr7XU92Us7IbsIyT8mMtZ4bqolrB/4EhiJ4SeZOOa6zodwXBw59Ox6/h7t/05Ksv8t
         NzcmMGT7LhYfwLkdKPVYhcfum82lKrWfk5jOtbq8rVPPsfzGHoThvp+HbW9Xl5g9OHK8
         GFAiAlXzBctAMOLX14nMScL/JrmIQbH8NO0qLSwPe1hiNYZNYZGg32ja2pCI2OxIzJE+
         FcowMkvwh0TC8LD9sb8aPIJvFMrB29dPE0p9jxhUUVm2HuG/a4+NcRku0iR0quN5GBON
         sUNTMjXjsMjIntolhYa9V+seGyXeG7CfPDhoFwaIMLDsSLwwPZLJ+QE3+eZnagncp4My
         WSRQ==
X-Gm-Message-State: ACrzQf1PZisQYqOt7VfGX0WgtWTkjAQS4vzzWRSv7wwZFVKLLTZlfCgS
        50e1dhfMh0Sue1kdviP9BUk=
X-Google-Smtp-Source: AMsMyM4uzCN4Fy0l5xIt4oMVRAoHTiGctlsItIuQgXL2SYAEs0yARZdIleQ97SzmJVT0qrPbCFMO1w==
X-Received: by 2002:a17:90b:1a84:b0:20d:5086:3694 with SMTP id ng4-20020a17090b1a8400b0020d50863694mr15913301pjb.74.1666265409872;
        Thu, 20 Oct 2022 04:30:09 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090a284700b00200461cfa99sm1539369pjf.11.2022.10.20.04.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 04:30:09 -0700 (PDT)
From:   yexingchen116@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     slyich@gmail.com, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next] ia64: Replace IS_ERR() with IS_ERR_VALUE()
Date:   Thu, 20 Oct 2022 11:30:04 +0000
Message-Id: <20221020113004.400031-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Avoid type casts that are needed for IS_ERR() and use
IS_ERR_VALUE() instead.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 arch/ia64/kernel/sys_ia64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/kernel/sys_ia64.c b/arch/ia64/kernel/sys_ia64.c
index 215bf3f8cb20..f6a502e8f02c 100644
--- a/arch/ia64/kernel/sys_ia64.c
+++ b/arch/ia64/kernel/sys_ia64.c
@@ -140,7 +140,7 @@ asmlinkage unsigned long
 sys_mmap2 (unsigned long addr, unsigned long len, int prot, int flags, int fd, long pgoff)
 {
 	addr = ksys_mmap_pgoff(addr, len, prot, flags, fd, pgoff);
-	if (!IS_ERR((void *) addr))
+	if (!IS_ERR_VALUE(addr))
 		force_successful_syscall_return();
 	return addr;
 }
@@ -152,7 +152,7 @@ sys_mmap (unsigned long addr, unsigned long len, int prot, int flags, int fd, lo
 		return -EINVAL;
 
 	addr = ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
-	if (!IS_ERR((void *) addr))
+	if (!IS_ERR_VALUE(addr))
 		force_successful_syscall_return();
 	return addr;
 }
@@ -162,7 +162,7 @@ ia64_mremap (unsigned long addr, unsigned long old_len, unsigned long new_len, u
 	     unsigned long new_addr)
 {
 	addr = sys_mremap(addr, old_len, new_len, flags, new_addr);
-	if (!IS_ERR((void *) addr))
+	if (!IS_ERR_VALUE(addr))
 		force_successful_syscall_return();
 	return addr;
 }
-- 
2.25.1

