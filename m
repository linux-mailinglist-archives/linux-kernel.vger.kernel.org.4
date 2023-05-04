Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C246F626D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 02:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjEDAtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 20:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEDAtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 20:49:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B6799;
        Wed,  3 May 2023 17:49:01 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6AF1866029DE;
        Thu,  4 May 2023 01:48:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683161340;
        bh=fb9qzuGOPKwdGOlOltLWR82xaBQN6heDuW2S3Fru+/U=;
        h=From:To:Cc:Subject:Date:From;
        b=UKGB6Kw3vKZDXwfQqPEvvC3UVMVo3BMhPuyYlP6olq/3B2Db2zOjpns1Chy6Pewtb
         +80HIQei65zowdbNqRbIJgeQvEw4uWmcp9I47y0x3HN3+dPxB4Bqo/a7QIObzDf+dy
         E4jYD7NnzwCEfar9Ijacx5y57G78loqTdS01qCuhUEKgOnAKnLYjyNVVKKZGSOandk
         dyvs4Sy6qXAKKNCow4PJoAAn8Tb+3XLi9KD7M0/RIf+FJxxBsSm8layenuR15l9jXX
         92lucnOuUYLtlFGAAjRJll3l1ymikA2lkJrJ4UZTSqSoLyICp7Lx8XYOZEKTXipRZG
         9EVyauRRKEodw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kernel@collabora.com, Alexandre Mergnat <amergnat@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 0/6] thermal/drivers/mediatek/lvts_thermal: Fixes to the interrupt handling
Date:   Wed,  3 May 2023 20:48:46 -0400
Message-Id: <20230504004852.627049-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes in the interrupt handling of the LVTS thermal driver noticed while
testing it on the Spherion Chromebook (mt8192-asurada-spherion) with the
MT8192 support series [1].

These are standalone fixes and don't depend on anything else.

While version 1 fixed the interrupt storms that were happening, after
doing some more testing I realized that interrupts still weren't
correctly working when crossing thermal trip points, so I've added a
couple more commits to get that fixed on version 2.

[1] https://lore.kernel.org/all/20230307163413.143334-1-bchihi@baylibre.com/

Thanks,
Nícolas

Changes in v2:
- Added commits 3, 5, 6 to get working interrupts when crossing thermal
  trip points
- Updated commit 4 with interrupt flags for the offset

Nícolas F. R. A. Prado (6):
  thermal/drivers/mediatek/lvts_thermal: Handle IRQ on all controllers
  thermal/drivers/mediatek/lvts_thermal: Honor sensors in immediate mode
  thermal/drivers/mediatek/lvts_thermal: Use offset threshold for IRQ
  thermal/drivers/mediatek/lvts_thermal: Disable undesired interrupts
  thermal/drivers/mediatek/lvts_thermal: Don't leave threshold zeroed
  thermal/drivers/mediatek/lvts_thermal: Manage threshold between
    sensors

 drivers/thermal/mediatek/lvts_thermal.c | 142 ++++++++++++++++++------
 1 file changed, 110 insertions(+), 32 deletions(-)

-- 
2.40.1

