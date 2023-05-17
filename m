Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEAC70665A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjEQLPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjEQLOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:14:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886FE59FA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-965ac4dd11bso112376666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684322081; x=1686914081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=if7YQ3Jqyx8UU5QrJc7rocl2hzsm+T3skIrYgPJcbZ8=;
        b=ZZNYO7TcWQf/4w4gaLWDpyEDeka0OZxVnDIc5sRFsbyL/9iZbbCbx8vZeGO60WRFhB
         YLphCf2UBV/33sliiaI7pZOZcIbc4EdrzIGyc1D2yJtr5YqERyrQU6BHQw7geeHsJMgi
         A+7VlGTrw60J1oVPDJM1snYMD83sN+QavQAzljMoYOar3YRW+z75gZmjxEhfoGggEpyk
         iRtTJBOWA3sqG0ZOyMgr1A9JmnQySodh9VbOmIl2ePjKQol4vaxxWXB2+jg+lFNtGEpC
         P0iYa3Fh1tOvll/kwkHI+dcf6CvViL7HlLsqo05a+Pd7MhA4g2mCWbXJlRTm80zUD3yL
         zezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322081; x=1686914081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=if7YQ3Jqyx8UU5QrJc7rocl2hzsm+T3skIrYgPJcbZ8=;
        b=VR26/+onVy0uVKXgSuKd0PguzASaOvV5IutFcBCqdA+tTPKfI8WBFxCuqz9KkzVo1+
         1TMpm7+o7hu5tlG5i1D/kiwqEFBMvq7YqJlAm4EFEm/knp0LrtlAzWnczTZxoauEVmWu
         bb3fjwTEYY8xLs2O2KAayJ18sRMsLDqJCiSgHPmd0O5wqGrPnjGyJUjW8CMIogSK/ock
         66iXbtjN+kd++wrJEj9SjSJ1ZInR+SoL/ljwoyAXdYD6flR5wbDmR9EzXGGwaes8AZu/
         8atAAjQlIDVMkqwB2ea22IH3G1fd0ufd9Ek8IchwDbaib5/p7D6f2M0MA5Ck+Ke+0v+8
         pxCA==
X-Gm-Message-State: AC+VfDyUUvrsjH7H9lDGCWc8j0yNNugdOvQhiXznN22aSqhHO5bvtAGr
        gADHhe8j+lpElnrs2T26FgVe9w==
X-Google-Smtp-Source: ACHHUZ5y2fv3RY686++601FfyO2aihA2Vrj8kltsyQOYUSLWJ+uJ9GBrL9eipsMCxlpfhVJxYk99QA==
X-Received: by 2002:a17:906:5d11:b0:96f:181b:87da with SMTP id g17-20020a1709065d1100b0096f181b87damr66787ejt.69.1684322081001;
        Wed, 17 May 2023 04:14:41 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id ml18-20020a170906cc1200b0094f124a37c4sm12326880ejb.18.2023.05.17.04.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:14:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 03/12] ASoC: codecs: rt1318: do not store status in state container
Date:   Wed, 17 May 2023 13:14:07 +0200
Message-Id: <20230517111416.424420-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517111416.424420-1-krzysztof.kozlowski@linaro.org>
References: <20230517111416.424420-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver in its update status callback stores Soundwire device status in
state container but it never uses it later.  Simplify the code a bit.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt1318-sdw.c | 5 +----
 sound/soc/codecs/rt1318-sdw.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt1318-sdw.c b/sound/soc/codecs/rt1318-sdw.c
index 795accedc22c..3751d923611c 100644
--- a/sound/soc/codecs/rt1318-sdw.c
+++ b/sound/soc/codecs/rt1318-sdw.c
@@ -456,9 +456,6 @@ static int rt1318_update_status(struct sdw_slave *slave,
 {
 	struct  rt1318_sdw_priv *rt1318 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt1318->status = status;
-
 	if (status == SDW_SLAVE_UNATTACHED)
 		rt1318->hw_init = false;
 
@@ -466,7 +463,7 @@ static int rt1318_update_status(struct sdw_slave *slave,
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt1318->hw_init || rt1318->status != SDW_SLAVE_ATTACHED)
+	if (rt1318->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt1318-sdw.h b/sound/soc/codecs/rt1318-sdw.h
index 85918c184f16..86e83d63a017 100644
--- a/sound/soc/codecs/rt1318-sdw.h
+++ b/sound/soc/codecs/rt1318-sdw.h
@@ -88,7 +88,6 @@ struct rt1318_sdw_priv {
 	struct snd_soc_component *component;
 	struct regmap *regmap;
 	struct sdw_slave *sdw_slave;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

