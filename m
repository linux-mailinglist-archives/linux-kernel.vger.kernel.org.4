Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947E464062C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbiLBLw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbiLBLwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:52:42 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06656BF7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 03:52:41 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id l11so6182500edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 03:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFkg6LALiTZGl9NAXbdWzz4DpTKGtwoKK/kUM7aSbHk=;
        b=MGB53sJL6yNAkcbcZAcQts88mjn8TP+JI77aEgnVW+FAk+1d6rh9ciPxK90Zeee/Cm
         2sIEUfrOhCWKWZQbuL+VJvUUJBL5hZRrkL6ReE/KKXcQJ/BVqjaj+i6ECDUu5hci0ot/
         lgYI37DqkagAHEbN6+IfcGdqdKJYKhPkuj2q8zblZ7FCFc3bB751wdFMitgFkfLs2AoL
         CGWyWvhYZLQT0dIKRhFjgRp+pDWQevKkAIv72WwRjcc4EIK/8U8ChrQ9ykdzOVnPlIx+
         p78QIwsckbEY30ifzsEuFsZbDWVjzfD1hqgWP1jtLjA8GkusPtRQ6gdt8HMJ+DbiwTJM
         2MDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XFkg6LALiTZGl9NAXbdWzz4DpTKGtwoKK/kUM7aSbHk=;
        b=MgZ3QhA+ywNsvGGA1TFmTW+q5UTjevTbt5XAvmL7x4HvwJzfehD1LKthPm7Hu0JEEN
         +275IgomkE5ZB7+XjmmkaBOI+yjhzPxzIzhYP4BNiz7QVz/zKWmIXRWwi11I9Znht+Ot
         4Bb9Xm1mHRX8K0IgS437WrS9E2rgR9qNCYa14AYyAmFCekYIY4FsSe0tjXol7NieTK/A
         6YBtvrhFh3NOhgRmnW1+FBAgekdpqe6MxmlmJVevq11m2rXCsTGXYD9z96nx1zmEjHc8
         xd95lQH4P/uj1AKdOZfRaNw8FzLcgJEO6zvBmwsbSrOWI1AW+aZmrAffyaVXVbOd3/lF
         rp2Q==
X-Gm-Message-State: ANoB5plijByuaSPPxCjUKgrjhKrXkpOhjrrk+thLlF49d6RRFwsWDECh
        KHftQNzgAfpTWax2tQ9vYlk=
X-Google-Smtp-Source: AA0mqf5YSdD37zIdHOwaNDFnnyA8aeWZS/MRjbqAv9Ar3+pF4SJfF+ThVg5sQUFrfqscQmTMdUV2lA==
X-Received: by 2002:a05:6402:19a:b0:460:7413:5d46 with SMTP id r26-20020a056402019a00b0046074135d46mr64058882edv.47.1669981959517;
        Fri, 02 Dec 2022 03:52:39 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b007c0bb571da5sm1206762ejb.41.2022.12.02.03.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:52:39 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 3/8] soc: amlogic: meson-pwrc: Add NNA power domain for A311D
Date:   Fri,  2 Dec 2022 12:52:15 +0100
Message-Id: <20221202115223.39051-4-tomeu.vizoso@collabora.com>
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

Based on power initialization sequence in downstream driver.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/soc/amlogic/meson-ee-pwrc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index dd5f2a13ceb5..f54acffc83f9 100644
--- a/drivers/soc/amlogic/meson-ee-pwrc.c
+++ b/drivers/soc/amlogic/meson-ee-pwrc.c
@@ -46,6 +46,9 @@
 #define HHI_NANOQ_MEM_PD_REG1		(0x47 << 2)
 #define HHI_VPU_MEM_PD_REG2		(0x4d << 2)
 
+#define G12A_HHI_NANOQ_MEM_PD_REG0	(0x43 << 2)
+#define G12A_HHI_NANOQ_MEM_PD_REG1	(0x44 << 2)
+
 struct meson_ee_pwrc;
 struct meson_ee_pwrc_domain;
 
@@ -106,6 +109,13 @@ static struct meson_ee_pwrc_top_domain sm1_pwrc_usb = SM1_EE_PD(17);
 static struct meson_ee_pwrc_top_domain sm1_pwrc_pci = SM1_EE_PD(18);
 static struct meson_ee_pwrc_top_domain sm1_pwrc_ge2d = SM1_EE_PD(19);
 
+static struct meson_ee_pwrc_top_domain g12a_pwrc_nna = {
+	.sleep_reg = GX_AO_RTI_GEN_PWR_SLEEP0,
+	.sleep_mask = BIT(16) | BIT(17),
+	.iso_reg = GX_AO_RTI_GEN_PWR_ISO0,
+	.iso_mask = BIT(16) | BIT(17),
+};
+
 /* Memory PD Domains */
 
 #define VPU_MEMPD(__reg)					\
@@ -217,6 +227,11 @@ static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_audio[] = {
 	{ HHI_AUDIO_MEM_PD_REG0, GENMASK(27, 26) },
 };
 
+static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_nna[] = {
+	{ G12A_HHI_NANOQ_MEM_PD_REG0, GENMASK(31, 0) },
+	{ G12A_HHI_NANOQ_MEM_PD_REG1, GENMASK(23, 0) },
+};
+
 #define VPU_PD(__name, __top_pd, __mem, __is_pwr_off, __resets, __clks)	\
 	{								\
 		.name = __name,						\
@@ -253,6 +268,8 @@ static struct meson_ee_pwrc_domain_desc g12a_pwrc_domains[] = {
 	[PWRC_G12A_VPU_ID]  = VPU_PD("VPU", &gx_pwrc_vpu, g12a_pwrc_mem_vpu,
 				     pwrc_ee_is_powered_off, 11, 2),
 	[PWRC_G12A_ETH_ID] = MEM_PD("ETH", meson_pwrc_mem_eth),
+	[PWRC_G12A_NNA_ID] = TOP_PD("NNA", &g12a_pwrc_nna, g12a_pwrc_mem_nna,
+				    pwrc_ee_is_powered_off),
 };
 
 static struct meson_ee_pwrc_domain_desc gxbb_pwrc_domains[] = {
-- 
2.38.1

