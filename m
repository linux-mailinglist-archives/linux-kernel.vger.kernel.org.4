Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A357767D6D4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjAZUup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjAZUuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:50:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEB76A76
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674766192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oGi4tyQZKR9EF1nkoMYIGWcX8cZ8bAVtY0RE3pjhZwE=;
        b=GKf/Nl3sfNlt4pVv9Mtpiex5uXBI9FwaoKY7lPzohEev5HuOJB0puBVcNLit9ei8Izmz6I
        GUEx6xuNrw4pKxLJZW++Yhqu7CLXC1UNlTKZN53KBlgg7TgyAMt/28wHmOFIAXtuuJilcv
        oEgkhsadb1Wnus2rTkeAeUZN/fGcCm4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-124-NS_wVxQqOFWPO4vgXE7RvQ-1; Thu, 26 Jan 2023 15:49:50 -0500
X-MC-Unique: NS_wVxQqOFWPO4vgXE7RvQ-1
Received: by mail-qv1-f72.google.com with SMTP id px22-20020a056214051600b00537657b0449so1714249qvb.23
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGi4tyQZKR9EF1nkoMYIGWcX8cZ8bAVtY0RE3pjhZwE=;
        b=ipFYKGpbH2ExKxRNFVJyFejGYQQEdP7RJRRfbKpHu83mI1j2hkSneIKZUsFnH6FLFX
         dRRNMYWFoKFEiUoc8+6ewXwgCpPSExVBMKwOyAuONKL4LkX4DHwLB2HgwDbTvY1OpKFq
         UNB8RZOlmRYU6X5Qz3A163sIsgbDqDVFeREreM6AQ6ReykoHu6T3IeT1lOEuQm9eond6
         Jkoc+BascE0plMc0QTQMcLTY4CWn4ejzPscKcHTgnq7RVwyLjXeG52GZuX0muimh1vhW
         CrrjaND11PTuxZ4/N++ThlbC2gsciEmYC1/DuP9pdKHqFSnhELPaUq8EBqzvKp/9a4pA
         iGVg==
X-Gm-Message-State: AO0yUKVfG1/zqOr7Vyuhhd3so94PgAyoY5cv1RJJDg0QtxpFnXXLvBXx
        zKWkaV34Gi8SnVpDmh0rHfFmEGfBy13xpnKN5IwsrreMgyoHcQtTLdI3CvMSfL2ryp9MZWzeZuc
        L2sB4qJdKb741fpFd6NNKH+9o
X-Received: by 2002:a05:6214:192c:b0:537:708d:3fef with SMTP id es12-20020a056214192c00b00537708d3fefmr11926904qvb.38.1674766190501;
        Thu, 26 Jan 2023 12:49:50 -0800 (PST)
X-Google-Smtp-Source: AK7set+ugItgaazXYqO9kQT722ufZwbkvuzBNI79A9vAf2gUEGkugVHZxtq7UGpUs+gPeO2hRZ5rIA==
X-Received: by 2002:a05:6214:192c:b0:537:708d:3fef with SMTP id es12-20020a056214192c00b00537708d3fefmr11926871qvb.38.1674766190258;
        Thu, 26 Jan 2023 12:49:50 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id b24-20020a05620a0f9800b006fafaac72a6sm1544573qkn.84.2023.01.26.12.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 12:49:49 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, jun.lei@amd.com, Alvin.Lee2@amd.com,
        Nevenko.Stupar@amd.com, Dillon.Varone@amd.com, george.shen@amd.com,
        rdunlap@infradead.org, David.Galiffi@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: reduce else-if to else in dcn32_calculate_dlg_params()
Date:   Thu, 26 Jan 2023 12:49:35 -0800
Message-Id: <20230126204935.819030-1-trix@redhat.com>
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

cppcheck reports
drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c:1403:76: style:
  Expression is always true because 'else if' condition is opposite to previous condition at line 1396. [multiCondition]
   } else if (context->res_ctx.pipe_ctx[i].stream->mall_stream_config.type == SUBVP_PHANTOM) {
                                                                           ^
drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c:1396:69: note: first condition
   if (context->res_ctx.pipe_ctx[i].stream->mall_stream_config.type != SUBVP_PHANTOM) {
                                                                    ^
drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c:1403:76: note: else if condition is opposite to first condition
   } else if (context->res_ctx.pipe_ctx[i].stream->mall_stream_config.type == SUBVP_PHANTOM) {

It is not necessary to explicitly the check != condition, an else is simplier.

Fixes: 238debcaebe4 ("drm/amd/display: Use DML for MALL SS and Subvp allocation calculations")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 0dc1a03999b6..c96cbd88e20d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1400,7 +1400,7 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 					/* SS PSR On: all active surfaces part of streams not supporting PSR stored in MALL */
 					context->bw_ctx.bw.dcn.mall_ss_psr_active_size_bytes += context->res_ctx.pipe_ctx[i].surface_size_in_mall_bytes;
 				}
-			} else if (context->res_ctx.pipe_ctx[i].stream->mall_stream_config.type == SUBVP_PHANTOM) {
+			} else {
 				/* SUBVP: phantom surfaces only stored in MALL */
 				context->bw_ctx.bw.dcn.mall_subvp_size_bytes += context->res_ctx.pipe_ctx[i].surface_size_in_mall_bytes;
 			}
-- 
2.26.3

