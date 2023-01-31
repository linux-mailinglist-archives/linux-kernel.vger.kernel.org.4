Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2394682A9C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjAaKeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjAaKeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:34:06 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8188C1422A;
        Tue, 31 Jan 2023 02:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675161244; x=1706697244;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r4kjuULXMnJtmj88iglwf80C4myiNq+dzKNJ7ZMal+c=;
  b=UzvAd1EnwRn2DmRzzbLMvs6EXQygS2arczCpKfJT97HTT56T0k5d/wkZ
   ZRkFPfKZNfm5UsRJHUuhhfUMIQGy5oqWrY/fT+PNVFbX7RqX0RYaoUKo2
   XURCrSlQuQKTiwxtKM0YKi73VRsTfrymYbbZD9V78ngkZSR8HZWC4Tc7q
   1q1HC7jmyjAAfaPrFa5Ih/Pjx3lSy0+1uQGbbzvUcdprxxzkz37gRoDBE
   QlmfG2GV6v60WC4Jq9tX0cyKPGyRxf7MeDJT0RVk7mKbCGCQ9bDN5zJ7w
   0jhrJe4+iQdKqceYb9acKU5+wEDpEiXXBS5nKd11qSYi0CXrsPCLbF2kt
   w==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="28767327"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 31 Jan 2023 11:34:03 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 31 Jan 2023 11:34:03 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 31 Jan 2023 11:34:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675161243; x=1706697243;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r4kjuULXMnJtmj88iglwf80C4myiNq+dzKNJ7ZMal+c=;
  b=AlyjSfLvgHNDFL3vxw6/gzOGrVWY1TpFOMQNQjBH95ntpK93iXdesPsu
   AIi4Rv11xDCt8sRJz2e6lQBZhZp/YAqlxrYdf9+L6za3P2YSopZT7HHZ1
   SWz4QZZR0v5SW0A3JqAwwqTmX+oMBcn9a8eKUzHlJC4qZutsjmefzJ02L
   n2azQALl6q9WxjlaOKX9Y9M/B7uClZP+okNR72kt5jypjiT8Rp0lJ9jRl
   JOuOSBHy6Mf0cqfyZ6yr27cVibDk2t9F6G3dbSE3k1d3qeweyDEaQ1Ng+
   2wodbbN4JW/QQhNeiSXDtRF7MdAp5YclxjNDLEeq40UEXCcOXlgTUIiVq
   g==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="28767326"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 31 Jan 2023 11:34:02 +0100
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id AA533280072;
        Tue, 31 Jan 2023 11:34:02 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] hwmon: (iio_hwmon) use dev_err_probe
Date:   Tue, 31 Jan 2023 11:33:59 +0100
Message-Id: <20230131103359.625081-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of just returning an error code, add an error message as well.
While at it, simplify the code and use a common return path.
Upon deferral this also nicely lists the following message in
/sys/kernel/debug/devices_deferred:
adc     iio_hwmon: Failed to get channels

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/hwmon/iio_hwmon.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index 3aa40893fc09..4c8a80847891 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -77,9 +77,11 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 
 	channels = devm_iio_channel_get_all(dev);
 	if (IS_ERR(channels)) {
-		if (PTR_ERR(channels) == -ENODEV)
-			return -EPROBE_DEFER;
-		return PTR_ERR(channels);
+		ret = PTR_ERR(channels);
+		if (ret == -ENODEV)
+			ret = -EPROBE_DEFER;
+		return dev_err_probe(dev, ret,
+				     "Failed to get channels\n");
 	}
 
 	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
-- 
2.34.1

