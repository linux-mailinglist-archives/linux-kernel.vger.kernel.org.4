Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C53066248C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbjAILrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbjAILrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:47:02 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56034D136
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:47:01 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NrBxc0fcLz8QrkZ;
        Mon,  9 Jan 2023 19:47:00 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl1.zte.com.cn with SMTP id 309BkqU1093359;
        Mon, 9 Jan 2023 19:46:52 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 9 Jan 2023 19:46:55 +0800 (CST)
Date:   Mon, 9 Jan 2023 19:46:55 +0800 (CST)
X-Zmail-TransId: 2b0363bbfeafffffffffb62deb1a
X-Mailer: Zmail v1.0
Message-ID: <202301091946553770006@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <sj@kernel.org>
Cc:     <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG1tL2RhbW9uL3N5c2ZzLXNjaGVtZXM6IHVzZSBzdHJzY3B5KCkgdG8gaW5zdGVhZCBvZiBzdHJuY3B5KCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 309BkqU1093359
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63BBFEB4.000 by FangMail milter!
X-FangMail-Envelope: 1673264820/4NrBxc0fcLz8QrkZ/63BBFEB4.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63BBFEB4.000/4NrBxc0fcLz8QrkZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL-terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 mm/damon/sysfs-schemes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index f0dabe3e2dc0..86edca66aab1 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -353,8 +353,7 @@ static ssize_t memcg_path_store(struct kobject *kobj,
 	if (!path)
 		return -ENOMEM;

-	strncpy(path, buf, count);
-	path[count] = '\0';
+	strscpy(path, buf, count + 1);
 	filter->memcg_path = path;
 	return count;
 }
-- 
2.15.2
