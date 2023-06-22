Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A26E73A572
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjFVP4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjFVP4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:56:20 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015A91992
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:56:19 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b477e9d396so70971271fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687449377; x=1690041377;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=znbfd2xCee88YdgNKMrXKidpIDwcYeqJYjkjML37kUs=;
        b=Jl8sA2H2N6xEpPLAfJMdYne8O1GMT4DQAz0HuYpnztSZ6AH6yA5TfBNpzEZMeoiWU+
         IF7bD2inU3xfOGuN/5AdzPyI3BkcSEaEpkm/INLIM5Nhpp4SmRnU9ibfVyxtmvkK4DHI
         9nDHf8ejOhPbN2F2paMPK5DqM6WUEhW4I4Rf3xUfRtZmTn2pwQHlK5oiemdH0IyjW+uO
         EI2LGQNwdBr59DfPAW2VP7clT9ESNnSRMlK8V/hnjeckuYlWaEsaQ7FFmVybYR1gidpl
         Ds0ISDWFWN6qbp0zU+wlKhGE2wfSSVWYhyxkVDr5SBgWCskIX0+5H2Zl8c5fgYGS/oej
         8/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687449377; x=1690041377;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znbfd2xCee88YdgNKMrXKidpIDwcYeqJYjkjML37kUs=;
        b=aY0WcovuC6pCLxG3IwBsjWqyCUwbzoTfcsh2BIlh2XvKQgcpW3pPsJiw0OZcL5fgDQ
         8iKoHgZddV1zcvvzrwu1KhJc52jeG1yMi4HEY6UxZDtCDfgRmgUf5+L5k5r82QpCyim9
         zP2pdEpW7iANgM4xY+17fdW8Yi16xKgUUWzw1FPrO4JhD9/CEJyS57CwYW/+nfBDQ8Vf
         qzVXTbz87kusNwSThPohq87OavEpu/kYSsSgYx2WAVSElsZW3egsGBL1GChb+tJppuSQ
         v7AOaQ03AgmuwEwtoGKDVC2YxJAsD7QsZB7WL/k2qaKo9vL6zkpA1E0qmgZzi/e76c0X
         Q1mQ==
X-Gm-Message-State: AC+VfDxIF21LL6TNjD7l653VW0JxjSIPtK4E09aMqMOBxx0oug6DjVn0
        tnrs3RjHzs7CcRTp0gOj8PbVEg==
X-Google-Smtp-Source: ACHHUZ7gHI3Ym/l712eWpcpACbY1KSyeARpNpHP8ldZLdPbWsB+/WgRnC5YmBCjkAvtI/ELEya3mdw==
X-Received: by 2002:a19:6409:0:b0:4f8:7781:9875 with SMTP id y9-20020a196409000000b004f877819875mr7130473lfb.60.1687449377155;
        Thu, 22 Jun 2023 08:56:17 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id h25-20020ac25979000000b004f8747e519bsm1146876lfp.125.2023.06.22.08.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 08:56:16 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] Hook up 8280 SCM icc
Date:   Thu, 22 Jun 2023 17:56:14 +0200
Message-Id: <20230622-topic-8280scmicc-v1-0-6ef318919ea5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB9vlGQC/x2NQQqDQAwAvyI5N7BGWGy/UjzsxlgDdpVNWwTx7
 4YeZ2CYA0yqisGjOaDKT03X4tDeGuA5lZegjs5AgboQifCzbsrYUx+M38qMEtN0JyGKOYNnOZl
 grqnw7GH5LovLrcqk+//zHM7zAu5xIzh3AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687449375; l=614;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=7gsI8qHufrl5sqmyv5QgxVvJHPbBfQ5Kso3+5N5mNaM=;
 b=Bcsu9pilCwH0a3I2Nr3hjwd1RSTN+HlTKMB36UxuS2pey+DxFOYwuDNg8XDsh3I0kY76ASFGs
 upHy0Ldh9usC9gIvzDemR+rI7FH99U9VPAakSBan3XNz5S2qjAVgfwW
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The icc handle for SCM was missing on 8280. Add it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: firmware: qcom,scm: Allow interconnect on SC8280XP
      arm64: dts: qcom: sc8280xp: Add missing SCM interconnect

 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                   | 1 +
 2 files changed, 2 insertions(+)
---
base-commit: c87d46a9e8ebd2f2c3960927b1d21687096d1109
change-id: 20230622-topic-8280scmicc-e6af92e226bb

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

