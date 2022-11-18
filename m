Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90AF62F4D1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbiKRMdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241920AbiKRMcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:32:53 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092596151C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:32:40 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id d3so6632298ljl.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8HEJJXAKUVernzz9Wo79oEymNliom5Q3VVumNx+M1W8=;
        b=ZHAsgUaIWQPKb7iP/4IhX7MSK56qD1Nu3eXRxrAMUGG2t6iZTKCtKcePZEEZ74Ix9P
         cj8eDHhW7tDMWCJozEgA2J9epPPJ/7RZ+6edwoM0qIWSXQkvMSaQrMTIrNM9pvrBlArr
         2H+Sns5tB+WlXbcHzNE9V5XCKY1D4BeOUREWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HEJJXAKUVernzz9Wo79oEymNliom5Q3VVumNx+M1W8=;
        b=7mXNJdXhNUr55BRPE77pXZcZhHMGzCB5gce1AGGzpfcBHO7Z8WGfM0VwYMlJx8dCK7
         lRYbdwo/rlp/hLvjO/PfTX5dDn30FWhHE9rLzVSussYX7uliz5yZc72GGelgmgsgxFgU
         tYq3OsEZJ9fzpm7xQX6pPTBaOw/z/O4/USIV+FQNMEnpbEDTl8VD65xCpcd9oSGPgKFX
         NOcFEx4M6At7QcqOD9Q1TQfjpyo2/UZItbsfB/wCoy9Wq8T+q5P1MgoslAZGXs89jIpo
         094F9WpsUwYd4pjtZygtkBcfXTwrMCr25M0fiJGYcbvT4jaqss+sEy4ocRoj0To7nZfz
         9hLw==
X-Gm-Message-State: ANoB5pn413OBfGtxZWBPvEt8eduPTqFL+2dxC3FY6TPHrP92vOROhHxG
        D9egfTvwSsxremRN32NFCXqu09kspY6ElSW5
X-Google-Smtp-Source: AA0mqf6Fvt8uQzigsSimZcSHe9Uqqm05defEGAKmdl86vVb4suGy7UmFhT8pik6o8uYT52SOmO44+w==
X-Received: by 2002:a05:651c:12c1:b0:277:2fd5:482 with SMTP id 1-20020a05651c12c100b002772fd50482mr2619130lje.194.1668774758200;
        Fri, 18 Nov 2022 04:32:38 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u3-20020a05651220c300b00496d3e6b131sm639484lfr.234.2022.11.18.04.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:32:37 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: addac: ad74413r: fix integer promotion bug in ad74413_get_input_current_offset()
Date:   Fri, 18 Nov 2022 13:32:08 +0100
Message-Id: <20221118123209.1658420-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
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

The constant AD74413R_ADC_RESULT_MAX is defined via GENMASK, so its
type is "unsigned long".

Hence in the expression voltage_offset * AD74413R_ADC_RESULT_MAX,
voltage_offset is first promoted to unsigned long, and since it may be
negative, that results in a garbage value. For example, when range is
AD74413R_ADC_RANGE_5V_BI_DIR, voltage_offset is -2500 and
voltage_range is 5000, so the RHS of this assignment is, depending on
sizeof(long), either 826225UL or 3689348814709142UL, which after
truncation to int then results in either 826225 or 1972216214 being
the output from in_currentX_offset.

Casting to int avoids that promotion and results in the correct -32767
output.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/iio/addac/ad74413r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 899bcd83f40b..e0e130ba9d3e 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -691,7 +691,7 @@ static int ad74413_get_input_current_offset(struct ad74413r_state *st,
 	if (ret)
 		return ret;
 
-	*val = voltage_offset * AD74413R_ADC_RESULT_MAX / voltage_range;
+	*val = voltage_offset * (int)AD74413R_ADC_RESULT_MAX / voltage_range;
 
 	return IIO_VAL_INT;
 }
-- 
2.37.2

