Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A99656499
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 19:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiLZS2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 13:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLZS2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 13:28:01 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4CC25FA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 10:27:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1672079251; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=PZGJ3qbYzCoKIz1LGSAUIwUdhLm3S1WAoZgfPwOkSHv5VLtQScAHTlTa8k6Fz3Y6cU/r66XytR2oWfqnEweBJIOWhmdqO7dHqi6RCkaxYMsUrm72ecPUEZl2oYppvzwGDAQGVoSAFaIThiFJCCsmX9hEB9dtcllOBjKjyng5t+w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1672079251; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=jOS7lFqPyYp4aF6uyo+Mu87tNYK2Fubh9HQ2gBzQ9pY=; 
        b=EoAROfcAppM6mYE4VUC2LYZ22U2Iqxl2zV/5DZFrPVCeTr2oup68bMIAS3wnMrvxZRwaPYPE/C0s1q91iOLudzuNZ9sdc7UdmpM5djmQMn1QvkElPPc6VqNbfJnOUJx27WawWGkPmNDhzppqF60g5rfjlgpx1RuFVa3KE/ikzRU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1672079251;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=jOS7lFqPyYp4aF6uyo+Mu87tNYK2Fubh9HQ2gBzQ9pY=;
        b=k1yn4OQfG5VTaG+IcB7Sros2Akq+Mu57nPJGfEn+RWsyo++CmY60Sma8y6ltW9rS
        B5rVvwM0qlJFlqmGVfa17oJKOehNPZ5HfU2rhHjEJit7DnYB3lxUCdqWi/4cUHLA55W
        rG4oZPLtufKPgzsmsKp0xivOj3XBLYePA+mTcFMo=
Received: from kampyooter.. (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1672079249369812.7233612638427; Mon, 26 Dec 2022 23:57:29 +0530 (IST)
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
Message-ID: <6487349e2277c93d2f2dab585a86694d082ddcb4.1672078853.git.code@siddh.me>
Subject: [PATCH v3 09/10] drm/drm_blend: Remove usage of deprecated DRM_DEBUG_ATOMIC
Date:   Mon, 26 Dec 2022 23:57:21 +0530
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1672078853.git.code@siddh.me>
References: <cover.1672078853.git.code@siddh.me>
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

drm_print.h says DRM_DEBUG_ATOMIC is deprecated in favor of
drm_dbg_atomic().

Signed-off-by: Siddh Raman Pant <code@siddh.me>
Reviewed-by: Simon Ser <contact@emersion.fr>
---
 drivers/gpu/drm/drm_blend.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index b4c8cab7158c..6e74de833466 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -450,8 +450,8 @@ static int drm_atomic_helper_crtc_normalize_zpos(struct=
 drm_crtc *crtc,
 =09int i, n =3D 0;
 =09int ret =3D 0;
=20
-=09DRM_DEBUG_ATOMIC("[CRTC:%d:%s] calculating normalized zpos values\n",
-=09=09=09 crtc->base.id, crtc->name);
+=09drm_dbg_atomic(dev, "[CRTC:%d:%s] calculating normalized zpos values\n"=
,
+=09=09       crtc->base.id, crtc->name);
=20
 =09states =3D kmalloc_array(total_planes, sizeof(*states), GFP_KERNEL);
 =09if (!states)
@@ -469,9 +469,8 @@ static int drm_atomic_helper_crtc_normalize_zpos(struct=
 drm_crtc *crtc,
 =09=09=09goto done;
 =09=09}
 =09=09states[n++] =3D plane_state;
-=09=09DRM_DEBUG_ATOMIC("[PLANE:%d:%s] processing zpos value %d\n",
-=09=09=09=09 plane->base.id, plane->name,
-=09=09=09=09 plane_state->zpos);
+=09=09drm_dbg_atomic(dev, "[PLANE:%d:%s] processing zpos value %d\n",
+=09=09=09       plane->base.id, plane->name, plane_state->zpos);
 =09}
=20
 =09sort(states, n, sizeof(*states), drm_atomic_state_zpos_cmp, NULL);
@@ -480,8 +479,8 @@ static int drm_atomic_helper_crtc_normalize_zpos(struct=
 drm_crtc *crtc,
 =09=09plane =3D states[i]->plane;
=20
 =09=09states[i]->normalized_zpos =3D i;
-=09=09DRM_DEBUG_ATOMIC("[PLANE:%d:%s] normalized zpos value %d\n",
-=09=09=09=09 plane->base.id, plane->name, i);
+=09=09drm_dbg_atomic(dev, "[PLANE:%d:%s] normalized zpos value %d\n",
+=09=09=09       plane->base.id, plane->name, i);
 =09}
 =09crtc_state->zpos_changed =3D true;
=20
--=20
2.35.1


