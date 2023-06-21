Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E08A738AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjFUQUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFUQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:20:15 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE7EE41
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:20:09 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qC0Yw-00CSap-Fg; Wed, 21 Jun 2023 17:20:07 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qC0Yx-001z4X-0O;
        Wed, 21 Jun 2023 17:20:07 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [RFC 2/5] i3c: add error print to show device failing during populate bus
Date:   Wed, 21 Jun 2023 17:20:02 +0100
Message-Id: <20230621162005.473049-3-ben.dooks@codethink.co.uk>
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

The of_populate_i3c_bus() does not produce much helpful output when
a device fails to add, so addd an explicit dev_err() showing the
device node that failed and the error code it failed with. This should
make finding bad device-tree entries easier.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/i3c/master.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 559fc2781a81..6316f3fc914a 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2125,6 +2125,8 @@ static int of_populate_i3c_bus(struct i3c_master_controller *master)
 	for_each_available_child_of_node(i3cbus_np, node) {
 		ret = of_i3c_master_add_dev(master, node);
 		if (ret) {
+			dev_err(dev, "%pOF: failed to add device (%d)\n",
+				node, ret);
 			of_node_put(node);
 			return ret;
 		}
-- 
2.40.1

