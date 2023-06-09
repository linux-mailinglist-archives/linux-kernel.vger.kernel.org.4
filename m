Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E510772908B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238585AbjFIHBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237823AbjFIHBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:01:37 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E5B26AD;
        Fri,  9 Jun 2023 00:01:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vkh.u4r_1686294078;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vkh.u4r_1686294078)
          by smtp.aliyun-inc.com;
          Fri, 09 Jun 2023 15:01:27 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jhs@mojatatu.com
Cc:     xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] net/sched: act_pedit: Use kmemdup() to replace kmalloc + memcpy
Date:   Fri,  9 Jun 2023 15:01:17 +0800
Message-Id: <20230609070117.100507-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./net/sched/act_pedit.c:245:21-28: WARNING opportunity for kmemdup.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5478
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 net/sched/act_pedit.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index fc945c7e4123..8c4e7fddddbf 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -242,14 +242,12 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 	nparms->tcfp_flags = parm->flags;
 	nparms->tcfp_nkeys = parm->nkeys;
 
-	nparms->tcfp_keys = kmalloc(ksize, GFP_KERNEL);
+	nparms->tcfp_keys = kmemdup(parm->keys, ksize, GFP_KERNEL);
 	if (!nparms->tcfp_keys) {
 		ret = -ENOMEM;
 		goto put_chain;
 	}
 
-	memcpy(nparms->tcfp_keys, parm->keys, ksize);
-
 	for (i = 0; i < nparms->tcfp_nkeys; ++i) {
 		u32 offmask = nparms->tcfp_keys[i].offmask;
 		u32 cur = nparms->tcfp_keys[i].off;
-- 
2.20.1.7.g153144c

