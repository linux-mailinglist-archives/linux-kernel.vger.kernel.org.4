Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C27869B19C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 18:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBQRLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 12:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBQRLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:11:14 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAF76ABFF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 09:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676653855; bh=1lHaTXrcGvk9qzJbf3HZv/4v4UAIzF/XJctBCsi93EU=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=cZK2uMz855tfXzoCdGS6KD19K0Iyo5OQUqBIp8rlzR8N+HIyG4+qT5L6pKdqKyQCH
         L7J83ArjGOWY+xAypD+ikuq9KcziVgfcbHQKqV2NApKLpJ2Yj+AekfJ1T5BJ8uV4g6
         lYZ9ZU/QPVe7WV/uBeIwl8vol9SC204+KBOx97/c=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 17 Feb 2023 18:10:55 +0100 (CET)
X-EA-Auth: 95fLD2RuWA+XCYTLFGyfARPmdWcBY3bcSw4kET3KnsvoY7D824dypTu6jXXxHfxxEry6KfPKbpCXSjrXN2fBSelkNN9EVdLg
Date:   Fri, 17 Feb 2023 22:40:49 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] arch/arm/l2x0: Use sysfs_emit() in show() callback function
Message-ID: <Y++1GSKNZnyqhUFN@ubun2204.myguest.virtualbox.org>
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

Using sprintf/snprintf functions are error prone and suggested to be
replaced by scnprintf/vscnrptintf as outlined in this [1] LWN article.

A more recent recommendation is to use sysfs_emit() or sysfs_emit_at()
as per Documentation/filesystems/sysfs.rst in show() callback function
when formatting values to be returned to user-space. These helper
functions are PAGE_SIZE aware and wrap a safer call to vscnprintf().

[1] https://lwn.net/Articles/69419/

Issue identified using the coccinelle device_attr_show.cocci script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Please note:
   1. Change compile tested using sama7_defconfig
   2. The driver name in the patch subject is best derived out of the 5 unique
      names available for the current committed patches. If this is incorrect,
      please suggest what it should be set to.


 arch/arm/mm/cache-l2x0-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
index 993fefdc167a..a9bd05b82003 100644
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -343,7 +343,7 @@ static ssize_t l2x0_pmu_event_show(struct device *dev,
 	struct l2x0_event_attribute *lattr;
 
 	lattr = container_of(attr, typeof(*lattr), attr);
-	return snprintf(buf, PAGE_SIZE, "config=0x%x\n", lattr->config);
+	return sysfs_emit(buf, "config=0x%x\n", lattr->config);
 }
 
 static umode_t l2x0_pmu_event_attr_is_visible(struct kobject *kobj,
-- 
2.34.1



