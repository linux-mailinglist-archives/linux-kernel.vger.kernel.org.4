Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05C16B6CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 00:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCLXml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 19:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCLXmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 19:42:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3141A2BF30
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:42:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o5-20020a05600c510500b003ec0e4ec6deso3673824wms.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678664553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=la0p/jvvcd1pW9pC/kzK82qIi7c6KvzFPifjBlwZbrc=;
        b=aLZj8JfH0eQ7HFdZx/+iprS/tlBFopYdB1aCKQXTt5WK8FgM8bcDbsa+wSY1iKQJxE
         Sq7nlwxxzv+OkfrXORItUJ0aliFlsx2GYC4bVIbkqOdoz3XJ/8X+6UsBq/gt7H0EZtMt
         nuAc/KhC3rf0zvdcWc/OLcAHwR9ZY+peyrzGWB24fyZW1aAv3sBtA5JYpdpHACiwUM4C
         Zn2OTxsvJxQeZs50umFz+7v+OiiQaf/ZCNb2VEVVGtNQsaBRYYbpPPVuAQjUJokXjnKZ
         skXJHxntFAccCGCVcChxVjMizrL+8AfSuhDiDuW1ANf8qzQ5/J6eKWecB6/XPCdmkVUt
         dJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678664553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=la0p/jvvcd1pW9pC/kzK82qIi7c6KvzFPifjBlwZbrc=;
        b=BYo+FO6rM+8RvJXTOVz8dXHjxHfCubk9NYqDajgoV3oSaZhLOO+D0vLRKCKPcNx05u
         tApmaw+tyZgPxG39FxfeWWhQuwrdPFTXzGHrHMFrgeuod8kDrqYe/0DbiLyPUzalcksM
         b7naSqv6FJx/8gA/wCy3jJoPCii7lfvJCcXccYsPkuGlUxstFbY6BP3u0YSrUmpVbUYD
         eI28T50CL7510GHnjq2f14oecgZdL1S8tqoHkEFLxgZsjbASc9g+6+nnmkoQioH8uQl8
         J2dYhdo3nLyIlpFJ+0dechO2Bz0HGOjzOeu3r4V470q8sI2IsrTWfIj2unJIiCVpGAQq
         q/rg==
X-Gm-Message-State: AO0yUKVT5abZlZHDZf+XXTA1AMsXbBVIu1P7eFYvr1pCGKhoI9URQ4fW
        JapahBvOXI6346QotEQcdtw=
X-Google-Smtp-Source: AK7set91yp0phYi1oU83T07w5p/4LtduuFcFeFbpdusqdMZ60+SpKowFcXg2lljxmC60wI0iAyj0hw==
X-Received: by 2002:a05:600c:4e87:b0:3eb:38a2:2bcd with SMTP id f7-20020a05600c4e8700b003eb38a22bcdmr9079693wmq.28.1678664553621;
        Sun, 12 Mar 2023 16:42:33 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id iz20-20020a05600c555400b003ed201ddef2sm3698376wmb.2.2023.03.12.16.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 16:42:32 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Christian Konig <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 3/3] drm/ttm: Remove comment referencing now-removed vmf_insert_mixed_prot()
Date:   Sun, 12 Mar 2023 23:40:15 +0000
Message-Id: <db403b3622b94a87bd93528cc1d6b44ae88adcdd.1678661628.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678661628.git.lstoakes@gmail.com>
References: <cover.1678661628.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function no longer exists, however the prot != vma->vm_page_prot case
discussion has been retained and moved to vmf_insert_pfn_prot() so refer to
this instead.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index ca7744b852f5..5df3edadb808 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -254,7 +254,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 		 * encryption bits. This is because the exact location of the
 		 * data may not be known at mmap() time and may also change
 		 * at arbitrary times while the data is mmap'ed.
-		 * See vmf_insert_mixed_prot() for a discussion.
+		 * See vmf_insert_pfn_prot() for a discussion.
 		 */
 		ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
 
-- 
2.39.2

