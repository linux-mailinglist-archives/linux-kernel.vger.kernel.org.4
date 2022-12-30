Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA10659C10
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 21:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiL3Ufw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 15:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiL3Ufq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 15:35:46 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6C1336
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 12:35:44 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b88so24451891edf.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 12:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c35vdC8Z5D9wRATcgK9ZqUx4CbBJ7cxYNHrmTF+xf4I=;
        b=DcxVMvOm79eLwrWdJhZUmVZse92z7FHpWJwZlkqpOg/uHYdnE+kpVVgEnkI5YtNQYq
         spz4HniZgaObn+dFrFH548OG070V65hGI9cShwndPvgFjx1m8ECfVK/6M4fEKfTZO4Qc
         vDgHxfYdULPwjT8cITw/MKAdBq8xKRHYLeC7rbPinpu0aut55nCW+1fv7HfJjCa6m8qD
         NojU4/omyWlrXDfiqH0h8wuG5G+SlI3mt+kZhl90++dA+VCQvjv/EbOS1vIJlZKR0ljq
         h1GP5Rfqk/qTHXqG9ueQ6BgxJNzYRtNt2+jb6qEFJnv1m/ONDAD8qqqz7owzMEZ+T6y9
         Ryog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c35vdC8Z5D9wRATcgK9ZqUx4CbBJ7cxYNHrmTF+xf4I=;
        b=aCs+/pc2tlaHq/rrayJV/kdEoWQHBvS6QS+KmPiwwUlnYS8BkM639Vw+m68nrL6Lce
         qGfQIL/hT/ZRcJ4P6pAC6yPsS6FtNdnoAhKnV35drBmSibA7xTXv4w4NQNxHm4BB7eSl
         Boyle4+vD+LKh4VdcGLSVD8d/u1x+lgoE02KCP1gblJoSimbiHlOhjzRZrS84y10nVwy
         mLpsLLGHzb5q3CgGCSTW7pcuPd9Va3KE1o0LozL7ZDloDWDnVJRBFtWx26/P4CYQNmhQ
         Mp+fZl+PAbIehWrUk/MXhmn8lZqZdRSsGWRKbXlMNZaV8lS/1fcunyajOpV1CNXW+gR/
         hDYA==
X-Gm-Message-State: AFqh2kqe/fMUIJ7E7jykbe86kGP10ny8QdIlnFuCN1pb4pY9zjagHH1x
        Ten0b8QCOB++mSZn6NE29mUGCDw6UVH6xVYLq+A=
X-Google-Smtp-Source: AMrXdXum8zmq8UrUgHT9L9BYn8Z/+pNc1RjjZ05TtokSFSv7w6vUqMMkRqQyp87Vbdrsvz4y0s/4AQ==
X-Received: by 2002:a50:ab1e:0:b0:47f:8c6f:5f31 with SMTP id s30-20020a50ab1e000000b0047f8c6f5f31mr28219402edc.14.1672432543117;
        Fri, 30 Dec 2022 12:35:43 -0800 (PST)
Received: from predatorhelios.fritz.box (dynamic-2a01-0c22-cd9d-4b00-ef17-3c78-1696-7315.c22.pool.telefonica.de. [2a01:c22:cd9d:4b00:ef17:3c78:1696:7315])
        by smtp.gmail.com with ESMTPSA id c10-20020a056402158a00b00482c1f1a039sm8350500edv.30.2022.12.30.12.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 12:35:42 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, gregkh@linuxfoundation.org,
        chunfeng.yun@mediatek.com, linus.walleij@linaro.org,
        lee@kernel.org, maz@kernel.org, tglx@linutronix.de,
        angelogioacchino.delregno@collabora.com
Subject: [PATCH v6 0/7] Add minimal MT8365 and MT8365-EVK support
Date:   Fri, 30 Dec 2022 21:35:34 +0100
Message-Id: <20221230203541.146807-1-bero@baylibre.com>
X-Mailer: git-send-email 2.39.0
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

This adds minimal support for the MediaTek 8365 SOC and the EVK reference
board, allowing the board to boot to initramfs with serial port I/O.

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
 arch/arm64/boot/dts/mediatek/mt8365.dtsi      | 374 ++++++++++++++++++
 9 files changed, 749 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-evk.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8365.dtsi

-- 
2.39.0

