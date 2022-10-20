Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C8B605C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiJTK0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiJTKZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:25:40 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D573ECE1;
        Thu, 20 Oct 2022 03:24:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so1960437wma.3;
        Thu, 20 Oct 2022 03:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=338ew+i7lhPhhsRwFXebT4YiHgbE5e7sWqj7Y/pRaLI=;
        b=pb8WX3HWaEJ0WTcDPURYIIYexJdp7jutkc+9DRribLrBrMheWwvoPTL69Kp3TgYLQU
         /q5buwPNLNvXPYtgmbvDTRPU3Cf9rN8af39laD6hNylMLhOlUWZcdjcuSnzgCp6h22Od
         /UuAQx1kzlARdQpq1xCwWoxDsm6WpgvcDhpEBGnxXMx7fyn+WxlJMB4yb5j7IGFpA5IY
         JowuZeey7HLVUqI08CfxheelbkMeehuJYR+H4MMaYbpc9lOToq3WbPhuta/kpStUn9rM
         Vs9FHcrWbF1cOoeU5N3b7QVUDeUPRpfB22qrSTrmwu6xTG2wpQ1sJ9Hb+8npd6UyRrVT
         hFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=338ew+i7lhPhhsRwFXebT4YiHgbE5e7sWqj7Y/pRaLI=;
        b=WFZAU/VajeqpTTsXyX3Y+cIOKOiOg/24/8snLpmZoX5+4/AflJUABji6NlYfkOzMRZ
         AIDghmIc8ljPzDLTsyDyftGfuMohKSAhsGAbzBQamvgZvhcRhpADf9vZNjPAolRoXOkF
         /xzNqzQXG9B77q3juW+PCUSDeTTZex1z+wrXCtPWQmNTEtQi59AKIqQ/4fqt0nqiSzp/
         lgNolY7L53CH1Ve/uRYaUUlMoK3rnrYhlgKFu9KS65r8XCfmN0yZ45xPdMThGGaBUYq1
         nAWmcqgWc8U6SYT0jwqO8UEL9N6H/VBJdfK7KULWwPMSdMO/kOUNqhbX0oMU+Ree9vzA
         +hsg==
X-Gm-Message-State: ACrzQf1vMV7Bxh+vTDhypV042M78kr6ZrmSdEEsJisSKRh+0ERMqVlxN
        Eca3/MXxFwoce3vAA91rA88=
X-Google-Smtp-Source: AMsMyM5WmolYkONk0FMYkPzqo4dahEZcXdn77VTv+ezaYrMPOagr//Hcwc+NtW4Wt6SJLMDRMTxFKw==
X-Received: by 2002:a05:600c:5486:b0:3b4:7e47:e19 with SMTP id iv6-20020a05600c548600b003b47e470e19mr8729825wmb.12.1666261476483;
        Thu, 20 Oct 2022 03:24:36 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d67ce000000b0022da3977ec5sm16088946wrw.113.2022.10.20.03.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 03:24:36 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: fix incorrect function name in comment block
Date:   Thu, 20 Oct 2022 11:24:35 +0100
Message-Id: <20221020102435.1527436-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function name in the comment block for intel_vgpu_emulate_cfg_write is
incorrect. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/gvt/cfg_space.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/cfg_space.c b/drivers/gpu/drm/i915/gvt/cfg_space.c
index eef3bba8a41b..bff63babacd5 100644
--- a/drivers/gpu/drm/i915/gvt/cfg_space.c
+++ b/drivers/gpu/drm/i915/gvt/cfg_space.c
@@ -244,7 +244,7 @@ static void emulate_pci_bar_write(struct intel_vgpu *vgpu, unsigned int offset,
 }
 
 /**
- * intel_vgpu_emulate_cfg_read - emulate vGPU configuration space write
+ * intel_vgpu_emulate_cfg_write - emulate vGPU configuration space write
  * @vgpu: target vgpu
  * @offset: offset
  * @p_data: write data ptr
-- 
2.37.3

