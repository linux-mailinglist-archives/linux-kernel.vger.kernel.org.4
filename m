Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563436547E3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 22:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiLVVcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 16:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiLVVcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 16:32:50 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D6C220D5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 13:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671744745; bh=m5A13CbMy20Q47cLnzC6Fb6fhQStUuVBXbSnoheidMw=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=jo2h4mRhgABlqJVSOkh+AOYw9YgnQ62n/FQwXqdp57JOm0M48hS8t6NQlWTPPUfm0
         SOJLBfq3qg0V28fYH2R+SKutRUdw1NgJSJ4NYRZ7OiePtV2Z4qgryFuk6U4kmed1js
         k6RF3Y/ONgGqU5KIliHlJEmgC4JWsYl+U4UCTY+k=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Thu, 22 Dec 2022 22:32:25 +0100 (CET)
X-EA-Auth: tNs3jUzJmrB1wishT6YQd/hDpbc92I55S2KpqxvBARFKBIIUugaz6hFy61mU3PncJY/3szve5aMOVJKIR1WPju0/Ks6Qpq+y
Date:   Fri, 23 Dec 2022 03:02:17 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: [PATCH] soc: loongson: use resource_size() helper function
Message-ID: <Y6TM4ZidDExh8SPx@qemulion>
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

Use the resource_size() function instead of a open coded computation
resource size. It makes the code more readable.

Issue identified using resource_size.cocci coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Note: Proposed change is compile tested only.

 drivers/soc/loongson/loongson2_guts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/loongson/loongson2_guts.c b/drivers/soc/loongson/loongson2_guts.c
index bace4bc8e03b..aba4f8832805 100644
--- a/drivers/soc/loongson/loongson2_guts.c
+++ b/drivers/soc/loongson/loongson2_guts.c
@@ -107,7 +107,7 @@ static int loongson2_guts_probe(struct platform_device *pdev)
 	guts->little_endian = of_property_read_bool(np, "little-endian");

 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	guts->regs = ioremap(res->start, res->end - res->start + 1);
+	guts->regs = ioremap(res->start, resource_size(res));
 	if (IS_ERR(guts->regs))
 		return PTR_ERR(guts->regs);

--
2.34.1



