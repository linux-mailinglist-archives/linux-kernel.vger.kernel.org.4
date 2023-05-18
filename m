Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12749707AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjERH2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjERH2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:28:25 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3D22D55
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96f0678de80so292210766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684394890; x=1686986890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVXk2J0zDtxw+0Qou5QUMtzlXSrHNQ48trwuAxglr6Q=;
        b=SY4zlhD/Ae3NqKWMgCYMmnInKUuz8aaW8w1LrZj140mUYU5ssSsPDI2EaABgQV9yap
         Ernl5l+MQeuF813vs5dgtI3WN3/XEiNudVVFA0hkaEZ04MQ1bZCxFSWxvUdn6kImX9+V
         IgVBEGaTPpfiGrTgAqGxD32MVO3InaXImAWE2u9wbz7HoXqOsm+0equhQfc5EpKrAtEO
         stmHcBuSxYTR4GnFSv0T6INTHLSjpLcWbXQOs/KvYprUoPnIioiimgAKeyhBOhy+brFc
         tR0btKWih37xTmEtBAEVCjy5nGMy4zD622zLbnzNYpyK4K6T85rxfEQtxaaLr7X45K6F
         9nGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684394890; x=1686986890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVXk2J0zDtxw+0Qou5QUMtzlXSrHNQ48trwuAxglr6Q=;
        b=Rhe/6vI2sEsTum8W/KyI4SB4/ITbEqP7ks2nHhONax+6GVT/jaMFXSjh4Zq14Jc11q
         /++A9as9AsdZsBAUYT+jm7AeUzKY/7IXDk/LOv53FQsw+VdcLucrB5AEZ1Neb7qUK/A5
         lACszwa8/VmEJgeuQm933IW/hDhJtU+jO6jkbf9OJok+ha0NJ86ykWwQQq9EiHGp7T6Y
         P+BQJFPJWnFevD5PvtUPhUcjZRv9CQb3YHw+pr7rwqBRBbJoEEgf59PTHSNgLUmyiTCQ
         Kz2cqYYdxIBJd4XmPXEz6fLKLIl6rfTvpvT0FMjII1Lu5AqV7DByqL4Gm5EuA4alBKBf
         lqAw==
X-Gm-Message-State: AC+VfDx2M5Kvu5NLjmE7ONHEy4E6OJ87kBnf3WtbWHEVcG9Xpn8X3DSi
        QIrt/sgz/DXrBVPQ1mEHHhkaNDJnOKqpyTGGF9epHw==
X-Google-Smtp-Source: ACHHUZ641f7zdyr1VGHoaOYeHSFCkkKsFuebd6A4/URfBSRepYIOCVjPIppyj2S59eXBj/0kOl+6sw==
X-Received: by 2002:a17:907:80e:b0:94e:9a73:1637 with SMTP id wv14-20020a170907080e00b0094e9a731637mr36831708ejb.75.1684394889884;
        Thu, 18 May 2023 00:28:09 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090669d100b00965aee5be9asm594241ejs.170.2023.05.18.00.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 00:28:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RESEND PATCH 11/12] ASoC: codecs: rt715: do not store status in state container
Date:   Thu, 18 May 2023 09:27:52 +0200
Message-Id: <20230518072753.7361-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518072753.7361-1-krzysztof.kozlowski@linaro.org>
References: <20230518072753.7361-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver in its update status callback stores Soundwire device status in
state container but it never uses it later.  Simplify the code a bit.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt715-sdw.c | 4 +---
 sound/soc/codecs/rt715.h     | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
index 5ffe9a00dfd8..6db87442b783 100644
--- a/sound/soc/codecs/rt715-sdw.c
+++ b/sound/soc/codecs/rt715-sdw.c
@@ -417,13 +417,11 @@ static int rt715_update_status(struct sdw_slave *slave,
 {
 	struct rt715_priv *rt715 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt715->status = status;
 	/*
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt715->hw_init || rt715->status != SDW_SLAVE_ATTACHED)
+	if (rt715->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt715.h b/sound/soc/codecs/rt715.h
index 17a8d041c1c3..12a0ae656d09 100644
--- a/sound/soc/codecs/rt715.h
+++ b/sound/soc/codecs/rt715.h
@@ -18,7 +18,6 @@ struct rt715_priv {
 	int dbg_nid;
 	int dbg_vid;
 	int dbg_payload;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

