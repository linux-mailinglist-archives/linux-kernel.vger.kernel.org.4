Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5510740227
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjF0R3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjF0R26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:28:58 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4506C1984
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:28:57 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b69e6cce7dso43269981fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687886935; x=1690478935;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pAqs7r6SvR+yOhTRuHSNI/21zCFg6SVkCE8s0PfadnQ=;
        b=SIE+M9V2p5nTcV1H7bNykf5wfP5sT+Gx1EX9Z+I6DBsTm1VCuHcWTH2luB1TIetDx5
         rt9I4cQskYywKSNuj802bXH6ifa2S1CKeyebaleeWiZaB3I9+n/ttiNvZuRIsN6Hvy1Y
         XDs2a1IBuiro4C8t7tOSBIvjVhmmGIY+eF0RhDXI1SCYwYEs8DE/HjNqPbY34EkPsC15
         2bIPeynIG6X4fWaC1QK78LImWSX+4m9fxfrJ/RctkCyhifNfucQhelgj35MLia3MO2Fp
         Hawi11ROeYASATgyytIYYe/l95qA8W+mDCDvlVhCgMf2CD3xUkL8/w4SL2Zdj+18nVoL
         eodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687886935; x=1690478935;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pAqs7r6SvR+yOhTRuHSNI/21zCFg6SVkCE8s0PfadnQ=;
        b=Wwckvz+gJuli0RH618aq9MT5SHoah7H9qg6vzsmxddQvejIY4bN7AoDcXChKT1hwDp
         Tak7CJWLIzIL1OH+u1nDHDQFlLeM5W0q05xkzM6t943aSHf4sJ/giz8PzPMXDRZ2lV1j
         CSMDSYU+3LuQlpYVjtF36hmZSUsc4zP5H1AXCwELb02A7mAMsVl/nNO+k0vD29OxnFmd
         RHeDE9A+7dshFz/RhPG+QvYp/2URIbKjebNDpu1PqFygyZ8y8twWuNBEE8Q374Vfadpa
         S8IZCkab/azRQ/LxAQyV3MvRTXrFqgyEgItm2oY83ZY14Zdg8G8b55HDqvA0gt9Nc8RZ
         60hA==
X-Gm-Message-State: AC+VfDynFlA/IwbolkFqOL5tsEU7IOqr1w4GO6Ugqgc+w66kEM+iv+tq
        kzUNM53sKz172Op2sJjV1Vx/gQ==
X-Google-Smtp-Source: ACHHUZ5ssiUwtSzFyEjw0dsCS/0lJJxjnNajJxOH+p3A+S+kslalWizXb7CU6H2889Y+FoKgkZ2SNQ==
X-Received: by 2002:a2e:3502:0:b0:2b6:98c3:7a70 with SMTP id z2-20020a2e3502000000b002b698c37a70mr6009803ljz.41.1687886935527;
        Tue, 27 Jun 2023 10:28:55 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id t9-20020a2e9d09000000b002b6a0ccc106sm1159633lji.12.2023.06.27.10.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 10:28:55 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 27 Jun 2023 19:28:52 +0200
Subject: [PATCH] arm64: dts: qcom: msm8998: Provide XO to RPMCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230627-topic-98_rpmcc-v1-1-4024e43ad0fc@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFMcm2QC/x2N0QrCMAwAf2Xk2UCNoJu/IiJtlrnA7Eo6ZTD27
 ws+3sFxG1QxlQr3ZgOTn1ads8P51ACPMb8FtXcGCnQJV7rhMhdl7NqXlQ8zkiTqO6HQhgE8SrE
 KJouZR8/yd5pcFpNB1//l8dz3A5om+tB1AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687886934; l=842;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JdUcoODkoasJyIKr57QND46EQoTekboMCKVsmUAjA9g=;
 b=5xuq8iYoHYEUFL/xuxh/lOfp8qw80seNChWK7HHRJ/kk4TszwQVC8u5ffo/hrKjwiSTL5uQyM
 i09UfdN2xH8Cug0aTvBAKQ9owe4GtzmJXHhWtDj1zeCsns1A/cRrXRe
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RPMCC node should be fed a reference to the XO fixed clock.
Do so.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f0e943ff0046..171f2e21d80a 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -334,6 +334,8 @@ rpm_requests: rpm-requests {
 
 			rpmcc: clock-controller {
 				compatible = "qcom,rpmcc-msm8998", "qcom,rpmcc";
+				clocks = <&xo>;
+				clock-names = "xo";
 				#clock-cells = <1>;
 			};
 

---
base-commit: 53cdf865f90ba922a854c65ed05b519f9d728424
change-id: 20230627-topic-98_rpmcc-2eb2d9e2080f

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

