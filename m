Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7AD6CA58C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjC0NXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjC0NXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:23:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76034C3E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:23:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i5so36359244eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679923389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RAzgsxWh6iXA0Nkdpgf/2nCg4Tswo7Jo12F1Nk5UNUo=;
        b=fBdz5o8qi/Khlda5m9/yDdNzXPS0MNmVt/DaVgzii1B2WIVPpnEomjCEobZnn3Skfd
         iUzOZyFrp6PwIRZqxHwuQ2VtOTKVFfEDWL2o+uQ2PqQmOlvvywYXzU61f6ZyswdiIntW
         g9lt1f+YAPywDl4UbdvFIi1H6ONB0/6bgKlExrPL7Idco0A2bNKtE8Qmn7as7GBpYEgh
         DqRhZQN1TGtQGQSfetXAj8fNv1CY3M705cWxv0MSqOy1tGPwyjqBTwpNVldWV4wQt3kD
         D88Q0nVmfqbuZGOkvYHQCK2Gz/D1JS3XpX77uyqXL+brFlcgU4Kz+fvqx5NMfbgJAzIX
         ua7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679923389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAzgsxWh6iXA0Nkdpgf/2nCg4Tswo7Jo12F1Nk5UNUo=;
        b=3124/dX1xGqAnw7dEFfXMdILR9CyEdf6jiWqktY5+u0g97GT0WL7/i0Nn/j61E1goN
         L0PenRGbDASif3FEcv3rHPNML256j04dNsL9E3WOpFtqgjQ8pr9/3o5LuMUna8X1ursQ
         IC5avMMWk+gfr+1YL5xOmj8hRR94Cw+xxGB45aNkK3aTBLVU8ca4FtAoXfPYKQrQHS/u
         njh4l1kqKoTjfIs+Iu52GeLqD3umVlL0DC4jugtC5S1AiZhsVdWuSFUEtbP4NiQWPvks
         q9hB6ZW9e5W7XXgQekLtkmEvyE/xWZv6jFWXG0BTzi+1ifP0yMMFPNF/j+ddKe4CcKA9
         En0w==
X-Gm-Message-State: AAQBX9eHQjXoiev99nBmtJhLiKlT1F9fq/N1M8vsVOYTxFkBMUFeafyX
        ykUW0aHN7glIARHRiTiDMbEx+Q==
X-Google-Smtp-Source: AKy350Yzur9V43SIMdNu02lm0MTMhSQJ9oj2fMsNEnVoo1PNdyeY8nk4vpk1vFV5UUzWcfbhUnR4hQ==
X-Received: by 2002:a17:907:7e8e:b0:932:dae5:2af9 with SMTP id qb14-20020a1709077e8e00b00932dae52af9mr15876869ejc.51.1679923389159;
        Mon, 27 Mar 2023 06:23:09 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:581e:789c:7616:5ee])
        by smtp.gmail.com with ESMTPSA id gy24-20020a170906f25800b00930445428acsm14286814ejb.14.2023.03.27.06.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:23:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrick Lai <quic_plai@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 00/10] ASoC: add audio digital codecs for Qualcomm SM8550
Date:   Mon, 27 Mar 2023 15:22:44 +0200
Message-Id: <20230327132254.147975-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset can be merged as is - no dependencies.

Changes since v2
================
1. Rebase.
2. New patch: ASoC: dt-bindings: qcom,lpass-va-macro: Add missing NPL clock.
3. Add Rb tags.

Changes since v1
================
1. Move the flag define to common header.

NOT a dependency
================
The patchset can be applied independently of my previous fix:
https://lore.kernel.org/linux-arm-msm/20230310100937.32485-1-krzysztof.kozlowski@linaro.org/T/#u

Logically, better if they were together, but code will work fine other way.

Best regards,
Krzysztof

Krzysztof Kozlowski (10):
  ASoC: dt-bindings: qcom,lpass-rx-macro: narrow clocks per variants
  ASoC: dt-bindings: qcom,lpass-rx-macro: Add SM8550 RX macro
  ASoC: codecs: lpass-rx-macro: add support for SM8550
  ASoC: dt-bindings: qcom,lpass-tx-macro: narrow clocks per variants
  ASoC: dt-bindings: qcom,lpass-tx-macro: Add SM8550 TX macro
  ASoC: codecs: lpass-tx-macro: add support for SM8550
  ASoC: dt-bindings: qcom,lpass-va-macro: Add missing NPL clock
  ASoC: dt-bindings: qcom,lpass-va-macro: Add SM8550 VA macro
  ASoC: dt-bindings: qcom,lpass-wsa-macro: Add SM8550 WSA macro
  ASoC: codecs: lpass-wsa-macro: add support for SM8550

 .../bindings/sound/qcom,lpass-rx-macro.yaml   | 76 +++++++++++++---
 .../bindings/sound/qcom,lpass-tx-macro.yaml   | 81 +++++++++++++----
 .../bindings/sound/qcom,lpass-va-macro.yaml   | 86 ++++++++++++++++---
 .../bindings/sound/qcom,lpass-wsa-macro.yaml  | 23 ++++-
 sound/soc/codecs/lpass-macro-common.h         |  3 +
 sound/soc/codecs/lpass-rx-macro.c             | 36 ++++++--
 sound/soc/codecs/lpass-tx-macro.c             | 35 ++++++--
 sound/soc/codecs/lpass-wsa-macro.c            | 37 ++++++--
 8 files changed, 309 insertions(+), 68 deletions(-)

-- 
2.34.1

