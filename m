Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3AC66847C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbjALUyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjALUwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:52:55 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4C814022;
        Thu, 12 Jan 2023 12:26:43 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id n5so20027664ljc.9;
        Thu, 12 Jan 2023 12:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15pPSTBqoyAYCYzMfabcXUrmxuKUpnkxLbI+dGkSmlM=;
        b=PAq8WbY3gH4wUoKvocUjwqtAWnHfUIZpoE6G0hdtvvZuQ9YdpBhQxSUUtS+wlW/qRb
         R1diCo9E+LgL3BTe/4RI7BMJ1o974PSvdMF+gJ1aaVU9thHcWJbTFyc7+bzhsmzHGWfQ
         1Q4KPGSQ9xPRQYKLRJv5HgFyeGiamKxMfzUpRTKQIGnZZNcxBizQbA2zcLDBQ5qttVVD
         GODzFanVddphjDw9uuCtAjbjaYS3udmiksbO63qCyRArmvOLGfcSwlJN58BGz9qX30t7
         xIueo5IeT+R9zt09NHM3wVOnD/ilYZj/c9iVLNz7zab2VrTb7Si6/O6qf5wSBGvQghsT
         sG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15pPSTBqoyAYCYzMfabcXUrmxuKUpnkxLbI+dGkSmlM=;
        b=WR0rkw2s3yCDYGhzfxsVsAHC+UyhJCRR9OnVgOI1AVLVGRWi35i0X8Hz1r64boc5w0
         KfeYPvG53rzwiOpiFALLGSj4mKZ6WxgtH7VwKrtmEjBCmlW66bsr40fkkfVePpBGjKgW
         WFYPWgH8s3sUYbQT/CNNbH9iu7H9Hi0x3HS9acz3Vds4LagnYH1cuKZuSOEuwM25Har0
         5hkATEeZSMT8msRyZ6xwFCms6+tOrAfLCaxFI4TxdDRdB4QQ5lyBGJdy55JGswT8oAef
         3RDobdJ5VIuq5GJwxPbrKf1unT5LyI7Au337oredCRDpJdPPvS4QtPJjHiFIlZ1+tw8X
         6jug==
X-Gm-Message-State: AFqh2kp0nyGCvSwPWJt/+AgSKPR1pX6gTBFg3q02M5DNzwgKR2J+iejI
        HrD45SCNjfg4UiAmb1KJxSLGPDLf7XAmsQ==
X-Google-Smtp-Source: AMrXdXsA3FOLg84HWWaXb8lSo+5cuVP7KeVN6FpIwHWx2PW7Vh/j8z6EPIW2vjE9YMtVBBu8Afewpw==
X-Received: by 2002:a2e:a683:0:b0:285:33b1:a64d with SMTP id q3-20020a2ea683000000b0028533b1a64dmr3877242lje.50.1673555201535;
        Thu, 12 Jan 2023 12:26:41 -0800 (PST)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id k6-20020a2eb746000000b00281350bb5fbsm2346731ljo.2.2023.01.12.12.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 12:26:40 -0800 (PST)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] ARM: dts: qcom: msm8226: Add node for TCSR halt regs
Date:   Thu, 12 Jan 2023 22:26:08 +0200
Message-Id: <20230112202612.791455-6-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
References: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add a syscon device node for the TCSR halt regs needed by
modem and other remoteprocs.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index 4cba25dad8d6..394662cbf282 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -590,6 +590,11 @@ tcsr_mutex: hwlock@fd484000 {
 			#hwlock-cells = <1>;
 		};
 
+		tcsr_regs_1: syscon@fd485000 {
+			compatible = "qcom,msm8226-tcsr", "syscon";
+			reg = <0xfd485000 0x1000>;
+		};
+
 		adsp: remoteproc@fe200000 {
 			compatible = "qcom,msm8226-adsp-pil";
 			reg = <0xfe200000 0x100>;
-- 
2.34.1

