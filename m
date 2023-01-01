Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9470865ABE7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 23:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjAAWB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 17:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAAWBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 17:01:53 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFE8114F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 14:01:52 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id x22so62946994ejs.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 14:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9nAEQgskD1p+skSduuar8ryWV0VfVRmc/5BdM22AEHM=;
        b=QHZknpCyz6goEZvOFtEpnRgZs7Bjhg4tCY45czBLsETy73xMfeLOZ4svEmlqO04aQd
         P2Gg9WJzpPVmELWtFMIsV6H+ZWqHwl5d3zrBhQsWycE0LTzR60IahcIDIqWPLGl9WrV6
         5yavHHY96RmAlStBCsNXggvH6hougx5I0KWCDSUEUafetM5qMopZBuyhqq0JdXn5mfJO
         rdpJyq9YsOkEBEza1HdCMpLSx6xgQrvM19dtEnT68fvtBhfZYdrdwi2yIU4LuLJ0sV4B
         cdayUYAR5IAu+KDUGY0ktUjOEOluvrgWGYb2GfoUzZi2QM3/txkf9fj2x2RR07rg4u/T
         qCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nAEQgskD1p+skSduuar8ryWV0VfVRmc/5BdM22AEHM=;
        b=Q6N/Mx97xfRIkMyJTasg2hZ2qzJG1HEpj9FHwVxV5aXnrHRZVkjG7rjdzcgyvUWndP
         vMlLN9ivXRjIwWINQvQODZ9IeLLQwbIEBN/efpAesAO1YYtG5r/xZSV6eU3W2ES3KeUN
         10pmPiFAAV2EJTIU2NwkG9EPY9KZuksBpWfHOTmWVkRqv539kvAY8/0ekUm+JLI51MaP
         9jiKsd46LO4YdPEeoFBZk8KO2haOTo3rZDa7FQldSSVSNbYcQ1afGUOwVUYHILxJXWtU
         egMVjDioZaJfkRjnbOD4dTC6B6/5j2NXQ3bYiP7KTjHNfNwtRdtP4d02sqkl1tdCcfe8
         E9gQ==
X-Gm-Message-State: AFqh2kqX8bZbzHk/LtL8VFGJj9FZ2C2N1v/Ai93/0l14rW2ti18ClWFm
        qM43KsLtWVgfnw5GwrjEnqb+IQ==
X-Google-Smtp-Source: AMrXdXvEfhtw8CmHeGkLwdMMPysWFJzv5uV+nc1KGgWUinvLxJebmQBqV1yB7wAGo/jHBa6kwrZbdA==
X-Received: by 2002:a17:906:6807:b0:7c0:9805:4060 with SMTP id k7-20020a170906680700b007c098054060mr44649306ejr.38.1672610511451;
        Sun, 01 Jan 2023 14:01:51 -0800 (PST)
Received: from predatorhelios.fritz.box (dynamic-2a01-0c23-7c55-d800-0fbe-25d2-487e-ae5c.c23.pool.telefonica.de. [2a01:c23:7c55:d800:fbe:25d2:487e:ae5c])
        by smtp.gmail.com with ESMTPSA id d12-20020a170906304c00b007c17b3a4163sm12486807ejd.15.2023.01.01.14.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 14:01:51 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org,
        linus.walleij@linaro.org, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, nfraprado@collabora.com,
        sean.wang@mediatek.com, zhiyong.tao@mediatek.com
Subject: [PATCH v7 0/7] Add minimal MT8365 and MT8365-EVK support
Date:   Sun,  1 Jan 2023 23:01:42 +0100
Message-Id: <20230101220149.3035048-1-bero@baylibre.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds minimal support for the MediaTek 8365 SOC and the EVK reference
board, allowing the board to boot to initramfs with serial port I/O.

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


Bernhard Rosenkränzer (4):
  dt-bindings: arm64: dts: mediatek: Add mt8365-evk board
  dt-bindings: irq: mtk, sysirq: add support for mt8365
  dt-bindings: mfd: syscon: Add mt8365-syscfg
  dt-bindings: pinctrl: add bindings for Mediatek MT8365 SoC

Fabien Parent (3):
  dt-bindings: usb: mediatek,mtu3: add MT8365 SoC bindings
  dt-bindings: usb: mediatek,mtk-xhci: add MT8365 SoC bindings
  arm64: dts: mediatek: Initial mt8365-evk support

 .../devicetree/bindings/arm/mediatek.yaml     |   4 +
 .../interrupt-controller/mediatek,sysirq.txt  |   1 +
 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 .../pinctrl/mediatek,mt8365-pinctrl.yaml      | 197 +++++++++
 .../bindings/usb/mediatek,mtk-xhci.yaml       |   1 +
 .../bindings/usb/mediatek,mtu3.yaml           |   1 +
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts   | 169 ++++++++
 arch/arm64/boot/dts/mediatek/mt8365.dtsi      | 378 ++++++++++++++++++
 9 files changed, 753 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-evk.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8365.dtsi

-- 
2.39.0

