Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9B065C2ED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbjACPW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjACPWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:22:22 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA303114C;
        Tue,  3 Jan 2023 07:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1672759339;
  x=1704295339;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nEIJiYZMrbyuP65czJYAOsZx1ZHYrqm7oFjfuWZFZZg=;
  b=SgEEPSk0A8+UIzR4KAIKDa9EjvU4vPc3pPn2X/C2vboxk9oGQQyTG+of
   B1qB3blALxiZ6Q2aBJNBoVONP7Kxgh8V1X6nhhp0LNabAW27oQ79kktXT
   cqk6C/9lV6UA8FalWbtZZO7eXjwbI7aq/BkNx0Au/GB/wYpADkBa6exKc
   f96FR0MVUG6mZdVFjPZPinGZLeUOa9l7tuqjAkh0/gSsRym08UJJXwZ1l
   q+7OOGw7Kg4Ffg7nUT8GX+J+mBedfEkdYZsFZjWakQzGRZWujgVcBSoxJ
   iDroJqV4Fc9ewObEpjNXZjNNKTHc4fnYjIHWk/nRjxjqQufE31olzuEqX
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: spi-loopback-test: Allow skipping delays
Date:   Tue, 3 Jan 2023 16:22:10 +0100
Message-ID: <20230103152211.3034779-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A 100 ms delay is inserted between tests by default in order to "detect
the individual tests when using a logic analyzer".  However, such delays
are unnecessary when using this module for automated regression testing,
so allow them to be disabled with a module parameter.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/spi/spi-loopback-test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index dd7de8fa37d0..313106eb8d40 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -71,6 +71,11 @@ module_param(check_ranges, int, 0644);
 MODULE_PARM_DESC(check_ranges,
 		 "checks rx_buffer pattern are valid");
 
+static unsigned int delay_ms = 100;
+module_param(delay_ms, uint, 0644);
+MODULE_PARM_DESC(delay_ms,
+		 "delay between tests, in milliseconds (default: 100)");
+
 /* the actual tests to execute */
 static struct spi_test spi_tests[] = {
 	{
@@ -1098,7 +1103,8 @@ int spi_test_run_tests(struct spi_device *spi,
 		 * detect the individual tests when using a logic analyzer
 		 * we also add scheduling to avoid potential spi_timeouts...
 		 */
-		mdelay(100);
+		if (delay_ms)
+			mdelay(delay_ms);
 		schedule();
 	}
 
-- 
2.34.1

