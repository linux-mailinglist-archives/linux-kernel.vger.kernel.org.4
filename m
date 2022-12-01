Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A465E63EC4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiLAJWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiLAJWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:22:05 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC2F86594
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:22:04 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id o13so2760110ejm.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 01:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cw/am3froU3IMTWG9BB3ZSyfplgImMW6lCXqrhZP2N0=;
        b=VtKXP9AfoQpyEZYYV8RQoSBNAXIYAvwbKi6Yg6Coz0B22h0nwf6cOnNjAiCNC6+8J1
         7NolDrEwXwXRx4yAaXXvqvu4wIgZsTZ6gLLbOMAqjbY94rN0zdjIWXsYwnONwGW/NsC/
         w2BiyAJVq4d0sjwWQtorKHctehY7vfauDgXs2hBNxAUV8PVaRnzRlqVrq6EGnTfq/vot
         z8opNiGX6/1bWF+R5skTgx9u1kpkMP54cALtMfMmZFlCymXrysGAOIRICToMQONZs/4l
         x3ufy1N7+UUN9Y4RraBMyMX+QvO6MiINR/ScMSbAh+mq210eN2ipnUpL/d0hsGL7jsGR
         QzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cw/am3froU3IMTWG9BB3ZSyfplgImMW6lCXqrhZP2N0=;
        b=r3Fdijw5U8NoegtxRC28gjxCs+u7KIE0xtDxZltKfCDkEhEBwR5oTayP3fwKPyN2XA
         g+Rbxc4HlbnjoNgC6yunAqVOFJH3+FBZzVfnDZQkxL/FB/H4+LbNItTCyp9gFv6hmdtL
         o3gbg3zLpxRlDhiMk9pKBTMUiKrZcLwzvlfPBphzcQe3wWf91/h7kFk0SlYdWnO6Vxo0
         mfrblZw7JRS0lXKlxP9b4MhjdhPbBRxm8sFcrw92qKlgDR6PbDvrqiTCbuJ/FEBXyoBp
         TmBSuVI5/Cr9kK7Zf/JiR3hlamtaBJyIWpaLdxirgvEmg5wCx0q0Kg3GExOWnauTAdrp
         8+xg==
X-Gm-Message-State: ANoB5plADgIP43yCn7sjIx6DvyQ4kXq2rGdQfUFrU4JoY3nmjH2qpX6g
        QchT1zBXrphS2KivG1vcLlg=
X-Google-Smtp-Source: AA0mqf6j94e36tZw8yrtZZ4lcltmqWjX7I3vRd3gaN2OAM5MqJ9bj+WCkFF+5F9Iy3UWrMLt1UWLkg==
X-Received: by 2002:a17:906:a387:b0:7bc:2ad:7c1e with SMTP id k7-20020a170906a38700b007bc02ad7c1emr28734923ejz.588.1669886523183;
        Thu, 01 Dec 2022 01:22:03 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b007b29eb8a4dbsm1587879ejt.13.2022.12.01.01.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 01:22:02 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 3/7] soc: amlogic: meson-pwrc: Add NNA power domain for A311D
Date:   Thu,  1 Dec 2022 10:21:24 +0100
Message-Id: <20221201092131.62867-4-tomeu.vizoso@collabora.com>
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

Based on power initialization sequence in downstream driver.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/soc/amlogic/meson-ee-pwrc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index dd5f2a13ceb5..dfbf0b1c7d29 100644
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
 
+static struct meson_ee_pwrc_top_domain g12a_pwrc_nna = {	\
+		.sleep_reg = GX_AO_RTI_GEN_PWR_SLEEP0, 		\
+		.sleep_mask = BIT(16) | BIT(17),		\
+		.iso_reg = GX_AO_RTI_GEN_PWR_ISO0, 		\
+		.iso_mask = BIT(16) | BIT(17), 			\
+	};
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

