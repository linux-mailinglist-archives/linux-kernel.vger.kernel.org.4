Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF6064277C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiLEL24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiLEL2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:28:54 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6241F10569
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 03:28:53 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NQhBr0D8xz4xVnH;
        Mon,  5 Dec 2022 19:28:52 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl1.zte.com.cn with SMTP id 2B5BShdT045660;
        Mon, 5 Dec 2022 19:28:43 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 5 Dec 2022 19:28:46 +0800 (CST)
Date:   Mon, 5 Dec 2022 19:28:46 +0800 (CST)
X-Zmail-TransId: 2b04638dd5ee1219271f
X-Mailer: Zmail v1.0
Message-ID: <202212051928467539184@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <w.d.hubbs@gmail.com>
Cc:     <chris@the-brannons.com>, <kirk@reisers.ca>,
        <samuel.thibault@ens-lyon.org>, <mushi.shar@gmail.com>,
        <speakup@linux-speakup.org>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjJdIGFjY2Vzc2liaWxpdHk6IHNwZWFrdXA6IHVzZSBzdHJzY3B5KCkgdG8gaW5zdGVhZCBvZiBzdHJuY3B5KCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B5BShdT045660
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 638DD5F4.000 by FangMail milter!
X-FangMail-Envelope: 1670239732/4NQhBr0D8xz4xVnH/638DD5F4.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638DD5F4.000/4NQhBr0D8xz4xVnH
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
---
change for v2
 - fix the mistake of eating one character when len > 250,
thanks to Samuel Thibault.
---

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 drivers/accessibility/speakup/kobjects.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/accessibility/speakup/kobjects.c b/drivers/accessibility/speakup/kobjects.c
index a7522d409802..c1ef48280f3c 100644
--- a/drivers/accessibility/speakup/kobjects.c
+++ b/drivers/accessibility/speakup/kobjects.c
@@ -426,8 +426,7 @@ static ssize_t synth_direct_store(struct kobject *kobj,
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
 	while (len > 0) {
 		bytes = min_t(size_t, len, 250);
-		strncpy(tmp, ptr, bytes);
-		tmp[bytes] = '\0';
+		strscpy(tmp, ptr, bytes + 1);
 		string_unescape_any_inplace(tmp);
 		synth_printf("%s", tmp);
 		ptr += bytes;
-- 
2.15.2
