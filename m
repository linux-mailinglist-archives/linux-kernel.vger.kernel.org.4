Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA88C6331A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiKVAxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiKVAxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:53:37 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AB9DEAEE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:53:35 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NGQjn3KKtz4y0vF;
        Tue, 22 Nov 2022 08:53:33 +0800 (CST)
Received: from szxlzmapp05.zte.com.cn ([10.5.230.85])
        by mse-fl1.zte.com.cn with SMTP id 2AM0rO5p080247;
        Tue, 22 Nov 2022 08:53:24 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 22 Nov 2022 08:53:25 +0800 (CST)
Date:   Tue, 22 Nov 2022 08:53:25 +0800 (CST)
X-Zmail-TransId: 2b04637c1d85ffffffffda7cd3f2
X-Mailer: Zmail v1.0
Message-ID: <202211220853259244666@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>
Cc:     <wuchi.zero@gmail.com>, <axboe@kernel.dk>,
        <colin.i.king@gmail.com>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHJlbGF5OiB1c2Ugc3Ryc2NweSgpIGlzIG1vcmUgcm9idXN0IGFuZCBzYWZlcg==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AM0rO5p080247
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 637C1D8D.000 by FangMail milter!
X-FangMail-Envelope: 1669078413/4NGQjn3KKtz4y0vF/637C1D8D.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 637C1D8D.000/4NGQjn3KKtz4y0vF
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 kernel/relay.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index d7edc934c56d..0a3d2e702001 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -507,7 +507,7 @@ struct rchan *relay_open(const char *base_filename,
 	chan->private_data = private_data;
 	if (base_filename) {
 		chan->has_base_filename = 1;
-		strlcpy(chan->base_filename, base_filename, NAME_MAX);
+		strscpy(chan->base_filename, base_filename, NAME_MAX);
 	}
 	chan->cb = cb;
 	kref_init(&chan->kref);
@@ -578,7 +578,7 @@ int relay_late_setup_files(struct rchan *chan,
 	if (!chan || !base_filename)
 		return -EINVAL;

-	strlcpy(chan->base_filename, base_filename, NAME_MAX);
+	strscpy(chan->base_filename, base_filename, NAME_MAX);

 	mutex_lock(&relay_channels_mutex);
 	/* Is chan already set up? */
-- 
2.15.2
