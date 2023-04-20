Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8F86E87CE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 04:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjDTCFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 22:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjDTCFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 22:05:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C37F3A9E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 19:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681956267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3DmHTzBBosn4V3T229BK2WXwwGVza+mxkwM7dlmK1v0=;
        b=AcpGCNeBs8HmPcaLm2aS5WR1lxaKHNtSykqgp6yKajsdhHDN+UEMUrEd7v4il2RPAIl4yW
        pyLi4idewnywlosOEeV7RNaMoP2M5h3NdTq25Ca4Yc3hZ3vRkudwCvxyDQko5ROlHgSr5U
        qD+MdJAYjhPlB48RFSfQmFxzimvJNUI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-5zjm-xagP32BJUJSOHs6gA-1; Wed, 19 Apr 2023 22:04:26 -0400
X-MC-Unique: 5zjm-xagP32BJUJSOHs6gA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3e6a9ef3e09so2852711cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 19:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681956266; x=1684548266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DmHTzBBosn4V3T229BK2WXwwGVza+mxkwM7dlmK1v0=;
        b=ac6ev/OXOtEUKME5qeVyW4eBuGjUAF0PNBXfADxDBa7aAgfW7HoIf5A4xAQsjCxrXy
         +EX4Jy3YFMOdZBnNKlWAKSxLDxtO3qbJLCDGFhmgmUdMKsqa2dWx4n9EQbNS7i97bW0v
         RYuW4PmOQVkkLyhMbItaK9h/crmF/WWfgrshryWCelQHSuOw2yVNFyn4p8EdS5WL84K1
         T9Nb8KnSB/3oFik8/MuBoNB+WHVeybinArP+SSyzyQNDLCZqxQG5mFtTe6aKBWn32AIt
         DTVfFhn8wLQyR9vGcL9mwRsJa/utnlvszcSAwexhAVPWF4Zkzn7EWSv42sm507o2ug+P
         nTiA==
X-Gm-Message-State: AAQBX9faSDhPj33S98UH58hItp8VzqbFeqTcESE9wUic9xTTHXUk/IPS
        f1+BpEf6VpN7RXoXi9Ubhyn47qIKERy9EehcaSpzoOzjQ56SmDyCDh25kvdoDr0qBQc3oTxOg4h
        YVYO094e6lu9HT3ef9rSNOhs9
X-Received: by 2002:a05:622a:1a90:b0:3e4:ee15:ad44 with SMTP id s16-20020a05622a1a9000b003e4ee15ad44mr1262260qtc.31.1681956266005;
        Wed, 19 Apr 2023 19:04:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350YeuDz5Dp3h9GRFwpofcuw/paRA8u3EMOKlcRyxTl5AAfb6gcJc36XIOwa+mFTFL6PBsRFbLA==
X-Received: by 2002:a05:622a:1a90:b0:3e4:ee15:ad44 with SMTP id s16-20020a05622a1a9000b003e4ee15ad44mr1262228qtc.31.1681956265646;
        Wed, 19 Apr 2023 19:04:25 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w14-20020a05620a094e00b0074e21136a77sm69826qkw.127.2023.04.19.19.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 19:04:25 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, qingqing.zhuo@amd.com, wenjing.liu@amd.com,
        Jun.Lei@amd.com, Josip.Pavic@amd.com, Leon.Huang1@amd.com,
        Nicholas.Kazlauskas@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: remove unused variables otg_inst and cmd
Date:   Wed, 19 Apr 2023 22:04:22 -0400
Message-Id: <20230420020422.3256782-1-trix@redhat.com>
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

gcc reports
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hwseq.c:
  In function ‘dcn21_set_backlight_level’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hwseq.c:229:18:
  error: unused variable ‘otg_inst’ [-Werror=unused-variable]
  229 |         uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
      |                  ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hwseq.c:226:27:
  error: unused variable ‘cmd’ [-Werror=unused-variable]
  226 |         union dmub_rb_cmd cmd;
      |                           ^~~

These variables are not used, so remove them.

Fixes: e97cc04fe0fb ("drm/amd/display: refactor dmub commands into single function")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
index 55a464a39529..43463d08f21b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
@@ -223,10 +223,8 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 		uint32_t backlight_pwm_u16_16,
 		uint32_t frame_ramp)
 {
-	union dmub_rb_cmd cmd;
 	struct dc_context *dc = pipe_ctx->stream->ctx;
 	struct abm *abm = pipe_ctx->stream_res.abm;
-	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
 
 	if (dc->dc->res_pool->dmcu) {
-- 
2.27.0

