Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5DC61F119
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiKGKrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiKGKrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:47:41 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB6117E30;
        Mon,  7 Nov 2022 02:47:40 -0800 (PST)
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2A7AlQG1056220;
        Mon, 7 Nov 2022 19:47:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Mon, 07 Nov 2022 19:47:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2A7AlHps056175
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 7 Nov 2022 19:47:25 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <531fb432-7396-ad37-ecba-3e42e7f56d5c@I-love.SAKURA.ne.jp>
Date:   Mon, 7 Nov 2022 19:47:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: [PATCH] Input: iforce - invert valid length check when fetching
 device IDs
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Tulli <greg.iforce@gmail.com>
References: <0000000000003adfa805ecde42f8@google.com>
Content-Language: en-US
Cc:     syzbot <syzbot+4dd880c1184280378821@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, glider@google.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000003adfa805ecde42f8@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting uninitialized value at iforce_init_device() [1], for
commit 6ac0aec6b0a6 ("Input: iforce - allow callers supply data buffer
when fetching device IDs") is checking that valid length is shorter than
bytes to read. Since iforce_get_id_packet() stores valid length when
returning 0, the caller needs to check that valid length is longer than or
equals to bytes to read.

Link: https://syzkaller.appspot.com/bug?extid=4dd880c1184280378821 [1]
Reported-by: syzbot <syzbot+4dd880c1184280378821@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 6ac0aec6b0a6 ("Input: iforce - allow callers supply data buffer when fetching device IDs")
---
 drivers/input/joystick/iforce/iforce-main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index b86de1312512..84b87526b7ba 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -273,22 +273,22 @@ int iforce_init_device(struct device *parent, u16 bustype,
  * Get device info.
  */
 
-	if (!iforce_get_id_packet(iforce, 'M', buf, &len) || len < 3)
+	if (!iforce_get_id_packet(iforce, 'M', buf, &len) && len >= 3)
 		input_dev->id.vendor = get_unaligned_le16(buf + 1);
 	else
 		dev_warn(&iforce->dev->dev, "Device does not respond to id packet M\n");
 
-	if (!iforce_get_id_packet(iforce, 'P', buf, &len) || len < 3)
+	if (!iforce_get_id_packet(iforce, 'P', buf, &len) && len >= 3)
 		input_dev->id.product = get_unaligned_le16(buf + 1);
 	else
 		dev_warn(&iforce->dev->dev, "Device does not respond to id packet P\n");
 
-	if (!iforce_get_id_packet(iforce, 'B', buf, &len) || len < 3)
+	if (!iforce_get_id_packet(iforce, 'B', buf, &len) && len >= 3)
 		iforce->device_memory.end = get_unaligned_le16(buf + 1);
 	else
 		dev_warn(&iforce->dev->dev, "Device does not respond to id packet B\n");
 
-	if (!iforce_get_id_packet(iforce, 'N', buf, &len) || len < 2)
+	if (!iforce_get_id_packet(iforce, 'N', buf, &len) && len >= 2)
 		ff_effects = buf[1];
 	else
 		dev_warn(&iforce->dev->dev, "Device does not respond to id packet N\n");
-- 
2.18.4

