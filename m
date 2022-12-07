Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16A9645788
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiLGKXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLGKXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:23:01 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C402111448
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:22:58 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id z4so20360890ljq.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 02:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1sijU5enLkDTq3DQ0nw0PYtfD3Qi+72BKYHiCTRs2ZU=;
        b=HZxXQqZ3S3FWmVtrocczB6d8HV4sm0tQJeYbpg4VYj1wUZu5In8brBDiGw5LJHzZEh
         zarVKSoEq5WN7ZOvOL4qZ+QAACHaJ3hZRjtS/u/PWaFnpuj3VJ8YcKj+1YfDTxgmPo4v
         CErSg8d8YiyQgIZsNb3NVn/ySgblrjRn9kYXtDOdO0YyQn5y255pH16yDlt3sOU5LYG3
         2TVtzB8YghEkfZ9Y7z6Mscy1fDDgD3OgJmNMr9Dcisba2yyfU2reI8Rny6r/ZqOG1vJr
         EoUYzUhbmQcy3BRUz7QOLxWbKT2EwWys5YqmirMvHz17JzH11jYwxgkv/wRYjCXu8x8Q
         jfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1sijU5enLkDTq3DQ0nw0PYtfD3Qi+72BKYHiCTRs2ZU=;
        b=m/c674QHLnGWkqbAdLgGjWrIAvkDuIFDoYElsAi+ldhTo6hUtzQ2zHke1CZiaIrZR5
         /VIiSTsZQmULinnDKxW8I991OFMQGRIYjx4s+aaZeVlma2f6OdI3F4fKravEQZCLaafC
         4rdJCX2aZs975/scmBNcxp0Vmi3TzEPBlwsw/s2YIGG9DrEPzhfOJhsTuIN/06erB11r
         OZ1WRKR/abiQPmiUnl/r3ogGLe1ffL2by2O7iAbfv92/Kl2HRRlcqmnw8LjtlWDpfUHg
         bJJyQ6vJfDAYdXnEPtcjdo77L4CKwIemvsNzx/NfLi1zYCir2Rd403cLzJdOe5SMVxq8
         cGfw==
X-Gm-Message-State: ANoB5pnYNPMV2n2K+7NNOuxD3+jfpC3x2AHKmirqs9IoxBt5AKK3fcxv
        AbImj54qr8U/MLxU8DPCzorDLA==
X-Google-Smtp-Source: AA0mqf5h4sxrFTul2bwSrjyQP2HZcpafzgXYhRs9WtHjL8fjJIlDzOVwcLZqY3H4sd1gKZL9bdaOjg==
X-Received: by 2002:a05:651c:1147:b0:277:4726:bcf2 with SMTP id h7-20020a05651c114700b002774726bcf2mr26270843ljo.107.1670408576811;
        Wed, 07 Dec 2022 02:22:56 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bu31-20020a056512169f00b00499b27a329esm1953183lfb.300.2022.12.07.02.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 02:22:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Joe Tessler <jrt@google.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Jeff Chase <jnchase@google.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 0/9] media: dt-bindings: common CEC properties
Date:   Wed,  7 Dec 2022 11:22:44 +0100
Message-Id: <20221207102253.26663-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v2:
================
1. nvidia,tegra114-cec: Rename to nvidia,tegra114-cec.yaml.
2. nvidia,tegra114-cec: Nvidia->NVIDIA.
3. Add acks/rb tags.

Changes since v1
================
1. chrontel,ch7322: fix node name to 'cec'.
2. Add ack tags.

Best regards,
Krzysztof

Krzysztof Kozlowski (9):
  media: dt-bindings: amlogic,meson-gx-ao-cec: move to cec subfolder
  media: dt-bindings: st,stm32-cec: move to cec subfolder
  media: dt-bindings: cec: convert common CEC properties to DT schema
  media: dt-bindings: amlogic,meson-gx-ao-cec: reference common CEC
    properties
  media: dt-bindings: chrontel,ch7322: reference common CEC properties
  media: dt-bindings: samsung,s5p-cec: convert to DT schema
  media: dt-bindings: cec-gpio: convert to DT schema
  media: dt-bindings: nvidia,tegra114-cec: convert to DT schema
  media: dt-bindings: st,stih-cec: convert to DT schema

 .../devicetree/bindings/media/cec-gpio.txt    | 42 -----------
 .../devicetree/bindings/media/cec.txt         |  8 --
 .../{ => cec}/amlogic,meson-gx-ao-cec.yaml    | 11 +--
 .../bindings/media/cec/cec-common.yaml        | 28 +++++++
 .../bindings/media/cec/cec-gpio.yaml          | 73 +++++++++++++++++++
 .../media/cec/nvidia,tegra114-cec.yaml        | 58 +++++++++++++++
 .../bindings/media/cec/samsung,s5p-cec.yaml   | 66 +++++++++++++++++
 .../bindings/media/cec/st,stih-cec.yaml       | 66 +++++++++++++++++
 .../media/{ => cec}/st,stm32-cec.yaml         |  4 +-
 .../bindings/media/i2c/chrontel,ch7322.yaml   | 11 ++-
 .../devicetree/bindings/media/s5p-cec.txt     | 36 ---------
 .../devicetree/bindings/media/stih-cec.txt    | 27 -------
 .../devicetree/bindings/media/tegra-cec.txt   | 27 -------
 MAINTAINERS                                   | 12 +--
 14 files changed, 308 insertions(+), 161 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/cec-gpio.txt
 delete mode 100644 Documentation/devicetree/bindings/media/cec.txt
 rename Documentation/devicetree/bindings/media/{ => cec}/amlogic,meson-gx-ao-cec.yaml (86%)
 create mode 100644 Documentation/devicetree/bindings/media/cec/cec-common.yaml
 create mode 100644 Documentation/devicetree/bindings/media/cec/cec-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/media/cec/nvidia,tegra114-cec.yaml
 create mode 100644 Documentation/devicetree/bindings/media/cec/samsung,s5p-cec.yaml
 create mode 100644 Documentation/devicetree/bindings/media/cec/st,stih-cec.yaml
 rename Documentation/devicetree/bindings/media/{ => cec}/st,stm32-cec.yaml (89%)
 delete mode 100644 Documentation/devicetree/bindings/media/s5p-cec.txt
 delete mode 100644 Documentation/devicetree/bindings/media/stih-cec.txt
 delete mode 100644 Documentation/devicetree/bindings/media/tegra-cec.txt

-- 
2.34.1

