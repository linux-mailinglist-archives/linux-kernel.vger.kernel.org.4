Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D27641481
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 07:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiLCGXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 01:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiLCGXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 01:23:05 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0918D77408;
        Fri,  2 Dec 2022 22:23:04 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NPKVt4mFRz4y0vK;
        Sat,  3 Dec 2022 14:23:02 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl1.zte.com.cn with SMTP id 2B36MuUB089118;
        Sat, 3 Dec 2022 14:22:56 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Sat, 3 Dec 2022 14:22:58 +0800 (CST)
Date:   Sat, 3 Dec 2022 14:22:58 +0800 (CST)
X-Zmail-TransId: 2b04638aeb42ffffffff9bb0203b
X-Mailer: Zmail v1.0
Message-ID: <202212031422587503771@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGJsb2NrOiB1c2Ugc3Ryc2NweSgpIHRvIGluc3RlYWQgb2Ygc3RybmNweSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B36MuUB089118
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 638AEB46.001 by FangMail milter!
X-FangMail-Envelope: 1670048582/4NPKVt4mFRz4y0vK/638AEB46.001/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638AEB46.001/4NPKVt4mFRz4y0vK
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
 block/partitions/cmdline.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index 1af610f0ba8c..c03bc105e575 100644
--- a/block/partitions/cmdline.c
+++ b/block/partitions/cmdline.c
@@ -81,8 +81,7 @@ static int parse_subpart(struct cmdline_subpart **subpart, char *partdef)

 		length = min_t(int, next - partdef,
 			       sizeof(new_subpart->name) - 1);
-		strncpy(new_subpart->name, partdef, length);
-		new_subpart->name[length] = '\0';
+		strscpy(new_subpart->name, partdef, length);

 		partdef = ++next;
 	} else
@@ -140,8 +139,7 @@ static int parse_parts(struct cmdline_parts **parts, const char *bdevdef)
 	}

 	length = min_t(int, next - bdevdef, sizeof(newparts->name) - 1);
-	strncpy(newparts->name, bdevdef, length);
-	newparts->name[length] = '\0';
+	strscpy(newparts->name, bdevdef, length);
 	newparts->nr_subparts = 0;

 	next_subpart = &newparts->subpart;
@@ -153,8 +151,7 @@ static int parse_parts(struct cmdline_parts **parts, const char *bdevdef)
 		length = (!next) ? (sizeof(buf) - 1) :
 			min_t(int, next - bdevdef, sizeof(buf) - 1);

-		strncpy(buf, bdevdef, length);
-		buf[length] = '\0';
+		strscpy(buf, bdevdef, length);

 		ret = parse_subpart(next_subpart, buf);
 		if (ret)
@@ -267,8 +264,7 @@ static int add_part(int slot, struct cmdline_subpart *subpart,

 	label_min = min_t(int, sizeof(info->volname) - 1,
 			  sizeof(subpart->name));
-	strncpy(info->volname, subpart->name, label_min);
-	info->volname[label_min] = '\0';
+	strscpy(info->volname, subpart->name, label_min);

 	snprintf(tmp, sizeof(tmp), "(%s)", info->volname);
 	strlcat(state->pp_buf, tmp, PAGE_SIZE);
-- 
2.15.2
