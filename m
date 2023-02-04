Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D951268AC25
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 20:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjBDTvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 14:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjBDTvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 14:51:40 -0500
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9D422DD0
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 11:51:37 -0800 (PST)
Received: from mta-01.yadro.com (localhost.localdomain [127.0.0.1])
        by mta-01.yadro.com (Proxmox) with ESMTP id 69028341C06;
        Sat,  4 Feb 2023 22:51:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :from:from:message-id:mime-version:reply-to:subject:subject:to
        :to; s=mta-01; bh=2+nG6RMfoQCfKHPRhE4D9HP+L4iRTiLBoadle+nMbyo=; b=
        PhHrspTRfdOaLp4uP4cRCSYvziyhdMMyPYBxhL1GdgJrg3d3PA5AHWmTxrGAB5LN
        2SfHcA1YTof0GHW5S/mNIIGlIf3hraNfiHrRqxL+nN8GR8Gkx3aDXN361sCbTE9o
        grQJeb87P9Nq+n//ABFmrPLjjGaUjYV0gJCGVxkhFXM=
Received: from T-EXCH-08.corp.yadro.com (unknown [172.17.10.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Proxmox) with ESMTPS id 5AAA03418EC;
        Sat,  4 Feb 2023 22:51:35 +0300 (MSK)
Received: from nb-1688.corp.yadro.com (10.199.23.92) by
 T-EXCH-08.corp.yadro.com (172.17.11.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.9; Sat, 4 Feb 2023 22:51:34 +0300
From:   Alexey Firago <a.firago@yadro.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <alsa-devel@alsa-project.org>, <zhuning0077@gmail.com>,
        <yangyingliang@huawei.com>, <yangxiaohua@everest-semi.com>,
        <broonie@kernel.org>, <tiwai@suse.com>,
        Alexey Firago <a.firago@yadro.com>
Subject: [PATCH] ASoC: codecs: es8326: Fix DTS properties reading
Date:   Sat, 4 Feb 2023 22:51:06 +0300
Message-ID: <20230204195106.46539-1-a.firago@yadro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.23.92]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like properties parsing and reading was copy-pasted,
so "everest,interrupt-src" and "everest,interrupt-clk" are saved into
the es8326->jack_pol variable. This might lead to wrong settings
being saved into the reg 57 (ES8326_HP_DET).

Fix this by using proper variables while reading properties.

Signed-off-by: Alexey Firago <a.firago@yadro.com>
---
 sound/soc/codecs/es8326.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
index 9ddf6a35e91c..28a0565c2a95 100644
--- a/sound/soc/codecs/es8326.c
+++ b/sound/soc/codecs/es8326.c
@@ -729,14 +729,16 @@ static int es8326_probe(struct snd_soc_component *component)
 	}
 	dev_dbg(component->dev, "jack-pol %x", es8326->jack_pol);
 
-	ret = device_property_read_u8(component->dev, "everest,interrupt-src", &es8326->jack_pol);
+	ret = device_property_read_u8(component->dev, "everest,interrupt-src",
+				      &es8326->interrupt_src);
 	if (ret != 0) {
 		dev_dbg(component->dev, "interrupt-src return %d", ret);
 		es8326->interrupt_src = ES8326_HP_DET_SRC_PIN9;
 	}
 	dev_dbg(component->dev, "interrupt-src %x", es8326->interrupt_src);
 
-	ret = device_property_read_u8(component->dev, "everest,interrupt-clk", &es8326->jack_pol);
+	ret = device_property_read_u8(component->dev, "everest,interrupt-clk",
+				      &es8326->interrupt_clk);
 	if (ret != 0) {
 		dev_dbg(component->dev, "interrupt-clk return %d", ret);
 		es8326->interrupt_clk = 0x45;
-- 
2.34.1


