Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547E25F966C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 03:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiJJBDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 21:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiJJBDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 21:03:00 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF77205CE
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 17:48:03 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r18so9063054pgr.12
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 17:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=b1IdFMAsFWWE5DfX4XR7dO8m7CmzOg+cTazbFUsdzyk=;
        b=YAXXSlZVKrpp5s11IEofCgqjlOxzLKiNl6J7yBu1bJ/lJVj6EpEmSp9+FdAVhg+4Bs
         rwLmW4YQ87dKk4gTf+IrBRVMhSiPKfypEacE2Fn+gWDtFSldhSgY3W6qfQqYV/eFqBVu
         HrFL7z9S3Is8oW5T3Z7C2+2Yd9AGnfsa2pBYLdap8ozcsOXFERUpUJDXVh/0QQ9Z8RBd
         Q+vV4Hyn/ODK03LWv0FLbdgzakp1v7tHvEi1Uxhzd6mf7uq9zvkucblYqoPbU3cIa46p
         GLeaWxAKotbwG6jM6OJZ4C+aVeKSJOGE2t/M+RxogTaa2FMXK18MXRJuzi/JyaZvXK3x
         /yfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1IdFMAsFWWE5DfX4XR7dO8m7CmzOg+cTazbFUsdzyk=;
        b=62pA5+yt7m0LD2MWdDSJ2XvPi3tL+EkhgX3eqRWeGi82H5QFgf3EJFhYaajl1HDhfd
         WdZkH2OjdyhxJP3PYeYDbV4s76ADMvID/vZIYCxqn4kNl2fuEE087H5giBk8rT8tHcCe
         xEGDiIa6+OkTE9cN4adR32Vr8yXJKNZxjlND3fNInzSE+IBcOEp6r8CxxQyz/rr7Kvh6
         +28tlbaZ4d5xfmNdQRAqtkyncKHnJYgUMGUlg7qcor7bwUDv/v/5NR18R9muMAvbY1eh
         cjdlMMighdokvetTdHDIP1niP8iUHwwUhe/ChNBfWnLsE7wOMtyTaR/LEg7kTR4PE8fs
         qj2A==
X-Gm-Message-State: ACrzQf2OyahzejlmZYjucFfQxXcK/S7jdIQikjnLTbCMh2QQAk4ntzJx
        sd/dAr47jKclt1TpeW4gOwscOg==
X-Google-Smtp-Source: AMsMyM6Idd60TBNk5F6K9oYeBS+wWXBfmwdsPd3JoJfR9ZOG7HWoK+tcxai8X3nWCbuJTLdbbQMUHg==
X-Received: by 2002:a63:441b:0:b0:439:103b:25a4 with SMTP id r27-20020a63441b000000b00439103b25a4mr14169869pga.487.1665362876908;
        Sun, 09 Oct 2022 17:47:56 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id y13-20020aa78f2d000000b00561e46ebf7dsm5498804pfr.216.2022.10.09.17.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 17:47:56 -0700 (PDT)
Subject: [PATCH] drm/amd/display: fix another array-bounds error in dc_stream_remove_writeback()
Date:   Sun,  9 Oct 2022 17:47:36 -0700
Message-Id: <20221010004736.17170-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Alvin.Lee2@amd.com, aurabindo.pillai@amd.com,
        Pavle.Kotarac@amd.com, alex.hung@amd.com,
        Palmer Dabbelt <palmer@rivosinc.com>, Jimmy.Kizito@amd.com,
        hersenwu@amd.com, hanghong.ma@amd.com, paul.hsieh@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux@rivosinc.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     alexander.deucher@amd.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

Without this I get some warnings.  I get the following with GCC 11:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c: In function ‘dc_stream_remove_writeback’:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:527:83: warning: array subscript 1 is above array bounds of ‘struct dc_writeback_info[1]’ [-Warray-bounds]
  527 |                                 stream->writeback_info[j] = stream->writeback_info[i];
      |                                                             ~~~~~~~~~~~~~~~~~~~~~~^~~
In file included from ./drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:1269,
                 from ./drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:29,
                 from ./drivers/gpu/drm/amd/amdgpu/../display/dc/basics/dc_common.h:29,
                 from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:27:
./drivers/gpu/drm/amd/amdgpu/../display/dc/dc_stream.h:241:34: note: while referencing ‘writeback_info’
  241 |         struct dc_writeback_info writeback_info[MAX_DWB_PIPES];
      |                                  ^~~~~~~~~~~~~~

and something slightly different with GCC 12:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c: In function 'dc_stream_remove_writeback':
rivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:527:83: error: array subscript [0, 0] is outside array bounds of 'struct dc_writeback_info[1]' [-Werror=array-bounds]
  527 |                                 stream->writeback_info[j] = stream->writeback_info[i];
      |                                                             ~~~~~~~~~~~~~~~~~~~~~~^~~
In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:1269,
                 from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:29,
                 from drivers/gpu/drm/amd/amdgpu/../display/dc/basics/dc_common.h:29,
                 from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:27:
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_stream.h:241:34: note: while referencing 'writeback_info'
  241 |         struct dc_writeback_info writeback_info[MAX_DWB_PIPES];
      |                                  ^~~~~~~~~~~~~~

This fixes both warnings for me.

I'm not sure how sane it is, as MAX_DWB_PIPES is 1 so the loop now
doesn't do anything: i and j are both 0, so they're always equal, so no
trimming is ever done.  IIUC that was the case before, though, as the
only way this could trigger would result in an out of bounds array
access.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index ae13887756bf..b64cef17afba 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -520,7 +520,7 @@ bool dc_stream_remove_writeback(struct dc *dc,
 	}
 
 	/* remove writeback info for disabled writeback pipes from stream */
-	for (i = 0, j = 0; i < stream->num_wb_info && j < MAX_DWB_PIPES; i++) {
+	for (i = 0, j = 0; i < stream->num_wb_info && i < MAX_DWB_PIPES && j < MAX_DWB_PIPES; i++) {
 		if (stream->writeback_info[i].wb_enabled) {
 			if (i != j)
 				/* trim the array */
-- 
2.34.1

