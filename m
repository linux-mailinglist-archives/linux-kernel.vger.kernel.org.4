Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE9967EAF7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjA0QcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbjA0QcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:32:11 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F0F7D6F2;
        Fri, 27 Jan 2023 08:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674837114; bh=vj4kVhLtQ+dIiXMCosovvjgWH9gdE7UHMs5WyPLi7GM=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=SUTL06j6soeiTZPjxv0txpD3o/EjY67wNH/yoRpD6SnydFK0jB+ijGn95wF/ppfAT
         7WotvE+TODNm1WrMOZFHoImjlR520tha+re3AZKNeFKiOI2b6hLsDaXR97nBIpG2Wh
         at/8inswS960IQ8DxeQcYZ2/COEQLJ5d5Srd98Yc=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 27 Jan 2023 17:31:54 +0100 (CET)
X-EA-Auth: tyf9JgDjzN3rfr5CP8gcpmNTaF1BMh6woDDK9QoGkJQoCiklXKtXjoqg8earvIT8+DO+4t/LrVfQlV1h48bQjnn0vdoq/KMr
Date:   Fri, 27 Jan 2023 22:01:49 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH] platform/x86: dell-smo8800: Use min_t() for comparison and
 assignment
Message-ID: <Y9P8debIztOZXazW@ubun2204.myguest.virtualbox.org>
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

Simplify code by using min_t helper macro for logical evaluation
and value assignment. Use the _t variant of min macro since the
variable types are not same.
This issue is identified by coccicheck using the minmax.cocci file.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/platform/x86/dell/dell-smo8800.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-smo8800.c b/drivers/platform/x86/dell/dell-smo8800.c
index 3385e852104c..8d6b7a83cf24 100644
--- a/drivers/platform/x86/dell/dell-smo8800.c
+++ b/drivers/platform/x86/dell/dell-smo8800.c
@@ -67,10 +67,7 @@ static ssize_t smo8800_misc_read(struct file *file, char __user *buf,
 
 	retval = 1;
 
-	if (data < 255)
-		byte_data = data;
-	else
-		byte_data = 255;
+	byte_data = min_t(u32, data, 255);
 
 	if (put_user(byte_data, buf))
 		retval = -EFAULT;
-- 
2.34.1



