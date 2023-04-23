Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD4D6EC03F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjDWOOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjDWOO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:14:29 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF772D74
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZM4LRZ9R6oIPI6RNCnBj4XwAXqnDA6bTH1zIbaUH8Yk=; b=McvxyZbQR5ieSvLdcLtNnFAKYm
        xjAPptQxeLwrZVayHfVbBgABTGy+H8RtSJ7n+XENAMP64aHoNzX41hIYxJOEKV3BQWd/MM8qA+daH
        /vf4d91eWbUSclLJAwBIbNDLdhB1fyOAFOwPjTXFqZajrYc5w5GWocunQDs31V61gWE7hloR5jiJY
        rMbdDkVnSnRSE3R/rDHZ7FYPOXJRlK/MP9AAI2HcXcaaHyl1ngRC7J+K7wZu8UwynRsy+3IJMbxVy
        Bw3cRWS6hjkiC4wg2reOfwYHO1du36GeAmFMYOkUZ37R4QTIzOq8clCrmO2g9FKDvsPdbLZT3aTua
        o04joJww==;
Received: from nat-wifi.fi.muni.cz ([147.251.43.9] helo=killbill.fi.muni.cz)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pqaSa-00ANVs-1Q; Sun, 23 Apr 2023 16:13:00 +0200
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
        Melissa Wen <mwen@igalia.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 19/40] drm/amd/display: update lut3d and shaper lut to stream
Date:   Sun, 23 Apr 2023 13:10:31 -0100
Message-Id: <20230423141051.702990-20-mwen@igalia.com>
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

It follows the same path of out_transfer_func for stream updates, since
shaper LUT and 3D LUT is programmed in funcs.set_output_transfer_func()
and this function is called in the atomic commit_tail when
update_flags.bits.out_tf is set.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e65ba87ee2c5..9230c122d77e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2581,7 +2581,7 @@ static enum surface_update_type check_update_surfaces_for_stream(
 			stream_update->integer_scaling_update)
 			su_flags->bits.scaling = 1;
 
-		if (stream_update->out_transfer_func)
+		if (stream_update->out_transfer_func || stream_update->lut3d_func)
 			su_flags->bits.out_tf = 1;
 
 		if (stream_update->abm_level)
@@ -2936,6 +2936,14 @@ static void copy_stream_update_to_stream(struct dc *dc,
 		       sizeof(struct dc_transfer_func_distributed_points));
 	}
 
+	if (update->func_shaper &&
+	    stream->func_shaper != update->func_shaper)
+		stream->func_shaper = update->func_shaper;
+
+	if (update->lut3d_func &&
+	    stream->lut3d_func != update->lut3d_func)
+		stream->lut3d_func = update->lut3d_func;
+
 	if (update->hdr_static_metadata)
 		stream->hdr_static_metadata = *update->hdr_static_metadata;
 
-- 
2.39.2

