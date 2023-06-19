Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8FC735C14
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjFSQTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjFSQTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:19:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8C0E4A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:19:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f76b6db73fso5698303e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687191539; x=1689783539;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NeMEcI4+yKDWLM0Xoh1q+uyo2M+zCM82XkXiL0IHChQ=;
        b=ERW7c9xDG11GsK8JfvPDwgUNzimXYc7k+0n+cwTtPkx+e/eN0Mc4b7g36HaVVsUT+2
         ZwcynuPACuf5rZr2c+/pXN9FyIhLZ7U8CFeaslkmnjVpcy0SHCuaxcDOGMISALDUdcRL
         sPUNNeCvRlt7d3PUcwA6sVCvxjfL/E6pOx8hYTSgmje7gyKTVGGVtFt5Kpy7t5owt/bg
         t6Hnm1z6KXcDTrz5bMOr+avoiyHZ8umjH68N60bfHlmapbzIsPHF0194rN665irS50v1
         NUxZWnvzBtSBADz4Wuae4ug52F/Of06tqhh1niZWQ+4ytTuWWnqj5KfMue7ScIQbiSjt
         KLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687191539; x=1689783539;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeMEcI4+yKDWLM0Xoh1q+uyo2M+zCM82XkXiL0IHChQ=;
        b=gSp1Tn5+xvBo+GyWBB4LerkDQyUcjglYfpDZB0jJc2RN4wp741HP4nfzNSbs/iONR+
         eMo2bHHIAkU8ko0sC2RJJQV5Nb+vHK+v0qxR9zBYsbqjg+wAuWdpvKj8xrYPpm/WzkVT
         fmEvcEUaKcgRIHLwieg/mBsgemXhFGePR/foMlcDOixIL9NJO1HX1Don8uDfGCiD82Vi
         lZTlCASS5f4k/bTWD+l6EaNXqoDOprgrPpEk9NYsvvDgQsjveNASQivhvjtPL0bRXnAY
         cvbLt+tJAaYfJt+kCf1C7OGKWst6UYxERSo05EexhaM5MqQ4UfU6HkWayRUNGyiRSSZ0
         fBFg==
X-Gm-Message-State: AC+VfDyo8mvtwXcCnDNz4G09ftGCDVeYI6Fr3ZKubUTJ+OKQunqMGv7R
        ei6BMf+14brMMOhLWHz0AEWSmg==
X-Google-Smtp-Source: ACHHUZ6iNnONLcUHaRD6LwY1bDzyrM6RE9wksQs+lZAEVUHBzQ3Teny0MCjBD4PNxgZlft0/pI5ggg==
X-Received: by 2002:a19:5f5d:0:b0:4f8:5e62:b94b with SMTP id a29-20020a195f5d000000b004f85e62b94bmr1804453lfj.9.1687191539015;
        Mon, 19 Jun 2023 09:18:59 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id c11-20020ac2530b000000b004b4cbc942a3sm4332824lfh.127.2023.06.19.09.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:18:58 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 18:18:55 +0200
Subject: [PATCH RFT RFC 3/3] arm64: dts: qcom: sc8280xp: Fix up idle state
 periods
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230619-topic-sc8280xp-idle-v1-3-35a8b98451d0@linaro.org>
References: <20230619-topic-sc8280xp-idle-v1-0-35a8b98451d0@linaro.org>
In-Reply-To: <20230619-topic-sc8280xp-idle-v1-0-35a8b98451d0@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687191534; l=1802;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=mq7mfTgr9ZtvOEPLMaimjrbNtQBLNamSOSbjgI89DqQ=;
 b=5zkt0CsawhYgMHbQ+uC07azdfetKN9uRQNsiWgI4WMR5ahWeGTk+03QDZRCGWFHV2YpGTc64b
 bDozYqakncYDn33+Klx7kP0OU9HayubPhGh42pPDLv++NgW8eB+lqCg
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the values were wrong, which may have painted a wrong picture
to the scheduler. Fix it.

Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index b8f2ec9477f5..d7894465a0d2 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -277,9 +277,9 @@ LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
 				compatible = "arm,idle-state";
 				idle-state-name = "little-rail-power-collapse";
 				arm,psci-suspend-param = <0x40000004>;
-				entry-latency-us = <355>;
-				exit-latency-us = <909>;
-				min-residency-us = <3934>;
+				entry-latency-us = <702>;
+				exit-latency-us = <915>;
+				min-residency-us = <4001>;
 				local-timer-stop;
 			};
 
@@ -297,9 +297,9 @@ BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
 				compatible = "arm,idle-state";
 				idle-state-name = "big-rail-power-collapse";
 				arm,psci-suspend-param = <0x40000004>;
-				entry-latency-us = <241>;
-				exit-latency-us = <1461>;
-				min-residency-us = <4488>;
+				entry-latency-us = <526>;
+				exit-latency-us = <1854>;
+				min-residency-us = <5555>;
 				local-timer-stop;
 			};
 		};
@@ -324,9 +324,9 @@ CLUSTER_SLEEP_CX_OFF: cluster-sleep-1 {
 			CLUSTER_SLEEP_APSS_OFF: cluster-sleep-2 {
 				compatible = "domain-idle-state";
 				arm,psci-suspend-param = <0x4100c344>;
-				entry-latency-us = <3263>;
+				entry-latency-us = <3638>;
 				exit-latency-us = <6562>;
-				min-residency-us = <9987>;
+				min-residency-us = <9826>;
 			};
 		};
 	};

-- 
2.41.0

