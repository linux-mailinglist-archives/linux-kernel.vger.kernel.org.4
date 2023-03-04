Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AB96AAAB1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 16:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjCDP1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 10:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDP1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 10:27:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06001E29D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 07:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677943611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/UDCKfL+7KAewaP80OA62WS4MzOdBiesWSnnrtlTFvY=;
        b=GUB3AEX9jY699jElosFY6cpUYniIxfxC6vB243EBvk8q0EGnXeFQ/ju0UuAwhY+BXnzRlB
        BqoPbLCNy79FZCd/MZP9mhQkyTgMTmzkd6ezERnrPzrB8eTyLGUUlRhfcXGUgNJcMQGN5a
        cUtpFePLdFrOcJFhMQvQ7FEV3HwTcTw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-bseNC7KiOdOwzKFpGZIjZA-1; Sat, 04 Mar 2023 10:26:50 -0500
X-MC-Unique: bseNC7KiOdOwzKFpGZIjZA-1
Received: by mail-qt1-f199.google.com with SMTP id p7-20020ac84607000000b003b9b6101f65so3028007qtn.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 07:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677943609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UDCKfL+7KAewaP80OA62WS4MzOdBiesWSnnrtlTFvY=;
        b=rog2R1IHKkvTjg+Epg0rLunhIpHnlP4GPTeoTMeMmsCbob2SQBveaUX6XJffMFrLWk
         FiBBbqE/iw9KpQB6u5tQkdkRB/tu8z8LxQJSoWeI6TZJg9EhcyoxGoF03FewgGnzeUr9
         635a9k0fUMAM6VGlbkr2PXnppc68R15ZVvVSB2al/gFpZBKwkZC5xo+0UIC+RGCaYdWg
         BVGR0rk0QBbYMhAnO+N4gqLKlhG5eLRzfR+e8Y7jWJl3bSznSrKhu9CUgNfb9i19yPLo
         P2QW1U4KdYj0Rp8KtCAymaArIHd+yXh4mD9zkYRAPreMZHbFrbC8bEBAF33u4Kw0JaPG
         e8zw==
X-Gm-Message-State: AO0yUKUcLFw3lLV1na0Vg1SDDuqb5AJb741vKbY8R+vHwZAARgRZTnEz
        MDBQKHRucd8DllZmnETjqQ1pqqIAmiF3sSSgeYg2DWQpRN05p9DxmhKEQU2iVwbl1nChUfdctc/
        wjyFcyq5o7n5oyXA58r/09V+v
X-Received: by 2002:a05:622a:91:b0:3bf:e320:ba5d with SMTP id o17-20020a05622a009100b003bfe320ba5dmr9306169qtw.17.1677943609587;
        Sat, 04 Mar 2023 07:26:49 -0800 (PST)
X-Google-Smtp-Source: AK7set/MOHotq65z85YoYXsl+9GxKlOMDwDiVF39R9D7RfzOLxzdvuuX5Qo/4zrs6kDMXmPcM2L2fg==
X-Received: by 2002:a05:622a:91:b0:3bf:e320:ba5d with SMTP id o17-20020a05622a009100b003bfe320ba5dmr9306142qtw.17.1677943609343;
        Sat, 04 Mar 2023 07:26:49 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j26-20020ac874da000000b003b82489d8acsm3884477qtr.21.2023.03.04.07.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 07:26:48 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, jiapeng.chong@linux.alibaba.com,
        Pavle.Kotarac@amd.com, oliver.logush@amd.com, alex.hung@amd.com,
        aurabindo.pillai@amd.com, HaoPing.Liu@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: change several dcn201 variables storage-class-specifier to static
Date:   Sat,  4 Mar 2023 10:26:40 -0500
Message-Id: <20230304152640.1938302-1-trix@redhat.com>
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

smatch reports these similar problems in dcn201
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c:165:22:
  warning: symbol 'dcn201_funcs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:77:30:
  warning: symbol 'dcn201_ip' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:139:37:
  warning: symbol 'dcn201_soc' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_mpc.c:79:24:
  warning: symbol 'dcn201_mpc_funcs' was not declared. Should it be static?

All of these are only used in their definition file, so they should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.c            | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c       | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
index f0577dcd1af6..811720749faf 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
@@ -162,7 +162,7 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 }
 
-struct clk_mgr_funcs dcn201_funcs = {
+static struct clk_mgr_funcs dcn201_funcs = {
 	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
 	.update_clocks = dcn201_update_clocks,
 	.init_clocks = dcn201_init_clocks,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.c
index 95c4c55f067c..1af03a86ec9b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.c
@@ -76,7 +76,7 @@ static void mpc201_init_mpcc(struct mpcc *mpcc, int mpcc_inst)
 	mpcc->shared_bottom = false;
 }
 
-const struct mpc_funcs dcn201_mpc_funcs = {
+static const struct mpc_funcs dcn201_mpc_funcs = {
 	.read_mpcc_state = mpc1_read_mpcc_state,
 	.insert_plane = mpc1_insert_plane,
 	.remove_mpcc = mpc1_remove_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
index 407d995bfa99..cd46701398d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
@@ -74,7 +74,7 @@
 #define MIN_DISP_CLK_KHZ 100000
 #define MIN_DPP_CLK_KHZ 100000
 
-struct _vcs_dpi_ip_params_st dcn201_ip = {
+static struct _vcs_dpi_ip_params_st dcn201_ip = {
 	.gpuvm_enable = 0,
 	.hostvm_enable = 0,
 	.gpuvm_max_page_table_levels = 4,
@@ -136,7 +136,7 @@ struct _vcs_dpi_ip_params_st dcn201_ip = {
 	.number_of_cursors = 1,
 };
 
-struct _vcs_dpi_soc_bounding_box_st dcn201_soc = {
+static struct _vcs_dpi_soc_bounding_box_st dcn201_soc = {
 	.clock_limits = {
 			{
 				.state = 0,
-- 
2.27.0

