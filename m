Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4734F72EDBD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbjFMVPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjFMVPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:15:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5523C173C;
        Tue, 13 Jun 2023 14:15:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38F67632AF;
        Tue, 13 Jun 2023 21:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AD2C433C8;
        Tue, 13 Jun 2023 21:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686690932;
        bh=3ccj01nPeLrzbHPbFudIi7YMYYr+8Kcyp8XJeZS7dMo=;
        h=From:To:Cc:Subject:Date:From;
        b=Fs1rcb5v3x4UGcv+5Ro0Hf50UaEkn/fi4Yb+Wqzo5q+hD5+F4By14+01cowoga7rp
         IXhgrjfDsE1pxAqIzwinpNZW3c7vFNMtvOZQw+SZjVFYvww2fCS1l29QQtYOkKXp+K
         uHNMWjDuYbKz88Z4Z3oNU2GVgnD3JLhZjsPe7U8eB5rnK3QU+4XLq0vSHR7nG9T5S5
         06Aq7CLFarLhj5R2scjsfNCG8A3YOUXhx47gj4nOuoVEbEYo1SaygLx0zbgpi184xg
         nYONQak7YNCLm/j8dMDHtc33kSQAhgc65CmuDETjIGtBjVlFguX628IAAewTRDiDij
         3bHg1pJxsN0iQ==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        stable@vger.kernel.org
Subject: [PATCH] firmware: stratix10-svc: Fix a potential resource leak in svc_create_memory_pool()
Date:   Tue, 13 Jun 2023 16:15:21 -0500
Message-Id: <20230613211521.16366-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

svc_create_memory_pool() is only called from stratix10_svc_drv_probe().
Most of resources in the probe are managed, but not this memremap() call.

There is also no memunmap() call in the file.

So switch to devm_memremap() to avoid a resource leak.

Cc: stable@vger.kernel.org
Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
Link: https://lore.kernel.org/all/783e9dfbba34e28505c9efa8bba41f97fd0fa1dc.1686109400.git.christophe.jaillet@wanadoo.fr/
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/firmware/stratix10-svc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 80f4e2d14e04..2d674126160f 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -755,7 +755,7 @@ svc_create_memory_pool(struct platform_device *pdev,
 	end = rounddown(sh_memory->addr + sh_memory->size, PAGE_SIZE);
 	paddr = begin;
 	size = end - begin;
-	va = memremap(paddr, size, MEMREMAP_WC);
+	va = devm_memremap(dev, paddr, size, MEMREMAP_WC);
 	if (!va) {
 		dev_err(dev, "fail to remap shared memory\n");
 		return ERR_PTR(-EINVAL);
-- 
2.25.1

