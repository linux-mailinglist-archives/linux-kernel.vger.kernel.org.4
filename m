Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA56074A126
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjGFPii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjGFPih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:38:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF0C171D;
        Thu,  6 Jul 2023 08:38:36 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F32F86606FD9;
        Thu,  6 Jul 2023 16:38:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688657914;
        bh=YtEw57pQl1u5j7kjoL9FMCgBqCbc54t/fOoETI0WtnM=;
        h=From:To:Cc:Subject:Date:From;
        b=S8tuXTraa+8ofdyz9TCNT4AAyvTRMBzIUG/O5SQBwf6Lx4/X9o/4Y7ePkfsTrkifF
         n9kwhBPYBoYUISK1sQAefLgAxhlgo9Q33iFi2csLXL+y7FDt8JmNtu8Zs6lxb69neW
         AT8dc9b9S9irmqcMa94PRrffHP+N91aUUezYx58SMKBOQ6YX8OK/TjctgTSzWNbk/u
         LyM3r3d/2wPuvJpMwKtn7Ea9qD4VXRnjMdjf+erLfpgJ0jQzJBoNIk4OYbctf++yKW
         PT2K+4Hl6mv5yuCxWGg+qjIX8AWSNY22se9+GZNbd1F1f+XNM9jOzZy8g9YyPqxuDb
         T9wkTFN9FxuOQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 0/6] thermal/drivers/mediatek/lvts_thermal: Fixes to the interrupt handling
Date:   Thu,  6 Jul 2023 11:37:31 -0400
Message-ID: <20230706153823.201943-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series fixes interrupt handling in the LVTS thermal driver. It not
only solves the interrupt storms currently happening, but also allows
the temperature monitoring interrupts to trigger when the thermal trip
temperature is reached.

This series was tested together with the MT8192 support series [1] on
the Spherion Chromebook (mt8192-asurada-spherion).

These are standalone fixes and don't depend on anything else.

[1] https://lore.kernel.org/all/20230530195132.2286163-1-bero@baylibre.com

Thanks,
Nícolas

Changes in v3:
- Reworded cover letter
- Split bitmaps for immediate and filtered modes into separate arrays
  (patch 2)
- Removed duplicate code for setting MINIMUM_THRESHOLD (patch 5)

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

 drivers/thermal/mediatek/lvts_thermal.c | 152 ++++++++++++++++++------
 1 file changed, 115 insertions(+), 37 deletions(-)

-- 
2.41.0

