Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF8969CB3C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjBTMmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjBTMmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:42:12 -0500
X-Greylist: delayed 381 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Feb 2023 04:41:56 PST
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A481C583;
        Mon, 20 Feb 2023 04:41:56 -0800 (PST)
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 95C27102397;
        Mon, 20 Feb 2023 15:35:31 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [172.16.4.50])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 8C65B1023A0;
        Mon, 20 Feb 2023 15:35:11 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.53.223])
        by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 31KCZ9RW010128;
        Mon, 20 Feb 2023 15:35:09 +0300
From:   Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [lvc-project] [PATCH] Input: cypress_ps2 - fix cypress_ps2_sendbyte() result check
Date:   Mon, 20 Feb 2023 15:34:58 +0300
Message-Id: <20230220123458.712530-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.0.152.ga5737674b6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
         bases: 20111107 #2745587, check: 20230220 notchecked
X-AV-Checked: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cypress_ps2_sendbyte() returns 0 or an error code greater than 0.
The cypress_ps2_read_cmd_status() function assumes that
cypress_ps2_read_cmd_status() will return a negative value on error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0799a924bc93 ("Input: add support for Cypress PS/2 Trackpads")
Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
 drivers/input/mouse/cypress_ps2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/cypress_ps2.c b/drivers/input/mouse/cypress_ps2.c
index d272f1ec27ba..b170959e2ad3 100644
--- a/drivers/input/mouse/cypress_ps2.c
+++ b/drivers/input/mouse/cypress_ps2.c
@@ -114,7 +114,7 @@ static int cypress_ps2_read_cmd_status(struct psmouse *psmouse,
 	memset(param, 0, pktsize);
 
 	rc = cypress_ps2_sendbyte(psmouse, 0xe9);
-	if (rc < 0)
+	if (rc > 0)
 		goto out;
 
 	wait_event_timeout(ps2dev->wait,
-- 
2.30.2

