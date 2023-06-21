Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DB9738B46
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjFUQcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjFUQcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:32:19 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00230268E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:31:46 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qC0jL-00CSw4-Jo; Wed, 21 Jun 2023 17:30:52 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qC0jM-0020GX-0U;
        Wed, 21 Jun 2023 17:30:52 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] devres: show which resource was invalid in __devm_ioremap_resource()
Date:   Wed, 21 Jun 2023 17:30:50 +0100
Message-Id: <20230621163050.477668-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The other error prints in this call show the resource which wsan't
valid, so add this to the first print when it checks for basic validity
of the resource.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 lib/devres.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/devres.c b/lib/devres.c
index 6baf43902ead..c44f104b58d5 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -129,7 +129,7 @@ __devm_ioremap_resource(struct device *dev, const struct resource *res,
 	BUG_ON(!dev);
 
 	if (!res || resource_type(res) != IORESOURCE_MEM) {
-		dev_err(dev, "invalid resource\n");
+		dev_err(dev, "invalid resource %pR\n", res);
 		return IOMEM_ERR_PTR(-EINVAL);
 	}
 
-- 
2.40.1

