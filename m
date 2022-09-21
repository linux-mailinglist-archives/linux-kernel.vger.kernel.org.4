Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EB75BFB82
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiIUJpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiIUJns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:43:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265DC92F5D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z6so8963065wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XrpGuF2vxbaEuk6VfKG2/A6XesW21KLMiogPr2+Ux0s=;
        b=CvbqxYvWLlH7YwxqIy9n50Zj/oeha4OoIrdgPE+mNnkr2pyBlbcU0Gy/jZyRcG0eXU
         40bTphoOn+/9vXysdosPiaUP15+f9sUP+LoZU9m/A/n80k8RqH+TtuxmABLSXn9WW3H8
         ZPxSTcerUs7ARkfxB94bQjwMiGh3//FRKJX8+W7wBlGxOd0fFVXr9l9abz0LLJxKCzM7
         jRLxhjprQrmOx+tNOXFFGvWFCd+qd9bnjkKz96pqS1pWiXHksU9h5hVCGcwbvY579CPV
         S9yIrjITEYMZkc+abBngKsmWc//iVcciMhiMbRmAXlE3GGiMQmkflpOrgOURUPLf+PLe
         WQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XrpGuF2vxbaEuk6VfKG2/A6XesW21KLMiogPr2+Ux0s=;
        b=q/tmjhuZ0wcSxnaL6EOGTl5RH8+JdhG/k12HG1hEaZBObK8KSEShtDyup0s+opmrwr
         IUF6Thg3CoAhn+DoXX1NSrEbi2tvSy7denAMGtv+olFRjK+tWK4g6mzPqALS/2iZ8b/9
         lhiEAl7us0O3Ro4n8Eua/D6n2tr1ydEwT8BBqACJPqPBVX9Ts9yovmHkR7DhwPTVAght
         EZV0BYblmIYJhI6gRpKG6HUxf5mC0WOiWa1+Cpw7N1UetqaWS6uRiTrDxmMpUlsEAP1f
         OZ5E6Fzj2HzwulYqLZ/u7jSmeHf39MCP43P00aR9FDjd6oeylTGhCaqO1JYDjyg7ohW0
         pDxA==
X-Gm-Message-State: ACrzQf0WjikJGz614nwanmdgEMDZSutFXerWdvj4n4jTo26xijPULRjQ
        NwIQiuG5DsAQ8pH/n1urB43dwQEff3MCng==
X-Google-Smtp-Source: AMsMyM6htcl1h2Rv2GIsHgmCdaubTQZpA3Zj9T7e3kQIg7c5nWcyGFLMOLz0reJ9UaOzgwNvj/z1+Q==
X-Received: by 2002:adf:f408:0:b0:228:d6f6:3bb9 with SMTP id g8-20020adff408000000b00228d6f63bb9mr16680389wro.398.1663753425574;
        Wed, 21 Sep 2022 02:43:45 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:45 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Amit Kucheria <amitk@kernel.org>,
        linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR THERMAL
        DRIVERS)
Subject: [PATCH v4 16/30] thermal/drivers/rcar_gen3: Use the generic function to get the number of trips
Date:   Wed, 21 Sep 2022 11:42:29 +0200
Message-Id: <20220921094244.606948-17-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921094244.606948-1-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The thermal core framework allows to get the number of thermal trips,
use it instead of visiting the thermal core structure internals.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 4c1c6f89aa2f..4ef927437842 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -529,7 +529,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		if (ret)
 			goto error_unregister;
 
-		ret = of_thermal_get_ntrips(tsc->zone);
+		ret = thermal_zone_get_num_trips(tsc->zone);
 		if (ret < 0)
 			goto error_unregister;
 
-- 
2.34.1

