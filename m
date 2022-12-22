Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096B465489E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 23:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiLVWjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 17:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbiLVWjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 17:39:33 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB9EA45A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 14:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671748768; bh=z8J0zWp2xScShPwwVbxBi7EfLHWTA83YkulZZUzCqCQ=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=aFgIbMQuvk47ps7/6m0SiLneAD6PXfeS8OXXpWTad9L2GZueB95X/dylAKf6RmlVd
         UchTzqfQ4ZhkRRZG2NUL1Llh1UBkXW41H2NSciMfBk16iA5uIxmUET1Sv19KC7T393
         kFYlKe+CrwjdYeAR5WyXOrYC/d3w/Uhw3rWVrf8c=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Thu, 22 Dec 2022 23:39:27 +0100 (CET)
X-EA-Auth: +78mYshc1jvuTVNaSX5oSe5ppaMTDLnPHSBg/6O+0Uud39gcRigBQlR58ttQMV+b52Zi9yOXgzdg46jT2cnOtwo3GGkxzO5I
Date:   Fri, 23 Dec 2022 04:09:22 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: [PATCH] w1: Use kfree_sensitive to clear sensitive information
Message-ID: <Y6TcmtlRvvblvL2f@qemulion>
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

Replace combination of 'memset(0) + kfree()' by kfree_sensitive() as it
prevents compiler from optimizing away from zeroing out memory at the
end of a scope. kfree_sensitive() is also safe in case the memory
pointer turns out to be null, which simply gets ignored.

Issue identified using kfree_sensitive.cocci coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Note: proposed change is compile tested only.

 drivers/w1/w1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index f2ae2e563dc5..e08467e08b73 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -73,8 +73,7 @@ static void w1_master_release(struct device *dev)
 	struct w1_master *md = dev_to_w1_master(dev);

 	dev_dbg(dev, "%s: Releasing %s.\n", __func__, md->name);
-	memset(md, 0, sizeof(struct w1_master) + sizeof(struct w1_bus_master));
-	kfree(md);
+	kfree_sensitive(md);
 }

 static void w1_slave_release(struct device *dev)
@@ -805,9 +804,10 @@ int w1_unref_slave(struct w1_slave *sl)
 		w1_family_notify(BUS_NOTIFY_DEL_DEVICE, sl);
 		device_unregister(&sl->dev);
 		#ifdef DEBUG
-		memset(sl, 0, sizeof(*sl));
-		#endif
+		kfree_sensitive(sl);
+		#else
 		kfree(sl);
+		#endif
 	}
 	atomic_dec(&dev->refcnt);
 	mutex_unlock(&dev->list_mutex);
--
2.34.1



