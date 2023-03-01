Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17ED86A6DB8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCAOBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCAOBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:01:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D536D22004
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677679213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CL8E0O6RN+NrPQ/BLg0Ur8+SgAnEDTABwI3zVV7mIYc=;
        b=cp5cTK8d3m7TAfnDMEd8BTySo1wfAkrvHw4o6sohGGwzsanWYZFgAhLiLJt3uUDruJkQMA
        LXdg853mLMvUnPDKJvQZ8jWj67vU1U6BDG3Na3FTom/98ekWF3GWeMjqaaxQHwK/MAXqH0
        1qfXCaqzwqn1oP9QQUYAWH8UZg5R4A4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-329-8Zj7wAt0PJSb9klb5q03uA-1; Wed, 01 Mar 2023 09:00:06 -0500
X-MC-Unique: 8Zj7wAt0PJSb9klb5q03uA-1
Received: by mail-qk1-f197.google.com with SMTP id ou5-20020a05620a620500b007423e532628so8023322qkn.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 06:00:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677679205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CL8E0O6RN+NrPQ/BLg0Ur8+SgAnEDTABwI3zVV7mIYc=;
        b=E6xJn4WgLIhzYQMm3m+574cYFhpZN604oeFPpH+/BknX7VStDSW8EhI0xppA+b6o09
         +g7uJMp8PBJk90kgLk8WoJgY8tJACr4W//yLB5GtnqNBvXXoWlIdsJSSSoZHHjv0O7Vp
         T67xk+jkg2AY5jw/QjRmIYRFDgBmgavSyFjpOu2cfLL7cy9XjTgiHfZXI2EroTy2S9Hx
         8/Iyx/3hw+bPRktFV8XrglEuaIj3HYmZs18b+Twe1REGOzvKFMZmQ0H4EvbgO1DhHGmo
         NAhPGVNEARAl8Ca5ivH7dkt0Si3PkOBIt8ITY6Rw5e42444snhhO4qOtKLkQQIDDlbMo
         rDOw==
X-Gm-Message-State: AO0yUKUtuAOUwVIJCc7zZN880Mmz3di/y6Fr4capnJw2PfsF98KH3dmS
        wF67KWT2LAVsm+k8ThbyedXcbddqYw4fGfaN0OmLDeThj+x27i08grzPehaLvJQ/2mZCGyyU7Vv
        h0L5dBOgFHvjLZFXykgMOwUh9
X-Received: by 2002:ac8:5a4e:0:b0:3bf:e320:ba5d with SMTP id o14-20020ac85a4e000000b003bfe320ba5dmr11526513qta.17.1677679205437;
        Wed, 01 Mar 2023 06:00:05 -0800 (PST)
X-Google-Smtp-Source: AK7set8dWK4c13zlMSqeRkUXAOU6QC6GcZMEJsa/xNpp+NtbXPm/fld3f2OETxlRbgVc4VZpjYjcQw==
X-Received: by 2002:ac8:5a4e:0:b0:3bf:e320:ba5d with SMTP id o14-20020ac85a4e000000b003bfe320ba5dmr11526351qta.17.1677679204525;
        Wed, 01 Mar 2023 06:00:04 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t128-20020ae9df86000000b0073d7e81f8b5sm8801235qkf.35.2023.03.01.06.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 06:00:03 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, andrealmeid@igalia.com, kevinyang.wang@amd.com,
        li.ma@amd.com, Kun.Liu2@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/pm: set vangogh_set_apu_thermal_limit storage-class-specifier to static
Date:   Wed,  1 Mar 2023 09:00:00 -0500
Message-Id: <20230301140000.2719608-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc with W=1 reports
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:1600:5:
  error: no previous prototype for ‘vangogh_set_apu_thermal_limit’ [-Werror=missing-prototypes]
 1600 | int vangogh_set_apu_thermal_limit(struct smu_context *smu, uint32_t limit)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vangogh_set_apu_thermal_limit is only used in vangogh_ppt.c, so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 016d5621e0b3..24046af60933 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1597,7 +1597,7 @@ static int vangogh_get_apu_thermal_limit(struct smu_context *smu, uint32_t *limi
 					      0, limit);
 }
 
-int vangogh_set_apu_thermal_limit(struct smu_context *smu, uint32_t limit)
+static int vangogh_set_apu_thermal_limit(struct smu_context *smu, uint32_t limit)
 {
 	return smu_cmn_send_smc_msg_with_param(smu,
 					      SMU_MSG_SetReducedThermalLimit,
-- 
2.27.0

