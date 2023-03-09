Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EB46B26F5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjCIOfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjCIOfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:35:10 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7811E776C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:35:08 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id i34so7790239eda.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678372507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LcEhx6gwR6RWgOvUTF3rgHelWTStZx88DS9IMOMzcYU=;
        b=FIJWNNaofZWm8AxmxcUFTGhqI9nJpkQC4bcmzdHza+fFFH95WrysDBUjPdBXqCHsrg
         R9yc/R7d2RsgDVpk4ddqOvVWwvyU8BO2PDocQ5/anqLEM1PkNz9anPio13HqtNSLW6yP
         QfF/OvhCbWx8Eh/3Via82aOWBwZDP02NyTE0FSNnrtgG9UzwwDa9ybYH/XAE43m4TCcf
         OawvE/0LGFHtu95cS26raTOVlABECe9uZyBZSsxB1h84Dc9vpym/sPJUxHneChRAr/bb
         /94MvFGKBgi/2ceDLnLtmcdyQx1Zaeh3mXQRV6JIsUTovvLYI1TkbtCQ834VKXUfKsF4
         Ufmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678372507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LcEhx6gwR6RWgOvUTF3rgHelWTStZx88DS9IMOMzcYU=;
        b=VI5mZK8MRCA9fA5e1hyXuCbkIa7/pOjU8vKIpd+7AgNdT6auDXBjz1WqE9vE9iFZab
         sDZkrB7kvXCQxKB9Cq4fr9gkx45YLvrH0satn4kqC74mKNSjhLWlX47Z66we4O2ki1or
         /aTPkmkthKOEyxS5949q7jN5aLQbOcbWyQ56GpkvNmRA40Wh0vYSWhNWqw303a2m4hJM
         pxAVJFXZcpYYxbXot74QtxM5NxRaFFWV5OoQzY1MSUzXK4QPVkcdYBQfVIeGnSYWyhhQ
         xQHBDsqm7lIwQwdldLBX6US6/w7pnjl7Bnx0nl9unTDpZ0rU80AYe+CbETVo5wuy1VTi
         aY+g==
X-Gm-Message-State: AO0yUKVOk2gMdpxZ2IkfHVI2Zj0suWFkW6mCnFb6HzL5MNv8vB9ygHls
        SxOyvILJk1FsmlQbBF3CfxsnKw==
X-Google-Smtp-Source: AK7set+eI67TsJNA/66GefmT4qzKOSQRbouWIWJn6ZDtGfr+R3ZEuDDFMKPnSJG7bOq8diBflcU+rg==
X-Received: by 2002:a17:906:1604:b0:8af:7b80:82ba with SMTP id m4-20020a170906160400b008af7b8082bamr20836675ejd.20.1678372507320;
        Thu, 09 Mar 2023 06:35:07 -0800 (PST)
Received: from ryzen9.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id w4-20020a170906184400b008cb7473e488sm9046239eje.12.2023.03.09.06.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 06:35:06 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, maz@kernel.org, tglx@linutronix.de
Subject: [PATCH v10 0/3] Add minimal MT8365 and MT8365-EVK support
Date:   Thu,  9 Mar 2023 15:34:56 +0100
Message-Id: <20230309143459.401783-1-bero@baylibre.com>
X-Mailer: git-send-email 2.40.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v10:
  - Fix systimer properties (Thanks Amjad)
  - Drop components of the patchset that have already been merged

v9:
  - Fix a regression in v8 that broke the USB port
  - Remove superfluous include in mt8365.dtsi
  - Fix some naming issues pointed out by dtbs_check

v8:
  - Add binding descriptions for mediatek,mt8365-systimer and
    mediatek,mt8365-uart
  - Specify ranges with parameters for u3phy

Tested-by: Kevin Hilman <khilman@baylibre.com>

v7:
  - Update GIC information in mt8365.dtsi (thanks to Marc Zyngier for
    pointing out the problem)
  - Adjust the timer to match the updated GIC information

v6:
  - Add systimer in mt8365.dtsi
  - Add I/D caches and L2 cache details in mt8365.dtsi
  - Move bl31_secmon_reserved from mt8365.dtsi to mt8365-evk.dts
  - Fix inconsistent indentation in mt8365-pinctrl example
  - Further mt8365.dtsi cleanups
  - Submit to additional maintainers spotted by get_maintainer.pl

v5:
  - Reorder top-level entries in mediatek,mt8365-pinctrl.yaml to match
    example-schema
  - Use consistent quotes

v4:
  - Remove pins-are-numbered references that have been holding things up
    now that the patches removing it from dt-bindings have landed in linux-next

v3:
  - Remove a number of components that are not yet supported (they will
    come back alongside the corresponding drivers)
  - Address issues found by dt_binding_check (mostly fixing pinctrl
    bindings)
  - Address issues pointed out in comments
  - Reorder patches

v2:
  - Add missing dt-bindings documentation
  - Small cleanups addressing issues in v1 pointed out by Krzysztof Kozlowski


Bernhard Rosenkränzer (2):
  dt-bindings: irq: mtk, sysirq: add support for mt8365
  dt-bindings: serial: mediatek,uart: add MT8365

Fabien Parent (1):
  arm64: dts: mediatek: Initial mt8365-evk support

 .../interrupt-controller/mediatek,sysirq.txt  |   1 +
 .../bindings/serial/mediatek,uart.yaml        |   1 +
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts   | 168 ++++++++
 arch/arm64/boot/dts/mediatek/mt8365.dtsi      | 377 ++++++++++++++++++
 5 files changed, 548 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-evk.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8365.dtsi

-- 
2.40.0.rc2

