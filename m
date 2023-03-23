Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0F56C6EED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjCWRbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjCWRbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:31:22 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA23F1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:31:09 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id x37so13018041pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679592668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wNlWMVOfIBJ5sYCGk8cV0F2Gur6V9aihLXHyK/3m6GA=;
        b=D1RO0Cz6QFWcPTByVwzHxkejA8/LZKJHXqOZ52+1fJ13P+NhalK/oDMzGRpbyvCpSo
         uTvXg9zRZarU4aMWWUX/LajFQET4gAUxlsx714/9xguyX2PZIIwrdEQkNw+Py97QDJ8w
         KHoes0QMnx09cpXmq5K0lMxqq02IAF2kNq9ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679592668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNlWMVOfIBJ5sYCGk8cV0F2Gur6V9aihLXHyK/3m6GA=;
        b=mrvQGuETuRj2K9JFPSsuR5eFp2j3Zc60rdm8YvGVd+Is+9K/qM/kLAlLG2qnltbgCw
         THaWH2qqI5HzDZIIS/KfXa5hnPoob5JgsloTxvTe2AnJvY+sGalpcUgDaVL27R+OkPIY
         FzGFjgWTxk3M3Uc/3z8X4hkbOcf64T/vY0j3WT10z5MIfbenoeONZPn1Ls228R9ORizv
         Fqtl484pH3NRdRgSLD3o+olhHOe/xxqWtuWZ2Fngx8+wUZvyIlBnbZWQvJmgLRThKqQI
         kag3Vp6h6T/2gGdNYarWfr8f/QRZX8PcPnGBAZ0s3vgOso1/2faezUsgJE1spAP3jHXj
         9D9Q==
X-Gm-Message-State: AAQBX9dES+/5/n7ufuEwfs80NzZfyf14/g70vk1ln9h9s1C45Uj80hJV
        kegjdpncl2xwWEtcO+a6Yqfsrw==
X-Google-Smtp-Source: AKy350aVBE8amoEnujDOw4ZJ3MN4p91l6YRmGHGGL84SD74zqJPXm29xNcOOhDNThqjqrWETQpaaPQ==
X-Received: by 2002:a62:1d85:0:b0:62a:4503:53b8 with SMTP id d127-20020a621d85000000b0062a450353b8mr248927pfd.1.1679592667856;
        Thu, 23 Mar 2023 10:31:07 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:16d3:ef20:206a:6521])
        by smtp.gmail.com with ESMTPSA id x13-20020a62fb0d000000b0061a6f4c1b2bsm12613546pfm.171.2023.03.23.10.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:31:07 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rajesh Patil <rajpat@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] Control Quad SPI pinctrl better on Qualcomm Chromebooks
Date:   Thu, 23 Mar 2023 10:30:04 -0700
Message-Id: <20230323173019.3706069-1-dianders@chromium.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main goal of this series is to do a better job of controling the
pins related to the "Quad SPI" IP block on Qualcomm Chromebooks. This
is essentially 'v2' of my previous attempt in the patch ("arm64: dts:
qcom: sc7180: Fix trogdor qspi pull direction") [1] but since it's
spiraled out a bit and there are no patches that are exactly the same
I've reset to v1.

The early patches in this series are just no-op cleanup patches that
can be applied. They're not terribly critical but since they are
"Fixes" I've listed them first.

The next patch in the series is a very simple and (hopefully)
non-controversial SPI patch. It can be applied independently if
anything else.

Next, we have a bunch of pinctrl patches (including the device tree
bindings related to them). I dunno what folks are going to think about
these. If everyone hates them, we can drop them and just change the
later patches in the series to use "input-enable" instead of
"output-disable". It feels ugly to me, but it maybe less upheval.

Next I removed the now-deprecated "input-enable" property from all
Chromebooks. None of them were necessary.

Finally, I did what I really wanted to do in the first place: attempt
to cleanup the pinctrl states of the Quad SPI. These patches have a
hard requirement on the pinctrl change.

[1] https://lore.kernel.org/r/20230213165743.1.I6f03f86546e6ce9abb1d24fd9ece663c3a5b950c@changeid


Douglas Anderson (14):
  arm64: dts: sc7180: Rename qspi data12 as data23
  arm64: dts: sc7280: Rename qspi data12 as data23
  arm64: dts: sdm845: Rename qspi data12 as data23
  arm64: dts: qcom: sc7180: Annotate l13a on trogdor to always-on
  spi: spi-qcom-qspi: Support pinctrl sleep states
  dt-bindings: pinctrl: qcom: tlmm should use output-disable, not
    input-enable
  dt-bindings: pinctrl: qcom: Add output-enable
  pinctrl: qcom: Support OUTPUT_ENABLE; deprecate INPUT_ENABLE
  arm64: dts: qcom: sc7180: Remove superfluous "input-enable"s from
    trogdor
  arm64: dts: qcom: sc7280: Remove superfluous "input-enable"s from
    idp-ec-h1
  arm64: dts: qcom: sdm845: Remove superfluous "input-enable"s from
    cheza
  arm64: dts: qcom: sc7180: Fix trogdor qspi pin config
  arm64: dts: qcom: sc7280: Fix qspi pin config
  arm64: dts: qcom: sdm845: Fix cheza qspi pin config

 .../bindings/pinctrl/qcom,tlmm-common.yaml    |  4 +-
 arch/arm64/boot/dts/qcom/sc7180-idp.dts       |  9 ++--
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 41 +++++++++++++------
 arch/arm64/boot/dts/qcom/sc7180.dtsi          | 11 +++--
 .../boot/dts/qcom/sc7280-chrome-common.dtsi   | 25 ++++++++++-
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 14 ++++---
 .../arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi |  2 -
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      | 13 +++---
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 11 +++--
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    | 37 ++++++++++++-----
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 11 +++--
 drivers/pinctrl/qcom/pinctrl-msm.c            | 36 +++++++++++++---
 drivers/spi/spi-qcom-qspi.c                   |  5 +++
 13 files changed, 165 insertions(+), 54 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

