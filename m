Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF315F85BD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 17:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJHPKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 11:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiJHPKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 11:10:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34AF2C12B
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 08:10:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qw20so16224128ejc.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJfFnZUElo4fDCQOc+GUeP/mNGH0ahT8QNQddIgzFpg=;
        b=g8aEsBuSKZ+1up29Gc0SivPAU0QfBvEDsDLSm/BA/WXxN1bgp6/ngqfrbqm2DWVHLw
         XY8BXGqopp6EWzVAt9v4zmoAu6Jbpj0rLDLEU7d1IjG38hYiQitRNR61MMREM0lqONMW
         WNOejInVh1VNU8xCdlu2gGUxtnyeyDK/he9Y7VJw4AK7iugU2I1s3KutVEVcLuoghSY2
         NQAW8eDDrLuM9/t3Aiccabh+YNbgX+hG6puCWDK/Shdi8LAkwVk2JbYaZOTgHfs+ZJfh
         gOjpzeOjYWGMgF5upe3h1GLGqIuLRi8laVdgMnKu5jjdzeB4pIQZ6Qi90e0vj9Sza4WE
         +h4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJfFnZUElo4fDCQOc+GUeP/mNGH0ahT8QNQddIgzFpg=;
        b=yYdg8Sg/dne2dYwYa9cvLitfN6F0B0Hs+lVH2PwYCPOjvGMlcXxnU0c8wG4FSgzTrZ
         4tNgOO2lpnePRl5ValalzsTIym2atw4BeZNI1adjL2q8uGgGEmvvqpqAURZ8fzVH7ABp
         1jZnFP9LJneLDpymZUuvowOxsnU5nGjZUe77ao5ff8ZSrrwTGsahm6j34F3WiD2lmZ/K
         ckcfXHdWJ2yEIqFHPP2nayIOsf0uOmaYM0ZxsT7w7Sk8c1Hl/zOMZRk8gBq8MUm9TL5k
         HJv3yv4v2f83i5X/pEUHwJhz2Gd+gIBs1YxcRTSv2NylKac/1ChGwCLyGDWXp+gxoib1
         FexQ==
X-Gm-Message-State: ACrzQf0TbnCFSTsTZXZgwHjaOqGlVjzVlNiqESHShtErZPMYhwrUFa1K
        itb0BLoz0hJzpMcDfHuq+oUoK/K6wpw=
X-Google-Smtp-Source: AMsMyM4cQnfbv1dRZ3p5BrDqTgfEyct+5Knto6fqk5S+UPZWC9Wybbx5bOvo/nRGWvYlCvM7hU59hA==
X-Received: by 2002:a17:907:802:b0:781:8017:b2df with SMTP id wv2-20020a170907080200b007818017b2dfmr8109754ejb.606.1665241834228;
        Sat, 08 Oct 2022 08:10:34 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id l25-20020a50d6d9000000b0045723aa48ccsm3523119edj.93.2022.10.08.08.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 08:10:33 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>
Subject: [PATCH V2 2/2] xen/virtio: Convert PAGE_SIZE/PAGE_SHIFT/PFN_UP to Xen counterparts
Date:   Sat,  8 Oct 2022 18:10:13 +0300
Message-Id: <20221008151013.2537826-3-olekstysh@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221008151013.2537826-1-olekstysh@gmail.com>
References: <20221008151013.2537826-1-olekstysh@gmail.com>
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

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Currently, a grant ref is always based on the Xen page granularity
(4KB), and guest commonly uses the same page granularity.
But the guest may use a different page granularity (i.e 64KB).
So adopt the code to be able to deal with it.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
Cc: Juergen Gross <jgross@suse.com>
Cc: Xenia Ragiadakou <burzalodowa@gmail.com>

Changes V1 -> V2:
   - update commit description
   - rebase
   - use xen_offset_in_page() in xen_grant_dma_map(unmap)_page()

Previous discussion is at:
https://lore.kernel.org/xen-devel/20221006120912.1948459-1-olekstysh@gmail.com/
---
 drivers/xen/grant-dma-ops.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index 1d018e3a68a0..aff0f95ed954 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -31,12 +31,12 @@ static DEFINE_XARRAY_FLAGS(xen_grant_dma_devices, XA_FLAGS_LOCK_IRQ);
 
 static inline dma_addr_t grant_to_dma(grant_ref_t grant)
 {
-	return XEN_GRANT_DMA_ADDR_OFF | ((dma_addr_t)grant << PAGE_SHIFT);
+	return XEN_GRANT_DMA_ADDR_OFF | ((dma_addr_t)grant << XEN_PAGE_SHIFT);
 }
 
 static inline grant_ref_t dma_to_grant(dma_addr_t dma)
 {
-	return (grant_ref_t)((dma & ~XEN_GRANT_DMA_ADDR_OFF) >> PAGE_SHIFT);
+	return (grant_ref_t)((dma & ~XEN_GRANT_DMA_ADDR_OFF) >> XEN_PAGE_SHIFT);
 }
 
 static struct xen_grant_dma_data *find_xen_grant_dma_data(struct device *dev)
@@ -79,7 +79,7 @@ static void *xen_grant_dma_alloc(struct device *dev, size_t size,
 				 unsigned long attrs)
 {
 	struct xen_grant_dma_data *data;
-	unsigned int i, n_pages = PFN_UP(size);
+	unsigned int i, n_pages = XEN_PFN_UP(size);
 	unsigned long pfn;
 	grant_ref_t grant;
 	void *ret;
@@ -91,14 +91,14 @@ static void *xen_grant_dma_alloc(struct device *dev, size_t size,
 	if (unlikely(data->broken))
 		return NULL;
 
-	ret = alloc_pages_exact(n_pages * PAGE_SIZE, gfp);
+	ret = alloc_pages_exact(n_pages * XEN_PAGE_SIZE, gfp);
 	if (!ret)
 		return NULL;
 
 	pfn = virt_to_pfn(ret);
 
 	if (gnttab_alloc_grant_reference_seq(n_pages, &grant)) {
-		free_pages_exact(ret, n_pages * PAGE_SIZE);
+		free_pages_exact(ret, n_pages * XEN_PAGE_SIZE);
 		return NULL;
 	}
 
@@ -116,7 +116,7 @@ static void xen_grant_dma_free(struct device *dev, size_t size, void *vaddr,
 			       dma_addr_t dma_handle, unsigned long attrs)
 {
 	struct xen_grant_dma_data *data;
-	unsigned int i, n_pages = PFN_UP(size);
+	unsigned int i, n_pages = XEN_PFN_UP(size);
 	grant_ref_t grant;
 
 	data = find_xen_grant_dma_data(dev);
@@ -138,7 +138,7 @@ static void xen_grant_dma_free(struct device *dev, size_t size, void *vaddr,
 
 	gnttab_free_grant_reference_seq(grant, n_pages);
 
-	free_pages_exact(vaddr, n_pages * PAGE_SIZE);
+	free_pages_exact(vaddr, n_pages * XEN_PAGE_SIZE);
 }
 
 static struct page *xen_grant_dma_alloc_pages(struct device *dev, size_t size,
@@ -168,9 +168,9 @@ static dma_addr_t xen_grant_dma_map_page(struct device *dev, struct page *page,
 					 unsigned long attrs)
 {
 	struct xen_grant_dma_data *data;
-	unsigned long dma_offset = offset_in_page(offset),
-			pfn_offset = PFN_DOWN(offset);
-	unsigned int i, n_pages = PFN_UP(dma_offset + size);
+	unsigned long dma_offset = xen_offset_in_page(offset),
+			pfn_offset = XEN_PFN_DOWN(offset);
+	unsigned int i, n_pages = XEN_PFN_UP(dma_offset + size);
 	grant_ref_t grant;
 	dma_addr_t dma_handle;
 
@@ -203,8 +203,8 @@ static void xen_grant_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 				     unsigned long attrs)
 {
 	struct xen_grant_dma_data *data;
-	unsigned long offset = dma_handle & (PAGE_SIZE - 1);
-	unsigned int i, n_pages = PFN_UP(offset + size);
+	unsigned long dma_offset = xen_offset_in_page(dma_handle);
+	unsigned int i, n_pages = XEN_PFN_UP(dma_offset + size);
 	grant_ref_t grant;
 
 	if (WARN_ON(dir == DMA_NONE))
-- 
2.25.1

