Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516AE6FA014
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjEHGpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEHGpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:45:44 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E6C659C
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 23:45:42 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6439e6f5a33so1980796b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 23:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1683528342; x=1686120342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rB0preXJQDdZyaNevNbkz7vJIIhOUzVqaFbE1aywo6c=;
        b=YlkEosC18ruD28Z7PwwXU5IhElCJkF8AZttgQOMzDUKALtZDp0VVXxrQrxVjo6IX8Z
         K8tJj9SWOcMFT2ZCNsaXAMC8Si3EcmJJ8n5m872ECpp6U5Jc/6w3QHH8bnTEQ/m3Bqfb
         R8NgSiQ9hmV/YdmU31menkJYE1BGsgBxXwEkrkANnj3MW0xLIQ/ipr4mGPu3j33Azc5s
         44dgLkNv0LDcyWlflGek6NnxIgFpSMrBxQ46kFUBZOO3KAG4pEAYqI0DeN1yalp5czVy
         L/SHYa3OkMIh0jw3ZmU503LHvUV1nr0SuQd1o65O3QL3RVjBAA0XS79GaUYriFX/REhr
         TVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683528342; x=1686120342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rB0preXJQDdZyaNevNbkz7vJIIhOUzVqaFbE1aywo6c=;
        b=GhGk9iodKGaeVjyEV48bVm29O69aWIJlmoLbHmmFpbIPoy/0UHLT6u93e9EX/mc6yt
         5HsjewqQAKC4vD6LO+7N+u3zcxxCiueL/jDmUOCe4rgxtv2PZhjQiLfunH4qcy2QtdJ3
         osHFRahfJJQVLDkTOYYE4L1FCiTKQ4ZKIa1ZvtDJ4f/qZHcXF0xmU4sqMr/9uMmb8wbX
         iXqBq+foArg1XEnyFxMjV+prlpalPJv8feKF6rZS0DNhLxomfUXbGmM7MvUIItmZTvwA
         wDxi6OzDMPaufILvaR4BALRd2SA834dZBtg9BjVZ9m00++8FX74tMCxcrNcMaS9Hl516
         KjHQ==
X-Gm-Message-State: AC+VfDwZKYiK+zdESzqFf4gxnm5qLjCs82A+po5w1T1IT0VednEpvEBT
        TgOsQI6i1wEH6CSTOm+2wd/ssskHxKpm5S2uIQgCjA==
X-Google-Smtp-Source: ACHHUZ68LVxHUDgNzzOFZFWer4lo0K37XaBwgoSPSC+tbmzTDwmDma26d4U3+vtxRgG9ehfeuUlz4Q==
X-Received: by 2002:a05:6a20:42a9:b0:100:a2ca:7ca8 with SMTP id o41-20020a056a2042a900b00100a2ca7ca8mr1809424pzj.54.1683528341786;
        Sun, 07 May 2023 23:45:41 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id h33-20020a635321000000b0052c3f0ae381sm5501867pgb.78.2023.05.07.23.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 23:45:41 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     luto@kernel.org
Cc:     bigeasy@linutronix.de, tglx@linutronix.de,
        akpm@linux-foundation.org, bristot@kernel.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] fork: optimize memcg_charge_kernel_stack() a bit
Date:   Mon,  8 May 2023 06:44:58 +0000
Message-Id: <20230508064458.32855-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit f1c1a9ee00e4 ("fork: Move memcg_charge_kernel_stack()
into CONFIG_VMAP_STACK"), memcg_charge_kernel_stack() has been moved
into CONFIG_VMAP_STACK block, so the CONFIG_VMAP_STACK check can be
removed.

Furthermore, memcg_charge_kernel_stack() is only invoked by
alloc_thread_stack_node() instead of dup_task_struct(). If
memcg_kmem_charge_page() fails, the uncharge process is handled in
memcg_charge_kernel_stack() itself instead of free_thread_stack(),
so remove the incorrect comments.

If memcg_charge_kernel_stack() fails to charge pages used by kernel
stack, only charged pages need to be uncharged. It's unnecessary to
uncharge those pages which memory cgroup pointer is NULL.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 kernel/fork.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index ea332319dffe..50762a41aa4e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -250,23 +250,20 @@ static int memcg_charge_kernel_stack(struct vm_struct *vm)
 {
 	int i;
 	int ret;
+	int nr_charged = 0;
 
-	BUILD_BUG_ON(IS_ENABLED(CONFIG_VMAP_STACK) && PAGE_SIZE % 1024 != 0);
+	BUILD_BUG_ON(PAGE_SIZE % 1024 != 0);
 	BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
 
 	for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
 		ret = memcg_kmem_charge_page(vm->pages[i], GFP_KERNEL, 0);
 		if (ret)
 			goto err;
+		nr_charged++;
 	}
 	return 0;
 err:
-	/*
-	 * If memcg_kmem_charge_page() fails, page's memory cgroup pointer is
-	 * NULL, and memcg_kmem_uncharge_page() in free_thread_stack() will
-	 * ignore this page.
-	 */
-	for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+	for (i = 0; i < nr_charged; i++)
 		memcg_kmem_uncharge_page(vm->pages[i], 0);
 	return ret;
 }
-- 
2.25.1

