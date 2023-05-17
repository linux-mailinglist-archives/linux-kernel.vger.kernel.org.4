Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B51706433
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjEQJdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjEQJdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:33:36 -0400
X-Greylist: delayed 494 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 02:33:34 PDT
Received: from mail-m3169.qiye.163.com (mail-m3169.qiye.163.com [103.74.31.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55092738
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:33:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [218.94.118.90])
        by mail-m3169.qiye.163.com (Hmail) with ESMTPA id 45F4B7A03D9;
        Wed, 17 May 2023 17:25:17 +0800 (CST)
From:   Zhen Ni <zhen.ni@easystack.cn>
To:     minyard@acm.org
Cc:     linux-kernel@vger.kernel.org, Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH] ipmi_watchdog: Fix read syscall not responding to signals during sleep
Date:   Wed, 17 May 2023 17:25:08 +0800
Message-Id: <20230517092508.369197-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaS0IeVhkfGUseTk8aSx9CTFUZERMWGhIXJBQOD1
        lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Tid: 0a88290731d600a9kurm45f4b7a03d9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pww6FAw4DzJDPxFMQzQePDUj
        OBEaFBdVSlVKTUNPSEpOTkpDS09CVTMWGhIXVQETHhVVFRI7HhoIAggPGhgQVRgVRVlXWRILWUFZ
        SUpDVUJPVUpKQ1VCS1lXWQgBWUFKTkxCNwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read syscall cannot response to sigals when data_to_read remains at 0
and the while loop cannot break. Fix it.

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 drivers/char/ipmi/ipmi_watchdog.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
index 0d4a8dcacfd4..e7eb3e140444 100644
--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -807,13 +807,12 @@ static ssize_t ipmi_read(struct file *file,
 			spin_unlock_irq(&ipmi_read_lock);
 			schedule();
 			spin_lock_irq(&ipmi_read_lock);
+			if (signal_pending(current)) {
+				rv = -ERESTARTSYS;
+				break;
+			}
 		}
 		remove_wait_queue(&read_q, &wait);
-
-		if (signal_pending(current)) {
-			rv = -ERESTARTSYS;
-			goto out;
-		}
 	}
 	data_to_read = 0;
 
-- 
2.20.1

