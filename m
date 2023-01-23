Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AFB6780E7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjAWQG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjAWQGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:06:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58C87A80;
        Mon, 23 Jan 2023 08:06:22 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8B09B6602E19;
        Mon, 23 Jan 2023 16:06:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674489981;
        bh=cQC3SstRN0i+rvAOG3ydA4+K6fOMQx+oZJ/RtdVRVpw=;
        h=From:To:Cc:Subject:Date:From;
        b=et/J8I8vWx34O+uyFxgCXVxZQYlkSJwYerq+782D+3/vyLydpK1LW4NJB/MnGYvja
         7daHL7g9uGu7Au5vdVrI1rEt/2BxZQJftUU9huccAqA/zkuxNL3NaFB7U3t71m6+7X
         remb2zKawD6ZiKN9yHZ5OlyZMj89MPlgM0ie0eRUOFL+DSnkapAv5f/rKNptT4rSPU
         9MI5H82KP3vuc0Cl1uGq9GsJLBs14ZQrKpo7uVlfSaFWdupWrEN0Bw3POWWfLScqS8
         9UScJ4m1cKEEmJbXafsKxWZ+4tajbM6imq4Kf0eepjqT2tlFy2KR8tVD5AyF3SqIsY
         ec2HzgVzl99QQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, matthias.bgg@gmail.com,
        weiqing.kong@mediatek.com, jitao.shi@mediatek.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/2] pwm: mtk-disp: Fix backlight configuration at boot
Date:   Mon, 23 Jan 2023 17:06:13 +0100
Message-Id: <20230123160615.375969-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
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

Since the pwm-mtk-disp driver was fixed to get PWM_EN state from the
right register, an old two-wrongs-make-one-right issue emerged: as a
result, MT8192 Asurada Spherion got no backlight at boot unless a
suspend/resume cycle was performed.
Also, the backlight would sometimes not get updated with the requested
value, requiring the user to change it back and forth until it worked.

This series fixes both of the aforementioned issues found on MT8192.

AngeloGioacchino Del Regno (2):
  pwm: mtk-disp: Disable shadow registers before setting backlight
    values
  pwm: mtk-disp: Configure double buffering before reading in
    .get_state()

 drivers/pwm/pwm-mtk-disp.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

-- 
2.39.0

