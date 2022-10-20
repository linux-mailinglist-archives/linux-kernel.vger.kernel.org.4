Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F00606BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJTWxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJTWxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:53:16 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E68021E12B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:53:14 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id u7so679991qvn.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zd9RqS9ddRq/iWYm6pmISfmwZ51rkrQtG7QRiWUtEbE=;
        b=mvXfb1oVHh9SBSaAzOUJ7ks1uBI7UU7rUb0yktkmqh6ZFRxSnz+K1GE2yNRTkWFJBo
         CIuClCxPvCRWs6H54lOeP6ZZqepx/M5me17V7uwc+7kEbsI8Pq4k6n7lQp7KUE53mxAf
         J2+3UfZmsXyQjDKA7jFOnztH18R43N8UoRj4nQNj70iQ1J5j0k34PHYVQeAqYxWZbcoT
         PNleiitir94GZ1Kr3MzS2GpCkZYoq2vogDjU1p8WPvYhD+PZg0GmV4iRR0mWAgtXdU8M
         Mq5AMAArLFo7mKZX2TQR1OOGCXjT2E6kkWWWZbHQi4Iv//HxfpWRO/3zVi8nEGz8DJ/J
         JbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zd9RqS9ddRq/iWYm6pmISfmwZ51rkrQtG7QRiWUtEbE=;
        b=gjeTQFe8jHVskqJo7oQnEojJBdkZobioQmL6R+pCWJ1/qSREm2ICIJIYHvyDhW9G33
         2/sf4oo3PfB5P6ydqay8bHlv9aGk3NbW1++zUUJcrF3Smu7xxUCTV30pZYCes7sS2J9t
         Mqz/GcKjadFSHKWLuMSoJGdJaZjHFxvma+PkhxxfiBtbLGJ/ZMWizqzeF6ZkCpr4Mb4C
         YKjFF/HrHWNxdGSZmX5BcwFRKbSvM+Ln+5qurlO1smE6xMN/TD8u6YkPtWoTfRpLmfnS
         cmOScMNgulcFgdp1seCB6AFnbSq0qs84X+2rkTKtDm70GrGEijLkrGhKraAZnqRxpMZb
         SOGg==
X-Gm-Message-State: ACrzQf0Ga/+vNX5RvcZjPcYe5g5qxIWjwmKXgLOxVMFh2y3jt+mADn7g
        rYeIIqfIBpGe8LQaagZCqkGRaCIvb/BQJw==
X-Google-Smtp-Source: AMsMyM4ZL8wYqXyklUoQzpkw5T6KgA/iAyxf3KIKJD2gNtWDY1LdOk/g8Qs47KJeefzN0r5Zebz0iQ==
X-Received: by 2002:a0c:a9cb:0:b0:4b4:746d:c0e7 with SMTP id c11-20020a0ca9cb000000b004b4746dc0e7mr13649706qvb.48.1666306393071;
        Thu, 20 Oct 2022 15:53:13 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id h19-20020a05620a401300b006eed47a1a1esm8556773qko.134.2022.10.20.15.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:53:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] arm64: dts: qcom: msm8996-sony-xperia-tone: drop incorrect wlan pin input
Date:   Thu, 20 Oct 2022 18:53:08 -0400
Message-Id: <20221020225309.32116-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pin configuration has no "input-high" property, so drop it from node
described as Wifi host wake up pin.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

---

Changes since v2:
1. None

Changes since v1:
1. Add Rb tag.
---
 arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
index de61c3c94903..cb9a169bb38b 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
@@ -912,7 +912,6 @@ wl_host_wake: wl-host-wake {
 		function = "gpio";
 		drive-strength = <2>;
 		bias-pull-down;
-		input-high;
 	};
 
 	wl_reg_on: wl-reg-on {
-- 
2.34.1

