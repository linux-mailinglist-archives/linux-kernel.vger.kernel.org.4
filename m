Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E596A81BD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjCBL6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjCBL6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:58:32 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB805C642
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:58:02 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id f11so4362644wrv.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 03:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677758273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9XPg1Z52HjMq8E0v0qy12uZXmzko/h/NRVbdc0uh8s=;
        b=i3QL/EwRJB2/0Ne1csLoG3EdF3JqWTwRZ8H5AvroPf9H2zOe+fHIej+kO2r14Fsxaw
         PdxyIElrMVK9ATDXMyRhbtXnq2vPabZ2bsx+lCgGWXW1Y/gOSu0cJEnDqiUr8oVYR8nM
         6MrUbGCPvHzGAZlXB3KrBKTIDts8odJmReD8zDRLslUgIkrsCpddG/n4gnphMovgx0IP
         LPFFx6SeSc9jz65eTsLqCxMV+tPASATsYDveODXBUx+6rZ9OhkO4OJRjxODvvhyqZJIB
         b5BZ6t2Cj52BptS4Gw6JejdV/cxhGnyqfMCXtY7ETV50R8M3zw+fg4nmHIH2ZPn4NQf8
         Mg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677758273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9XPg1Z52HjMq8E0v0qy12uZXmzko/h/NRVbdc0uh8s=;
        b=0BUrlEBCsYX0W1e4wnVoT3+mdacXeHzoXrq+qbHUsowCwtqPElnZ6w3P5i9raSyXcd
         aJ3jtm1MAOsWtmg7LajcViVq8r5ut7jSnnF0wbipkHJPwItCrQVxJ7j7E2qTWnpfzaK7
         /NP02zSkSub+/K4igLyxEhYgbkQRji3xKk0tT3vpwX9XN1EDFRv66vmV4Zink2F7rxGj
         6xhY/+7uK0XjNLF9Re5dSn5GHp4S+EoCJYY4nwswfmO0RJAcdrhjyb/8MdN5TUCAigwn
         WVucssHfQheJGb5IgC1/MNcowC9chDgbr4crRH/X+tTRR3IKiF9OU6zNbbFLKE8viLzO
         xguA==
X-Gm-Message-State: AO0yUKWNkCA/PMvXP4t6/E9/6MVyeEzFFE5eDdjQwW2b9Gw0VLLAQkbh
        bhj8JieOVr0TOuA6ZxfCDPDU4A==
X-Google-Smtp-Source: AK7set+ce1McbLrytRvdw2eK37qzNDxYg7cD5idrh0Tf9V6wFeG6zE0K5jPlSmnnJcZ+eTs5BOhsFQ==
X-Received: by 2002:a5d:6b10:0:b0:2c5:55cf:b1ab with SMTP id v16-20020a5d6b10000000b002c555cfb1abmr7226256wrw.48.1677758273329;
        Thu, 02 Mar 2023 03:57:53 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d4a50000000b002c5526234d2sm15298209wrs.8.2023.03.02.03.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 03:57:52 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] arm64: dts: qcom: sc8280xp-x13s: fix dmic sample rate
Date:   Thu,  2 Mar 2023 11:57:40 +0000
Message-Id: <20230302115741.7726-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230302115741.7726-1-srinivas.kandagatla@linaro.org>
References: <20230302115741.7726-1-srinivas.kandagatla@linaro.org>
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

The version of dmic that is on X13s panel supports clock frequency
of range 1 Mhz to 4.8 MHz for normal operation.

So correct the existing node to reflect this.

Fixes: 8c1ea87e80b4 ("arm64: dts: qcom: sc8280xp-x13s: Add soundcard support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 198a81405e6e..d18d405d1776 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -1111,7 +1111,7 @@
 
 	vdd-micb-supply = <&vreg_s10b>;
 
-	qcom,dmic-sample-rate = <600000>;
+	qcom,dmic-sample-rate = <4800000>;
 
 	status = "okay";
 };
-- 
2.21.0

