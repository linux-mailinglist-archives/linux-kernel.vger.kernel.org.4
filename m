Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4976B5FA44F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJJTrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJJTq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:46:58 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3725E559;
        Mon, 10 Oct 2022 12:46:55 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id x18so5837269ljm.1;
        Mon, 10 Oct 2022 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hKtR8JVIp6FNFfckoP6qflwXPqB9HW7iOtTc8jEtu3g=;
        b=YVx8BQUMqOWo3vXqoqTAgVFjcOWYBMs7DoY0bwuJ2Sy5LoiDs9sXTLzS1HsVkiIVwj
         C9vuYseRVD2Eq/m4y1leskgHMWaKGOgONlZap7H6vjIRTU065wuoafkacmc4lg8kdMJa
         bg9McYSh2j/5btauOTbz6jrmyGXundWNoXIeTXoo4Qy7YjDxC43x5FMuLYwZsCyFoulU
         rFIZtlC1Ke0N9HKze2SeNhjuZ7JeI5ckoPv1/lcERy7oATzdcspo5ha17ChTzSRDEgpw
         asRByzAsV9GcYT9rAuX8FbRA1gRg8hYX1Lb7Z3l7SwMooNfC0nDsBZUDsvDbRg3Y24kK
         J/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hKtR8JVIp6FNFfckoP6qflwXPqB9HW7iOtTc8jEtu3g=;
        b=T5onvwIUsPACmQkKSobJ2JrUx5eCtgYt4yDQPB+JqqrU7DMmziETBTvpDV+yy+NG7C
         gdbPw46UDhGeRVTbDanDnFHQdx7wo6WQXzjAv+NUwgH64p6ldUg4xT4qmVMSGGHTvuZq
         LrS+AdqBPdYnvCp0XkqL8i5Lt8vlXrthiLbrYUz6nknyMiRvgqw/9szkwGvaay1Zs1Xn
         49WAyc1Hsca99IVy85XRzlMLZtqf5xaaxOjebI/s2Tq6Jdv5V3Ilk4CPFJwMMIBq25gU
         iyr+Z0bHxhZBSGD/5IpXkeSDtB4LyS0fXNtfRub6u+7E6kcQgQP+Ce2Kd/XTKHS5OAeB
         P/8w==
X-Gm-Message-State: ACrzQf0JAPsUTKsl+orUoLUjGaBsJowW17C9UCYEMR6g7eum6xGxccy4
        xKIOK4Dsy2+o8cNTW79loMkQFxbiQjo=
X-Google-Smtp-Source: AMsMyM7rp9rYmm2wixrGZrUz3aSNf8/xQD31orfC4b7a4YjTuM4F+NKdYw1QvS7XtJAlEJ1JK7AALg==
X-Received: by 2002:a2e:a499:0:b0:26f:a7cb:d9d with SMTP id h25-20020a2ea499000000b0026fa7cb0d9dmr2464458lji.139.1665431213397;
        Mon, 10 Oct 2022 12:46:53 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id p20-20020ac24ed4000000b004a2588520f5sm1540690lfr.166.2022.10.10.12.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 12:46:52 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: mcp3911: use correct id bits
Date:   Mon, 10 Oct 2022 21:46:41 +0200
Message-Id: <20221010194641.676484-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
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

The device ID should be shifted 6 bits to left according to datasheet.

Fixes: 3a89b289df5d ("iio: adc: add support for mcp3911")
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index e55db02c534f..2c1af11a621f 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -57,8 +57,8 @@
 /* Internal voltage reference in mV */
 #define MCP3911_INT_VREF_MV		1200
 
-#define MCP3911_REG_READ(reg, id)	((((reg) << 1) | ((id) << 5) | (1 << 0)) & 0xff)
-#define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 5) | (0 << 0)) & 0xff)
+#define MCP3911_REG_READ(reg, id)	((((reg) << 1) | ((id) << 6) | (1 << 0)) & 0xff)
+#define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 6) | (0 << 0)) & 0xff)
 
 #define MCP3911_NUM_CHANNELS		2
 #define MCP3911_NUM_SCALES		6
-- 
2.37.1

