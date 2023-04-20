Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CF26E9B43
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjDTSIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjDTSH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:07:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F2F1FC0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682014031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DAlGbmvVdWeoiiH06KOhyy0LizTfr2FfHgvUIIzCTWQ=;
        b=IdZuSO5gzrixsnJdo29THk7y98PHh1MV6I+RZlAvrNfzUP3gi8/t9qw2t4t7GGHROLG/MW
        7cSZeJ4Q6JBlm40vCbXgYvz3FH5/e1MjkDodCd+0xCRpzcB6XEtf1q1DXHUwrC53t8oJZD
        yuNGkLxzGu70N2KQhtu/2M5LBYIO6no=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-Ox_hxxYpMN-JsE7Sa0tq3A-1; Thu, 20 Apr 2023 14:07:10 -0400
X-MC-Unique: Ox_hxxYpMN-JsE7Sa0tq3A-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-74ab517c14bso419611485a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682014029; x=1684606029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAlGbmvVdWeoiiH06KOhyy0LizTfr2FfHgvUIIzCTWQ=;
        b=dQCyW6/iaqux2hB52hYtLfFr3RrugrePBBSojnLhi7CRhtNB8yGPCsVTirRB1Ulidb
         KmwdyEVphm6Snve+3boFLswLFrhPVbIYihl8QkBtf7kED28lMjmzFc8maqsGPJRDXXVa
         m6tp6NP3Xvl6C95/DJi7KjRinQvlIcrl/JurFagxDN1K9mhiqO1LSK+SJpZETL9V0IZD
         l1/lzqMX7zRjgHFBK+GOzQ8eUA9zRclC0XBjvSg75AAorZqW/8qq3/xkNox2/bMcxCMw
         936eDYePQGGDxxaL3yK6kWNkF/rIcdlkoVEqvlnQXILk3Tc0YCRhDT7imtNQxtVGO9y6
         Ku0g==
X-Gm-Message-State: AAQBX9cAOyU+A447+Au+wl+1ulLfWsraChb3DObHrmIcgLet6JKHjVRK
        7hS8JpkffRSDNMoGN3pc+2KJiYREQd2OhzvqeARle+QOBhEpsAE0Fi2NJJR6Jk011GJDhEd4O5O
        XknuE3BRYsTOpLZwp1/aeGZV3
X-Received: by 2002:ac8:5915:0:b0:3e4:e035:b5ae with SMTP id 21-20020ac85915000000b003e4e035b5aemr5802125qty.25.1682014029741;
        Thu, 20 Apr 2023 11:07:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350bZtoGbXr5zTKxwxJWHDlD+kzZVK9Rkj0Gg5y9VvHKOIKTnh6wcqzjG9aPwh50t9BtIPzm+YQ==
X-Received: by 2002:ac8:5915:0:b0:3e4:e035:b5ae with SMTP id 21-20020ac85915000000b003e4e035b5aemr5802089qty.25.1682014029490;
        Thu, 20 Apr 2023 11:07:09 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o17-20020a05620a111100b0074e00d6834esm602339qkk.81.2023.04.20.11.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 11:07:09 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        hamza.mahfooz@amd.com, drv@mailo.com, roman.li@amd.com,
        mairacanal@riseup.net, jiapeng.chong@linux.alibaba.com,
        caionovais@usp.br, gabe.teeger@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: remove unused variables dispclk_delay_subtotal and dout
Date:   Thu, 20 Apr 2023 14:07:05 -0400
Message-Id: <20230420180705.3893475-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
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

clang with W=1 reports
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_rq_dlg_calc_314.c:1003:15:
  error: variable 'dispclk_delay_subtotal' set but not used [-Werror,-Wunused-but-set-variable]
        unsigned int dispclk_delay_subtotal;
                     ^
This variable is not used, so remove it.
Which made dout unused, so also remove.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../display/dc/dml/dcn314/display_rq_dlg_calc_314.c    | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
index ea4eb66066c4..239cb8160c77 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
@@ -951,7 +951,6 @@ static void dml_rq_dlg_get_dlg_params(
 {
 	const display_pipe_source_params_st *src = &e2e_pipe_param[pipe_idx].pipe.src;
 	const display_pipe_dest_params_st *dst = &e2e_pipe_param[pipe_idx].pipe.dest;
-	const display_output_params_st *dout = &e2e_pipe_param[pipe_idx].dout;
 	const display_clocks_and_cfg_st *clks = &e2e_pipe_param[pipe_idx].clks_cfg;
 	const scaler_ratio_depth_st *scl = &e2e_pipe_param[pipe_idx].pipe.scale_ratio_depth;
 	const scaler_taps_st *taps = &e2e_pipe_param[pipe_idx].pipe.scale_taps;
@@ -1000,8 +999,6 @@ static void dml_rq_dlg_get_dlg_params(
 	unsigned int vupdate_width;
 	unsigned int vready_offset;
 
-	unsigned int dispclk_delay_subtotal;
-
 	unsigned int vstartup_start;
 	unsigned int dst_x_after_scaler;
 	unsigned int dst_y_after_scaler;
@@ -1127,13 +1124,6 @@ static void dml_rq_dlg_get_dlg_params(
 	vupdate_offset = dst->vupdate_offset;
 	vupdate_width = dst->vupdate_width;
 	vready_offset = dst->vready_offset;
-	dispclk_delay_subtotal = mode_lib->ip.dispclk_delay_subtotal;
-
-	if (dout->dsc_enable) {
-		double dsc_delay = get_dsc_delay(mode_lib, e2e_pipe_param, num_pipes, pipe_idx); // FROM VBA
-
-		dispclk_delay_subtotal += dsc_delay;
-	}
 
 	vstartup_start = dst->vstartup_start;
 	if (interlaced) {
-- 
2.27.0

