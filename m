Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EFC662673
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbjAINFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbjAINED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:04:03 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E7163C1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:03:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673269252; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=RAMCAHNMFblTzKqAmhy/pHgi6XvvjWo/JrabVPW8YSyCARCCXtwvTtG3eUKoh/lZO48bK0twcHEb+jnjB95ycZ+f4/j1pX4j4SxSIWsp4/JK0fzbxvuFrb5zXyQ9kfHuWEE1j8l4OK4crUWXCDrelYLXgi+hxqAnKwDul4A3OkQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1673269252; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=8m3UiIpaqwhxOnubafQnfgDXsOIquhP+SlU1ixmnv+8=; 
        b=Q7M320MAGUPkRSl1TWufRYwwgSsByzDJNj8EX+rnE4ESEJ9dfDc25SbO/rLbVdXOMDoK3NP/F26qCabkglCfezZpxaxdSA4JIsqwxyS312GIaBjDLuQ0XuPgVbm2W32smaM2Ve+ZMwiyoCaKu+Daw4wp4kM1NkiQVHwmYtyScEk=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1673269252;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=8m3UiIpaqwhxOnubafQnfgDXsOIquhP+SlU1ixmnv+8=;
        b=hx669WiNq76c9dJKD5GdOZihhcpzibI8C/49xFebBLGHgK1I5dhT1eG4U6wkp8Yz
        ed4UycMp/vovozvUIYQZ9StYr2lxLML5BJmtYPA069HFL+f0V4FMpU4w00B93rlu4At
        Po9o7klcpAfW857xJQ1iHwY+ewnLZAu9l2Aot1dA=
Received: from kampyooter.. (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1673269250525886.7014855307966; Mon, 9 Jan 2023 18:30:50 +0530 (IST)
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
Message-ID: <ca0aedccde988e111522c5062780687b240ef66f.1673269059.git.code@siddh.me>
Subject: [PATCH v6 03/10] drm: Remove usage of deprecated DRM_NOTE
Date:   Mon,  9 Jan 2023 18:30:28 +0530
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


