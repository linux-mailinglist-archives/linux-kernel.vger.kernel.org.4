Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB9F6D2600
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjCaQpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCaQpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:45:13 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1992BA5C2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:43:54 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so26011925pjp.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680281033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYD6p8k0MAvXLgW2ujOSm1q/H2SLlbnZmg0CclkW4x0=;
        b=PZpeZS1KXBC2YN+vJT3OPlyL1yl5kDhSsgqNZdKSUmyXcd4h8PnY79jZxr3Rb/eOo5
         i84DsF7gZ7P5CgFuVCdS+oY2N+xIb+EvR3Xca5NPkQIsDouJUe+aM82iQFssfnWX6GCo
         0DLYNnqoCLo7VSlydptNdrQE1S4o9iRNTlV5Us/vyDfxHIoICT0flwnNStGjVfb5D5SK
         ztFilqrXsNqw07wEE4TM9BPQfptNp97lsguJOjiEw1Z55vOGAXUsSoVRx1BsGERNq9VY
         YtW4u1NiI6VhMNpLqfxzQT1EjNUER4Si3XE5vR3q0mutoqOGSJ06Ew5TLuSkmIPHViel
         NV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680281033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYD6p8k0MAvXLgW2ujOSm1q/H2SLlbnZmg0CclkW4x0=;
        b=2jfjzL9CV3bMANseBPRwhRPN2uzdh4r4uUTXKfZY9QWoxP6NujPaT6Xo65wBRvZU7/
         HZzipNNXwf47exGusCoIw10zXcfoSh+rb7+A5WIHiPILbMzlSxdSZOapafNRgg9MsK8f
         Nv3Ms2Xov6Qmoyyf8oAuIUu/5/zqZkbEc2Jfg5Cwlsr57nb5l3Z5BVr/CaZIU6mBebZy
         04rh980PlTjXNf3W6aRi8kpw8nLErAwy7zrjXqHNbuvOAzYbbS9uvYWMzoPrDGhdpsPw
         /8C3rQ5GhZ4t/TrwQNCLTS0KRTFpEusoA+mxPHV4y2iuZBCgXbtum9d3bT0ZaJJ3dXb+
         kU8Q==
X-Gm-Message-State: AAQBX9cza63VgBL1/FnYEgHnzENiXs7w+mA0gzjIdu4jBHYq0VovtD5B
        BB71rt1u8Br6VdtvsTFz0JpnBg==
X-Google-Smtp-Source: AKy350aUadKxCjC7T/jtAKyhtu8secZ5aS9M9FzLyNXe0UgsEzCUaS54081hv5nD8SoUiDgQslQ9Gw==
X-Received: by 2002:a17:903:2848:b0:19e:675b:a40f with SMTP id kq8-20020a170903284800b0019e675ba40fmr24719165plb.8.1680281032922;
        Fri, 31 Mar 2023 09:43:52 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:53ce:1f39:30a5:d20f:f205])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902b40d00b0019b089bc8d7sm1798767plr.78.2023.03.31.09.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 09:43:52 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v4 04/11] arm64: dts: qcom: sdm845: Fix the slimbam DMA engine compatible string
Date:   Fri, 31 Mar 2023 22:13:16 +0530
Message-Id: <20230331164323.729093-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230331164323.729093-1-bhupesh.sharma@linaro.org>
References: <20230331164323.729093-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per documentation, Qualcomm SDM845 SoC supports SLIMBAM DMA
engine v1.7.4, so use the correct compatible strings.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 2f32179c7d1b..17a29184884c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5152,7 +5152,7 @@ msi-controller@17a40000 {
 		};
 
 		slimbam: dma-controller@17184000 {
-			compatible = "qcom,bam-v1.7.0";
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
 			qcom,controlled-remotely;
 			reg = <0 0x17184000 0 0x2a000>;
 			num-channels = <31>;
-- 
2.38.1

