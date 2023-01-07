Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761BD66107A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 18:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjAGRYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 12:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjAGRXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 12:23:49 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593694C72F
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 09:23:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673112190; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=R1mrQ4F3Ue9uLmF3hdVCIJGqIdNH8yLqxX66hcHQOzS2jo9KAJtR8rJ8KxqdRm6/0y7B5tsyfpR4ijFC2DeQMxOE3rGVTVz1GDwwlOaeunm1/d8c4gMB2WH3LnNNahHtwlF/fbLRrvelnbcsWPUBOsMsJMKpdb1gn9zjid7m7Wo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1673112190; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=YAXTlBSpddAOoRl/rgdcXT/UmQnPneK4iAsjBbqHVFE=; 
        b=OnnVbJ5KJ+wIunl2sbKSWbrAGYCwROtMWP8kEGPrAfSzt0x4O/l7vNeAbVSXSVkM9q0HF0hEc7MqswXyOiYbAzXw85bN9NAW6Js44KjYQmqH66+rXJpTGKJVZXs0xxPXhvn9LG3OnKbKKhA6EUD/tf3Jlei1LGOXS2kYO/PkXr4=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1673112190;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=YAXTlBSpddAOoRl/rgdcXT/UmQnPneK4iAsjBbqHVFE=;
        b=eFmF/hSfTGZhghmBExiaqdRIEOVPdMaYRmH5DEnHpjbwgxoRmq1fHZDTkX3Rmh8z
        Le8UbLTSaxcoiSm5dkOynm7sMe4BIGaywSWNeu37zagqc0TeSZnUSRwmZ++WdEmCL/n
        5uA2gxbJVJDXx0gwEw3Hyr/as9polEdQ7QuVD/BM=
Received: from kampyooter.. (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1673112189539240.16651329667513; Sat, 7 Jan 2023 22:53:09 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Jim Cromie <jim.cromie@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <775e3800eed1f62df950063dc623037ca3840828.1673110890.git.code@siddh.me>
Subject: [PATCH v5 08/10] drm: Remove usage of deprecated DRM_DEBUG_PRIME
Date:   Sat,  7 Jan 2023 22:52:28 +0530
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673110890.git.code@siddh.me>
References: <cover.1673110890.git.code@siddh.me>
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
Reviewed-by: Simon Ser <contact@emersion.fr>
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
index e99426b5be93..c8780b72e4e8 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -760,7 +760,7 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device *=
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
2.39.0


