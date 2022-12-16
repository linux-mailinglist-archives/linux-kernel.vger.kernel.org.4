Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B37264E813
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 09:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiLPITB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 03:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiLPISz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 03:18:55 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D2D30F51
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 00:18:43 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id kw15so4330772ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 00:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6IetT+3qAxgYv4w7rQA6gx6h6oqAE2jpN63VkZpms+0=;
        b=KXHn5eeNot+kzcKrFAvGadeKpkAURMc8tk9hN2at0v8f8Kt7JuZeEYiihEMHv156gq
         W3FtVsZzt4NA4xO179dFXd5k8ysP2CMbhbisjqVCuFpxRWoDXEGMC2IAf/yPCfqvirNr
         iAPtB0qYRhW3/OiU+V5dTaL2k8ksbp7KE2Gn/xC0PXSJlkdcoh05UHxAXeQ+dDqHDtt0
         XJLvHPOtZbh5XiBfp5MUVHKJFlinGfg3NdEW6RV8VEq8mdqK8KY71d2ywADANOHH7LxG
         l0rVmLysMEUba85+I+Q8jwbnIuUXG7pjLVVAxtu0iMUgzad6uKNaN8y/WdMB54selCMn
         RLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6IetT+3qAxgYv4w7rQA6gx6h6oqAE2jpN63VkZpms+0=;
        b=UUJ/qnrIfiHm9LVD6LRD2jzojLrFJyFh8NGdLvHA9ftKkDMmqmh//9k1IscrWbGT6H
         4DETqHpPH0v30/HslbZGvjT8yUDjOQurPWK4BAF0fvLtUeSowZFZeTirl4eSNuYOIzm2
         GEZfRr633yDp5+2/NktN+TCtT9iLb4WVkhTB1De5yB3bsuTYwiGPfvX+4CRpeEwXCnbB
         zUMHjhdTY0QAtegGc50FK/3KFNWvEAiT2sig9/O0su+dLQejsbILaUkO9g7INmk2eysy
         rIRuIyDo6EgHemUTtO5/av6TSeWNu9eQf2LrNFzkGj1Q1pLqyk1AhoFCaCTZNbE7wkr4
         OauQ==
X-Gm-Message-State: AFqh2kpTBYcpLqSRMJtA/vKMQMQ1Uv7CsxSeZRZDXGhoxeTHDTRLYYaS
        sn+osrF6I+6VjkuwkTHiS0s=
X-Google-Smtp-Source: AA0mqf4YqGiWAtfLh9xLvFT08r0xdiy7tzpKC7Clk4d8/VWxYUUcS7dp57l6JZEgqMiMWvCeJftAUg==
X-Received: by 2002:a17:906:b14b:b0:78d:f459:719e with SMTP id bt11-20020a170906b14b00b0078df459719emr16122255ejb.73.1671178722057;
        Fri, 16 Dec 2022 00:18:42 -0800 (PST)
Received: from fedora.. (chello085216152096.chello.sk. [85.216.152.96])
        by smtp.googlemail.com with ESMTPSA id b18-20020a1709063cb200b007be3aa82543sm572814ejh.35.2022.12.16.00.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 00:18:41 -0800 (PST)
From:   Wim Van Boven <wimvanboven@gmail.com>
Cc:     wimvanboven@gmail.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        syed sabakareem <Syed.SabaKareem@amd.com>,
        Leohearts <leohearts@leohearts.com>,
        Brent Mendelsohn <mendiebm@gmail.com>,
        Xiaoyan Li <lxy.lixiaoyan@gmail.com>,
        linkt <xazrael@hotmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: yc: Add Razer Blade 14 2022 into DMI table
Date:   Fri, 16 Dec 2022 09:18:27 +0100
Message-Id: <20221216081828.12382-1-wimvanboven@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Razer Blade 14 (2022) - RZ09-0427 needs the quirk to enable the built in microphone

Signed-off-by: Wim Van Boven <wimvanboven@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 1f0b5527c594..469c5e79e0ea 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -220,6 +220,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Redmi Book Pro 14 2022"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Razer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Blade 14 (2022) - RZ09-0427"),
+		}
+	},
 	{}
 };
 
-- 
2.38.1

