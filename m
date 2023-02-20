Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBF569D6F9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 00:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjBTXZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 18:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBTXZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 18:25:34 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2E36A52
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 15:25:33 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676935531;
        bh=5x9HeqcPHCwhATJF4tQJt9RgTjIXEhGqy4OdoKFWpTA=;
        h=From:Date:Subject:To:Cc:From;
        b=tudpp20jT0vytgZFBYSEALP/SjaH3wcRzKZx1z0FIT+bxvPj0rqhz1/HonUC8J/A3
         YyBnAuOTxIp+4RD6HnZYVNrcgKP4TISEIBaoqba5YpB20hKo7WMqqb09z07hAsJvVk
         oMv9X8cm7ea9Q/yAIx+DLWNPf97X8NnmZdPzmQZs=
Date:   Mon, 20 Feb 2023 23:25:28 +0000
Subject: [PATCH] mm: slub: make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230220-kobj_type-mm-slub-v1-1-5ae49b96d9aa@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAGcB9GMC/x2N0QrCMAwAf2Xk2UDNVIa/IjLaNbpo143GycbYv
 xt8vIPjNlAuwgrXaoPCX1EZs8HxUEHX+/xklGgM5Kh2RA7fY3i1n3ViHAbUNAd0FOnc1JfIzQm
 sC14ZQ/G5663Mc0omp8IPWf6j233ff8VJ+nh4AAAA
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676935528; l=921;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=5x9HeqcPHCwhATJF4tQJt9RgTjIXEhGqy4OdoKFWpTA=;
 b=RHGaqUGnOzyorJZF1SDFU499idlP2/FBP4dLzRX0j2eF+vh1q4H90n248lF26VQvyEpikrbAv
 XIe9ATRCeAnBAKeOYdZ+Vw/9RzsMr6RPEnC2YyY5OZuCtyQ7V2j3PSk
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definition to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 13459c69095a..be710dc4dc3e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6058,7 +6058,7 @@ static const struct sysfs_ops slab_sysfs_ops = {
 	.store = slab_attr_store,
 };
 
-static struct kobj_type slab_ktype = {
+static const struct kobj_type slab_ktype = {
 	.sysfs_ops = &slab_sysfs_ops,
 	.release = kmem_cache_release,
 };

---
base-commit: 5b0ed5964928b0aaf0d644c17c886c7f5ea4bb3f
change-id: 20230220-kobj_type-mm-slub-02d25836de84

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

