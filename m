Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F074165463F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiLVTAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiLVTAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:00:38 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEED4248EE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:00:35 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bp15so4028822lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+DOrKc/WLcF8tZORAcZxALx+GbVZfz9pT9WtlPUuC4=;
        b=bcrd/4/xejvVpq2+B3spoa/sbs9+HPre0M1zqgfRI4dfY5E5LLvs2Qh8ug58GxtUlS
         maVwcN/m+756UH2rwsGldqcaBBY4cgnAT1gpT5r67UCTO8byxZzI1h7F/Z4hd4dD3OMI
         pwjn8QOFoRBrS4dZPFZk1GAW7LFmW+QMvJqP19G0NtyH5b6iXpL67h0+kV8VaNk2h9DJ
         cmBkv3h+DmAARSsdpskD45XXO1BfEN/S2Pc4Ypcd8ACZ7ZgK+xOC8vgd2bX7/NUMoEH7
         eL3xq2h11ZhNpZ2t1u/eQch2Q5E6nCkWHMmqAyYutaSnLMFckQpTER9Z80Z3zQ5VEVF1
         ky/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+DOrKc/WLcF8tZORAcZxALx+GbVZfz9pT9WtlPUuC4=;
        b=bGvukt+0yfOe1WOfMlMbdR6T3+c8t6GercNHKgz2bcjadgoWgvt12nfp23EzdLahWV
         RPgp6p7j1U8RQ9Dse+jVv+9aEAVykVUIOkTN1eLRHAnCLOciyYHbyrezFGvkfk2b/Ir0
         SpiOy+HBnBRUfuxVViS+/9GAhQnwNuVA+e2hqulF8ZyAobzeknrsZlxksccO5zbt4Zei
         5s2Hd1ZUje2vZ4Exp89c0kInVCcL0p8rsOyo9d3/xrYkdvL+3SRDgxZGilx16oFQd79H
         +NczrIdljVRCI3GbHa7S+Vbb2mWMVlYyFWpNGfABIL1F/ke4W2ljvsMemHSJ/pmCgodj
         E2Zg==
X-Gm-Message-State: AFqh2koP/8kGwbpkZtTVGL0CcNCsZ93het2Ro6ZCqS3YtuamtyaIVNIt
        jFBmrxgTWGuKJogkp+Zo2tI=
X-Google-Smtp-Source: AMrXdXul5bZK1z5ZO6+wV5M1B4ckWgEp7djYnY12RmpTYVoVITC2Do/+E8FCHd6bs5YsCMrtD5VgnQ==
X-Received: by 2002:a05:6512:b9f:b0:4b5:9914:87f6 with SMTP id b31-20020a0565120b9f00b004b5991487f6mr2162013lfv.66.1671735634218;
        Thu, 22 Dec 2022 11:00:34 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id c20-20020ac24154000000b0048a8c907fe9sm164209lfi.167.2022.12.22.11.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 11:00:33 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 2/3] mm: vmalloc: Switch to find_unlink_vmap_area() in vm_unmap_ram()
Date:   Thu, 22 Dec 2022 20:00:21 +0100
Message-Id: <20221222190022.134380-2-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221222190022.134380-1-urezki@gmail.com>
References: <20221222190022.134380-1-urezki@gmail.com>
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

Switch from find_vmap_area() to find_unlink_vmap_area() to prevent
a double access to the vmap_area_lock: one for finding area, second
time is for unlinking from a tree.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index eb91ecaa7277..70e5000b9d68 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2252,7 +2252,7 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 		return;
 	}
 
-	va = find_vmap_area(addr);
+	va = find_unlink_vmap_area(addr);
 	BUG_ON(!va);
 	debug_check_no_locks_freed((void *)va->va_start,
 				    (va->va_end - va->va_start));
-- 
2.30.2

