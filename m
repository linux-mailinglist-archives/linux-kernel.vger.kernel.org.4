Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314466B0AB0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjCHOMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjCHOLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:11:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638668F52E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678284597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mXndFig5MxMz39oru/IvohSxV+rytJfkgOQsYDdo+fQ=;
        b=LOBGK1Dh8UmBVToSwzAy80BbcGExuuNZSavuqNWtZVEpyk645Ifxg1BLJzE9KL7j1LV4pt
        UA4z7cTRRF/Sc2vNkjPHEqxaypLqbWa/CiKXFvFAN8ax6CR+D3Ubi2Xdm92JYpDTbSX8yc
        k5GvVIoIkohQlVvVPqs6B6EFWajP+TY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-KHFF2M-fPqi48-0Mhji4YA-1; Wed, 08 Mar 2023 09:09:54 -0500
X-MC-Unique: KHFF2M-fPqi48-0Mhji4YA-1
Received: by mail-qt1-f199.google.com with SMTP id i24-20020ac84f58000000b003bfe3358691so9090558qtw.21
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 06:09:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678284593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXndFig5MxMz39oru/IvohSxV+rytJfkgOQsYDdo+fQ=;
        b=fzzwouMTteWoqSm36vBME2rjcPnWe/DFdlXC+4r663kZOt8gW6b5J1mUPHd9v5qXFP
         pIDU835TMlisKfptcFIpV3VWWBJbU/7cYT4EVFzp0KxPRLCTPjBJFYZ7f++e/1iuHXwN
         xKJd5zZUlI6Ss8UA5NttxHQ48faRWZpx6ewVHaVJLAVaQZB+ioJa17iAbMQHKkRTi31s
         ZOQ39oo4aFHQnEk8D4VtkDCBtZNppDayYAtT9PoAd0OZikTE7qiUeRjqyp1Oy83uuTdQ
         o1KiVv6PwQGc3wGcNl25fPyvlAFluAnNJvCXyNJiuYRBzmT6zXBkXmc4YFwJG5HtTXx7
         HN/Q==
X-Gm-Message-State: AO0yUKVQeGhIskoJV76id8GJaPHcNGLmK69HhXyn5ar0pMEjamvWjhSQ
        XsWOulj1ojyNYIptrwPZpHIKP4qSREL9hToOITrjmZ5J4QcRQdhV7pY7z9mTWBvo9pd30vWnWfq
        oKQgyG+cbY6Hw6Zbr3/FRc/c9bSwQ3Vxc
X-Received: by 2002:a05:622a:1443:b0:3bf:d4c3:365d with SMTP id v3-20020a05622a144300b003bfd4c3365dmr4212470qtx.14.1678284593677;
        Wed, 08 Mar 2023 06:09:53 -0800 (PST)
X-Google-Smtp-Source: AK7set/OjUR2DEyaB2HDQqosX6A/GPRFh2BbK8gtM7CV145ROLD4Op15ZKZMuAH5bQJg0F1d3/souw==
X-Received: by 2002:a05:622a:1443:b0:3bf:d4c3:365d with SMTP id v3-20020a05622a144300b003bfd4c3365dmr4212441qtx.14.1678284593432;
        Wed, 08 Mar 2023 06:09:53 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b1-20020ac812c1000000b003bfa932525dsm11523571qtj.51.2023.03.08.06.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 06:09:53 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, lyude@redhat.com, Wayne.Lin@amd.com,
        hersenxs.wu@amd.com, hamza.mahfooz@amd.com, Jerry.Zuo@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: remove unused variable res_pool
Date:   Wed,  8 Mar 2023 09:09:43 -0500
Message-Id: <20230308140943.2009970-1-trix@redhat.com>
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

With gcc and W=1, there is this error
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:1214:31:
  error: variable ‘res_pool’ set but not used [-Werror=unused-but-set-variable]
 1214 |         struct resource_pool *res_pool;
      |                               ^~~~~~~~

Since res_pool is unused, remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 2739bef9b90c..4b9b5e4050fc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1211,7 +1211,6 @@ static int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 	bool computed_streams[MAX_PIPES];
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_dp_mst_topology_mgr *mst_mgr;
-	struct resource_pool *res_pool;
 	int link_vars_start_index = 0;
 	int ret = 0;
 
@@ -1220,7 +1219,6 @@ static int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 
 	for (i = 0; i < dc_state->stream_count; i++) {
 		stream = dc_state->streams[i];
-		res_pool = stream->ctx->dc->res_pool;
 
 		if (stream->signal != SIGNAL_TYPE_DISPLAY_PORT_MST)
 			continue;
-- 
2.27.0

