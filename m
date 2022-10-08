Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA345F85BC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 17:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiJHPKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 11:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJHPKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 11:10:35 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519DE2AE1D
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 08:10:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id o21so16788606ejm.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20FlK2f2Ao6in3DL/pE8fjcn0IFPQLl6lYsp91zsW/g=;
        b=ROTHMsmP/hzHS74G5W9dubaxDxyjkONMkP12fjLSs7nXD77oMmyr0l2NmnTjHv1Hwy
         zks7PaJdMSnEWoAwqOi4UUoC/kVKHQBEn96iD61c9+n+1FyW4sj89a410hBePPTvINK8
         UuWofOk3ZZLRM2tvGpQmPVrNfKp7G6/wRNk4HT9KH4xo0vtnzi+/rXdpzu+0xabMtWhO
         hEx800aqTYrse+VY0x4iY7CgkcjXyxeaVDfNM2f184zWPNkzqCHSrll/+0v7GeQThF7D
         SXMJJswpnKdExgww62wuwncf+ygGRYHuTAZ3Ac37jBQBsTaDaL7waMhuE2VrE+7Fah4G
         P/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20FlK2f2Ao6in3DL/pE8fjcn0IFPQLl6lYsp91zsW/g=;
        b=TaPcMxGQlYMirVMxAcsvgclZ2BHiTYOWIV3nDbtl4IX9+VjvviA1j+47RVw72XMQxG
         1x5Z9819xYlIdpJ0glLT2ixuRV2NWC7Ah5fgnYyGg9tNQIy5AzpM2i1HebaYQVAI75yg
         sDnG5f9zFqEDWkzcf4yJ0XxAlpd4JpewyGuDHWaeMm9ampaM72ZfeHNuHxxXKDQiaLbi
         LlnmY6ufQOdykCUA4I02pxiUIy20NBLKSUxBOjISuPvnDDX+P4p3YQoY5s3pUnP24sZE
         oW+5lm+J0ZOYKNXv+kVGYhDIW1dpcJrtq8b4szQ/nraQ5oT3wAUss1FJKIRJ5b/9du6h
         04DA==
X-Gm-Message-State: ACrzQf3ctm3wtv5WLtGOCvNib8qqg/nhNcKpDKFtZW3FjwNTg0EL8GAL
        MpnlK14ef6IEaXzU8p2FSpM=
X-Google-Smtp-Source: AMsMyM5XtGDmusETEHuN4wJntwNBpo8Mn3TJU8DM8u6nC3r7GTulKyyiTrXMGTKfS0fnjt2h4eGUBQ==
X-Received: by 2002:a17:906:974f:b0:780:4a3c:d179 with SMTP id o15-20020a170906974f00b007804a3cd179mr8378820ejy.289.1665241832708;
        Sat, 08 Oct 2022 08:10:32 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id l25-20020a50d6d9000000b0045723aa48ccsm3523119edj.93.2022.10.08.08.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 08:10:32 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>
Subject: [PATCH V2 1/2] xen/virtio: Handle cases when page offset > PAGE_SIZE properly
Date:   Sat,  8 Oct 2022 18:10:12 +0300
Message-Id: <20221008151013.2537826-2-olekstysh@gmail.com>
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

Passed to xen_grant_dma_map_page() offset in the page
can be > PAGE_SIZE even if the guest uses the same page granularity
as Xen (4KB).

Before current patch, if such case happened we ended up providing
grants for the whole region in xen_grant_dma_map_page() which
was really unnecessary. The more, we ended up not releasing all
grants which represented that region in xen_grant_dma_unmap_page().

Current patch updates the code to be able to deal with such cases.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
Cc: Juergen Gross <jgross@suse.com>
Cc: Xenia Ragiadakou <burzalodowa@gmail.com>

Changes V1 -> V2:
   - s/gfn_offset/pfn_offset
   - clarify gfn calculation when granting a page

Previous discussion is at:
https://lore.kernel.org/lkml/20221007132736.2275574-1-olekstysh@gmail.com/
---
 drivers/xen/grant-dma-ops.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index c66f56d24013..1d018e3a68a0 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -168,7 +168,9 @@ static dma_addr_t xen_grant_dma_map_page(struct device *dev, struct page *page,
 					 unsigned long attrs)
 {
 	struct xen_grant_dma_data *data;
-	unsigned int i, n_pages = PFN_UP(offset + size);
+	unsigned long dma_offset = offset_in_page(offset),
+			pfn_offset = PFN_DOWN(offset);
+	unsigned int i, n_pages = PFN_UP(dma_offset + size);
 	grant_ref_t grant;
 	dma_addr_t dma_handle;
 
@@ -187,10 +189,11 @@ static dma_addr_t xen_grant_dma_map_page(struct device *dev, struct page *page,
 
 	for (i = 0; i < n_pages; i++) {
 		gnttab_grant_foreign_access_ref(grant + i, data->backend_domid,
-				xen_page_to_gfn(page) + i, dir == DMA_TO_DEVICE);
+				pfn_to_gfn(page_to_xen_pfn(page) + i + pfn_offset),
+				dir == DMA_TO_DEVICE);
 	}
 
-	dma_handle = grant_to_dma(grant) + offset;
+	dma_handle = grant_to_dma(grant) + dma_offset;
 
 	return dma_handle;
 }
-- 
2.25.1

