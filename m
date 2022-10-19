Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DAC603A57
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJSHH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJSHHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:07:23 -0400
X-Greylist: delayed 1917 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 00:07:20 PDT
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CE1C7657C;
        Wed, 19 Oct 2022 00:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=lidC2
        05/jwIwLT3qu8Cp7EEyC/GOm0Zd2Cl9irOAQPs=; b=KCZUwjfqXz0KPGJwIpy0G
        QdPf/Xs2Evz4j6kJA9wpXpIZ0w+tjSDkEeRw5HlhhV7Pr7oO1ExfgcdszDZUF1h3
        86K9UatXi701vLoYmd6JOCp0e+5COn9yLcQh2TwKp2GS/SrSmpxgY1CnW7vHPRi7
        E2apIAf879uXXehgEH36LY=
Received: from fedora.. (unknown [123.52.27.102])
        by smtp3 (Coremail) with SMTP id DcmowAAnLqqGmk9jTN0VDQ--.39346S2;
        Wed, 19 Oct 2022 14:34:47 +0800 (CST)
From:   zhaomzhao@126.com
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, edumazet@google.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Subject: [PATCH v1] rcu: use hlist_nulls_next_rcu() in hlist_nulls_add_tail_rcu()
Date:   Wed, 19 Oct 2022 08:36:50 -0400
Message-Id: <20221019123650.139210-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowAAnLqqGmk9jTN0VDQ--.39346S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFy8try3uw4rKrWDZr1rCrg_yoWDArbEv3
        40kw1I9F4SqF4Dur1jvr1IqF98Kr13Xr93Xr1xJr1aya4DCwnxG3WUGr1qyFy7KrW3KrZ5
        JF4kKryvkFn7GjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUYuCJPUUUUU==
X-Originating-IP: [123.52.27.102]
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbiEAefd1pEDd-FJQAAsT
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

In commit 8dbd76e79a16 ("tcp/dccp: fix possible race
__inet_lookup_established()"), function hlist_nulls_add_tail_rcu() was
added back, but the local variable *last* is of type hlist_nulls_node,
so use hlist_nulls_next_rcu() instead of hlist_next_rcu().

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 include/linux/rculist_nulls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index d8afdb8784c1..ba4c00dd8005 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -139,7 +139,7 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
 	if (last) {
 		n->next = last->next;
 		n->pprev = &last->next;
-		rcu_assign_pointer(hlist_next_rcu(last), n);
+		rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
 	} else {
 		hlist_nulls_add_head_rcu(n, h);
 	}
-- 
2.37.1

