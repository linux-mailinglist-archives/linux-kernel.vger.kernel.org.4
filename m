Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D20863C9B8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbiK2UrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbiK2UrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:47:07 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BAE2DA95;
        Tue, 29 Nov 2022 12:47:07 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id s8so23898705lfc.8;
        Tue, 29 Nov 2022 12:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzEeQBd4qVGm9JgmmMP1iyLQB+gK14BZ1mh6GaefoH0=;
        b=dEQMO4MmRBxn2n8P8ZFdAJE1AWzKRPZ37ygPrW7O7fww+tAkRsi63ThQuw4tHQikLg
         DP0/BQHSpVA4UOscQO01pcHD4YUWc+MIEkeNI+vca4T3IDHUkB3jhWgPFhCtp4NougfL
         JUHUzbXWxE7+FuPHFN/f7gH1AeZprKBaeDeb0JEHPou79Ya7i5Us6sSa/wrqEhOaDUgR
         ofty4EZcklUW74HSfeDEz/Tozka19N8hxhVuZS+9H4kutsvfAtzTtoZ85ZAHNX9sB70H
         my2vds6MjKMpCejA1ZVxPtOsn4yamgjVZU+7mSdcCZVJz/qzmI629oFT0DzmUjWQhp1Y
         xPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzEeQBd4qVGm9JgmmMP1iyLQB+gK14BZ1mh6GaefoH0=;
        b=7HTr1LWPlhnb62h1+Rz8RSjgJP5iEnwulTrajHsZBFSZXv/VS1QeSM+PgkXDthMyFt
         aJRqpfiHduvTrswR1CXKFTsyw/kJBK3IUWQR2KI0OdnfzgkoQ75UM+bBo3I9XBgpiDfs
         bD4LmF//E66zrPaeTcpw4BGNgmssSuXxwns434BYvjAfOByGw54gDEilKqW7eInWwkZ6
         n0n4TQNkJTOnmZ7BA4aJlaP6mG+07Yk+adTkAXIuUWo/HjHD4G1yFdKHa13Dcqli8uGZ
         vngSjgUTd3Q+DzG1BtzGt2QnBMQGTblmGxXVxyMpxCahR6HbLC9Uc9lNMwW9kYQ3hY8f
         fsjA==
X-Gm-Message-State: ANoB5pnLX42quBJDZasA2vBF/Fs4VP7aAM2NG1jUcp4CHJwcdNvJA9bn
        O3n1pp7ZJbbRvnJqfd+C6qJw4WhbS6I=
X-Google-Smtp-Source: AA0mqf6mJkKMHnG6+nKkmTXcj/ijy8QDO0d6tdmPbqUNhwl6IlU6e8RfwRfjgxvFbLGJR4ilyQU7JA==
X-Received: by 2002:a05:6512:784:b0:4b4:a304:998a with SMTP id x4-20020a056512078400b004b4a304998amr14912583lfr.555.1669754825367;
        Tue, 29 Nov 2022 12:47:05 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id o11-20020ac24e8b000000b004ae24368195sm2325620lfr.233.2022.11.29.12.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:47:05 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 06/12] arm64: dts: qcom: sm6115: Add rpm-stats node
Date:   Tue, 29 Nov 2022 21:46:10 +0100
Message-Id: <20221129204616.47006-7-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221129204616.47006-1-a39.skl@gmail.com>
References: <20221129204616.47006-1-a39.skl@gmail.com>
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

Add rpm stats node.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 04620c272227..6d14bbcda9d3 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -538,6 +538,11 @@ rpm_msg_ram: sram@45f0000 {
 			reg = <0x045f0000 0x7000>;
 		};
 
+		sram@4690000 {
+			compatible = "qcom,rpm-stats";
+			reg = <0x04690000 0x10000>;
+		};
+
 		sdhc_1: mmc@4744000 {
 			compatible = "qcom,sm6115-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x04744000 0x1000>, <0x04745000 0x1000>, <0x04748000 0x8000>;
-- 
2.25.1

