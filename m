Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1332F6AAB19
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 17:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCDQXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 11:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDQXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 11:23:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D758515565
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 08:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677946960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dmotLXem4e3x/uxYnezILl2DZNq6o+kU9ZnW6R95Pzc=;
        b=YihrXB1l3uoXLyLwpSEe+08m9kGsQaVKXSubSJpI2JrRU6q/6IvayPjU0s2LFbB/aGJCEV
        AaJ6x1qsOIalJ3gygT0jWRTckEpfK37TdRWre6mkszYspDSOzfq8jpEQIYpKbRA0UVE+Wt
        4UDDMe0zydTfzxWnyfnAzTgVPAjlX2k=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-okmueAt6M8aR_zuuuEr4Fg-1; Sat, 04 Mar 2023 11:22:27 -0500
X-MC-Unique: okmueAt6M8aR_zuuuEr4Fg-1
Received: by mail-qv1-f72.google.com with SMTP id jh21-20020a0562141fd500b0053c23b938a0so3156848qvb.17
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 08:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677946942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmotLXem4e3x/uxYnezILl2DZNq6o+kU9ZnW6R95Pzc=;
        b=PAbFStaN5PS53U1NM2jX/5asgGMcFD9JqtRwpj+IFZGwZJW2QKSiSNkNqYnkJU7/Tx
         OcGqhjx6xTmTi0sYKeAsIze9oecEHxSV5OUVZoOGx9Rup6EFnyqhDpLtMSSQM1QIzlgJ
         W+vDEwr9LvhGXufjK41BVbt18m2y9rPpvQTmTeaboUVblxoLAp6Pf2SgP/cHJkuridKK
         jX+s/XDdPhSB34VVhFPmyxwA0AlESbhiv0RAFHIEGcXoQ86mqEf4ZDSGtPtBf0CKGiRL
         s+j5Tui13faeEP3GM9jqd8WyXWA/No6Bm/ENpoxbR6WWoK2+fzLZVYB7p7PlDO91NkJH
         LslA==
X-Gm-Message-State: AO0yUKXLf6nDp/l5Kx2r/03IH22j62ETMrQVOQ8gyIBsF+TuifLYmaqW
        TnW2zYtCaSXQhToq0f5UItaHd/iuVQUrfuxkRFHMT2vHZJqqYOqnK386/v3Rpe3u6qjXPGM3/XZ
        vuW4HK2zXPAlxAXCNDnyMkK3c
X-Received: by 2002:a05:6214:f09:b0:577:5b89:577e with SMTP id gw9-20020a0562140f0900b005775b89577emr10603064qvb.32.1677946942325;
        Sat, 04 Mar 2023 08:22:22 -0800 (PST)
X-Google-Smtp-Source: AK7set/JOVgua1W48N5/fE0WY936nqy/GjjBYTH7jYlDd1pCaIPB4j3tzfLMIQGDzqH29BsEliUTcQ==
X-Received: by 2002:a05:6214:f09:b0:577:5b89:577e with SMTP id gw9-20020a0562140f0900b005775b89577emr10603032qvb.32.1677946942084;
        Sat, 04 Mar 2023 08:22:22 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s144-20020a374596000000b0073bb4312842sm3904539qka.128.2023.03.04.08.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 08:22:21 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, alvin.lee2@amd.com, javierm@redhat.com,
        hamza.mahfooz@amd.com, eric.bernstein@amd.com, roman.li@amd.com,
        wenjing.liu@amd.com, praful.swarnakar@amd.com, tzimmermann@suse.de,
        jiapeng.chong@linux.alibaba.com, Pavle.Kotarac@amd.com,
        hansen.dsouza@amd.com, Charlene.Liu@amd.com, Josip.Pavic@amd.com,
        Jun.Lei@amd.com, chiahsuan.chung@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: change several dcn20 variables storage-class-specifier to static
Date:   Sat,  4 Mar 2023 11:22:13 -0500
Message-Id: <20230304162213.1939515-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
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

smatch reports these similar problems in dcn20
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dsc.c:53:24:
  warning: symbol 'dcn20_dsc_funcs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dwb.c:304:25:
  warning: symbol 'dcn20_dwbc_funcs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_mmhubbub.c:300:28:
  warning: symbol 'dcn20_mmhubbub_funcs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_mpc.c:545:24:
  warning: symbol 'dcn20_mpc_funcs' was not declared. Should it be static?

All of these are only used in their definition file, so they should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c      | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c      | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
index 42344aec60d6..5bd698cd6d20 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
@@ -50,7 +50,7 @@ static void dsc2_enable(struct display_stream_compressor *dsc, int opp_pipe);
 static void dsc2_disable(struct display_stream_compressor *dsc);
 static void dsc2_disconnect(struct display_stream_compressor *dsc);
 
-const struct dsc_funcs dcn20_dsc_funcs = {
+static const struct dsc_funcs dcn20_dsc_funcs = {
 	.dsc_get_enc_caps = dsc2_get_enc_caps,
 	.dsc_read_state = dsc2_read_state,
 	.dsc_validate_stream = dsc2_validate_stream,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c
index f1490e97b6ce..f8667be57046 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c
@@ -301,7 +301,7 @@ void dwb2_set_scaler(struct dwbc *dwbc, struct dc_dwb_params *params)
 
 }
 
-const struct dwbc_funcs dcn20_dwbc_funcs = {
+static const struct dwbc_funcs dcn20_dwbc_funcs = {
 	.get_caps		= dwb2_get_caps,
 	.enable			= dwb2_enable,
 	.disable		= dwb2_disable,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.c
index ccd91792991b..259a98e4ee2c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.c
@@ -297,7 +297,7 @@ void mcifwb2_dump_frame(struct mcif_wb *mcif_wb,
 	dump_info->size		= dest_height * (mcif_params->luma_pitch + mcif_params->chroma_pitch);
 }
 
-const struct mcif_wb_funcs dcn20_mmhubbub_funcs = {
+static const struct mcif_wb_funcs dcn20_mmhubbub_funcs = {
 	.enable_mcif		= mmhubbub2_enable_mcif,
 	.disable_mcif		= mmhubbub2_disable_mcif,
 	.config_mcif_buf	= mmhubbub2_config_mcif_buf,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
index 116f67a0b989..5da6e44f284a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
@@ -542,7 +542,7 @@ static struct mpcc *mpc2_get_mpcc_for_dpp(struct mpc_tree *tree, int dpp_id)
 	return NULL;
 }
 
-const struct mpc_funcs dcn20_mpc_funcs = {
+static const struct mpc_funcs dcn20_mpc_funcs = {
 	.read_mpcc_state = mpc1_read_mpcc_state,
 	.insert_plane = mpc1_insert_plane,
 	.remove_mpcc = mpc1_remove_mpcc,
-- 
2.27.0

