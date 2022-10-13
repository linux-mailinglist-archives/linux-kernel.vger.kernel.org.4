Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA025FDDBF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJMP4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJMP40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:56:26 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D23DAC42
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:56:25 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id mx8so1533016qvb.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peBZ+o0SLeYqd+DX9yqHCLT12xT6rkAjixZ0RNiZfhk=;
        b=gDCuiFor8HhpbWp9fp3uVoGYcrxvCuN30wL3ycpmtQUhgOfaKOHfQAfWRFQQvOjXRD
         s2HaYMgTL9/mXuok+k2EVgRwDTohpx5U4qSC/4ZtacdmJf4x8/wcprMXcH8I6e1N19A3
         yuchYZfusaAiKjfw400t9C1NEm25tcpaZfI+YAijRONZBFq1u7CfuJXonKHmO5Qg3P4S
         7LG4LUL0ew63UGj9EfwOeKKuAKKx4GFvImk/ZzGw8NtfPYiFm5tiBq0H/talcKb1ESD1
         alKCkoDemzduw+Y90xJRgzNqAzY2mGl1sk8fK2cFnA4jYjuyPrkhAyQQw2j7dCSlDATs
         0X4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peBZ+o0SLeYqd+DX9yqHCLT12xT6rkAjixZ0RNiZfhk=;
        b=KYU8pyKSh165TQA7H6TDL7YCDIZcjaRwMgpJlFRvL/BZO+AfSICOHcEDNibek5cnCA
         sa/9m9ktWx7bm/hzLsoQz9JNi3qUzVTp907JX0sZiMlFqcyt4VhC1bmvxX6uwsmI/nq3
         qXEodMqzHocO3m3gaI/2Xni4ihbvGhTvn9WlU0yUkRgTeD3lm5dEJ9HXXtKVVhnT0K12
         W0MK5qCJwNIVwLgFA2sd+ti36WX3tBHQujHp5YahpAfT1QYLSD6XMHwZ8VwGmxus8eFH
         SIKqtaHvKEt7zMehIXy3i2daMpH5w2OK47olLgdt60aiekz4AtrHFKcW3rHyUgHJC5Ot
         KBew==
X-Gm-Message-State: ACrzQf1nD8v9n7tpzfjXnEAKC2vqIEpEIRBtxqgivWRRNh89ntnqfAL1
        m0WF2LvuNm4RrE+/6XRSRL4lGg==
X-Google-Smtp-Source: AMsMyM4XRJrleKDViEuaZRBXI1jBxAocsRDssr0ijqLzj3jQlNSUTePImEmO8W2wY2lZWQg2nXW4cw==
X-Received: by 2002:a0c:e552:0:b0:4b1:86f0:89d5 with SMTP id n18-20020a0ce552000000b004b186f089d5mr456508qvm.97.1665676584224;
        Thu, 13 Oct 2022 08:56:24 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a0c4600b006cec8001bf4sm65280qki.26.2022.10.13.08.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:56:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] ARM: dts: qcom: ipq4018-ap120c-ac: Add SoC compatible
Date:   Thu, 13 Oct 2022 11:54:17 -0400
Message-Id: <20221013155418.47577-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013155418.47577-1-krzysztof.kozlowski@linaro.org>
References: <20221013155418.47577-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qcom,ipq4018 compatible fallback for the SoC.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
index af9a26fb5d4a..a5a6f3ebb274 100644
--- a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
@@ -6,7 +6,7 @@
 
 / {
 	model = "ALFA Network AP120C-AC";
-	compatible = "alfa-network,ap120c-ac";
+	compatible = "alfa-network,ap120c-ac", "qcom,ipq4018";
 
 	keys {
 		compatible = "gpio-keys";
-- 
2.34.1

