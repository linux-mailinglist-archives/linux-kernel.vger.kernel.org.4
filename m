Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CFA70BC56
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjEVLvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjEVLvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:51:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B1F10EF
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:51:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A93161EBF
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5771C4339B;
        Mon, 22 May 2023 11:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684756272;
        bh=vmhEzOLeII1TRyTAiOXHuCyCtcRxvOwz/9R88nNsAis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lEMTC6/qCBThkgoM0qf41k3j+222+sxSxyGkBTkUBedmRUg0xmdQLAmGy2jm0TkrI
         YBLq2FIRjJT/5qy/uPk2+Ujy+TclJCbCFagxEXTO0yaACD2jSIi/gHCqwe6ZLo1hnK
         83oXgaDSS0vX1T4IBK/6Mze5tCJtM/gznXkPKfjCKsFKY/FglTrmT3yVhzieeJb2xQ
         rgBio60K+EU3zmkRCEazMPVWTnzMZa9bFT7r8TXGHKBFStDeryTLJp4VMW61a7QU9W
         YlyHRszkkNLJgH+QPxPPXDOjRLYA93lX9JGmdr4f0jAr6oSJKIKs9RT6dZT2TtGxDN
         BcvRuOLn0jMpg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lijo Lazar <lijo.lazar@amd.com>, James Zhu <James.Zhu@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Le Ma <le.ma@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] drm/amdgpu:mark aqua_vanjaram_reg_init.c function as static
Date:   Mon, 22 May 2023 13:50:30 +0200
Message-Id: <20230522115047.1169839-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522115047.1169839-1-arnd@kernel.org>
References: <20230522115047.1169839-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A few newly added global functions have no prototype, which causes warnings:

drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c:169:5: error: no previous prototype for 'aqua_vanjaram_select_scheds' [-Werror=missing-prototypes]
drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c:310:5: error: no previous prototype for '__aqua_vanjaram_get_xcc_per_xcp' [-Werror=missing-prototypes]
drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c:337:5: error: no previous prototype for '__aqua_vanjaram_get_xcp_ip_info' [-Werror=missing-prototypes]
drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c:593:5: error: no previous prototype for 'aqua_vanjaram_get_xcp_ip_details' [-Werror=missing-prototypes]

There are no callers from other files, so just mark them as 'static'.

Fixes: 5f9f80485953 ("drm/amdgpu: add partition schedule for GC(9, 4, 3)")
Fixes: 27614f589fc0 ("drm/amdgpu: Add SOC partition funcs for GC v9.4.3")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 68d1a0fc5f5d..a595bb958215 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -166,7 +166,7 @@ static int aqua_vanjaram_update_partition_sched_list(struct amdgpu_device *adev)
 	return aqua_vanjaram_xcp_sched_list_update(adev);
 }
 
-int aqua_vanjaram_select_scheds(
+static int aqua_vanjaram_select_scheds(
 		struct amdgpu_device *adev,
 		u32 hw_ip,
 		u32 hw_prio,
@@ -307,7 +307,7 @@ static int aqua_vanjaram_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
 	return mode;
 }
 
-int __aqua_vanjaram_get_xcc_per_xcp(struct amdgpu_xcp_mgr *xcp_mgr, int mode)
+static int __aqua_vanjaram_get_xcc_per_xcp(struct amdgpu_xcp_mgr *xcp_mgr, int mode)
 {
 	int num_xcc, num_xcc_per_xcp = 0;
 
@@ -334,7 +334,7 @@ int __aqua_vanjaram_get_xcc_per_xcp(struct amdgpu_xcp_mgr *xcp_mgr, int mode)
 	return num_xcc_per_xcp;
 }
 
-int __aqua_vanjaram_get_xcp_ip_info(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
+static int __aqua_vanjaram_get_xcp_ip_info(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
 				    enum AMDGPU_XCP_IP_BLOCK ip_id,
 				    struct amdgpu_xcp_ip *ip)
 {
@@ -590,7 +590,7 @@ static int aqua_vanjaram_get_xcp_mem_id(struct amdgpu_xcp_mgr *xcp_mgr,
 	return r;
 }
 
-int aqua_vanjaram_get_xcp_ip_details(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
+static int aqua_vanjaram_get_xcp_ip_details(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
 				     enum AMDGPU_XCP_IP_BLOCK ip_id,
 				     struct amdgpu_xcp_ip *ip)
 {
-- 
2.39.2

