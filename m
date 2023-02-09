Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BC769099C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjBINN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBINNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:13:52 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF27A35252
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:13:50 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id u10so1396004wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPXVzG5o2X54MLB3ZyDSI4pawnltFzWU5Saextq817o=;
        b=ULYJnwqNMeRiea9IJdFP6yvfpxaRwkju4sp2HMcBIO6UHM0rdl40OPLuvrjmSSH4OQ
         fpScO6nXREnk/uZlVm+PA0saUgUMEmCFnW5NCC9kCeEAOKtmcNsrx7ogiJ6TB335qgHA
         CldrEYHwLgk7qatZ91j1dre1BD6oBWD0L9U/KbLV3gEdL58WEI6i5db+AgDPJOe6pxVK
         rQQoGLiXpE/k3cYKnVBMHn4E9BWxgeSkl1ny+vpFIAqEa6Vsypkb77sMWf551sHbIURF
         KB0pIBFLrVjTUtsMuN76ljfwuGHip+Xb5xVwWvy+MARzu1zprHOqFyTiW2V25COrRGcI
         +Ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPXVzG5o2X54MLB3ZyDSI4pawnltFzWU5Saextq817o=;
        b=evgBq5pvpwOU5xUUvt3rpJPZhlcZNMWbTAvt/9k2O2ZMgkC87quFrmkl9TKEc+8fKa
         gZq3vkuGJCYw7FJdhP2RAf4bE6GStCqt2rpP47V3jNe2/cp4m/dbJp52sKetI6U+za4z
         L8D+40QjDTDLW/fWKoTEHnUSpCKVCHvkqxa5SwuE4iVr7BiCGSFhi1ueuGuFOfJMnubC
         hb4V2DST8Y9xuamhd8DjLeTXLyWLu/wt02NKRoSaOZU3NCczAcc3UtvxZ0yr8Q/knh2y
         UK7YyHgumRlni4oa5TGNNQCB+0Bu2I0WYi7yAf3FLdWQQsEs28DUw1O68Bs3/gO5T4C8
         Lw7A==
X-Gm-Message-State: AO0yUKVo4ajzz6WTbYsTns7f86RKM5O2aSFbw4HvLyVUw0EET6hSrHBx
        9pQecFGOMPis9OGzLx4clbfdFA==
X-Google-Smtp-Source: AK7set9KVelqkabFmlPe2AeCDVnSLTivPIjdspWLcsVhNmF8H4NdG9Vd9VAvODpDmSKyXrZx8cstZw==
X-Received: by 2002:a05:600c:a293:b0:3dc:59e9:9285 with SMTP id hu19-20020a05600ca29300b003dc59e99285mr11100382wmb.18.1675948429591;
        Thu, 09 Feb 2023 05:13:49 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ja13-20020a05600c556d00b003dc4b4dea31sm1789394wmb.27.2023.02.09.05.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 05:13:48 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        johan+linaro@kernel.org, quic_bjorande@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/5] soundwire: qcom: enable runtime pm before controller is registered
Date:   Thu,  9 Feb 2023 13:13:33 +0000
Message-Id: <20230209131336.18252-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230209131336.18252-1-srinivas.kandagatla@linaro.org>
References: <20230209131336.18252-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Registering controller even before pm runtime is enabled will result
in pm runtime underflow warnings. Fix this by properly moving
the runtime pm enable before registering controller.

Fixes: 74e79da9fd46 ("soundwire: qcom: add runtime pm support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 9d8ae77bad0a..b2363839624c 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1417,6 +1417,12 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 		}
 	}
 
+	pm_runtime_set_autosuspend_delay(dev, 3000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	ret = sdw_bus_master_add(&ctrl->bus, dev, dev->fwnode);
 	if (ret) {
 		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
@@ -1435,12 +1441,6 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 		 (ctrl->version >> 24) & 0xff, (ctrl->version >> 16) & 0xff,
 		 ctrl->version & 0xffff);
 
-	pm_runtime_set_autosuspend_delay(dev, 3000);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-
 	/* Clk stop is not supported on WSA Soundwire masters */
 	if (ctrl->version <= 0x01030000) {
 		ctrl->clock_stop_not_supported = true;
-- 
2.21.0

