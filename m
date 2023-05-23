Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A0570DBC6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbjEWLub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjEWLu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:50:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917B9FE
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684842582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ehkOIFzpHbRExxwyu097KqZWDTX7tEk3jO5IBFhFU3Y=;
        b=WHikG8kY2UHRbexUkCLzwsIbOrBPhvhWqBF51aoHUdr23LDsMdOWOkwAg1nTJ5kLJsPsZQ
        JIjCmmU+yj0veLfba3MHSboOE1sblBcIyjeG6A2eKIZ/G0gUHS7IKq8Faa14KSvuXGixGn
        lh12PcJ+IO4Z+ryzHTQpWoPb8MSHi5E=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-krHN9inzMt-5EVUX6eODAQ-1; Tue, 23 May 2023 07:49:41 -0400
X-MC-Unique: krHN9inzMt-5EVUX6eODAQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75af7f030a8so254341385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684842581; x=1687434581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehkOIFzpHbRExxwyu097KqZWDTX7tEk3jO5IBFhFU3Y=;
        b=eF+uncxzkCgBXZaqXXwzDLLwH3AAkFZh6v1OpdASNd5Mcuxu//od6S5TYABiYKdZlf
         dKa5+/lWBE2IEojhzEc5SZ/CfmZ91kkH8zOh4fld+HeNPcnXpepqAVz+rkfexgxXElRs
         iMNYAl9Z8We7JdL6XgZvfoJthVLYzUOh+NhfNW4Kn5ee4x8PB2RuziKmn06jBicr6Org
         n3iOMnIdptgrXoTRSsDTQ1ROM2JVf4HzjZbA3f9UA0vlHPyZxG8SLx/FGG4zcP74MFFU
         9BbWl/HwhBJclkILFc4wImainZ8QYe9p/g6exE/E264XghOwaJEv9t3JeH+GPaVothda
         mD7g==
X-Gm-Message-State: AC+VfDw31pI8bGKfbHWkTIbpmbgoQ0v/gm4dkMsqRk5/Fo0hjlJisR+S
        zfeJLLsioStwa7nnr6QuWwnaTbl5vYnTtveWszRhbxZ0IQo/tK/INfq5Vj7qmE6M/736uehLqSz
        aFh5XyOQ63LU3aciBqhFDa7ii
X-Received: by 2002:a05:620a:4729:b0:75b:23a1:8e61 with SMTP id bs41-20020a05620a472900b0075b23a18e61mr4404062qkb.50.1684842581142;
        Tue, 23 May 2023 04:49:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ454BiFvVGHW3X1aVYaT0byKBgm9wV3PxaMMK3SBnSdxglwCADjCPGSr4qskptcC3WGT6OipA==
X-Received: by 2002:a05:620a:4729:b0:75b:23a1:8e61 with SMTP id bs41-20020a05620a472900b0075b23a18e61mr4404055qkb.50.1684842580930;
        Tue, 23 May 2023 04:49:40 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j9-20020a37c249000000b0074e0e6aae1csm2451529qkm.36.2023.05.23.04.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 04:49:40 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, qingqing.zhuo@amd.com, wenjing.liu@amd.com,
        aurabindo.pillai@amd.com, Samson.Tam@amd.com, gpiccoli@igalia.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: remove unused variables res_create_maximus_funcs and debug_defaults_diags
Date:   Tue, 23 May 2023 07:49:37 -0400
Message-Id: <20230523114937.1080767-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc with W=1 reports
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:1069:43: error:
  ‘res_create_maximus_funcs’ defined but not used [-Werror=unused-const-variable=]
 1069 | static const struct resource_create_funcs res_create_maximus_funcs = {
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:727:38: error:
  ‘debug_defaults_diags’ defined but not used [-Werror=unused-const-variable=]
  727 | static const struct dc_debug_options debug_defaults_diags = {
      |                                      ^~~~~~~~~~~~~~~~~~~~

These variables are not used so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 23 -------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 7dcae3183e07..6ef7e2634991 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -724,22 +724,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.underflow_assert_delay_us = 0xFFFFFFFF,
 };
 
-static const struct dc_debug_options debug_defaults_diags = {
-		.disable_dmcu = false,
-		.force_abm_enable = false,
-		.timing_trace = true,
-		.clock_trace = true,
-		.disable_dpp_power_gate = true,
-		.disable_hubp_power_gate = true,
-		.disable_clock_gate = true,
-		.disable_pplib_clock_request = true,
-		.disable_pplib_wm_range = true,
-		.disable_stutter = true,
-		.scl_reset_length10 = true,
-		.underflow_assert_delay_us = 0xFFFFFFFF,
-		.enable_tri_buf = true,
-};
-
 void dcn20_dpp_destroy(struct dpp **dpp)
 {
 	kfree(TO_DCN20_DPP(*dpp));
@@ -1066,13 +1050,6 @@ static const struct resource_create_funcs res_create_funcs = {
 	.create_hwseq = dcn20_hwseq_create,
 };
 
-static const struct resource_create_funcs res_create_maximus_funcs = {
-	.read_dce_straps = NULL,
-	.create_audio = NULL,
-	.create_stream_encoder = NULL,
-	.create_hwseq = dcn20_hwseq_create,
-};
-
 static void dcn20_pp_smu_destroy(struct pp_smu_funcs **pp_smu);
 
 void dcn20_clock_source_destroy(struct clock_source **clk_src)
-- 
2.27.0

