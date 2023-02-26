Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2BB6A2EC1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 08:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBZHWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 02:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBZHWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 02:22:49 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C77911E86
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 23:22:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1677396130; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=KxddhieU05Ln4k1acieltQY7v0EoaLjC60fmQKJEmH3vOg2rDE98vLCdFsxajRFzRrgQARJGG0AyAbEjBk1dq6e0FQ6NV9lMYyAxhAgBP2Fc2hgLWiIZrvsQ9rRaRG4Thh4/gnXA0PEkoMAERiTT9TDMtzRhnQYNWrIcTcZMmcs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1677396130; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=8G/F/eygNJ3r9G90eWZBfkKRI/vHqXgYNYardtRrrwk=; 
        b=NIPJMHX52JXzcej7jDIbJ7xo+IByYy/I+VqquURN2YMANf3chidykb3PxuJSNWcZQMAHUiBrPhDl3mS1WhjYUOSUqSGJ6UjE5FCuuUuowBaEXQpWgcC9AQFSssAMsyND416MkcQxsEDgeII4QExaZB9PFe1fUDVgIY/oIwXV5Hc=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1677396130;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=8G/F/eygNJ3r9G90eWZBfkKRI/vHqXgYNYardtRrrwk=;
        b=LCZPCXDv4ycYlMgR8K8wtZdCgx7hbLG1+ug7V9FXnb3im7D5sQRZdo6YXilFh80z
        9zsKwmJLqYhenz21JnA3bm+CjRuHVlvFjqOiLZ4Txhvwa44VWwOpqA9NKEYEiKx6RvC
        fdp4mgiofe6YoFgnYNia0w73NX+poOkA/xshRbHY=
Received: from kampyooter.. (122.170.64.102 [122.170.64.102]) by mx.zoho.in
        with SMTPS id 1677396128649235.6112975918394; Sun, 26 Feb 2023 12:52:08 +0530 (IST)
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
Message-ID: <496db3221937d0955e1771016f24489872737ffb.1677395403.git.code@siddh.me>
Subject: [PATCH v7 3/7] drm: Remove usage of deprecated DRM_NOTE
Date:   Sun, 26 Feb 2023 12:51:50 +0530
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
2.39.1


