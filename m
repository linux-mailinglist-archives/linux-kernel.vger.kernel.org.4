Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9847167F50F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 06:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjA1FxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 00:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjA1FxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 00:53:06 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468FD7375D;
        Fri, 27 Jan 2023 21:53:05 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id e8-20020a17090a9a8800b0022c387f0f93so5607953pjp.3;
        Fri, 27 Jan 2023 21:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H67bSVzm5ER4zFp/9HSmqMmtSQHhSFTb50GKenobAiM=;
        b=C8BtML5mpPVvSDKrdTL/bBV+e3l2LBOWBUfxoYZcKdWkNxYrZpBghofid7CTN9ptDF
         1AzbhGlYnqJBl6ttJ1gM/oTxuEQSCVzePDceaoVGU96smsAxYQP7Awm9nOg+b8b58Srd
         GfPBS9PoxjdYXJ/wsZoObJHJn+ThFlaKi51ii81JkUmHeWFoX2F229r7QeWIj9HCQ8Ll
         MMqUjEfZhz+tokmifHzr3g9BA8AyJS7wRNE3nhi3nsc2vE9uMDC/L9AIa/mSgnc/wuk6
         0nYp6t10shYup/DsR07cMhA0RWJEEzgo6YgLMs/Us6MWDXaNxI/vjqIRiOhL5un1sTUB
         u2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H67bSVzm5ER4zFp/9HSmqMmtSQHhSFTb50GKenobAiM=;
        b=u/m7+O9IYMkxvZm+KMSm/tYiKvM96VCQXe50WRBnKXYodnyYPIITCCwASOef43KGzE
         Fthrfx2GfkzhvleQfFRbtr70YSrEhiCqJb5sLvPag5z/DEEDVfdwd2oU1I5gFyC2x/cd
         BoUWt55xL2TsbEoXcPVqysNpOaVcsHMmCdY2Y5MupYzOEXOVGIXnfk1kRD3CqU7lHAEm
         rOSbs9Gwxx1zbbNNOc7lrg6PysEgEe5PdnIKEldNrqc867dtADk7L60Jga27EAGbdh6x
         7jRNLpjgoOiniP3FRxckJsPCjSBJcQd09ybzaCgJiZuHQX4/L7hehMpoJVwlPmvj1dTG
         RuUQ==
X-Gm-Message-State: AFqh2kooTU69ZflpBY/wKes/jKEiJuQcG76ECzHKgLRdmjrokCbiWgoI
        IHOcsGnG1ICE/05kuZDNKwPmBMVwyOozaW2e
X-Google-Smtp-Source: AMrXdXv06alTKQJMKsIgXSjlh4MInkc3xTzZSb3cvEAYyJcamvJQBY5GngfYVsDr2mb2LY8jSZoi1g==
X-Received: by 2002:a17:902:ce0b:b0:194:586a:77ba with SMTP id k11-20020a170902ce0b00b00194586a77bamr45317844plg.52.1674885184512;
        Fri, 27 Jan 2023 21:53:04 -0800 (PST)
Received: from jamie-desktop.modem ([2001:8003:cce7:dc00:ca73:20fb:36e7:4dcd])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090322ca00b001947c22185bsm3736962plg.184.2023.01.27.21.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 21:53:03 -0800 (PST)
From:   Jamie Douglass <jamiemdouglass@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Petr Vorel <petr.vorel@gmail.com>,
        Dominik Kobinski <dominikkobinski314@gmail.com>,
        Konrad Dybico <konrad.dybico@linaro.org>,
        Jamie Douglass <jamiemdouglass@gmail.com>
Subject: [PATCH] arm64: dts: qcom: msm8992-lg-bullhead: Correct memory overlap with SMEM region
Date:   Sat, 28 Jan 2023 16:52:14 +1100
Message-Id: <20230128055214.33648-1-jamiemdouglass@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previously committed reserved memory region was overlapping with the
SMEM memory region, causing an error message in dmesg:
	OF: reserved mem: OVERLAP DETECTED!
	reserved@5000000 (0x0000000005000000--0x0000000007200000)
	overlaps with smem_region@6a00000
	(0x0000000006a00000--0x0000000006c00000)
This patch splits the previous reserved memory region into two
reserved sections either side of the SMEM memory region.

Signed-off-by: Jamie Douglass <jamiemdouglass@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
index 79de9cc395c4..5e375ea73c79 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
@@ -53,8 +53,13 @@ cont_splash_mem: memory@3400000 {
 			no-map;
 		};
 
-		removed_region: reserved@5000000 {
-			reg = <0 0x05000000 0 0x2200000>;
+		reserved@5000000 {
+			reg = <0x0 0x05000000 0x0 0x1a00000>;
+			no-map;
+		};
+
+		reserved@6c00000 {
+			reg = <0x0 0x06c00000 0x0 0x400000>;
 			no-map;
 		};
 	};
-- 
2.25.1

