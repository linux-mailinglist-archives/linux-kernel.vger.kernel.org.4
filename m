Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B7E6D25EB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjCaQoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjCaQn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:43:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D453223FEA
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680280847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=S5srYW34Gq6Rc0mPy9hqCIRWz9WH4Jy0yDiTUMwyFoY=;
        b=KM9x6QZIuZPMGD0HrmJdk5jtWrLXJvK+txC8WU5k0tEmR/CaaHLMpEDmhuqsSdF47fTUnS
        Jw9fNADx7JNF0km6YQrn5A30qDD8DYSgdTBZfvhuzzPUEuUJmmanlIJXaX23ElLTu2Zodd
        6P1ymxMyZXlCb6IhtLbBfzOUVTeyqmI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-FAjq3XoJP0GeL5y2Txe2Iw-1; Fri, 31 Mar 2023 12:40:45 -0400
X-MC-Unique: FAjq3XoJP0GeL5y2Txe2Iw-1
Received: by mail-qk1-f199.google.com with SMTP id 203-20020a370ad4000000b00746981f8f4bso10775702qkk.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680280845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5srYW34Gq6Rc0mPy9hqCIRWz9WH4Jy0yDiTUMwyFoY=;
        b=NDCJT2hGh6Al/sOvOlg6tRox3FemUak3VTycTJsnSCP28OsRSvF6TEAa1agp5jAwHD
         gW0sNF0ew7K9hgi/gBRWCgmPos/VJgEehItgNJ88kTppCpzrQRWbdH5jmsnTC65OVYBy
         a4CRAEttXk9TX6Yvh35NV/l9M/4pKsUqdEhPnRVan3iP9ydXkNVluLvUZ9tYWHzD4Fuz
         P85ACT85u+fqK9a7+tqfFYKdDd7fKEM8LAEWn4EUX6Dgy468HdwLUmMzvfp3ISzAeglq
         K0WoHJSLj7tRYXbYWe2ZJHaQo8JtbhVb9IbYgKr8GqrFlhqynOyDvdeWjqCPMSoPNB0A
         RlwQ==
X-Gm-Message-State: AAQBX9fl4lGGjrhkXhNcNNqwXKo7Fmvlv3umlN86SIk1IoyE2Fs9o4KK
        ZXONA4GstohxFsEGg65mRKSZ4XEk9gmhbzoBDEN4pvYTy45FgTUm+jiIYWkyffujZkhDEt6l0aD
        VqA7RjSUJgzytGTITKFk0qVTo
X-Received: by 2002:a05:622a:1a20:b0:3e3:9041:3f6e with SMTP id f32-20020a05622a1a2000b003e390413f6emr46722898qtb.7.1680280845097;
        Fri, 31 Mar 2023 09:40:45 -0700 (PDT)
X-Google-Smtp-Source: AK7set9AlG21wz/QX/2UqrS1W/pPfMtig2JbymMss4of37EbHIk5FJiRqMt3PBrL7AF9Ryxd9BM1Yg==
X-Received: by 2002:a05:622a:1a20:b0:3e3:9041:3f6e with SMTP id f32-20020a05622a1a2000b003e390413f6emr46722869qtb.7.1680280844887;
        Fri, 31 Mar 2023 09:40:44 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c70-20020a379a49000000b00746ae84ea6csm797194qke.3.2023.03.31.09.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 09:40:44 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        Hawking.Zhang@amd.com, kenneth.feng@amd.com, lijo.lazar@amd.com,
        KevinYang.Wang@amd.com, tim.huang@amd.com, andrealmeid@igalia.com,
        Kun.Liu2@amd.com, mario.limonciello@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/pm: remove unused num_of_active_display variable
Date:   Fri, 31 Mar 2023 12:40:41 -0400
Message-Id: <20230331164041.1859088-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:1700:6: error: variable
  'num_of_active_display' set but not used [-Werror,-Wunused-but-set-variable]
        int num_of_active_display = 0;
            ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b5d64749990e..f93f7a9ed631 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1696,8 +1696,6 @@ static int smu_display_configuration_change(void *handle,
 					    const struct amd_pp_display_configuration *display_config)
 {
 	struct smu_context *smu = handle;
-	int index = 0;
-	int num_of_active_display = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -1708,11 +1706,6 @@ static int smu_display_configuration_change(void *handle,
 	smu_set_min_dcef_deep_sleep(smu,
 				    display_config->min_dcef_deep_sleep_set_clk / 100);
 
-	for (index = 0; index < display_config->num_path_including_non_display; index++) {
-		if (display_config->displays[index].controller_id != 0)
-			num_of_active_display++;
-	}
-
 	return 0;
 }
 
-- 
2.27.0

