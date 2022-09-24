Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934555E888E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 07:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiIXFcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 01:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIXFcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 01:32:50 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4579EDD3C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 22:32:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id c7so2003347pgt.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 22:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=hp/42N2i6PuccgU715Y/Xc7PBBOuVEDoQVUXTCti5SA=;
        b=WR/3s7wdutz9L7NKJT2aeukFstJukvxtQ9f96CptWWr7r2uEI089yTpxOkUz8+TF7y
         voSJhNK3vT0jn/klGafu/wq+uzZE0K9eTiU0Ibl01fqhTbbY31hEST3/onDIK6r7zybf
         rmM3qegOkzGQfBuWY/IjC/tYVIUVw/fpny0JQt4Mbrk01YyIHTTJIYra/ltDlb8llXUy
         794PLDNAR7hPweGEsHE9n1OQ/qnYTzxRX+bFTDfevZ0MEhXhBRbLAcfuJRXwKRQqCKZR
         VP5AMpPONm2GQjedD2WXomp0hrlysemvAp9yZWJE0UzcHFkVx8gEm5UYgjYKLUKc/FeA
         fUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=hp/42N2i6PuccgU715Y/Xc7PBBOuVEDoQVUXTCti5SA=;
        b=ov0UX+e8GeKVOErmaqWUPMx1R93cpH4UBApBh1w3pjO1V1A0ZjZ1Edxt/G26WjrJxc
         /X8IhcYzSpQAwpctAUuTUTYuuJQ8fYUqKZ81g7TWYgs3PWa322D5c1NndZd0tudgk2l+
         +ImQFrV4pfOB8kOMrZ/ZZVoLz7+AMTB6chtqivEyCrANJDRNkbagLTGhVQOjD0w8v1Ye
         aYPnialfp24RjxhC9H3JmXhYQkwVviMFHG4VKUPGS/2pmMmdgIS+QQrmZMpuUCD5ufDT
         jRdMCfK8JfCwHIMmu2D3dQf+OJh/Yp/Yz0ztxrRrseha0WZ10Gw4leIWWQfxVp/SpxlT
         1SJQ==
X-Gm-Message-State: ACrzQf0LxIFlGRUazffBYJFVCj8CcxHnrjOrPwayP6Js4NOscm4IsAMF
        mo433IybqJ+qCmV89U06FsLfLg==
X-Google-Smtp-Source: AMsMyM6LGPHxG2C+f4vPGJkM1QFrFfn359mompHONvT3eNnhaVU7H7f+IIaVHDNIzZYZ4ivtInm36Q==
X-Received: by 2002:a62:1bc8:0:b0:546:c62e:e84 with SMTP id b191-20020a621bc8000000b00546c62e0e84mr12486864pfb.45.1663997569341;
        Fri, 23 Sep 2022 22:32:49 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902cec500b0017286f83fadsm7023852plg.135.2022.09.23.22.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 22:32:48 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        muchun.song@linux.dev, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] mm: fix misuse of update_mmu_cache() in do_anonymous_page()
Date:   Sat, 24 Sep 2022 13:32:39 +0800
Message-Id: <20220924053239.91661-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As message in commit 7df676974359 ("mm/memory.c: Update local TLB
if PTE entry exists") said, we should update local TLB only on the
second thread. So fix the misuse of update_mmu_cache() by using
update_mmu_tlb() in the do_anonymous_page().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 118e5f023597..9e11c783ba0e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4122,7 +4122,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
 	if (!pte_none(*vmf->pte)) {
-		update_mmu_cache(vma, vmf->address, vmf->pte);
+		update_mmu_tlb(vma, vmf->address, vmf->pte);
 		goto release;
 	}
 
-- 
2.20.1

