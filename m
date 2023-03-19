Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513B46BFF4A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 05:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCSEUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 00:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjCSEUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 00:20:37 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 783D9222CC;
        Sat, 18 Mar 2023 21:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=IP8Op
        5NYAZpLD4TuJdEpRPmgpBXAldqWHpEXpQ6dDHs=; b=ODawpGsdlI2arK2+moZRm
        GWo/R8/X7bIPTDnsTdcVzOIhHWExIgOknlYc6+8REYoAWuSkNGqkVLardOn5M0N1
        z6umcmRbRDpD5qZ1fjlO9CXZ7SFADW6Cv7XZznYZGgaZPWp8+tstT+b9CI0F4ubW
        o2Mk0o/J0dyQLYJXlwpA1U=
Received: from lizhe.. (unknown [120.245.132.192])
        by zwqz-smtp-mta-g3-4 (Coremail) with SMTP id _____wCHx69ejRZkU1WuAQ--.31804S4;
        Sun, 19 Mar 2023 12:20:18 +0800 (CST)
From:   Lizhe <sensor1010@163.com>
To:     akrowiak@linux.ibm.com, pasic@linux.ibm.com, jjherne@linux.ibm.com,
        freude@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhe <sensor1010@163.com>
Subject: [PATCH v1] s390/vfio-ap-drv: Remove redundant driver match function
Date:   Sun, 19 Mar 2023 12:19:41 +0800
Message-Id: <20230319041941.259830-1-sensor1010@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHx69ejRZkU1WuAQ--.31804S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4UtFy8tF15GF4UXr4DXFb_yoWDXrX_C3
        y8Xrn7Wr1j9w1fta48XrW7Z3sF9w4kXFZagrsYq3sag3W7Jr1DuFZF9rnrW34jqrW7Aa9x
        W3yUJr40yr12gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKSdyUUUUUU==
X-Originating-IP: [120.245.132.192]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBogk3q1aEHrmpOgAAsR
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no driver match function, the driver core assumes that each
candidate pair (driver, device) matches, see driver_match_device().

Drop the matrix bus's match function that always returned 1 and so 
implements the same behaviour as when there is no match function

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 997b524bdd2b..9341c000da41 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -59,14 +59,8 @@ static void vfio_ap_matrix_dev_release(struct device *dev)
 	kfree(matrix_dev);
 }
 
-static int matrix_bus_match(struct device *dev, struct device_driver *drv)
-{
-	return 1;
-}
-
 static struct bus_type matrix_bus = {
 	.name = "matrix",
-	.match = &matrix_bus_match,
 };
 
 static struct device_driver matrix_driver = {
-- 
2.34.1

