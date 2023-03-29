Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D522E6CF353
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjC2Tly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjC2Tlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:41:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBDA7AA3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:41:31 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id q16so21637731lfe.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680118890;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cbt8RYRsNXhKllEm2l6/c935b1na6Cv5pr1oMZejEYk=;
        b=KhLdI9Au0OcebER4ZU5rq4XlGeI89RYyfLhrCHjSFyGHdxItZaKqMD32y2oZwO6yeX
         vmTgj7IZElzl7aQ9hvY+b4mvUuhYX5rppPS2UT9nVZDJGM462queAt7cHtRmPMjoRWWN
         tLNSrZlqht0VGQKX/cNw/fgJKAskYkMMDuzHpnv5YbCP5ykkofXLeRzO6t3Tzcj681CI
         Vw3GtCMROp2+MM/KOHNLN71DutQFlT38bGI1LnGRP3JpxSH4I12q7+NfK5aDnWkvvbCv
         +cjhnqb0yn6oKgcNArilmgUgAEsWPy4BhudjMRi/k68PWi9xTxcOBXZAobd4yh2EmKBL
         qPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680118890;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbt8RYRsNXhKllEm2l6/c935b1na6Cv5pr1oMZejEYk=;
        b=PkfUH8JknGGLUirLPkfzdC2xO/JLPcwP8vPSvrNVMXZ1vUotpvK9iaLp2UMhGRp/EQ
         i4cWa0czKIfVTG4Ce2N7lllyWprF2J2OuklgOcF2vsOwLF+k0YKQRTbYKm71+cO64/68
         IuXBEexXy075ehmPpfiOh86OCjUtt39EIR82OKOQ6NB8sbyqwyVzLGSNEKLS30UfllsG
         4909oXi0dWLq93Z9RVE0VN7ChlqK4W7i3iHNYFTPh0Wj/kvZSMKDEPn2k7O3kyizKlD1
         kuOB8DKrKOfvJd6Zxm5ldLW5dHdwBdhev1IPlKVfNnl0khS/Z4+JMRCP6K+VdExsM6iQ
         cfIw==
X-Gm-Message-State: AAQBX9d5HOMf6sVvi+3Tcy2HQi3mvcqR8oVVowoA99jCXlNnaIxk6CKz
        eGRJXbGugM+sC1r0WJUFAi9g2GYlp8s1sRrxIsc=
X-Google-Smtp-Source: AKy350ZKgmPGGLfaVshnM25rJBESXaQ7TB/BO1HogkxbQYLi/glHQpFHiSzC4tr5WMZAhM/TbgGXtg==
X-Received: by 2002:a05:6512:312c:b0:4db:25bb:ff0b with SMTP id p12-20020a056512312c00b004db25bbff0bmr1224944lfd.2.1680118889820;
        Wed, 29 Mar 2023 12:41:29 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id q22-20020ac25296000000b004eae672e96bsm3955048lfm.255.2023.03.29.12.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 12:41:29 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 0/6] Sony SDM845 panel and remoteproc enablement
Date:   Wed, 29 Mar 2023 21:41:17 +0200
Message-Id: <20230313-topic-tama_disp-v3-0-2b1567c039d7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF2UJGQC/3WNQQ6CMBAAv0L27JrSqhhP/MMQs5QtbIItaZFoC
 H+3cvc4k0xmhcRROMGtWCHyIkmCz2AOBdiBfM8oXWbQShtlSoNzmMTiTE96dJImdOZKZXlxZ90
 5yFVLibGN5O2QO/8axyynyE7e++beZB4kzSF+9uuif/b/YNGo0FRs2bqTqSpVj+IphmOIPTTbt
 n0BUMVii8QAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680118888; l=2208;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jy9fJvfWwS1V31GRDu+r4uQToIEw/SFIAP+9psSKVdk=;
 b=e/OgvB58S/2sqwVed4d/Hfrk8pbcXFiUhuPX2d5w/8Is/ymPSZOwBGp/vKiVNLlDsWHJO69X5ldH
 xvz52o35BIP4RAKCKZIJ+2b4hYJQmZ/0eFffc9mtwfX4egfNJJ1f
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3:
- Fix pinctrl-n / -names ordering [1/6], [2/6]
- Drop unnecessary #-cells [1/6]
- Drop GPIO52 (it's apparently some LCD mode, single vs dual port,
  not sure how real it is considering it came from messy downstream
  code and not touching it at all does not seem to break anything) [1/6]
- Use interrupts-extended instead of interrupt-parent+interrupts [2/6]

2/6 is still a total OF abuse and very RFC-ish, pending comments or ideas!

v2: https://lore.kernel.org/r/20230313-topic-tama_disp-v2-0-37ececf43770@linaro.org

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
 .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi     | 199 ++++++++++++++++++++-
 4 files changed, 253 insertions(+), 3 deletions(-)
---
base-commit: 198925fae644b0099b66fac1d972721e6e563b17
change-id: 20230313-topic-tama_disp-f38a116f52df

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

