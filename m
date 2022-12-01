Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF8B63EDD5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiLAKbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiLAKbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:31:04 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32FB9D80B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:31:02 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ha10so3144167ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 02:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcT8YWVtzB1GH3wOdz9aZTQd5ehiQWJpYZBWZtycvm8=;
        b=cbjbrXuT8E1s38jzvt5nDpI8pDGo9sLSQBn85SkcpzB/lfR+IYTvqkDDRNZgh2xaX/
         hP1vgyrt14EfGicPI15NkWFmw9lTE/kIcwkC4CxR79Qb4UO8U40H2NsuNWNm5C4pfX2u
         rIzRBLpjE1qe6WpFfUuyXk5VT+VysTyjYVj2rc5S2Z8MZRuTlw7HqbLd0kM3wsDHqTCn
         8+Pthl24i9yHneVK+ayw9VF3UPmkfz6hgvaPxBelDF/rW421wCOK5xLzwbdgkuzXniUL
         /3/iBh78lTW85/idYvXbRlu5I120sZoNtAGgusL10Du525UNHgpQEaPP1FeLcPibs77O
         aB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vcT8YWVtzB1GH3wOdz9aZTQd5ehiQWJpYZBWZtycvm8=;
        b=Ppu5xFsJUrlHHJSi7azawlx2DzBt0gTxi03ZgbuFQBNdeMw5SDq+z38wB2jmCIY3HK
         oBSUnj4v8NUZu8/w7Z3DdS3oi4fnuBzh81lCPbftHfrc5wpPEdPREr7ToN5aMWx4CiN8
         D/H9W4Oy60cIWaAQEUZmV4QrI5LZSGl57LLqon7vd9RmKnt2kQDHLfS/YQ3jGXg6MUCu
         E2p3/JjZwhiI9WePMeXqcYgCppI64Tjj9W9TdjvygoO91C7zgoISbaQHsDfqVkdmEYm9
         crXOD7mnFhopDE2kR55gUJn9N3NzaZikc27BhnKhizIpW+KB1dqtT1SzILuuh+nm8J3S
         KX9g==
X-Gm-Message-State: ANoB5pmXURb04OBhGJo6JcamIB7BYTQQDmBsEtIkFlsJwKHsd8IshnAS
        qvi6zKgpaV+AcRZHO1ZrrO8=
X-Google-Smtp-Source: AA0mqf6vLwJ1e3gG/cbesF5dC/cJZEejWxr7z+4bT4uuMCGBKShgh1K9ZWvRJXzcdKkZCuY8cmdu7w==
X-Received: by 2002:a17:906:3510:b0:781:b7f2:bce9 with SMTP id r16-20020a170906351000b00781b7f2bce9mr56599893eja.269.1669890661370;
        Thu, 01 Dec 2022 02:31:01 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b007c07b23a79bsm1592400eja.213.2022.12.01.02.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 02:31:00 -0800 (PST)
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
Subject: [PATCH v5 5/7] drm/etnaviv: Add nn_core_count to chip feature struct
Date:   Thu,  1 Dec 2022 11:30:21 +0100
Message-Id: <20221201103026.53234-6-tomeu.vizoso@collabora.com>
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

We will use these for differentiating between GPUs and NPUs, as the
downstream driver does.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h  | 3 +++
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 4 ++++
 2 files changed, 7 insertions(+)

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
index f2fc645c7956..44df273a5aae 100644
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
-- 
2.38.1

