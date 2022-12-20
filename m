Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCFE6527B6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiLTURr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbiLTURh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:17:37 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD09F13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 12:17:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1671567425; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=gDT/4VsGFgcMz5GtfZ79XATt7qNhzahiJYFRSXkQSFPfG/MN9tqDCS5niyzlaN5hVqQf89tbXOC9CPFVaO8pLRhhsmsND8WZLhDREPskt9ZjwXQ012qgk2BWEZxmDi6xR6Ncq7wpvw5R9MLJjgiJcv5lwCkc2yOyU0uikX8+LXk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1671567425; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=0uLPZQvo/xpyH3LitCS/tSZQBnXvJjFnagwHKMQiGhA=; 
        b=MSzhpgci5C6ruNZ+ahFD2CFe/eMiyoDJmX37WX6Em6jFgy3XQUxm86W8Gnan6xIYcAHWJlBmkDgqt7eHUGv3xRuhFiBW9HkzqrLfqs49e4nGrqhkwFIIatlRCoMHT10H4x5jQcXrKJt5JFL/v84l777wFb1+PLlZ6HhuVsuczus=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1671567425;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=0uLPZQvo/xpyH3LitCS/tSZQBnXvJjFnagwHKMQiGhA=;
        b=X1Sd9KjKptN1ARCSRpZ9pea6cLAAI/uNNMI2O/s2vgO58MLu1F3nbh/b2qloxtJC
        xT8fdwfU3l4q+Dp/vkI1a7AJHWK9tUlm+lWzv7iEsVqIwoX8SVCVvSOHy2k7p1jjDzt
        tsDFnGaslkb7Y4cZJGofOgRMRvMSyHXoaZ7C31dM=
Received: from kampyooter.. (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1671567425118860.6646368112663; Wed, 21 Dec 2022 01:47:05 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <adf001582998535f212cf93e0fa35ed34358301a.1671566741.git.code@siddh.me>
Subject: [PATCH 09/10] drm/drm_blend: Remove usage of deprecated DRM_DEBUG_ATOMIC
Date:   Wed, 21 Dec 2022 01:46:44 +0530
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1671566741.git.code@siddh.me>
References: <cover.1671566741.git.code@siddh.me>
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


