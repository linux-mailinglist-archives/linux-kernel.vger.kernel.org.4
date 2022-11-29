Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E0263B675
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 01:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiK2ARH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 19:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbiK2AQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 19:16:59 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C042B19F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 16:16:58 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z3so8936485iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 16:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gA7jpYl6yV6P4juXicdMOmof7r1j/N5hUrukqrPzGdk=;
        b=DQs1Hqu73bNAJW0k4CHMP/GFzfmwIUvzkUhQZaJ16ASZJ+TVA84Uz1ZP4lfZD1yEpm
         KGFsQvcP4ne79puTyiCDAu2YusMevht3J9nQCgk5pWCogA/prSxN+g1dt8YrLpRHll0O
         8D3SjMY5yHIP9U9huqa3c15zkiE1NJbD9ihwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gA7jpYl6yV6P4juXicdMOmof7r1j/N5hUrukqrPzGdk=;
        b=ld3q57NsvX8O2rIDnXTvbL6z5n6jFkfxOKb+8AOSuGrchhYS9A2rWEkj78hiy36xip
         a5VIIZ41jamAuJXc7j4+huxjCrvoKltM05Oo6jMbcNlbh+oMCbJ9hhHTJPfpPSBdX1dA
         Vk4sLYOqA7RatO1egvxbMJ+JxGHFysBcWY086pHtS3TW/p6QwpZ20NtmYnW83aHbNoK/
         RDax27fNgsWTnkU3MDP863Yn0LXZUn5wlV82XhZCo/GsFjXKQkrAfJF0zPQIi62x2T7F
         g/YexhnTCeRPi4g+8vZ68uLio0Vc+C46gb6Cw+zRWFjFOiTn4PRP7G1QyBh2+X2hcoyH
         6qYg==
X-Gm-Message-State: ANoB5pmiHSp4QkzVD6Ud2BYdycyo1F+elWoJvVlSixiD0Mqe5hSX0Vrv
        RScH0yVZqcHotltMwghzv3WITWdSfTiF8g==
X-Google-Smtp-Source: AA0mqf5O/zpf9bI5X01LNRcc5En7D9DRQc+o4PEsnb6Zkk3bOUWAm6FvBfwZDdw+4jQexdhSlJqa/Q==
X-Received: by 2002:a05:6638:535:b0:375:b7f:daec with SMTP id j21-20020a056638053500b003750b7fdaecmr6888722jar.154.1669681017666;
        Mon, 28 Nov 2022 16:16:57 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id m12-20020a02a14c000000b003636cb862d0sm4884318jah.42.2022.11.28.16.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 16:16:57 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        alsa-devel@alsa-project.org, Judy Hsiao <judyhsiao@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Banajit Goswami <bgoswami@codeaurora.org>
Subject: [PATCH v2] ASoC: qcom: lpass-sc7180: Delete redundant error log from _resume()
Date:   Tue, 29 Nov 2022 00:16:54 +0000
Message-Id: <20221129001633.v2.1.I8d1993f41f0da1eac0ecba321678ac489f9c0b9b@changeid>
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

sc7180_lpass_dev_resume() logs an error if clk_bulk_prepare_enable()
fails. The clock framework already generates error logs if anything
goes wrong, so the logging in _resume() is redundant, drop it.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- removed the log in the error path (requested by Doug)
- updated subject (was "ASoC: qcom: lpass-sc7180: Return 0 instead
  of 'ret' at the end of _resume()") and commit message

 sound/soc/qcom/lpass-sc7180.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
index 6ad1c5b5f2de..db3be15cf14c 100644
--- a/sound/soc/qcom/lpass-sc7180.c
+++ b/sound/soc/qcom/lpass-sc7180.c
@@ -162,15 +162,9 @@ static int sc7180_lpass_exit(struct platform_device *pdev)
 
 static int sc7180_lpass_dev_resume(struct device *dev)
 {
-	int ret = 0;
 	struct lpass_data *drvdata = dev_get_drvdata(dev);
 
-	ret = clk_bulk_prepare_enable(drvdata->num_clks, drvdata->clks);
-	if (ret) {
-		dev_err(dev, "sc7180 clk prepare and enable failed\n");
-		return ret;
-	}
-	return ret;
+	return clk_bulk_prepare_enable(drvdata->num_clks, drvdata->clks);
 }
 
 static int sc7180_lpass_dev_suspend(struct device *dev)
-- 
2.38.1.584.g0f3c55d4c2-goog

