Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AB66DFA32
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjDLPdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjDLPdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:33:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E944EC7;
        Wed, 12 Apr 2023 08:33:18 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6E50B66031FC;
        Wed, 12 Apr 2023 16:33:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681313597;
        bh=ecJH2EtX3R5DZMYZKjQw1ZtBrs//AYhOJV8hfuaZ1iU=;
        h=From:To:Cc:Subject:Date:From;
        b=I4d1ZOWZuIT/oAmJVJMEP6w3ieVTTFsTZqe193tCIt14+gHejTpmZcBSVrEJg39PH
         HKrNrkh79KFVkhTqGeiynDL9J+dGsIsgAXNn6f0UlQcz2X6mYViVA0o961ZIOVi12R
         lnUCcB6EA9Jn/AavzH34cyw17ifZBJKzB5BpSNGJ4klGme3jVU6xZqwR0eyHmemTgm
         m5kzhNozbvlEsdE90v+MxNnBBNJ893il1yRwuQwPMd0laV1n6stseHbm88I+KAvYBg
         AUk9PvBkQpARW85FwVRc1U0lIyDjk8LrfaNHGT8pL7FBZg0KKI5CDoqBSqStGIaVMu
         wuVM1BUoVijsw==
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
Subject: [PATCH v2 0/7] Add support for MT6331 and MT6332 LEDs
Date:   Wed, 12 Apr 2023 17:33:03 +0200
Message-Id: <20230412153310.241046-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

AngeloGioacchino Del Regno (7):
  dt-bindings: leds: leds-mt6323: Document mt6331 compatible
  dt-bindings: leds: leds-mt6323: Document mt6332 compatible
  leds: leds-mt6323: Specify registers and specs in platform data
  leds: leds-mt6323: Open code and drop MT6323_CAL_HW_DUTY macro
  leds: leds-mt6323: Drop MT6323_ prefix from macros and defines
  leds: leds-mt6323: Add support for MT6331 leds
  leds: leds-mt6323: Add support for WLEDs and MT6332

 .../devicetree/bindings/leds/leds-mt6323.txt  |   5 +-
 drivers/leds/leds-mt6323.c                    | 444 ++++++++++++++----
 2 files changed, 350 insertions(+), 99 deletions(-)

-- 
2.40.0

