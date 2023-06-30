Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486B67435A9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjF3HTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjF3HS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:18:58 -0400
Received: from smtpcmd12131.aruba.it (smtpcmd12131.aruba.it [62.149.156.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013F01BDB
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 00:18:56 -0700 (PDT)
Received: from polimar.homenet.telecomitalia.it ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id F8P2qe5pmwtegF8PAqinFy; Fri, 30 Jun 2023 09:18:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1688109536; bh=QcsExrNJ6u1tiwlvDyvY9CDAytYAHUcGn+MfPz/pR+M=;
        h=From:To:Subject:Date:MIME-Version;
        b=UN5RMAXkMviYnp4jYmmiMtNiGPPtedCJdjUMe2Ej4XT4YDqTxeseIAB1U4IeM41fK
         MvDwYgL+2+9eYCWALRY4Xy8sTL4fdhgtinJSVIZ9eIJ1INOwpQb6d1U2uuC/nsm0u6
         qhIH6w6fkMO/PZBUAcgIoEfjeMU5fMNxPTWVhNIa8IOgj8XSuhsD6YHVWaB/80lwX+
         th5Rmm9bWhS+dvQh18yrgxergV5MNowvQNxbDLNasVjDi3fbjkCcmtvusq4Ac3u2G0
         d4H8zr8EzObwBsOshfwbMvUaVbIx4oFNDe2HsRzK5O4bS0odj3IwFl1oEjXiNIg1xV
         GephMKN94FF6A==
From:   Rodolfo Giometti <giometti@enneenne.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rodolfo Giometti <giometti@enneenne.com>
Subject: [PATCH 2/2] include/uapi pps.h: drop not needed PPS_MAX_SOURCES define
Date:   Fri, 30 Jun 2023 09:18:26 +0200
Message-Id: <20230630071826.105501-2-giometti@enneenne.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630071826.105501-1-giometti@enneenne.com>
References: <20230630071826.105501-1-giometti@enneenne.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEKXjkKELrLkuV21oCJBEGONFsFIcn/35iHv7RHB6PVXRFxSfWMKWwHLolc88Ky7whnKEmwZVxVcyv2EZ3vOt7ciRgBmxCA2yGmnURGFEKrbSKOyjkxp
 GLyV6wTzwvj+L85OKaqiosjgUVD9TID+V9Ea9WLYbOO1nlTxfZ0UQ+hfZ9diJ0yIRSQ10aKT/gHX/LWUIHoddVIPPK2GNTJKeU1MbFSkWRvX8yN9ZjASp3bq
 4Ks3PdGZiwGlUdYteuQz8m/SDOswsWVbCO83Tg+4y8UzvLmdUK0QorZnl+6lSbDy
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace PPS clients should not known about how many PPS sources can
be defined within the system (nor the rfc2783 say so), so we can
safely drop this define since is not used anymore in the kernel too.

Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
---
 drivers/pps/pps.c        | 6 +++---
 include/uapi/linux/pps.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 5d19baae6a38..1a6131608036 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -354,7 +354,7 @@ int pps_register_cdev(struct pps_device *pps)
 	 * Get new ID for the new PPS source.  After idr_alloc() calling
 	 * the new source will be freely available into the kernel.
 	 */
-	err = idr_alloc(&pps_idr, pps, 0, PPS_MAX_SOURCES, GFP_KERNEL);
+	err = idr_alloc(&pps_idr, pps, 0, MINORMASK, GFP_KERNEL);
 	if (err < 0) {
 		if (err == -ENOSPC) {
 			pr_err("%s: too many PPS sources in the system\n",
@@ -449,7 +449,7 @@ EXPORT_SYMBOL(pps_lookup_dev);
 static void __exit pps_exit(void)
 {
 	class_destroy(pps_class);
-	unregister_chrdev_region(pps_devt, PPS_MAX_SOURCES);
+	unregister_chrdev_region(pps_devt, MINORMASK);
 }
 
 static int __init pps_init(void)
@@ -463,7 +463,7 @@ static int __init pps_init(void)
 	}
 	pps_class->dev_groups = pps_groups;
 
-	err = alloc_chrdev_region(&pps_devt, 0, PPS_MAX_SOURCES, "pps");
+	err = alloc_chrdev_region(&pps_devt, 0, MINORMASK, "pps");
 	if (err < 0) {
 		pr_err("failed to allocate char device region\n");
 		goto remove_class;
diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
index 90f2e86020ba..8a4096f18af1 100644
--- a/include/uapi/linux/pps.h
+++ b/include/uapi/linux/pps.h
@@ -26,7 +26,6 @@
 #include <linux/types.h>
 
 #define PPS_VERSION		"5.3.6"
-#define PPS_MAX_SOURCES		MINORMASK
 
 /* Implementation note: the logical states ``assert'' and ``clear''
  * are implemented in terms of the chip register, i.e. ``assert''
-- 
2.34.1

