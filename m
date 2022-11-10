Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FF562484F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiKJRYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiKJRYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:24:32 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5AC1658C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=YqIoRq3Z6BinSF+viJeXIC76+f26dp/HQr/mPgW3vTw=; b=LK
        CqEWu3FRBbkDn2746+8mSjzoEBQ197JuGr3ZYKf/zPj4JnAEf05qHggOGhwXGyEZOGS6wyY0Io6Xj
        5oqJ4/MENCCMU6JTcJBf+PGxl+CO9nqv98YHkANkcEeWMnhEFSnrekXjnN1wyWiNYddI1ETGxC4o0
        hRVOBBaQXGisXEPJI/Zmy2cOwm8TzhkPz3AqN1RhbPRrT5VNyvlHY7TvkukPf2/8C43nvSWP2vXWC
        3gWITrczDK7AfvQREU0zwgDEir32zOzTZ6jcRPmdEZyF4nWgK0ZYlFm2HnJyiLnqkOFfJuHq1dSyC
        vWohxZABHm6LfYXAzxUkfdRwrifzaFsg==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1otBHn-0000C1-NK;
        Thu, 10 Nov 2022 17:24:20 +0000
From:   John Keeping <john@metanate.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc:     John Keeping <john@metanate.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: avoid duplicate mappings for IOMMU devices
Date:   Thu, 10 Nov 2022 17:24:14 +0000
Message-Id: <20221110172415.2853420-1-john@metanate.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a buffer is allocated with alloc_kmap, then it is vmap'd on creation
and there is no reason to map it again in rockchip_gem_prime_vmap() when
the existing mapping can be used.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 6edb7c52cb3d..c9507d27f0ba 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -519,8 +519,14 @@ int rockchip_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
 
 	if (rk_obj->pages) {
-		void *vaddr = vmap(rk_obj->pages, rk_obj->num_pages, VM_MAP,
-				  pgprot_writecombine(PAGE_KERNEL));
+		void *vaddr;
+
+		if (rk_obj->kvaddr)
+			vaddr = rk_obj->kvaddr;
+		else
+			vaddr = vmap(rk_obj->pages, rk_obj->num_pages, VM_MAP,
+				     pgprot_writecombine(PAGE_KERNEL));
+
 		if (!vaddr)
 			return -ENOMEM;
 		iosys_map_set_vaddr(map, vaddr);
@@ -540,7 +546,8 @@ void rockchip_gem_prime_vunmap(struct drm_gem_object *obj,
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
 
 	if (rk_obj->pages) {
-		vunmap(map->vaddr);
+		if (map->vaddr != rk_obj->kvaddr)
+			vunmap(map->vaddr);
 		return;
 	}
 
-- 
2.38.1

