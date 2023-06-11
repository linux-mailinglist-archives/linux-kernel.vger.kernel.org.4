Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3AE72B021
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 05:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjFKDaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 23:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjFKDaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 23:30:25 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45541BF0;
        Sat, 10 Jun 2023 20:30:21 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f9e5c011cfso10116511cf.1;
        Sat, 10 Jun 2023 20:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686454221; x=1689046221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=200wjCR5HDe9fxLF4l8kSbZBxV+TWLYy9JzUR6Cj1Lo=;
        b=ch9PnoF4Mb81Blwkf0hMv8D0789A3mgLbBlbKqIlSA1k1Pa1y/rN9BNzlfDclVb4Z4
         WL/GkbXHJudTIoJN5Ya/3UEznQjLIb29/frvDOtse2phYFP0ZWgNW5vk0lVGYU7VltGg
         SKXGvI9e6r6BDCZ7sdc/d3+7AuTwetnoXH+9h9OUGGJ0SRQxw8HhxSd2tZShNYaMmeuN
         kOq3XXP0g4FMg8UlPSRXS8Lt9s8v2LQJyaY5jOaF2pkSQ+HTe6I9PPE9+5JK5zU4QwKu
         MdDwgdatmAXQzjI8x8gie4XxfpKj/BZWcd1DgekvV2gGBQNeEXgZ5ANC8gfD/PpzDf/R
         2dSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686454221; x=1689046221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=200wjCR5HDe9fxLF4l8kSbZBxV+TWLYy9JzUR6Cj1Lo=;
        b=EjVHWE2qlSSaVPeELUW8EqlHJw/PdW/S/OmLrhY/8EqYUdcUggWgDYZhH9dcWVWEQX
         mwN9dlIHJJWQ82RsCq28FKfanufFVY9AMvujynNXwvbg6N0UBu2TggsCz3Ac9qg2RvTD
         lvNT1sCgS90OyoTqymOXYs6NchHGh35bLPwShOkyfK7c6Lh7D23oQaI2O/64RCzH9NCw
         278d9zMBLOoAaZGnUud13lSsfvzpizEesrQvrIv53FpdlDeyYkDETcBdLtWmKZy/x0Jt
         sKbn8a57AcKz2CxtbU8GMm2nBiYZsteIolNBvHP/9CF4yy8GKMLW3C2/UxJ3K+TYVu35
         lt9g==
X-Gm-Message-State: AC+VfDwJa/dAqLqJD0Y303YViqFAQfh6tASOpSEC0yCsGaIHxuQ/RJXd
        pwcscrwv9DaZV3v6zKrneA==
X-Google-Smtp-Source: ACHHUZ4q+/MrRmOkuMCpM62AOPc3QYe4a+Ltb/Q7kXOFxX8RFz0V928IWCw7vGNtdQZWAFecgr2HeA==
X-Received: by 2002:a05:622a:1494:b0:3f3:8e79:5742 with SMTP id t20-20020a05622a149400b003f38e795742mr7082201qtx.19.1686454220829;
        Sat, 10 Jun 2023 20:30:20 -0700 (PDT)
Received: from C02FL77VMD6R.bytedance.net ([2600:1700:65a5:6400:a53e:60df:7509:de6])
        by smtp.gmail.com with ESMTPSA id bq13-20020a05622a1c0d00b003f872332a9asm2363193qtb.64.2023.06.10.20.30.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Jun 2023 20:30:20 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
X-Google-Original-From: Peilin Ye <peilin.ye@bytedance.com>
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Peilin Ye <peilin.ye@bytedance.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hillf Danton <hdanton@sina.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cong Wang <cong.wang@bytedance.com>,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH net 1/2] net/sched: Refactor qdisc_graft() for ingress and clsact Qdiscs
Date:   Sat, 10 Jun 2023 20:30:15 -0700
Message-Id: <bd1ccdee2ffe28262dea993392e3045a5aa0722b.1686355297.git.peilin.ye@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <cover.1686355297.git.peilin.ye@bytedance.com>
References: <cover.1686355297.git.peilin.ye@bytedance.com>
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

Tested-by: Pedro Tammela <pctammela@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
---
 net/sched/sch_api.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index e4b6452318c0..094ca3a5b633 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1079,12 +1079,12 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 
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
@@ -1100,18 +1100,18 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
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

