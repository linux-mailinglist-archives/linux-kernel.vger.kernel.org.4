Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395AE6C02C6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 16:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjCSP1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjCSP1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 11:27:46 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CFA1E9E4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 08:27:44 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h8so37810966ede.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 08:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679239663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g3viO/SVS1mAUPDADBNw/95UMMSdd5bvS68WvAIfgKs=;
        b=cndUSDcLJ1g+lnvV7RtVfaGzOd2gedLDsXsY9euB+Vuyr2n5qmyK5XyzpEEEMl4eOq
         CcgtWk8HQtNxZF3m1uVTD2rJqvpjtuvmQDB91D2aGX7qD4DHMh/rdnmHqh/NyObKb+fT
         JqXq8/YYeyyDPAR1uq2gKKN+e213lVeSbVx35UqIgvnqV3EsOuhpM7OyNwrf1EBn7C0N
         9fqaA+7/+UBsh/VSd2kU7suBwTvjGpTQ5Y58iwy0AfxKvX0dAGVeuqkSFCjsWO0krrni
         RiLEKLufNQSO62aoTrNDCcqT+0KAnoUs708s9LcZPp2u7AY3xomlkcdr03eBsXnEhyhd
         ig+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679239663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3viO/SVS1mAUPDADBNw/95UMMSdd5bvS68WvAIfgKs=;
        b=Xl4g3t4fGksUdAKp7/Hf49qvgmRzCQInc4x5CwEq4Y2woG00kGijVi9s+ysqHrrvb8
         I+Glwhd8gzaFVq6/k0ILFLaw2N4/C+xV0xHPkGU5bFK3rCO+EK+OI4vcXNJsGaT0By7j
         wrQbShpFL23101X4w1QStK6kTyoJvitgQaEHoNbw+tOpuC8ZZ1mmHW+NzJ0Ldb2dZJ0j
         ClSTj1eZCTDzcyR3jRG3BBD6skf5Eonv5xfVgXG3CQJ2Bxy+Gj9uU0AB25hvOpGjtO+B
         1VDpRqeJVbQzFYoOqNUAXos7topYezzbbrXJbO2WZMcm4ZwkaVcBK2ZYwUB9WmT3uMQz
         3PeQ==
X-Gm-Message-State: AO0yUKUQrgLJLtNvzMicgZV74oxcIOJz1gChBX9sGgn2Gzc/WenwwS5p
        VblX4L03TIilKbqH3Qs2RXnn+A==
X-Google-Smtp-Source: AK7set/47vNe/VBA1m9BQdyDxM2teNI19eB4W2tllqt6sHMM97qWkxhef7FVbfq+zHUFlQQ1+y73Bw==
X-Received: by 2002:a17:906:7394:b0:92b:ae6c:23e7 with SMTP id f20-20020a170906739400b0092bae6c23e7mr5985333ejl.56.1679239663137;
        Sun, 19 Mar 2023 08:27:43 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709064f0700b008cda6560404sm3340857eju.193.2023.03.19.08.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 08:27:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [GIT PULL 1/2] arm64: dts: few cleanups for v6.4
Date:   Sun, 19 Mar 2023 16:27:39 +0100
Message-Id: <20230319152740.34551-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd and Olof,

Few cleanups where maintainers did not pick them up for some time, maybe
expecting me to send or maybe because they missed these.

Best regards,
Krzysztof


The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt64-cleanup-6.4

for you to fetch changes up to d2e5c16f6c86901040f3bb6b40d1a01ccf1a21b0:

  arm64: dts: cavium: Fix GICv3 ITS nodes (2023-03-17 13:39:00 +0100)

----------------------------------------------------------------
Minor improvements in ARM64 DTS for v6.4

1. Toshiba: white-space fixes.
2. Cavium, Marvell: fix GICv3 ITS node name.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      arm64: dts: toshiba: adjust whitespace around '='

Rob Herring (2):
      arm64: dts: marvell: armada-ap810: Fix GICv3 ITS node name
      arm64: dts: cavium: Fix GICv3 ITS nodes

 arch/arm64/boot/dts/cavium/thunder-88xx.dtsi      | 3 ++-
 arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi     | 4 ++--
 arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi | 2 +-
 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi         | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)
