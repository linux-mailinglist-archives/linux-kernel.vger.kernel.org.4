Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5137865F6C2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbjAEW2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbjAEW1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:27:45 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1CF102F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:27:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1672957510; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=FXTKARM4codHZ8MySX8+/zrZ6y3ij/wDtoOmIMRyIuH/ShdHbAmgNYZIZaQk9L1C5dLajANZ7eRBsHvAr9ZkBrwspkFqJgeMxh0xQhh4hw1OXMrLTYKFbTA/HPb09e+gyBdv5ws4iaXrmByKUg4c2ZXDmBTdLKKOU9UijK9qt14=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1672957510; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=YAXTlBSpddAOoRl/rgdcXT/UmQnPneK4iAsjBbqHVFE=; 
        b=PIHvg2GZtRl1h2z7/z5G02Rc+gu0067TmBqhEZvafsG/NvGNap5ZFcg1Oh957urbWi/lUYXIv8TyvEo+xlqJBlG266c2LU1oqAzkuTr6IQkL5UZqFckc1jxUz6jSbjO69tkX+me4y0g0uV0pw6sTzfDNuMdVppB/6wd/t5oCZK4=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1672957510;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=YAXTlBSpddAOoRl/rgdcXT/UmQnPneK4iAsjBbqHVFE=;
        b=GaQxZuLXCsPd6swS7SQUyvWjbyUX2koO8Lwi5HkFGVjdlNazyYXKmYVK8Cr7k088
        RLB+SIlYbu+SozOtmFvMMP8BSeGHvhR7FiVV1iv8GN0QwtOJud0uqP0sJh7Uz9rgGhH
        veKogXjTuf9swlBNz2jv8B9EVksdC6kYJPJvODvM=
Received: from kampyooter.. (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1672957508838339.1388299764209; Fri, 6 Jan 2023 03:55:08 +0530 (IST)
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
Message-ID: <a4910cd9e48747bb2b23d2857cc6adb41bd096f6.1672957022.git.code@siddh.me>
Subject: [PATCH v4 08/10] drm: Remove usage of deprecated DRM_DEBUG_PRIME
Date:   Fri,  6 Jan 2023 03:54:59 +0530
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1672957022.git.code@siddh.me>
References: <cover.1672957022.git.code@siddh.me>
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


