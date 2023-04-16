Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0B66E3824
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjDPMiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjDPMh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:37:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B476230ED
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:37:56 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a5so722251ejb.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681648675; x=1684240675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0HPx42QUlUrIgol6iT7rI+K2Mx3HeR6PV/33hfPyrk=;
        b=u8/evSXUyc8lUAiyGXDKvua7QJQUTv5TZJhlGuTyc0sB+aa2xuqONXI0+WrwP3JTfl
         N3X88Zu+j5wFQqeocutBPdlb7BGJ7l6983SgyOOhWV7JGrLHEwOJ9qmrAzUW6HWnuf1j
         OkeVIb0JOY+GQ6dNnZNeGmuoJDM4fuFC2U71OXd1b9cDr1pPBJbvbFwEk5I/dR1f0ihO
         ORE03qDPqm9b+rbe3dtJ2ngIHn1OOr3LmuGnKRIHGhI0ooVoefYMDU2bXKt1GhQaJPBC
         uNc26anBAbmYoSQTHl1H7F/GzVWz0B1xYyUmL7JTrviJBezglvQDvVqAcim6Dbx9Ac8x
         NarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681648675; x=1684240675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0HPx42QUlUrIgol6iT7rI+K2Mx3HeR6PV/33hfPyrk=;
        b=A1oeBjojw0vKnN3lAw0oXjnXqC2ass4EraefLounjAmWehTJiNvgtp6H/nyUT+/zId
         q851JjRqL3SaDJhiUgZBVqNDlcu6IxRrgp8yzhTd+PeRGP2ldqIHJcKCzHN5mx4u/g+n
         0tR9nZl4LJXRMGrWLmvr9p7o+MtTmixSrHAHB3r5UvsfaXGFyyVKcpq+yxehLc3/omjZ
         gxRHFqFjkU5+glaFBLUrrDFVPHmxOMfgA8LBXYNJ7BzGV6Lar6VTgFdaqif9Cyv3LOna
         qH0gLoE6YP4CG7trBlIrSBT9TlV7+BpViFXHYMhMYdEKsTg9fIFn4Gd4nYNFLho6kDPR
         9yaQ==
X-Gm-Message-State: AAQBX9ctHSJ227zsCj1as3jOFPNVevupTTl2DOOwH9+VV6zaQ5NjTuuh
        NrJTUlJAvJuWetplyYq92Ue8ZQ==
X-Google-Smtp-Source: AKy350ZUVn1slojtD4IsCWk4vIejtqMK9/KVGcdNaKZhs9zUjwUfAvjAnepDlhC4f1EGSliGIoFLbg==
X-Received: by 2002:a17:906:c407:b0:94f:9f0:e897 with SMTP id u7-20020a170906c40700b0094f09f0e897mr5401002ejz.38.1681648675166;
        Sun, 16 Apr 2023 05:37:55 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id j23-20020aa7de97000000b0050432d2b443sm4556889edv.48.2023.04.16.05.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 05:37:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/6] arm64: dts: qcom: sm8550-qrd: add missing PCIE1 PHY AUX clock frequency
Date:   Sun, 16 Apr 2023 14:37:29 +0200
Message-Id: <20230416123730.300863-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230416123730.300863-1-krzysztof.kozlowski@linaro.org>
References: <20230416123730.300863-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8550 DTSI defines a fixed PCIE1 PHY AUX clock and expects boards
to define frequency.  Use the same as in MTP8550 to fix:

  sm8550-qrd.dtb: pcie-1-phy-aux-clk: 'clock-frequency' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index d5a645ee2a61..a08aa438bba8 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -359,6 +359,10 @@ vreg_l3g_1p2: ldo3 {
 	};
 };
 
+&pcie_1_phy_aux_clk {
+	clock-frequency = <1000>;
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
-- 
2.34.1

