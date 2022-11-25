Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A0E63888C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiKYLTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiKYLTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:19:48 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4ADE286F4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:19:43 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so3176921wmg.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+Dm0WodzoCwPekd8CO1ZcYNi+jBHrS/Ym57B3kSSJQ=;
        b=Hn6VrYtyjsw/RxM7FIytyKmMTHcmSQdULy25PBy2jG77GEB6p9pcLoZls6GcB4iSPe
         bHxSw2D+ZnMEAfcAx7rdY3UwL07a57rknUPQ+WwKueTJ5svOG5cIse490VuInvRpKlMC
         tWgc4Hn8GjcCMiYgrVKFfyAtHTsw4qlpqaZrJCS6KJNpeoSG00b9/gtJx4Mrj30vKI65
         0ReOELdEpsnDPt10pUhk6uBkBLbwMGFcDZRhwsebCn7q94J+iAbfLFiwiqwEYC6wMrRO
         c19Vh4P/VV2/Fc3ZEOw275zHau96+AklK4IEjvDfGW8x/RitxjLhVdoNmm2b7F/ArIcZ
         Ajvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q+Dm0WodzoCwPekd8CO1ZcYNi+jBHrS/Ym57B3kSSJQ=;
        b=6+Qay2Dz8f4u12UZ3sWI+ebDwZj4DAiIOgXiE00w1rwUTdLwBTiXQcF+KzTgC0CXGN
         ZupymqzxZep5J9n271Oo50sqWN/hs0x2osVLJEAXcYJPlcGtOw3TzG+wWjC2y6J33mhp
         K/3UWGkXeczsXI5oOE6LeH1KaRFJBiM3E41ZdK4D6eN8NCLo/cz/3VhBbNM3uhJ99UIo
         MlDxC8cMm9LHILeUiIRjFGsEepthVWml+dQiUTTm5slNfGNS7vWDDOCfXVxEmvOA7CAi
         SR+SVHp/1GF91anau0a39+I8bH82fhn3yJjjG8tbGF7xU1NoggZVcwbBsia5c+GkT+Ql
         zGXg==
X-Gm-Message-State: ANoB5pkOvB6U98ZNqplZjObmR42am+FOwu5KX50Ln12XWGiAvvLVp0MC
        gkp5xecLtSGc0VC5oQiFUnNkhKYzgtc=
X-Google-Smtp-Source: AA0mqf55R9KgI/Juvsgb/srUjW0m6KonIuK6lfizlFd8UR4T+C8S7WL+NJSarGHx2qIZYQSTcU9gqw==
X-Received: by 2002:a05:600c:3ac7:b0:3cf:75db:c417 with SMTP id d7-20020a05600c3ac700b003cf75dbc417mr18616319wms.109.1669375182380;
        Fri, 25 Nov 2022 03:19:42 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d4b0b000000b002368f6b56desm4207406wrq.18.2022.11.25.03.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 03:19:41 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/6] soc: amlogic: meson-pwrc: Add NNA power domain for A311D
Date:   Fri, 25 Nov 2022 12:19:16 +0100
Message-Id: <20221125111921.37261-4-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125111921.37261-1-tomeu.vizoso@collabora.com>
References: <20221125111921.37261-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
---
 drivers/soc/amlogic/meson-ee-pwrc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index dd5f2a13ceb5..925cfaf50d11 100644
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
+	{ G12A_HHI_NANOQ_MEM_PD_REG0, 0xffffffff },
+	{ G12A_HHI_NANOQ_MEM_PD_REG1, 0xffffffff },
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

