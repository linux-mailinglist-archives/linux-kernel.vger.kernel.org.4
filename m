Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAF26D45D9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjDCNbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjDCNbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:31:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839E81FC1;
        Mon,  3 Apr 2023 06:31:03 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AF2216600013;
        Mon,  3 Apr 2023 14:31:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680528661;
        bh=Ud9yCIjB8jwMmXsFScRcYrf42votU0cIRo7MP8MJdsY=;
        h=From:To:Cc:Subject:Date:From;
        b=DztboHq63LfR00xbNZy1e6rjnslVuZLtPvi5e9+0B3QHJSGFlmpKpR7lqvd4UoV6C
         dKAU34GLYM2wh8nQVA1bJBDoYheifd7teJ8akpt9aMnyPVj4S39D3QA0/YZMhV54PO
         F/gn56tFNb+fgVkvIBu0I5LAv+hgX7OhQT+aemWf+xTuyr/s/AWeMo7YbbqEZCzav9
         sHhsv/ztLZoXRNzuMn+hHs/VoO/STx8O0gkruTB2PFpwguiK06jgFegBjMoDHj4wty
         DfEWRYuaJ4vL8g6oAaBfBrpzl02RnL/nW5FxH5BPXt1aFyW/QgZ/nO612BBiDnSa7Q
         GJyLSknky4+Xg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, matthias.bgg@gmail.com,
        weiqing.kong@mediatek.com, jitao.shi@mediatek.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH RESEND 0/2] pwm: mtk-disp: Fix backlight configuration at boot
Date:   Mon,  3 Apr 2023 15:30:52 +0200
Message-Id: <20230403133054.319070-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the pwm-mtk-disp driver was fixed to get PWM_EN state from the
right register, an old two-wrongs-make-one-right issue emerged: as a
result, MT8192 Asurada Spherion got no backlight at boot unless a
suspend/resume cycle was performed.
Also, the backlight would sometimes not get updated with the requested
value, requiring the user to change it back and forth until it worked.

This series fixes both of the aforementioned issues found on MT8192
and similar issues on MT8183 Chromebooks.

AngeloGioacchino Del Regno (2):
  pwm: mtk-disp: Disable shadow registers before setting backlight
    values
  pwm: mtk-disp: Configure double buffering before reading in
    .get_state()

 drivers/pwm/pwm-mtk-disp.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

-- 
2.39.0

