Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A121370C2BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjEVPxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbjEVPwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:52:50 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B147FE6;
        Mon, 22 May 2023 08:52:48 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-76f06c0f58cso76390339f.1;
        Mon, 22 May 2023 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684770768; x=1687362768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OwP8XjPQvqKW6xBr4Aer+sS6LY6nG5MbxtpxV+9HcUY=;
        b=X1C5PR7OBPGQCgJeInQRtolY+16TDR0e9y+aXVcl4Jay+gJoMyO1YJuxDuH9ImE1cE
         IVAbKokBQmTIaTL75hJ9+LFxM9ABAln8+uKJLbsocGNXPoJTalFS+7XR6NwNR6e1b78U
         avZyV4HImz5dfs7/Ib6N9Q5U9UOFbgeYwedMvfgz1tGFcUFO+jOfSBxgnz7ITeel4R0N
         uEw3itrdiaesjXeRvUUqFl5dkLUaTFlP6VB8ZhXoixq89hAHpW9yxNx1v8+3fTClvI6f
         uKb7dMaW7JZZG9vsQcSNkyUngfI5YsL2gJBxZXr+s2IKWGCuuOPOOtZJ5BEOnukXDtex
         uVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684770768; x=1687362768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OwP8XjPQvqKW6xBr4Aer+sS6LY6nG5MbxtpxV+9HcUY=;
        b=XcmrsCVuR6+p3/Wzfr2j9ZKMVZCKn2sKzNvIkcs9jjT1fdztzfs5OqHBbrYfGsLur6
         hSljoTqOOFYvcutc02t+7Yz5rSIWubIElQLEGZdotuJndRuJ3Ou9nI0c/fYpyUCqHuzp
         t4XrIs9dch5btUhaos7htz/c0EifvHhDX5ZcdFz5JKtiEHmtdnGwm76uNvTURXf8tKBR
         WaWrnHavkBPMPdcJtW0d7GVMbG7sR7vaRUjTe1L7CczF8TipoZH99U0b+v6CdhW+uqv7
         MjctyfwVPOqVpEvYXNeceo7m8WyWIryMYhhz4KtadVBlIJl5waxzt8BNr9YN1X7gMtIy
         7n2A==
X-Gm-Message-State: AC+VfDxYW/SfCSrSp+TFKWXMexAIvO/HCT75L2trc/m7g8XHNjwBHrtw
        W1OVfeXSCix6HZILGrnmPqM=
X-Google-Smtp-Source: ACHHUZ5G3QAr2j++n+RyksPqWsnu8OAn7GpwPYHS00q3/2krEKpXMvD4hLOEY5pAgdonIAEEU/YoQg==
X-Received: by 2002:a05:6602:2188:b0:772:af3a:76b1 with SMTP id b8-20020a056602218800b00772af3a76b1mr7076407iob.21.1684770767849;
        Mon, 22 May 2023 08:52:47 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id az11-20020a056638418b00b00405f36ed05asm1729252jab.55.2023.05.22.08.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 08:52:47 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Evan Quan <evan.quan@amd.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 15:52:45 +0000
Message-ID: <20230522155245.2336818-1-azeemshaikh38@gmail.com>
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
 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index d3fe149d8476..81fb4e5dd804 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -794,7 +794,7 @@ void amdgpu_add_thermal_controller(struct amdgpu_device *adev)
 				struct i2c_board_info info = { };
 				const char *name = pp_lib_thermal_controller_names[controller->ucType];
 				info.addr = controller->ucI2cAddress >> 1;
-				strlcpy(info.type, name, sizeof(info.type));
+				strscpy(info.type, name, sizeof(info.type));
 				i2c_new_client_device(&adev->pm.i2c_bus->adapter, &info);
 			}
 		} else {

