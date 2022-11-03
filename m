Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1959618912
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiKCTyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiKCTxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:53:49 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D2A1FCE1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:53:48 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id k2so1870787qkk.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 12:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qi/QHriO9WLQrr+WCirZAkAs6AyTOYgHq/qkN2NOeAY=;
        b=cBKnf4Y1p3+pN9MdezNdYjZKCwgXSR88lGmahi0XjLm9TisFhJ7LKE8GC4wJvyUshH
         B0XrcUJEhnrQ7tDMJ3sDi0VpA7PRZSxVQgH52RiiC9hmvSnLsqnAhHtZP/6p/rGqpH7k
         F4fpsTPXvFw9iTIRgx9h1W3tXABfb4iC1zEye4Y/80iYt5D9u12gqAxREHJoFy4SqKqJ
         ZUrUOMP/okpkL7R9b4QIS/cDSm8zQiQDaDRcSzF5yIoYZWlU4blkusbC6amjtKViFBta
         1SRvnix4Ba5TqRcyeHyY1C/5QFcTiQTj0FipNndPvKgXRaIe1RQk11PgEXU0s5a89rrB
         IwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi/QHriO9WLQrr+WCirZAkAs6AyTOYgHq/qkN2NOeAY=;
        b=T82qqYib5qBYCVyAm9sP5/MDKLlaXDenXIAcSDXGgqu86Ivd+JOsA+ILjZpO3D/hgO
         GJFDEnbjEqO36raaAkrZWKznEnxfzmpBJKznbRAiq2QCw0OeJOZ0zbZ+EODbyBfuI84H
         gGEiM4+ZQK7CuObsDAxNEf4Z2/e4GUhuvzBxIYdqtkAkKDJIud/3zXkmFZeYobCYRhpp
         16IijXpFA4mNgo7B6rWzEBNGKAqimHxD/TDBYObVeIvwlmk/6boh1K9kS6yyB8zO2rtE
         33GKOOGeVBDW5ornlzLtgF66Ssmj1g8lF+Z0+9fhtpGK55Y/Tw5r0Hv4BmBtEm+vNQ7+
         v7WQ==
X-Gm-Message-State: ACrzQf2EVyG7CXWPbZpydG5F6tDIFk3ciVC3kyEJyUglPDQyvnRUYupP
        jE5Ga2qAnRHnXtyYM0ZmScrQqg==
X-Google-Smtp-Source: AMsMyM4yhWaJCxNpHi/v3VKOjOMfzR/+GK0OT1VhHzDrako56nPe7wmtV4XL2pkQu6H1U4JIPBpB0Q==
X-Received: by 2002:a05:620a:29cf:b0:6d3:2762:57e5 with SMTP id s15-20020a05620a29cf00b006d3276257e5mr23610520qkp.389.1667505227505;
        Thu, 03 Nov 2022 12:53:47 -0700 (PDT)
Received: from krzk-bin.. ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id de41-20020a05620a372900b006b615cd8c13sm1328892qkb.106.2022.11.03.12.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:53:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ASoC: codecs: wsa-macro: parse clock-output-names
Date:   Thu,  3 Nov 2022 15:53:41 -0400
Message-Id: <20221103195341.174972-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103195341.174972-1-krzysztof.kozlowski@linaro.org>
References: <20221103195341.174972-1-krzysztof.kozlowski@linaro.org>
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

If we have several instances of WSA macro, each one of them should
register clock with unique name, so parse clock-output-names for this.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/lpass-wsa-macro.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 5e0abefe7cce..5cfe96f6e430 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -4,6 +4,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/of_clk.h>
@@ -2350,14 +2351,15 @@ static int wsa_macro_register_mclk_output(struct wsa_macro *wsa)
 {
 	struct device *dev = wsa->dev;
 	const char *parent_clk_name;
-	const char *clk_name = "mclk";
 	struct clk_hw *hw;
 	struct clk_init_data init;
 	int ret;
 
 	parent_clk_name = __clk_get_name(wsa->npl);
 
-	init.name = clk_name;
+	init.name = "mclk";
+	of_property_read_string(dev_of_node(dev), "clock-output-names",
+				&init.name);
 	init.ops = &swclk_gate_ops;
 	init.flags = 0;
 	init.parent_names = &parent_clk_name;
-- 
2.34.1

