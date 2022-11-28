Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7FB63B4A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbiK1WMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbiK1WL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:11:59 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2D130F46
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:11:58 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id o13so5735768ilc.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+K0jgOSLksPF0t4oO6z2n4LjWuWuN8YIQgfQeuzMRF0=;
        b=Aq1EGgv7Yfv518jIs78L4d+GGgWaxs8TyWPdQf0qndrhr8yITjDwgaLKNfQFqQXrZx
         nnPeeSK6X5QcqXNK373SSmHPhq1+zsmZHL9YGSNNtsNpYs5i0Xdpw3alKtVy+Px1De0P
         ZFCNwvc5caUtGJSl+ljr6Hew1e4WTUMRKAaFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+K0jgOSLksPF0t4oO6z2n4LjWuWuN8YIQgfQeuzMRF0=;
        b=ws15KKznjlhF8m5gBVrV7cFtF6qdFHfqs7vGXp4Ru3OtChFnfrGrnJfk/vcdZvW4zc
         LBipq/Ctz0P0kcQ0yuiFtVdv+hD9kO92IfoNojKJieF06iuOoevmb0VYVtGc1bq4xZrf
         6gipFKk26XQMpFntCIFNthRaXtlD+96crbr0JGfi7zmJJffDTN7IurhhMwQtOO+ANntk
         vV1/qjAuTcCMNeO9zKjKMLdCyxZqvf8DCAfMbmZXsJc6Sm23Y26R+Q3kLZq4yHQSAPG/
         3snQr/IigdQjiIlls+OEit6xjsaN+zvXTY54sWKifnsVbOLDaEx5GGeacrFdIK1alMcC
         wzbg==
X-Gm-Message-State: ANoB5pleu1I2BGk+9GVaIq/lqZ1GLe1DbmePK+rRKJF0GLUtxE/L5Zge
        9QX0MRq0jT0gcyqDbdDnserldgobG4qI7g==
X-Google-Smtp-Source: AA0mqf6Fo8Uf5/CsFnfNGuV1ojrI2ZNykhxAz1ZxrUuYeIfuTr1RKHtapDjLrNo7xXOLi496j/GAgw==
X-Received: by 2002:a05:6e02:dc1:b0:302:ecb2:179b with SMTP id l1-20020a056e020dc100b00302ecb2179bmr10840765ilj.223.1669673518004;
        Mon, 28 Nov 2022 14:11:58 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id i14-20020a056e02054e00b003030e36d9bfsm1480355ils.46.2022.11.28.14.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 14:11:57 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org,
        Douglas Anderson <dianders@chromium.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] ASoC: qcom: lpass-sc7180: Drop unnecessary initialization in _resume()
Date:   Mon, 28 Nov 2022 22:11:54 +0000
Message-Id: <20221128221152.1.Ia805c688ee968fbbec7b93dc10742876fdef8024@changeid>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initialization of the variable 'ret' in sc7180_lpass_dev_resume()
is unnecessary, as it is always assigned a few lines below. Drop the
initialization.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 sound/soc/qcom/lpass-sc7180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
index 9c3365ddc274..7a81e609727c 100644
--- a/sound/soc/qcom/lpass-sc7180.c
+++ b/sound/soc/qcom/lpass-sc7180.c
@@ -165,7 +165,7 @@ static int sc7180_lpass_exit(struct platform_device *pdev)
 
 static int sc7180_lpass_dev_resume(struct device *dev)
 {
-	int ret = 0;
+	int ret;
 	struct lpass_data *drvdata = dev_get_drvdata(dev);
 
 	ret = clk_bulk_prepare_enable(drvdata->num_clks, drvdata->clks);
-- 
2.38.1.584.g0f3c55d4c2-goog

