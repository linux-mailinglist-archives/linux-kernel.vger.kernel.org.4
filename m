Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7024B5BD80E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiISXRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiISXRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:17:40 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037024B0FE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:17:39 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id k12so539582qkj.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WopcYcPly2clGQMko18Z5Oo2qU5OZoDnJ7KQZMk3xww=;
        b=LamPOf6Xv6PxDji/NDvDyiv2TYSbNPa+hFBFgCpeuqYRaIFpaU24B/fRlRM4hp0470
         +OKA6GsYE7T7REOH/DJkrCEw3WiQSIJ/pDsm9wqU14WhB+j2hdO1zTTLoO5FctZ+Oa/x
         AnhLtU+TNgk5zVLUgJD+XNmsGHctj3YjRJxrxpUkFs90YaQIXb+4Fk+NBir6KqlhNz79
         /hE7KoavKgiikjjtR69fSWUg86ve7j/TJ2FZn0H4p38ORN6NJvGjx2cttjIfjRKenxm7
         AUUqV2WNwi2k4amsIPf5D4vl/ms1uJYIQ6X3Ml9NJhcExHb+RNime0F8rjJEMw1eKBbd
         WRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WopcYcPly2clGQMko18Z5Oo2qU5OZoDnJ7KQZMk3xww=;
        b=HMAHazROTCXNRWvLfn1xidIy8hz6JMSuFOZ56KjATVDvqLYoVVWe+ysacGUqLuSWWh
         sj5aRKn2qqJBWzcI6z52LOPIvqpxR4bw+9NX/h/3tOkSH96UaajaVnGqhx6IcRerH95j
         wPdWanmi2DbSK7O1/BZZP1Z8SYDMZxzx2y7BIR6rGb2rWhhQ2ypNWuw1O4HMLosyxekZ
         b+ytYdGKhIlZc2Yn2ijYApjLy4F0Bf+oW0r8QsX9jW9rgWaDOfATH9ANFXQJZh58D/gO
         2XEVkTkRpL5IEOxGpo3oqy7IQKUEGMXYQ64vRbvD55jTPqjE1q3T5jn/uSumT44iQ7Gd
         zUew==
X-Gm-Message-State: ACrzQf1/oCtexzQF52xBQKJ0FryN0yWXUN7se2NG25Rr4jCwzE7hAArq
        vKxhG2Kg86M5qRfTLxzPW/+jBA==
X-Google-Smtp-Source: AMsMyM4ILoEcv/6xCcEEodsafunFHi1qVBkYah5xudFsxSBUnp+9v4sOt3MFyKkfXgdtvPcPfNyyCw==
X-Received: by 2002:a05:620a:2793:b0:6cb:c11a:130f with SMTP id g19-20020a05620a279300b006cbc11a130fmr14332366qkp.549.1663629458118;
        Mon, 19 Sep 2022 16:17:38 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id d4-20020ac80604000000b0035cebb79aaesm2547005qth.18.2022.09.19.16.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 16:17:37 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v4 2/4] counter: 104-quad-8: Add Signal polarity component
Date:   Sun, 18 Sep 2022 14:22:05 -0400
Message-Id: <8f1e5d7a264f0a40422733775ea63d39027ecec7.1663524845.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663524845.git.william.gray@linaro.org>
References: <cover.1663524845.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 104-quad-8 driver provides support for Index signal polarity modes
via the "index_polarity" Signal component. This patch exposes the same
functionality through the more standard "polarity" Signal component.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/104-quad-8.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 1323edfbe40c..2a9d8259ed4b 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -549,6 +549,32 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 	return 0;
 }
 
+static int quad8_polarity_read(struct counter_device *counter,
+			       struct counter_signal *signal,
+			       enum counter_signal_polarity *polarity)
+{
+	int err;
+	u32 index_polarity;
+
+	err = quad8_index_polarity_get(counter, signal, &index_polarity);
+	if (err)
+		return err;
+
+	*polarity = (index_polarity) ? COUNTER_SIGNAL_POLARITY_POSITIVE :
+		COUNTER_SIGNAL_POLARITY_NEGATIVE;
+
+	return 0;
+}
+
+static int quad8_polarity_write(struct counter_device *counter,
+				struct counter_signal *signal,
+				enum counter_signal_polarity polarity)
+{
+	const u32 pol = (polarity == COUNTER_SIGNAL_POLARITY_POSITIVE) ? 1 : 0;
+
+	return quad8_index_polarity_set(counter, signal, pol);
+}
+
 static const char *const quad8_synchronous_modes[] = {
 	"non-synchronous",
 	"synchronous"
@@ -977,6 +1003,13 @@ static struct counter_comp quad8_signal_ext[] = {
 			       quad8_signal_fck_prescaler_write)
 };
 
+static const enum counter_signal_polarity quad8_polarities[] = {
+	COUNTER_SIGNAL_POLARITY_POSITIVE,
+	COUNTER_SIGNAL_POLARITY_NEGATIVE,
+};
+
+static DEFINE_COUNTER_AVAILABLE(quad8_polarity_available, quad8_polarities);
+
 static DEFINE_COUNTER_ENUM(quad8_index_pol_enum, quad8_index_polarity_modes);
 static DEFINE_COUNTER_ENUM(quad8_synch_mode_enum, quad8_synchronous_modes);
 
@@ -984,6 +1017,8 @@ static struct counter_comp quad8_index_ext[] = {
 	COUNTER_COMP_SIGNAL_ENUM("index_polarity", quad8_index_polarity_get,
 				 quad8_index_polarity_set,
 				 quad8_index_pol_enum),
+	COUNTER_COMP_POLARITY(quad8_polarity_read, quad8_polarity_write,
+			      quad8_polarity_available),
 	COUNTER_COMP_SIGNAL_ENUM("synchronous_mode", quad8_synchronous_mode_get,
 				 quad8_synchronous_mode_set,
 				 quad8_synch_mode_enum),
-- 
2.37.3

