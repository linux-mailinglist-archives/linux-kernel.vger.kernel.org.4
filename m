Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5246800ED
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 19:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbjA2Srl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 13:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjA2Srj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 13:47:39 -0500
X-Greylist: delayed 2498 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 Jan 2023 10:47:07 PST
Received: from mx.flying-snail.de (mx.flying-snail.de [IPv6:2a06:1c40:3::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EACE206A7;
        Sun, 29 Jan 2023 10:47:07 -0800 (PST)
Received: from [2a02:908:1b0:8800:2ff:ffff:fe11:2236] (helo=mondbasis.internal.flying-snail.de)
        by mx.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pMC3S-000nCh-MC; Sun, 29 Jan 2023 19:05:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=feldner-bv.de; s=s1; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=2Ah3M2XYpBYD33vznQiby+cj6OhHC3L8o5U3S39YtlU=; b=o0duPuddPQgsHoe5+BV1gDXjzV
        Sa04Me2rSAxmHP7q4vXwng99ZYMS6wVm47INK+POULYfmxC2Sm3AMqX0UTKRmxHUGRd9QxewTDuYt
        KGi6tUJiF6n1hy9C3MCp4/TbgeoKkxfQ6rwwZXzQmYSit4TtYXg8x+GModfRMwDJq+VUs8/3EIuvH
        v3kbGw47owUsdIfkP9/c9kColyzA/VWEcdoVMcqsClBXT5e5aF7Nqj2zwJhwBFVnjA+LkbnCt05kL
        XbK0wgSFY0ndU4hvKwaQr3Nx3dJwpFBr5xSxWbNS+23sfBak0RJo3QRu264wwLxafSWqXwFtGwyEL
        eOl8owYw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=flying-snail.de; s=s1; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To
        :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=2Ah3M2XYpBYD33vznQiby+cj6OhHC3L8o5U3S39YtlU=; b=mMeZ9l87VHB4RS7IEcuTjopjvF
        r1lFDDgRHxSPZIUbtDAmd8epSCGJHrB46bO+1wi1dbfL5pJCapWufgv8BdEvNa+owVfXZIS4QP0gY
        v75Q+D0UHICHf3qvCwhtwYi1H3xOwX0dRlMH2k4AcrMBFhB2K346Wd9+TETSs8uoU4I1HDtlpq+To
        6gDuYRfrAEI2PRJuHm9OHuTG3lGFcow5D1ls3F+6aldA4aohljW2PZIb9G4DuJHP7iRN4R4eSGSVL
        8jQ3ywtVpBY/3gGENrPWnsvt86Jmhzy2VjIZqJqNwKC5ncbUYx5CbHSvUVXsMdft3admedqRZyou4
        w2txzg9w==;
Received: from [2a02:908:1b0:8800:1400:2ed0:5344:b031] (helo=debian-qemu)
        by mondbasis.internal.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pMC3P-000U3k-Rp; Sun, 29 Jan 2023 19:05:25 +0100
Date:   Sun, 29 Jan 2023 19:05:23 +0100
From:   Andreas Feldner <pelzi@flying-snail.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dht11: Read bit stream from IRQ on falling edges only
Message-ID: <Y9a0RZ+inWs44Kn8@debian-qemu.internal.flying-snail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, IRQs for both falling and raising edges of the GPIO
line connected to the DHT11 device are requested. However, the
low states do not carry information, it is possible to determine
0 and 1 bits from the timing of two adjacent falling edges as
well.

Doing so does no longer requires to read the GPIO line value
within the IRQ handler, plus halves the number of IRQs to be
handled at all.

Signed-off-by: Andreas Feldner <pelzi@flying-snail.de>
---
 drivers/iio/humidity/dht11.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index c97e25448772..d1cd053c5dd4 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -30,13 +30,13 @@
 
 #define DHT11_DATA_VALID_TIME	2000000000  /* 2s in ns */
 
-#define DHT11_EDGES_PREAMBLE 2
+#define DHT11_EDGES_PREAMBLE 1
 #define DHT11_BITS_PER_READ 40
 /*
  * Note that when reading the sensor actually 84 edges are detected, but
  * since the last edge is not significant, we only store 83:
  */
-#define DHT11_EDGES_PER_READ (2 * DHT11_BITS_PER_READ + \
+#define DHT11_EDGES_PER_READ (DHT11_BITS_PER_READ + \
 			      DHT11_EDGES_PREAMBLE + 1)
 
 /*
@@ -46,6 +46,7 @@
  * 1-bit: 68-75uS -- typically 70uS (AM2302)
  * The acutal timings also depend on the properties of the cable, with
  * longer cables typically making pulses shorter.
+ * Low time is constant 50uS.
  *
  * Our decoding depends on the time resolution of the system:
  * timeres > 34uS ... don't know what a 1-tick pulse is
@@ -63,7 +64,8 @@
 #define DHT11_START_TRANSMISSION_MIN	18000  /* us */
 #define DHT11_START_TRANSMISSION_MAX	20000  /* us */
 #define DHT11_MIN_TIMERES	34000  /* ns */
-#define DHT11_THRESHOLD		49000  /* ns */
+#define DHT11_LOW		50000  /* ns */
+#define DHT11_THRESHOLD		(49000 + DHT11_LOW)  /* ns */
 #define DHT11_AMBIG_LOW		23000  /* ns */
 #define DHT11_AMBIG_HIGH	30000  /* ns */
 
@@ -83,7 +85,7 @@ struct dht11 {
 
 	/* num_edges: -1 means "no transmission in progress" */
 	int				num_edges;
-	struct {s64 ts; int value; }	edges[DHT11_EDGES_PER_READ];
+	struct {s64 ts; }	edges[DHT11_EDGES_PER_READ];
 };
 
 #ifdef CONFIG_DYNAMIC_DEBUG
@@ -99,7 +101,7 @@ static void dht11_edges_print(struct dht11 *dht11)
 	for (i = 1; i < dht11->num_edges; ++i) {
 		dev_dbg(dht11->dev, "%d: %lld ns %s\n", i,
 			dht11->edges[i].ts - dht11->edges[i - 1].ts,
-			dht11->edges[i - 1].value ? "high" : "low");
+			"falling");
 	}
 }
 #endif /* CONFIG_DYNAMIC_DEBUG */
@@ -125,14 +127,8 @@ static int dht11_decode(struct dht11 *dht11, int offset)
 	unsigned char temp_int, temp_dec, hum_int, hum_dec, checksum;
 
 	for (i = 0; i < DHT11_BITS_PER_READ; ++i) {
-		t = dht11->edges[offset + 2 * i + 2].ts -
-			dht11->edges[offset + 2 * i + 1].ts;
-		if (!dht11->edges[offset + 2 * i + 1].value) {
-			dev_dbg(dht11->dev,
-				"lost synchronisation at edge %d\n",
-				offset + 2 * i + 1);
-			return -EIO;
-		}
+		t = dht11->edges[offset + i + 1].ts -
+		    dht11->edges[offset + i].ts;
 		bits[i] = t > DHT11_THRESHOLD;
 	}
 
@@ -174,9 +170,7 @@ static irqreturn_t dht11_handle_irq(int irq, void *data)
 	struct dht11 *dht11 = iio_priv(iio);
 
 	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 0) {
-		dht11->edges[dht11->num_edges].ts = ktime_get_boottime_ns();
-		dht11->edges[dht11->num_edges++].value =
-						gpiod_get_value(dht11->gpiod);
+		dht11->edges[dht11->num_edges++].ts = ktime_get_boottime_ns();
 
 		if (dht11->num_edges >= DHT11_EDGES_PER_READ)
 			complete(&dht11->completion);
@@ -224,7 +218,7 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
 			goto err;
 
 		ret = request_irq(dht11->irq, dht11_handle_irq,
-				  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				  IRQF_TRIGGER_FALLING,
 				  iio_dev->name, iio_dev);
 		if (ret)
 			goto err;
-- 
2.30.2

