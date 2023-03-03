Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823AB6AA4C2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjCCWq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjCCWq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:46:56 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F95199F9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 14:46:12 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id z42so3823065ljq.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 14:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677883504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8raBTXfySji8fpCPLBYPhkx+Ml6mdyfbjzhF4yIreP0=;
        b=xoIo8qJArvmh6/FgZUqXzIJnnr+wKRNzq4eRC/BARmBUhb0UMHlrwrusCNYxhUIVa0
         Ui4t0Lv3aNcuNYZccNgUL4B7xkGqA00k+vTBF4AK8OclWHIlxqHJBE0f3V3M7X/hrJR6
         lN9knuP7pvzoP75FxpxKeRmLwoeCzZyIXnBpBJTnXFpks5NpE8W67Dt9RepJWWzRN7I3
         7NRcSoiGIB03utjsxHif5VpTYjNo2Ghq9yH1A9irz5L3KeirO16f2kORWtz/I6Xqrpa8
         pBklWidSmBKiVMjRuA1jC68if9GdNygaiWZuV6jI7rPqj+/eTQUUMeew4mzCzp0Eq/W9
         Z0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677883504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8raBTXfySji8fpCPLBYPhkx+Ml6mdyfbjzhF4yIreP0=;
        b=le9B+4ffVAsaVLKs/x1Z6Os31MGu+W0K9M2UOBv7Wu6mSnGzKu3kgtpDODbCyIEYRH
         bN8mMRyvca8jZqOzntRUZRfXHcNPCk8qUbI5vXC+56JEm/inLqfFvzS9VwnKgUHDegok
         9Slv0fT7UHgDNR0ANNSkaCS0NdAFjgeeXqG26WXpAFnMQd4MdOQqkLxD6tKHPtVtYKo4
         3LuPlks/x13L3Y6APtvL2WqLsl9eqboWuWhVx4gUG13JqmcdPf48OoZ2vHTBi3hsliuw
         wpa9oOpCQeCS/RXHAi4WVRbHYpHQijvgjoNt3ZJ7PiB2ybw/4dS40zVEZbkFabHmCNN8
         04eA==
X-Gm-Message-State: AO0yUKXTB/DSo+cFBx3P5NSBxJsxE9kw11cqkfvaq8kYsBeAnDFhqj4z
        BtWrtfOYC+PZv/DrLaDVsLbkK7rfGrDZknzs+oY=
X-Google-Smtp-Source: AK7set9dHnVPJdpQHv/CLdSNRU7NCSWy7pxfL4tnOClqRR6cvV1Uwnypv4a6xYhpfqs8RyQdan0HSw==
X-Received: by 2002:ac2:4a74:0:b0:4dd:a212:e3ca with SMTP id q20-20020ac24a74000000b004dda212e3camr948621lfp.11.1677880697243;
        Fri, 03 Mar 2023 13:58:17 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id e27-20020ac2547b000000b004cafa01ebbfsm552670lfn.101.2023.03.03.13.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 13:58:16 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 03 Mar 2023 22:58:04 +0100
Subject: [PATCH 04/15] arm64: dts: qcom: sm6375: Add RPM sleep stats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v1-4-8c8d94fba6f0@linaro.org>
References: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677880689; l=761;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DKx+rSMb2n+6CPR4L2fodh6IzfCfn+ctrSy97qX3zGU=;
 b=ieZzG7g5ztbr6xl4XS6hT/hcGYS9CF9DgfDN9kVdowHP4hjJI4xQiPH4AVR1FIGts7rPCJkZkEgF
 93W+nIO6DG1CU0I/gEWLtzQLXcAtTQB/8iAm6c0HyZxqWpgY77Db
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for RPM sleep stats to enable sleep monitoring.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 31b88c738510..de5882c0ff81 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -718,6 +718,11 @@ rpm_msg_ram: sram@45f0000 {
 			reg = <0 0x045f0000 0 0x7000>;
 		};
 
+		sram@4690000 {
+			compatible = "qcom,rpm-stats";
+			reg = <0 0x04690000 0 0x400>;
+		};
+
 		sdhc_2: mmc@4784000 {
 			compatible = "qcom,sm6375-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x04784000 0 0x1000>;

-- 
2.39.2

