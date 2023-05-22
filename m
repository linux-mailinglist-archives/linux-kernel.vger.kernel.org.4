Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4A470C2B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbjEVPuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjEVPui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:50:38 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8F5BB;
        Mon, 22 May 2023 08:50:36 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-76c791e2d8dso247681039f.3;
        Mon, 22 May 2023 08:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684770636; x=1687362636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G5EoxSWTbZ7f4uUwHdfO8oRaR8Zf3HbYw6LZWLrtj7o=;
        b=aYjyZeDKbWw1WoAP+tDEvTQT1TD+BXo/51E9aS5/pArAaKrVLxr48PvyaP7jTiJJaz
         TAf5CKdO7dGCBePScjP2d0Kg0STVGh5vWX48aPZypMqefD7HAC8LDMTIilIUm2ICWmG+
         rRueQ3vvpi8+69m39hTKR6yoTA2d+fJfGqkE3Qy+XeSP6I3zXXhFNkg5CkF/VlDCjsfa
         fHPDeO/GxOtlZz0eVqg0AuKqHkOBefRH3qtfDK6yFEG0RCcFNH7JkrFSO9rCoE+JZvq8
         jXtLfthtCJUhvje5mHJcckh+PB9bKXqrrMLg1VAPNvnZa6C/pIsyo+LllUYZBFMk4QAL
         T8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684770636; x=1687362636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5EoxSWTbZ7f4uUwHdfO8oRaR8Zf3HbYw6LZWLrtj7o=;
        b=E1iZFqDWr061mnhaoxyHwl9R9quY3SYAfXYp60KW8tzxdKn6BOhbq/8K/ebQlrhwTE
         NQaEDy9MdvyPeIhzQKaE13kOreuyHTtitxdSx21FC5UvIxPO95WNBODDviJLGx9jYHgn
         DvxZrtbrhiLhkFEcf6jQ/O2GhIQfij3MAG9w3949zPRhzxqXgPr/sjIYqZvRpqX3pxRF
         3fpwURAvlRGBrNgGhzIixhQgeK49oIBqTU6h0bu7YWYE1DCT37tbX59/VkKbNV+OeFpB
         GbYBqJ2asYkKKo0A6ismwDTgIzDrdpaYOiKhYpByJzIHcd2YP+/23y26ddNG+jCkcAm8
         oyfA==
X-Gm-Message-State: AC+VfDxhmDQ0//h1P8MkuaFSLdJkb2hA+5+7gXyI46tMqk8ivehypfL9
        aU4jqkDVIXGUC9N73kO354enivvTVo4=
X-Google-Smtp-Source: ACHHUZ5bmd8UsBXwNVhG+/oYOyAjgR2LVwt3rBvruoZvMBljZmso4tozgBnOlHjQpZH9bjPF/mWoig==
X-Received: by 2002:a92:d8cb:0:b0:332:f72b:3b30 with SMTP id l11-20020a92d8cb000000b00332f72b3b30mr7240899ilo.10.1684770635830;
        Mon, 22 May 2023 08:50:35 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id e2-20020a056638020200b00418b8f08187sm1854683jaq.126.2023.05.22.08.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 08:50:35 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/radeon: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 15:50:32 +0000
Message-ID: <20230522155032.2336283-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c        |    2 +-
 drivers/gpu/drm/radeon/radeon_atombios.c |    4 ++--
 drivers/gpu/drm/radeon/radeon_combios.c  |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 1c5d9388ad0b..5f610e9a5f0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1509,7 +1509,7 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 	str = CSTR(idx);
 	if (*str != '\0') {
 		pr_info("ATOM BIOS: %s\n", str);
-		strlcpy(ctx->vbios_version, str, sizeof(ctx->vbios_version));
+		strscpy(ctx->vbios_version, str, sizeof(ctx->vbios_version));
 	}
 
 	atom_rom_header = (struct _ATOM_ROM_HEADER *)CSTR(base);
diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index 4ad5a328d920..bf3c411a55c5 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -2105,7 +2105,7 @@ static int radeon_atombios_parse_power_table_1_3(struct radeon_device *rdev)
 			const char *name = thermal_controller_names[power_info->info.
 								    ucOverdriveThermalController];
 			info.addr = power_info->info.ucOverdriveControllerAddress >> 1;
-			strlcpy(info.type, name, sizeof(info.type));
+			strscpy(info.type, name, sizeof(info.type));
 			i2c_new_client_device(&rdev->pm.i2c_bus->adapter, &info);
 		}
 	}
@@ -2355,7 +2355,7 @@ static void radeon_atombios_add_pplib_thermal_controller(struct radeon_device *r
 				struct i2c_board_info info = { };
 				const char *name = pp_lib_thermal_controller_names[controller->ucType];
 				info.addr = controller->ucI2cAddress >> 1;
-				strlcpy(info.type, name, sizeof(info.type));
+				strscpy(info.type, name, sizeof(info.type));
 				i2c_new_client_device(&rdev->pm.i2c_bus->adapter, &info);
 			}
 		} else {
diff --git a/drivers/gpu/drm/radeon/radeon_combios.c b/drivers/gpu/drm/radeon/radeon_combios.c
index 783a6b8802d5..795c3667f6d6 100644
--- a/drivers/gpu/drm/radeon/radeon_combios.c
+++ b/drivers/gpu/drm/radeon/radeon_combios.c
@@ -2702,7 +2702,7 @@ void radeon_combios_get_power_modes(struct radeon_device *rdev)
 				struct i2c_board_info info = { };
 				const char *name = thermal_controller_names[thermal_controller];
 				info.addr = i2c_addr >> 1;
-				strlcpy(info.type, name, sizeof(info.type));
+				strscpy(info.type, name, sizeof(info.type));
 				i2c_new_client_device(&rdev->pm.i2c_bus->adapter, &info);
 			}
 		}
@@ -2719,7 +2719,7 @@ void radeon_combios_get_power_modes(struct radeon_device *rdev)
 				struct i2c_board_info info = { };
 				const char *name = "f75375";
 				info.addr = 0x28;
-				strlcpy(info.type, name, sizeof(info.type));
+				strscpy(info.type, name, sizeof(info.type));
 				i2c_new_client_device(&rdev->pm.i2c_bus->adapter, &info);
 				DRM_INFO("Possible %s thermal controller at 0x%02x\n",
 					 name, info.addr);

