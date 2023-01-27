Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F0A67DB55
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 02:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjA0BjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 20:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjA0BjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 20:39:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275AB2BF1D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 17:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674783513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZaWLbVYYzGv21vJO7aGswdiJnWhUW0nGAziQI0ZtQyY=;
        b=S0P+IxKyZStepI2KiUShdy45E4s/vXJX3mMr/80DDYKX7rilHtFiF1gunWyVkI8Nenrtvq
        VBKlNDPPKmjpvDoWs+zXDzCHM69chytiBgql/jbyiCQBlIHTZEluRsMl3R8CUY2GHfas5R
        pnFDYTFHgPAtbga4oqoMC8Xmf5runDQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-643-zoDgEvd4M9qRryqFsr1fxQ-1; Thu, 26 Jan 2023 20:38:32 -0500
X-MC-Unique: zoDgEvd4M9qRryqFsr1fxQ-1
Received: by mail-qt1-f198.google.com with SMTP id br26-20020a05622a1e1a00b003b62dc86831so1603180qtb.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 17:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZaWLbVYYzGv21vJO7aGswdiJnWhUW0nGAziQI0ZtQyY=;
        b=QzxU8ArwHw8xct0aTUKOYxHY3q1cWhebBHS4zHXTwzmb8hLtbPzptsQDWRomuqVPcF
         fR4CumoXPLjPUuY8qNOD8BqOef0h8nZ1T72f8vKpK9ATS9ERriq7G38DG50DWk/0Dhwt
         QMcemHHeuzickwqnqSMSh8eNTjjunflus6iE0t1Jq0ikTQmkHXB7kP20B1fH0xeYsDdN
         X/Hbalh3YMkgaWsb5H6rMvXdcoSuqKRbQbA2NLD0x0qYMh7on6jOV+gsGSZT6Ot+Nrgd
         fLJluOG3kp2ki/3LmjFq1cK9Ef7b7Tb/NJ988PhYKoWFZSEst/YiTNtbmxbPlRo3DoES
         utgQ==
X-Gm-Message-State: AFqh2ko+2xMvaoVLQLRLEZIvx2ebfYGgYMmGIBN8NU4w33xDb3l1G3nU
        v9CJddU6MM7wqp+gg7NbwfbOLTrtxjgIuZWUp7HuLARTZ1KoXx0wHhYiO9BpepAGHxKlXxrNldh
        mh/29yKdY5KYdsbDfgD8H1VCQ
X-Received: by 2002:a05:6214:e8e:b0:4ed:fb72:9186 with SMTP id hf14-20020a0562140e8e00b004edfb729186mr82795448qvb.0.1674783511652;
        Thu, 26 Jan 2023 17:38:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvj0I8ZKFown/tFr5t6mdJxPm3gmzyISiA4AAWzoztipBf2zfexnkIA+fwENP+IzIKg1Fl40g==
X-Received: by 2002:a05:6214:e8e:b0:4ed:fb72:9186 with SMTP id hf14-20020a0562140e8e00b004edfb729186mr82795411qvb.0.1674783511392;
        Thu, 26 Jan 2023 17:38:31 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id dm30-20020a05620a1d5e00b00704a2a40cf2sm2013364qkb.38.2023.01.26.17.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 17:38:30 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, Anthony.Koo@amd.com, alex.hung@amd.com,
        aurabindo.pillai@amd.com, Roman.Li@amd.com, wenjing.liu@amd.com,
        Dillon.Varone@amd.com, mwen@igalia.com, dingchen.zhang@amd.com,
        martin.tsai@amd.com, aric.cyr@amd.com, Wesley.Chalmers@amd.com,
        Max.Tseng@amd.com, sivapiriyan.kumarasamy@amd.com,
        Tony.Cheng@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: reduce else-if to else in dcn10_blank_pixel_data()
Date:   Thu, 26 Jan 2023 17:38:23 -0800
Message-Id: <20230127013823.832698-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
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

checkpatch reports
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c:2902:13: style:
  Expression is always true because 'else if' condition is opposite to previous condition at line 2895. [multiCondition]
 } else if (blank) {
            ^
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c:2895:6: note: first condition
 if (!blank) {
     ^
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c:2902:13: note: else if condition is opposite to first condition
 } else if (blank) {

It is not necessary to explicitly the check != condition, an else is simplier.

Fixes: aa5a57773042 ("drm/amd/display: Vari-bright looks disabled near end of MM14")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index bb155734ac93..f735ae5e045f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2899,7 +2899,7 @@ void dcn10_blank_pixel_data(
 			dc->hwss.set_pipe(pipe_ctx);
 			stream_res->abm->funcs->set_abm_level(stream_res->abm, stream->abm_level);
 		}
-	} else if (blank) {
+	} else {
 		dc->hwss.set_abm_immediate_disable(pipe_ctx);
 		if (stream_res->tg->funcs->set_blank) {
 			stream_res->tg->funcs->wait_for_state(stream_res->tg, CRTC_STATE_VBLANK);
-- 
2.26.3

