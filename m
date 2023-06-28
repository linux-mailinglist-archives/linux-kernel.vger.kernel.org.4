Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452BD740C13
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbjF1I6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbjF1Ip6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:45:58 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06973580
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:37:52 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-172-149.tukw.qwest.net [174.21.172.149])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 44A4B31E;
        Wed, 28 Jun 2023 01:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1687941472;
        bh=rOzvsgROD/f26mzOAzvMUcVNNF4sR/rHxdezjOWfqto=;
        h=From:To:Cc:Subject:Date:From;
        b=Y9TP19DNIpS58C1xU+PXyja7lpGsJHv/rWufUqAu1Dy5pWUE0Cx8FhMUMIb9uM9z4
         gG3VdzvIgNFNW053bC2RVxS3b5BpZM9aAhA1W+f0ovQ7M2UB4O/Tw0uRl97/5Y9CMb
         s2xjM0PkvW+JSP4XxtYyKQgSHq2PHFjQ5kQ7lkYg=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
        linux-aspeed@lists.ozlabs.org
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        Oskar Senft <osk@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH] soc: aspeed: uart-routing: Use __sysfs_match_string
Date:   Wed, 28 Jun 2023 01:37:36 -0700
Message-ID: <20230628083735.19946-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing use of match_string() caused it to reject 'echo foo' due
to the implicitly appended newline, which was somewhat ergonomically
awkward and inconsistent with typical sysfs behavior.  Using the
__sysfs_* variant instead provides more convenient and consistent
linefeed-agnostic behavior.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/soc/aspeed/aspeed-uart-routing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/aspeed/aspeed-uart-routing.c b/drivers/soc/aspeed/aspeed-uart-routing.c
index ef8b24fd1851..59123e1f27ac 100644
--- a/drivers/soc/aspeed/aspeed-uart-routing.c
+++ b/drivers/soc/aspeed/aspeed-uart-routing.c
@@ -524,7 +524,7 @@ static ssize_t aspeed_uart_routing_store(struct device *dev,
 	struct aspeed_uart_routing_selector *sel = to_routing_selector(attr);
 	int val;
 
-	val = match_string(sel->options, -1, buf);
+	val = __sysfs_match_string(sel->options, -1, buf);
 	if (val < 0) {
 		dev_err(dev, "invalid value \"%s\"\n", buf);
 		return -EINVAL;
-- 
2.40.0.5.gf6e3b97ba6d2.dirty

