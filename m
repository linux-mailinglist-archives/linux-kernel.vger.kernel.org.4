Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C80654475
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiLVPll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiLVPl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:41:28 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802A517414
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:41:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1671723651; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=afDaLve54pgeuDsZug2F8oCsQta7Wcv/5Y4ujwHaC/v0nQ7WIlQdfijwb02kpBqiqoa+ihvjblsIwNCfnVVPazg5AHw6VNiG37Sv5S5U9nJ+mCRKhxDHREw1SxdMfEyfg+UmvxuBYSkWfbEtiCnfpxIXiIR0KiaRl5Hld1Rsado=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1671723651; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=1MCKPJOG9ImRBJLySDbjsiaY3Ui5PpMZ+NWkNcMBJcc=; 
        b=ea6szritPlwEEyRxR7EFBEshraVatCEARiM/If5Xdw8nNiZUqHoHUYOSuUoELC748cKiZVrWz8MIv52snHgbjFx265trnAma+xL5zwFoxTb9G+pGeNEbyFNY/xslBJkqMgl4Gz4eSzcGH/2adYG7rCeL9CVQZ8s8TStGxeMApkg=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1671723651;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=1MCKPJOG9ImRBJLySDbjsiaY3Ui5PpMZ+NWkNcMBJcc=;
        b=D5M8EEyXnty59BC5u06qtwDD41GRAVI5Gka9YYEHZwyDnBiixX28hBt9EFqwvdfc
        fsO/J151DpIq96ya2IdSUX7+SHv8WhQnQZR79Ka3tRAIZArgugewGwAjEWgs99oN9KN
        8Th7ZcE5DW72H4Qx9EhMIQQNIhOM5t266ZqTj45w=
Received: from kampyooter.. (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1671723650135402.59306702069614; Thu, 22 Dec 2022 21:10:50 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <e7b5b54ebfac4ba53cd95174b81d3f3169a4d630.1671723195.git.code@siddh.me>
Subject: [PATCH v2 7/9] drm: Remove usage of deprecated DRM_DEBUG_PRIME
Date:   Thu, 22 Dec 2022 21:10:41 +0530
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1671723195.git.code@siddh.me>
References: <cover.1671723195.git.code@siddh.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_print.h says DRM_DEBUG_PRIME is deprecated in favor of
drm_dbg_prime().

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 drivers/gpu/drm/drm_gem_dma_helper.c   | 4 ++--
 drivers/gpu/drm/drm_gem_shmem_helper.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem=
_dma_helper.c
index 1ba551b0ab97..0f903cc8914a 100644
--- a/drivers/gpu/drm/drm_gem_dma_helper.c
+++ b/drivers/gpu/drm/drm_gem_dma_helper.c
@@ -477,8 +477,8 @@ drm_gem_dma_prime_import_sg_table(struct drm_device *de=
v,
 =09dma_obj->dma_addr =3D sg_dma_address(sgt->sgl);
 =09dma_obj->sgt =3D sgt;
=20
-=09DRM_DEBUG_PRIME("dma_addr =3D %pad, size =3D %zu\n", &dma_obj->dma_addr=
,
-=09=09=09attach->dmabuf->size);
+=09drm_dbg_prime(dev, "dma_addr =3D %pad, size =3D %zu\n", &dma_obj->dma_a=
ddr,
+=09=09      attach->dmabuf->size);
=20
 =09return &dma_obj->base;
 }
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_g=
em_shmem_helper.c
index f0b6b69f4baf..1b9a6b357d8a 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -764,7 +764,7 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device *=
dev,
=20
 =09shmem->sgt =3D sgt;
=20
-=09DRM_DEBUG_PRIME("size =3D %zu\n", size);
+=09drm_dbg_prime(dev, "size =3D %zu\n", size);
=20
 =09return &shmem->base;
 }
--=20
2.35.1


