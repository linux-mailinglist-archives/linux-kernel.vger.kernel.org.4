Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD65738AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjFUQUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjFUQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:20:15 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC324E69
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:20:09 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qC0Yw-00CSaq-JA; Wed, 21 Jun 2023 17:20:07 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qC0Yx-001z4c-0U;
        Wed, 21 Jun 2023 17:20:07 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [RFC 3/5] i3c: show node when printing unsupported 10-bit i2c dev
Date:   Wed, 21 Jun 2023 17:20:03 +0100
Message-Id: <20230621162005.473049-4-ben.dooks@codethink.co.uk>
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

When an i2c device is errored due to not being supported, the OF node
is not show (unlike errors from of_i2c_get_board_info). Make the failed
node explict in the of_i3c_master_add_i2c_boardinfo() to aid in tracking
down incorrect entries in the device tree.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/i3c/master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 6316f3fc914a..bc42669f5c6d 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2023,7 +2023,7 @@ of_i3c_master_add_i2c_boardinfo(struct i3c_master_controller *master,
 	 * DEFSLVS command.
 	 */
 	if (boardinfo->base.flags & I2C_CLIENT_TEN) {
-		dev_err(dev, "I2C device with 10 bit address not supported.");
+		dev_err(dev, "%pOF: I2C device with 10 bit address not supported.", node);
 		return -ENOTSUPP;
 	}
 
-- 
2.40.1

