Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBD074EA65
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGKJ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjGKJ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:26:41 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37D410C3;
        Tue, 11 Jul 2023 02:22:48 -0700 (PDT)
Received: from 82-132-229-125.dab.02.net ([82.132.229.125] helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qJ9a2-007IDs-Qa; Tue, 11 Jul 2023 10:22:46 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qJ9a1-0005rY-1a;
        Tue, 11 Jul 2023 10:22:45 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     nvdimm@lists.linux.dev
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] ACPI: NFIT: limit string attribute write
Date:   Tue, 11 Jul 2023 10:22:44 +0100
Message-Id: <20230711092244.22527-1-ben.dooks@codethink.co.uk>
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

If we're writing what could be an arbitrary sized string into an attribute
we should probably use sysfs_emit() just to be safe. Most of the other
attriubtes are some sort of integer so unlikely to be an issue so not
altered at this time.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
v2:
  - use sysfs_emit() instead of snprintf.
---
 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 9213b426b125..d7e9d9cd16d2 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1579,7 +1579,7 @@ static ssize_t id_show(struct device *dev,
 {
 	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
 
-	return sprintf(buf, "%s\n", nfit_mem->id);
+	return snprintf(buf, PAGE_SIZE, "%s\n", nfit_mem->id);
 }
 static DEVICE_ATTR_RO(id);
 
-- 
2.40.1

