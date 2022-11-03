Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32BF617A75
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiKCJ7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiKCJ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:59:03 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22449270E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 02:59:03 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id b62so1260403pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 02:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFJpBjb6QP5w8jom1mD9aX3bwJzFPKeDTupRGJObZls=;
        b=GPyvqSiEiv7CDnFXCQebtzu42nMnmronzlVeq0HyyGG+67EgFq8XuQqFisBJ9VMtlj
         fzM55rgS1L+vG2BkCNC2Ks2AAoNaTI7n4jl/A42fpcLxjfOwGQDseqBRL8Th7fs07yLV
         Q7447FBwhgZm87ODQpLa7aDDBxkyDh/N7/WKERxZcYhTyynJz3L/F+2kPd3lQ+DBrvqJ
         54rWM/0cwUcwLXhhORmgjFaf5P1mknW7xVeujQ00MYNxEGj2KZ14f0Icuap1o9EgJn4p
         6hDYXPCnHi6w5AbjpKMwRsKLEX1sxCCsUSxk/PEJH3Hv/VcgQF8ZcNd/KOyrLqNRm6Ku
         A3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFJpBjb6QP5w8jom1mD9aX3bwJzFPKeDTupRGJObZls=;
        b=wDPrYXxbfH+N8QIfz/R7N2hefYSHR3MkRnPKiRmBw0bId/oo5+yDwmVIMyXvlecr9r
         f0iyXDc15yOkfGqMkjx7FURBW2Vf0KV5d1jgs/boaUC5iJJAPizjQQJ/IvjcvkrcM/Tc
         KsYg3e7Qzh1tBX4xqk+JRv1SczC1P/84L5GKi1NlR/12NgL5a4dmX3mt+gY+fDm7v8Vk
         PtD00aVo+OPiEC/ATSsIP5wSU0kun1ieenHI+Xq3hT9HMq1f8x8etCcuo4pGnSK3lvkt
         YTUxYwGNEL/pkoLvNGqf+BFi4upT8HOwbsvklCrxD/yHNplMth+XbGQGetA7o/FvyFXi
         CHcw==
X-Gm-Message-State: ACrzQf2J4dZzuG2ahDtt8xjroaqLIfflvdfBzPgWNO9t5izUsh5+BqFS
        w1+9ZFSfaQUSPg7BUVm77cmp
X-Google-Smtp-Source: AMsMyM7uNucJzy/u8Hy9a3AFwkRjwXVdJKw+xrWgi8fiXd08XTQ2W2tfuMW4U3Jt+MPSJi/TjAA8bQ==
X-Received: by 2002:a05:6a00:450d:b0:56d:9ec6:4ddd with SMTP id cw13-20020a056a00450d00b0056d9ec64dddmr17165048pfb.62.1667469542595;
        Thu, 03 Nov 2022 02:59:02 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.64])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b00186c54188b4sm161670plf.240.2022.11.03.02.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 02:59:01 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 07/12] arm64: dts: qcom: sc8280xp-x13s: Enable PMK8280 RESIN input
Date:   Thu,  3 Nov 2022 15:28:05 +0530
Message-Id: <20221103095810.64606-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103095810.64606-1-manivannan.sadhasivam@linaro.org>
References: <20221103095810.64606-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable resetting the PMK8280 through RESIN block in SC8280XP X13s.

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index b2b744bb8a53..6aa8cf6d9776 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -169,6 +169,10 @@ &pmk8280_pon_pwrkey {
 	status = "okay";
 };
 
+&pmk8280_pon_resin {
+	status = "okay";
+};
+
 &qup0 {
 	status = "okay";
 };
-- 
2.25.1

