Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F2B73B50D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjFWKRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjFWKRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:17:17 -0400
Received: from out-63.mta0.migadu.com (out-63.mta0.migadu.com [91.218.175.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A07F1731
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:17:06 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687514912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QDxJJPScyqXOrcPzZmNjVaQ6zDID/kl69ta88kJSkSo=;
        b=fdEGDRZSUBXyp8Q0+FPOwVKVo8RbP2ONsgpb/9bPKqNG4qUCDcczVrd3QIcG+h1shSSCvW
        EjUphRcTmkrhBjcLwmlpwmeXqEstqvMOultBeKtjhuJmrcuX8v+Wf4nB2lD7ZISCkNA7Kz
        PxbfrCy0VPI0O2W6LPXalHxQY/4m6oM=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v1 2/8] drm/etnaviv: Using the unsigned int type to count the number of pages
Date:   Fri, 23 Jun 2023 18:08:16 +0800
Message-Id: <20230623100822.274706-3-sui.jingfeng@linux.dev>
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

Instead of the 'int' type in the etnaviv_gem_prime_get_sg_table(),
because the drm_prime_pages_to_sg() function takes an unsigned int type
as its third argument.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
index b003481adc2b..6a2129a92cb6 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
@@ -17,7 +17,7 @@ static struct lock_class_key etnaviv_prime_lock_class;
 struct sg_table *etnaviv_gem_prime_get_sg_table(struct drm_gem_object *obj)
 {
 	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
-	int npages = obj->size >> PAGE_SHIFT;
+	unsigned int npages = obj->size >> PAGE_SHIFT;
 
 	if (WARN_ON(!etnaviv_obj->pages))  /* should have already pinned! */
 		return ERR_PTR(-EINVAL);
-- 
2.25.1

