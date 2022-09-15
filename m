Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A001C5B9830
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiIOJwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiIOJvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:51:33 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9C1DEA;
        Thu, 15 Sep 2022 02:49:31 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w13so2171291plp.1;
        Thu, 15 Sep 2022 02:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BLldUmawu01GzUZglxj6MBSK7Wi8J1495Ow2vHiQCbA=;
        b=mWs3Joq2+U9sk0TTku4uVfHfyJi54bqPrLJdN+GMWioKOLnEkyRHTv5xRQa+u2QYdw
         dV95RVVDRAFNhd4CPJ8CDqlym//oYKusNe9pE+0UGlurC7GX9j8A0Jv5IGrQxD/r4B/t
         X13xnw9hl7TkRq7NoOqQaN5jnWFHhwLI7Auvg/P63ImdtomryUyEtHnnuVHpewnd0ZoO
         LCFMNAIQACzoLpPObHtHKsS0aYUS7SoFHipgKt6I9xIK+3iAKZeC3j0BoBAU2najHWr6
         Ss9mWYWzKs3SgdP2noEt8mTzKzK7+QiBVL63MfrogRCkmxX0O33J6DOrFKmGE2fz5bDu
         YZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BLldUmawu01GzUZglxj6MBSK7Wi8J1495Ow2vHiQCbA=;
        b=xeUkZfJZl4iab4Jn4PwF7VJ6xC4YlXYCutT02DRfI2PzSEu6+xs4I+gwPkaEDj5Q6K
         iGmZ4qtQbIRXbUXPhPlHMQuzE5KvNg7mO33B8OyibqQiqi4YzBMHBcVX2MEh+URYIK1y
         /q+/JZzFmxCG8MgwsdiOPguxH7mIN0S9sSWRODGVFdpOZ4ssfXh5mmtkysCznEcoJLiM
         lpOwOr98i2kZiCb5A4swgf/Vb58TXH62AbHfWwKk83eBfI4QD6zFA2CFQPnG2VjnfBvt
         bCHidlMm3A8Rw05+TmQ6AxaNZlVYJW7R2ccGfYK5wliRsbpEjpV623DM64aT1CvqzgB2
         WjRg==
X-Gm-Message-State: ACrzQf1drRg31aqY/6NZHZmaV35QW2F1fsJGXLVPt3KNT/BChg6VcnOR
        9uW1mpxkcWDdg2pW7qFkAGY=
X-Google-Smtp-Source: AA6agR6yi0j1GpLpIKM8QQVsHOeuU4zo8E/AA6tf+Pawbf6kZNb9CUcIHt39amXLj4c6P9ph2VToYw==
X-Received: by 2002:a17:90b:4d12:b0:202:e772:fa09 with SMTP id mw18-20020a17090b4d1200b00202e772fa09mr10042498pjb.30.1663235366651;
        Thu, 15 Sep 2022 02:49:26 -0700 (PDT)
Received: from RD-3580-24288.rt.l (114-137-177-189.emome-ip.hinet.net. [114.137.177.189])
        by smtp.gmail.com with ESMTPSA id n4-20020a170903110400b00176675adbe1sm12669010plh.208.2022.09.15.02.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 02:49:26 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, jic23@kernel.org, lars@metafoo.de,
        broonie@kernel.org, mazziesaccount@gmail.com,
        andriy.shevchenko@linux.intel.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        szunichen@gmail.com
Subject: [PATCH v11 4/8] lib: add linear range index macro
Date:   Thu, 15 Sep 2022 17:47:32 +0800
Message-Id: <0418eade65d434a25d304eaa804b34f92318be87.1663254344.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663254344.git.chiaen_wu@richtek.com>
References: <cover.1663254344.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiaEn Wu <chiaen_wu@richtek.com>

Add linear_range_idx macro for declaring the linear_range struct simply.

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 include/linux/linear_range.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/linear_range.h b/include/linux/linear_range.h
index fd3d0b3..2e4f4c3 100644
--- a/include/linux/linear_range.h
+++ b/include/linux/linear_range.h
@@ -26,6 +26,17 @@ struct linear_range {
 	unsigned int step;
 };
 
+#define LINEAR_RANGE(_min, _min_sel, _max_sel, _step)		\
+	{							\
+		.min = _min,					\
+		.min_sel = _min_sel,				\
+		.max_sel = _max_sel,				\
+		.step = _step,					\
+	}
+
+#define LINEAR_RANGE_IDX(_idx, _min, _min_sel, _max_sel, _step)	\
+	[_idx] = LINEAR_RANGE(_min, _min_sel, _max_sel, _step)
+
 unsigned int linear_range_values_in_range(const struct linear_range *r);
 unsigned int linear_range_values_in_range_array(const struct linear_range *r,
 						int ranges);
-- 
2.7.4

