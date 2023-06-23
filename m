Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E8073B509
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjFWKR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjFWKRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:17:17 -0400
Received: from out-32.mta0.migadu.com (out-32.mta0.migadu.com [91.218.175.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3699D172D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:17:05 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687514910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qr4AdEHTYoG685b8wdwNQJqh58lsMzRbl2ELqoqnYBI=;
        b=S70026q2IZpnkxGa9L2vVHlHbIqeZLtj7NDD/D9SQI7G7Tlyz5UxodTgl/a/1XqOL3vBdE
        9pVN1uud4BRdZSfLq54XxFbC0yNm0/EzpuD5nJLxGT02xA9NVBCuJLpQzib+Nqn3qMuouD
        yRlg0UhlRSB//HARQF/0Ta571pGYlL4=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v1 1/8] drm/etnaviv: Using the size_t variable to store the number of pages
Date:   Fri, 23 Jun 2023 18:08:15 +0800
Message-Id: <20230623100822.274706-2-sui.jingfeng@linux.dev>
In-Reply-To: <20230623100822.274706-1-sui.jingfeng@linux.dev>
References: <20230623100822.274706-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

Because the etnaviv_gem_new_private() function receives the size_t argument
for the number of pages. And the number of pages should be unsigned.

Note that Most 32-bit architectures use "unsigned int" size_t,
and all 64-bit architectures use "unsigned long" size_t.
So, let's keep the argument and parameter consistent.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
index 3524b5811682..b003481adc2b 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
@@ -114,7 +114,8 @@ struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
 {
 	struct etnaviv_gem_object *etnaviv_obj;
 	size_t size = PAGE_ALIGN(attach->dmabuf->size);
-	int ret, npages;
+	size_t npages = size / PAGE_SIZE;
+	int ret;
 
 	ret = etnaviv_gem_new_private(dev, size, ETNA_BO_WC,
 				      &etnaviv_gem_prime_ops, &etnaviv_obj);
@@ -123,8 +124,6 @@ struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
 
 	lockdep_set_class(&etnaviv_obj->lock, &etnaviv_prime_lock_class);
 
-	npages = size / PAGE_SIZE;
-
 	etnaviv_obj->sgt = sgt;
 	etnaviv_obj->pages = kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
 	if (!etnaviv_obj->pages) {
-- 
2.25.1

