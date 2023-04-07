Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC716DB66D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 00:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjDGWXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 18:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDGWXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 18:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA82D503
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 15:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680906118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tKz0tg31KcO0axIciN8Gt+6+AOxGyPzji0GIe3mVV4M=;
        b=JypNFVrFFL3q5PilfpO4qiasiiQofQHRJuPbdW/dLps0roHpdTSvxvy1TDPRFT7HlFIeBV
        dieHn+uB0Hn6a98I9XgAy1G3jUZhY384lcQsG9nnT8Uoemxdq9Fy9tjkqXLw6wD63NPLnE
        YV9EJUPvQI8gonJBywMJ3QHlAR1tcnE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-fHMxFWKpO1Cyo62X0mtBmg-1; Fri, 07 Apr 2023 18:21:56 -0400
X-MC-Unique: fHMxFWKpO1Cyo62X0mtBmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4201A8996E1;
        Fri,  7 Apr 2023 22:21:56 +0000 (UTC)
Received: from emerald.redhat.com (unknown [10.22.8.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3BF951FF;
        Fri,  7 Apr 2023 22:21:55 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/nouveau/nvkm/outp: Use WARN_ON() in conditionals in nvkm_outp_init_route()
Date:   Fri,  7 Apr 2023 18:21:31 -0400
Message-Id: <20230407222133.1425969-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c
index 6094805fbd63..06b19883a06b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c
@@ -229,10 +229,8 @@ nvkm_outp_init_route(struct nvkm_outp *outp)
 		return;
 
 	ior = nvkm_ior_find(disp, type, -1);
-	if (!ior) {
-		WARN_ON(1);
+	if (WARN_ON(!ior))
 		return;
-	}
 
 	/* Determine the specific OR, if any, this device is attached to. */
 	if (ior->func->route.get) {
@@ -248,10 +246,8 @@ nvkm_outp_init_route(struct nvkm_outp *outp)
 	}
 
 	ior = nvkm_ior_find(disp, type, id);
-	if (!ior) {
-		WARN_ON(1);
+	if (WARN_ON(!ior))
 		return;
-	}
 
 	/* Determine if the OR is already configured for this device. */
 	ior->func->state(ior, &ior->arm);
-- 
2.39.2

