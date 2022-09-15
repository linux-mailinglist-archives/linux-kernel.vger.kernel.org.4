Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0385B9720
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiIOJNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiIOJMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:12:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1AC98C86;
        Thu, 15 Sep 2022 02:12:23 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0A2206601DA4;
        Thu, 15 Sep 2022 10:12:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663233142;
        bh=VA5VB4z2NgVxbPr8bvpxhyy2+avv1eayxIuBDflOGCQ=;
        h=From:To:Cc:Subject:Date:From;
        b=YzPowdGT5a0pDpkwJFuRkfR6DTqkF9H7FUq5rj/Gf0iltU133tiBi1cgjGXRHZpbL
         c1DH7dZoCZsUWk+4fHYC+ks1TiBby3HmrQ3ngA4zqPtYhrcWaERJEgPYPO7J+jCoth
         VEKoYzemxBP0IAgQcB9dQs+vDtyknmsmmHmhoHwlXmZgVZJhEkAQc/rRnx+4RceqLl
         OWeEOzyFYKBsCgeonnynUXar0w1Yt6PigY/DpY+qXx3StqhEjlS2p6M5odGOqjdVhB
         bb5xJmpJAhPi4viGnBXjTcRkyPYM+/TgS4nSL8/D/sfKfmwcKsJ6cxufwsxGpqkAZK
         4TeR15Zub03nA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@mediatek.com
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/7] Add support for MT6331 and MT6332 LEDs
Date:   Thu, 15 Sep 2022 11:12:07 +0200
Message-Id: <20220915091214.59673-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
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

AngeloGioacchino Del Regno (7):
  leds: leds-mt6323: Specify registers and specs in platform data
  leds: leds-mt6323: Open code and drop MT6323_CAL_HW_DUTY macro
  leds: leds-mt6323: Drop MT6323_ prefix from macros and defines
  dt-bindings: leds: leds-mt6323: Document mt6331 compatible
  leds: leds-mt6323: Add support for MT6331 leds
  dt-bindings: leds: leds-mt6323: Document mt6332 compatible
  leds: leds-mt6323: Add support for WLEDs and MT6332

 .../devicetree/bindings/leds/leds-mt6323.txt  |   5 +-
 drivers/leds/leds-mt6323.c                    | 444 ++++++++++++++----
 2 files changed, 350 insertions(+), 99 deletions(-)

-- 
2.37.2

