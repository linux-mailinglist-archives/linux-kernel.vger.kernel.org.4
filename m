Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3CB5B9B67
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIOM41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiIOM4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:56:23 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37789C1C0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:56:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b5so30718765wrr.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lGIzKCCzT9Z91pOhcVsZGKjotZcXBUNtgUUXIg8kGbo=;
        b=VuXecdGbo5H0WHk/RI9HLQXwwK1vUUhREBkhtGiX3Jl6fOuDuNBLg6iChSdEnTkLg0
         wpN4E6AlnnbShqjmEJdh3MuUsz3tYbi2QZHlhulQ+ulv40Y1oVEwYV5sqhHXq83Zi9zs
         V1ApSMiZTdrs7OAvZulaHbZGim0JP/oa9n795R1sQqHTBjb+jr08YiccC0bYxz3frWRH
         ClWncZXoh2F31AWcO/Q5BNvvBa1XeJPyZbnBdZp/KrUWTEPxwtt6AiH14ZHPEKc/naqC
         qAQqbQlhyHOaRUO13xSqkNIh4XQVkO1UG9mMEU2Bb49H2OU3RFOzSntKCXXlF6OjOLBa
         sCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lGIzKCCzT9Z91pOhcVsZGKjotZcXBUNtgUUXIg8kGbo=;
        b=go3HKevfaWCkmkF8RXEFRVIsqYTI7opoXJ+68IWTl3acN8nS75AepfvTl5bjW8xW2b
         s2W/mryE0AeOnsDpErkJe46kLJcqUfNoWxkb3JpMCrLw+U9a8APHCl5k8lLZSuNWAZBj
         KYCR0ypk2LJTJv1xa8qM0I/28lb3dT0lgNEQIjHD3UoFIazFLrxVyGDrPn0joyL+p0bU
         ScPN1xzEPlUfZ42ktKVPqM71kRObEp/STrUfkGh4JKC+qxxuZT5ctgy4pTritE9Lszhs
         5nmvY3Gf8T7TkQZqssWKh++tTMTPTKEc/hG6SPbNN/jgPpv8gwe5mxVbmxodWcUAro7C
         4Hcw==
X-Gm-Message-State: ACgBeo2B0HOXo34fOuRp5RBJti4NIe3ZdIV5AAS+/f567P/1Vbz8NLzG
        xzP+Mz9pQakyqkhHjyv228Jt0Q==
X-Google-Smtp-Source: AA6agR5NfkgxbpXSZo002+Ikyd38sNhGJGQI6H3P46uFW0Rvglr5n1hmYSs9SZy7Ecb4Ie0qv80k7A==
X-Received: by 2002:adf:fa83:0:b0:205:c0cb:33c6 with SMTP id h3-20020adffa83000000b00205c0cb33c6mr25811807wrr.39.1663246580396;
        Thu, 15 Sep 2022 05:56:20 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c510b00b003a845621c5bsm2764776wms.34.2022.09.15.05.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:56:18 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/4] ASoC: qcom: common: use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
Date:   Thu, 15 Sep 2022 13:56:08 +0100
Message-Id: <20220915125611.22473-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220915125611.22473-1-srinivas.kandagatla@linaro.org>
References: <20220915125611.22473-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcom_snd_parse_of depends on ASoC EXPORT_SYMBOL_GPL functions,
so make qcom_snd_parse_of and EXPORT_SYMBOL_GPL.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index c407684ce1a2..e53ad84f8ff5 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -175,6 +175,6 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 	of_node_put(np);
 	return ret;
 }
-EXPORT_SYMBOL(qcom_snd_parse_of);
+EXPORT_SYMBOL_GPL(qcom_snd_parse_of);
 
 MODULE_LICENSE("GPL v2");
-- 
2.21.0

