Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1712A6A7547
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCAU2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCAU17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:27:59 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB8AEB7D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1677702473; bh=QgZkwG2KJaskVSRysFIed9zv+7/Cb+p1bNFgkMQ4mcc=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=kkl6+nMBxZfQJEUfSXyYBFs2usQ/Tvn00Rs9paf84JZpjq/EYSLvjajxrePRJ+W06
         tvUrH0IreHuhhg2k/i4pXDRRRZkwKJSHGdxEQdbtb+jgNGNbi7o+8E9H5CwPf9gSjP
         7sgBJdc2yA3hUWJFIjpIoIo+rg2aoaQQyJMNVB8E=
Received: by b221-2.in.mailobj.net [192.168.90.22] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Wed,  1 Mar 2023 21:27:53 +0100 (CET)
X-EA-Auth: R7+3+1I5KkV/6Upk1NJ/PVVMvhlx+h3G2Swayr51HNxGFuQWV9jwEpye02f5r0pQ5K+XoAbwT1C0fRkMUOeZSg==
Date:   Thu, 2 Mar 2023 01:57:48 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH RESEND] w1: Use kfree_sensitive to clear sensitive information
Message-ID: <Y/+1RJI6skwV814r@ubun2204.myguest.virtualbox.org>
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
Note:
   - proposed change is compile tested only.
   - Resending the patch for review and feedback. Initially sent on Dec 23 2022.

 drivers/w1/w1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 9d199fed9628..0241fc6ca65a 100644
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



