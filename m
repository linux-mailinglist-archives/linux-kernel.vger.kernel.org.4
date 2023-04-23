Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420F16EC07B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjDWOqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjDWOqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:46:44 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F7EE7C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8bT2ob0F8OaOVr4E4QYrwsso9uTEpOktmlUklSt8S/Q=; b=H0v1vztIlXOcj+FbNVovVSfxmS
        uLfgMVTH0Tki6M+t52HV7T8tsXMELFNbTc3nzcvA7RlIaoHnDJeegiil6v16jjibd/nQz/9L4qMJX
        wauTFprY5PTOrGaOSGSplXdDZUyQUHu/vGwbL5lwB5tGqmIzoNlOQ1NkmE70Gpmj03LNksO09AYX9
        SFNmhLnRr9IPKs7Y1KiMqzrJ5wiKkpi3BPbmThmETI5lrb9MWUwiO+Kfg/WLQK6+/mnmQlqbRTsnJ
        ySloYFH2oXHJLsYK4stG70OUmDEi48Tw/b30wioMj19hLgbrzLZAJZenJGrDWEFhh9qdIze1upjSW
        HO2SnzWQ==;
Received: from nat-wifi.fi.muni.cz ([147.251.43.9] helo=killbill.fi.muni.cz)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pqaT4-00ANVs-5O; Sun, 23 Apr 2023 16:13:30 +0200
From:   Melissa Wen <mwen@igalia.com>
To:     amd-gfx@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        sunpeng.li@amd.com, Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     Joshua Ashton <joshua@froggi.es>,
        Sebastian Wick <sebastian.wick@redhat.com>,
        Xaver Hugl <xaver.hugl@gmail.com>,
        Shashank Sharma <Shashank.Sharma@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sungjoon.kim@amd.com, Alex Hung <alex.hung@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 28/40] drm/amd/display: set sdr_ref_white_level to 80 for out_transfer_func
Date:   Sun, 23 Apr 2023 13:10:40 -0100
Message-Id: <20230423141051.702990-29-mwen@igalia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230423141051.702990-1-mwen@igalia.com>
References: <20230423141051.702990-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joshua Ashton <joshua@froggi.es>

Otherwise this is just initialized to 0.

This needs to actually have a value so that compute_curve can work
for PQ EOTF.

Signed-off-by: Joshua Ashton <joshua@froggi.es>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 55aa876a5008..6e7271065a56 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -323,6 +323,7 @@ static int amdgpu_dm_set_atomic_regamma(struct dc_stream_state *stream,
 		 */
 		stream->out_transfer_func->type = TF_TYPE_DISTRIBUTED_POINTS;
 		stream->out_transfer_func->tf = tf;
+		stream->out_transfer_func->sdr_ref_white_level = 80;
 
 		ret = __set_output_tf(stream->out_transfer_func,
 				      regamma_lut, regamma_size, has_rom);
-- 
2.39.2

