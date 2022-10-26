Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC8A60DF2D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiJZLCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiJZLC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:02:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85688B5FED
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:02:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r6-20020a1c4406000000b003cf4d389c41so232092wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qO/JbNRzACWJ+/BPqzyo1ybZ7r6Vd9pEOf9FoOyjmc=;
        b=RWGT62z0OrUByMt9GrSpD27EAROj86fo8TCkjjtRrXYNZ6HPIPQ5r5t5vpxfZQi0hd
         QoBX2qHvro7m4+uOucRRcVawjJZD8M+NXwqHESqMKuVmPmFN0EEJpFUOxhi1Tv0NCQvq
         5oSkrVszv1SKhJb5bc/UmpozOVeaCe01pKmr0hMCFKF5at8bs0Knx/L0vEg055RsahMi
         5wgwPKOvh22s18cE2oZvGjSg0h3z1hhDKNPe22z3CxTt/ntFrf2/3Q0Ltzl2YLpErooj
         3tdAEwQyKaSdYqfroQEnF+6gxG0O9YEFrAL35sjVpftNC6WinLATzAZHFZ5sNgad9J+r
         /Dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qO/JbNRzACWJ+/BPqzyo1ybZ7r6Vd9pEOf9FoOyjmc=;
        b=pkBpvZM3/u4ExeDZ1oxxthvuBtjIuLW7toyFjZgQkCg6kCBB0+E6/f3VA04z+URQeO
         bgOTR5FJvLIr0Y7ULq33dl/2IFVL9i2MZB+ywNSbZkyGIDLV8NHn+q8UeuUW/BfI8Nm3
         n9j9uG4yDYxsHIYLsesRJVAvZl6Vlrvnvrj2kGo3QCUbSyzRUT4OQ3yMpY1498+KDQJC
         0rnDboF4CbNx4sIJmbHq9sEBu+/sQ/FhjCvqXJdKxwLwxl+u3M5lZ18QCbqI/U/vR5sI
         exhGXcWVKvbTIcMOk7CH0okmdfYr/2um8qsVol4GHWmrB5VrJJorof2nWRrYRdyDJNP4
         HzpQ==
X-Gm-Message-State: ACrzQf2ivuZF0VxKdPXABSar/yKsMcYr4lBv1t5n4jTJpMODGDzu8wg9
        I92IyWVq3pfHFEzs+Fadtd78SQ==
X-Google-Smtp-Source: AMsMyM7mBIWMKyJj6QToByEpy/WDyizCwqeWxSIBwY9ABO0T5YGw9F9xu21lVTuRnTh2c2ivzL82Bg==
X-Received: by 2002:a7b:cc15:0:b0:3b4:ca90:970d with SMTP id f21-20020a7bcc15000000b003b4ca90970dmr2043088wmh.198.1666782147100;
        Wed, 26 Oct 2022 04:02:27 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d44c7000000b0023672104c24sm5237415wrr.74.2022.10.26.04.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 04:02:26 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 4/6] soundwire: qcom: make reset optional for v1.6 controller
Date:   Wed, 26 Oct 2022 12:02:08 +0100
Message-Id: <20221026110210.6575-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20221026110210.6575-1-srinivas.kandagatla@linaro.org>
References: <20221026110210.6575-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Some Qualcomm SOCs like sc8280xp which uses v1.6 soundwire controller
reset is not mandatory, so make this an optional one.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 7bc8cd0e906b..54d370f4b291 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1330,8 +1330,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	}
 
 	if (data->sw_clk_gate_required) {
-		ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, "swr_audio_cgcr");
-		if (IS_ERR_OR_NULL(ctrl->audio_cgcr)) {
+		ctrl->audio_cgcr = devm_reset_control_get_optional_exclusive(dev, "swr_audio_cgcr");
+		if (IS_ERR(ctrl->audio_cgcr)) {
 			dev_err(dev, "Failed to get cgcr reset ctrl required for SW gating\n");
 			ret = PTR_ERR(ctrl->audio_cgcr);
 			goto err_init;
-- 
2.21.0

