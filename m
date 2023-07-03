Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E5E745C83
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjGCMsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjGCMsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:48:38 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746D5E74;
        Mon,  3 Jul 2023 05:48:35 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qGIyn-002Att-GZ; Mon, 03 Jul 2023 13:48:33 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qGIyn-0046ot-0K;
        Mon, 03 Jul 2023 13:48:33 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     lenb@kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] ACPI: fix undeclared variable warnings by including sleep.h
Date:   Mon,  3 Jul 2023 13:48:31 +0100
Message-Id: <20230703124831.979430-1-ben.dooks@codethink.co.uk>
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

There are two pieces of data being exported from drivers/acpi/scan.c
(acpi_device_lock and acpi_wakeup_device_list) that don't have their
definitions declared in anything scan.c is including.

Fix the following sparse warnings by including sleep.h to add the
declarations of acpi_device_lock and acpi_wakeup_device_list to
fix the followng sparse warnings:

drivers/acpi/scan.c:42:1: warning: symbol 'acpi_device_lock' was not declared. Should it be static?
drivers/acpi/scan.c:43:1: warning: symbol 'acpi_wakeup_device_list' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/acpi/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1c3e1e2bb0b5..9556aff69453 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -23,6 +23,7 @@
 #include <linux/dma-direct.h>
 
 #include "internal.h"
+#include "sleep.h"
 
 extern struct acpi_device *acpi_root;
 
-- 
2.40.1

