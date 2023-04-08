Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18486DBB38
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 15:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDHNoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 09:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDHNom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 09:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547DFA5CD
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 06:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680961437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cWTGZwUDsK+ArhfUvsnQDdChpakeTyXMHjj4Kv1VcJU=;
        b=B6bHfTQjBnXhfP8BFUrpZnkG2SFaHdnVsHqRHB5DCHBR+8COUE8bQ9KBqEfj25umMz3oAI
        s6oPVftguT8sOHAGHqjmjht9Gla09ssvDyM9FWf2pnwe7h40s532D9TZpXRKdO6AtUakjB
        mQRakDKZAdpMNAbNlAB401qZLDHlDbg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-zD3CPgnyPqSMpMseqboytg-1; Sat, 08 Apr 2023 09:43:54 -0400
X-MC-Unique: zD3CPgnyPqSMpMseqboytg-1
Received: by mail-qv1-f71.google.com with SMTP id pr26-20020a056214141a00b005a228adfcefso692567qvb.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 06:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680961433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWTGZwUDsK+ArhfUvsnQDdChpakeTyXMHjj4Kv1VcJU=;
        b=CbzL2P36JuTYUyCatTr+634TKfF1zOVe67o6voD3HR2VwdPI0IWKldanG4yjBtaeCF
         53f/e9Z39iSc0UiqmRZiOTX0ykfXW/1ZuN7XIJnfH1YPMw3wB28Q1DI5CSJ5oyy9RQgs
         R/0e0n0NQkbHMaCo1iaNdkfvA8keEI9fXMPGBKOrnYYrO0phcGQnB4S0r7lhFEExT11k
         UEOIPLje1J30t7j/H9a1DG6xNvTtcLNtOhdmcQD4ZECxKWlG37BpxSG+eDe0z87ny0iV
         Ak8EGad6CuaHy1kgi1m3DF7ATaFKf5nH/dZ/bYw4Up/pcDPixzqd6Ay1AlhTR4r9HlC6
         j9Hw==
X-Gm-Message-State: AAQBX9fOrD82FvtkC+fuBGzEyc5Ie/hM3jDZcmFR3Fo0C4nl1AxbQucm
        ik2FFvf8lQXj/OoYQ0tay9F6o9fYkHNoc9M4dNqWKVzBYidWAIpd03oZvfleY5GznzgSNds/xCU
        ZoxOkt/pAfPkCEFPsTioYQ/Zm
X-Received: by 2002:a05:622a:1ba4:b0:3e6:6d82:3fd8 with SMTP id bp36-20020a05622a1ba400b003e66d823fd8mr3795510qtb.17.1680961433683;
        Sat, 08 Apr 2023 06:43:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350YDlN+3ZRDKytX5Na9sWA4wfmdLE+QkD9JBOEgqvZpj+T/K9mAWJXM0MJJelMtg0nudO6TROA==
X-Received: by 2002:a05:622a:1ba4:b0:3e6:6d82:3fd8 with SMTP id bp36-20020a05622a1ba400b003e66d823fd8mr3795488qtb.17.1680961433420;
        Sat, 08 Apr 2023 06:43:53 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h22-20020ac85056000000b003e302c1f498sm1833122qtm.37.2023.04.08.06.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 06:43:53 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, Pavle.Kotarac@amd.com, Jun.Lei@amd.com,
        nicholas.kazlauskas@amd.com, Charlene.Liu@amd.com,
        aurabindo.pillai@amd.com, Dmytro.Laktyushkin@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: set variables dml*_funcs storage-class-specifier to static
Date:   Sat,  8 Apr 2023 09:43:48 -0400
Message-Id: <20230408134348.2703105-1-trix@redhat.com>
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

smatch reports
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:44:24: warning: symbol
  'dml20_funcs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:51:24: warning: symbol
  'dml20v2_funcs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:58:24: warning: symbol
  'dml21_funcs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:65:24: warning: symbol
  'dml30_funcs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:72:24: warning: symbol
  'dml31_funcs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:79:24: warning: symbol
  'dml314_funcs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:86:24: warning: symbol
  'dml32_funcs' was not declared. Should it be static?

These variables are only used in one file so should be static.
Cleanup whitespace, use tabs consistently for indents.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../drm/amd/display/dc/dml/display_mode_lib.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
index 4125d3d111d1..bdf3ac6cadd5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
@@ -41,51 +41,51 @@
 #include "dcn32/display_rq_dlg_calc_32.h"
 #include "dml_logger.h"
 
-const struct dml_funcs dml20_funcs = {
+static const struct dml_funcs dml20_funcs = {
 	.validate = dml20_ModeSupportAndSystemConfigurationFull,
 	.recalculate = dml20_recalculate,
 	.rq_dlg_get_dlg_reg = dml20_rq_dlg_get_dlg_reg,
 	.rq_dlg_get_rq_reg = dml20_rq_dlg_get_rq_reg
 };
 
-const struct dml_funcs dml20v2_funcs = {
+static const struct dml_funcs dml20v2_funcs = {
 	.validate = dml20v2_ModeSupportAndSystemConfigurationFull,
 	.recalculate = dml20v2_recalculate,
 	.rq_dlg_get_dlg_reg = dml20v2_rq_dlg_get_dlg_reg,
 	.rq_dlg_get_rq_reg = dml20v2_rq_dlg_get_rq_reg
 };
 
-const struct dml_funcs dml21_funcs = {
-        .validate = dml21_ModeSupportAndSystemConfigurationFull,
-        .recalculate = dml21_recalculate,
-        .rq_dlg_get_dlg_reg = dml21_rq_dlg_get_dlg_reg,
-        .rq_dlg_get_rq_reg = dml21_rq_dlg_get_rq_reg
+static const struct dml_funcs dml21_funcs = {
+	.validate = dml21_ModeSupportAndSystemConfigurationFull,
+	.recalculate = dml21_recalculate,
+	.rq_dlg_get_dlg_reg = dml21_rq_dlg_get_dlg_reg,
+	.rq_dlg_get_rq_reg = dml21_rq_dlg_get_rq_reg
 };
 
-const struct dml_funcs dml30_funcs = {
+static const struct dml_funcs dml30_funcs = {
 	.validate = dml30_ModeSupportAndSystemConfigurationFull,
 	.recalculate = dml30_recalculate,
 	.rq_dlg_get_dlg_reg = dml30_rq_dlg_get_dlg_reg,
 	.rq_dlg_get_rq_reg = dml30_rq_dlg_get_rq_reg
 };
 
-const struct dml_funcs dml31_funcs = {
+static const struct dml_funcs dml31_funcs = {
 	.validate = dml31_ModeSupportAndSystemConfigurationFull,
 	.recalculate = dml31_recalculate,
 	.rq_dlg_get_dlg_reg = dml31_rq_dlg_get_dlg_reg,
 	.rq_dlg_get_rq_reg = dml31_rq_dlg_get_rq_reg
 };
 
-const struct dml_funcs dml314_funcs = {
+static const struct dml_funcs dml314_funcs = {
 	.validate = dml314_ModeSupportAndSystemConfigurationFull,
 	.recalculate = dml314_recalculate,
 	.rq_dlg_get_dlg_reg = dml314_rq_dlg_get_dlg_reg,
 	.rq_dlg_get_rq_reg = dml314_rq_dlg_get_rq_reg
 };
 
-const struct dml_funcs dml32_funcs = {
+static const struct dml_funcs dml32_funcs = {
 	.validate = dml32_ModeSupportAndSystemConfigurationFull,
-    .recalculate = dml32_recalculate,
+	.recalculate = dml32_recalculate,
 	.rq_dlg_get_dlg_reg_v2 = dml32_rq_dlg_get_dlg_reg,
 	.rq_dlg_get_rq_reg_v2 = dml32_rq_dlg_get_rq_reg
 };
-- 
2.27.0

