Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882C6640630
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiLBLxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbiLBLwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:52:45 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7D81263C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 03:52:43 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x2so6204578edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 03:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcT8YWVtzB1GH3wOdz9aZTQd5ehiQWJpYZBWZtycvm8=;
        b=n6rSQm2scPUp8G7dkrFMvAlrmDdT5HqkEFLp5tVgjnDhobTyndc90glH9j1b0mNhM4
         PlCdqyRunGFcWaw40v1XO1FSXh9aTfLBBrupdRpb73kotN52w4f1n2ij3hFHRPRX2wa4
         kacKVYbnJWeQHWjvGMvFfVlMplLd/isdSbjz2AqBN0jDpGu7R2+DvXsdJd7fNvJf4Zhq
         3kTdiH0gyp40Vejo7JRT3g8aEMXlLccp97tvG1j6mQExD9L9JFARULn1LNhUHNas2AKl
         vp6Xn+JSyYqlVspuDjrELJGnySjWwMg2YjB61h3wwHglmL06xvpYDgkkhBaBCSJ8wvgk
         0mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vcT8YWVtzB1GH3wOdz9aZTQd5ehiQWJpYZBWZtycvm8=;
        b=NOBo1gsVtETHbjjmrnYVE9tsudLMHbQnbzmv6Zhw2HcXjHt5aeoacXX3H5eYV8EuM8
         QH2hb9RMa1gxrYFSYKZGUS+Jox6yrsjLdChpHVJsSvWkbcfJR+UUEw81pvY0Ba9KvD8c
         N3xEuQq2di9DJn2UXGHm7V/ehbRFZwtyATw6DqvKLVbDHBfULCyBjLiMBBNQKhuxsi6Q
         0XzNAYZ1+C9/Qvc8FNvAjDoYuI/VRSHFCpCjf+/K2jj7c9zVJwJBchf5AcPN+0SCRhXs
         DHABmtebHRStWOJIjuTdAyn7sYcjm+bwH1K5H3HyETbdynIh6VBilPngpxKAzS+7nPo+
         KpHw==
X-Gm-Message-State: ANoB5pn9qyoBTioEpBFo1rVHe3wXPznnLju+B+KGUUT6KlR/iYVGJ+Zf
        gH5EFc0pa3MRfoVWWvaZXgo=
X-Google-Smtp-Source: AA0mqf7z5O8rS3mctV42J+CAKDbBvQEW1qpHWHU4cS8Gyjn6lrLWf90VBV+FexZaVWvv37D7WFdRNw==
X-Received: by 2002:a05:6402:1f89:b0:458:caec:8f1e with SMTP id c9-20020a0564021f8900b00458caec8f1emr62952822edc.280.1669981962298;
        Fri, 02 Dec 2022 03:52:42 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b007c0bb571da5sm1206762ejb.41.2022.12.02.03.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:52:41 -0800 (PST)
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
Subject: [PATCH v6 5/8] drm/etnaviv: Add nn_core_count to chip feature struct
Date:   Fri,  2 Dec 2022 12:52:17 +0100
Message-Id: <20221202115223.39051-6-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202115223.39051-1-tomeu.vizoso@collabora.com>
References: <20221202115223.39051-1-tomeu.vizoso@collabora.com>
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

