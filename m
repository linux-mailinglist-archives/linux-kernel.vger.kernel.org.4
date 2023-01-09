Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A83C66266D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbjAINDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbjAINCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:02:46 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BF313CC7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:01:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673269260; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=C+FUwis8U2oJPZaT5QaY+nRMhWCFD6/oU7K3+H+KPSubSBHzqjXH3PsV8iHjrd9Qgby/5CRmBl9cFAIzGmBvq+FHIVtnTZ+pjPhQQB3cYRUn4woPeZeAPbkEnmKgFYA4PQiHaCcAlomWS4PJuh3iqUIr5xGA5fpL/7BrSwXG7x8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1673269260; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=znP/XfpvkYLIXBf5VD9++AwSP6x7VnbopQc4VSKslDI=; 
        b=HQvmTATaxtrNDvxGDq1sozmwz6KCFn+QrXw9JwgkEm0qPZwgQVyc4a6+hH6YI3j47Z1c9nRiKVjzpVp22kqFIKdzS89uScBYTLWAcmr5khLF24SZPvXUHOZRSSvauWoWRSIqwKlurqTq8xsO8T8mogy5Wi/mjRoMFHKirXrx6ic=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1673269260;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=znP/XfpvkYLIXBf5VD9++AwSP6x7VnbopQc4VSKslDI=;
        b=kv21sfDbef2wzMIEr5lJSkIOUEzZq2xynFg9HnjTJzsxwgt72QSelwayFzKpZWQ0
        dx0FY7icZ7dMhHkQmqrqaKvz6KAX3yfengh4ZNej6fKD4q7hRbvPozhW99VLUO5glda
        ehj38oyNFoP/xqwLGZ/3WWhIEnVc2lopEZpaeW7g=
Received: from kampyooter.. (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1673269251542861.2258046967122; Mon, 9 Jan 2023 18:30:51 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <88c8bb5c8a93ad3121f389c90b5362ccc42f4e90.1673269059.git.code@siddh.me>
Subject: [PATCH v6 06/10] drm: Remove usage of deprecated DRM_DEBUG_DRIVER
Date:   Mon,  9 Jan 2023 18:30:31 +0530
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673269059.git.code@siddh.me>
References: <cover.1673269059.git.code@siddh.me>
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

drm_print.h says DRM_DEBUG_DRIVER is deprecated.
Thus, use newer drm_dbg_driver().

Also fix the deprecation comment in drm_print.h which
mentions drm_dbg() instead of drm_dbg_driver().

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 drivers/gpu/drm/drm_mipi_dbi.c | 10 +++++-----
 include/drm/drm_print.h        |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.=
c
index 58ff9503a403..ab5dd5933a1a 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -70,11 +70,11 @@
 #define MIPI_DBI_DEBUG_COMMAND(cmd, data, len) \
 ({ \
 =09if (!len) \
-=09=09DRM_DEBUG_DRIVER("cmd=3D%02x\n", cmd); \
+=09=09drm_dbg_driver(NULL, "cmd=3D%02x\n", cmd); \
 =09else if (len <=3D 32) \
-=09=09DRM_DEBUG_DRIVER("cmd=3D%02x, par=3D%*ph\n", cmd, (int)len, data);\
+=09=09drm_dbg_driver(NULL, "cmd=3D%02x, par=3D%*ph\n", cmd, (int)len, data=
);\
 =09else \
-=09=09DRM_DEBUG_DRIVER("cmd=3D%02x, len=3D%zu\n", cmd, len); \
+=09=09drm_dbg_driver(NULL, "cmd=3D%02x, len=3D%zu\n", cmd, len); \
 })
=20
 static const u8 mipi_dbi_dcs_read_commands[] =3D {
@@ -708,7 +708,7 @@ bool mipi_dbi_display_is_on(struct mipi_dbi *dbi)
 =09    DCS_POWER_MODE_DISPLAY_NORMAL_MODE | DCS_POWER_MODE_SLEEP_MODE))
 =09=09return false;
=20
-=09DRM_DEBUG_DRIVER("Display is ON\n");
+=09drm_dbg_driver(NULL, "Display is ON\n");
=20
 =09return true;
 }
@@ -1256,7 +1256,7 @@ int mipi_dbi_spi_init(struct spi_device *spi, struct =
mipi_dbi *dbi,
=20
 =09mutex_init(&dbi->cmdlock);
=20
-=09DRM_DEBUG_DRIVER("SPI speed: %uMHz\n", spi->max_speed_hz / 1000000);
+=09drm_dbg_driver(NULL, "SPI speed: %uMHz\n", spi->max_speed_hz / 1000000)=
;
=20
 =09return 0;
 }
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 481bf129cc39..abc7b96144ed 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -624,7 +624,7 @@ void __drm_err(const char *format, ...);
 #define DRM_DEBUG(fmt, ...)=09=09=09=09=09=09\
 =09__drm_dbg(DRM_UT_CORE, fmt, ##__VA_ARGS__)
=20
-/* NOTE: this is deprecated in favor of drm_dbg(NULL, ...). */
+/* NOTE: this is deprecated in favor of drm_dbg_driver(NULL, ...). */
 #define DRM_DEBUG_DRIVER(fmt, ...)=09=09=09=09=09\
 =09__drm_dbg(DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
=20
--=20
2.39.0


