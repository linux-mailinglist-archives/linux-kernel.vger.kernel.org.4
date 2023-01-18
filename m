Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C485767123A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 04:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjARDz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 22:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjARDzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 22:55:23 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE34453FA2;
        Tue, 17 Jan 2023 19:55:18 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pHzXZ-00032D-0e;
        Wed, 18 Jan 2023 04:55:09 +0100
Date:   Wed, 18 Jan 2023 03:55:01 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Steven Liu <steven.liu@mediatek.com>,
        Henry Yen <Henry.Yen@mediatek.com>,
        Chad Monroe <chad@monroe.io>, John Crispin <john@phrozen.org>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH v4 0/2] thermal: mediatek: add support for MT7986 and MT7981
Message-ID: <cover.1674012985.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As requested in a previous review, first convert the if-else selection
of the raw_to_mcelsius_* function to instead use a function pointer
added to struct mtk_thermal. Then add thermal support for the MT7986
SoC which can also be used on MT7981.

Device Tree bindings have already been merged[1].

When submitting v3, it looked like the patch series submitted by Amjad
Ouled-Ameur ("thermal: mediatek: Add support for MT8365 SoC"[2]) which
also adds this function pointer would be merged first. However, this a
re-spin of this series addressing the comments it has received has not
yet been submitted. The change introducing the raw_to_mcelsius function
pointer is hence being applied independently.

Changes since v2: Rebase on top of pending patch introducing
raw_to_mcelsius function pointer.
Drop left-over macro extracting the unused adc_oe field.
Use switch (...) instead of if-else-if-else-... statements.
For now, return -EINVAL as default in case of unknown version. Imho
this should be BUG(), as this version is only defined within this
driver.

Changes since v1: Drop use of adc_oe field in efuse, Henry Yen
confirmed its use has been dropped intentionally in MTK SDK as well.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//071e99848ccc1fbe238c4c9c7cfffd83f1dfe156
[2]: https://lore.kernel.org/linux-arm-kernel/4121bb6b-30db-7a23-f4c8-40afdda7a0b5@linaro.org/T/

Daniel Golle (2):
  thermal/drivers/mtk: use function pointer for raw_to_mcelsius
  thermal: mediatek: add support for MT7986 and MT7981

 drivers/thermal/mtk_thermal.c | 150 +++++++++++++++++++++++++++++++---
 1 file changed, 140 insertions(+), 10 deletions(-)

-- 
2.39.1

