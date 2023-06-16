Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647FC7330E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345283AbjFPML1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345260AbjFPMLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:11:22 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8F130C6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:11:21 -0700 (PDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5A4C33F84B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686917480;
        bh=ygm1JpcHC+yM6gwUZ9anDyDYQkSa5UJcZ+p9QEN6GhU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=m80NhPyjDUPqJGH+dmcSS1hWLH3FcicKhUkPYlM1C1vnspQ+/LWrwQGr7PqsgRyx6
         svaXwURgeBgJhSIPbb4czOv33q0jtzO7m6VTzr5UPjl+WagKysQuUNN065BgqvFK7y
         BM3k1h6wOljAc1DJRHf8+Nu0odTWOhyR6DfdsF7ZwNqdvFhNyyLCIqMphQu3Q0fSC4
         eZoOfWo0zxlHqSdus5vCFCA3m3lCH6daJw6I2aWbgKmC8NP+Pi5yaTd9J4MBDqhziX
         8oZS2R0xxl/60DnHcmwjDhn0j60iZSQvHFFPKjUrE9eSN5ffc2fgRYxLMgF9hhBjTy
         Zr10Sq3xDbekQ==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30e3fb5d1a4so207818f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686917480; x=1689509480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygm1JpcHC+yM6gwUZ9anDyDYQkSa5UJcZ+p9QEN6GhU=;
        b=g0Q5/776LC8V0tpK6KZB6atovIzOB+nKPUeetkxWj4qCMdUVd4KOSk9r3LuzkOhHgI
         BIWzYl/eNXclI8DGR2LNNBGAwvSn6m8kO1pkksteX4pgA49UqyJ/dtBjg1fAqvvfeK/8
         d2id3iDSNfXYTy671zWXKFbvVi3NxXS0OuBi21aWay+O0peaN66A+Ycxt4Wjom+X818a
         HIBLKlm8sABjSaL+QxyCOGyo2QNlGRzP16XyywSPJayEX3sYhySe8setzfmbNZS18OBS
         kyXz8W2hK8SVOgCGEaVOdzD0FydJdGhvybeSPSIkkX4hGjCTyZ1cSmqzpUeCWcdMqKP5
         sQYw==
X-Gm-Message-State: AC+VfDym2JbLhGtrOVE0fS+n3kReI/vVvqo3jUfe5N7hjE9yqfg8fjvj
        XPmFIjtHCbjDhRw/x5M5j7dVoZ6e0FUj7scTQrpRQ+heX3KKhfkdWRBxPp1D7dOPTVuslHrosjE
        pL6Va24CSOcFYaQalN7PkQ7+awIDDgcE8Hc/oP2CYhQ==
X-Received: by 2002:adf:fd82:0:b0:30e:19a8:4b15 with SMTP id d2-20020adffd82000000b0030e19a84b15mr1232217wrr.30.1686917480060;
        Fri, 16 Jun 2023 05:11:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7+RJMFh0mO2k3qKah4mRBirj+tBn8JQcdEo6xSgXQRBq85MahquhXfYVqxTBHqLgbleXfsHQ==
X-Received: by 2002:adf:fd82:0:b0:30e:19a8:4b15 with SMTP id d2-20020adffd82000000b0030e19a84b15mr1232197wrr.30.1686917479747;
        Fri, 16 Jun 2023 05:11:19 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id s2-20020adfecc2000000b0030aed4223e0sm23325047wro.105.2023.06.16.05.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 05:11:19 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Hawking.Zhang@amd.com,
        mario.limonciello@amd.com, lijo.lazar@amd.com, YiPeng.Chai@amd.com,
        Bokun.Zhang@amd.com, Likun.Gao@amd.com,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH] drm/amdgpu: Add missing MODULE_FIRMWARE macro
Date:   Fri, 16 Jun 2023 14:11:16 +0200
Message-Id: <20230616121116.1031336-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing MODULE_FIRMWARE macro for "amdgpu/fiji_smc.bin".

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5c7d40873ee2..1f83a939d641 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -92,6 +92,7 @@ MODULE_FIRMWARE("amdgpu/picasso_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/raven2_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
+MODULE_FIRMWARE("amdgpu/fiji_smc.bin");
 
 #define AMDGPU_RESUME_MS		2000
 #define AMDGPU_MAX_RETRY_LIMIT		2
-- 
2.37.2

