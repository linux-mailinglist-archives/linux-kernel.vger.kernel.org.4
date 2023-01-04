Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C0165CDB3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 08:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjADHiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 02:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjADHiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 02:38:03 -0500
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF661928C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 23:38:02 -0800 (PST)
X-UUID: 68b2f31b067246c78c587ccdb400e0c9-20230104
X-CPASD-INFO: 13bb055be8fd47479fb64d232f57b64a@eoOcgl1nY5KRWKiwg3p_cVmXkmZkkFK
        CdKBVZ5BmYIGVhH5xTV5nX1V9gnNXZF5dXFV3dnBQYmBhXVJ3i3-XblBgXoZgUZB3gHWcgmBjZQ==
X-CLOUD-ID: 13bb055be8fd47479fb64d232f57b64a
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:184.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:134.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-
        5,AUF:5,DUF:11594,ACD:192,DCD:192,SL:0,EISP:0,AG:0,CFC:0.623,CFSR:0.043,UAT:0
        ,RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:
        0,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 68b2f31b067246c78c587ccdb400e0c9-20230104
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 68b2f31b067246c78c587ccdb400e0c9-20230104
X-User: xurui@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <xurui@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 2024304127; Wed, 04 Jan 2023 15:38:00 +0800
From:   xurui <xurui@kylinos.cn>
To:     f.fainelli@gmail.com
Cc:     trivial@kernel.org, linux-kernel@vger.kernel.org,
        xurui <xurui@kylinos.cn>
Subject: [PATCH] coredump: Fix a compilation issue with CONFIG_VLYNQ_DEBUG=y
Date:   Wed,  4 Jan 2023 15:38:09 +0800
Message-Id: <20230104073809.1095521-1-xurui@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A compilation issue occurred when CONFIG_VLYNQ_DEBUG is set:
drivers/vlynq/vlynq.c:82:13: error: ‘vlynq_dump_mem’ defined but not used [-Werror=unused-function]
drivers/vlynq/vlynq.c:68:13: error: ‘vlynq_dump_regs’ defined but not used [-Werror=unused-function]

Signed-off-by: xurui <xurui@kylinos.cn>
---
 drivers/vlynq/vlynq.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/vlynq/vlynq.c b/drivers/vlynq/vlynq.c
index 4af6615808cc..6bff9651f699 100644
--- a/drivers/vlynq/vlynq.c
+++ b/drivers/vlynq/vlynq.c
@@ -64,34 +64,6 @@ struct vlynq_regs {
 	u32 int_device[8];
 };
 
-#ifdef CONFIG_VLYNQ_DEBUG
-static void vlynq_dump_regs(struct vlynq_device *dev)
-{
-	int i;
-
-	printk(KERN_DEBUG "VLYNQ local=%p remote=%p\n",
-			dev->local, dev->remote);
-	for (i = 0; i < 32; i++) {
-		printk(KERN_DEBUG "VLYNQ: local %d: %08x\n",
-			i + 1, ((u32 *)dev->local)[i]);
-		printk(KERN_DEBUG "VLYNQ: remote %d: %08x\n",
-			i + 1, ((u32 *)dev->remote)[i]);
-	}
-}
-
-static void vlynq_dump_mem(u32 *base, int count)
-{
-	int i;
-
-	for (i = 0; i < (count + 3) / 4; i++) {
-		if (i % 4 == 0)
-			printk(KERN_DEBUG "\nMEM[0x%04x]:", i * 4);
-		printk(KERN_DEBUG " 0x%08x", *(base + i));
-	}
-	printk(KERN_DEBUG "\n");
-}
-#endif
-
 /* Check the VLYNQ link status with a given device */
 static int vlynq_linked(struct vlynq_device *dev)
 {
-- 
2.25.1

