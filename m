Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF90663571
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbjAIXgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237627AbjAIXgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:36:09 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD1AF46
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:36:03 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id g7so9609477qts.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 15:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHdylmQcW9wYYsCa9wwYr0VU2Cu3mjkXydVxqDNSd7s=;
        b=IgpF0zOJNGRyYHPgr14oe84dRF4bZ4IkqF/xVJTwejgGZZo5CdElnmDII9psWkdYdV
         VQgAkixF2ZeGL6DjydEyuZtNHfBmLn5rpdRFaqqVL6z6PTXvZGBtF2fg3LEBWOnKmrnD
         GRdkAhof4yATzA6aIyB0m9QnqDPh8pJZnSPX5VoFJfhoAK6iXoQFA/3N8coGLwXEfWIt
         H1fpOo3VaGy9D6L276k0b/V0maEo+T8b3eyXLn7gmkjhPLokinE0gtFt89rvOcRu/IiB
         JOulRj1Gu0ycfFA24YeJLNK2FoAMGqHZlXEZ5ywgdniFUq3JKfUlvxPa/A1U2rYYCjDJ
         SIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHdylmQcW9wYYsCa9wwYr0VU2Cu3mjkXydVxqDNSd7s=;
        b=NvKRZ7NOUElNvdlgrrCBwK5qhBvXBF/gksiYhSY0rdgmvbM/KbIB4Pxa5nMqgSezn5
         5QiWosorppX5mUgYpg0svscLEHK596V66UCkvfe8EdL/fj0T8qwvyo95Al61BNOAj24V
         5BrYGvW1dmAUhiD79MudXtWqayj885AlYhXze+RnR1s6TrQ0zkCVQXJxX8jJIXmcA761
         L9LEtzHasTa2f3EWYWXPghpPdiarKsKAUDnuhl7aNQKkKKUDu+oJqPwqWo9rVGfcqiv2
         Psin4UOcvtHIAYFqDDdvJfDCKG3LDte+w7TEMZNygefgCTH/ZQbxG1p96Vmh+CNk8k/R
         N5yw==
X-Gm-Message-State: AFqh2kq05I2Vg76ZBBgL6shXo2a7iZoooMuOaRtkB/vDqyYXAi3Cd5/1
        9Z1YhgrY407zC3Czg7I23fGPrA==
X-Google-Smtp-Source: AMrXdXulseYYzs7cQNeCTGbJ59lnFcneJ7Iqd1kaKyqxoO1OhcE8XyTsdvklFinEON7uDw2wkbYhkQ==
X-Received: by 2002:a05:622a:1646:b0:3a7:f6cf:a597 with SMTP id y6-20020a05622a164600b003a7f6cfa597mr120230588qtj.33.1673307362569;
        Mon, 09 Jan 2023 15:36:02 -0800 (PST)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id t5-20020a05620a450500b006fa8299b4d5sm6294846qkp.100.2023.01.09.15.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:36:02 -0800 (PST)
From:   Jonathan Cormier <jcormier@criticallink.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Jonathan Cormier <jcormier@criticallink.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>
Subject: [PATCH v3 5/5] hwmon: ltc2945: Convert division to DIV_ROUND_CLOSEST_ULL
Date:   Mon,  9 Jan 2023 18:35:34 -0500
Message-Id: <20230109233534.1932370-6-jcormier@criticallink.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109233534.1932370-1-jcormier@criticallink.com>
References: <20221214220727.1350784-3-jcormier@criticallink.com>
 <20230109233534.1932370-1-jcormier@criticallink.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert division to DIV_ROUND_CLOSEST_ULL to match code
in same function

Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
---
 drivers/hwmon/ltc2945.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
index 0d743d75459c..5456c1b60b8b 100644
--- a/drivers/hwmon/ltc2945.c
+++ b/drivers/hwmon/ltc2945.c
@@ -203,7 +203,7 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 	case LTC2945_MAX_VIN_THRES_H:
 	case LTC2945_MIN_VIN_THRES_H:
 		/* 25 mV resolution. */
-		val /= 25;
+		val = DIV_ROUND_CLOSEST_ULL(val, 25);
 		break;
 	case LTC2945_ADIN_H:
 	case LTC2945_MAX_ADIN_H:
-- 
2.25.1

