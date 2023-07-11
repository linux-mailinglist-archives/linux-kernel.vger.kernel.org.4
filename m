Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF5D74EACB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjGKJhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjGKJh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:37:28 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C571A2;
        Tue, 11 Jul 2023 02:37:15 -0700 (PDT)
Received: from [134.238.52.102] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qJ9o0-00BpMC-Q6; Tue, 11 Jul 2023 10:37:12 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qJ9nx-0006AL-2p;
        Tue, 11 Jul 2023 10:37:09 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     nvdimm@lists.linux.dev
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH v2] ACPI: NFIT: limit string attribute write
Date:   Tue, 11 Jul 2023 10:37:08 +0100
Message-Id: <20230711093708.23692-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

