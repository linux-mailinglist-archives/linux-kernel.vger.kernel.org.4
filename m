Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB14363A705
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiK1LS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiK1LSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:18:07 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8028B1B9DF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:18:06 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r66-20020a1c4445000000b003d05a3775d4so1887290wma.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/wAlj9+lbLEBeIqsdF+yfeUS1s2V84+JTVk1VCdcTE=;
        b=eLtpnITDJBZ4eC9WuN+NwFAZ7Z6Q9wtGvKkEguievQ+59Mk2Ve17OmAit8TaOcxvKM
         9ZVS4Ku1Nbf2k5IO7W8uxcSf/xPiLO/HtBHmKUuAPB48FVoe7n0eO2FwZD5M1i94g2FS
         afj8vKngWtKaGuxQQ59gHYv0zRK6ZGxdOVzWZA2sYo4g87HI3JnSqci+zlw/ZzoSyfWz
         o79Ua3SmWjCeMIkSmoyJYckXE1qH8nQRbGgNFMmC+JQPfN91W26JPbkdF5+b1h+NyUCD
         ovpRky4zA4/Tt+nO4cQ56RGCL94I9sx9n0gEHo/QXuuVIQCPX1VYYfcgkbuPt+FJFFHS
         1J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j/wAlj9+lbLEBeIqsdF+yfeUS1s2V84+JTVk1VCdcTE=;
        b=w3LqprrBHY1d/M6/udf/XYjV6cVdnsRYWOcTMwyDg3uOaUvHyVE3Ny7wC14gs0fugt
         YxclsiPw+e878j1t+6pBms5sLjMMRpshCRNtKSAdMU91IgHUBQjK0xZgnnBSBO1DA9nX
         5iOQ/STZvb4hhHtzfkas/Vvs6XYRaHZsMVlFQIk5qizb7pwzRvRbkBi/vmS2EBhUe6mL
         Gtc9JUHaqWonOsIyvcFVI0aNcUBr15TknrBZVCqPLYXuaacwSxnmVae2i2oalkZaPLOt
         9idxmJ7qci6bQ3I4sssV7hgx4Jya2ECznV8331dat7/cSWhcXCK8KJWnW4b1PsZluKuE
         7aow==
X-Gm-Message-State: ANoB5pkoRdObGvDUASyjowUOuLCk/rAUIia+VCalyj0vBaVs4LBI1vfi
        aoE/BZePWNKRwncvmmaM+4Y=
X-Google-Smtp-Source: AA0mqf69eWYyZgMKdOGsUq0UPtisowcqx0w0ysK/Ur6civ9KWMfHY8SUYDhnxbdliyF6bhrfjnFrfQ==
X-Received: by 2002:a05:600c:3d94:b0:3d0:552e:8d86 with SMTP id bi20-20020a05600c3d9400b003d0552e8d86mr4812413wmb.112.1669634284975;
        Mon, 28 Nov 2022 03:18:04 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id g3-20020adffc83000000b0024207ed4ce0sm7711817wrr.58.2022.11.28.03.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 03:18:04 -0800 (PST)
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
Subject: [PATCH v2 5/5] drm/etnaviv: add HWDB entry for VIPNano-QI.7120.0055
Date:   Mon, 28 Nov 2022 12:17:38 +0100
Message-Id: <20221128111740.39003-6-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128111740.39003-1-tomeu.vizoso@collabora.com>
References: <20221128111740.39003-1-tomeu.vizoso@collabora.com>
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
index f2fc645c7956..3f6fd9a3c088 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
@@ -130,6 +130,37 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
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

