Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB18462595B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbiKKL2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiKKL2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:28:18 -0500
Received: from dhl.lxnav.com (dhl.lxnav.com [IPv6:2a01:4f8:c010:2f07::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B351569DC9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:28:09 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E82040768;
        Fri, 11 Nov 2022 12:28:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lxnav.com; s=dhl;
        t=1668166085; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=NqvSjeOULQZbj3EUjH7dknKYQjo14gTb8HTU0Fd3y2A=;
        b=hYtyX2wIlbpRse+AYLKuwh4QMTwz+d6nnySOhp5qQRVLJviQ613mUP4sJZtegxv8cMGmte
        nhI8wp+T8NjKNqbOm9W/KRQIwkFC94s6Rv8aXZlmOBJFoxE4Kin3W/Sr7gva9ohi5J043I
        ZILyXvw1M71C/kaI/gO/KksqNXI5gt1qPD9vdZqkw655oQxRs4Yk0z0ZHk0nLw2hD9nJB7
        fCsRc4Lh/uj00LPqmEJVFrrRI9rjLMMO30Ecccdha44/3JURIwe5PrIOk1QrRAiYk6pCm6
        1qiKhmLqrLduxacyuSXsE9KikRzdlFFeZTCw+nhw/j3b9hzw3o43lJUgQ/tEkw==
From:   Mitja Spes <mitja@lxnav.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mitja Spes <mitja@lxnav.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] iio: adc: mcp3422: add hardware gain attribute
Date:   Fri, 11 Nov 2022 12:26:55 +0100
Message-Id: <20221111112657.1521307-4-mitja@lxnav.com>
In-Reply-To: <20221111112657.1521307-1-mitja@lxnav.com>
References: <20221111112657.1521307-1-mitja@lxnav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows setting gain separately from scale.

Signed-off-by: Mitja Spes <mitja@lxnav.com>
---
 drivers/iio/adc/mcp3422.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index cfb629b964af..eef35fb2fc22 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -58,7 +58,8 @@
 		.channel = _index, \
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) \
 				| BIT(IIO_CHAN_INFO_SCALE) \
-				| BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+				| BIT(IIO_CHAN_INFO_SAMP_FREQ) \
+				| BIT(IIO_CHAN_INFO_HARDWAREGAIN), \
 	}
 
 static const int mcp3422_scales[MCP3422_SRATE_COUNT][MCP3422_PGA_COUNT] = {
@@ -184,6 +185,10 @@ static int mcp3422_read_raw(struct iio_dev *iio,
 		*val1 = mcp3422_sample_rates[sample_rate];
 		return IIO_VAL_INT;
 
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		*val1 = (1 << pga);
+		return IIO_VAL_INT;
+
 	default:
 		break;
 	}
@@ -245,6 +250,29 @@ static int mcp3422_write_raw(struct iio_dev *iio,
 		adc->ch_config[req_channel] = config;
 		return 0;
 
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		switch (val1) {
+		case 1:
+			temp = MCP3422_PGA_1;
+			break;
+		case 2:
+			temp = MCP3422_PGA_2;
+			break;
+		case 4:
+			temp = MCP3422_PGA_4;
+			break;
+		case 8:
+			temp = MCP3422_PGA_8;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		config &= ~MCP3422_PGA_MASK;
+		config |= MCP3422_PGA_VALUE(temp);
+		adc->ch_config[req_channel] = config;
+		return 0;
+
 	default:
 		break;
 	}
@@ -260,6 +288,8 @@ static int mcp3422_write_raw_get_fmt(struct iio_dev *indio_dev,
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
-- 
2.34.1

