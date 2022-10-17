Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E158C601AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiJQVF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiJQVFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:05:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF4458DFE;
        Mon, 17 Oct 2022 14:05:49 -0700 (PDT)
Received: from localhost (unknown [188.24.131.113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 74FE0660229A;
        Mon, 17 Oct 2022 22:05:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666040747;
        bh=T9SO0KJzI7t9t5kHCa7qShjSy9PVO9xpWQIv8eD/WbY=;
        h=From:To:Cc:Subject:Date:From;
        b=dTR9uYjecKkmtUW+D9wQ7+Cr+YRiXo/t87DUK/2JZ6Q/MaU8pGkGSPgt1dJie1ElZ
         3UAUDhyEo39kbkYstLTm8F024Ht7QAQb9/ZfAvM3+Ek++qVRSpk4mnjqA6rlowFPt9
         m6JVloC3B6DtwICTS4IPRqoZHJwvNaIaYUhWNcn+ijc0IZ/cdA/PqJIX3DtLgGKtU4
         qMlt3FnJoxMZBqRzvxlmhELbHR7/wJIyqq6b+WDIbATO23dK+xwBWcepWURiPLetiS
         LDjEAmZFyLdacoRCS7L2/LCj+9SznAfQtUC3x62uybOjQWsNoBg+sxKC0a7hlKT87+
         YZ3kqRof1EN+Q==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Drew Fustini <drew@beagleboard.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH v4 0/3] Enable initial support for StarFive VisionFive V1 SBC
Date:   Tue, 18 Oct 2022 00:05:39 +0300
Message-Id: <20221017210542.979051-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The StarFive VisionFive V1 SBC [1] is similar with the already supported
BeagleV Starlight Beta board, both being based on the StarFive JH7100 SoC.

In addition to documenting the necessary compatibles, this patch series 
moves most of the content from jh7100-beaglev-starlight.dts to a new file
jh7100-common.dtsi, to be shared between the two boards.

No other changes are required in order to successfully boot the board.

[1] https://github.com/starfive-tech/VisionFive

Changes in v4:
 - Rebased onto v6.1.0-rc1
 - Fixed a conflict in patch 2/3 as pinctrl-starfive.h has been renamed
   to pinctrl-starfive-jh7100.h

Changes in v3:
 - Added Reviewed-by tag from Krzysztof in patch 1/3
 - Optimized patch 2/3 by enabling copy detection on "git format-patch",
   as indicated by Krzysztof

Changes in v2:
 - Simplified documentation by using 'enum' instead of 'const' in 
   patch 1/3, according to Conor's review
 - Added Reviewed-by tags from Conor

Cristian Ciocaltea (3):
  dt-bindings: riscv: starfive: Add StarFive VisionFive V1 board
  riscv: dts: starfive: Add common DT for JH7100 based boards
  riscv: dts: starfive: Add StarFive VisionFive V1 device tree

 .../devicetree/bindings/riscv/starfive.yaml   |   4 +-
 arch/riscv/boot/dts/starfive/Makefile         |   2 +-
 .../dts/starfive/jh7100-beaglev-starlight.dts | 153 +-----------------
 ...aglev-starlight.dts => jh7100-common.dtsi} |   3 -
 .../jh7100-starfive-visionfive-v1.dts         |  20 +++
 5 files changed, 25 insertions(+), 157 deletions(-)
 copy arch/riscv/boot/dts/starfive/{jh7100-beaglev-starlight.dts => jh7100-common.dtsi} (96%)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts


base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.38.0

