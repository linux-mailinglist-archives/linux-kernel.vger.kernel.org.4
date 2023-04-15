Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3E16E3213
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 17:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjDOPS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDOPS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 11:18:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15F9448B
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681571859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q5M14rzEqBNgFK8HU9Akt9HYXKL8QNDYAZuFGTil5ww=;
        b=W/tlfb8hP4DT+wc3QbwtkPV4YJHniQg5N8DGRAV+ZHTtcZzNHfmEvAzzjuWkrvx3E5cjAv
        /WJOVF3muqKzgkVF1gQowE4DSK46xKTiPegJ7WMrrtO4jBvMhcCNxtf8jPJ3Rr5TqWrqDZ
        VuzMunNdN+aLMhnJ06ZpUdk53qsubqs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-pTpLZe6qMdutmDGvUCVwCw-1; Sat, 15 Apr 2023 11:17:32 -0400
X-MC-Unique: pTpLZe6qMdutmDGvUCVwCw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-2f6d4e7faabso121972f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 08:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681571851; x=1684163851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5M14rzEqBNgFK8HU9Akt9HYXKL8QNDYAZuFGTil5ww=;
        b=S/vYiVQWdyinB6v+9lHePMXpCLy8AAbMODfeIbHUOo6D094nC9Gaa7Saey/tQpAoTe
         sMtVOO45dfPCemIkQZ8ErNAGqFxdLE3lAuxbPlyq+DPqDxRFHcfSnLupeqNc6pduOdXB
         sE+QYl9S8gTgMq6PD3X1j79XWrg8Lr2Bo0k/SZwAopl0S54LWnrB/ejEvb++7WkKsbDD
         FmvdFMJJM3ekQrEQqwnjlZfYefU+iwAIn5Cve9wtxva9re3p26F/Ls5qlPqK99xqq2df
         GrL4kJbxLdSq4x2nfLQjEW7Z+ydyjKhZ2DVb07EObUu6PHF1IlvBBoNE43R+BM8Xz1Le
         o0pQ==
X-Gm-Message-State: AAQBX9eRwqNQqS2EgupJIT5hEYD+VAH3t2/nSsD+l7Es1qywyFhJ0SYB
        tSQMQrjw12dI1lMF9W4/urK9EzSZi7I+odyPuyLS5yt1XiwQOouAXpszXMDT42NnUcCT0BYXxNO
        h0rl9s3geQ2M3z1F5CMiQlKbU
X-Received: by 2002:a5d:5248:0:b0:2f9:a75:b854 with SMTP id k8-20020a5d5248000000b002f90a75b854mr479317wrc.59.1681571851275;
        Sat, 15 Apr 2023 08:17:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZiVk0AFMX3CN+Ea1tpGa+ZETudf89c2CORBo70Q1fyjzBSsB+LBm6h3/+QEZQTcBxaKCvJSg==
X-Received: by 2002:a5d:5248:0:b0:2f9:a75:b854 with SMTP id k8-20020a5d5248000000b002f90a75b854mr479290wrc.59.1681571850835;
        Sat, 15 Apr 2023 08:17:30 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m13-20020adffe4d000000b002efb139ce72sm5953488wrs.36.2023.04.15.08.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 08:17:30 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nicholas.kazlauskas@amd.com, Syed.Hassan@amd.com,
        jdhillon@amd.com, alex.hung@amd.com, michael.strauss@amd.com,
        aurabindo.pillai@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: set variable dccg314_init storage-class-specifier to static
Date:   Sat, 15 Apr 2023 11:17:22 -0400
Message-Id: <20230415151722.3188010-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
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

smatch reports
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_dccg.c:277:6: warning: symbol
  'dccg314_init' was not declared. Should it be static?

This variable is only used in one file so should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index 6f879265ad9c..de7bfba2c179 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -274,7 +274,7 @@ static void dccg314_set_dpstreamclk(
 	}
 }
 
-void dccg314_init(struct dccg *dccg)
+static void dccg314_init(struct dccg *dccg)
 {
 	int otg_inst;
 
-- 
2.27.0

