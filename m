Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA7172238A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjFEKdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFEKcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:32:54 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FA0EC;
        Mon,  5 Jun 2023 03:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Kmh6Q+En4QAQCaRsLzaEanf4GOSbnJbhi38Sn/xlHv0=; b=Wh/DWcCzpVQD50rALlJTjxkC7w
        WAjloqSEfWAbDDoD++9ZZIr1tei6gpqOEvsBYqaK856XCMAG7L+UJNn6+Wm5bFEdc7A31t+Tm1So4
        G7TwY1jomDgyMglxGAvJQ++EIzuz2hfsir8StzS/+7G0O8Nn+1+8KOLOd+KQfCZhBa2OA/9ngY1+8
        5jQZ7lQvOKhrPFGHOInvnQVQtijkcgFzf27YZ6kh4YifExj2vVOWW29x4x79rv7+gidcQSTrQPrAk
        dvL0JR5qNdrqq/QQ5soNBV5vZB+2HyoAumQmEGwrI+Bc8EVRXZZrNQiCqF4/ojC8wdZCN1MrvWV8K
        je6xEUEA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1q67W7-000FQ5-Jy; Mon, 05 Jun 2023 12:32:51 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1q67W7-000Ns0-A8; Mon, 05 Jun 2023 12:32:51 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sean Nyekjaer <sean@geanix.com>
Cc:     stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: accel: fxls8962af: errata bug only applicable for FXLS8962AF
Date:   Mon,  5 Jun 2023 12:32:22 +0200
Message-Id: <20230605103223.1400980-2-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230605103223.1400980-1-sean@geanix.com>
References: <20230605103223.1400980-1-sean@geanix.com>
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

Remove special errata handling if FXLS8964AF is used.

Fixes: af959b7b96b8 ("iio: accel: fxls8962af: fix errata bug E3 - I2C burst reads")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Cc: stable@vger.kernel.org
---
 drivers/iio/accel/fxls8962af-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index bf7949e51e6c..3f27834ef04c 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -904,9 +904,10 @@ static int fxls8962af_fifo_transfer(struct fxls8962af_data *data,
 	int total_length = samples * sample_length;
 	int ret;
 
-	if (i2c_verify_client(dev))
+	if (i2c_verify_client(dev) &&
+	    data->chip_info->chip_id == FXLS8962AF_DEVICE_ID)
 		/*
-		 * Due to errata bug:
+		 * Due to errata bug (only applicable on fxls8962af):
 		 * E3: FIFO burst read operation error using I2C interface
 		 * We have to avoid burst reads on I2C..
 		 */
-- 
2.40.0

