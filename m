Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9844722389
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjFEKc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFEKcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:32:54 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60486EA;
        Mon,  5 Jun 2023 03:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=XZiVldLWqdwbMBBgGYgkQEvrIRfRmGDyyFJop1yZS/U=; b=T7hQUR5j7ZMGcj3VvxAv/jjgxa
        efGQdSYUlFpmkdeGq0/zd8M5006USx0Lu+zG/mgORNGqrBp2DWQ61O4ngGmQBLvUqNHaDey2pbNI1
        jxzYu3LCJizcb05nRnIdFDBgsbXQxDfdhH0B8kDc/Yx4b7ZTWYr57pZJchokQQ8aaX303k5oSiTVI
        FwHVsxDd+cUGBUZZ6VvZcs5ubcc28Fvi9LrcvvS6nATXZigL/7VbocfQPjTn2dRA4JldmqR2cOnED
        RIwoGPPaepMDH+oCH0nzABNaqyTGT1tx6v/M/6zFrOf/+XVIyG8benio5DWSwKdoEJ0Dt4CC9Kso7
        YCIHGu5g==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1q67W7-000FPw-2h; Mon, 05 Jun 2023 12:32:51 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1q67W6-000Ns0-NU; Mon, 05 Jun 2023 12:32:50 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sean Nyekjaer <sean@geanix.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: accel: fxls8962af: fixup buffer scan element type
Date:   Mon,  5 Jun 2023 12:32:21 +0200
Message-Id: <20230605103223.1400980-1-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26929/Mon Jun  5 09:34:01 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scan elements for x,y,z channels is little endian and requires no bit shifts.
LE vs. BE is controlled in register SENS_CONFIG2 and bit LE_BE, default
value is LE.

Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Cc: stable@vger.kernel.org
---
 drivers/iio/accel/fxls8962af-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 0d672b1469e8..bf7949e51e6c 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -724,8 +724,8 @@ static const struct iio_event_spec fxls8962af_event[] = {
 		.sign = 's', \
 		.realbits = 12, \
 		.storagebits = 16, \
-		.shift = 4, \
-		.endianness = IIO_BE, \
+		.shift = 0, \
+		.endianness = IIO_LE, \
 	}, \
 	.event_spec = fxls8962af_event, \
 	.num_event_specs = ARRAY_SIZE(fxls8962af_event), \
-- 
2.40.0

