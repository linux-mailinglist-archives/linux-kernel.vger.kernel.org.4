Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C60F734F61
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjFSJOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjFSJOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:14:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7520C1A8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:13:42 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f640e48bc3so3923755e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687166020; x=1689758020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FGUmUyPYRQe7JCe5YSSOKzsUZSYLXR3kceyIiK3bZTo=;
        b=jF7pdXS3XhA2vRtlsR7hRh6g4RSLWEnZZL29aG3Csa3XHvACUzVJqPmkbtOf1YmX4t
         Sk3hHWWHpFn8lqavTJDhbBqKqj75OXR2fwgsay2bnpcVxYGJlzOJrqS6i6MafXRZs6NN
         kD5suHqFLxFkuj+7vLJScGh3Sfql66h/Gc5ntN7Wmix3dL/0lRMTGEfkrQV7e2SsgsUm
         c8tZ0LQwU5rvBEi0+YIKuC04utnu6rzpDHXGVhru5hYdZo25u87yiTPT15h6RRKUAtSW
         ELqf9YFazuGXOlrTf8OpsmciEKvMS7EeV8p9LoslLEE8GvD6NdI03QmLTcKphJxLRlv6
         qJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687166020; x=1689758020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGUmUyPYRQe7JCe5YSSOKzsUZSYLXR3kceyIiK3bZTo=;
        b=KwqvYyXxllW52iYUhKbs0J7u8+jSAGC4OTRfKt595RBQwQS0BWGGET/a7WeaxcMmY+
         K1oYNkS0dB6Mabrg8RRu6XdPEae25tjLLtSzluKdwxrumGctZyRWdpBw3qKyred/u33u
         h6S4fRt+UmPjT2dGWOPjEC2sMTE6N9FoIJXJRNN/bF2G6Ssv4ImCaKOw096gjtwwyHwU
         nclLmwesJ1LzVnxGj7PRoyBOe9ZbY+RK47gH/ikmF4u0d9p6kranWw897u0SZjhAlH4b
         A6IOVDReZsRtUboNGbJ2wsIqEAtdgddlP6dRNs8RBPr1UcRndqS++eoXMJoUTIWaZ6la
         sKiQ==
X-Gm-Message-State: AC+VfDyRjDPNHVmq9tSKy6vhod4+XLOSRaX58PYFh/VyID/T4VfVYHfQ
        omNZnKJGvkuHVn49KK38F3zDqw==
X-Google-Smtp-Source: ACHHUZ78zEUhE9gBbobf8MIedRP5SIggqx8yhpnqgFdeJalbMShz4tBLCD/3Fg+jBdr7c4DmfZ4tFQ==
X-Received: by 2002:a19:790e:0:b0:4f8:6e16:fca3 with SMTP id u14-20020a19790e000000b004f86e16fca3mr1368039lfc.28.1687166020479;
        Mon, 19 Jun 2023 02:13:40 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d9e8:ddbf:7391:a0b0])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c205400b003f9a6f3f240sm3072993wmg.14.2023.06.19.02.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 02:13:40 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v2 0/3] phy: add the SerDes/SGMII driver for Qualcomm SoCs
Date:   Mon, 19 Jun 2023 11:13:33 +0200
Message-Id: <20230619091336.194914-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a new PHY driver and its DT bindings (reviewed by DT maintainers).

This is a sub-series of [1] with only the patches targetting the PHY subsystem
as they can go in independently.

[1] https://lore.kernel.org/lkml/20230617001644.4e093326@kernel.org/T/

Bartosz Golaszewski (3):
  phy: qualcomm: fix indentation in Makefile
  dt-bindings: phy: describe the Qualcomm SGMII PHY
  phy: qcom: add the SGMII SerDes PHY driver

 .../phy/qcom,sa8775p-dwmac-sgmii-phy.yaml     |  55 +++
 drivers/phy/qualcomm/Kconfig                  |   9 +
 drivers/phy/qualcomm/Makefile                 |   3 +-
 drivers/phy/qualcomm/phy-qcom-sgmii-eth.c     | 451 ++++++++++++++++++
 4 files changed, 517 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sa8775p-dwmac-sgmii-phy.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-sgmii-eth.c

-- 
2.39.2

