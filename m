Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDE165463D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiLVTAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiLVTAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:00:38 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5A723304
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:00:36 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o6so4072968lfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At43IBCLPeuA3Qoij5h6NdcJqc+/xwkW1Zl5H96ba4o=;
        b=Dqr3iTZ0vzi70FOzZCaSh8aJhEc4QWrvczhL1whAhjZsrmsmNR9XDbERrQ+QdsxnCz
         NXXUnCyPLEKwSNi/nPioasZlPFKne+ljvHsef3XRmYULCgnlhYHXSTzOnqEza/jON6FP
         7YvavRGlP0sUCaScGkAG+SDHAJl2mS++2Oq/qQ+zgVykelUeL9x0ATuMuSddjx4f8G2/
         2TSyGTB4r1kPJ8qSevDi1E2qgvQxatN/QWx+q+rgxp/fnX62hrfw1bM7cWq2YWpQ7eOM
         BkRzAmRfSliOkhUzDNtFK7zemygu+nen07SRpSIEQ7x+T+AcJu3df9Fr/pqwlU4DxnPf
         zH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=At43IBCLPeuA3Qoij5h6NdcJqc+/xwkW1Zl5H96ba4o=;
        b=E8uyLYiMY20S7ctSvjWBe4dLt1ZOdu/EnWBrkkI9sBEIJvb+i8O9PJc2xcfAMQTsqz
         U/CKiVf3Ylf8rv6Za9r9aF9oEwnDxVBNQceqaUqFQxPmdhx7LIYgwBoTXE48Kyjk9RY8
         FcDiPjxFPqLcieBILNChHvvJdwoOlFnZDImBDetxzBZJVmcFLuxmKl9AibXe7Oz1d/7y
         aQpHmKyCVQmj63IfZ8zVFKyK+Q0bS99g50PDTUn4hLcSyzSqrNF8LkL8MvkTvx/XP/C0
         R0+S5KLAroF3afaavjYlDvDe9YCApihANC5FA9uApcF194wiyrRGodZuTtDEJNl7qvQQ
         Nngw==
X-Gm-Message-State: AFqh2krgzRWNrY0hlS/IZ3h3Kw4BeHXTIGV8QyvR8fJvWWDK9Lc7fcFX
        R0zQQqktZv3tLA8eabVWdnY=
X-Google-Smtp-Source: AMrXdXvv/k1GbWC8VD6nUe01H19g0QQ6rT7WPMAhGe/HhukHF3+U6/vdOWzIkaKy+1YR/bzzerRjTA==
X-Received: by 2002:a05:6512:3683:b0:4b5:b46d:e52 with SMTP id d3-20020a056512368300b004b5b46d0e52mr1603684lfs.50.1671735634989;
        Thu, 22 Dec 2022 11:00:34 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id c20-20020ac24154000000b0048a8c907fe9sm164209lfi.167.2022.12.22.11.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 11:00:34 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v3 3/3] mm: vmalloc: Replace BUG_ON() by WARN_ON_ONCE()
Date:   Thu, 22 Dec 2022 20:00:22 +0100
Message-Id: <20221222190022.134380-3-urezki@gmail.com>
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

Currently a vm_unmap_ram() functions triggers a BUG() if an area
is not found. Replace it by the WARN_ON_ONCE() error message and
keep machine alive instead of stopping it.

The worst case is a memory leaking.

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 70e5000b9d68..09a9b93b32ca 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2253,7 +2253,9 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 	}
 
 	va = find_unlink_vmap_area(addr);
-	BUG_ON(!va);
+	if (WARN_ON_ONCE(!va))
+		return;
+
 	debug_check_no_locks_freed((void *)va->va_start,
 				    (va->va_end - va->va_start));
 	free_unmap_vmap_area(va);
-- 
2.30.2

