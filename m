Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79105654B2D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbiLWCj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbiLWCjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:39:25 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2AD1928A;
        Thu, 22 Dec 2022 18:39:22 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NdWbW5qJkz4y3ZH;
        Fri, 23 Dec 2022 10:39:19 +0800 (CST)
Received: from szxlzmapp07.zte.com.cn ([10.5.230.251])
        by mse-fl2.zte.com.cn with SMTP id 2BN2dBSU049421;
        Fri, 23 Dec 2022 10:39:11 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 23 Dec 2022 10:39:12 +0800 (CST)
Date:   Fri, 23 Dec 2022 10:39:12 +0800 (CST)
X-Zmail-TransId: 2b0463a514d02fd8a3f9
X-Mailer: Zmail v1.0
Message-ID: <202212231039128402297@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <robh+dt@kernel.org>
Cc:     <frowand.list@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG9mOiBiYXNlOiB1c2Ugc3Ryc2NweSgpIHRvIGluc3RlYWQgb2Ygc3RybmNweSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2BN2dBSU049421
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 63A514D7.001 by FangMail milter!
X-FangMail-Envelope: 1671763159/4NdWbW5qJkz4y3ZH/63A514D7.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63A514D7.001/4NdWbW5qJkz4y3ZH
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
 drivers/of/base.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index d5a5c35eba72..ac6fde53342f 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1884,8 +1884,7 @@ static void of_alias_add(struct alias_prop *ap, struct device_node *np,
 {
 	ap->np = np;
 	ap->id = id;
-	strncpy(ap->stem, stem, stem_len);
-	ap->stem[stem_len] = 0;
+	strscpy(ap->stem, stem, stem_len + 1);
 	list_add_tail(&ap->link, &aliases_lookup);
 	pr_debug("adding DT alias:%s: stem=%s id=%i node=%pOF\n",
 		 ap->alias, ap->stem, ap->id, np);
-- 
2.15.2
