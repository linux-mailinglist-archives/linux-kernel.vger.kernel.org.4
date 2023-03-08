Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA596AFFC8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCHHfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCHHfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:35:34 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8BB14EB0;
        Tue,  7 Mar 2023 23:35:24 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id da10so62105445edb.3;
        Tue, 07 Mar 2023 23:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678260923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gte2HFg34yVeA/U5OHeIizbsHhlUPWICXggwBKuVh2I=;
        b=Dt82pBO67slGMwDm1SS6/1HLw6ZpAzyD6srwgZVrAvXg86Ba82MtmdgLPLzCSDT3b9
         BN5+kNFV9aXgpZOPMK1GjuNptRtjo4oP3cbH5Ia65t+klmJvNMZKI4qxSlrYRmuOaNsk
         DsGdBVpK1l+E8cuMCRpVKGbJsuaIj6RzOhQBPzk4XXLXs+Lv9ZkGH0HFQTPswWh8RoSh
         1jvcdkiZw0oul9twRi176xsDc+cbt97a8HonmyAWHAS2Gfny3Wx7qppNirRF3FaCHOv/
         U1lUJB3hKqsYfm7LJBVMywfgJdsTyw/ddCn7P8TNNWEokX0dg5PC1Prp8+KRgSi+6XjV
         uvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678260923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gte2HFg34yVeA/U5OHeIizbsHhlUPWICXggwBKuVh2I=;
        b=hT9kdunHwRKV2kPpbaTUTsv/BJG/oYCGKydWBOq6tZ0pRsNrmHFQrI05zTmuDOjZGS
         hYB6sAVcSz5d5jTbL5fDDb5TqSBm8LTiPq57O1ouNsyC+dFJfmlbIWh4Tu6gBrmlYYa8
         crkvI/2QL2ISvoA5b0pyRxo6n7UFYonwhEXefgunUcNjT8K2KWqwZYk+6dpfu+5+DNpy
         fdd3J36F0CnMNGZE1EH5MWJs8kYupy60A24Noyk5qbJCsd3VMHV6+QkEs+84eLWi8z6d
         Sk49TWpnwBfZKXvhsn2aO7Q9HF/0h/Sywzt07qYBN7VnhxEtxnhu52pj83mqOsMkWgDe
         ra3A==
X-Gm-Message-State: AO0yUKUWqnxlnR1y3HGAzAZHgz4sdX8qtRyTYrm471l5i6skRB8bwUR1
        9kfjxNfpy+kaQ/7BJCLIPzEqeMewUSo=
X-Google-Smtp-Source: AK7set8BdlJlpmywABZUT++XuOH4ogUuKoQXSG95jB3Xk6sHLRzgk3JFLTIQsB8V/aB5j/dY/7XHjQ==
X-Received: by 2002:a17:906:ac3:b0:8f2:bcb5:bbf2 with SMTP id z3-20020a1709060ac300b008f2bcb5bbf2mr18581306ejf.44.1678260922879;
        Tue, 07 Mar 2023 23:35:22 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709062dcf00b008dffda52d71sm7051880eji.124.2023.03.07.23.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 23:35:22 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v2 0/8] Fix sound on ASUS Transformers
Date:   Wed,  8 Mar 2023 09:34:54 +0200
Message-Id: <20230308073502.5421-1-clamor95@gmail.com>
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
- update bindings

---
Changes from v1
- fm34 dropped for re-work
- quirk for headset detection and rt5631 bringup splitted
- minor adjustments in binding updates
- improvement of rt5631 rate asignment
---

David Heidelberg (1):
  dt-bindings: sound: nvidia,tegra-audio: add RT5631 CODEC

Svyatoslav Ryhel (7):
  dt-bindings: sound: nvidia,tegra-audio-common: add
    coupled-mic-hp-detect property
  ASoC: tegra: Support coupled mic-hp detection
  ARM: tegra: transformers: update sound nodes
  ASoC: tegra: Support RT5631 by machine driver
  ARM: tegra: transformers: bind RT5631 sound nodes
  dt-bindings: sound: nvidia,tegra-audio: add MAX9808x CODEC
  ASoC: tegra: Support MAX9808x by machine driver

 .../sound/nvidia,tegra-audio-common.yaml      |   4 +
 .../sound/nvidia,tegra-audio-max9808x.yaml    |  90 +++++++++++++
 .../sound/nvidia,tegra-audio-rt5631.yaml      |  85 ++++++++++++
 arch/arm/boot/dts/tegra20-asus-tf101.dts      |   7 +-
 arch/arm/boot/dts/tegra30-asus-tf201.dts      |  17 +++
 arch/arm/boot/dts/tegra30-asus-tf300t.dts     |   5 +-
 arch/arm/boot/dts/tegra30-asus-tf300tg.dts    |  17 +++
 arch/arm/boot/dts/tegra30-asus-tf700t.dts     |  17 +++
 .../dts/tegra30-asus-transformer-common.dtsi  |   9 +-
 sound/soc/tegra/Kconfig                       |  18 +++
 sound/soc/tegra/tegra_asoc_machine.c          | 125 +++++++++++++++++-
 11 files changed, 380 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5631.yaml

-- 
2.37.2

