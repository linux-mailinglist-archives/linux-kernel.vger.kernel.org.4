Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B806E95B7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjDTNWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDTNWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D8018D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681996894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pvqliZRx3bFZXXj3TRlgYVKcTGcdvhWSve5Bdh4PePw=;
        b=WoCnfBBE+P1k9rg8mPjvCY4fRjclPLf0tgGglaFnOXWVhzWXxzY1dp2ppB8Fakk8EpwPer
        qzCxktIY3XygTfVZaSRSp1X5a19Jc6oWFcMrtWDQf/hUxGP7jdRcyTR0OEdrwR4h2sRsRl
        iP78zajLav1nfa9+Um44YWGEfBY0FIs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-0crgVPyXNQCMnuJJ7q5ozg-1; Thu, 20 Apr 2023 09:21:33 -0400
X-MC-Unique: 0crgVPyXNQCMnuJJ7q5ozg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3ef566e9879so4949191cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681996893; x=1684588893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvqliZRx3bFZXXj3TRlgYVKcTGcdvhWSve5Bdh4PePw=;
        b=WA2+DXc/nznRVVPVZZPObUdqklTQuyOO1/xHI7mLvJGgNduCfnFBkloLmtOkYWJ/o9
         EADFH04BESD9kSHCNksAPjYM/1CbR65Ghf8mGkNiNrYi115ujUARNSJukhtu8ok2VP9L
         ZWiNoyXfYnH6dzWGk6V9xVEh0whCCSxCRm58VgI/CxmkgYJT0xRjF3I3pyDybs3I6q70
         VTHPOUeit0f+UwSUu6LQZZnMrRE30t3l+6BFO9ZL0ogl+wKnedOYqgitd7F6j3OQ8VkM
         RYdXx5qmTDoyFlUl1dNeXjoT5MZHURKK8mzFWCAkV1ucUX6XjGXaNdjnVHUyqwYQo+QV
         Hvhg==
X-Gm-Message-State: AAQBX9eAjAO0QJF9NCabvCPKH1mRLkQ829kNK4kTHZazAJf0bFvs1gPS
        4BX29LuyB4wjVArGSIdUUDau6PkHlSGGWtayIPQzn9M8jW9qmFfrhlMCdmsaoHPZj5ZhH56pD6a
        5fk2sK4kBoUVc+6gyuW/tSKgK
X-Received: by 2002:a05:622a:1:b0:3ef:38a2:9fdb with SMTP id x1-20020a05622a000100b003ef38a29fdbmr1373149qtw.60.1681996893053;
        Thu, 20 Apr 2023 06:21:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350auOzQ5hmP9e5U0LJ8lAJnmKf51VGzZATeBmsYh5r8XbqdU4pHx6XuM5qDCF95LyqUWmJx0nQ==
X-Received: by 2002:a05:622a:1:b0:3ef:38a2:9fdb with SMTP id x1-20020a05622a000100b003ef38a29fdbmr1373127qtw.60.1681996892824;
        Thu, 20 Apr 2023 06:21:32 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q2-20020a37f702000000b0074acdb873a7sm413158qkj.86.2023.04.20.06.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 06:21:32 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, Leon.Huang1@amd.com, wenjing.liu@amd.com,
        qingqing.zhuo@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: return status of abm_feature_support
Date:   Thu, 20 Apr 2023 09:21:29 -0400
Message-Id: <20230420132129.3888917-1-trix@redhat.com>
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

gcc with W=1 reports
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm.c:
  In function ‘dmub_abm_set_event_ex’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm.c:138:22: error: variable
  ‘feature_support’ set but not used [-Werror=unused-but-set-variable]
  138 |         unsigned int feature_support;
      |                      ^~~~~~~~~~~~~~~

This variable is not used so remove it.
The status of amb_feature_support should have been returned, so
set ret and return it.

Fixes: b8fe56375f78 ("drm/amd/display: Refactor ABM feature")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index a66f83a61402..8f285c3be4c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -134,10 +134,9 @@ static bool dmub_abm_set_pipe_ex(struct abm *abm, uint32_t otg_inst, uint32_t op
 static bool dmub_abm_set_event_ex(struct abm *abm, unsigned int full_screen, unsigned int video_mode,
 		unsigned int hdr_mode, unsigned int panel_inst)
 {
-	bool ret = false;
-	unsigned int feature_support;
+	bool ret;
 
-	feature_support = abm_feature_support(abm, panel_inst);
+	ret = abm_feature_support(abm, panel_inst);
 
 	return ret;
 }
-- 
2.27.0

