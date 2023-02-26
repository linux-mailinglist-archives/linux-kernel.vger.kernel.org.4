Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFAE6A2EC0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 08:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBZHWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 02:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZHWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 02:22:48 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200BE11672
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 23:22:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1677396129; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=fHLumIJDTrUlndkZzNV0bct/FAp0nKPPEPWt/81iKdaSWzrrR3eb9rQL6OBp+dFx/KIfY4EZgj6Z9xBT07aO9GZUgg5MsOGNOMElgKANhdnEfw9hX5j3VuF9FwB5NAH8/DmvH7vbiHBhE36urcIX2j5XJUtdq9kQ8p2W7kTVQZE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1677396129; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=HIfNyHsjcILZU5s+jcIJqhvxO/AvcQ7lKLAK/tEncF0=; 
        b=UGNP+WUbxAlO3JVZKbjUoiP9ZvrSWqD2YRHP7F3bEMdDW8CcFbWsefDarW1gGejnG+8OmtvQCCr/IIch5Za6JSeAt2kNCuAnIl86Xx0Byezw2NQ+Mk4BA3CiWu2//pOGWpm3QMlT5HtsIOU6vYbRDC4mn0Bi2/bKfuVbyDlsYBw=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1677396129;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=HIfNyHsjcILZU5s+jcIJqhvxO/AvcQ7lKLAK/tEncF0=;
        b=K+biD2IAotacJymEpYzejrVmkUOtg8wFtAKGTHsl2bB/TKNhsMPzFC4bXaVTyzxF
        RSIst/uUclX0MQ8HjJRHf6YGvPdGSdiEB861+ix5SIqMrUdV0O6LyHzahM/2pmbCoMy
        F5t/Aguvaf4o71NcyvHK1OeAOVpAU+GwQlQpSU5o=
Received: from kampyooter.. (122.170.64.102 [122.170.64.102]) by mx.zoho.in
        with SMTPS id 1677396128247823.6164607619477; Sun, 26 Feb 2023 12:52:08 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Message-ID: <e77429337f6a08027999b3afed6c9687cacf2997.1677395403.git.code@siddh.me>
Subject: [PATCH v7 2/7] drm: Remove usage of deprecated DRM_INFO
Date:   Sun, 26 Feb 2023 12:51:49 +0530
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677395403.git.code@siddh.me>
References: <cover.1677395403.git.code@siddh.me>
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

drm_print.h says DRM_INFO is deprecated in favor of drm_info().

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 drivers/gpu/drm/drm_client_modeset.c | 2 +-
 drivers/gpu/drm/drm_connector.c      | 7 ++++---
 drivers/gpu/drm/drm_drv.c            | 2 +-
 drivers/gpu/drm/drm_pci.c            | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_cli=
ent_modeset.c
index 1b12a3c201a3..ae19734974b5 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -331,7 +331,7 @@ static bool drm_client_target_cloned(struct drm_device =
*dev,
 =09=09DRM_DEBUG_KMS("can clone using 1024x768\n");
 =09=09return true;
 =09}
-=09DRM_INFO("kms: can't enable cloning when we probably wanted to.\n");
+=09drm_info(dev, "kms: can't enable cloning when we probably wanted to.\n"=
);
 =09return false;
 }
=20
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connecto=
r.c
index ca5fb54b7aab..cd1a23fc82e1 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -168,13 +168,14 @@ static void drm_connector_get_cmdline_mode(struct drm=
_connector *connector)
 =09=09return;
=20
 =09if (mode->force) {
-=09=09DRM_INFO("forcing %s connector %s\n", connector->name,
-=09=09=09 drm_get_connector_force_name(mode->force));
+=09=09drm_info(connector->dev, "forcing %s connector %s\n",
+=09=09=09 connector->name, drm_get_connector_force_name(mode->force));
 =09=09connector->force =3D mode->force;
 =09}
=20
 =09if (mode->panel_orientation !=3D DRM_MODE_PANEL_ORIENTATION_UNKNOWN) {
-=09=09DRM_INFO("cmdline forces connector %s panel_orientation to %d\n",
+=09=09drm_info(connector->dev,
+=09=09=09 "cmdline forces connector %s panel_orientation to %d\n",
 =09=09=09 connector->name, mode->panel_orientation);
 =09=09drm_connector_set_panel_orientation(connector,
 =09=09=09=09=09=09    mode->panel_orientation);
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index c6eb8972451a..b08b502285c7 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -941,7 +941,7 @@ int drm_dev_register(struct drm_device *dev, unsigned l=
ong flags)
 =09if (drm_core_check_feature(dev, DRIVER_MODESET))
 =09=09drm_modeset_register_all(dev);
=20
-=09DRM_INFO("Initialized %s %d.%d.%d %s for %s on minor %d\n",
+=09drm_info(dev, "Initialized %s %d.%d.%d %s for %s on minor %d\n",
 =09=09 driver->name, driver->major, driver->minor,
 =09=09 driver->patchlevel, driver->date,
 =09=09 dev->dev ? dev_name(dev->dev) : "virtual device",
diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
index 39d35fc3a43b..7dfb837d1325 100644
--- a/drivers/gpu/drm/drm_pci.c
+++ b/drivers/gpu/drm/drm_pci.c
@@ -262,7 +262,7 @@ void drm_legacy_pci_exit(const struct drm_driver *drive=
r,
 =09=09}
 =09=09mutex_unlock(&legacy_dev_list_lock);
 =09}
-=09DRM_INFO("Module unloaded\n");
+=09drm_info(NULL, "Module unloaded\n");
 }
 EXPORT_SYMBOL(drm_legacy_pci_exit);
=20
--=20
2.39.1


