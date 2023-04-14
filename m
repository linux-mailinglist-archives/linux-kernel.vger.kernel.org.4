Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890DF6E22CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDNME5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDNMEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548ED127
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681473834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EzZmygZ/h6mW1KymHJQMpqqwuqkO8pIbZa2IhX1gPjg=;
        b=PRN+r0Cw6gQZD1k3JNd7yLB8PN9owFpOciTwwPt2V4Ub3VRvWNYTSLbzAxiox0GC2G/gUZ
        W2T9NMZtjRMZ0BKsGv8qsAak3At6M4mStrl/w2MZGZlhKaB1bxilFYlVBnDXmQ3j7anXA/
        TE5kbGjB4MXX0AJwhKFIoZn7XyBs6Fw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-Kk9Vv4H-M4Gyo4kHDTi6ww-1; Fri, 14 Apr 2023 08:03:53 -0400
X-MC-Unique: Kk9Vv4H-M4Gyo4kHDTi6ww-1
Received: by mail-qv1-f71.google.com with SMTP id q5-20020ad44025000000b005ef45791eb5so3099491qvp.19
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681473833; x=1684065833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EzZmygZ/h6mW1KymHJQMpqqwuqkO8pIbZa2IhX1gPjg=;
        b=DOVF+8EHezcnpmzOPxVn8T7q/bMeejiC91jClcjUnakWnVBnJAjZ31cjWDoWdtWOaM
         4ZaLau06Apov91qx1OCboCiWns1wGml6R/E7ztLwnX97DfE1EAWXzeQDFQwctBLtNe1Y
         +i2goncApCtL+aTbUCZm74XneKAEvpLiOs2iUnRvAIZSAWLwKCKx52TQxFW9WKvLhCFD
         w/njZg6KL3tN9cQT1qfW8tBJzIFuUhZz8nQlNrG9H8KOO3H4EJ/hz9jvQ0S34h9ximnL
         ROtwwURLuF6/bq/kQX7eEdkzLrLlhrcMe98TlTKB7yrZ6E28MCHUx32GOd1mUWO0PygS
         e+iQ==
X-Gm-Message-State: AAQBX9cdSBXxIwi9Q+/3TgBcZNgx/VvLOMDtGZXTS87LOoO9wbOiGDVb
        TaDlpT2F5Ciy/xBshO9IGqYi0Fjfus+yEkaCAAV4k2aLRkgr2R4X46ScmZm9cptYEn3cyHfMdmF
        liBz7X+q2aRdyqsfZIrsTsxXN
X-Received: by 2002:ac8:5f53:0:b0:3e3:8ee5:1629 with SMTP id y19-20020ac85f53000000b003e38ee51629mr7740978qta.51.1681473832734;
        Fri, 14 Apr 2023 05:03:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZD/j4DT8ikAl75WcXZCOLLsqk7WERFlQmI22J29ud9lx0mWwo6lSZErGjashkqixzZG9eJOw==
X-Received: by 2002:ac8:5f53:0:b0:3e3:8ee5:1629 with SMTP id y19-20020ac85f53000000b003e38ee51629mr7740944qta.51.1681473832463;
        Fri, 14 Apr 2023 05:03:52 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a084700b006fcb77f3bd6sm1168803qku.98.2023.04.14.05.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:03:52 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, Hawking.Zhang@amd.com, kenneth.feng@amd.com,
        tim.huang@amd.com, lijo.lazar@amd.com, mario.limonciello@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/pm: change pmfw_decoded_link_width,speed variables to globals
Date:   Fri, 14 Apr 2023 08:03:44 -0400
Message-Id: <20230414120344.3170942-1-trix@redhat.com>
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
In file included from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0.c:36:
./drivers/gpu/drm/amd/amdgpu/../pm/swsmu/inc/smu_v13_0.h:66:18: error:
  ‘pmfw_decoded_link_width’ defined but not used [-Werror=unused-const-variable=]
   66 | static const int pmfw_decoded_link_width[7] = {0, 1, 2, 4, 8, 12, 16};
      |                  ^~~~~~~~~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../pm/swsmu/inc/smu_v13_0.h:65:18: error:
  ‘pmfw_decoded_link_speed’ defined but not used [-Werror=unused-const-variable=]
   65 | static const int pmfw_decoded_link_speed[5] = {1, 2, 3, 4, 5};
      |                  ^~~~~~~~~~~~~~~~~~~~~~~

These variables are defined and used in smu_v13_0_7_ppt.c and smu_v13_0_0_ppt.c.
There should be only one definition.  So define the variables as globals
in smu_v13_0.c

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h   | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 7944ce80e5c3..df3baaab0037 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -62,8 +62,8 @@
 #define CTF_OFFSET_HOTSPOT		5
 #define CTF_OFFSET_MEM			5
 
-static const int pmfw_decoded_link_speed[5] = {1, 2, 3, 4, 5};
-static const int pmfw_decoded_link_width[7] = {0, 1, 2, 4, 8, 12, 16};
+extern const int pmfw_decoded_link_speed[5];
+extern const int pmfw_decoded_link_width[7];
 
 #define DECODE_GEN_SPEED(gen_speed_idx)		(pmfw_decoded_link_speed[gen_speed_idx])
 #define DECODE_LANE_WIDTH(lane_width_idx)	(pmfw_decoded_link_width[lane_width_idx])
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 73175c993da9..393c6a7b9609 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -85,6 +85,9 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_10.bin");
 static const int link_width[] = {0, 1, 2, 4, 8, 12, 16};
 static const int link_speed[] = {25, 50, 80, 160};
 
+const int pmfw_decoded_link_speed[5] = {1, 2, 3, 4, 5};
+const int pmfw_decoded_link_width[7] = {0, 1, 2, 4, 8, 12, 16};
+
 int smu_v13_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-- 
2.27.0

