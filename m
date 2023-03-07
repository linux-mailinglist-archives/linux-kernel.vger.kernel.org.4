Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B0A6AE78F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjCGQ66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjCGQ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:58:05 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E002F900A5;
        Tue,  7 Mar 2023 08:54:28 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2BD08C000F;
        Tue,  7 Mar 2023 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678208067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GmTz13SaF5QA5tI3kF6niArbxNcTvsMZc/5y93yP4pU=;
        b=guy91AfPPHcEdsQm5speMhqIIjA3cVdkn/sunDG4mZh70pke94GGIcreq5jYCcNQMuog7v
        ymVqv2XSgLeE2e3sCoohDJ6fJASQA0i9GYbU2r4lbR6X0/4SoSpzBhSh0iJUhv7c/pMxpW
        eblBWFo2qHb9F3ioEDoAgt902vlPXIWwc37cA7i4L89Cj/PFR4laicB2qyih2X3ZK1YUC+
        BMyPH2+HIZSTZBPkAm1S4J5rk0rEOp5nDiVZGgeQTOUOHyVA7ov3lMcKPXsFPQi8+OGBQZ
        Yy/tSl0gVRzhpa/ibBPHvvPKWl23k3THWbx5h3YyLDg4FwWEmdDnt90r+GdSaA==
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
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v2 06/21] usb: ulpi: Use of_request_module()
Date:   Tue,  7 Mar 2023 17:53:44 +0100
Message-Id: <20230307165359.225361-7-miquel.raynal@bootlin.com>
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

There is a new helper supposed to replace of_device_request_module(),
called of_request_module(). They are both strictly equivalent, besides
the fact the latter receives a "struct device_node" directly. Use it.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/usb/common/ulpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 60e8174686a1..6a2b69642e83 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -229,7 +229,7 @@ static int ulpi_read_id(struct ulpi *ulpi)
 	request_module("ulpi:v%04xp%04x", ulpi->id.vendor, ulpi->id.product);
 	return 0;
 err:
-	of_device_request_module(&ulpi->dev);
+	of_request_module(ulpi->dev.of_node);
 	return 0;
 }
 
-- 
2.34.1

