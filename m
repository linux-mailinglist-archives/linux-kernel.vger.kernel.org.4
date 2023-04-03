Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743896D4BE7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjDCP3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjDCP3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:29:31 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7015C30FB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:29:18 -0700 (PDT)
Received: from LAPTOP-6NFQSDTK.localdomain ([10.12.182.145])
        (user=yll@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 333FS2bR027146-333FS2bS027146
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Apr 2023 23:28:08 +0800
From:   Liliang Ye <yll@hust.edu.cn>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Liliang Ye <yll@hust.edu.cn>,
        Dan Carpenter <error27@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: fsl_mqs: call pm_runtime_disable() on error path
Date:   Mon,  3 Apr 2023 23:27:37 +0800
Message-Id: <20230403152737.17671-1-yll@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: yll@hust.edu.cn
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_disable was missed in cleanup operation, which corresponds to
the earlier call to pm_runtime_enable.

To fix this, add pm_runtime_disable() on error path.

Fixes: 9e28f6532c61 ("ASoC: fsl_mqs: Add MQS component driver")
Signed-off-by: Liliang Ye <yll@hust.edu.cn>
Reviewed-by: Dan Carpenter <error27@gmail.com>
---
 sound/soc/fsl/fsl_mqs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
index 32d20d351bbf..129d426c60c4 100644
--- a/sound/soc/fsl/fsl_mqs.c
+++ b/sound/soc/fsl/fsl_mqs.c
@@ -251,9 +251,13 @@ static int fsl_mqs_probe(struct platform_device *pdev)
 	ret = devm_snd_soc_register_component(&pdev->dev, &soc_codec_fsl_mqs,
 			&fsl_mqs_dai, 1);
 	if (ret)
-		return ret;
+		goto err_pm_disable;
 
 	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	return ret;
 }
 
 static int fsl_mqs_remove(struct platform_device *pdev)
-- 
2.34.1

