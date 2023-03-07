Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AB66AE779
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjCGQ6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCGQ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:57:53 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A077C90B65;
        Tue,  7 Mar 2023 08:54:12 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8EDA5C0004;
        Tue,  7 Mar 2023 16:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678208048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=75hjPMNAGJRNOFAp/fyez5Ik1I1pAujO7NUPgauoYjM=;
        b=oJ8WdyTtiPt9WWMz16kTM2WhUvDSZHnxiu7sHpQSkl5i0bNflhYyI//yPMsyOqEa3Ovytc
        ufbJQMzuPs3WMtvOd3ZVr1BIKia1t7Kog777gMDB7EtVZ+CAfs7z5X9+vHXY+v8km0+6rx
        nA+np7No6SxiRdjVnKxKlOzwk+W9hmdi32NaaoVU3F7NJjS96feL2RqRZf8Jna8lAmnKNx
        BneQfPRfZ+ADOFet9i3Zwl//RJO9aLaJqWvOenznN0C0P8CR6xioHfsG69UM7dvENd5DVc
        jlouF4ECATQGEsQFf3Oj1LwNVmyLsqS6sy1Btg1o0GIwmAAJV05py+d3wZQjYw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 01/21] of: Fix modalias string generation
Date:   Tue,  7 Mar 2023 17:53:39 +0100
Message-Id: <20230307165359.225361-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307165359.225361-1-miquel.raynal@bootlin.com>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper generating an OF based modalias (of_device_get_modalias())
works fine, but due to the use of snprintf() internally it needs a
buffer one byte longer than what should be needed just for the entire
string (excluding the '\0'). Most users of this helper are sysfs hooks
providing the modalias string to users. They all provide a PAGE_SIZE
buffer which is way above the number of bytes required to fit the
modalias string and hence do not suffer from this issue.

There is another user though, of_device_request_module(), which is only
called by drivers/usb/common/ulpi.c. This request module function is
faulty, but maybe because in most cases there is an alternative, ULPI
driver users have not noticed it.

In this function, of_device_get_modalias() is called twice. The first
time without buffer just to get the number of bytes required by the
modalias string (excluding the null byte), and a second time, after
buffer allocation, to fill the buffer. The allocation asks for an
additional byte, in order to store the trailing '\0'. However, the
buffer *length* provided to of_device_get_modalias() excludes this extra
byte. The internal use of snprintf() with a length that is exactly the
number of bytes to be written has the effect of using the last available
byte to store a '\0', which then smashes the last character of the
modalias string.

Provide the actual size of the buffer to of_device_get_modalias() to fix
this issue.

Note: the "str[size - 1] = '\0';" line is not really needed as snprintf
will anyway end the string with a null byte, but there is a possibility
that this function might be called on a struct device_node without
compatible, in this case snprintf() would not be executed. So we keep it
just to avoid possible unbounded strings.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Peter Chen <peter.chen@kernel.org>
Fixes: 9c829c097f2f ("of: device: Support loading a module with OF based modalias")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/of/device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index c674a13c3055..877f50379fab 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -297,12 +297,15 @@ int of_device_request_module(struct device *dev)
 	if (size < 0)
 		return size;
 
-	str = kmalloc(size + 1, GFP_KERNEL);
+	/* Reserve an additional byte for the trailing '\0' */
+	size++;
+
+	str = kmalloc(size, GFP_KERNEL);
 	if (!str)
 		return -ENOMEM;
 
 	of_device_get_modalias(dev, str, size);
-	str[size] = '\0';
+	str[size - 1] = '\0';
 	ret = request_module(str);
 	kfree(str);
 
-- 
2.34.1

