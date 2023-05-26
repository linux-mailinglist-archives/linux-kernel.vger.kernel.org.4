Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E36A712D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjEZTXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243809AbjEZTXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:23:00 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFE6E5E
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:22:56 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b021cddb74so2348565ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685128976; x=1687720976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bfn7W4wlvGKYY1Xv+0AM7IhBXt2kfIwNQPmd+vEv/4w=;
        b=Dtoy7ewh54wR5VT72iH4ijb/9S+LZy3gcmEkuL3y9fXW/n43FVEitTHRQhuWvtZSOg
         KA7OKe8eJ3Mosl1THk8rMj+NSGnAmVmHIJ1Lk02nAqUwFpvw+i0aMp4SbTwyr3HAWnp2
         JOhXtWjEtdochNrzeiJmvZtuw3TCJxpCMon/9fr1hloWj0W9SVPjI3BuiGDEQUXbNcaH
         IvcPLGvRtVvw23Jxo/0SS3B58mRuAj2X3XtAOz99PzN0hfQ95yKL0JT+80glWyrCaEHW
         2cjZ4au835aDEGbdkFmtQYoDVRbRTF5LqKIFCMTTjbFzcrKh0SMiGDH0ISd1sIhP7QIf
         axqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685128976; x=1687720976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bfn7W4wlvGKYY1Xv+0AM7IhBXt2kfIwNQPmd+vEv/4w=;
        b=aFpMLpVIKaE4L4I9y11yHfVASF7npqmFQ4CNPmaeQks0SpqDu6tLo8Np7eP/UnWfZN
         mWg6JiRRI8bDm93wSbyX2zaEn7ZUtAUqTKaSSQWxLhcib6TloP1OLeqD34On+B/exeNs
         v1nuGMaGXSEYAmTWu1jfyfD/CHEMQouD0w1s3wW9vTwN0r5HeYWaO1KedgZdzbveZsY4
         uT36HVk9ByMUIfVQTorHdf1vOg2+xNg3Z7lYRNv++vCks++yBJi0PEHi1lFsDMnDakfT
         w2yses46lPqGaGGb78UfLKNQLyuZ3GsB0xdfS9vcGQZWZCo1JGDTtdixI8Ev0A2uZLNf
         94hg==
X-Gm-Message-State: AC+VfDxSxK4Ifbjz6gvzEWyaHqxqYle8oHxId2M0dxvjklxY2g69ufz4
        0NrXnfj9TvwSMJ5z5uJl/0B/yw==
X-Google-Smtp-Source: ACHHUZ5wANoFsNTRQmDGKRNutkbGrk9m4YPYtyi77j8epfqprAhfnQpkcsQ20alJ3V6q4FfYvzj5SA==
X-Received: by 2002:a17:902:d4ca:b0:1b0:440:7f5f with SMTP id o10-20020a170902d4ca00b001b004407f5fmr4451943plg.49.1685128975895;
        Fri, 26 May 2023 12:22:55 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3a:6990:1a5c:b29f:f8cf:923c])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090311d200b001b008b3dee2sm1955079plh.287.2023.05.26.12.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 12:22:55 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org,
        stephan@gerhold.net, Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v8 04/11] arm64: dts: qcom: sdm845: Fix the slimbam DMA engine compatible string
Date:   Sat, 27 May 2023 00:52:03 +0530
Message-Id: <20230526192210.3146896-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
References: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per documentation, Qualcomm SDM845 SoC supports SLIMBAM DMA
engine v1.7.4, so use the correct compatible strings.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cdeb05e95674..0d1d7328cd62 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5221,7 +5221,7 @@ msi-controller@17a40000 {
 		};
 
 		slimbam: dma-controller@17184000 {
-			compatible = "qcom,bam-v1.7.0";
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
 			qcom,controlled-remotely;
 			reg = <0 0x17184000 0 0x2a000>;
 			num-channels = <31>;
-- 
2.38.1

