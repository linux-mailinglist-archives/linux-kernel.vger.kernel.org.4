Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D93E63EDD8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiLAKb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiLAKbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:31:11 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504299FA9A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:31:05 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id e27so3067080ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 02:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2njBXO/jcTn1hW9BCGP1JQWTyTb5ivQ7E5VaL+5F8g=;
        b=cc2+71zSLRd6aORczf6VwydiioGC5ERV4dEKqnoGWiupso+Zv97xJSaSUG9NoDOC4L
         Ox8vRi1EW3ddGkNSkgRnFIfJF4Z1HJ+IqQzf6OMKQVUoXcDDzo6wQ/7T5G+PMfoqF2HT
         YHqD1xge3JGgEmQ4bp37AjPDJ5KlrfVRSPDWi+VadiEDN504svPMnqkzxq2E2YWemhoJ
         69UTZGCNiYHy6FZ+dJgUR0l6zpobBAk663+rjTcWedCXVKNJJliORPf1dJdGo+UvW3z2
         VTsYOkcE+SYDqeSA5RY2mBDon1V/qwuQUF9nrkPADmDUHbWMWwJWP1lU2bWA9ZgXMAdZ
         tzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q2njBXO/jcTn1hW9BCGP1JQWTyTb5ivQ7E5VaL+5F8g=;
        b=X5rj+Qi5ppKjLXhtR4cZ/YvxjIQ7uwr0vKsDvO2fot1uY6L1Ejj0nk9gEeeFZIpjRm
         lvtUZVobBMIUO2ABmsBPusx7YdhWb5LcwKs98eC1Vxp3HxuypXVAA6gfBMRZH1d+JUEo
         Oij1jJCk2Tit6x9TRgdXfZjy4gAZk8APiijD9T2s30yL316PfVNCRWQsjCXewKfF1Kt5
         jj244SQxWQhIqQKeqwb150+2CIUQoBd6o1Co7vf1gvd4gYa7ycCQ5PfVDQkDAkocHraV
         4P6XV+LpPB+PglQzK89UltR0AFsiY3XDB5t4gC7k+/X+48d3JPOnVkQLttfOhDAYQdT8
         CdIA==
X-Gm-Message-State: ANoB5pkjxHqI/oHsKsHmLvEsS0TM+dD0HAbEBKWPQJyQvAJSTdphpNi9
        iN400IVUHbo46ktBh16kAGc=
X-Google-Smtp-Source: AA0mqf4roDdJ7X5AOMeo4c+BOzUOX3iZ5+TSETAMFDa6FBYU0p4nnryzGSyIFtBehtaFMD5MYiKeew==
X-Received: by 2002:a17:907:7670:b0:78d:b713:7247 with SMTP id kk16-20020a170907767000b0078db7137247mr33837303ejc.706.1669890663829;
        Thu, 01 Dec 2022 02:31:03 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b007c07b23a79bsm1592400eja.213.2022.12.01.02.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 02:31:03 -0800 (PST)
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
Subject: [PATCH v5 7/7] drm/etnaviv: add HWDB entry for VIPNano-QI.7120.0055
Date:   Thu,  1 Dec 2022 11:30:23 +0100
Message-Id: <20221201103026.53234-8-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201103026.53234-1-tomeu.vizoso@collabora.com>
References: <20221201103026.53234-1-tomeu.vizoso@collabora.com>
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

This is a compute-only module marketed towards AI and vision
acceleration. This particular version can be found on the Amlogic A311D
SoC.

The feature bits are taken from the Khadas downstream kernel driver
6.4.4.3.310723AAA.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
index 44df273a5aae..66b8ad6c7d26 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
@@ -134,6 +134,37 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.minor_features10 = 0x90044250,
 		.minor_features11 = 0x00000024,
 	},
+	{
+		.model = 0x8000,
+		.revision = 0x7120,
+		.product_id = 0x45080009,
+		.customer_id = 0x88,
+		.eco_id = 0,
+		.stream_count = 8,
+		.register_max = 64,
+		.thread_count = 256,
+		.shader_core_count = 1,
+		.vertex_cache_size = 16,
+		.vertex_output_buffer_size = 1024,
+		.pixel_pipes = 1,
+		.instruction_count = 512,
+		.num_constants = 320,
+		.buffer_size = 0,
+		.varyings_count = 16,
+		.features = 0xe0287cac,
+		.minor_features0 = 0xc1799eff,
+		.minor_features1 = 0xfefbfadb,
+		.minor_features2 = 0xeb9d6fbf,
+		.minor_features3 = 0xedfffced,
+		.minor_features4 = 0xd30dafc7,
+		.minor_features5 = 0x7b5ac333,
+		.minor_features6 = 0xfc8ee200,
+		.minor_features7 = 0x03fffa6f,
+		.minor_features8 = 0x00fe0ef0,
+		.minor_features9 = 0x0088003c,
+		.minor_features10 = 0x108048c0,
+		.minor_features11 = 0x00000010,
+	},
 };
 
 bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
-- 
2.38.1

