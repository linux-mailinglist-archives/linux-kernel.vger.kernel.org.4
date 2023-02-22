Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F5669D9DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjBUDwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjBUDwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:52:06 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C56B9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:51:50 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id CD0ED1A009BB;
        Tue, 21 Feb 2023 11:52:28 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pCQ2vw8EJboU; Tue, 21 Feb 2023 11:52:28 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 09E0A1A00A50;
        Tue, 21 Feb 2023 11:52:28 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] tty: tty_ldisc: Remove the ret variable
Date:   Thu, 23 Feb 2023 04:23:03 +0800
Message-Id: <20230222202303.3195-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The int variable ret does not receive the return value in this function.
It should be removed and returned 0 directly.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 drivers/tty/tty_ldisc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index e758f44729e7..3f68e213df1f 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -58,7 +58,6 @@ static struct tty_ldisc_ops *tty_ldiscs[NR_LDISCS];
 int tty_register_ldisc(struct tty_ldisc_ops *new_ldisc)
 {
 	unsigned long flags;
-	int ret = 0;
 
 	if (new_ldisc->num < N_TTY || new_ldisc->num >= NR_LDISCS)
 		return -EINVAL;
@@ -67,7 +66,7 @@ int tty_register_ldisc(struct tty_ldisc_ops *new_ldisc)
 	tty_ldiscs[new_ldisc->num] = new_ldisc;
 	raw_spin_unlock_irqrestore(&tty_ldiscs_lock, flags);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(tty_register_ldisc);
 
-- 
2.18.2

