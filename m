Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E72B68E548
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjBHBMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBHBMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:12:32 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2887C2CC7A;
        Tue,  7 Feb 2023 17:12:29 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vb9GWTf_1675818747;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vb9GWTf_1675818747)
          by smtp.aliyun-inc.com;
          Wed, 08 Feb 2023 09:12:27 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     richard.henderson@linaro.org
Cc:     ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] alpha: Fix warning comparing pointer to 0
Date:   Wed,  8 Feb 2023 09:12:26 +0800
Message-Id: <20230208011226.81918-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./arch/alpha/kernel/smp.c:271:39-40: WARNING comparing pointer to 0

Avoid pointer type value compared with 0 to make code clear.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3979
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/alpha/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 0ede4b044e86..3edf1e572d10 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -268,7 +268,7 @@ recv_secondary_console_msg(void)
 			memcpy(cp2, cp1, cnt);
 			cp2[cnt] = '\0';
 			
-			while ((cp2 = strchr(cp2, '\r')) != 0) {
+			while ((cp2 = strchr(cp2, '\r'))) {
 				*cp2 = ' ';
 				if (cp2[1] == '\n')
 					cp2[1] = ' ';
-- 
2.20.1.7.g153144c

