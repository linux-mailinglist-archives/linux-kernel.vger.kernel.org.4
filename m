Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580FE69325B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBKQPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBKQPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:15:06 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0857714229
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 08:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676132094; bh=obYcn7IR8jiFOnVOs2E2wFw+fR1SLSLMq4/1K3z69X4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=oS34WFIbPmdtwukzDrKYA05mX11v2hcFZ1uKoT1IPvEKVUgFNWtJCDuMgLwelhGhb
         rFlDgh+toN3u7qNGr78AfjjpSIIOSNeFDM/tCs01lu5H1bzhhGxSDLi6lH47c07FRM
         WWKgFmUv+HmAl48/a4+eRe7ZpOPbPFRYH75YpAdE=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 11 Feb 2023 17:14:54 +0100 (CET)
X-EA-Auth: tlLZDsFUGZ7clccaOzAbomGIsQ5H42fX/+AxviRK7WQFaJZ3026U9tqRI3JQp5e5tLx1JvjfwWY7toesuDhX1LbqiIXqNVYe
Date:   Sat, 11 Feb 2023 21:44:47 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] soc: dove: release node before breaking child_of_node loop
Message-ID: <Y+e+90hi6KwoB/xh@ubun2204.myguest.virtualbox.org>
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

The iterator for_each_available_child_of_node() increments the refcount
of the child node it is processing. Release such a reference when the
loop needs to break due to an error during its execution.
Issue identified using for_each_child.cocci Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Please note: The proposed change is compile tested only. I do not have the
necessary hardware to perform additional testing. Please suggest if there is an
alternate means available to further test this change.
 drivers/soc/dove/pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
index ffc5311c0ed8..6202dbcd20a8 100644
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -410,13 +410,16 @@ int __init dove_init_pmu(void)
 		struct pmu_domain *domain;
 
 		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
-		if (!domain)
+		if (!domain) {
+			of_node_put(np);
 			break;
+		}
 
 		domain->pmu = pmu;
 		domain->base.name = kasprintf(GFP_KERNEL, "%pOFn", np);
 		if (!domain->base.name) {
 			kfree(domain);
+			of_node_put(np);
 			break;
 		}
 
-- 
2.34.1



