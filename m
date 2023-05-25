Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9652F711834
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241453AbjEYUgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjEYUgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59C9BB
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685046936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3mE/fckEZuR9c9fPTu4FUL0ylsLmFraWECVvvXZLruc=;
        b=TJbks6XtPBDD0hAfbaAHqUy2yGIsQDFIXcgB3iRKlWV9R6FR2lHTU1PH8CuMC+qpSXE5Oy
        bWMK//ZNyQVyh1wkhHcIfkiSbDtzXJ/OjfCaOH9hgk3V9HL/U6j7z7/87pQI85T+Ycw45Y
        cuR1IRint98JYJEFzrd8nl92g0k5vsM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-tUjEQHvROGqEkDwPfapU1w-1; Thu, 25 May 2023 16:35:34 -0400
X-MC-Unique: tUjEQHvROGqEkDwPfapU1w-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6238c64280fso2730476d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685046934; x=1687638934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mE/fckEZuR9c9fPTu4FUL0ylsLmFraWECVvvXZLruc=;
        b=ONuc3mWhzMzdY8cHIdi7HA7erxCoB/EBzuAbxTdShIEowWE7eEhZs8Lv2kPkygBZz8
         06pknkQPNOwcLn2Ku8xjPGzz2r/1cU+nl47LhlGZ9qs+99N6BJH7SRPi55dNZA9S5Drg
         PADLVjPEna3xbfsbjYcoEY6UG/rJqTksfcgQGhYvjNMZNnhbrDtHW2PPg6T8Ghl2TaAC
         QdM/wKh1SraZMX9b9AsWZp8/t8MdsbuPXFK8dKgBeH0d/LuVtUCpJRh14Y05bmIJhGnY
         5j3QYtgBgAegnGu1wL3pPFaooVj321JYYYCDDzAPq1jHYrBXj+7Gc0WpNK93YxWPNga6
         KOBQ==
X-Gm-Message-State: AC+VfDzksXDajzgv4F4xhHBNnfTyAVIShRiZfaYFb3lhyz9OZGWybGf+
        HEILDHjzBVzfONJsbv/1mCuxbh1rlePx6lwmqKlMLgOF6/KqhMKaHABBMXwSKLOR6UuYqEI2nYD
        KRIXKlO/js7CV7fYbulR+7KSw
X-Received: by 2002:a05:6214:e6e:b0:625:ccca:328b with SMTP id jz14-20020a0562140e6e00b00625ccca328bmr2860163qvb.19.1685046934272;
        Thu, 25 May 2023 13:35:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ45euEwzTp2G5RGMPSK3fbgDMQGjQu3VHUmMrVMif+hhFqBfdVa/ja2Hs14iGliwKoExaQfdA==
X-Received: by 2002:a05:6214:e6e:b0:625:ccca:328b with SMTP id jz14-20020a0562140e6e00b00625ccca328bmr2860132qvb.19.1685046934059;
        Thu, 25 May 2023 13:35:34 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a4-20020a05620a124400b0075b1c6f9628sm650389qkl.71.2023.05.25.13.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 13:35:33 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, le.ma@amd.com, jesse.zhang@amd.com,
        Jiadong.Zhu@amd.com, mario.limonciello@amd.com, Likun.Gao@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdgpu: move gfx9_cs_data definition
Date:   Thu, 25 May 2023 16:35:31 -0400
Message-Id: <20230525203531.3233040-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc with W=1 reports
In file included from drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:32:
drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h:939:36: error:
  ‘gfx9_cs_data’ defined but not used [-Werror=unused-const-variable=]
  939 | static const struct cs_section_def gfx9_cs_data[] = {
      |                                    ^~~~~~~~~~~~

gfx9_cs_data is only used in gfx_v9_0.c, so move its definition there.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h | 4 ----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h b/drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h
index 567a904804bc..6de4778789ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h
+++ b/drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h
@@ -936,7 +936,3 @@ static const struct cs_extent_def gfx9_SECT_CONTEXT_defs[] =
     {gfx9_SECT_CONTEXT_def_8, 0x0000a2f5, 155 },
     { 0, 0, 0 }
 };
-static const struct cs_section_def gfx9_cs_data[] = {
-    { gfx9_SECT_CONTEXT_defs, SECT_CONTEXT },
-    { 0, SECT_NONE }
-};
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 8bf95a6b0767..c97a68a39d93 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -56,6 +56,11 @@
 #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
 #include "asic_reg/gc/gc_9_0_default.h"
 
+static const struct cs_section_def gfx9_cs_data[] = {
+    { gfx9_SECT_CONTEXT_defs, SECT_CONTEXT },
+    { 0, SECT_NONE }
+};
+
 #define GFX9_NUM_GFX_RINGS     1
 #define GFX9_NUM_SW_GFX_RINGS  2
 #define GFX9_MEC_HPD_SIZE 4096
-- 
2.27.0

