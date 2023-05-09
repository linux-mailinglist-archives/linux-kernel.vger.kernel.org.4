Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655366FC6EC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbjEIMnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbjEIMnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:43:05 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E1E4C1A;
        Tue,  9 May 2023 05:42:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3062db220a3so3753184f8f.0;
        Tue, 09 May 2023 05:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683636163; x=1686228163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ogUelxBN/iBvkYaR2z1a5yJ9iiiICSJTX6onuQ39wKc=;
        b=bP7R25534DGHvBCha1PbVOLFyNyApN14uU0+rqLMNhnVLU10jdo0WpgiD4Fm5V0yAI
         qB9qqNDTJNCGQpxxKLifFkvcNrAT6QpRIzcuFAQOHfNsG4T1LJkdu9BJqroSTIQuCnSH
         hVmH8GmS4d3T4uHCkbAxE+GJfb+6wFmAyVPw8Qr8/MJJwoTr0DX3abclrKNkPLwDd3qq
         QnkES30ONz6qzfN90XpFKCc6PfH1ofxZHL/Kfgi8YzSg/5h5z+MdHLX6fTrmTadngxAg
         nsULLXonZPl8d+eq1IQ4r5tR/1ucDnjMokuQ606bWx9lLRVU7nOwih+KSmfHz8CWWfn8
         2Ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683636163; x=1686228163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogUelxBN/iBvkYaR2z1a5yJ9iiiICSJTX6onuQ39wKc=;
        b=IhkAgda/IgAVEFTtxKaJ7Z6LrvOQg85j5YFFXU+A+e4dgv4bjcJMlXn8vOiCSDOR8m
         Ttrmy4lXS8rmzIx44wk4xmUis6tjNyznFha/QS6aXbQap4OtljatYHFs2HUQLfcwyVPb
         oEKXLH98pYtt8vjuLhZ6x8ombL4uqWnFW6Id3xQ4cmSoGTk7z5TqjhpID1kB7Sio6QAe
         PZa+pXf75mSLeaHMOuu+elZ76jPDAco1y9C6woaNYccrI2x2eSVDzyjZ7msCU+51LcHZ
         X7XK5FcfLWt5qbYtTQ1t+moRgAAbc1ux3iOf5A057ibhRvEQghIzjyhL00I30RK5MNwH
         5ykQ==
X-Gm-Message-State: AC+VfDzV9AHiEwpazotJBtL/owgvtpbN/sESEuTkcBEa94MCTKfAVdrG
        4nChmAW5loeJ+60dJDnZ6MI=
X-Google-Smtp-Source: ACHHUZ4OvsksKT0JGRCaHiq1efo16lO58Z2ioXMGYLZCNfBtE3MpDpTy4POSymXX2RrynXBHt6s39g==
X-Received: by 2002:a05:6000:1a48:b0:306:34e4:be40 with SMTP id t8-20020a0560001a4800b0030634e4be40mr8884827wry.33.1683636163178;
        Tue, 09 May 2023 05:42:43 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d558e000000b003079f2c2de7sm3058083wrv.112.2023.05.09.05.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 05:42:42 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tsbogend@alpha.franken.de, paul@crapouillou.net
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v1 1/3] ASoC: jz4740-i2s: Add support for X1000 SoC
Date:   Tue,  9 May 2023 13:42:36 +0100
Message-Id: <20230509124238.195191-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X1000's AIC is similar to the AIC found on other Ingenic SoCs.
It has symmetric playback/capture rates like the JZ4740, but more
flexible clocking when outputting the system or bit clocks.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 6d9cfe0a5041..7cb563bb8b09 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -329,6 +329,14 @@ static const struct i2s_soc_info jz4760_i2s_soc_info = {
 	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
 };
 
+static const struct i2s_soc_info x1000_i2s_soc_info = {
+	.dai = &jz4740_i2s_dai,
+	.field_rx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 24, 27),
+	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
+	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 8),
+	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 8),
+};
+
 static struct snd_soc_dai_driver jz4770_i2s_dai = {
 	.probe = jz4740_i2s_dai_probe,
 	.playback = {
@@ -440,6 +448,7 @@ static const struct of_device_id jz4740_of_matches[] = {
 	{ .compatible = "ingenic,jz4760-i2s", .data = &jz4760_i2s_soc_info },
 	{ .compatible = "ingenic,jz4770-i2s", .data = &jz4770_i2s_soc_info },
 	{ .compatible = "ingenic,jz4780-i2s", .data = &jz4780_i2s_soc_info },
+	{ .compatible = "ingenic,x1000-i2s", .data = &x1000_i2s_soc_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, jz4740_of_matches);
-- 
2.39.2

