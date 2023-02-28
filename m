Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E06F6A5E5B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 18:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjB1Rke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 12:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB1Rkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:40:31 -0500
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDD7EB48;
        Tue, 28 Feb 2023 09:40:30 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.109.146.223])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id D1E9B20D60;
        Tue, 28 Feb 2023 17:40:28 +0000 (UTC)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 28 Feb
 2023 18:40:28 +0100
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <saravanak@google.com>
CC:     <gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jean Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [PATCH] of: property: Add missing of_node_get() in parse_interrupt()
Date:   Tue, 28 Feb 2023 18:40:19 +0100
Message-ID: <20230228174019.4004581-1-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG4EX2.emp2.local (172.16.2.32) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 4362862141621811675
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudelfedggedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfgtihesthekredtredttdenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepjeeuhfeklefghfelhfethfegkedtvedvgfekledtheegueejuedtheekuefhffdtnecukfhppeduvdejrddtrddtrddupdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehrohgshhdoughtsehkvghrnhgvlhdrohhrghdpfhhrohifrghnugdrlhhishhtsehgmhgrihhlrdgtohhmpdhsrghrrghvrghnrghksehgohhoghhlvgdrtghomhdpghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmoh
 ehvdekpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean Jacques Hiblot <jjhiblot@traphandler.com>

As all the other parsers do, parse_interrupt() must increase the refcount
of the device_node. Otherwise the refcount is decremented every time
parse_interrupt() is called on this node, leading to a potential
use-after-free.

This is a regression introduced by commit f265f06af194 ("of: property:
Fix fw_devlink handling of interrupts/interrupts-extended"). The reason is
that of_irq_parse_one() does not increase the refcount while the previously
used of_irq_find_parent() does.

Fixes: f265f06af194 ("of: property: Fix fw_devlink handling of interrupts/interrupts-extended")
Signed-off-by: Jean Jacques Hiblot <jjhiblot@traphandler.com>
---
 drivers/of/property.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 134cfc980b70b..1f23bcb765c4e 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1380,7 +1380,10 @@ static struct device_node *parse_interrupts(struct device_node *np,
 	    strcmp(prop_name, "interrupts-extended"))
 		return NULL;
 
-	return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args.np;
+	if (of_irq_parse_one(np, index, &sup_args))
+		return NULL;
+
+	return of_node_get(sup_args.np);
 }
 
 static const struct supplier_bindings of_supplier_bindings[] = {
-- 
2.25.1

