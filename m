Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE16705D05
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjEQCS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjEQCS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:18:57 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2144010CF
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:18:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f24ddf514eso335167e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684289934; x=1686881934;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mNuleyZz00TgZy2qn9synoHafBsS2EGKwJDZ0wTnRXM=;
        b=wFt5R7uDlqCI5juBKjX+HKH9IfSSpOtP+J8cGttpl+kx1YOeolIo/0xujf9T2Lu9/z
         UOHQHgNVtpDL0K1bD1bO9m7qhGojRCjzmhkWmt9vYXvYG1eNGv5GlCL48Bh41EKWEFz5
         k7ykRUfIqNK68ZEH1kdgLGSJ7mCEui24q1BKZegkkubVFvG14N9DO13T98s7irDJp7hu
         SO3m7MnSXvtWqMWPX8xHnkdcsrZuSCWhxlMvZ8/0NNu8JeiAFjMVYrma7P8VSEBKN6Bs
         tznYeWjDF5GmDjH+kEyUOpv8Une0WYmzOdajRFlwsRbJJ9aALF/f7oX+MgMWByMiRHl2
         UC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684289934; x=1686881934;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNuleyZz00TgZy2qn9synoHafBsS2EGKwJDZ0wTnRXM=;
        b=Razvm34c0P4A1aOO4p52O4lbAJjvrThut0LzBO/Xxb0UQ1jwWtabzAkOcDvuMvMvCp
         CzsTmgCWNtgvOZ3LbS1zxgY1QJ9ZIR4oluUBmHVMFMuVOpbeLBWleugxQESyU2tK8qh1
         oS7yCxByy8snN45OUuoGjU41WFz/q771GsIM5z1ZZX8ql7kPVyTZd4YDx9BqiUmsp21M
         358GxEpamj3n+Rlp2vqPnh3vB7aYA/0/CTKF3BLastRXa3RbkOBuIaRssTdSpR63Se2K
         TycTV5xCYovwpXsXhWp98m07bwhPTI1aSWm6/t1gnUewv1cymDxG49YVNkXPyLr2Z/Sy
         TM6A==
X-Gm-Message-State: AC+VfDyezxox9Bwv4UfVn0YzsfODLGlKc+DPVq0u4ZpUKsmeZPryJWBZ
        QsHku09cf/WgyZTegzNsqIsSdw==
X-Google-Smtp-Source: ACHHUZ6cEKZjZPUZ/A7OWo1caIo/qBlIBx0j9UNQtzWqioi710Vj/oDKmPKMVJcUqZkxhQD12mvNug==
X-Received: by 2002:ac2:4302:0:b0:4ec:7b87:931a with SMTP id l2-20020ac24302000000b004ec7b87931amr7146198lfh.13.1684289934402;
        Tue, 16 May 2023 19:18:54 -0700 (PDT)
Received: from [10.167.154.1] (public-gprs529629.centertel.pl. [31.61.188.30])
        by smtp.gmail.com with ESMTPSA id z22-20020a2e9656000000b002af01da6c67sm384232ljh.32.2023.05.16.19.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 19:18:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] Fix SM8550 LLCC
Date:   Wed, 17 May 2023 04:18:48 +0200
Message-Id: <20230517-topic-kailua-llcc-v1-0-d57bd860c43e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIg5ZGQC/x2N0QqDMAwAf0XyvIDtmMJ+ZewhjamGhSrtHAPx3
 xf2eAfHHdCkqjS4dwdU+WjTtTiESwe8UJkFdXKG2MdrfwsjvtdNGV+kthOaMaPkMExjTIGzgHe
 JmmCqVHjxsuxmLrcqWb//0eN5nj+8SliMeAAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684289932; l=772;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=APGnRrrr5TbZrxKPg7ottygde1n4pWblpcQNvgATuUM=;
 b=QqJiuyxuIU2wwBiPeU0LPVL5yZhYWg10sWC/fxGSUrG8eTyLzdW8cI1aUqEGGcTbJfnJQ442h
 b773B2EGunpDDVuqB3ErDHeXQG8bbjTtcxQfZYnKDEWKtgjhmFkJnzV
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLCC was recently untangled as far as register regions go [1], but
SM8550 was omitted. Fix it.

[1] https://lore.kernel.org/all/20230314080443.64635-1-manivannan.sadhasivam@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: cache: qcom,llcc: Fix SM8550 description
      arm64: dts: qcom: sm8550: Use the correct LLCC register scheme

 Documentation/devicetree/bindings/cache/qcom,llcc.yaml |  1 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi                   | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)
---
base-commit: 885df05bf634d589fbf030c3751614eaa453fb5d
change-id: 20230517-topic-kailua-llcc-ef16d72b1cfe

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

