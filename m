Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8AC735C16
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjFSQTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjFSQTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:19:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB9CE61
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:18:57 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f867700f36so2605473e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687191535; x=1689783535;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fsaki9f+UZgl1Nxe4pywUOtc38gD6sbALTtH94iAX+s=;
        b=br9e16MGjHz82Yi8wkrnxP/PnHiBCOyExOzGrmUAT8y4L5ibrtZ4bjp0JluVECizki
         F5d7C/CxoGYbCmZwMNhQ5IEOSH58CsK7mrGCn4LLzLgP+cK4a0P5odGhXp8N5FLGiFz/
         rXnCDJHiXWgpDS23TaGCy/cfrl5lva5Xh4zamJY2xw36rIBZh/9X4HHj/+TSgGOt5KOp
         QTf9bvqUNd+ftWGY8NwjX6dRC/rMtYDo5j4UqMWhgREsHD0U7SbfM/x8wEm2FiD92st2
         WyAe15+NPpZq0r0JffPV/6BRKiwiO81PB/dWH8OgGXqXmeVH6GtsLV62hB1nIcT+FPk6
         TOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687191535; x=1689783535;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsaki9f+UZgl1Nxe4pywUOtc38gD6sbALTtH94iAX+s=;
        b=DE/FU0xWEgeKluhsu/Kud9zH2Dny2F6/3C3NjpCo2jN2sEjhhc0ckskQ/GgzSUbMIq
         f2zxQ9Rmrj72h0wD5qtF7KpkMGYkJgEbAir654W9gP91LzTxxEZ5ZicxyLjquqFO6/Ru
         87+BWeRu/pJfel8u+pyjJ72P/CAo6yKdVMwf5VXUmbAJhoeHOauF4gWuTVJHs5CEqVEC
         WebSyB8kBvjijsNZSjXPF4wSuG1KJW1knGut/OKqxQBLW4kySZPMSxdtzQN27ZwsU+iv
         Ar+ZWrLwd41NwlDRCpNJMKCNpEzvk23WnlEDe2lJ6QzItnvkEDChtLJ5iRyC9u6ut+27
         DnxQ==
X-Gm-Message-State: AC+VfDwE0dDpOhdAgZsr4/Li1UQZdi4utPuHCJj8fPbxwG7ZA4isXMY3
        qa+O3GCi3CTSxMVFK20hSSCe0GLofR4P4R+7vV0=
X-Google-Smtp-Source: ACHHUZ7FKytpT1bIzBWmeX+ibT6gpEBgUWOEGUg57C2o92fQt0WDpjil/FQlercYeXK3Mwexb9xceA==
X-Received: by 2002:a19:5f1c:0:b0:4f4:d83e:4141 with SMTP id t28-20020a195f1c000000b004f4d83e4141mr5192012lfb.50.1687191535334;
        Mon, 19 Jun 2023 09:18:55 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id c11-20020ac2530b000000b004b4cbc942a3sm4332824lfh.127.2023.06.19.09.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:18:54 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH RFT RFC 0/3] Fix up SC8280XP idle states
Date:   Mon, 19 Jun 2023 18:18:52 +0200
Message-Id: <20230619-topic-sc8280xp-idle-v1-0-35a8b98451d0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOx/kGQC/x2NwQrCMBBEf6Xs2cA2LRq9Cv2A4q14SNetXQhpS
 FQKpf/u6vHNzGM2KJyFC1yqDTJ/pMgSFepDBTT7+GQjD2WwaBs81mfzWpKQKeSswzVpG9ggToR
 4sk1LDtQcfWEzZh9pVje+Q9AwZZ5k/V8N0He337DvrnDf9y9rENLHhgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687191534; l=1359;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=GYm5GFOL7jLxNcgLuse8QD/24Xdd2Q2S5dQ75UZ085U=;
 b=RroKKu+kpc0100TCKw5v3rsJZf1kE1Ubt2T4QaB1aIyQ+f5eoIQp5dJOoKacfaAYs+E3aaTeG
 48wmF5OwVJQCneXWxQTSh/aDfr8jSTt/TO4veiUJZsRcI09rHEr6VDY
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

Comparing the data available in the downstream sources with what's there
upstream, it was easy to spot some differences. This series aligns what
we have upstream with what is there on the vendor kernel.

The big asterisk there is that the downstream sources for SC8280XP can't
always be trusted. A simple test shows that the lower idle states that
were previously missing are implemented in the firmware (Linux reports no
errors and enters them).

HOWEVER

The only cluster idle state that's been present until now (the deepest
one) is now barely used if at all, as the scheduler seems to deem it
inefficient or so.

Hence, a request for testing and comments, especially from those who
use the X13s daily or have reliable setup to measure the power usage.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (3):
      arm64: dts: qcom: sc8280xp: Add lower cluster idle states
      arm64: dts: qcom: sc8280xp: Add missing CPU idle states
      arm64: dts: qcom: sc8280xp: Fix up idle state periods

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 72 +++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 18 deletions(-)
---
base-commit: 47045630bc409ce6606d97b790895210dd1d517d
change-id: 20230619-topic-sc8280xp-idle-00fc007234c8

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

