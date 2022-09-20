Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F965BE9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiITPH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiITPHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:07:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7B3C03
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:07:21 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MX4YS5jqdzmVlF;
        Tue, 20 Sep 2022 23:03:24 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 23:07:19 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 23:07:18 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <oder_chiou@realtek.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>
Subject: [PATCH -next] ASoC: rt5682s: simplify the return of rt5682s_probe()
Date:   Tue, 20 Sep 2022 23:14:13 +0800
Message-ID: <20220920151413.3455255-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit bfc5e8b860ad ("ASoC: rt5682s: Reduce coupling of
Micbias and Vref2 settings"), the return of rt5682s_probe()
can be simplified. No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/codecs/rt5682s.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index 9d7a70753c6f..466a37f3500c 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -2864,15 +2864,10 @@ static inline int rt5682s_dai_probe_clks(struct snd_soc_component *component)
 static int rt5682s_probe(struct snd_soc_component *component)
 {
 	struct rt5682s_priv *rt5682s = snd_soc_component_get_drvdata(component);
-	int ret;
 
 	rt5682s->component = component;
 
-	ret = rt5682s_dai_probe_clks(component);
-	if (ret)
-		return ret;
-
-	return 0;
+	return rt5682s_dai_probe_clks(component);
 }
 
 static void rt5682s_remove(struct snd_soc_component *component)
-- 
2.25.1

