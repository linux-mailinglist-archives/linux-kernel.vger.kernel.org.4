Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18A0732E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344480AbjFPK31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344061AbjFPK2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:28:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C292230FC;
        Fri, 16 Jun 2023 03:26:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43D306364D;
        Fri, 16 Jun 2023 10:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770DBC433C0;
        Fri, 16 Jun 2023 10:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911202;
        bh=9gVndDDGD3GB5YZiZTn+lErzwx67qIfGPxOubXPSXPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YeXUuc34FCH8NTyCplbJ7WXDhTemElK4rEKmxW3NRn7K5dSsDzWzWpR2DCGuPhAwi
         EFy4HzjjBMTC7XLivNMWDG4auWgpjzw9esTCRAc/ZjQOnp4sw0Y2LDTIxoPmIPd/QF
         G77UuXdiGDysSaU1sJa04RwQWYlWldcwJwLggyMXTNanK2b3hoXirL4HtMyb5fBhc1
         4QeJIbxuONI7tl3O0DzHMuSa+cSszGJ4OOlR3zCQTx1QrpAIc/HFKbCG4PTbVRj6J1
         0ZTsHbRjYqArEOoZqTlhlwrMzupdl8F1RTWEBqvxJwZoQ4kTe0f+E47NJWkFsJaOfb
         I2XcGs+/IJ/OQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        agross@kernel.org, andersson@kernel.org,
        yung-chuan.liao@linux.intel.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 09/26] soundwire: qcom: add proper error paths in qcom_swrm_startup()
Date:   Fri, 16 Jun 2023 06:26:06 -0400
Message-Id: <20230616102625.673454-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102625.673454-1-sashal@kernel.org>
References: <20230616102625.673454-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.34
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 21c50972047f5..b2eb3090f4b46 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1090,8 +1090,10 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
 	}
 
 	sruntime = sdw_alloc_stream(dai->name);
-	if (!sruntime)
-		return -ENOMEM;
+	if (!sruntime) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
 
 	ctrl->sruntime[dai->id] = sruntime;
 
@@ -1101,12 +1103,19 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
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

