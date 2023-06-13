Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEFE72ED9D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbjFMVGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjFMVGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0C11BC6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686690349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q8vXi7FRx1nxarI+Y7DTeE0H1U4V8kGwZTSHdSqOeZA=;
        b=c87WA9RdRXiO8CUsG+EHs6mP/fYFOJpbIu5zCdMLOKH27EkLtyQB6J4CSnR1dCnTdWqlDw
        qcIZ86yn2ym8km1dz/q+oIXV8bTO3HQkRdP1Nq/2Y+CPa2+z84+/mevB7IkzM7anxUBT/x
        ZTYWexquWN+ZBX6vYb58J+A98C3sWTU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-VC_dhVwxOtqGJSkZWfg4nQ-1; Tue, 13 Jun 2023 17:05:46 -0400
X-MC-Unique: VC_dhVwxOtqGJSkZWfg4nQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33E9180120A;
        Tue, 13 Jun 2023 21:05:38 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.8.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93D6F40C6F5C;
        Tue, 13 Jun 2023 21:05:37 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau-devel@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/nouveau/kms/nv50-: Fix drm_dp_remove_payload() invocation
Date:   Tue, 13 Jun 2023 17:05:28 -0400
Message-Id: <20230613210529.552098-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We changed the semantics for this in:

e761cc20946a ("drm/display/dp_mst: Handle old/new payload states in drm_dp_remove_payload()")

But I totally forgot to update this properly in nouveau. So, let's do that.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 5bb777ff13130..1637e08b548c2 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -909,15 +909,19 @@ nv50_msto_prepare(struct drm_atomic_state *state,
 	struct nouveau_drm *drm = nouveau_drm(msto->encoder.dev);
 	struct nv50_mstc *mstc = msto->mstc;
 	struct nv50_mstm *mstm = mstc->mstm;
-	struct drm_dp_mst_atomic_payload *payload;
+	struct drm_dp_mst_topology_state *old_mst_state;
+	struct drm_dp_mst_atomic_payload *payload, *old_payload;
 
 	NV_ATOMIC(drm, "%s: msto prepare\n", msto->encoder.name);
 
+	old_mst_state = drm_atomic_get_old_mst_topology_state(state, mgr);
+
 	payload = drm_atomic_get_mst_payload_state(mst_state, mstc->port);
+	old_payload = drm_atomic_get_mst_payload_state(old_mst_state, mstc->port);
 
 	// TODO: Figure out if we want to do a better job of handling VCPI allocation failures here?
 	if (msto->disabled) {
-		drm_dp_remove_payload(mgr, mst_state, payload, payload);
+		drm_dp_remove_payload(mgr, mst_state, old_payload, payload);
 
 		nvif_outp_dp_mst_vcpi(&mstm->outp->outp, msto->head->base.index, 0, 0, 0, 0);
 	} else {
-- 
2.40.1

