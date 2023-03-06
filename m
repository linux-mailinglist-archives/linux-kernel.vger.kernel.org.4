Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85756AB4BC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 03:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCFCut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 21:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCFCur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 21:50:47 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764A6F97C
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 18:50:45 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id x34so8416697pjj.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 18:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1678071045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EVGjMrclCEaMIMZKUYlnh2axdze/uTIR/Mv0pCsUOmU=;
        b=DZX7UT6aDv2BtYbLOycfYuulqo/XjuiHjzkPqawXrF7CBrhYSSHwBkP8oP0itHuZw2
         pE8d47n571CFwzX3S5XQFKDPMN5WsSjV34ezRN9uyhq2JD7Rahx69rFI151jcxOLXchm
         1Rn91tCQASUfxtMAOS9m1sKLkak64Pc0qI/7hAaN5b8QjCDHgz9GroQboQ5LsB2nyp2n
         0PfBYq7uJytXjWjkHq6fbZ4JaVU6PVAQ7y5adi1XAzUiwm2ws/nPSZJ7si5040d/pbCk
         ziCTixd+4nTd3oKlB89e+0czAORVMdJQxUC82tTP4BIB8rkZs9NArYw1pI9Czi5P1KM7
         gErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678071045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVGjMrclCEaMIMZKUYlnh2axdze/uTIR/Mv0pCsUOmU=;
        b=JGRNRGPxRMVk1wnaZJF/XggCFZZ1H0CAfV0kI7pXVWXQynjQQKF9fvKk4+Sw15XaXD
         2Z5ppnEb76ds7EbLlXPFBWiAfXNNX2fkOr1VBX4oITtDM32QuSECl9tFz4i5s88YH1LV
         JioSV3O42K41sE0WRKSGtSZ2dtpR8oTBLptZlDv2jWccJb7CSnmaeJRpKYVSxJ2ngaJD
         vDs1IhWifIoHrmzoP51oIFmG+kdgbTpa6TCxsF6tZMdqy/ibH5CG9HtTrZP+EpgsV5DB
         y+E5511OKbgUJ/PWZ3u+WOCKSKNDDVEX7j1rHyMxPKAnIMMk4xqFq80AN1kJjsVO5Uj7
         ZQCg==
X-Gm-Message-State: AO0yUKUbZlt24lmjqwk6lAJEujvx/F8NFY9tGuWZx2V6k3mVpnpTqGzn
        nvERVd4BZLUuTDEjt2BB8q4kGmHjTx7QcPtdivo=
X-Google-Smtp-Source: AK7set9e7d7qkcNATE0CxLdkmohjf1AnrDBZzru+g85JjNK6/SRy6qsFF3ePYSHoqpPPBOiOEiuicQ==
X-Received: by 2002:a17:903:1209:b0:19d:1bd6:4b80 with SMTP id l9-20020a170903120900b0019d1bd64b80mr9987196plh.42.1678071044951;
        Sun, 05 Mar 2023 18:50:44 -0800 (PST)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902e80300b0019a6e8ceb49sm5348879plg.259.2023.03.05.18.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 18:50:44 -0800 (PST)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] mm: remove redundant check in handle_mm_fault
Date:   Mon,  6 Mar 2023 02:49:59 +0000
Message-Id: <20230306024959.131468-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mem_cgroup_oom_synchronize() has checked whether current memcg_in_oom is
set or not, so remove the check in handle_mm_fault().

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index f456f3b5049c..e066d974c27b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5206,7 +5206,7 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 		 * VM_FAULT_OOM), there is no need to kill anything.
 		 * Just clean up the OOM state peacefully.
 		 */
-		if (task_in_memcg_oom(current) && !(ret & VM_FAULT_OOM))
+		if (!(ret & VM_FAULT_OOM))
 			mem_cgroup_oom_synchronize(false);
 	}
 
-- 
2.25.1

