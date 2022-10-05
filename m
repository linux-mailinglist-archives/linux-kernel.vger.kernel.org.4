Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34DD5F5959
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiJERsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiJERsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:48:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2997A24D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 10:48:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bj12so37036946ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 10:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUqPpYv5HbJS3RJZgdTtH5zBJM8cF/Q/yQo70/LIPGg=;
        b=q2NAXUerg5Qq4svf9ZBclqSa7jhIsyyWtisVfdHoR09jVE9TUdLqPM4efflTILBJ2E
         1QzruERT96PZYju0r7C2ZaHvg30mr5WuMueOXGd/ZwvoZmmuOUN13WUjo0E1wd+IbDqs
         BHtddK4HNWj9DlWucI/LF6hcSCBL5vdIlYwIr7rf7LHwpwKw1u0JzBn48GS4yFmoiv+C
         BXfd99AdwgNOMIo8PqFDtYXynE8wj8nj18ErlAFmAjYKe4avYXwKc2MTtpfsUUJ0Hr+d
         nyJcbqw+4Yt20d6Zxo8CDJDZfh2dhLrWeY1cgcrGP5JOqbkMqzLlOTlOQlgFouD46h6r
         MMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUqPpYv5HbJS3RJZgdTtH5zBJM8cF/Q/yQo70/LIPGg=;
        b=e8iVVSl+Z6082WT15Hs5ZxRfQzat2STbEA86rZBA9MWYsNjPIR98zxoXlT+b+m9zYs
         bMlP4VKwgfMUTyjR2teJYHUd+fozAxTs0Rk/3de16cTcMGemsOpq2k4yzMZjOhh9/5b/
         tbRsE/UUSChSyPLox6ce02riVngTs+6PgO3HHZF9d9dz/tNwFsyEr+lszZtuLVDD/wIr
         ONlrUKLeaZz6whFs+wV4gJHlJsjSlSl5+m7ccCcT2pTXF/GDRYefW50zBBA3gyysrRiw
         kY9C4dqIG5afT/655rKTnWX5mGS5X+mFt2PZrPch60vuYB5s5NNkh6KCThzbLThmMFo5
         YQ3A==
X-Gm-Message-State: ACrzQf3NwwdrdIhpGhfsxoZrMb50A9gfcbYfdeccdpRJMUHbfgmTJeeM
        GtmKZW4N6bO/JLxpjK4kahQ=
X-Google-Smtp-Source: AMsMyM7qFxTtDClHub9HwGnUCHbj0K2B+uD3aLcbrl4tDcKrhmWQ/TdQGfyyThVB1O4Bfc/Y82Eqaw==
X-Received: by 2002:a17:906:4ac1:b0:780:3448:ff06 with SMTP id u1-20020a1709064ac100b007803448ff06mr587283ejt.403.1664992113581;
        Wed, 05 Oct 2022 10:48:33 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id ee32-20020a056402292000b0044e7862ab3fsm4320697edb.7.2022.10.05.10.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 10:48:32 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 1/2] xen/virtio: Fix n_pages calculation in xen_grant_dma_map(unmap)_page()
Date:   Wed,  5 Oct 2022 20:48:22 +0300
Message-Id: <20221005174823.1800761-2-olekstysh@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005174823.1800761-1-olekstysh@gmail.com>
References: <20221005174823.1800761-1-olekstysh@gmail.com>
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

Take page offset into the account when calculating the number of pages
to be granted.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Fixes: d6aca3504c7d ("xen/grant-dma-ops: Add option to restrict memory access under Xen")
---
 drivers/xen/grant-dma-ops.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index 8973fc1e9ccc..1998d0e8ce82 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -153,7 +153,7 @@ static dma_addr_t xen_grant_dma_map_page(struct device *dev, struct page *page,
 					 unsigned long attrs)
 {
 	struct xen_grant_dma_data *data;
-	unsigned int i, n_pages = PFN_UP(size);
+	unsigned int i, n_pages = PFN_UP(offset + size);
 	grant_ref_t grant;
 	dma_addr_t dma_handle;
 
@@ -185,7 +185,8 @@ static void xen_grant_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 				     unsigned long attrs)
 {
 	struct xen_grant_dma_data *data;
-	unsigned int i, n_pages = PFN_UP(size);
+	unsigned long offset = dma_handle & (PAGE_SIZE - 1);
+	unsigned int i, n_pages = PFN_UP(offset + size);
 	grant_ref_t grant;
 
 	if (WARN_ON(dir == DMA_NONE))
-- 
2.25.1

