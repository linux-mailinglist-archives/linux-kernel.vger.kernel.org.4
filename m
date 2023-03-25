Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DCC6C8EA1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCYNqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCYNqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:46:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAD8125AB
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 06:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679751908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CA7h/KT6ar6s3WSm/PcPsckHI4JxnLRkTxYhhO4xj4k=;
        b=MWBMm6KR749nnm1mC0XzCkmKYGsvH5C5N9ULOrWBOVtl+3qZCIKVzAFICpkXN4p5oaxx0V
        lGsrwUmJKoIr1CcNMgma5uqksQHidmmaADoKzdtwKfMNpgTe4UyjcSHvodv9oCT5JidDbV
        jQqWA3do9qEAbqxpkdKPNjNa0yk13Pc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-ZeduFHGWOzWUrcJJ4H1h0w-1; Sat, 25 Mar 2023 09:45:07 -0400
X-MC-Unique: ZeduFHGWOzWUrcJJ4H1h0w-1
Received: by mail-qt1-f198.google.com with SMTP id b11-20020ac87fcb000000b003e37d72d532so2794232qtk.18
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 06:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679751907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CA7h/KT6ar6s3WSm/PcPsckHI4JxnLRkTxYhhO4xj4k=;
        b=iWhV/YrIli1zU8XpZahj0cz/gYlYlS/RdHszR8AG8eEWtg3+1+ckSe+DVXSBLDC7EQ
         oZnCeA8QAHBuMu3xtDQuyWlx3CV9B8bd3tlIBoYIXFqUEJppdRvPWmnxT8Gig9qoBUJP
         93dROP3MQhpkK3vXi0GBIlVxNyFJZBVFPP8HpFWB1K/g6RPYEwedVuj8jMo/h+jcjOtB
         MF30aDPKP1UPvma5regGHAsbYfpzj3wwJq1XMfuKRlngfy74yOUO1+n52rNk2cTFw2Bv
         6PjXU/vyenUEN2TomkmYvzDg5X1yQNeKYzcrzO93/JlOBzUbjsEcfDdMC2lph0Z1pcV7
         3Zlw==
X-Gm-Message-State: AO0yUKUpWZrde4aAJq18zaRO5zJVw60S4KynoZWG8yV3S1B+GpiuUGKj
        XQ4BkVMmwWS5DRRvkygg1t5i+eawb+ZnXDnzrii7DnxpgL03KE3Vo6eIl4dVoki+OoJs2zX1NeU
        iehubnBo/bZ0t0xP7AdGu1ywt
X-Received: by 2002:a05:622a:647:b0:3e3:9948:98d1 with SMTP id a7-20020a05622a064700b003e3994898d1mr10992011qtb.38.1679751907344;
        Sat, 25 Mar 2023 06:45:07 -0700 (PDT)
X-Google-Smtp-Source: AK7set9lBadmzaW3R6GBzpZCCcrV/q81u7BWSsClYIuBO79n0CA6GzW3uhjcVgbc5HCJD7hhViJ7VQ==
X-Received: by 2002:a05:622a:647:b0:3e3:9948:98d1 with SMTP id a7-20020a05622a064700b003e3994898d1mr10991982qtb.38.1679751907150;
        Sat, 25 Mar 2023 06:45:07 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h23-20020ac85497000000b003e3927a2cd8sm2528739qtq.3.2023.03.25.06.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 06:45:06 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        Jun.Lei@amd.com, wenjing.liu@amd.com, Jimmy.Kizito@amd.com,
        Cruise.Hung@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: remove unused matching_stream_ptrs variable
Date:   Sat, 25 Mar 2023 09:45:03 -0400
Message-Id: <20230325134503.1335510-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_PDS_OTHER_BAD_TLD
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_enc_cfg.c:625:6: error:
  variable 'matching_stream_ptrs' set but not used [-Werror,-Wunused-but-set-variable]
        int matching_stream_ptrs = 0;
            ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 41198c729d90..30c0644d4418 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -622,7 +622,6 @@ bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state)
 	int i, j;
 	uint8_t valid_count = 0;
 	uint8_t dig_stream_count = 0;
-	int matching_stream_ptrs = 0;
 	int eng_ids_per_ep_id[MAX_PIPES] = {0};
 	int ep_ids_per_eng_id[MAX_PIPES] = {0};
 	int valid_bitmap = 0;
@@ -645,9 +644,7 @@ bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state)
 		struct link_enc_assignment assignment = state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
 
 		if (assignment.valid) {
-			if (assignment.stream == state->streams[i])
-				matching_stream_ptrs++;
-			else
+			if (assignment.stream != state->streams[i])
 				valid_stream_ptrs = false;
 		}
 	}
-- 
2.27.0

