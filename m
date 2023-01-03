Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9940B65B939
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 03:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbjACCCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 21:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbjACCCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 21:02:20 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253291039;
        Mon,  2 Jan 2023 18:02:19 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NmGFj0ylcz501Sr;
        Tue,  3 Jan 2023 10:02:17 +0800 (CST)
Received: from szxlzmapp05.zte.com.cn ([10.5.230.85])
        by mse-fl1.zte.com.cn with SMTP id 303226xk053280;
        Tue, 3 Jan 2023 10:02:06 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 3 Jan 2023 10:02:07 +0800 (CST)
Date:   Tue, 3 Jan 2023 10:02:07 +0800 (CST)
X-Zmail-TransId: 2b0363b38c9f6a036ac0
X-Mailer: Zmail v1.0
Message-ID: <202301031002076571212@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <freude@linux.ibm.com>, <hca@linux.ibm.com>
Cc:     <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjJdIHMzOTAvemNyeXB0OiB1c2Ugc3Ryc2NweSgpIHRvIGluc3RlYWQgb2Ygc3RybmNweSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 303226xk053280
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 63B38CA9.001 by FangMail milter!
X-FangMail-Envelope: 1672711337/4NmGFj0ylcz501Sr/63B38CA9.001/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63B38CA9.001/4NmGFj0ylcz501Sr
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL-terminated strings.

Signed-off-by: Yang Yang <yang.yang29@zte.com>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
chang for v2
 - match the FROM with the Email
---
 drivers/s390/crypto/zcrypt_api.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 4bf36e53fe3e..6fe05bb82c77 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -347,8 +347,7 @@ static ssize_t zcdn_create_store(struct class *class,
 	int rc;
 	char name[ZCDN_MAX_NAME];

-	strncpy(name, skip_spaces(buf), sizeof(name));
-	name[sizeof(name) - 1] = '\0';
+	strscpy(name, skip_spaces(buf), sizeof(name));

 	rc = zcdn_create(strim(name));

@@ -365,8 +364,7 @@ static ssize_t zcdn_destroy_store(struct class *class,
 	int rc;
 	char name[ZCDN_MAX_NAME];

-	strncpy(name, skip_spaces(buf), sizeof(name));
-	name[sizeof(name) - 1] = '\0';
+	strscpy(name, skip_spaces(buf), sizeof(name));

 	rc = zcdn_destroy(strim(name));

-- 
2.15.2
