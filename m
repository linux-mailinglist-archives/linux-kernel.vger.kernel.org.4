Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7606C63BC24
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiK2Iv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiK2IvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:51:23 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E7358BF9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:51:21 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id d20so8051412edn.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/wAlj9+lbLEBeIqsdF+yfeUS1s2V84+JTVk1VCdcTE=;
        b=F3BLC6fjBiitgUFKsGVyTVAd7kZmy7Whapxwc6oWLXJG2YEVH6tfowU3+qwLpDxLxm
         BYBoPEs29A5J+sEPdBpDeQ4VzYuYwTfzcbdm4sWHgYt21XjcGvlJH51EG3kBZ8PNS3Fc
         0ocfDufO/9u32Foc/LoNNEcj/5tnGjxfz9B++VlKxKZJ9vUJYsvT8knVy19XCqTApAxA
         QFIyydAvQFMFKz3vun5Ro66pHwIByRIGuUg01/mGLIioPZmit58rco0JTDyKHWF1oOtQ
         2kMvEBzVn/6A7jFpoIK9DsYVkrqAZ/pZ8PtsxPhAhF9H0LkXnOKDvV+g3tos+OzoQBZw
         7+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j/wAlj9+lbLEBeIqsdF+yfeUS1s2V84+JTVk1VCdcTE=;
        b=pqbPsFwm1jmSYLM6I4muBkKAqEXOAtuxIvPq8SfJnLWs332h9LmnceWlzg7KQjT99N
         fUAQZZz84wOeT2oF3x6PQkZh2OpOsXPm4t1Sm5cwv3R9Ns6NoHrs/boqhgQot5TTdQoc
         Fa03tcuV6edrmeMrEp+TF/tIU5gTT/ZwoQ9mWceHN8udM9TtOQQqHjVIf0oioKmFD/vC
         cDoY+KmDQbMxazcOTejXp5DEIfh8TuFKcciq56Uz69a21ctZfByTrJ+2Uc3TsTuX2q1g
         fp2J/svfiYCv0qvGAsNKT2eYgy3FE9bbbeo+kfXYiAaFBA9c2AupP5MCI+2hB9snRdoV
         DTDg==
X-Gm-Message-State: ANoB5pkUBXM7V5mhgL2zrFgTwYQAgfBksqkQOxcRzpK3f4eWWH83g+cq
        aaFL2cSPdr5Qe2dfBgZbsF8=
X-Google-Smtp-Source: AA0mqf7jKhZ7QKnwHguva3IWUuFk9/+/O92m4VQX+VxAVGvVd4Kt2AlyTWN0negQts5Celyb9XWVcg==
X-Received: by 2002:a05:6402:2b8b:b0:468:cae8:f5a6 with SMTP id fj11-20020a0564022b8b00b00468cae8f5a6mr52228379edb.263.1669711879597;
        Tue, 29 Nov 2022 00:51:19 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id kz1-20020a17090777c100b0078de26f66b9sm5873219ejc.114.2022.11.29.00.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 00:51:19 -0800 (PST)
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
Subject: [PATCH v3 5/5] drm/etnaviv: add HWDB entry for VIPNano-QI.7120.0055
Date:   Tue, 29 Nov 2022 09:50:45 +0100
Message-Id: <20221129085047.49813-6-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129085047.49813-1-tomeu.vizoso@collabora.com>
References: <20221129085047.49813-1-tomeu.vizoso@collabora.com>
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

