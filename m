Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCC3719A91
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjFALIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjFALIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:08:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7628107;
        Thu,  1 Jun 2023 04:08:20 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0C5E26606EBB;
        Thu,  1 Jun 2023 12:08:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685617698;
        bh=Sse+Q1M/NQWUrVoTeA+SiLfS8fyeSQsrOZ1ZDEDAn2U=;
        h=From:To:Cc:Subject:Date:From;
        b=lRPk/Z3FXbz2jdk5r/vUaSO1C6jjTZmtwzaAZGeFXsPn+6Dx0WyuyeJF1VNxMCfUj
         n1VC4p+3H3MkKKmUB6WyVFbujawywFv9CMmkKe6VwikoYjjbjeSAv/KL61dXq1PiG6
         EormIXqeimQpdSJeKy/FM2LowMeX0yOqN9+xOPESI3zBuHu6+NQH44NTvFvvE8BnZi
         frJU1KlWKv2s4P8igJ7x6p5OmJEmOFnU1d7qBJ/s98YVq1G7Mbn9b8fqefe88kRVOE
         mECU7d2tH7sa8ftssUXSC2QhAA6qmgl5FOD8ig99MJ5kfPdficOXYCplkJyBtRSZIv
         4jbLR9Sj+js2w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     pavel@ucw.cz
Cc:     lee@kernel.org, sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 0/8] Add support for MT6331 and MT6332 LEDs
Date:   Thu,  1 Jun 2023 13:08:05 +0200
Message-Id: <20230601110813.2373764-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
 - Rebase over next-20230601
 - Beautified ISINK_CON0 comment
 - Added binding for mediatek,is-wled property

Changes in v2:
 - Rebase over next-20230412

NOTE: Since v1 of this series was sent in Semptember 2022 and got
ignored for *7 months* with no feedback, I'm retrying the upstreaming
of this same series.
There are no changes, if not just a simple rebase and another test
run on the same hardware.


MT6323 is not the only PMIC that has a LEDs controller IP and it was
found that the others do have a compatible register layout, except
for some register offsets.
The logic contained in this driver can be totally reused for other
PMICs as well, so I can't see any reason to keep this specific to
the MT6323 part.

This series brings meaningful platform data to this driver, giving
it flexibility and adding support for LED controllers found in the
MT6331 and MT6332 PMICs.

Tested on MT6795 Sony Xperia M5 smartphone.

AngeloGioacchino Del Regno (8):
  dt-bindings: leds: leds-mt6323: Document mt6331 compatible
  dt-bindings: leds: leds-mt6323: Document mt6332 compatible
  dt-bindings: leds: leds-mt6323: Support WLED output
  leds: leds-mt6323: Specify registers and specs in platform data
  leds: leds-mt6323: Drop MT6323_ prefix from macros and defines
  leds: leds-mt6323: Open code and drop MT6323_CAL_HW_DUTY macro
  leds: leds-mt6323: Add support for MT6331 leds
  leds: leds-mt6323: Add support for WLEDs and MT6332

 .../devicetree/bindings/leds/leds-mt6323.txt  |   6 +-
 drivers/leds/leds-mt6323.c                    | 448 ++++++++++++++----
 2 files changed, 352 insertions(+), 102 deletions(-)

-- 
2.40.1

