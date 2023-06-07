Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6C1725276
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 05:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbjFGDl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 23:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240836AbjFGDlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 23:41:19 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A291BEA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 20:41:03 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 6k2eqmOt4fPUb6k2fqJcsz; Wed, 07 Jun 2023 05:41:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686109261;
        bh=h9asTVHJogZoJLCuyX7iMMLYoCBwbTiEljds8BOdE0M=;
        h=From:To:Cc:Subject:Date;
        b=L4HgFnnUT2C38A8o+3dCuS2XjRBRnucHjyAxSi72ReFUDc4mlNJsa3QdfVY1T0Ufe
         vmJmNnAPATOlQoXqE6yCV5dAgvqjOdgEuHui+k3JaHsgYPfuhnSdK9I5EZGNSc8ej4
         Y24Zp8PuhniOY36V9bnko9qUa4XgfXjHTEjqHQHDqEV/+4Lf0TRpO4RVJsdyzPabcV
         wKJ63Ga0w9JVXA0JNgdpbpWVJ7vM7KC6w/E68UNmLvOf3xCOkabtOdbaUL7lRCcYnr
         JNojSQt+FKMrR9ZCqrpMEUoRsYxyWqyaRjgSyra0sxGuteu4bs059RnCJvZZYyejYw
         XKof7OpgU6lng==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 07 Jun 2023 05:41:01 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] firmware: stratix10-svc: Fix a potential resource leak in svc_create_memory_pool()
Date:   Wed,  7 Jun 2023 05:40:59 +0200
Message-Id: <c3eadd5621e39aea6ac2f6504ac84d3abdc54637.1686109244.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

svc_create_memory_pool() is only called from stratix10_svc_drv_probe().
Most of resources in the probe are managed, but not this memremap() call.

There is also no memunmap() call in the file.

So switch to devm_memremap() to avoid a resource leak.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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
2.34.1

