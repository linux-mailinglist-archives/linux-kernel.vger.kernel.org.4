Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CF26FFF13
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 04:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbjELCyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 22:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjELCyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 22:54:18 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF5AE66
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 19:54:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0ViNAMMq_1683860051;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0ViNAMMq_1683860051)
          by smtp.aliyun-inc.com;
          Fri, 12 May 2023 10:54:13 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     pierre-louis.bossart@linux.intel.com
Cc:     lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ASoC: SOF: topology: Fix missing error code in sof_route_load()
Date:   Fri, 12 May 2023 10:54:10 +0800
Message-Id: <20230512025410.52832-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error code is missing in this code scenario, add the error code
'-EINVAL' to the return value 'err'.

sound/soc/sof/topology.c:2060 sof_route_load() warn: missing error code 'ret'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4935
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/sof/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index d3d536b0a8f5..3ca3a72f1805 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -2045,7 +2045,6 @@ static int sof_route_load(struct snd_soc_component *scomp, int index,
 	if (!source_swidget) {
 		dev_err(scomp->dev, "error: source %s not found\n",
 			route->source);
-		ret = -EINVAL;
 		goto err;
 	}
 
@@ -2064,7 +2063,6 @@ static int sof_route_load(struct snd_soc_component *scomp, int index,
 	if (!sink_swidget) {
 		dev_err(scomp->dev, "error: sink %s not found\n",
 			route->sink);
-		ret = -EINVAL;
 		goto err;
 	}
 
@@ -2087,6 +2085,8 @@ static int sof_route_load(struct snd_soc_component *scomp, int index,
 	return 0;
 err:
 	kfree(sroute);
+	ret = -EINVAL;
+
 	return ret;
 }
 
-- 
2.20.1.7.g153144c

