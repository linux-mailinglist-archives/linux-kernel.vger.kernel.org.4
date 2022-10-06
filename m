Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6928C5F65C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiJFMJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiJFMJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:09:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D48C15FE8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:09:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w10so2503383edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oezV6p4Pg66UTbe9c4t+yatYSFzeOtShFiSFXQ54qSo=;
        b=MeQbriyUIPiZobQp0WSRTktwRu3/jvvxRk0i5QonnBoZz/pZhqwGuso5KHD2on7YKW
         Bv2+dvIzSMJ2SSzqOu5+kjQ9HxQwQ7winQxJFoCQkzJM8qs9ANi7b5sOH0t9hBeFLfdH
         pMHVSPkaE+q1TXxG4SuI3OC3E3Dp5gbVjMXUxHv8CBsobEXsQJuC5Io7/APoyyw+rJGW
         +kprM4KhMvt85TFiAoqIXjIECj/zvFOUDNY8VB2LSRLB6azOjUdTsYfRq6QLnFY3Itpt
         FZAFkZYAvb5Uoi1+DnAIfy7thdere2eOKT+ZSFmbuBEF5E9S5lOcTfc1vvMkMTqz2poC
         pP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oezV6p4Pg66UTbe9c4t+yatYSFzeOtShFiSFXQ54qSo=;
        b=hlN9zzz54GMMPeJB4k4p0+B15YJUiMmTiqB8CcFKoROLXCCYC+JuJ7yiRh/ckWfcBJ
         iIBqyEEOY/OKXsuW05vzyjR2VHjFcvxqwe3eGvEUuTtKKIk9xn1ZT7EbEvhTr+GQOvuk
         7IuijRINqwVVdd7Yk+yaFXlGW8F6mH8Hz+rwLN3HmVbGNO8fCYDncnTPAace40PVNNUW
         coFc+8JOoGehCJ0Ark2onnAvpy/krxWsYAIaNCIn4PmNKXVnRfh5qPsWi1jFceBmHVD5
         r1O5bgLqid9GuZh5lm2tRYsEPFmxWvzgPwmlUS63IRADX4gZoNwNTPbfQFC3gyzijrWz
         ZGdA==
X-Gm-Message-State: ACrzQf1c0ktq9ofsi77uxUge78LesUdi/adKq9kPHNCrq1fsQDUfEu+c
        SntUV2CUZOykhzhkVgU+33jo5R8xSvo=
X-Google-Smtp-Source: AMsMyM7aU33Z5R0VlNLsXaNenVyARndTDobGsMO0OEwiDyF02B/9haEMaDcT/T5Xqho8omvVAWaV7g==
X-Received: by 2002:aa7:d614:0:b0:458:f796:f86a with SMTP id c20-20020aa7d614000000b00458f796f86amr4256860edr.294.1665058163906;
        Thu, 06 Oct 2022 05:09:23 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id ky9-20020a170907778900b0073ddff7e432sm10353101ejc.14.2022.10.06.05.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:09:23 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>
Subject: [PATCH] xen/virtio: Convert PAGE_SIZE/PAGE_SHIFT/PFN_UP to Xen counterparts
Date:   Thu,  6 Oct 2022 15:09:12 +0300
Message-Id: <20221006120912.1948459-1-olekstysh@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Although XEN_PAGE_SIZE is equal to PAGE_SIZE (4KB) for now, it would
be more correct to use Xen specific #define-s as XEN_PAGE_SIZE can
be changed at some point in the future.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
Cc: Juergen Gross <jgross@suse.com>
Cc: Xenia Ragiadakou <burzalodowa@gmail.com>

As it was proposed at:
https://lore.kernel.org/xen-devel/20221005174823.1800761-1-olekstysh@gmail.com/

Should go in only after that series.
---
 drivers/xen/grant-dma-ops.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index c66f56d24013..5392fdc25dca 100644
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
@@ -168,7 +168,7 @@ static dma_addr_t xen_grant_dma_map_page(struct device *dev, struct page *page,
 					 unsigned long attrs)
 {
 	struct xen_grant_dma_data *data;
-	unsigned int i, n_pages = PFN_UP(offset + size);
+	unsigned int i, n_pages = XEN_PFN_UP(offset + size);
 	grant_ref_t grant;
 	dma_addr_t dma_handle;
 
@@ -200,8 +200,8 @@ static void xen_grant_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 				     unsigned long attrs)
 {
 	struct xen_grant_dma_data *data;
-	unsigned long offset = dma_handle & (PAGE_SIZE - 1);
-	unsigned int i, n_pages = PFN_UP(offset + size);
+	unsigned long offset = dma_handle & ~XEN_PAGE_MASK;
+	unsigned int i, n_pages = XEN_PFN_UP(offset + size);
 	grant_ref_t grant;
 
 	if (WARN_ON(dir == DMA_NONE))
-- 
2.25.1

