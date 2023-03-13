Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601706B7DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjCMQeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjCMQdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:33:50 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E508B211E0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:33:14 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id t14so13244879ljd.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678725184;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IxAObhtaTCcRbG6Hmd9m0sIf05Okzjn3JGLYoGOg1TQ=;
        b=mI2o8AsFCByJJoFOVVg+b1mlcXkoKIiF2Zq0Cw6+ZI29rpJBoLoP96hOwVfAxZ/l4E
         i8MGj5FKWzSBCz2+O2EpFZlr+lNJrZxS3FK8Hc294Nnk69anGkqxtILoJrvx3QlzOp4V
         rQtlYt4YbXAEQWdX2QL/w6wNuugiwlQQEkR0qcVku+IE0reekNBdF7WxkmyFpab++wQ6
         Z0vJ5cjnPqZ6OZU3bR74ZLbIbDM/LckrH06skfv1/QrcA2NAkPVGvavg9mj6KDsb2y0a
         FA9P9yqdxw5CWEwwjvPa4evJ/0K6KSXCN3fun8WKcHSj72Y2ueiCMJv03VhofRuJDAaX
         aIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678725184;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxAObhtaTCcRbG6Hmd9m0sIf05Okzjn3JGLYoGOg1TQ=;
        b=fNXt3gd+bthpYlaVXaS2wKhL+wbCKjSE8FJKOS/kAZinGEEbCeLhKHevidRZ6J41IM
         yD5h/vVlRzPZfZHOtu+fdZ8IEhXeU7wSYrlmkOklTh1HSYlw/kfFUQygZkW3kgWVQr3E
         wdtr6d+LerqVMhs5LvX12sPirUuCmP1GyIm4SgaiT/npgOYLdT3CO/ZCIn0auHzLQM/K
         7Mb6iH6iSkaoP1cbXANEst8Q8O48gyM3zT7sRmlFchF280CcqvSOgd+bnrqQy5UkFI0s
         dTa9+njVs6urltC5Y+tQpsR2H5c1d4tVWfJZiAxIT/qxnu2QG30te6wrhyV8YUGEF0a2
         9Rkg==
X-Gm-Message-State: AO0yUKWhyBHmnlLcBJZR8RTRh2j7xmk0GTgw0RmIZEEjD9u1/dP4ftBI
        eQpknT3/FdVAIuDm8LvMmxy6E/56d7277pr5Yhw=
X-Google-Smtp-Source: AK7set+m/oE5niqMhke8f6ER+gWlkruhMxGnwh9/yhr3ujGuX9yQniRUZnfoINzC8OaTg3VoHIgauw==
X-Received: by 2002:a2e:a9a2:0:b0:298:39e7:75dc with SMTP id x34-20020a2ea9a2000000b0029839e775dcmr12377505ljq.48.1678725184528;
        Mon, 13 Mar 2023 09:33:04 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id q62-20020a2e5c41000000b00295765966d9sm57417ljb.86.2023.03.13.09.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 09:33:03 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/6] Sony SDM845 panel and remoteproc enablement
Date:   Mon, 13 Mar 2023 17:32:35 +0100
Message-Id: <20230313-topic-tama_disp-v2-0-37ececf43770@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACNQD2QC/x2N0QrCMAwAf2Xk2cDaMhF/RUSyNnWB2ZVmE2Hs3
 xd8vIPjdlBuwgr3bofGX1FZioG/dBAnKm9GScbgex/64AKuS5WIK33olUQr5nAj56558CmDVSM
 p49ioxMm6ss2zydo4y++/eTyP4wS6PnhNdgAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678725183; l=1665;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=bKcRsRkpMUUvkJs8OUvRQMB6jCsTJXQ8bRahIpo2/XQ=;
 b=qDsWTw0Vu7OuwUVVHEI9Dwe7Iqc5fFm97J1DfjlKtJVfC2VOoFTvy/gNouekhbdot/xiXkum119G
 uXQ4efRMCwEisJg94/wQDO55AVVDpdJD66Y1m5QvnswWA3nXgWxT
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
- Drop akatsuki touch panel as Marijn figures out some sleep-related
  things
- No more dependencies, the panel driver has been merged into drm-misc
  next
- "*-pin" { -> "*-pins {"
- treset-gpios -> touch-reset-gpios
- Drop "Don't use 0x in unit address" (solved)
- Drop IPA & modem, this keeps crashing for some reason..

2/7 is a total OF abuse and very RFC-ish..

v1: https://lore.kernel.org/lkml/20220930191049.123256-2-konrad.dybcio@somainline.org/

This series enables display and touch panel on XZ2/XZ2c devices
equipped with a JDI panel with a TD4353 driver IC and just
touch panel for all XZ3 phones. It also enables the remote
processors, GPU&GMU and GPI DMA on all Tama devices.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (6):
      arm64: dts: qcom: sdm845-tama: Add display nodes
      [RFC] arm64: dts: qcom: sdm845-tama: Add Synaptics Touchscreen
      arm64: dts: qcom: sdm845-tama: Add regulator-system-load to l14a/l28a
      arm64: dts: qcom: sdm845-tama: Enable remoteprocs
      arm64: dts: qcom: sdm845-tama: Enable GPU
      arm64: dts: qcom: sdm845-tama: Enable GPI_DMA0/1

 .../dts/qcom/sdm845-sony-xperia-tama-akari.dts     |   4 +
 .../dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts  |  47 ++++-
 .../dts/qcom/sdm845-sony-xperia-tama-apollo.dts    |   6 +
 .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi     | 203 ++++++++++++++++++++-
 4 files changed, 257 insertions(+), 3 deletions(-)
---
base-commit: 24469a0e5052ba01a35a15f104717a82b7a4798b
change-id: 20230313-topic-tama_disp-f38a116f52df

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

