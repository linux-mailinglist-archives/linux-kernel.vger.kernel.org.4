Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D545267C985
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbjAZLL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbjAZLLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:11:53 -0500
Received: from smtpweb146.aruba.it (smtpweb146.aruba.it [62.149.158.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9291763853
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:11:18 -0800 (PST)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id KzrppyQ5bn7VrKzrspdlp8; Thu, 26 Jan 2023 11:52:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1674730353; bh=j13KKIJM6fFKosjFnovvgyqOUFOoD8QPhU4cG+FAZMI=;
        h=From:To:Subject:Date:MIME-Version;
        b=mAmqc8KP+o2c6Fy9qMAEg4cY9eYB/bhoxSEUVuK1B0Gahe6ZkdrJI2v924g8k7onr
         oKbcfUPTcmK4+LoMGo15+gK/TJ8DcVIBWfhnEb7nB3raGvtq+7Oj8L/idX9YfT2Jkz
         +6dvjnlnsdLj2xD3TyO7OxZvbucmh7XsIeWmd7l6Xij+R8k4IfOHORDAQ3ZMKkMnyj
         Ze61iwZ3oBTijtUTieUHHmmk9jwqv3Im7NqHY7vLwBkvwM2h0bdjrL7lBh30OZgNoQ
         AtDhNVoTdW5xJnO0SJPRtoDbwQMRqrVJcJtVMgh0lUGRtt0/OySIV8GyjjQN3LIz2j
         AfHO7+g5OpsEg==
From:   Luca Ellero <l.ellero@asem.it>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH 1/3] Input: ads7846 - don't report pressure for ads7845
Date:   Thu, 26 Jan 2023 11:52:25 +0100
Message-Id: <20230126105227.47648-2-l.ellero@asem.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230126105227.47648-1-l.ellero@asem.it>
References: <20230126105227.47648-1-l.ellero@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDOQITVe5HdccN8ZR7js8LsXxDXfRRRw3BoVo61j0dBfmGWMLnQShJQUqk7l2JrYX3VpXhOiMs57ly0R+i3Gp6liuLXKW55xuGWNA0EDwPqoQlspu9hy
 G6QDM7ooc0tN39LOWKVFJ88zmjd1J49NgjJ4pngmVSoxGYamRo6pgHZVPVxZYvnmhe4GmF7iIjksSbZ3yVMf4EbdAgY9p+Q4UoNtv/Joa56wYbJDzdSEpO1W
 QZjjv4U5hOj3nv4Dpvn0/iaa1Pkh8JRd+hFA+J4rC868YFiHzuQj7yDxJ2ai7gJ8Vh1RRMPcirUYWTr91CXqC5FeJQU42gGTozACaG3z5/fof+l0mmU3AA1K
 XBWWBunJ3WkpXdk+Y6VPMHHojINGWkPUIuQXs3zDYftYjBkXYPxe28RlDpfYjP87SI/8ZdPbEyPRKvWQSiYOh2EnFo3ls9wbamuAdCjWcmpINqsZQkTRn+qW
 BJMb2Nw5by6rOWLQIhraBL/3c7IIdRAxIpGNTnEU9bK0rMrHhQdj+OvbjAIW1UQBhDE8TDvv96YoFF8OH+ckXZVK/6BLFcFLDAcNiA0EY5Dse5YwLD9/+mQf
 wAsJFD7HDN7YkFyKIpqdauf/
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADS7845 doesn't support pressure.
Avoid the following error reported by libinput-list-devices:
"ADS7845 Touchscreen: kernel bug: device has min == max on ABS_PRESSURE".

Fixes: ffa458c1bd9b ("spi: ads7846 driver")
Signed-off-by: Luca Ellero <l.ellero@asem.it>
---
 drivers/input/touchscreen/ads7846.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4c3dd01902d0..f11b444f2138 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1316,8 +1316,9 @@ static int ads7846_probe(struct spi_device *spi)
 			pdata->y_min ? : 0,
 			pdata->y_max ? : MAX_12BIT,
 			0, 0);
-	input_set_abs_params(input_dev, ABS_PRESSURE,
-			pdata->pressure_min, pdata->pressure_max, 0, 0);
+	if (ts->model != 7845)
+		input_set_abs_params(input_dev, ABS_PRESSURE,
+				pdata->pressure_min, pdata->pressure_max, 0, 0);
 
 	/*
 	 * Parse common framework properties. Must be done here to ensure the
-- 
2.25.1

