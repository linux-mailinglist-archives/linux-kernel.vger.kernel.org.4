Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063616F5699
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjECKuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjECKuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:50:52 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196D9B1
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:50:49 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f00d41df22so3059472e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 03:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1683111047; x=1685703047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zgj+aUgoJdUUawwjQ6SgSQXM3EvgvrnXKII1glX28tA=;
        b=XnS7NVz8zttO1mmcapsD4f8wA0e8bEV1z3wez08PCINAL3k7C7YTNcSfTyrILcy74r
         Di5jMQfCzg01pGf5tURveH4iEtrBZYukqXzl6fky++6GLhQyYDIPJKX+FXaGzZqQKvCD
         BHFrHpukkujhe/jjDm+9SjwFj0B4ralYu78Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683111047; x=1685703047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zgj+aUgoJdUUawwjQ6SgSQXM3EvgvrnXKII1glX28tA=;
        b=XgqTZARXn3N49orr5c89kKeUex7Z1mwWNnXK5lE6Flw5DnRm0FVeZBERdRWGhRhPHu
         RoJ55JWcrjaRW2vCg24SFqgyaeH9/m/Q6Zek+LkUw+WCCKmsbXte+rHYajlynNsQm8Sz
         7zQED+Ih+sRmAZRKrZV49IyVtAsLmaHUrOP1r8n47s190oxVMwCS+Ogd16uEYFZ0a7pW
         qegzgY3nC+tig3iLdrWwG6kI8d9QsGdEiFhdSF4qpGAq2hx9gzaTfe9EihrEgObcMFBb
         xUVSNdi6je44D2ElegaWYEzj2XbGVdd4pXJ0jTS0HlEzXZjyFtbJ/KzOGd8vMtgbo6sn
         IjLQ==
X-Gm-Message-State: AC+VfDySRwPpOIj9Dx6MYneYSlYsdpagYtnYlgRYzd20v44AIfBtz+ZJ
        GNaGqlKhpbXaOecZmKJA8WAkFHL4l//WjK6gBNBMgw==
X-Google-Smtp-Source: ACHHUZ7KGBBKidxkonefCJDBhObv1u5vOSFiRrhYpWG4uzfVOm+Br56TJUXrQbSRcCCtDVdvY7iG+w==
X-Received: by 2002:ac2:529a:0:b0:4ef:ebbb:2cf5 with SMTP id q26-20020ac2529a000000b004efebbb2cf5mr467562lfm.17.1683111047318;
        Wed, 03 May 2023 03:50:47 -0700 (PDT)
Received: from prevas-ravi.k200.local ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id j1-20020a19f501000000b004eff0bcb276sm4702776lfb.7.2023.05.03.03.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 03:50:46 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: addac: ad74413: don't set DIN_SINK for functions other than digital input
Date:   Wed,  3 May 2023 12:50:41 +0200
Message-Id: <20230503105042.453755-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
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

Apparently, despite the name Digital Input Configuration Register, the
settings in the DIN_CONFIGx registers also affect other channel
functions. In particular, setting a non-zero value in the DIN_SINK
field breaks the resistance measurement function.

Now, one can of course argue that specifying a drive-strength-microamp
property along with a adi,ch-func which is not one of the digital
input functions is a bug in the device tree. However, we have a rather
complicated setup with instances of ad74412r on external hardware
modules, and have set a default drive-strength-microamp in our DT
fragments describing those, merely modifying the adi,ch-func settings
to reflect however the modules have been wired up. And restricting
this setting to just being done for digital input doesn't make the
driver any more complex.

Fixes: 504eb485589d1 (iio: ad74413r: wire up support for drive-strength-microamp property)
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/iio/addac/ad74413r.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index e3366cf5eb31..6b0e8218f150 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -1317,13 +1317,14 @@ static int ad74413r_setup_gpios(struct ad74413r_state *st)
 		}
 
 		if (config->func == CH_FUNC_DIGITAL_INPUT_LOGIC ||
-		    config->func == CH_FUNC_DIGITAL_INPUT_LOOP_POWER)
+		    config->func == CH_FUNC_DIGITAL_INPUT_LOOP_POWER) {
 			st->comp_gpio_offsets[comp_gpio_i++] = i;
 
-		strength = config->drive_strength;
-		ret = ad74413r_set_comp_drive_strength(st, i, strength);
-		if (ret)
-			return ret;
+			strength = config->drive_strength;
+			ret = ad74413r_set_comp_drive_strength(st, i, strength);
+			if (ret)
+				return ret;
+		}
 
 		ret = ad74413r_set_gpo_config(st, i, gpo_config);
 		if (ret)
-- 
2.37.2

