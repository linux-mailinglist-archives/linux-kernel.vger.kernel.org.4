Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3E25F78EE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJGN17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJGN14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:27:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55098804BB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 06:27:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z97so7034069ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 06:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PORH37wl02w5zim2PpJcX5b14ycsNmFAFsoV/wDCQVg=;
        b=U8zIpLC9vkt1BxrKzxjy6Cz9Wfr50dEgERMUW7D3MmIk3M/GAnxJb0zX6CzjP1tWVm
         sh2qvWo/lWg/5UYdKf3IW9vu+3q5HyCpHAJzHMF8Y0so/+inIAUn7rHPiwOY2tNxDGMc
         mPARgY289vvOo0g1re36cTnA5sXHjurm0HQcJlEystO7CBW4Lxfsma8/vmjCJXAEOznS
         2PBgX3kVoYBFo3rSe+mtq97swC9VN3P/7LeLbEWtjI7/PiuDN3mH5G/rknAXEZ4TgNbv
         mn9+Q9n74kZdOKaBq0wbOoY8trlau9Wr0kwO0811xNWR9RCaIbQkALXA88J1xoukgH5O
         yb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PORH37wl02w5zim2PpJcX5b14ycsNmFAFsoV/wDCQVg=;
        b=os6NdBd5FUcw9z2+TKa/7DKDI7vKdFv1hQKhgLY8t2lv1PC5LbyauEMQpqiLHgg57n
         t+d6V8y5fOtpQclr0cBXp3G8uyoAEv+EeSNOpm0qAtVWMoE22qkz2WGAjAU+mnkavwDf
         AuP/URlxuNU0wVwT+bgl8U1bYbOCzT/BN7MY5Q82tm2SHNUw19zsovlm8iDXJA/adMNg
         QR9a7iVHNPt6dy59foQwvwiLMhIDkliR03YN022B6/oxJlxi8deghuQa40AJ7fr/QiqY
         No8KpWYEkg5+w43YqcQf8DJodawgzVlEFGNHoDqYStqksRTWqr8vmmF8lGOV+sjgdEE/
         N9Yw==
X-Gm-Message-State: ACrzQf0npgQO6PoMRaV7WVpljkmbXLO5gEQEU/yRITJfduDjIrrgD9tx
        47WHHVqhOZXoDEHrAMCrkqE=
X-Google-Smtp-Source: AMsMyM6dRcRpow+v9ntj3SdSgn+856xu57eMalm4LP36SOxY1H2aCoZRDpopoA4CB96QCMhTyUgivg==
X-Received: by 2002:a05:6402:2489:b0:454:11de:7698 with SMTP id q9-20020a056402248900b0045411de7698mr4712240eda.214.1665149273742;
        Fri, 07 Oct 2022 06:27:53 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id cn22-20020a0564020cb600b00459012e5145sm1438183edb.70.2022.10.07.06.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 06:27:53 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>
Subject: [PATCH] xen/virtio: Handle cases when page offset > PAGE_SIZE properly
Date:   Fri,  7 Oct 2022 16:27:36 +0300
Message-Id: <20221007132736.2275574-1-olekstysh@gmail.com>
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

Depens on:
https://lore.kernel.org/xen-devel/20221005174823.1800761-1-olekstysh@gmail.com/

Should go in only after that series.
---
 drivers/xen/grant-dma-ops.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index c66f56d24013..1385f0e686fe 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -168,7 +168,9 @@ static dma_addr_t xen_grant_dma_map_page(struct device *dev, struct page *page,
 					 unsigned long attrs)
 {
 	struct xen_grant_dma_data *data;
-	unsigned int i, n_pages = PFN_UP(offset + size);
+	unsigned long dma_offset = offset_in_page(offset),
+			gfn_offset = PFN_DOWN(offset);
+	unsigned int i, n_pages = PFN_UP(dma_offset + size);
 	grant_ref_t grant;
 	dma_addr_t dma_handle;
 
@@ -187,10 +189,10 @@ static dma_addr_t xen_grant_dma_map_page(struct device *dev, struct page *page,
 
 	for (i = 0; i < n_pages; i++) {
 		gnttab_grant_foreign_access_ref(grant + i, data->backend_domid,
-				xen_page_to_gfn(page) + i, dir == DMA_TO_DEVICE);
+				xen_page_to_gfn(page) + i + gfn_offset, dir == DMA_TO_DEVICE);
 	}
 
-	dma_handle = grant_to_dma(grant) + offset;
+	dma_handle = grant_to_dma(grant) + dma_offset;
 
 	return dma_handle;
 }
-- 
2.25.1

