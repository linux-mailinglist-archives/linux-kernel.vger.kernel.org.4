Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930F56DA211
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbjDFT7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjDFT7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F35161BF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680811103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LRqwdTQMWkbHJObb62Qyqd5cmfrq+lMBU33zKFDK0cA=;
        b=gh6ByEpoqzOZIeDhLKH/Ko45rUYyftXw0sPa/lCUtrtLGlII4RD2XTuMZLs8PJwxFyEdYO
        yQ2I8tT5AK/bOc+i/JWVkCtJ1EE4Y+6K4xUBqlol+yom8v5Z4HuVZ6aOx1vLuCcpv6i9/n
        S2/dXRkPPnndxyW2mtwYyzqcOwe1pro=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512--h3AHq7qP5ue-xanUb10ew-1; Thu, 06 Apr 2023 15:58:22 -0400
X-MC-Unique: -h3AHq7qP5ue-xanUb10ew-1
Received: by mail-qt1-f197.google.com with SMTP id f2-20020ac87f02000000b003e6372b917dso15454211qtk.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680811101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRqwdTQMWkbHJObb62Qyqd5cmfrq+lMBU33zKFDK0cA=;
        b=tBL0CqrHTVV8BHSDtOydWTKroV0scFEPYgMFmXUaGa5QWNA+CbVS0rVNoGMBq1wsY1
         AHTPUEjZHitgMt2CcEMNjAca5Lx8MMrWIljbztsFnImA6t8c5yNIIDC2Gto/HQqCPu4S
         uxAgN0muHl++rDEHfFDdNpPFj3FkV8AqG1oTDgGk51/PqA/o1MmV0S0gKaofdCwlGg7P
         7PBmjGlk5KeO3XvqAtkJsXnWAqLQi4cHfDX8JBEE7khPjqK5I+tWXzy+SGxSDvVbBRdw
         uNOqoc1n4ADv39eeBvSy+JoufW233YRG5X8IxSNNCgVCsex2aC/TNHIcXuD6uSsZ1exE
         r0NQ==
X-Gm-Message-State: AAQBX9cXng1GJGssBq6IlekFMNU0+408vJhJ5rlqqclfXi3SQU8ANvey
        CqHY+P3uPnw7Myl2czX+BE6lsoJRZt9Jh6ty6jbVQdCgNOZgwORjjQZ+x7kMUPJV3B0ng3uivHP
        NmHsNzLUAIWbL5pPWkmsjYN+B
X-Received: by 2002:a05:6214:d88:b0:56f:52ba:ccf7 with SMTP id e8-20020a0562140d8800b0056f52baccf7mr731010qve.14.1680811101488;
        Thu, 06 Apr 2023 12:58:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zp+eBXfawoiv3Bq3fAJCCQ9Lkm2x6dWbrn6iRjoMte3WoDewQoxo6DwdNhkhrR4LeP5Aop1w==
X-Received: by 2002:a05:6214:d88:b0:56f:52ba:ccf7 with SMTP id e8-20020a0562140d8800b0056f52baccf7mr730984qve.14.1680811101252;
        Thu, 06 Apr 2023 12:58:21 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id mk21-20020a056214581500b005dd8b9345f0sm733097qvb.136.2023.04.06.12.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 12:58:20 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, Brian.Chang@amd.com, Martin.Leung@amd.com,
        David.Galiffi@amd.com, Ethan.Wellenreiter@amd.com,
        martin.tsai@amd.com, tales.aparecida@gmail.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: set variables aperture_default_system and context0_default_system storage-class-specifier to static
Date:   Thu,  6 Apr 2023 15:58:18 -0400
Message-Id: <20230406195818.1958162-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hubp.c:758:10: warning: symbol
  'aperture_default_system' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hubp.c:759:10: warning: symbol
  'context0_default_system' was not declared. Should it be static?

These variables are only used in one file so should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
index a142a00bc432..bf399819ca80 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
@@ -755,8 +755,8 @@ bool hubp1_is_flip_pending(struct hubp *hubp)
 	return false;
 }
 
-uint32_t aperture_default_system = 1;
-uint32_t context0_default_system; /* = 0;*/
+static uint32_t aperture_default_system = 1;
+static uint32_t context0_default_system; /* = 0;*/
 
 static void hubp1_set_vm_system_aperture_settings(struct hubp *hubp,
 		struct vm_system_aperture_param *apt)
-- 
2.27.0

