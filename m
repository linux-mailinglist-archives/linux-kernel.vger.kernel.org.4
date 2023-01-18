Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D91672182
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjARPkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjARPki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:40:38 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE6310DE;
        Wed, 18 Jan 2023 07:40:36 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pIAY6-0007gG-1J;
        Wed, 18 Jan 2023 16:40:26 +0100
Date:   Wed, 18 Jan 2023 15:40:19 +0000
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
        Chad Monroe <chad@monroe.io>, John Crispin <john@phrozen.org>
Subject: [PATCH v5 0/2] thermal: mediatek: add support for MT7986 and MT7981
Message-ID: <cover.1674055882.git.daniel@makrotopia.org>
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

Changes since v4: Only use switch statement where requested[2] and keep
if-else logic in other places.

When submitting v3, it looked like the patch series submitted by Amjad
Ouled-Ameur ("thermal: mediatek: Add support for MT8365 SoC"[3]) which
also adds this function pointer would be merged first. However, a
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

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?h=thermal/bleeding-edge&id=071e99848ccc1fbe238c4c9c7cfffd83f1dfe156
[2]: https://lore.kernel.org/lkml/0b72a12c-286f-79d0-09e9-b1761530850a@collabora.com/
[3]: https://lore.kernel.org/linux-arm-kernel/4121bb6b-30db-7a23-f4c8-40afdda7a0b5@linaro.org/T/

Daniel Golle (2):
  thermal/drivers/mtk: use function pointer for raw_to_mcelsius
  thermal: mediatek: add support for MT7986 and MT7981

 drivers/thermal/mtk_thermal.c | 143 +++++++++++++++++++++++++++++++---
 1 file changed, 133 insertions(+), 10 deletions(-)


base-commit: 9ce08dd7ea24253aac5fd2519f9aea27dfb390c9
-- 
2.39.1

