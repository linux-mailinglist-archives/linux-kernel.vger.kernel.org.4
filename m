Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BA062595D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiKKL2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiKKL2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:28:21 -0500
Received: from dhl.lxnav.com (dhl.lxnav.com [IPv6:2a01:4f8:c010:2f07::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3F86A772
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:28:12 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 982964070A;
        Fri, 11 Nov 2022 12:28:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lxnav.com; s=dhl;
        t=1668166088; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=sduuwDJ1cpdPo1tG/vMuBFFxLHUHN1zt6Q+P4Jawaig=;
        b=R25EG2cP4ELm7lYu+1KM6DyIj0ArFnNkdIqozN6tS6rHE7IFVOzk8vSoUTX7eDuwY71eTo
        PGJqHjaJc7bD4rQnT5gPGbAhDEAph/MMwIC70Hq4A94Y/vBTyE/raLT6xR9zbA1Zd3R7KH
        ELJfQrO6N8R93ZeIrjhjRlOUjlUs3zs5Q/HMf5a00aMGv292ercvOUMYrSR/evWYJaupYQ
        iwo9pP7Zx8Gdz00TCYvbueWxtHomDdTHaIFgehqyvJ8MNMmWeX5ORfwnP53pzvZh+bB3yf
        1lb7zI5NgbGLuXpORXZMXI+tf1XZXCO9bZiNst+yOxkrQl/A8ITZqA/IgkKRcg==
From:   Mitja Spes <mitja@lxnav.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mitja Spes <mitja@lxnav.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] iio: adc: mcp3422: reduce sleep for fast sampling rates
Date:   Fri, 11 Nov 2022 12:26:56 +0100
Message-Id: <20221111112657.1521307-5-mitja@lxnav.com>
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

- reduced sleep time for 240 & 60 sps rates
- minor roundup fix for sleep times

Signed-off-by: Mitja Spes <mitja@lxnav.com>
---
 drivers/iio/adc/mcp3422.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index eef35fb2fc22..dbcc8fe91aaa 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -70,10 +70,11 @@ static const int mcp3422_scales[MCP3422_SRATE_COUNT][MCP3422_PGA_COUNT] = {
 
 /* Constant msleep times for data acquisitions */
 static const int mcp3422_read_times[MCP3422_SRATE_COUNT] = {
-	[MCP3422_SRATE_240] = 1000 / 240,
-	[MCP3422_SRATE_60] = 1000 / 60,
-	[MCP3422_SRATE_15] = 1000 / 15,
-	[MCP3422_SRATE_3] = 1000 / 3 };
+	[MCP3422_SRATE_240] = DIV_ROUND_UP(1000, 240),
+	[MCP3422_SRATE_60] = DIV_ROUND_UP(1000, 60),
+	[MCP3422_SRATE_15] = DIV_ROUND_UP(1000, 15),
+	[MCP3422_SRATE_3] = (100000 + 375 - 100) / 375 /* real rate is 3.75 sps */
+};
 
 /* sample rates to integer conversion table */
 static const int mcp3422_sample_rates[MCP3422_SRATE_COUNT] = {
@@ -137,6 +138,7 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
 				struct iio_chan_spec const *channel, int *value)
 {
 	int ret;
+	int sleep_duration;
 	u8 config;
 	u8 req_channel = channel->channel;
 
@@ -148,7 +150,11 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
 			mutex_unlock(&adc->lock);
 			return ret;
 		}
-		msleep(mcp3422_read_times[MCP3422_SAMPLE_RATE(adc->active_config)]);
+		sleep_duration = mcp3422_read_times[MCP3422_SAMPLE_RATE(adc->active_config)];
+		if (sleep_duration < 20)
+			usleep_range(sleep_duration * 1000, sleep_duration * 1300);
+		else
+			msleep(sleep_duration);
 	}
 
 	ret = mcp3422_read(adc, value, &config);
-- 
2.34.1

