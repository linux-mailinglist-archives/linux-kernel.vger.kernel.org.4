Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB28732E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345079AbjFPKbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345098AbjFPKa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E454A4EE6;
        Fri, 16 Jun 2023 03:27:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEC8F6364D;
        Fri, 16 Jun 2023 10:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19CAC433C8;
        Fri, 16 Jun 2023 10:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911252;
        bh=e0FqgMXuLmowGZmYZK4dy55udaFDEqsCTjD3af4rmvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WRmD4bj0VFYlL4vJzZd0FhhvDurUMzJygdzdgn1cVRLpJfSXFnl8nMwwdrwDf+PZg
         ZTt4Dl14MIJHYoYnO746QVTLrOUwVplHmg7eFaSeZ+QFXJ0VPLiw+NRZc0DTRf7u9T
         8LWSs5bHHVU4FC/rcraU13ISnQz7K1BiexNdlUKEDw7jgg7Jk8y+3EtD4STq0Y91up
         G+IhDRN5Am6lq7tCoqMEx6ye8mHhpDehk811DDDW4X+wzbBX3XZ8XLs62ygrESxHkl
         ncd3O4HLdpqDGl9AN54mYA9FoWKmkB8qBseGVBiG1CC3EDRz1sbZUnXDhtetMNDXVf
         YGaG8qyxljudQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        agross@kernel.org, andersson@kernel.org,
        yung-chuan.liao@linux.intel.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.15 06/16] soundwire: qcom: add proper error paths in qcom_swrm_startup()
Date:   Fri, 16 Jun 2023 06:27:09 -0400
Message-Id: <20230616102721.673775-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102721.673775-1-sashal@kernel.org>
References: <20230616102721.673775-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.117
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 99e09b9c0ab43346c52f2787ca4e5c4b1798362e ]

Reverse actions in qcom_swrm_startup() error paths to avoid leaking
stream memory and keeping runtime PM unbalanced.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230517163736.997553-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/qcom.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 2ba0911f5d0cc..64b157f5f80db 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1026,8 +1026,10 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
 	int ret, i;
 
 	sruntime = sdw_alloc_stream(dai->name);
-	if (!sruntime)
-		return -ENOMEM;
+	if (!sruntime) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
 
 	ctrl->sruntime[dai->id] = sruntime;
 
@@ -1037,12 +1039,19 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
 		if (ret < 0 && ret != -ENOTSUPP) {
 			dev_err(dai->dev, "Failed to set sdw stream on %s\n",
 				codec_dai->name);
-			sdw_release_stream(sruntime);
-			return ret;
+			goto err_set_stream;
 		}
 	}
 
 	return 0;
+
+err_set_stream:
+	sdw_release_stream(sruntime);
+err_alloc:
+	pm_runtime_mark_last_busy(ctrl->dev);
+	pm_runtime_put_autosuspend(ctrl->dev);
+
+	return ret;
 }
 
 static void qcom_swrm_shutdown(struct snd_pcm_substream *substream,
-- 
2.39.2

