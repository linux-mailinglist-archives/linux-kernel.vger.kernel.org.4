Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5AA69E77D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjBUSca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBUSc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:32:28 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6622FCED;
        Tue, 21 Feb 2023 10:32:24 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id o12so21423849edb.9;
        Tue, 21 Feb 2023 10:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0EeJlO8QUl1DZMAlcd+EODPEJDc+DBbZZnZ+JDzoEdg=;
        b=kWq4ecHFuWXMSQZOzGBaSB3TZctWJCNGUWIu8P3VK24KihWheD/Hkgnz3BhcjBm+Ov
         z8eahBqmrp2SwL0wBFOCTd+8Knk4Nx90ZwYEY03DeTfn6M/VqR6QPOqhy5+242r9yDzt
         Ebj1teN7A4oA8YgIQe8byK5O6YanmP4Rk4ZeqmJR7xKaFSbu8E7tfn3utJjUFoZ988os
         QEbB2xHc3wW1X2WPp4qC8P+OOaY4c9nDtBXBo3LdSxRv8OmHfXrfBf1SVw9icnA4wePn
         SA8PnAH5xFwF8CR18LYgwYpvbCp28OMh9f4PgaM5DxNZ/D9Fk68DmsvDr2FtOiXzVAsJ
         Jbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EeJlO8QUl1DZMAlcd+EODPEJDc+DBbZZnZ+JDzoEdg=;
        b=haj3XIK9QmQYf397q3VNAnMiKOI9SppFXpCrNZdMY1XGktlxx3rQ/krFkgsI7gEgQC
         R9YrtgCRpiJE3hH4wKWUSzFTBlc4QV4sv9/+MXsEaFwIVi7qH+SHmNCvDle+qLXAGRQj
         g6JIEk1L+4t7O9EcEsh9TsXq3B3QlUGKz0TP8j/AdhrFJO8++zFRx/YMfsSl1WVHm1Vj
         7BBcQ0J28+geKX9a1HGJ+uKSzzXbCXUyvGdaJ6AQ2/NkvrPMyt9Q7ooYQzT6o0gBbpo5
         FjxRbPoOuTPX14XD/JSBuP4lZ4C9ze59EPUgUtY33EMmaGnN1n38LEINvPqQ5AImCZs9
         KxCQ==
X-Gm-Message-State: AO0yUKXvgzHCGnOPIicAWWXOzzY+digl3Of82Qw+sWihRKxphmJV6Hx/
        73NohiDQfNngYiNtEpZUfGE=
X-Google-Smtp-Source: AK7set86GBsI14U6VEaKmjm3BNimI8/ZzoK6Ek4xMuPyAJKltWK2m8xRKjLbpVGkaLUsc2k/7+79Yw==
X-Received: by 2002:a05:6402:215:b0:4af:515d:5658 with SMTP id t21-20020a056402021500b004af515d5658mr2968051edv.35.1677004342754;
        Tue, 21 Feb 2023 10:32:22 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id i3-20020a50c3c3000000b004af5aa16fcasm169102edf.66.2023.02.21.10.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:32:22 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v1 00/10] Fix sound on ASUS Transformers
Date:   Tue, 21 Feb 2023 20:32:01 +0200
Message-Id: <20230221183211.21964-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- add quirk for headset detection used by some T30 devices
  (ASUS Transformers, LG Optimus 4X HD and Vu);
- add RT5631 and MAX9808x machine drivers
- add Fortemedia FM34NE DSP driver used by ASUS Transformers
  and mandatory for correct sound work
- bind everything into working configuration

David Heidelberg (1):
  dt-bindings: sound: nvidia,tegra-audio: add RT5631 CODEC

Svyatoslav Ryhel (9):
  dt-bindings: sound: nvidia,tegra-audio-common: add new property
  sound: soc: jack: allow multiple interrupt per gpio
  ASoC: tegra: Support RT5631 by machine driver
  dt-bindings: sound: nvidia,tegra-audio: add MAX9808x CODEC
  ASoC: tegra: Support MAX9808x by machine driver
  ARM: tegra: transformers: update bindings of sound graph
  dt-bindings: dsp: add Fortemedia FM34 DSP
  staging: dsp: add support for Fortemedia FM34NE DSP
  ARM: tegra: transformers: bind FM34NE DSP on supported devices

 .../bindings/dsp/fortemedia,dsp.yaml          |  95 ++
 .../sound/nvidia,tegra-audio-common.yaml      |   4 +
 .../sound/nvidia,tegra-audio-max9808x.yaml    |  93 ++
 .../sound/nvidia,tegra-audio-rt5631.yaml      |  88 ++
 arch/arm/boot/dts/tegra20-asus-tf101.dts      |  22 +-
 arch/arm/boot/dts/tegra30-asus-tf201.dts      |  46 +
 arch/arm/boot/dts/tegra30-asus-tf300t.dts     |  34 +-
 arch/arm/boot/dts/tegra30-asus-tf300tg.dts    |  36 +
 arch/arm/boot/dts/tegra30-asus-tf700t.dts     |  36 +
 .../dts/tegra30-asus-transformer-common.dtsi  |   9 +-
 .../arm/boot/dts/tegra30-pegatron-chagall.dts |  29 +-
 drivers/staging/Kconfig                       |   2 +
 drivers/staging/Makefile                      |   1 +
 drivers/staging/dsp/Kconfig                   |   7 +
 drivers/staging/dsp/Makefile                  |   2 +
 drivers/staging/dsp/dsp-fm34ne.c              | 364 ++++++++
 drivers/staging/dsp/dsp-fm34ne.h              | 845 ++++++++++++++++++
 sound/soc/soc-jack.c                          |   1 +
 sound/soc/tegra/Kconfig                       |  18 +
 sound/soc/tegra/tegra_asoc_machine.c          | 120 ++-
 20 files changed, 1837 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dsp/fortemedia,dsp.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5631.yaml
 create mode 100644 drivers/staging/dsp/Kconfig
 create mode 100644 drivers/staging/dsp/Makefile
 create mode 100644 drivers/staging/dsp/dsp-fm34ne.c
 create mode 100644 drivers/staging/dsp/dsp-fm34ne.h

-- 
2.37.2

