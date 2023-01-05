Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB10565F6B3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbjAEWZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbjAEWZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:25:45 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665CB6D52D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:25:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1672957509; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=RmEZYZTTZ+n9uss18sU3rIltLzJrCKx61PtiH8FE/9rJNFFc4360JEH+lDUbaVplNeq1pUue1ssrlOJzINq7PSnEufzGkoqqH0DSwF8FJkiaQ/dX3QQ/SMmURfhet9W/yE/ubsIQsutRHxpM0NVKwO4N1uyWM9qBo/4X8625QrI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1672957509; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=8m3UiIpaqwhxOnubafQnfgDXsOIquhP+SlU1ixmnv+8=; 
        b=A/unJIuimFwtpf6sClwSI4IwDSe0jVSsEVC9VZECS1g9+yRE1MzOXLTaqeDLO1iZUYrt0M5a8Y70xFz7bEMvgs3JWgfxD7HLn+LyRa3n6Epfw+kOuj4UuayK8X4I7MHJe5+C7kdq3yUpFn4KaLZw0YIF7rHaQJGQsxchlWhOQh8=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1672957509;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=8m3UiIpaqwhxOnubafQnfgDXsOIquhP+SlU1ixmnv+8=;
        b=RDuXqehOf3S1hiI4cakCQa4MevmZ7QWt0nW0pV+xXQcKRHDQjOPPY6OiI6A9T0D2
        3ZiPScseo0PZekpvqsAxzr7I7h7Ukp6g592OZDxraSs8Lcqy9H/llvZSCirgTPIjYnn
        H16XKNb5sWnX2VnKIuGPmpTEwADJQPS9H8h8CJzw=
Received: from kampyooter.. (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1672957507254842.5520703240902; Fri, 6 Jan 2023 03:55:07 +0530 (IST)
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
Message-ID: <4b4e45033e7980669d34467ad9b2c361822c0218.1672957022.git.code@siddh.me>
Subject: [PATCH v4 03/10] drm: Remove usage of deprecated DRM_NOTE
Date:   Fri,  6 Jan 2023 03:54:54 +0530
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

drm_print.h says DRM_NOTE is deprecated in favor of drm_notice().

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 drivers/gpu/drm/drm_displayid.c         | 2 +-
 drivers/gpu/drm/drm_kms_helper_common.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_displayid.c b/drivers/gpu/drm/drm_displayi=
d.c
index 38ea8203df45..67fed6cee9e9 100644
--- a/drivers/gpu/drm/drm_displayid.c
+++ b/drivers/gpu/drm/drm_displayid.c
@@ -26,7 +26,7 @@ static int validate_displayid(const u8 *displayid, int le=
ngth, int idx)
 =09for (i =3D 0; i < dispid_length; i++)
 =09=09csum +=3D displayid[idx + i];
 =09if (csum) {
-=09=09DRM_NOTE("DisplayID checksum invalid, remainder is %d\n", csum);
+=09=09drm_notice(NULL, "DisplayID checksum invalid, remainder is %d\n", cs=
um);
 =09=09return -EINVAL;
 =09}
=20
diff --git a/drivers/gpu/drm/drm_kms_helper_common.c b/drivers/gpu/drm/drm_=
kms_helper_common.c
index 0bf0fc1abf54..7a41373b67dc 100644
--- a/drivers/gpu/drm/drm_kms_helper_common.c
+++ b/drivers/gpu/drm/drm_kms_helper_common.c
@@ -41,7 +41,7 @@ MODULE_LICENSE("GPL and additional rights");
 /* Backward compatibility for drm_kms_helper.edid_firmware */
 static int edid_firmware_set(const char *val, const struct kernel_param *k=
p)
 {
-=09DRM_NOTE("drm_kms_helper.edid_firmware is deprecated, please use drm.ed=
id_firmware instead.\n");
+=09drm_notice(NULL, "drm_kms_helper.edid_firmware is deprecated, please us=
e drm.edid_firmware instead.\n");
=20
 =09return __drm_set_edid_firmware_path(val);
 }
--=20
2.39.0


