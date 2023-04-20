Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EEB6E9676
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjDTN77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjDTN75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACE710DC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681999146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=m4/JuEsZscBS1QEjsB4TfQCsUwFo0JrhZtOzYqZKIzY=;
        b=FkDwRI9riU3gqUI/siICUB8tBA0mcKXRPB7GVCSqGoawFBG29zFUKPmjst1bWX21GYlza1
        pbJ71+H4pqCJrb5izMl2C759pIxfra6ywDd1c2UqzkLQo4mHmOhSmSSIHtBlIDG7Jg55+P
        yrr+wgzvWH7vhy1Q1ON3A/bqGrtQc9o=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-83Iu-T3COqKq_lrNkVWCCg-1; Thu, 20 Apr 2023 09:59:05 -0400
X-MC-Unique: 83Iu-T3COqKq_lrNkVWCCg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-74e04fcc695so58177585a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681999145; x=1684591145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4/JuEsZscBS1QEjsB4TfQCsUwFo0JrhZtOzYqZKIzY=;
        b=WxxfgUNXNrbSfJUXVNFkcl23IGG1EtvhrYteXl1Eq6ACgXsEovCirxoYJ7CTDP6S+G
         5MP/xVE8yv8ND08QtfKbSs9/uQfDQhSFkoVkhOlMRSkPhV2j0itimQ8LUI242MQrT+ym
         Mp1FdNLh+UJLpC0nBvZUnmgMK12HYg4sqCgS7GMPtWKFfisZlZtTqdeF5JgswNqlSqmI
         ++tFIPcgzUw69vzmPlFush+Eg4H76vgHFCgS7qnXsV/KaTeIcOC0xGnTw5eEQqrdpS8z
         3RzorbjTXcj46XSbELdvJpZGsDxNhcrXkPJZNb+N2lr2YegVW0BTwHmjAEbEDrBXE2oe
         /cpA==
X-Gm-Message-State: AAQBX9e4zKViCaSB1GN1JqscsU0ezcgNc/Vv4OXzGsu9VykP5vGIeZXT
        KAox4A6ZhDRKS0Zr8NBTvbr1E9K4u/TnwJNEAtvte7YrBAye74RkAIIXilHtdZ5iydoGpYGKYdh
        XuGXE1UFrYuyvuXMDT8FIWsU4
X-Received: by 2002:a05:622a:18a9:b0:3e6:35ec:8a9f with SMTP id v41-20020a05622a18a900b003e635ec8a9fmr2276770qtc.59.1681999145134;
        Thu, 20 Apr 2023 06:59:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZWmwkSKjotOboNJvMVMnZ/90aKxEW+jnR3KliISrG82OxoHSKFPujRz0mheXYNaiH8sWDnrA==
X-Received: by 2002:a05:622a:18a9:b0:3e6:35ec:8a9f with SMTP id v41-20020a05622a18a900b003e635ec8a9fmr2276737qtc.59.1681999144890;
        Thu, 20 Apr 2023 06:59:04 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z42-20020a05620a262a00b00745f3200f54sm430905qko.112.2023.04.20.06.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 06:59:04 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, Alvin.Lee2@amd.com, Jun.Lei@amd.com,
        qingqing.zhuo@amd.com, Max.Tseng@amd.com, Josip.Pavic@amd.com,
        Eric.Yang2@amd.com, aurabindo.pillai@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: return status of dmub_srv_get_fw_boot_status
Date:   Thu, 20 Apr 2023 09:59:01 -0400
Message-Id: <20230420135901.3889747-1-trix@redhat.com>
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
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:
  In function ‘dc_dmub_srv_optimized_init_done’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:184:26:
  error: variable ‘dmub’ set but not used [-Werror=unused-but-set-variable]
  184 |         struct dmub_srv *dmub;
      |                          ^~~~

The return status is never set.
It looks like a call to dmub_srv_get_fw_boot_status is missing.

Fixes: 499e4b1c722e ("drm/amd/display: add mechanism to skip DCN init")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index d15ec32243e2..36d936ab4300 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -182,14 +182,23 @@ bool dc_dmub_srv_cmd_run_list(struct dc_dmub_srv *dc_dmub_srv, unsigned int coun
 bool dc_dmub_srv_optimized_init_done(struct dc_dmub_srv *dc_dmub_srv)
 {
 	struct dmub_srv *dmub;
-	union dmub_fw_boot_status status;
+	struct dc_context *dc_ctx;
+	union dmub_fw_boot_status boot_status;
+	enum dmub_status status;
 
 	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
 		return false;
 
 	dmub = dc_dmub_srv->dmub;
+	dc_ctx = dc_dmub_srv->ctx;
+
+	status = dmub_srv_get_fw_boot_status(dmub, &boot_status);
+	if (status != DMUB_STATUS_OK) {
+		DC_ERROR("Error querying DMUB boot status: error=%d\n", status);
+		return false;
+	}
 
-	return status.bits.optimized_init_done;
+	return boot_status.bits.optimized_init_done;
 }
 
 bool dc_dmub_srv_notify_stream_mask(struct dc_dmub_srv *dc_dmub_srv,
-- 
2.27.0

