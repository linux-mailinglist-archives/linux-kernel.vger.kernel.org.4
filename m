Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEFD6194E7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiKDK4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKDK4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:56:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0002662C4;
        Fri,  4 Nov 2022 03:56:11 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3F5336602970;
        Fri,  4 Nov 2022 10:56:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667559369;
        bh=kR0yMmfSADaph/vvvsbk8ijgbIAXuJ7Ew0EtyUSL8pQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ElwKlRjACqNxRMX31ZGDEzzA7bLPFU7hCpa3HSCzqanj7wQt6Risk6xSZMSgmndwH
         bRH7opU6YJpLbY9JePqn5pUTXK2g+Vx/Ft291hEWKRVeWBmDgSnXa3xSQzFRB9JX/p
         e7KDPuysbKymQlh8hnlBAiaAHmiRNTAT0MfoOOHrE7Dt5NqHYcVu2E4xOd0iv/PN9h
         hVkPH5QgqzlvGoQlYLkMAzwZQKSjDZAmPAN7ArpD2aB1U98t8dxr6U6qayPVAYy5z9
         RNknrq1sTdXlsnelalFxRGYukYx/O+ucmg0Cra9ASRoAL27XaPVwhZP6bvvnjSCz3+
         CC5mR2RUdRQOQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linus.walleij@linaro.org
Cc:     sean.wang@kernel.org, matthias.bgg@gmail.com,
        zhiyong.tao@mediatek.com, wenst@chromium.org,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] pinctrl: mediatek: common-v2: Fix bias-disable for PULL_PU_PD_RSEL_TYPE
Date:   Fri,  4 Nov 2022 11:56:05 +0100
Message-Id: <20221104105605.33720-1-angelogioacchino.delregno@collabora.com>
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

In pinctrl-paris we're calling the .bias_set_combo() callback when we
are asked to set the pin bias to either pull up/down or pull disable.

On newer platforms, this callback is mtk_pinconf_bias_set_combo(),
located in pinctrl-mtk-common-v2.c: this will check the "pull type"
assigned to the requested pin and in case said pin's pull type is
MTK_PULL_PU_PD_RSEL_TYPE, this function will set RSEL first, PUPD
last, which is fine.

The issue comes when we're requesting PIN_CONFIG_BIAS_DISABLE, as
this does *not* require setting RSEL but only PU_PD: in this case,
the arg is MTK_DISABLE (zero), which is not a supported RSEL, due
to which function mtk_pinconf_bias_set_rsel() returns a failure;
because of that, mtk_pinconf_bias_set_pu_pd() is never called,
hence the pin bias is never set to DISABLE.

To fix this issue, add a check to mtk_pinconf_bias_set_rsel(): if
we are entering that function with no pullup requested and at the
same time the arg is MTK_DISABLE, this means that we're trying to
disable pin bias, hence it's safe to return cleanly without ever
setting any RSEL register.
This makes mtk_pinconf_bias_set_combo() happy, going on with setting
the PU_PD registers, which is the only action to actually take to
disable bias on a pin/pingroup.

Fixes: fb34a9ae383a ("pinctrl: mediatek: support rsel feature")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index e1ae3beb9f72..b7921b59eb7b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -709,6 +709,9 @@ static int mtk_pinconf_bias_set_rsel(struct mtk_pinctrl *hw,
 {
 	int err, rsel_val;
 
+	if (!pullup && arg == MTK_DISABLE)
+		return 0;
+
 	if (hw->rsel_si_unit) {
 		/* find pin rsel_index from pin_rsel array*/
 		err = mtk_hw_pin_rsel_lookup(hw, desc, pullup, arg, &rsel_val);
-- 
2.37.2

