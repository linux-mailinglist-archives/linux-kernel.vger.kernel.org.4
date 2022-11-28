Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4620863A6FF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiK1LSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiK1LSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:18:06 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49B5253
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:18:03 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q7so15341219wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cw/am3froU3IMTWG9BB3ZSyfplgImMW6lCXqrhZP2N0=;
        b=e8gELn8IgLw4c7pgk25h5/TtTBA2qpEO4v7J4nDEkbxG4f4qJQCppwKHsdxv7jQxTT
         oYRhB8ieddTEJdMy5kKerOReXDZew/TVw+cxZM0t09EACpwHJWwYcP/cYk/N5G5qgzQr
         wXqyYIIE5Ty0i9N8Ia3p9e2uTXykzwb4psd257FT8ky2k3h4TN7FvioOs/TxN3LMBpC0
         uMYzTl7Ob02h/SFQJxMpeoXfKP+qFJgn+lzJnWzaAtEzoHAC4Xq+1bYU5FJnZ7KniQyV
         YAZKK1/vizqL4so3adpeGhBRLbMuMvyUuzSf1Z2sNX8/Q9uA+WfJB6LYH+DsKM/Scfx4
         NjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cw/am3froU3IMTWG9BB3ZSyfplgImMW6lCXqrhZP2N0=;
        b=xb2WFj7fxWGxOxe+x/sV7pfQfPD39yNz2+FN2JencyB7E5MEl6SkaX+uJNmRNLMCno
         Cf9cTpedq067PsugkubK8u5BO5X6IKUNkrE6rfzIS1GjVF3qG9LqE5X5B8EVw3zxnQ9D
         e/vtu0X2w5qW4glKUEQlgIZl/g2qyKGIiVpnVVDhUL8ouw68yQM14QBdrmsN/eTLYjYN
         iZ+cMzp319bj8QplSA4s5aY9o+QfMQFvoUEy7Umlh1ZmJgfw6s3pYr4L+lsv2DmrW8nU
         8IHbeiwcR33zBDJ6ME68TrrpM0fms8Qt8TsnR6BJuvgKN7dKs8Mt6tUENjSK14WZGbXw
         GcnA==
X-Gm-Message-State: ANoB5pnx0lyM81c1ycYyZCiadB/jk8+vJHCyjn/cPeb1Obb4C3C6yAs8
        4A0Gh7cAfaVAXgdyNhlkS6Y=
X-Google-Smtp-Source: AA0mqf7FlFtIDKPTjGZuk8Oe01rtn29LvDSRj8mFz6LD40ZubOZeqIPs8zVhbu1uqPDi5exDxM72gg==
X-Received: by 2002:a05:6000:883:b0:22c:d6c7:562 with SMTP id ca3-20020a056000088300b0022cd6c70562mr21365842wrb.8.1669634282187;
        Mon, 28 Nov 2022 03:18:02 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id g3-20020adffc83000000b0024207ed4ce0sm7711817wrr.58.2022.11.28.03.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 03:18:01 -0800 (PST)
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
Subject: [PATCH v2 3/5] soc: amlogic: meson-pwrc: Add NNA power domain for A311D
Date:   Mon, 28 Nov 2022 12:17:36 +0100
Message-Id: <20221128111740.39003-4-tomeu.vizoso@collabora.com>
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

