Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21565BB752
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 10:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiIQIot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 04:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIQIol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 04:44:41 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B3FFAE47
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 01:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=YHdx/
        6gmPjB0lW9gk123clXM4PERhfOCRZN9axf3Nig=; b=EuHz1ZI0blFDWognHByBy
        pNzFPhAtwzAhvlzO9veVVJbXBG2StWIbNTeDwlrMtdxKB/H1c9zZE9lUwcEhRWDG
        qvffwoueLPdWwi7nPMR1LnNrMY30TzytKQapuCcE2wVipfbU0XzoOzQd7ukQobPe
        E/JYjCNHAzx5yFZdVFT5dM=
Received: from DESKTOP-CE2KKHI.localdomain (unknown [124.160.210.227])
        by smtp2 (Coremail) with SMTP id GtxpCgDnoQvviCVjOqJTeQ--.56S2;
        Sat, 17 Sep 2022 16:44:32 +0800 (CST)
From:   williamsukatube@163.com
To:     linux-kernel@vger.kernel.org
Cc:     haren@us.ibm.com, William Dean <williamsukatube@163.com>
Subject: [PATCH -next] crypto: simplify code in process_next
Date:   Sat, 17 Sep 2022 16:44:30 +0800
Message-Id: <20220917084430.4131-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgDnoQvviCVjOqJTeQ--.56S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFWDuw4DZrWkWrWxWFWfKrg_yoWfJFXEk3
        WIgaykGr4rZF47A34UGF4ktaya9rs7uF13uFsYqw43AFyxAa1ruryDWwsxGrZ3Zryvg347
        Wws8Jrsakr9xWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRBHDd3UUUUU==
X-Originating-IP: [124.160.210.227]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/xtbB6Ah-g2BHKJNCKAAAsq
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@163.com>

It could directly return 'add_template' to simplify code.

Signed-off-by: William Dean <williamsukatube@163.com>
---
 lib/842/842_compress.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/842/842_compress.c b/lib/842/842_compress.c
index c02baa4168e1..168950bd00af 100644
--- a/lib/842/842_compress.c
+++ b/lib/842/842_compress.c
@@ -441,7 +441,7 @@ static void update_hashtables(struct sw842_param *p)
  */
 static int process_next(struct sw842_param *p)
 {
-	int ret, i;
+	int i;

 	p->index8[0] = INDEX_NOT_CHECKED;
 	p->index4[0] = INDEX_NOT_CHECKED;
@@ -457,11 +457,7 @@ static int process_next(struct sw842_param *p)
 			break;
 	}

-	ret = add_template(p, i);
-	if (ret)
-		return ret;
-
-	return 0;
+	return add_template(p, i);
 }

 /**
--
2.25.1

