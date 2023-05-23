Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2459570D4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbjEWHTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbjEWHSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:18:42 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C111737;
        Tue, 23 May 2023 00:17:38 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-75b0b2d0341so187660185a.3;
        Tue, 23 May 2023 00:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684826255; x=1687418255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DP0WRhEZFA9apP4UUxu6qOcwGT3oty462OE7ZKWIbQ=;
        b=OUxWQ8i2mtKHdr5lHqfVnOO50e57a592r7zgEo7fJcgBpcI+H0c5G8vSDzdaJNQcAa
         d3+Dhm2uSgftKexBWEhp3xf/jvbM5B65gdQljfsNaG8WwJ110deoiEiWDN0aHmcjnLW6
         l2aaOXEQk8zL3PoxbL2n7TB2hyBshlzWKpEtU8PSAW80G48Sd3z6iNt3b3xFJK7QDD3F
         jevDH4iNDUu3guPcwKcaKrs35vK+2lKRzVGO0E8/gMCI/dDUTTNIYn4QjlBBKHnHNA5c
         sFND2q9uX3AyhzDPMzyUdZAzQrzrCg9sF3eueXGyhQFfcORN0QLP8B2yefaSa/zHZkTf
         uWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684826255; x=1687418255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DP0WRhEZFA9apP4UUxu6qOcwGT3oty462OE7ZKWIbQ=;
        b=TEj6iFCEoGhRJGRaW4PiIwirPtkQ/8yXBHLnbMl0A8QqNX8KXMQ+c78JlmAa9CAqxz
         l52pOrOedNX9OtXpHXsOmK7H+HNSuxXv5aOPdJ43mEVibUK2YYXAPZTS2+QmlWVtNhVD
         NPyW2qsqLpE+EOJNq5NWY29PohIEX82UbLjipHXFFMKTmzgRmNciNvTvFSd+rLDe+jTK
         hHFHkDl9eniNEAMM36jpht+IH1+UvwLQLztYzNj5kevbLBKSsy1HwkxbGFykSvc9ccUi
         BkdsmFUB5SvCpzd+P7FSyvKVaiIS0lHp9JC9NvzFE7OyBmoxAmfzdPYjwI9H8Z8mBc6S
         tjsg==
X-Gm-Message-State: AC+VfDwFuYFmtPccTRDs89bnKyHFNggwyycUmwHF7lstYG4s/pS7C7ru
        vktzib7d0H0ms0zfzU5aGw==
X-Google-Smtp-Source: ACHHUZ660zMrWscX3GY+5jLdNq+n3WWC4xRWqCTCIw0MiXXyWGuDblPiKIuPOp+g0rnncgdONTvOhA==
X-Received: by 2002:a05:620a:95d:b0:75b:23a1:486 with SMTP id w29-20020a05620a095d00b0075b23a10486mr2781227qkw.76.1684826254970;
        Tue, 23 May 2023 00:17:34 -0700 (PDT)
Received: from C02FL77VMD6R.bytedance.net ([2600:1700:d860:12b0:18c1:dc19:5e29:e9a0])
        by smtp.gmail.com with ESMTPSA id y11-20020a37e30b000000b00759495bb52fsm2325251qki.39.2023.05.23.00.17.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2023 00:17:34 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
X-Google-Original-From: Peilin Ye <peilin.ye@bytedance.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>
Cc:     Peilin Ye <peilin.ye@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH v4 net 5/6] net/sched: Refactor qdisc_graft() for ingress and clsact Qdiscs
Date:   Tue, 23 May 2023 00:17:24 -0700
Message-Id: <08267d7f0563327ad468dbaf3626ef3352e4924a.1684825171.git.peilin.ye@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <cover.1684825171.git.peilin.ye@bytedance.com>
References: <cover.1684825171.git.peilin.ye@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peilin Ye <peilin.ye@bytedance.com>

Grafting ingress and clsact Qdiscs does not need a for-loop in
qdisc_graft().  Refactor it.  No functional changes intended.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Tested-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
---
change since v2:
  - add in-body From: tag

 net/sched/sch_api.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 49b9c1bbfdd9..f72a581666a2 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1073,12 +1073,12 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 
 	if (parent == NULL) {
 		unsigned int i, num_q, ingress;
+		struct netdev_queue *dev_queue;
 
 		ingress = 0;
 		num_q = dev->num_tx_queues;
 		if ((q && q->flags & TCQ_F_INGRESS) ||
 		    (new && new->flags & TCQ_F_INGRESS)) {
-			num_q = 1;
 			ingress = 1;
 			if (!dev_ingress_queue(dev)) {
 				NL_SET_ERR_MSG(extack, "Device does not have an ingress queue");
@@ -1094,18 +1094,18 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 		if (new && new->ops->attach && !ingress)
 			goto skip;
 
-		for (i = 0; i < num_q; i++) {
-			struct netdev_queue *dev_queue = dev_ingress_queue(dev);
-
-			if (!ingress)
+		if (!ingress) {
+			for (i = 0; i < num_q; i++) {
 				dev_queue = netdev_get_tx_queue(dev, i);
+				old = dev_graft_qdisc(dev_queue, new);
 
-			old = dev_graft_qdisc(dev_queue, new);
-			if (new && i > 0)
-				qdisc_refcount_inc(new);
-
-			if (!ingress)
+				if (new && i > 0)
+					qdisc_refcount_inc(new);
 				qdisc_put(old);
+			}
+		} else {
+			dev_queue = dev_ingress_queue(dev);
+			old = dev_graft_qdisc(dev_queue, new);
 		}
 
 skip:
-- 
2.20.1

