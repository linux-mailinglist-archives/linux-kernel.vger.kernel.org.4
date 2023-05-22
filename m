Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2689070CAC7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjEVUTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjEVUTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DFACA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684786726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=O9q1qCwNu3Mrx87IGOjeTMvMrxO9D4Con5QINyscbnk=;
        b=NytQNg2AhGQpVQhC4tRMvsSFNEcXBNK1ivdO8lN0WGyrHz7iAsHj+KavNX7NH2wIDzRA7P
        soBrSuKrrOfg1p7iYB9FgMMd8H/vbEwxp2gDHUoUgW2O2Mmnb2XkDaIylWFyS6KjtuXpwz
        NekiTW/h2pATHcOh1RYGMqw9x9Tz51c=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-5zQPdtQLN0a73JRJlmBv8w-1; Mon, 22 May 2023 16:18:44 -0400
X-MC-Unique: 5zQPdtQLN0a73JRJlmBv8w-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-625891d5ad5so1590516d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786723; x=1687378723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9q1qCwNu3Mrx87IGOjeTMvMrxO9D4Con5QINyscbnk=;
        b=Q4aVDkglyuVey2c0MjeIRzFShWdSg/yv665ZnwuFBt4FNebhnjqfTTcRC7p1h+FqjG
         lS+Kfd3ak6Mspi1MkrldH5kwObkIW8qMXGPutwos2fTvcoempjhyF+hswRXOR6saLBLy
         +ChxNJzoDupQHEjcpkMLxn+5FxHEkUMc1GhSy59AChmgpXdqfoDv1pBsPkusLs3Ixvgf
         ULDXtHtMcasV7asAjuOhgmS8barJShQmBqNvRzw1gaT+FuBAnIektfqeen4/oXLip/Il
         uho0PRgCQBLZRw6QnQbMZKTweFAZWe/anyNP1B7wIQAl8vVp7fppMhfOb5oFaisTuCDv
         FQHg==
X-Gm-Message-State: AC+VfDxWsAHaHH/tWe3sNOMT28Hm2pP3BRr2uQpk+dG0dPOeagX31PHE
        B/pS3BIU7HYKcoGnkbF9B753PREpyYz41qZaR+DMpeCsXm+iVm4tN0BovmfAnlv8d3x4Af2gM1F
        jstAUE+MlErMBwo6/VAtQFHV5QjSFRAQX08L9GcVORC4mOKbjZJXKlbKpGFiNhqQuvZPxxcuSRQ
        fSBWqW03c=
X-Received: by 2002:a05:6214:400f:b0:625:86ed:8ab4 with SMTP id kd15-20020a056214400f00b0062586ed8ab4mr4376391qvb.3.1684786723664;
        Mon, 22 May 2023 13:18:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7fUAFOMh8GoM7ZLqKEyQV3CmmIqRVsI4seXXB/Q3bmVY+dOhM/G3gUw77RysfQOiQm3Y6Waw==
X-Received: by 2002:a05:6214:400f:b0:625:86ed:8ab4 with SMTP id kd15-20020a056214400f00b0062586ed8ab4mr4376368qvb.3.1684786723299;
        Mon, 22 May 2023 13:18:43 -0700 (PDT)
Received: from kherbst.pingu (ip1f1032e8.dynamic.kabel-deutschland.de. [31.16.50.232])
        by smtp.gmail.com with ESMTPSA id i10-20020a0cfcca000000b006255bcfca88sm1688836qvq.7.2023.05.22.13.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:18:42 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gourav Samaiya <gsamaiya@nvidia.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS),
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS)
Subject: [PATCH] drm/nouveau/acr: Abort loading ACR if no firmware was found
Date:   Mon, 22 May 2023 22:18:38 +0200
Message-Id: <20230522201838.1496622-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a NULL pointer access inside nvkm_acr_oneinit in case necessary
firmware files couldn't be loaded.

Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/212
Fixes: 4b569ded09fd ("drm/nouveau/acr/ga102: initial support")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
index 795f3a649b12..6388234c352c 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
@@ -224,7 +224,7 @@ nvkm_acr_oneinit(struct nvkm_subdev *subdev)
 	u64 falcons;
 	int ret, i;
 
-	if (list_empty(&acr->hsfw)) {
+	if (list_empty(&acr->hsfw) || !acr->func->wpr_layout) {
 		nvkm_debug(subdev, "No HSFW(s)\n");
 		nvkm_acr_cleanup(acr);
 		return 0;
-- 
2.40.1

