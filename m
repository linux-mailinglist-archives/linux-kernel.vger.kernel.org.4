Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542C4719827
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjFAKCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjFAKB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:01:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F9F188
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:00:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f3baf04f0cso699591e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613657; x=1688205657;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kusTVM6jg9/A5F7RGb0bUmgFNZBoFsvxKae8/D2f+KQ=;
        b=cez/5Z093HmjJmMdam6i3LLqIX2MiUERi6cWmYg855rB7ynBFCxD3NFZ5CPFVn+wk3
         qlqB8xKwbG1Cwk6Z66fkekviM0ZlTT/VlfQVRlTvSekzQElJLdmCMvAExCEr+6qSCGLL
         D2vqKuV29hQ073ftK3RtfIP2DFspJMnqA/4ik5j36YpYr/bUS5+rcHxDnTwygzD/K6Gq
         jumaRpbVpoI81uJUNfVM4YNAswttReOCLzmE3+0SAFE3LriQaBdCmtS28tZwDFlxFLnf
         Oav58OyFssmRVmhQYbnvASWe7JTL6IAMYfDhhBk3p5Hcze3kA+NiM4pCLMRjoBhOPAAt
         1wdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613657; x=1688205657;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kusTVM6jg9/A5F7RGb0bUmgFNZBoFsvxKae8/D2f+KQ=;
        b=W2dJjdV/MC+5a7LkUnPEjWyvVr4YD84Z9xQ2TyCNr8btw3wXkF8XwQxW8J89o9QqQV
         J7D0o66rP4NsZDZpRAAmL82+ti1CFWb1T8Bu6yH7Y98y4lb30KdGN+VQEyPwloMFx7Lo
         d8/Y09u8JORoEFnUamMtaxE7IxLSJUr9PoownKeZ7ptu//F0CeWpKxVYTfKJiuC/mGKs
         EdM32O6xlrKAXd0lU/auyCf2qtFDb+gOSdkRJWuVm83E5wehVhZdi389KZDCM2YNWlU+
         EieQXC9/oT1x50TUXDrjulOYo4tOPiNe3VYNY9kq9jr/PYa1y99zxdEeonapGb23+jWB
         iPrw==
X-Gm-Message-State: AC+VfDyrc2yFTqbF8612N1wUe3LjZeEic4lIaNQB6JGJuqRNf2SZ3R4f
        oJqeO8BPQek/Zmo1rL1jG/2KoA==
X-Google-Smtp-Source: ACHHUZ4FE4TszkkXL/P96pjK3toansUObJ74vGjlC48/2OSpgnkvtevnJeFBKvFPfFsbtw8lauPKgQ==
X-Received: by 2002:a05:6512:49e:b0:4f4:b694:21a3 with SMTP id v30-20020a056512049e00b004f4b69421a3mr920101lfq.46.1685613656980;
        Thu, 01 Jun 2023 03:00:56 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id l13-20020adff48d000000b003064088a94fsm9708543wro.16.2023.06.01.03.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 03:00:56 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/4] arm64: qcom: sm8550: enable PMIC devices
Date:   Thu, 01 Jun 2023 12:00:51 +0200
Message-Id: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v3-0-8823ee43f3fc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFNseGQC/52Pwa7CIBBFf8WwfmPowNTWlf9hXFDAlqQCgdpoT
 P9dqhtd+pZnFueeebBsk7OZ7TcPluzssgu+gPjbMD0o31twpjBDjoITEkwhOg350hBxuMY8Jas
 uEN88xh7MBFpUksggnrFmxdSpbKFLyuuhuPx1HMsxJnt2t9f08VR4cHkK6f4qmav1+tvoXAGHj
 hopzI5UjeIwOq9S2IbUrxG/y6Qhs6t5+aLln7K1dsZ/FGKRKtE1La+51LL9ki7L8gT8ksKvjgE
 AAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1831;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=IM8sjXHwyIqX4uuu0+MmE9DZktIQvKBx6uopgTYROXk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkeGxVzlYTDGrqbj03vzypW4FdDHIZN/7mnNpswifb
 vKiVkmiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHhsVQAKCRB33NvayMhJ0eiiD/
 0flxULKx0hXpc0HWbwmQdjzczgzm4rPSGxFqN7Z4SRGtBFWVAwcWHx6NKJEPOQq5PUOrAVQ8OEEcHs
 5KURQR3xBTPr1ppuTMbGl2IzKfTLmbnXpb3uXfrO28A4Vp+bMOo1l0XTKX9icdbX+cuXGjnJjAzfbI
 LwtEkrpjSndpNd80ZeK0dhObCkV9hCtsG/jfuB+8amPf+mhtiDqr6FaJPhv0PvwmY+gKis6a7sQGCp
 nHurNf/WN9xAm9AFoVjYX87qeBRK3W+lKqlR5f8NGpSvUrMM6cyHRVpvjlY0WLKtOQVF2BZ8wQ4tbi
 cvxCaKC2gyKdutTlqm9iHQKE49hbKkr4pQUC7b+0VdsTbKMVUkxz7Y2bxpvBIY69g9VZ2PR4ZmlEFV
 iBWPhE4tb2bxs/as4z5n1Zk7r2eLmoKEB8QYG4vuTsrDsmgdWioCtO7CBfxVIKNQP6iyuHTF9Jftge
 Jyh8kithbp8ZoYA7HRIsZnBjNYNAiSG3n8n9vQHvCVcoTJHfZqOWA6iMoPVauRdDDsna2vl6Mav/57
 gbhDfRZIiyFACyNYLegaB6+jLSbMVVu7MIk40AN+vS/3FthhIl9BYIbCsm4413rIOYf+Udq7LBIY0v
 I2zbUL+gUW9FCICNH5QbRwlyz7Xk9sXSeG3XlvCcDYmEWIsRWWgieS4a6Wvw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables the following PMIC devices:
- PWM RGB LED
- RTC
- Volume and Power buttons

on the SM8550 boards.

Depends on:
- [1] PWM bindings, merged by Lee
- [2] functional fix
- [3] & [4] QRD flash DT changes merged by Bjorn

[1] https://lore.kernel.org/all/20230522-topic-sm8550-upstream-pm8550-lpg-v2-1-c5117f1d41f9@linaro.org/
[2] https://lore.kernel.org/r/20230515162604.649203-1-quic_bjorande@quicinc.com
[3] https://lore.kernel.org/r/20230516150202.188655-3-krzysztof.kozlowski@linaro.org
[4] https://lore.kernel.org/r/20230516150202.188655-2-krzysztof.kozlowski@linaro.org

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Added all review tags
- Fixed pinctrl-names/-0 order in last patch
- Link to v2: https://lore.kernel.org/r/20230525-topic-sm8550-upstream-pm8550-lpg-dt-v2-0-a3b890604c49@linaro.org

Changes in v2:
- Always enable RTC in a new patch
- Drop patch enabling RTC on boards
- Move PON names to meet alphabetical order
- Link to v1: https://lore.kernel.org/r/20230525-topic-sm8550-upstream-pm8550-lpg-dt-v1-0-4d5d7602f290@linaro.org

---
Neil Armstrong (4):
      arm64: dts: qcom: pm8550: add PWM controller
      arm64: dts: qcom: sm8550-qrd: add notification RGB LED
      arm64: dts: qcom: pmk8550: always enable RTC PMIC device
      arm64: dts: qcom: sm8550-qrd: enable PMIC Volume and Power buttons

 arch/arm64/boot/dts/qcom/pm8550.dtsi    | 10 ++++++
 arch/arm64/boot/dts/qcom/pmk8550.dtsi   |  1 -
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 63 +++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)
---
base-commit: 388a38fadd00565867bda40c3b87c3a983bfb83d
change-id: 20230525-topic-sm8550-upstream-pm8550-lpg-dt-c31455d22f26

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

