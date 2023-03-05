Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DEC6AAFA6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 13:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCEMx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 07:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCEMx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 07:53:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B498CC2E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 04:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678020759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vQQ0uYBPxRhMjlBoHSkG7kjvkj++lGtvOQg+vNT+2wk=;
        b=ep0dNilsfrDK5tUBFz+UF7bgtaSWJ/rYWtk9E+9fkCW0AvhNi5Ep7ZBAAXQictHl3jH6uL
        3Sga/b1OmuDPMCEVqgUKkzV03nQSh5rGIYaw2YcFyu4vie1Rf+zbZXQARdNoIlHNrsBqv2
        v9azCkU/3X/XWxSIyD3P8kIj8n8x6IQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-SvnZDXiLMjujIZQ8okvo3A-1; Sun, 05 Mar 2023 07:52:35 -0500
X-MC-Unique: SvnZDXiLMjujIZQ8okvo3A-1
Received: by mail-qk1-f199.google.com with SMTP id ea22-20020a05620a489600b00742cec04043so4030256qkb.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 04:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678020754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQQ0uYBPxRhMjlBoHSkG7kjvkj++lGtvOQg+vNT+2wk=;
        b=UKBm4Ay0ncaWoBpQ3K+QWMrNxPmZYVoE/EdfVYfXG/19+RhMIOdhP4C6MEeSCFVVpp
         Eziy2mkQljsqEvdW3w4XTW7bYH0S8j8DlQU96oMFc2ADlaH6jFNxpCZR2Om+8Xu17lbl
         bEsfdIrurg2zW5LjpQRhkBx0fKbrhpaSpji3Ngf88BOMrHzoUS6japxYeBb3ZemRiW9O
         P04Hkiv+aE2tLaSQui5hwjoYP/g6pXT6xbc9lqMy4e1x0I+CxGfPk1aqGp50ogZezY6s
         d75p579Ews3BeXDzfzZUyKkYdoPtfjjS3u5kqvvkVmjrU4ALKfCy9AvptPjVak3mx0Br
         oFrg==
X-Gm-Message-State: AO0yUKV26aCP1+rQbjy/gCTtBqhY0ifrBFv0a4arKE/jMEN5aJVnKlzu
        iL7nZsN5FCuWm1bFglLp7GubEy0C2ERAbmegEr/jG+2DwRhbGYCxKD7kg2KnXjM10r0+E9S/rLN
        wUciWXMwr5cUdcMF0w3oDlTBR
X-Received: by 2002:a05:622a:5d2:b0:3b9:a5d8:2c50 with SMTP id d18-20020a05622a05d200b003b9a5d82c50mr12269839qtb.38.1678020754030;
        Sun, 05 Mar 2023 04:52:34 -0800 (PST)
X-Google-Smtp-Source: AK7set+W7zKVuSVvPa9kOsfNu2XMxPKYssuDIr6jC6Wd16rob9HdjLdX/3AcHy4wLZTo1nMeA5PdoQ==
X-Received: by 2002:a05:622a:5d2:b0:3b9:a5d8:2c50 with SMTP id d18-20020a05622a05d200b003b9a5d82c50mr12269819qtb.38.1678020753790;
        Sun, 05 Mar 2023 04:52:33 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a3-20020ac86103000000b003b63dfad2b4sm5681344qtm.0.2023.03.05.04.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:52:32 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, jiapeng.chong@linux.alibaba.com,
        aurabindo.pillai@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: change several dcn30 variables storage-class-specifier to static
Date:   Sun,  5 Mar 2023 07:52:26 -0500
Message-Id: <20230305125226.1953574-1-trix@redhat.com>
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

smatch reports these similar problems in dcn30
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_dwb.c:223:25:
  warning: symbol 'dcn30_dwbc_funcs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_mmhubbub.c:214:28:
  warning: symbol 'dcn30_mmhubbub_funcs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_mpc.c:1402:24:
  warning: symbol 'dcn30_mpc_funcs' was not declared. Should it be static?

All of these are only used in their definition file, so they should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c      | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c
index f14f69616692..0d98918bf0fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c
@@ -220,7 +220,7 @@ void dwb3_set_denorm(struct dwbc *dwbc, struct dc_dwb_params *params)
 }
 
 
-const struct dwbc_funcs dcn30_dwbc_funcs = {
+static const struct dwbc_funcs dcn30_dwbc_funcs = {
 	.get_caps		= dwb3_get_caps,
 	.enable			= dwb3_enable,
 	.disable		= dwb3_disable,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c
index 7a93eff183d9..6f2a0d5d963b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c
@@ -211,7 +211,7 @@ static void mmhubbub3_config_mcif_arb(struct mcif_wb *mcif_wb,
 	REG_UPDATE(MCIF_WB_ARBITRATION_CONTROL, MCIF_WB_CLIENT_ARBITRATION_SLICE,  params->arbitration_slice);
 }
 
-const struct mcif_wb_funcs dcn30_mmhubbub_funcs = {
+static const struct mcif_wb_funcs dcn30_mmhubbub_funcs = {
 	.warmup_mcif		= mmhubbub3_warmup_mcif,
 	.enable_mcif		= mmhubbub2_enable_mcif,
 	.disable_mcif		= mmhubbub2_disable_mcif,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
index ad1c1b703874..6cf40c1332bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
@@ -1399,7 +1399,7 @@ static void mpc3_set_mpc_mem_lp_mode(struct mpc *mpc)
 	}
 }
 
-const struct mpc_funcs dcn30_mpc_funcs = {
+static const struct mpc_funcs dcn30_mpc_funcs = {
 	.read_mpcc_state = mpc1_read_mpcc_state,
 	.insert_plane = mpc1_insert_plane,
 	.remove_mpcc = mpc1_remove_mpcc,
-- 
2.27.0

