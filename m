Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A6E72933C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbjFIIcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240899AbjFIIbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:31:20 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2EC3A94
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:30:46 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d44b198baso1184328b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 01:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686299445; x=1688891445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11zc4FsjjThT9aF4m1qk+2IflC0iJrne6V3Jm40ZBR0=;
        b=WMoYiK/iXxPeqvuSRQWk/tYTcNjJU80QxtgpGB3hlLcCXiJQnqNF15avOkmQ0GpyLx
         eKy8+A8sRWAeorUOpjs6DmNg4x6M9M53n99aD7PcmPhHY7VafIuaT+b5NDGJ+TUXiofz
         eMoLcBQ1o8hK+kMDaGcJauXBShrpPGiPGuHMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686299445; x=1688891445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11zc4FsjjThT9aF4m1qk+2IflC0iJrne6V3Jm40ZBR0=;
        b=YU+OlcynumVcdM2+ELzwa3uxbQi8AdcNh2zRDAUDM5GQ7KAbmVchEY/ahADBBON0pA
         mmqq72Hz/yVoTTbsPtPu/YH0XRYo51R4s0N2nWLLt6XV3rstlkFwkrAnk8Jo25UROyke
         Zyo7x3FyIDNYNZhG5PIZG0D0xY2r89bT9NLLRkJGJNJTyaX4zqZpDntkzVqdwcAuUo7R
         2hNYpKh0uVccmBNI4aN/wVQv9sUeI7n3obYWAZ45eXo6FO+xHkjP3L+7H1ufBeNMWghd
         UAfGXO/BxecoImRoeiYC85+DCbHg0hrOorZUeS0mZs014Eu/E8j+vMfud5Ajo1wmosIZ
         xSqA==
X-Gm-Message-State: AC+VfDxHERhqk2qb4PqGWiXC4GMSgK9+djrwEwHMq48Cd/9Eli+cbhIs
        6mnU3OqJsJ8LA3J7DMeSjCYO2A==
X-Google-Smtp-Source: ACHHUZ5xpoOoksvbDS28+5deuwiplC6Vp3HHVXsrSO8dFl4pdVvNkxHNkySvOoAhhlJXej2Ra8nmsg==
X-Received: by 2002:a05:6a21:6d84:b0:116:fc1b:fa38 with SMTP id wl4-20020a056a216d8400b00116fc1bfa38mr1344531pzb.7.1686299444790;
        Fri, 09 Jun 2023 01:30:44 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c2ea:d8e4:1fe8:21f0])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79157000000b0063b806b111csm2184327pfi.169.2023.06.09.01.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 01:30:44 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] regulator: mt6358: Drop *_SSHUB regulators
Date:   Fri,  9 Jun 2023 16:30:01 +0800
Message-ID: <20230609083009.2822259-5-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230609083009.2822259-1-wenst@chromium.org>
References: <20230609083009.2822259-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The *_SSHUB regulators are actually alternate configuration interfaces
for their non *_SSHUB counterparts. They are not separate regulator
outputs. These registers are intended for the companion processor to
use to configure the power rails while the main processor is sleeping.
They are not intended for the main operating system to use.

Since they are not real outputs they shouldn't be modeled separately.
Remove them. Luckily no device tree actually uses them.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/mt6358-regulator.c       | 14 --------------
 include/linux/regulator/mt6358-regulator.h |  4 ----
 2 files changed, 18 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index faf6b0757019..946a251a8b3a 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -505,9 +505,6 @@ static struct mt6358_regulator_info mt6358_regulators[] = {
 	MT6358_BUCK("buck_vcore", VCORE, 500000, 1293750, 6250,
 		    buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_DBG0, 0x7f,
 		    MT6358_VCORE_VGPU_ANA_CON0, 1),
-	MT6358_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
-		    buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_SSHUB_ELR0, 0x7f,
-		    MT6358_VCORE_VGPU_ANA_CON0, 1),
 	MT6358_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
 		    buck_volt_range3, 0x3f, MT6358_BUCK_VPA_DBG0, 0x3f,
 		    MT6358_VPA_ANA_CON0, 3),
@@ -583,10 +580,6 @@ static struct mt6358_regulator_info mt6358_regulators[] = {
 	MT6358_LDO1("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750, 6250,
 		    buck_volt_range1, MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f00,
 		    MT6358_LDO_VSRAM_CON2, 0x7f),
-	MT6358_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
-		    1293750, 6250, buck_volt_range1,
-		    MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f,
-		    MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f),
 	MT6358_LDO1("ldo_vsram_gpu", VSRAM_GPU, 500000, 1293750, 6250,
 		    buck_volt_range1, MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00,
 		    MT6358_LDO_VSRAM_CON3, 0x7f),
@@ -603,9 +596,6 @@ static struct mt6358_regulator_info mt6366_regulators[] = {
 	MT6366_BUCK("buck_vcore", VCORE, 500000, 1293750, 6250,
 		    buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_DBG0, 0x7f,
 		    MT6358_VCORE_VGPU_ANA_CON0, 1),
-	MT6366_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
-		    buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_SSHUB_ELR0, 0x7f,
-		    MT6358_VCORE_VGPU_ANA_CON0, 1),
 	MT6366_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
 		    buck_volt_range3, 0x3f, MT6358_BUCK_VPA_DBG0, 0x3f,
 		    MT6358_VPA_ANA_CON0, 3),
@@ -670,10 +660,6 @@ static struct mt6358_regulator_info mt6366_regulators[] = {
 	MT6366_LDO1("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750, 6250,
 		    buck_volt_range1, MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f00,
 		    MT6358_LDO_VSRAM_CON2, 0x7f),
-	MT6366_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
-		    1293750, 6250, buck_volt_range1,
-		    MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f,
-		    MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f),
 	MT6366_LDO1("ldo_vsram_gpu", VSRAM_GPU, 500000, 1293750, 6250,
 		    buck_volt_range1, MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00,
 		    MT6358_LDO_VSRAM_CON3, 0x7f),
diff --git a/include/linux/regulator/mt6358-regulator.h b/include/linux/regulator/mt6358-regulator.h
index a4307cd9edd6..c71a6a9fce7a 100644
--- a/include/linux/regulator/mt6358-regulator.h
+++ b/include/linux/regulator/mt6358-regulator.h
@@ -47,8 +47,6 @@ enum {
 	MT6358_ID_VLDO28,
 	MT6358_ID_VAUD28,
 	MT6358_ID_VSIM2,
-	MT6358_ID_VCORE_SSHUB,
-	MT6358_ID_VSRAM_OTHERS_SSHUB,
 	MT6358_ID_RG_MAX,
 };
 
@@ -88,8 +86,6 @@ enum {
 	MT6366_ID_VMC,
 	MT6366_ID_VAUD28,
 	MT6366_ID_VSIM2,
-	MT6366_ID_VCORE_SSHUB,
-	MT6366_ID_VSRAM_OTHERS_SSHUB,
 	MT6366_ID_RG_MAX,
 };
 
-- 
2.41.0.162.gfafddb0af9-goog

