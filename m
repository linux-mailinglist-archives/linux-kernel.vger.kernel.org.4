Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E2565EA9E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjAEMYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjAEMYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:24:45 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5E84E404;
        Thu,  5 Jan 2023 04:24:44 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Nnlyy4l7hz8QrkZ;
        Thu,  5 Jan 2023 20:24:42 +0800 (CST)
Received: from szxlzmapp06.zte.com.cn ([10.5.230.252])
        by mse-fl2.zte.com.cn with SMTP id 305COVcF068055;
        Thu, 5 Jan 2023 20:24:31 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Thu, 5 Jan 2023 20:24:34 +0800 (CST)
Date:   Thu, 5 Jan 2023 20:24:34 +0800 (CST)
X-Zmail-TransId: 2b0363b6c1823267991f
X-Mailer: Zmail v1.0
Message-ID: <202301052024349365834@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <freude@linux.ibm.com>, <hca@linux.ibm.com>
Cc:     <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjNdIHMzOTAvemNyeXB0OiB1c2Ugc3Ryc2NweSgpIHRvIGluc3RlYWQgb2Ygc3RybmNweSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 305COVcF068055
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63B6C18A.001 by FangMail milter!
X-FangMail-Envelope: 1672921482/4Nnlyy4l7hz8QrkZ/63B6C18A.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63B6C18A.001/4Nnlyy4l7hz8QrkZ
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
chang for v3
 - fix the sign-off Email address
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
