Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C056E01ED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjDLWhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjDLWhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:37:03 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813F476A9;
        Wed, 12 Apr 2023 15:37:01 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Pxcyg5SmKz9sjN;
        Thu, 13 Apr 2023 00:36:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1681339019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NLZaMASFM7Zk2iHOKzdzLhBxwDhzf9hvMJPzhzphBYY=;
        b=DttlIcYLSXwiLqP/JM6G0kgtmUe+AXrUC+BIoPK2n9sLXgAqCms6Jx3BXtc/WPRjmNYZjt
        shZNmwOIJoQBxK30b1uj2BK/neMWMEMijOaibA/jKw/eu4YOexaindqh6fIBDQxcwt6Grx
        IBJcuTTF5Ba6x3mwID4yn5pB64cDPnG5qiIOVyK2SmQwHWZ0AL9YjCr+RmVGdKfAz6JgfB
        FBg4MwxlXM5BMkirrMF/6ARDJYUO5LDURqFBE67kW6aviEv7oxAcjYykIt7F2mtPAH00l1
        d+4Mp8XUk0QI9C5R+PMZmLfWcsuw8lhr9RNPc8HV3/TRYXFMALZL3XaAW1ivSw==
From:   mail@mariushoch.de
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <mail@mariushoch.de>
Subject: [PATCH] iio: magnetometer: st_accel: Add LSM303D
Date:   Thu, 13 Apr 2023 00:36:23 +0200
Message-Id: <20230412223627.442963-3-mail@mariushoch.de>
In-Reply-To: <20230412223627.442963-1-mail@mariushoch.de>
References: <20230412223627.442963-1-mail@mariushoch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Pxcyg5SmKz9sjN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marius Hoch <mail@mariushoch.de>

The lsm303d has the same register mapping as the lsm9ds0,
thus we can just re-use that.

Tested on a Lenovo Yoga Tablet 2 1051-F.

Signed-off-by: Marius Hoch <mail@mariushoch.de>
---
 drivers/iio/magnetometer/st_magn_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 8faa7409d9e1..6cc0dfd31821 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -427,6 +427,7 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = LSM9DS0_IMU_DEV_NAME,
+			[1] = LSM303D_IMU_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_magn_4_16bit_channels,
 		.odr = {
-- 
2.39.2

