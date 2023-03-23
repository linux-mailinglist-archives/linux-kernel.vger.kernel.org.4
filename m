Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD346C6E05
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjCWQp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjCWQpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:45:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78526BDC5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:44:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eh3so89494192edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679589856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4p58Lw+agHASsKfJ6aDJH9J3fw9PY/7V6UBtha5qnBQ=;
        b=mkSLbSGc8DserzlRocfmGovK4CVXM9wFX93zf+RwrfRNWUdp0Aqb3/jH+3ZaNQ99Mu
         5pnqk8ZX63k1t+viVUk0gpVnV4uNs+fEL6HN7KBXrplCxQSWeBe+qV8rUHCuZCVMfaUJ
         UCmEeyBAG8reHjZxRR+Uk1XhfRgn/00G0CNcSpQfjbGGoeNF/kyd5/CbsnC+e7IoKdo6
         8JzuammEipu17QgSECVds5BEVRGVaL0mooaiJqUw+B6oO2CWoShT5kq9DFIZ3jTg1n+2
         1WaNZ7pGrmOJhHD7qg9vPhIorYzlbU8fynb98St6KupzEuMSjsPbYpaE4hzjlEHyIKqq
         OIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679589856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p58Lw+agHASsKfJ6aDJH9J3fw9PY/7V6UBtha5qnBQ=;
        b=sFiTL4XP/AaoXPz0XE2b/S7o7Jp5ITli9zF2Cvb+f9FAUvEp/jXqRvD+B1xjsVhnXE
         wRuvN8jzqhVFHF3ASQAfAEwcuHEPGrOHarif7en9QoTbZKp0KoBloIIG/pe6kM8rCB3Y
         9nDpqUj2MS18+FIehDGW3oLkaYkkw8UXYYQvqHhQsQo1aWVmBip0ALwBsoF2ChTDy8Fl
         6zbhpjaFz2WA28TaA4ZOYLaVXEF9ujuQK7/2NyPUk9NbKjJSoe7Bn1qnuVrKY1ppyq/Y
         yLPgnL986c8YDBFEetZdDtOZUShoxNVSap23R42NDKoCuS8TW98027ovTECsjUQ+LMSJ
         41ng==
X-Gm-Message-State: AO0yUKW/LY+EsTyfCruILu6T0OKRHFsZ8CzVZorLJENxUxBD+2IgseeD
        vLUFoYrJOz/kQfovQM2vvckonw==
X-Google-Smtp-Source: AK7set/1iEUyO0rmlFJ0I7ZZcuxj1Fi1IMkDzUKyo1qAoN5vycDXyk/M6lvLxoh02t6QggEmrhoOiA==
X-Received: by 2002:a17:906:6d4e:b0:8b8:c06e:52d8 with SMTP id a14-20020a1709066d4e00b008b8c06e52d8mr11481150ejt.36.1679589855954;
        Thu, 23 Mar 2023 09:44:15 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id m10-20020a50998a000000b004e48f8df7e2sm9542187edb.72.2023.03.23.09.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 09:44:15 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        johan+linaro@kernel.org, steev@kali.org,
        dmitry.baryshkov@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] ASoC: qcom: sdw: do not restart soundwire ports for every prepare
Date:   Thu, 23 Mar 2023 16:44:01 +0000
Message-Id: <20230323164403.6654-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230323164403.6654-1-srinivas.kandagatla@linaro.org>
References: <20230323164403.6654-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unpreparing/disabling and preparing/reenabling soundwire ports is not required
for every prepare call, this add lots of click and pop noise if we do this in
middle of playback or capture.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sdw.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
index 10249519a39e..1a41419c7eb8 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -32,11 +32,8 @@ int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
 		return 0;
 	}
 
-	if (*stream_prepared) {
-		sdw_disable_stream(sruntime);
-		sdw_deprepare_stream(sruntime);
-		*stream_prepared = false;
-	}
+	if (*stream_prepared)
+		return 0;
 
 	ret = sdw_prepare_stream(sruntime);
 	if (ret)
-- 
2.21.0

