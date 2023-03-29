Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCED56CDCAA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjC2Ofi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjC2OfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:35:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E44ABBA0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:31:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l27so15967572wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680100191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jZVAn1MUwCLmQgtnE/uyJHf6u7yyI6ZBAmjRU0STOcQ=;
        b=DMufeaVUk25DTpehwQjuUO5ZFyoJ6w5hEiyJQibZ/hCdJ5pTdXoIR9eFJc8bKtNfrr
         qm905QR7HkpLC+CUuRbfKJ3b8vZeFjPPlhng9cTUPPU9XjHOGi3gNnTsbutR9Mz35o/t
         e7e5894KNLa/pnTpezbPDcQc2HyhaVWAjlEThSaoLvskTSLCYmuIs0aoT060MPsmWfKK
         /rorhB+FXcWYrWDr5we4W0PHSHNLD8MFJRBrrfb4p6bKbkvEL/7kFfBoOAqldVpDCASX
         U8vvgBtAuanc9wyjDVRPbnvchqGPWT2gTX0rgOSWw67MJwwHL3ObR4rFGgSjdk2qv97O
         uamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680100191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZVAn1MUwCLmQgtnE/uyJHf6u7yyI6ZBAmjRU0STOcQ=;
        b=fdU6qBI712EsRM0mnjdjXkq7dPEbTsCt/KAHdIrHHC9bHGGASUCqnhjJrvZiUYG7Sv
         +rf3zZVFLUW74ZIJB0fBUNqcKXSipYozbsPKsRPDLhl0VxBB5Lqi0CoZqhwM1wErERt5
         /CT1HUstqekia43FXlKWosioLhLtH1aU4Rle+DlSlPq7j2PKkf9QofQAR9liEVAcl01O
         yyDgOBvKo58v5w16taVpSWfUcTxFuQZvBbIfBjs/MD4GUhlmG+4CHmsQnEw1DwWDNyRr
         Hm31qA9yIAZjnjOfb3V5LTLVTmyjBmTe3kdIEsgjxTk2J0HX2NuC6Dd6Y0WGTSgKC0xo
         meqA==
X-Gm-Message-State: AAQBX9fcopl4QcwQ+onMQSNLjDZKBbVL1Mmi5QfovTVcIuSdKMy9ZS1W
        D5heVzZQCBHiB2q3Lsr/VYl7GQ==
X-Google-Smtp-Source: AKy350a+EkoJ7QLaGrJxFde8tqmVeYIa5AoUMdaxf3ecN3MrxD6IB011xyf8bA4cpUsUDAzyMxt26w==
X-Received: by 2002:adf:d852:0:b0:2d7:1ec1:9e47 with SMTP id k18-20020adfd852000000b002d71ec19e47mr15650739wrl.19.1680100190877;
        Wed, 29 Mar 2023 07:29:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:28d:66d0:7049:3791:78c8:6c3])
        by smtp.gmail.com with ESMTPSA id b9-20020adfde09000000b002daeb108304sm17270792wrm.33.2023.03.29.07.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:29:50 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com, jpanis@baylibre.com
Subject: [PATCH v1 0/4] Add TPS6594 PMIC support on several boards
Date:   Wed, 29 Mar 2023 16:29:44 +0200
Message-Id: <20230329142948.833800-1-eblanc@baylibre.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPS6594 is a Power Management IC which provides regulators and others
features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC can
communicate through the I2C or SPI interfaces.
TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.

This should be applied on top of other patch series:
- https://lore.kernel.org/all/20230327154101.211732-1-jpanis@baylibre.com/
  For core MFD driver
- https://lore.kernel.org/all/20230328091448.648452-1-eblanc@baylibre.com/
  For regulator driver

This serie adds device tree nodes for TI TPS6594 PMICs found in the
following boards:
- j721eXSOMXEVM:
Link: https://www.ti.com/tool/J721EXSOMXEVM
- j721s2:
Link: https://www.ti.com/tool/J721S2XSOMXEVM
- j7200XSOMXEVM:
Link: https://www.ti.com/tool/J7200XSOMXEVM
- AM62A-SKEVM:
Link: https://www.ti.com/tool/SK-AM62A-LP

Esteban Blanc (2):
  arm64: dts: ti: k3-j7200-som-p0: Add TP6594 family PMICs
  arm64: dts: ti: k3-j721s2-som-p0: Add TP6594 family PMICs

Jerome Neanne (1):
  arm64: dts: ti: k3-j721e-som-p0: Add TP6594 family PMICs

Julien Panis (1):
  arm64: dts: ti: k3-am62a7-sk: Add support for TPS6593 PMIC

 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts      |  94 +++++++++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi  | 170 +++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi  | 169 +++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi | 208 +++++++++++++++++++
 4 files changed, 641 insertions(+)

-- 
2.39.2

