Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D0B5EC649
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbiI0Oem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiI0OdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:33:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83015DB960
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:33:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id cc5so15313464wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XrpGuF2vxbaEuk6VfKG2/A6XesW21KLMiogPr2+Ux0s=;
        b=HYMVagpkuZ4iwK7gYaWt6I09PBdgmc0cg3H3T00viug84DQSekcZ4lHE6K5sDigMWG
         8X5AZbpmvsqH7FUf7sZL8wF77LMaX1eHJV1Caqy529BPli6cRU1l70kF+TKg1WzVDHMl
         LyoIBraFm7QBXXNDvSyCS70tfZkroai2Y8+zih/UBMdxzZT7ERNXvMUF1zAr1zhiBJ1f
         bvIXiAT475TSYrYOuDi7AAhggayAG1u+c4aLNONEeQ1yJoYuSgIb3o9Q+dvMt5VGT+3e
         rsjskeRNesLJHEF6JwKGyJkTfXCE2VBqnrxA3SOCzdGf2l46zxz6bi9KqiQNqIEvvyXu
         MjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XrpGuF2vxbaEuk6VfKG2/A6XesW21KLMiogPr2+Ux0s=;
        b=ufbdQYRcfwAOLVkZsoxb/tpqTUxkJkw+cZsIem/eqUx1dW841o1blG1MMZYohTd4dc
         mYOU6tlatHQUWRI7M/SDoi89MXW3uE6LZTnEs3uFXRPuZXKY43hlHXUxGK9f7QdHlUg9
         dOCqb0961Dv5KVya11AZfUzLAWmMjnSQoBnipm44k48+tW/R7WtHPol7jqK6VZ32j2ar
         D3zZENxJjUhgQRHoK2u6b4qhbiNof0J9mJbJKsTIRpds4Vo0s/eP8PJb66hlyrMZU6CW
         pFvIkySXj4HkPXauOfwF5tlve4ELFGaaiRJV8b4//0oslgJVo9V0q9KLl0VryW4NJfvS
         c/pw==
X-Gm-Message-State: ACrzQf1aYY4pZoz3u02abUVbttb1zPd0sJPQ9mzVzAJnPERvGAfFPUza
        QZ4wWY6UC+CVFjfxschM0X5wGg==
X-Google-Smtp-Source: AMsMyM4CAFZP57R8XEA7yg4spePw1uV+D0tYMzJ9FsIDee7DlSWMc9AH8FsWeB/aAQCacOdHX24jGw==
X-Received: by 2002:a05:6000:16c5:b0:22c:bdbd:e06b with SMTP id h5-20020a05600016c500b0022cbdbde06bmr2468842wrf.53.1664289192505;
        Tue, 27 Sep 2022 07:33:12 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:33:12 -0700 (PDT)
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
Subject: [PATCH v6 15/29] thermal/drivers/rcar_gen3: Use the generic function to get the number of trips
Date:   Tue, 27 Sep 2022 16:32:25 +0200
Message-Id: <20220927143239.376737-16-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927143239.376737-1-daniel.lezcano@linaro.org>
References: <20220927143239.376737-1-daniel.lezcano@linaro.org>
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

