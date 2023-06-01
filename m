Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C1A71F500
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjFAVs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjFAVs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:48:27 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89291107
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:48:26 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d722dac08so56274b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 14:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685656106; x=1688248106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EE0EfDU+u9u4+ui1uHS92kS3GcLRsqU5zsR2pwsCo3A=;
        b=WEaxs8UwIO7EwC/BTfzutEb2uSeNq0jr0HNk4pRSoK779Y/EvUB2N3h6JqWrrbfcR4
         J9VdrgcVD9S0BAnpqkqVUthUpOsBQkjSfFfs1+pn6R4EMC2cUkE72AmC/O+uWoJedjv+
         ZAg3guMXwcyzco3vBuVFty98F/aL2Nmhf0yS5VIVgKC/YDhiKBP3MtfUsMTpbVo0jMok
         D3mX56z2yK3YXOfzY/aw7E1wHDD7y7fsQbhqDyqu4RfupdIf9ewV6trSc0rbUxT4FAod
         bpCxu4BQzGSsDpWpkpRsinnx6JJOcZvftKEJei1re13T0/yDNIO/w1zknCFST0JTCkLk
         PJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685656106; x=1688248106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EE0EfDU+u9u4+ui1uHS92kS3GcLRsqU5zsR2pwsCo3A=;
        b=Uz6J/TFYAd2RoUw57rJUoNvFC8SLUZq5ihrU8iruU6btb6/nLZtUGUtP0rQ/7Dcw3q
         QZPyTOqjt/WX0Qn/1+S9rB2RVOvZWV3ZY4ello5nkbdw+CN6wsiqNFiiwDN+KBlTbIOM
         hqmML6/3v2awg+wFYXR3U1IGrZQ2tReCf7ROfZGfpOJgEoeD8nBj5JqzbZ0KcqxtpHkX
         LI1aska7wv/MwYY/L3VmhO/GWy+4wqwVSX5sykM6eD8zHt/4nTyz8cz0jqRDb8ZdJDT4
         EojW/326MKmsrh3p0rmBPCycovwh9PhHiVDVnA3NAghsGItk5KeOovEMpuy6I9lcdRgt
         NNLQ==
X-Gm-Message-State: AC+VfDxewD5IumaxT8P3sG+df4ECjDD0HVf+u3/Sc3ILKTTVjaOHjN9s
        98QQwTntjm8dc/BHt590D7/ZRdUBnBW3EQ==
X-Google-Smtp-Source: ACHHUZ5xoaMF2HMTwWkn/jqMaSKTXJVeou8EUHzdO27JS9u25qqVrUjzfjUHLz1MWt6p/Gvfs7pCQw==
X-Received: by 2002:a05:6a00:99d:b0:652:a91c:558e with SMTP id u29-20020a056a00099d00b00652a91c558emr783245pfg.1.1685656105839;
        Thu, 01 Jun 2023 14:48:25 -0700 (PDT)
Received: from olv-ct-22.c.googlers.com.com (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with ESMTPSA id j15-20020aa783cf000000b0064d2ad04cccsm5614994pfn.175.2023.06.01.14.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 14:48:25 -0700 (PDT)
From:   Chia-I Wu <olvaffe@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix xclk freq on CHIP_STONEY
Date:   Thu,  1 Jun 2023 14:48:08 -0700
Message-ID: <20230601214814.2329224-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Alex, most APUs from that time seem to have the same issue
(vbios says 48Mhz, actual is 100Mhz).  I only have a CHIP_STONEY so I
limit the fixup to CHIP_STONEY
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 770f2d7a371fc..6a8494f98d3ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -542,8 +542,15 @@ static u32 vi_get_xclk(struct amdgpu_device *adev)
 	u32 reference_clock = adev->clock.spll.reference_freq;
 	u32 tmp;
 
-	if (adev->flags & AMD_IS_APU)
-		return reference_clock;
+	if (adev->flags & AMD_IS_APU) {
+		switch (adev->asic_type) {
+		case CHIP_STONEY:
+			/* vbios says 48Mhz, but the actual freq is 100Mhz */
+			return 10000;
+		default:
+			return reference_clock;
+		}
+	}
 
 	tmp = RREG32_SMC(ixCG_CLKPIN_CNTL_2);
 	if (REG_GET_FIELD(tmp, CG_CLKPIN_CNTL_2, MUX_TCLK_TO_XCLK))
-- 
2.41.0.rc0.172.g3f132b7071-goog

