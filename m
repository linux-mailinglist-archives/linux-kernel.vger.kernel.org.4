Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7AF693C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 03:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjBMCJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 21:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBMCJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 21:09:45 -0500
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBA6AD2F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 18:09:43 -0800 (PST)
Received: by mail-pl1-f172.google.com with SMTP id e17so3190667plg.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 18:09:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RRSa5splVjb43STyERCx9WqlUztd7VM3FAvVjySaRc=;
        b=GBMlsSI82S91cACvvgMaiRmvr/LOWrENMiRIdzygVDx+f0jUrtLcDnZWUfzVI3fTr5
         RE9PEQ7YVrczwBaCeHh5LyEDAg/OIiGXElvxjYk8McWThWJs7QtaCvRQTbAdrm/GuDbO
         Ca92rC7916nX8JjgLbrdfBklk0tT31Cht9WUfqPrpVrUeTey/NlTAhuEaK03ypUMt7y5
         /cgQeR6e+9PPbzFQNKPnOvrNMIx+ce0lIqm1aasTBrYUUVN19LiTKwpksDufuf3DntWD
         BwCM4vfDkuiSO58WpnhmKSi6UbRk2sDP+l6BjSI1hwkbf2TT/AOLZQGm+/cFeWR+++bx
         Ln9A==
X-Gm-Message-State: AO0yUKXnku6rHvB1lU9DqJSoQ3pR8NfHXs5qxT01Zd6+x29PxnDCNQ3k
        kMmo6Xln45gt0sJPQMZQtomxO2mVMAs=
X-Google-Smtp-Source: AK7set+N46JXyTbzaQcE1o/BgoH3fzisDhed3Y72Ho7vSXidZxoKEErNkg7OETaUViBewObm0ZDU4g==
X-Received: by 2002:a17:903:485:b0:19a:839f:435 with SMTP id jj5-20020a170903048500b0019a839f0435mr5201711plb.3.1676254183354;
        Sun, 12 Feb 2023 18:09:43 -0800 (PST)
Received: from localhost.localdomain (144.34.241.68.16clouds.com. [144.34.241.68])
        by smtp.gmail.com with ESMTPSA id ja15-20020a170902efcf00b0019607547f29sm6896140plb.304.2023.02.12.18.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 18:09:42 -0800 (PST)
From:   Ke Sun <sunke@kylinos.cn>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ke Sun <sunke@kylinos.cn>
Subject: [PATCH RFC] mm: pagemap: add vma(VM_PFNMAP) support in pagemap_pte_hole()
Date:   Mon, 13 Feb 2023 10:08:07 +0800
Message-Id: <20230213020807.1985422-1-sunke@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pagemap currently does not support vma(FIXMAP), add support
in pagemap_pte_hole().

Signed-off-by: Ke Sun <sunke@kylinos.cn>
---
 fs/proc/task_mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index af1c49ae11b1..297c7b9dc630 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1400,6 +1400,11 @@ static int pagemap_pte_hole(unsigned long start, unsigned long end,
 		if (vma->vm_flags & VM_SOFTDIRTY)
 			pme = make_pme(0, PM_SOFT_DIRTY);
 		for (; addr < min(end, vma->vm_end); addr += PAGE_SIZE) {
+			if ((vma->vm_flags & VM_PFNMAP) && vma->vm_pgoff) {
+				unsigned long pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
+
+				pme = make_pme(vma->vm_pgoff + pgoff, PM_PRESENT);
+			}
 			err = add_to_pagemap(addr, &pme, pm);
 			if (err)
 				goto out;
-- 
2.25.1

