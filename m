Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD23E6002A8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 20:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJPSEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 14:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJPSER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 14:04:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8192E2F018
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 11:04:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n12so15111173wrp.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fe/M3BtJEx5biARpyDFVvoQN+eQ6J3tXBkH3EpL46Fs=;
        b=OWmXAT1iBdOq1G4kh+sUNBucMG35LEcXWnksatc5WMZAvIQUsJc2BXmBxahy+D9f2o
         0oGMRFWKUjN1nhO+BIuCz7+F9XQM3AbFnxI9caj3RSNUeR4rMwXhw330PFGPPKLQYBfV
         Fofimy2BjmcOurmnm/+zx6l6QmMqIaTuobOGP5xI0IS7e4LNP5m4oi+CS+0XxeqpbCTb
         XiAxe7etrC/M4ncyGMgfITHhR0d6+o2rtRDuuBd0OhiVTXXGVOUgpPxZ1w0paaiDE1D6
         H1DmSaE8RdKXyFG30v6X5aTqxRqFPINm8IHGGQg9dBwA/9+VqNP9qqjtAHKzvkYe1aPr
         LzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fe/M3BtJEx5biARpyDFVvoQN+eQ6J3tXBkH3EpL46Fs=;
        b=rYojrtgKe6Cq+CC/cGmZFlnGqVUoTC3xv93w3VCWngBYXF8wrr/XThfE2XHb40USwb
         +Z9b/5eaHv/yUG8vkXfYtjd5mpuDZ502WwtI6eopt0H+FTHGwU2wgQDr+GZCQX1zHLQ1
         zOW9bLtehuhmcuKty888P0AFrtXDn9+HChSMV26EFy8I2aT/ZYWVM6nlr7lXaJJAi4qM
         u6t5cFM/L+sxli6bP5CYUFb4J/foaRIRA/R8QlPlM0RgmbUnbJYyjG5ntZiA1nKEZzHt
         bgxcXdgrTVVIZWgOKHDFqWOQ5U93FfU3BJDSuXCkXP5V00GDRQ6K+Pv7QmnjYroZUtm9
         +bDg==
X-Gm-Message-State: ACrzQf3kG78imFCfzedjynZT1ewflpJkAeGPs9yCz9NLyEbQOI4GUFNX
        Ks84JMVr2HCiWeNrpXfB1UmJtQ==
X-Google-Smtp-Source: AMsMyM7D2VyZf6FGxMkmjwXFUNqzT06DWpUbiiwUB6FTiShabEHWfkRENPFVN7pb2IlJG7gyyV/VMA==
X-Received: by 2002:a05:6000:1e17:b0:22e:618f:b9d8 with SMTP id bj23-20020a0560001e1700b0022e618fb9d8mr4071288wrb.280.1665943455076;
        Sun, 16 Oct 2022 11:04:15 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net. [86.14.22.118])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d6d45000000b0022e57e66824sm7844181wri.99.2022.10.16.11.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 11:04:14 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org
Cc:     Luca Weiss <luca@z3ntu.xyz>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 5/5] arm64: dts: qcom: msm8998-oneplus-common: enable RRADC
Date:   Sun, 16 Oct 2022 19:03:29 +0100
Message-Id: <20221016180330.1912214-6-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221016180330.1912214-1-caleb.connolly@linaro.org>
References: <20221016180330.1912214-1-caleb.connolly@linaro.org>
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

From: Jami Kettunen <jami.kettunen@somainline.org>

Enable the Round Robin ADC for the OnePlus 5/5T.

Signed-off-by: Jami Kettunen <jami.kettunen@somainline.org>
---
 arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
index 62bda23791bb..5650bf5e604e 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
@@ -279,6 +279,10 @@ vol_keys_default: vol-keys-state {
 	};
 };
 
+&pmi8998_rradc {
+	status = "okay";
+};
+
 &qusb2phy {
 	status = "okay";
 
-- 
2.38.0

