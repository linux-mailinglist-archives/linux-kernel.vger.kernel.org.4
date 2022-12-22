Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6791765466E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiLVTPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbiLVTPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:15:33 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDB328E38;
        Thu, 22 Dec 2022 11:15:31 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [IPv6:2401:4900:1f3f:d076:4da6:b729:f032:ed0a])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 56073471;
        Thu, 22 Dec 2022 20:15:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671736530;
        bh=bqvMP11pqYGYAC5IZOywqjG3I9GF/0iY9Gg7h2H8QBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tl8lcCTtBojKEuNJ8j+cnCa7NsqslZ/z3PEjsWPTzSUny88AVie/m6bS1/CJfboa4
         yhk8NKmdqAN/+nuzHtsQhOui3SeFIdyhWigmoReRGlfp5e52gmnIvExLyXf5cvh27u
         m+01+akz6BoJrrgkRVYJEjxXAwz10DXh4qkfN1qU=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrien Thierry <athierry@redhat.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 3/4] staging: vchiq: Simplify platform devices registration
Date:   Fri, 23 Dec 2022 00:44:59 +0530
Message-Id: <20221222191500.515795-4-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221222191500.515795-1-umang.jain@ideasonboard.com>
References: <20221222191500.515795-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The child platform devices registered by the vchiq driver currently
populates a struct platform_device_info with a name and parent device
and uses platform_device_register_full() to its registration.

It can be simplified by using platform_device_register_data() directly
(which encapsulates populating the platform_device_info struct and a
platform_device_register_full() call in itself).

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c      | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 3c4766375daa..ba34e4d603d4 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1766,16 +1766,10 @@ MODULE_DEVICE_TABLE(of, vchiq_of_match);
 static struct platform_device *
 vchiq_register_child(struct platform_device *pdev, const char *name)
 {
-	struct platform_device_info pdevinfo;
 	struct platform_device *child;
 
-	memset(&pdevinfo, 0, sizeof(pdevinfo));
-
-	pdevinfo.parent = &pdev->dev;
-	pdevinfo.name = name;
-	pdevinfo.id = PLATFORM_DEVID_NONE;
-
-	child = platform_device_register_full(&pdevinfo);
+	child = platform_device_register_data(&pdev->dev, name, PLATFORM_DEVID_NONE,
+					      NULL, 0);
 	if (IS_ERR(child)) {
 		dev_warn(&pdev->dev, "%s not registered\n", name);
 		platform_device_put(child);
-- 
2.38.1

