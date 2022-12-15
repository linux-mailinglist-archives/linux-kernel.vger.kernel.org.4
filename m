Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D335364DC6B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLONnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLONno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:43:44 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0051D0E5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:43:44 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id cf42so15748179lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yeSaGzMo9vtSSNNjXtnr+AVO8TROQTWJ8g1sUJShZO4=;
        b=aIuBTe8rz7xw0KbrovzoVxh17WBpMVMqERmnZVQFKxaz5P8H1OGCEWFFBzXsKz0mwu
         3VXTGdgsnD1bSUVBBe/vkXlSDPfqoZxLiOGE/dtlstvnq+8OO7UwqWFskifYCqSQJwtF
         U8OGW8fZ676WBGpLcQRU4LDzqGJmonX18qA0kU7cAvUN9GFswHoB6iEZ0Ae1cJbpYZD0
         VbhyDYoVPPkHJnRsxs+0AydHZQzIW00s8BzEHEzYfTTAXd/flW6K6sdviZh6QbxSBjaE
         kQyAkEDnEg3DlZ6px/ntdo6/2gdkf0OU36HVmxNyyWYjv+rW5gfZseLLlqIP+hrWXWoJ
         PVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeSaGzMo9vtSSNNjXtnr+AVO8TROQTWJ8g1sUJShZO4=;
        b=IUlzaVKipx1WgRtGhbN/OvmeUHf3N7cMwHfXyIe/dzuKhTXGRomAJJ0ue3+y7CIBz2
         Q8KzLJfBcr3NGkWNoqhhqnu3a8mPI9yE3BTaox8IOkUlFl32enaqwvy+zmbMbfi7cn4t
         qMJiIhzmUCPGEPV3iJOOtoZzWtKxmNzPAG5kuptxO2zJOCc9ZIb/2c7TciY/AsKNREvW
         gQCOAe8B1qjm1raYOCDm4YcGp4TRLv+UQYhE6mRNkCZEi9FspFvwbb69/mF3m7dKuabQ
         r5hNbs7rgYm1lR+vY+e+dIz7kzkYAhNOvyldHxc9W+ZZYMCZROiIYIpOG4n6q3OzUmNn
         46TA==
X-Gm-Message-State: ANoB5pkqV24ZA/8xykT5VUUqWre1tamCGkKUaMh8h65lDLdZPJRU73kd
        GQ8a4c12HBxCCeha0JfpU3w3oA==
X-Google-Smtp-Source: AA0mqf7XiQTneVhAoC3rYevXT3PQNA7YtPR5evRnvv6wCZaDFVihXgUcICGydnrWBXnWeLVaKoNsig==
X-Received: by 2002:a05:6512:b8e:b0:4b5:a5c7:3286 with SMTP id b14-20020a0565120b8e00b004b5a5c73286mr11792153lfv.9.1671111822368;
        Thu, 15 Dec 2022 05:43:42 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q21-20020a056512211500b0048aee825e2esm1161826lfr.282.2022.12.15.05.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 05:43:41 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: lochnagar: Fix unused lochnagar_of_match warning
Date:   Thu, 15 Dec 2022 14:43:37 +0100
Message-Id: <20221215134337.77944-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lochnagar_of_match is used unconditionally, so COMPILE_TEST builds
without OF warn:

  sound/soc/codecs/lochnagar-sc.c:247:34: error: ‘lochnagar_of_match’ defined but not used [-Werror=unused-const-variable=]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/lochnagar-sc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lochnagar-sc.c b/sound/soc/codecs/lochnagar-sc.c
index 13fbd8830b09..5e0bd0d24ed3 100644
--- a/sound/soc/codecs/lochnagar-sc.c
+++ b/sound/soc/codecs/lochnagar-sc.c
@@ -253,7 +253,7 @@ MODULE_DEVICE_TABLE(of, lochnagar_of_match);
 static struct platform_driver lochnagar_sc_codec_driver = {
 	.driver = {
 		.name = "lochnagar-soundcard",
-		.of_match_table = of_match_ptr(lochnagar_of_match),
+		.of_match_table = lochnagar_of_match,
 	},
 
 	.probe = lochnagar_sc_probe,
-- 
2.34.1

