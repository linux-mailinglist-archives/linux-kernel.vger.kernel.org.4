Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DECC738AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjFUQUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjFUQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:20:15 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E06510F1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:20:10 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qC0Yx-0016iZ-Av; Wed, 21 Jun 2023 17:20:07 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qC0Yx-001z4S-0H;
        Wed, 21 Jun 2023 17:20:07 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [RFC 1/5] i3c: show error with node for invalid reg property
Date:   Wed, 21 Jun 2023 17:20:01 +0100
Message-Id: <20230621162005.473049-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621162005.473049-1-ben.dooks@codethink.co.uk>
References: <20230621162005.473049-1-ben.dooks@codethink.co.uk>
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

When adding i3c devices via fdt, it is useful to get an error if the
reg node is wrong (say, you thought it was an i2c device and only
needed one value here) and have the error show the OF node which was
the cause of the problem (in case of many devices in the system),

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/i3c/master.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 08aeb69a7800..559fc2781a81 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2094,8 +2094,10 @@ static int of_i3c_master_add_dev(struct i3c_master_controller *master,
 		return -EINVAL;
 
 	ret = of_property_read_u32_array(node, "reg", reg, ARRAY_SIZE(reg));
-	if (ret)
+	if (ret) {
+		dev_err(&master->dev, "%pOF: invalid reg property", node);
 		return ret;
+	}
 
 	/*
 	 * The manufacturer ID can't be 0. If reg[1] == 0 that means we're
-- 
2.40.1

