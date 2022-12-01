Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BA063EC4F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiLAJWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiLAJWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:22:10 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC2A8BD2F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:22:08 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s12so1510278edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 01:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxpUnfBd0p8vcBE3KJWC/GuBXuBQqcwTN9Z0iX5mpvg=;
        b=HD5y/WXR910sg83kjV2BWWD+qL/7BH8Xo4u7soFHYUr5CtSS9XJJU6O7ZscoquM91K
         6i8CKACWUqe/EphfLVNL2AHfOvDiEB044SEXeiwUHAsO2Jug0lRYot3mwxw96t79SLgK
         2iqa6epHYKcFXijhbisR/YZ3N9lhnp//SQWLMlTdL958FSj2WhAvDdmJIWdcfV7iFcP8
         tTj8SjoHaM4lifnQ1ICKCqtYfDBJitNjdgyn11dBfVbHqs2Dh+PsU617DNKiLxHj7vXx
         ASv/A9z6YvKKX9AVQwdse0/25qgPMFHyAACGc+tmr8vfUArHhK+A/P+quLM8po7jBoq3
         IwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZxpUnfBd0p8vcBE3KJWC/GuBXuBQqcwTN9Z0iX5mpvg=;
        b=qg8cWyBw6w1H+n8AELbl+Yi/BBWRXge4x13PGFL4t5G2vpcEcuMwC+VXDueUcoDzxw
         MSNPzYhaDjFDqvjl7a1JBvUoUA1sgvDKNJK7anZJlfvbyawlSvWUssveMke82e0vQk3N
         UM0g0B3ys7edQU2yEB5KCub3O8sUmEPaqOyH1QBIAQuumtinAunNuIicztrZmGgoH1Ye
         HjwpC3cOHF7WeSHbq4fnRivfAIvKtyyWbATERYwSb8wgM/My9qtdpuDqwV7kWjtqtCKc
         cx3aiG554kUXNi5vm3UGTArYkfjzZwr9mJxLsk8TwmrYXEgKEyckuztXtmD4yvVvw1iy
         GihQ==
X-Gm-Message-State: ANoB5pmVC7DALDQaXMgXM8iEo7PQfCtdSrneQeyJP02P3vHhcB3brBmi
        Iainy2QGmpM7S8LkLm+reJw=
X-Google-Smtp-Source: AA0mqf4/z8IWZm6GF+afL3r9Qn6kOIeqai5lAdazdtaxlhi3u/3DQBDzJbdDNAkDm3voiXgaDjvn1g==
X-Received: by 2002:aa7:c042:0:b0:462:2f5a:8618 with SMTP id k2-20020aa7c042000000b004622f5a8618mr59546512edo.42.1669886527062;
        Thu, 01 Dec 2022 01:22:07 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b007b29eb8a4dbsm1587879ejt.13.2022.12.01.01.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 01:22:06 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE
        GPU IP),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR VIVANTE GPU
        IP), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 6/7] drm/etnaviv: Add nn_core_count to chip feature struct
Date:   Thu,  1 Dec 2022 10:21:27 +0100
Message-Id: <20221201092131.62867-7-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201092131.62867-1-tomeu.vizoso@collabora.com>
References: <20221201092131.62867-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will use these for differentiating between GPUs and NPUs, as the
downstream driver does.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h  | 3 +++
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
index 85eddd492774..c8f3ad2031ce 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -50,6 +50,9 @@ struct etnaviv_chip_identity {
 	/* Number of shader cores. */
 	u32 shader_core_count;
 
+	/* Number of Neural Network cores. */
+	u32 nn_core_count;
+
 	/* Size of the vertex cache. */
 	u32 vertex_cache_size;
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
index 3f6fd9a3c088..9fc5223299e4 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
@@ -16,6 +16,7 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.register_max = 64,
 		.thread_count = 128,
 		.shader_core_count = 1,
+		.nn_core_count = 0,
 		.vertex_cache_size = 8,
 		.vertex_output_buffer_size = 1024,
 		.pixel_pipes = 1,
@@ -47,6 +48,7 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.register_max = 64,
 		.thread_count = 512,
 		.shader_core_count = 2,
+		.nn_core_count = 0,
 		.vertex_cache_size = 16,
 		.vertex_output_buffer_size = 1024,
 		.pixel_pipes = 1,
@@ -78,6 +80,7 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.register_max = 64,
 		.thread_count = 512,
 		.shader_core_count = 2,
+		.nn_core_count = 0,
 		.vertex_cache_size = 16,
 		.vertex_output_buffer_size = 1024,
 		.pixel_pipes = 1,
@@ -109,6 +112,7 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.register_max = 64,
 		.thread_count = 1024,
 		.shader_core_count = 4,
+		.nn_core_count = 0,
 		.vertex_cache_size = 16,
 		.vertex_output_buffer_size = 1024,
 		.pixel_pipes = 2,
@@ -140,6 +144,7 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.register_max = 64,
 		.thread_count = 256,
 		.shader_core_count = 1,
+		.nn_core_count = 8,
 		.vertex_cache_size = 16,
 		.vertex_output_buffer_size = 1024,
 		.pixel_pipes = 1,
-- 
2.38.1

